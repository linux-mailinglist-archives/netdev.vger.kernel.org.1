Return-Path: <netdev+bounces-20942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AED761FA7
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 18:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 618E61C2042F
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 16:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBF924191;
	Tue, 25 Jul 2023 16:56:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237FD1F927
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 16:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D22C433C8;
	Tue, 25 Jul 2023 16:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690304183;
	bh=TJd9AOo4MJx0nSlvmoA1i6hcjsJ07qNeSFb9t986iX0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uCv6RSFeQ8qyjbOwUfurnJXw/fvc2Gya/tWUGjiv7PgTbZDXUqFdGHHQFAmX57yBM
	 BOCVSUZ85zdkqBifPueW4+5qjnMBzAgFJCui5Od20Nvcc64cn1l9vE5u997e3TFfEf
	 JcYfO7zljGUgSrIY+qAtogy34lzBETSZI9AOtpGiRcQXaH9wVUtxY47ma3MkS1ZvID
	 tZtZyJDcWc67OltGu57GisVR71HSBcETj7OVDC2AHc7K1BMK7v9OfHHlOdP4RzM+DL
	 o6edEb4s9iWDrxTl/3+/D7nUQ4hIX7OLDKd+82wo6R52BlxCHGmgtRGUyCkVimEyoB
	 3a7FUPGw3SvMw==
Date: Tue, 25 Jul 2023 09:56:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 mkubecek@suse.cz, lorenzo@kernel.org
Subject: Re: [PATCH net-next 1/2] net: store netdevs in an xarray
Message-ID: <20230725095622.33fedff7@kernel.org>
In-Reply-To: <e5655b23861d3c4b5684665874c19f37952b2e43.camel@redhat.com>
References: <20230722014237.4078962-1-kuba@kernel.org>
	<20230722014237.4078962-2-kuba@kernel.org>
	<20788d4df9bbcdce9453be3fd047fdf8e0465714.camel@redhat.com>
	<20230724084126.38d55715@kernel.org>
	<2a531e60a0ea8187f1781d4075f127b01970321a.camel@redhat.com>
	<20230724102741.469c0e42@kernel.org>
	<20230724120718.4f01113a@kernel.org>
	<e5655b23861d3c4b5684665874c19f37952b2e43.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jul 2023 13:11:50 +0200 Paolo Abeni wrote:
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
> You convinced me the 'missed device' scenario is not very relevant. 
> 
> The cursor with the dummy placeholder looks error-prone and/or too
> invasive to me.
> 
> I'm fine with this approach.

I'll post a v2 with the fix Leon pointed out.

But do feel free to change your mind.

It seems like a problem where there's no perfect solution but
there are multiple non-perfect ones, each with its advantages
and disadvantages.

