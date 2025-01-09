Return-Path: <netdev+bounces-156670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0714A07562
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 13:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6049C7A053B
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 12:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06268217640;
	Thu,  9 Jan 2025 12:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="afR7TU/S"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452D6216E24
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 12:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736424702; cv=none; b=j7fCKpjpupux9kWzz6zxgca9SiC76d8F5qBCrg2i2eZS+Bvf7NvssCeNt25EeX03s6snl2OERdaG4/+KUCnCzIXJ6kwNFuRaCPQw7vjXUWM+wz6ocPcVvdZRwtSiKwEfdo8j62+Pww97rTuPD7ftjTpkYp0T8/znPi564AmnQB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736424702; c=relaxed/simple;
	bh=V9Igcc57UG9HRjSech9JKcEzhucrTa40yP8znsLc6RI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tvkkr3sbeQm66d4Hd2OFA71nVG81Uu/D1VBie5W3EKlNI6+r+qQvRO3UH8Bs5alQVgpuADKTNBT2fZ4W3r2QfPiD0EV2bf4LG4B+p+PTjYil6gjUHO/suurDvPi2M814NEZO+g5ors6/5kfVTTJAJvQRVej1Aq1kSm75FV++nwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=afR7TU/S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736424700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6UX0y6Cp3sQrCE2nh5veQWVG7OewsvHWIAkmGcNadoM=;
	b=afR7TU/SrO6VLHwoJlMf58aZbcmwtTa2XzZ8lMrPFsrkY+8B50vdhvaArWO5WFHKuAL0t7
	oEYtK6HyHEczwsDvBkWnSFhthw2REmby8JyARPov8P1AhhiRPQdbW6y82ljOPycVkYqea4
	k5lYyYPkQxaMbHOjUmbU6Pu3RgyUcgM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-9Fmd4Ao2PRqiWMNPqO2NEA-1; Thu, 09 Jan 2025 07:11:38 -0500
X-MC-Unique: 9Fmd4Ao2PRqiWMNPqO2NEA-1
X-Mimecast-MFC-AGG-ID: 9Fmd4Ao2PRqiWMNPqO2NEA
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-468f6f2f57aso10359461cf.0
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 04:11:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736424698; x=1737029498;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6UX0y6Cp3sQrCE2nh5veQWVG7OewsvHWIAkmGcNadoM=;
        b=Nwjz280gu5oi2oros1Dpik2VkH+PRwGWIGV5epVhdACWP58d9sBy6LBBPb8gHHy4Bw
         awx4A75tfteUQF775L7DJ3kc6Go6dyx9yqofZQ7/9euO2OL6D7MNFQM84pwqucfS5ucS
         ABv9IituneiW2k6J/TYCgQbetpR+rjEx0YejwW8tz37dcPiz03q8tsmwkiWYkQdQAW1M
         XPvvOf+kH/8uywam49CRM+qtlExriPoBxzeH+toIuul99OianUR0EsrlR9DpJqNziOiB
         GvML6FKYPmvLIYU8fqRj/CtoJSn40xyK7mS0vjAkdKZTcRKfwVRJQxOOjRdoI4lb+GJG
         n+Bw==
X-Forwarded-Encrypted: i=1; AJvYcCWYNMZC3XIh9QifHLDZeWS7fpySHS9/4VLbwHadxRtkhAF8CnKlAxlav/to6sA4xtaGVevO5EY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvFNoiv5Fq/n4PHluXk+BslAWtzln/vx9WLZQ7iLVghk7jyDiI
	dfapaJ5QLvYWJMrjQ4OTyiPpwHZUQtbS/2LRZiYoZATzavMcHRYoHvQWvSw0BGl5DJsTsbI/Ymg
	+F2Uv765MevVwCF8Jn1LvFFEumwkfh1nKeGv2b1Un0XAoUu/OQVOXkg==
X-Gm-Gg: ASbGnct870wCS19a5+K33rA4RITXMnPPypCoGdzZlnViXX5iMttVx/EKdSFok34cO27
	M5/DwTr/CUS0Kd1aSiYUh11RN/s9XRpnCxXTQtbzAvE9Dn9fG5/ZaGTQmG9/yid9/saGZB5NiXZ
	clVAy9Z5ZoW92FqdqjZVqW3H25PVgbvxkkt80ANdLU20buAoe2+2lVHDRhLlRpQ19FdwCAGxR/A
	BidXT025X8CuzfW4HmMjFspqXit1/2ignEJAYnPCcO1TzIzlAzBesZAivjL/JlWSLgLZTskEEUP
	TWGS0T5s
X-Received: by 2002:a05:622a:242:b0:467:54e5:ceaa with SMTP id d75a77b69052e-46c71079ea3mr95295221cf.9.1736424698340;
        Thu, 09 Jan 2025 04:11:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqKaxlWIfd8ANpdNqMYSDWxka7BN+0vCp0a2UKun8ljcvGi8/js/ptgg8silyjum2+0LQEyA==
X-Received: by 2002:a05:622a:242:b0:467:54e5:ceaa with SMTP id d75a77b69052e-46c71079ea3mr95294811cf.9.1736424697984;
        Thu, 09 Jan 2025 04:11:37 -0800 (PST)
Received: from [192.168.88.253] (146-241-2-244.dyn.eolo.it. [146.241.2.244])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb30dc4sm206077481cf.76.2025.01.09.04.11.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 04:11:37 -0800 (PST)
Message-ID: <fb7a1324-41c6-4e10-a6a3-f16d96f44f65@redhat.com>
Date: Thu, 9 Jan 2025 13:11:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] sched: sch_cake: add bounds checks to host bulk
 flow fairness counts
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>
Cc: syzbot+f63600d288bfb7057424@syzkaller.appspotmail.com,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 cake@lists.bufferbloat.net, netdev@vger.kernel.org
References: <20250107120105.70685-1-toke@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250107120105.70685-1-toke@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/7/25 1:01 PM, Toke Høiland-Jørgensen wrote:
> Even though we fixed a logic error in the commit cited below, syzbot
> still managed to trigger an underflow of the per-host bulk flow
> counters, leading to an out of bounds memory access.
> 
> To avoid any such logic errors causing out of bounds memory accesses,
> this commit factors out all accesses to the per-host bulk flow counters
> to a series of helpers that perform bounds-checking before any
> increments and decrements. This also has the benefit of improving
> readability by moving the conditional checks for the flow mode into
> these helpers, instead of having them spread out throughout the
> code (which was the cause of the original logic error).
> 
> v2:
> - Remove now-unused srchost and dsthost local variables in cake_dequeue()

Small nit: the changelog should come after the '---' separator. No need
to repost just for this.

> Fixes: 546ea84d07e3 ("sched: sch_cake: fix bulk flow accounting logic for host fairness")
> Reported-by: syzbot+f63600d288bfb7057424@syzkaller.appspotmail.com
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
> ---
>  net/sched/sch_cake.c | 140 +++++++++++++++++++++++--------------------
>  1 file changed, 75 insertions(+), 65 deletions(-)
> 
> diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> index 8d8b2db4653c..2c2e2a67f3b2 100644
> --- a/net/sched/sch_cake.c
> +++ b/net/sched/sch_cake.c
> @@ -627,6 +627,63 @@ static bool cake_ddst(int flow_mode)
>  	return (flow_mode & CAKE_FLOW_DUAL_DST) == CAKE_FLOW_DUAL_DST;
>  }
>  
> +static void cake_dec_srchost_bulk_flow_count(struct cake_tin_data *q,
> +					     struct cake_flow *flow,
> +					     int flow_mode)
> +{
> +	if (likely(cake_dsrc(flow_mode) &&
> +		   q->hosts[flow->srchost].srchost_bulk_flow_count))
> +		q->hosts[flow->srchost].srchost_bulk_flow_count--;
> +}
> +
> +static void cake_inc_srchost_bulk_flow_count(struct cake_tin_data *q,
> +					     struct cake_flow *flow,
> +					     int flow_mode)
> +{
> +	if (likely(cake_dsrc(flow_mode) &&
> +		   q->hosts[flow->srchost].srchost_bulk_flow_count < CAKE_QUEUES))
> +		q->hosts[flow->srchost].srchost_bulk_flow_count++;
> +}
> +
> +static void cake_dec_dsthost_bulk_flow_count(struct cake_tin_data *q,
> +					     struct cake_flow *flow,
> +					     int flow_mode)
> +{
> +	if (likely(cake_ddst(flow_mode) &&
> +		   q->hosts[flow->dsthost].dsthost_bulk_flow_count))
> +		q->hosts[flow->dsthost].dsthost_bulk_flow_count--;
> +}
> +
> +static void cake_inc_dsthost_bulk_flow_count(struct cake_tin_data *q,
> +					     struct cake_flow *flow,
> +					     int flow_mode)
> +{
> +	if (likely(cake_ddst(flow_mode) &&
> +		   q->hosts[flow->dsthost].dsthost_bulk_flow_count < CAKE_QUEUES))
> +		q->hosts[flow->dsthost].dsthost_bulk_flow_count++;
> +}
> +
> +static u16 cake_get_flow_quantum(struct cake_tin_data *q,
> +				 struct cake_flow *flow,
> +				 int flow_mode)
> +{
> +	u16 host_load = 1;
> +
> +	if (cake_dsrc(flow_mode))
> +		host_load = max(host_load,
> +				q->hosts[flow->srchost].srchost_bulk_flow_count);
> +
> +	if (cake_ddst(flow_mode))
> +		host_load = max(host_load,
> +				q->hosts[flow->dsthost].dsthost_bulk_flow_count);
> +
> +	/* The get_random_u16() is a way to apply dithering to avoid
> +	 * accumulating roundoff errors
> +	 */
> +	return (q->flow_quantum * quantum_div[host_load] +
> +		get_random_u16()) >> 16;

dithering is now applied on both enqueue and dequeue, while prior to
this patch it only happened on dequeue. Is that intentional? can't lead
to (small) flow_deficit increase?

Thanks!

Paolo


