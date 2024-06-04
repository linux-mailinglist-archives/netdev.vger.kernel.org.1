Return-Path: <netdev+bounces-100753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEFE8FBDDD
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 23:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DB4CB21D0A
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 21:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8206914B96A;
	Tue,  4 Jun 2024 21:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KvqAbaSx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A503B140375
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 21:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717535561; cv=none; b=DrwjxePJIS16qFLODAhEY+XtmTKgEt8RvFiR8W66ODUWyEjExRK5KdwI3QLMbQJS1/J0HQSRmHCQXcov4q1QwRDMxCDofnF+FbSvC3aXRBIING+kYNJ4TMD18pbNpEtWVkSWnxcrjZCZvB1TakVsPxApO8LU9NbzvkGSW+/H6Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717535561; c=relaxed/simple;
	bh=ev0Xw6mSy+PHDyjzSPt/QDo/H7gy+pQk/HVfSR1wjzM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ifqDuzVCy34TxsJnMp4bsLaftip9fny8z8rBumodmq7pKG3E6FOvlzu4NjZUw5UNRm6cr8l66pPYgbzDCiP3NNlvhYsy/hzY4Xe+y3t6tUK1TMYPut1tADBZMiZa+rtVGJ3IvpyQaXimztCGU5BvrtGsluHC2y3+LZszuhGBpEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KvqAbaSx; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717535559; x=1749071559;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=ev0Xw6mSy+PHDyjzSPt/QDo/H7gy+pQk/HVfSR1wjzM=;
  b=KvqAbaSxQYd1WqeC46sj0SJKuynkJuUgprAODHU3xFFu0K3nzPOjLv/R
   50nNBZjHeMDmu9APrRjhv0fNGrItQ2q8IqZnE+Qox7vKIr9fuIh+/BVrR
   rXYpFJDY83F3QWRg0WYmBC6XpvPUjk5GOR+s3a8d7MJ02yQIVebRzB+NE
   jctcwJAmzwgMsyy/x4+vVq4+5CSJCPEssvawKZq9p/F778WvckrAa7c2W
   l5TteyJWNLtMJ0nHb/HUEI8AO2DRyQv4ZYi+H1ne7FqrAb1cGcRbdZqrt
   MVUijMhUJJpPHUB9m1DbkbKwjlXdw3XtwquSey0JH8YGkpXg6hCmvavxB
   A==;
X-CSE-ConnectionGUID: vhEq4+eiRkKRaOdGnyZMGg==
X-CSE-MsgGUID: HM+TfvwbR9uV/H5jV5IizQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="14333271"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="14333271"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 14:12:38 -0700
X-CSE-ConnectionGUID: DxUybvZpQk+pFcWwOhDT0Q==
X-CSE-MsgGUID: BAcYiPKjRHiLEhwmVmRTPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="42314821"
Received: from vcostago-mobl3.jf.intel.com (HELO vcostago-mobl3) ([10.241.228.254])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 14:12:38 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, Eric Dumazet
 <edumazet@google.com>, Noam Rathaus <noamr@ssd-disclosure.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net] net/sched: taprio: always validate
 TCA_TAPRIO_ATTR_PRIOMAP
In-Reply-To: <20240604181511.769870-1-edumazet@google.com>
References: <20240604181511.769870-1-edumazet@google.com>
Date: Tue, 04 Jun 2024 14:12:38 -0700
Message-ID: <87plswv2d5.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Dumazet <edumazet@google.com> writes:

> If one TCA_TAPRIO_ATTR_PRIOMAP attribute has been provided,
> taprio_parse_mqprio_opt() must validate it, or userspace
> can inject arbitrary data to the kernel, the second time
> taprio_change() is called.
>
> First call (with valid attributes) sets dev->num_tc
> to a non zero value.
>
> Second call (with arbitrary mqprio attributes)
> returns early from taprio_parse_mqprio_opt()
> and bad things can happen.
>
> Fixes: a3d43c0d56f1 ("taprio: Add support adding an admin schedule")
> Reported-by: Noam Rathaus <noamr@ssd-disclosure.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  net/sched/sch_taprio.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> index 937a0c513c17..b284a06b5a75 100644
> --- a/net/sched/sch_taprio.c
> +++ b/net/sched/sch_taprio.c
> @@ -1176,16 +1176,13 @@ static int taprio_parse_mqprio_opt(struct net_device *dev,
>  {
>  	bool allow_overlapping_txqs = TXTIME_ASSIST_IS_ENABLED(taprio_flags);
>  
> -	if (!qopt && !dev->num_tc) {
> -		NL_SET_ERR_MSG(extack, "'mqprio' configuration is necessary");
> -		return -EINVAL;
> -	}
> -
> -	/* If num_tc is already set, it means that the user already
> -	 * configured the mqprio part
> -	 */
> -	if (dev->num_tc)
> +	if (!qopt) {
> +		if (!dev->num_tc) {
> +			NL_SET_ERR_MSG(extack, "'mqprio' configuration is necessary");
> +			return -EINVAL;
> +		}
>  		return 0;
> +	}

Nice one. I think I have an idea of what's going on here.

Validating the priomap even if we are not going to install it is good:


Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


Cheers,
-- 
Vinicius

