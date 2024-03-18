Return-Path: <netdev+bounces-80394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3165087E9AA
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 14:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 611231C2074D
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 13:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE38737711;
	Mon, 18 Mar 2024 13:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUeT1Z0v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B1036AE0
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 13:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710766913; cv=none; b=dRR0h6JkOgiSl79fv0+aURrKzuuS+xO2tWD6vDR33fmOndDXOSys+On6KULs8P2RjXqq+4vQa0ssuEgk1KHdkMCN5ql+4W1+p46h4E0GhLKy+EMJ3bh2+ZQP6n84BoehFpfMPe1Fmx44djzexm41SaucOqJROaDpK4XJYxTSMVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710766913; c=relaxed/simple;
	bh=Lr5ZMgMIY1z6SMLtn9oGn5a4KludY3r/KaDm6Q/ILrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RqwdIvlxmjUqK8aW+ipDmJPUjAxNn7cQ5FV4pSOz4hmFjf/+tmnMryJrAWKel6Fam3zEgP/AlpEzWZ0FSMF3PNhhwY36/PDeSG/403CuCrxSxEEY8kCtd4D2x6YwuxbRGzOt2QtvjaXxr9Ox6mW7vT7EBKIyusOdpURM4lgWmQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUeT1Z0v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABFBC433C7;
	Mon, 18 Mar 2024 13:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710766913;
	bh=Lr5ZMgMIY1z6SMLtn9oGn5a4KludY3r/KaDm6Q/ILrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UUeT1Z0v/tBY2ZJssEXpOgPfp2mAZ+qHrtdxRsF8WyHspu2+tzNNLOC/5xUjKPHoN
	 SNgFKt6GUZNPIrQRb+wY2SNkbt24pLl68Ewl7u5+4avCBWaFySoEa3j58aQOvht2tC
	 fnB+xeLeaFerbqJfO3kMwUOBMesZZHkTOLrj1BaFJhoaBH0qr/9d8fw2s2pl4dM1me
	 EKAqKJiVLk+96Wfx1qzrUkNoummBxiuKNFu2TO42Ksxue5zcuWKKclu4Sp43lJq+Fl
	 KraQJAAp+09IQIxX9Jf6OLiaf7QkeOKBLGrZTxOCH33JHKu5s3fvPR8cbcQ6EWWc+F
	 iHiupkcfl+hGQ==
Date: Mon, 18 Mar 2024 13:01:49 +0000
From: Simon Horman <horms@kernel.org>
To: Felix Maurer <fmaurer@redhat.com>
Cc: Breno Leitao <leitao@debian.org>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net] hsr: Handle failures in module init
Message-ID: <20240318130149.GD1623@kernel.org>
References: <0b718dd6cc28d09fd2478d8debdfc0a6755a8895.1710410183.git.fmaurer@redhat.com>
 <ZfL0t5v3szkhEhiN@gmail.com>
 <bd03c79a-39e9-4eb0-97b2-4ded536f8eb4@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd03c79a-39e9-4eb0-97b2-4ded536f8eb4@redhat.com>

On Thu, Mar 14, 2024 at 04:56:35PM +0100, Felix Maurer wrote:
> On 14.03.24 13:59, Breno Leitao wrote:
> > On Thu, Mar 14, 2024 at 11:10:52AM +0100, Felix Maurer wrote:
> >> A failure during registration of the netdev notifier was not handled at
> >> all. A failure during netlink initialization did not unregister the netdev
> >> notifier.
> >>
> >> Handle failures of netdev notifier registration and netlink initialization.
> >> Both functions should only return negative values on failure and thereby
> >> lead to the hsr module not being loaded.
> >>
> >> Signed-off-by: Felix Maurer <fmaurer@redhat.com>
> >> ---
> >>  net/hsr/hsr_main.c | 18 ++++++++++++++----
> >>  1 file changed, 14 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/net/hsr/hsr_main.c b/net/hsr/hsr_main.c
> >> index cb83c8feb746..1c4a5b678688 100644
> >> --- a/net/hsr/hsr_main.c
> >> +++ b/net/hsr/hsr_main.c
> >> @@ -148,14 +148,24 @@ static struct notifier_block hsr_nb = {
> >>  
> >>  static int __init hsr_init(void)
> >>  {
> >> -	int res;
> >> +	int err;
> >>  
> >>  	BUILD_BUG_ON(sizeof(struct hsr_tag) != HSR_HLEN);
> >>  
> >> -	register_netdevice_notifier(&hsr_nb);
> >> -	res = hsr_netlink_init();
> >> +	err = register_netdevice_notifier(&hsr_nb);
> >> +	if (err)
> >> +		goto out;
> > 
> > Can't you just 'return err' here? And avoid the `out` label below?
> > 
> >> +
> >> +	err = hsr_netlink_init();
> >> +	if (err)
> >> +		goto cleanup;
> > 
> > Same here, you can do something like the following and remove the
> > all the labels below, making the function a bit clearer.
> > 
> > 	if (err) {
> > 		unregister_netdevice_notifier(&hsr_nb);
> > 		return err;
> > 	}
> 
> I usually follow the pattern with labels to make sure the cleanup is not
> forgotten later when extending the function. But there is likely not
> much change in the module init, I'll remove the labels in the next
> iteration.

FWIIW, I think the use of labels is the right way to go: it is the
idomatic approach preferred in Networking code.

That said, dropping the out label would be fine by me,
as as simple return nice IMHO.

