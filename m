Return-Path: <netdev+bounces-175782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 725CBA6777F
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 16:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1AD717D56A
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 15:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE13E20E013;
	Tue, 18 Mar 2025 15:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5hKfX1b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874DA20D505;
	Tue, 18 Mar 2025 15:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742310989; cv=none; b=S0gT7Pd70QRtjlm+02uA0ZzMqdWrdZSwmm5u5Cou6yWxgPqLiDU2iX9JQUva4QGt6HrSLKmJgAHmM3o41pfl+f3Y4Uep/W8hV0Exlq30bxE0fkQuRFH7xSacvRACNxpBlOdew/E8O7jWvmC8LK1fYdkenyj4QrpgHEqoSe5Q9F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742310989; c=relaxed/simple;
	bh=sd/wzBX9but7ZOJjYceVNbvV3MbkJU9nIM6WwRq6E1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkodW9TXpHDHYtV3ks+GullhpaS2aB7sXyfw3RocYqdaiX7q+87FgSOmlFB/iP4ZNRaeDVHHVdmKgalt4uutMTM37usE1IfKAzBOtZqAsisZatOExiM+Z73mI5UKNjtbansIO756+pX3ZXr1r+xzRRgzsQjQSBqyjbd0E/yNb/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5hKfX1b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D01C4CEF3;
	Tue, 18 Mar 2025 15:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742310989;
	bh=sd/wzBX9but7ZOJjYceVNbvV3MbkJU9nIM6WwRq6E1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W5hKfX1b8wXJq9AT/9xZ2qjVT/J6/LbJ7eEhR+/PC5Qdgq/Flo1J8qKuPcNriqeyX
	 K1hzO05EjO3Nlz+br3sxHUTVBhHceQBHSDv4fzF9XHejECYyO02pjynrUiipolaLVz
	 RNKFFRyblNzFqdqUEWHS/hgt52RFhy4z3+cicG5T1FdsPB5tohrFKrKidW6Ih7yLmX
	 fmoR80qCRBz4OIxhBxhnTzqtVtm3mOks3ySi2sMK6rxQDvS9C8zCDxCvIPJFf2R1FB
	 fC/tJDRICD0268GyGRFCeScM4u/seMnKyPLBBP0x0m7Gw7YHGwOX016NCN6SsUjiPh
	 /3Am4osxcOHjg==
Date: Tue, 18 Mar 2025 15:16:24 +0000
From: Simon Horman <horms@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us
Subject: Re: [PATCH net-next] net: don't relock netdev when on qdisc_create
 replay
Message-ID: <20250318151624.GC688833@kernel.org>
References: <20250313100407.2285897-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313100407.2285897-1-sdf@fomichev.me>

On Thu, Mar 13, 2025 at 03:04:07AM -0700, Stanislav Fomichev wrote:
> Eric reports that by the time we call netdev_lock_ops after
> rtnl_unlock/rtnl_lock, the dev might point to an invalid device.
> Don't relock the device after request_module and don't try
> to unlock it in the caller (tc_modify_qdisc) in case of replay.
> 
> Fixes: a0527ee2df3f ("net: hold netdev instance lock during qdisc ndo_setup_tc")
> Reported-by: Eric Dumazet <edumazet@google.com>
> Link: https://lore.kernel.org/netdev/20250305163732.2766420-1-sdf@fomichev.me/T/#me8dfd778ea4c4463acab55644e3f9836bc608771
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  net/sched/sch_api.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index abace7665cfe..f1ec6ec0cf05 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -1278,13 +1278,14 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
>  			 * tell the caller to replay the request.  We
>  			 * indicate this using -EAGAIN.
>  			 * We replay the request because the device may
> -			 * go away in the mean time.
> +			 * go away in the mean time. Note that we also
> +			 * don't relock the device because it might
> +			 * be gone at this point.
>  			 */
>  			netdev_unlock_ops(dev);
>  			rtnl_unlock();
>  			request_module(NET_SCH_ALIAS_PREFIX "%s", name);
>  			rtnl_lock();
> -			netdev_lock_ops(dev);
>  			ops = qdisc_lookup_ops(kind);
>  			if (ops != NULL) {

Hi Stan,

I see that if this condition is met then the replay logic
in the next hunk works as intended by this patch.

But what if this condition is not met?
It seems to me that qdisc_create(), and thus __tc_modify_qdisc()
will return with an unlocked device, but the replay logic
won't take effect in tc_modify_qdisc().

Am I missing something?

>  				/* We will try again qdisc_lookup_ops,
> @@ -1837,9 +1838,10 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
>  	replay = false;
>  	netdev_lock_ops(dev);
>  	err = __tc_modify_qdisc(skb, n, extack, dev, tca, tcm, &replay);
> -	netdev_unlock_ops(dev);
> +	/* __tc_modify_qdisc returns with unlocked dev in case of replay */
>  	if (replay)
>  		goto replay;
> +	netdev_unlock_ops(dev);
>  
>  	return err;
>  }
> -- 
> 2.48.1
> 

