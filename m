Return-Path: <netdev+bounces-41523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B447CB31D
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 21:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 139D0B20E08
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 19:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5F930F92;
	Mon, 16 Oct 2023 19:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZu5m9Ua"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F69E34182
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 19:03:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A84C433C7;
	Mon, 16 Oct 2023 19:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697483033;
	bh=K9tgzVSy7OHjw2Yj5wke3eQW5Pi+rz9MLIe8L001tEo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lZu5m9UaPUTbQTW3/swj6WXA/lBOmjN3m8qY557DjKrEDOPqMHjJZmmW4Qz5q6GBT
	 givU+baJwgHAr0roRCV4ytNB05JPovSNVE+G8mLPNEwvTWYdEpxMIfBeArMQYmxR2t
	 w0ZyjvtYLW+et8nA1Too28y3GfSrnevMsW3I72xpzVwd3Dxp/3l5/pipvV0xqItxSU
	 I9AMhcthZy3S6ZvZqrkEBxGHBg9tVCn+bduBwe0k60KI4vwlpQ4d5s7WOh7fW2Z/WI
	 9x0YxIgFQpaqH2iGfGIS5ioDv2ckRj+TWHkuxuzR+RXILm233Tu1X4bRa5s1nVAA3O
	 ltAalR2YCoqTg==
Date: Mon, 16 Oct 2023 12:03:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Daniel =?UTF-8?B?R3LDtmJlcg==?= <dxld@darkboxed.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, Richard Weinberger
 <richard@nod.at>, Serge Hallyn <serge.hallyn@canonical.com>, "Eric W.
 Biederman" <ebiederm@xmission.com>
Subject: Re: [BUG] rtnl_newlink: Rogue MOVE event delivered on netns change
Message-ID: <20231016120352.174fe1ee@kernel.org>
In-Reply-To: <2023101632-circle-delegate-39dd@gregkh>
References: <20231010121003.x3yi6fihecewjy4e@House.clients.dxld.at>
	<20231013153605.487f5a74@kernel.org>
	<20231013154302.44cc197d@kernel.org>
	<2023101408-matador-stagnant-7cab@gregkh>
	<20231016073251.0f47d42b@kernel.org>
	<2023101632-circle-delegate-39dd@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Oct 2023 19:20:26 +0200 Greg Kroah-Hartman wrote:
> > IIUC what happens is:
> > 
> >  - systemd controls "real" eth0
> >  - we move a "to be renamed" eth0 from a container into main ns
> >  - we rename "to be renamed" eth0 to something else
> >  - seeing the rename of eth0 system thinks it's the "real" one
> >    that is being renamed, ergo there's no eth0 any more,
> >    so it shuts down its "unit" for eth0
> > 
> > I don't think anything changed. Sounds more like someone finally tried
> > to use this in anger.  
> 
> Then they get to keep the broken pieces that they created here.
> "moving" a network connection to a container needs to either be added to
> systemd if it is going to manage the network connections, or just stop
> using systemd to handle the connection entirely as they want to do
> something that systemd doesn't support.
> 
> I don't think your proposed change is going to do much here as you would
> have multiple adds for the same device without any removes, which is
> odd.

We issue the ADD and REMOVE uevents explicitly.

If only we could have a form of device_rename() which does not generate
any uevent, everything should be perfectly sensible. We issue REMOVE in
the old namespace. Rejig the device including the silent rename. Issue
ADD for the new identity in the new namespace.

