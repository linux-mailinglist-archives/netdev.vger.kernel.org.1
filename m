Return-Path: <netdev+bounces-209861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6673B11148
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 20:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFBB6AA6285
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 18:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C3B207A2A;
	Thu, 24 Jul 2025 18:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fZoC3xJd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4B02116F6
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 18:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753383495; cv=none; b=hjVYePK/glvdRFkohb4yI/2a6glIYU3XdSIydh4bh++O90jhlXekWnwHjX3NQLGftzP6a7mccr782pAIlyXxVJoLdJtNbuoemGR4S3n7LvU07lvp0ZcIDGHZhWILjKslTua4Qf2s8oooP7kOUHBow3Y80/mZ1C8RSGEGEM+EReQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753383495; c=relaxed/simple;
	bh=Y9aWs3V4mdlrimYY7VLG+s6NAwFX8HPz+yeIc6DRkLU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IjtLGEcXGiHL6YFAEzkUDN7Jz12kwzNlLI85EFWOESa6PZEHsFUb1Tgy4TgMHxIJm6B8Tp0Kwda5pq5bZ9C+dl0VCCF0nqvPYECQlee/+dZcadoQIOPh9yxMRgZ1tdrYPKPtLFw7KancFhd+4arrfdFa9+3WIBwElmIYq4dM/+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fZoC3xJd; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753383494; x=1784919494;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Y9aWs3V4mdlrimYY7VLG+s6NAwFX8HPz+yeIc6DRkLU=;
  b=fZoC3xJdDVMwj+TrdFm7lfhY2xDJbGLu1/wHF0ucpZAUuwyH0FlaSaO1
   +EtJNGzPJLGIjd4m1HWZrodcLcKLyif8W6mthGW5O9rKe+EP7IoT0sNXv
   MnRCnoimxMUdut1HhZwit0jyY/eB2eIcsxAbax53Gyp2xgU8rxK2o7lPw
   /vHyfaX+43DQNY0kqqYrLXF7PEiNiAWmCLUWCIP5HeZ9G5951OyOeq8Qt
   qN/aogg/TzoKZ7SYADIgSYCKjFhoLugKEgtJcN4uwlIDBOLdVPkYzwIiZ
   psPVCefohi2psmOlEbGrXpzPZnFv/smGCciF1UieDH02i6SdFeOpENxTj
   g==;
X-CSE-ConnectionGUID: c7xlnFYYT9W+EwXvPrxjUw==
X-CSE-MsgGUID: zcstDoPoTt+/tgMYd+2yGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="67067847"
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="67067847"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 11:58:13 -0700
X-CSE-ConnectionGUID: 7YvJ8rIZTDWw0Xg7N4NJZQ==
X-CSE-MsgGUID: WPk5humMQtic2g9z2JfrzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="191339298"
Received: from msatwood-mobl.amr.corp.intel.com (HELO vcostago-mobl3) ([10.124.223.210])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 11:58:12 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Takamitsu Iwai <takamitz@amazon.co.jp>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@google.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Vladimir Oltean <olteanv@gmail.com>,
 takamitz@amazon.com, Takamitsu Iwai <takamitz@amazon.co.jp>,
 syzbot+398e1ee4ca2cac05fddb@syzkaller.appspotmail.com
Subject: Re: [PATCH v1 net] net/sched: taprio: enforce minimum value for
 picos_per_byte
In-Reply-To: <20250724181345.40961-1-takamitz@amazon.co.jp>
References: <20250724181345.40961-1-takamitz@amazon.co.jp>
Date: Thu, 24 Jul 2025 11:58:11 -0700
Message-ID: <87ecu5e7r0.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Takamitsu Iwai <takamitz@amazon.co.jp> writes:

> Syzbot reported a WARNING in taprio_get_start_time().
>
> When link speed is 470589 or greater, q->picos_per_byte becomes too
> small, causing length_to_duration(q, ETH_ZLEN) to return zero.
>

When I chose the unit picoseconds, I remember thinking "nobody would
consider using taprio with over 400Gbs" :-)

> This zero value leads to validation failures in fill_sched_entry() and
> parse_taprio_schedule(), allowing arbitrary values to be assigned to
> entry->interval and cycle_time. As a result, sched->cycle can become zero.
>
> Since SPEED_800000 is the largest defined speed in
> include/uapi/linux/ethtool.h, this issue can occur in realistic scenarios.
>
> To ensure length_to_duration() returns a non-zero value for minimum-sized
> Ethernet frames (ETH_ZLEN = 60), picos_per_byte must be at least 17
> (60 * 17 > PSEC_PER_NSEC which is 1000).
>
> This patch enforces a minimum value of 17 for picos_per_byte when the
> calculated value would be lower.
>
> Fixes: 68ce6688a5ba ("net: sched: taprio: Fix potential integer overflow in taprio_set_picos_per_byte")
> Reported-by: syzbot+398e1ee4ca2cac05fddb@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=398e1ee4ca2cac05fddb
> Signed-off-by: Takamitsu Iwai <takamitz@amazon.co.jp>
> ---
>  net/sched/sch_taprio.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> index 2b14c81a87e5..bcfdb9446657 100644
> --- a/net/sched/sch_taprio.c
> +++ b/net/sched/sch_taprio.c
> @@ -43,6 +43,12 @@ static struct static_key_false taprio_have_working_mqprio;
>  #define TAPRIO_SUPPORTED_FLAGS \
>  	(TCA_TAPRIO_ATTR_FLAG_TXTIME_ASSIST | TCA_TAPRIO_ATTR_FLAG_FULL_OFFLOAD)
>  #define TAPRIO_FLAGS_INVALID U32_MAX
> +/* Minimum value for picos_per_byte to ensure non-zero duration
> + * for minimum-sized Ethernet frames (ETH_ZLEN = 60).
> + * 60 * 17 > PSEC_PER_NSEC (1000)
> + */
> +#define TAPRIO_PICOS_PER_BYTE_MIN 17
> +
>  
>  struct sched_entry {
>  	/* Durations between this GCL entry and the GCL entry where the
> @@ -1299,7 +1305,7 @@ static void taprio_set_picos_per_byte(struct net_device *dev,
>  		speed = ecmd.base.speed;
>  
>  skip:
> -	picos_per_byte = (USEC_PER_SEC * 8) / speed;
> +	picos_per_byte = max((USEC_PER_SEC * 8) / speed,
>  TAPRIO_PICOS_PER_BYTE_MIN);

Thinking if it's worth displaying an error to the user here? something
like "Linkspeed %d is greater than what can be tracked, schedule may be
inacurate". I am worried that at this point, taprio won't be able to
obey the configured schedule and the user should know about that.

If we see people complaining about it in the real world, we can change
the units, or do something else.

>  
>  	atomic64_set(&q->picos_per_byte, picos_per_byte);
>  	netdev_dbg(dev, "taprio: set %s's picos_per_byte to: %lld, linkspeed: %d\n",
> -- 
> 2.39.5 (Apple Git-154)
>


Cheers,
-- 
Vinicius

