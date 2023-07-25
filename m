Return-Path: <netdev+bounces-21012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1C9762297
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 21:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15AB01C20F69
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 19:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6B826B04;
	Tue, 25 Jul 2023 19:46:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA191D2FD
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 19:46:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB0C7C433C8;
	Tue, 25 Jul 2023 19:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690314360;
	bh=1Uh4TPOBk512aHbEuk/jYdhaFBhXhA8L86v0n5StCTw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EshMDONLk/elSPudh0bxJeunrwrXjZv3Q4645Xfb35/+y5SYc/u8a6stQWthW4gJR
	 ig1nSV8kq0kf00HeC59957FxKencxY3JAm+GI7lrr1cTH/nfWQMlpwPC78yCBmsnxS
	 6MDOEDZ7wQSysw2zEQ/NfnoXR5/iFmXOfjFMsa6try9IeF7kox//BM4QAUpk2R2+ub
	 o4TGyXSkfiRnNxiOjsE3D8uqtJnO/Mr9pEh2BG8iTMsKVQy/SVx9xzgoPuAFl5aOnK
	 FujdHkQgG42bdkmiQGm4zbTRZ0ZTkhCPo/wbn482oq1inhzryIhY4wPkAUn43K3RC5
	 N6JQk+nhkPlrQ==
Date: Tue, 25 Jul 2023 12:45:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, mkubecek@suse.cz,
 lorenzo@kernel.org
Subject: Re: [PATCH net-next 1/2] net: store netdevs in an xarray
Message-ID: <20230725124559.1dc930cd@kernel.org>
In-Reply-To: <ZMAMY0MTj7PbJazi@hog>
References: <20230722014237.4078962-1-kuba@kernel.org>
	<20230722014237.4078962-2-kuba@kernel.org>
	<20788d4df9bbcdce9453be3fd047fdf8e0465714.camel@redhat.com>
	<20230724084126.38d55715@kernel.org>
	<2a531e60a0ea8187f1781d4075f127b01970321a.camel@redhat.com>
	<20230724102741.469c0e42@kernel.org>
	<20230724120718.4f01113a@kernel.org>
	<ZMAMY0MTj7PbJazi@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jul 2023 19:54:43 +0200 Sabrina Dubroca wrote:
> > > And if that's not enough we can make the iteration index ulong 
> > > (i.e. something separate from ifindex as ifindex is hardwired to 31b
> > > by uAPI).  
> > 
> > We can get the create, delete ordering with this or the list, but the
> > inverse theoretical case of delete, create ordering can't be covered.
> > A case where user wants to make sure at most one device is visible.
> > 
> > I'm not sure how much we should care about this. The basic hash table
> > had the very real problem of hiding devices which were there *before
> > and after* the dump.
> > 
> > Inconsistent info on devices which were created / deleted *during* the
> > dump seems to me like something that's best handled with notifications.
> > 
> > I'm not sure whether we should set the inconsistency mark on the dump
> > when del/add operation happened in the meantime either, as 
> > the probability that the user space will care is minuscule.  
> 
> The inconsistent dump mark may be more relevant for changes in device
> properties than link creation/removal. If the MTU on 2 devices changes
> while the dump is running (one low ifindex, one high ifindex), we'll
> see the old MTU for the first device and the new MTU for the 2nd. Or
> by adding/removing bridge ports while the dump runs, I can make it
> look like bridge0 has mulitple ports with the same port_no.
> 
> I don't know how likely those cases are, but if they happen I think
> they'd be more confusing than a missing/extra device.

I believe that for netdevs dev_base_seq_inc() is used to indicate 
a change. It's only called when listing / unlisting devices so
the changes to device config are already not covered :(

