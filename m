Return-Path: <netdev+bounces-241432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B3615C83F87
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 09:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5F87034C508
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 08:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E832D9EC8;
	Tue, 25 Nov 2025 08:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIv7TBHo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128F32D948F
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 08:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764059179; cv=none; b=K9jD0L2yCHAuUpxMpnEQZIwJ6O9LpI/TgRlJFp6aH/UpapeIvomlfQ1Gl3+rYa5vDP0Hg1HLxHAsCOaxHPlpWtrhKOPdI1VzRNKSiWplFG4ttxS5rUEuK4MxtPwQOPj63VJz0mMowVk4WxoeszbfXi/fBqzDrde9eMpun5+DQ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764059179; c=relaxed/simple;
	bh=Afh3LuqY8T6H1cQlXtonHTUKu9vzJFqvaorplKdD1Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uABhrFHapdfx7FNMJviV66GWiiPUEdm7SWijscnRBgquWq3+E+eSlqC8gIAyFxyA39soQcrW9zrALjF48x37SGVpMp3FSI4N8E07hzusKQRseQMx5OVZOMIgRju8oiLNe5gv/7fAjrubCN/ZYTDMocQcRkc0tcStuw7EMId6HMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIv7TBHo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6DDC116D0;
	Tue, 25 Nov 2025 08:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764059178;
	bh=Afh3LuqY8T6H1cQlXtonHTUKu9vzJFqvaorplKdD1Hw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QIv7TBHo4ffmvfz6MSNJcIjiOjwlc/CyNHBeoOPfs242j16mPB5y6Pt7lmUpdlHrx
	 Pk3C9bcp8mq0biYOFbM9ggmn3A9r08hrSZh6waXALb7HcXv0MLj4U2eInYrgKzDLn5
	 vi04ekvr7PMSZNSw8vVTOHmrgejrGSI/PxUzujD1HNl/lGTegSKe5x7Br40pr9rJFc
	 ftImSMnq+s85zqyBJGWYE+n/fea/9NgnX9DiGaPphrrTg1VPcCHkaChis3HnpVOdBc
	 vKzuicrhtsENvDnJZiC8p+xMC3QlTr7bOx5t3md2JqGpE5yTXG1ctVMPX1b0p2vQcE
	 XBMT2m5dWnIiA==
Date: Tue, 25 Nov 2025 09:26:14 +0100
From: Antoine Tenart <atenart@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	andrew+netdev@lunn.ch, netdev@vger.kernel.org, Liang Li <liali@redhat.com>, 
	Beniamino Galvani <b.galvani@gmail.com>
Subject: Re: [PATCH net] net: vxlan: prevent NULL deref in vxlan_xmit_one
Message-ID: <emskewx4qfgxdhp6tvfx5fgz2nkcuv6sln6cde7m5jqm2rybmj@odtf6g5zu2no>
References: <20251124163103.23131-1-atenart@kernel.org>
 <20251124195119.0199d58a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124195119.0199d58a@kernel.org>

On Mon, Nov 24, 2025 at 07:51:19PM -0800, Jakub Kicinski wrote:
> On Mon, 24 Nov 2025 17:30:59 +0100 Antoine Tenart wrote:
> > Neither sock4 nor sock6 pointers are guaranteed to be non-NULL in
> > vxlan_xmit_one, e.g. if the iface is brought down. This can lead to the
> > following NULL dereference:
> > 
> >   BUG: kernel NULL pointer dereference, address: 0000000000000010
> >   Oops: Oops: 0000 [#1] SMP NOPTI
> >   RIP: 0010:vxlan_xmit_one+0xbb3/0x1580
> >   Call Trace:
> >    vxlan_xmit+0x429/0x610
> >    dev_hard_start_xmit+0x55/0xa0
> >    __dev_queue_xmit+0x6d0/0x7f0
> >    ip_finish_output2+0x24b/0x590
> >    ip_output+0x63/0x110
> > 
> > Mentioned commits changed the code path in vxlan_xmit_one and as a side
> > effect the sock4/6 pointer validity checks in vxlan(6)_get_route were
> > lost. Fix this by adding back checks.
> > 
> > Since both commits being fixed were released in the same version (v6.7)
> > and are strongly related, bundle the fixes in a single commit.
> > 
> > Reported-by: Liang Li <liali@redhat.com>
> > Fixes: 6f19b2c136d9 ("vxlan: use generic function for tunnel IPv4 route lookup")
> > Fixes: 2aceb896ee18 ("vxlan: use generic function for tunnel IPv6 route lookup")
> > Cc: Beniamino Galvani <b.galvani@gmail.com>
> > Signed-off-by: Antoine Tenart <atenart@kernel.org>
> 
> clang sayeth:
> 
> ../drivers/net/vxlan/vxlan_core.c:2548:7: warning: variable 'err' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
>  2548 |                 if (unlikely(!sock6)) {
>       |                     ^~~~~~~~~~~~~~~~
> ../include/linux/compiler.h:77:22: note: expanded from macro 'unlikely'
>    77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/net/vxlan/vxlan_core.c:2631:6: note: uninitialized use occurs here
>  2631 |         if (err == -ELOOP)
>       |             ^~~
> ../drivers/net/vxlan/vxlan_core.c:2548:3: note: remove the 'if' if its condition is always false
>  2548 |                 if (unlikely(!sock6)) {
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~
>  2549 |                         reason = SKB_DROP_REASON_DEV_READY;
>       |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  2550 |                         goto tx_error;
>       |                         ~~~~~~~~~~~~~~
>  2551 |                 }
>       |                 ~
> ../drivers/net/vxlan/vxlan_core.c:2464:7: warning: variable 'err' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
>  2464 |                 if (unlikely(!sock4)) {
>       |                     ^~~~~~~~~~~~~~~~
> ../include/linux/compiler.h:77:22: note: expanded from macro 'unlikely'
>    77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/net/vxlan/vxlan_core.c:2631:6: note: uninitialized use occurs here
>  2631 |         if (err == -ELOOP)
>       |             ^~~
> ../drivers/net/vxlan/vxlan_core.c:2464:3: note: remove the 'if' if its condition is always false
>  2464 |                 if (unlikely(!sock4)) {
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~
>  2465 |                         reason = SKB_DROP_REASON_DEV_READY;
>       |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  2466 |                         goto tx_error;
>       |                         ~~~~~~~~~~~~~~
>  2467 |                 }
>       |                 ~
> ../drivers/net/vxlan/vxlan_core.c:2352:9: note: initialize the variable 'err' to silence this warning
>  2352 |         int err;
>       |                ^
>       |                 = 0

I missed that somehow... will fix in v2. Thanks!

