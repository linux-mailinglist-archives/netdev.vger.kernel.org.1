Return-Path: <netdev+bounces-208956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C61DEB0DAE5
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 15:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5CFD17C67E
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 13:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3312882BB;
	Tue, 22 Jul 2025 13:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GqrTpvJk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A496E2DFA46
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 13:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753191132; cv=none; b=m0PgrznwT9dSdufCXGaUaqPvyNaU56374KfknfPhFYcc6hTzhLoiGptc4nkdN3RYnzY7ZYCb6fL6D1GM0vovN9e7E42UALknMn2MMHHspqBMEOb4E2n5bDABc6lCdfnO0c/JFdnDEdnX3zzsrz+Aur8y33Qh87e6lzlRw1JnS0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753191132; c=relaxed/simple;
	bh=AwaSntSRv4KKTq/Mc/4XIRkj3yppN4Zuohy3PZwRodY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ueOqyraYUMYJl5xYi1s3VTuXPhLX368tHOhBZU8MLpeBxHdgQmFwzKwIP7PBO3L8ykXGlH7d+WfvNIcEFofOdkg2bdCAIvnj9TLYEU7aj5SHH7Y/0k6IEj7U9tMv/y3K0WtHWXDKlGu1AB5NDdb/Cscd3jaeOj8ZwLHjZqamDZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GqrTpvJk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753191129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OwS927qXkgcBzQAQ1/jvGsSW5/bTXbavY6/4pe28EKI=;
	b=GqrTpvJkk7jrHcQuoOYIWcyRtd8EF7Nohchmdrm0wuof1QxSJu3YI5q2zk6U9xCw7Zm7+q
	JT0q/Jr3VRmp2eINDQ9HI4+eFK9aXwsxdOERwRDPESS2cEA1/FVNIkTJNCfP6QPE0hgxoE
	1oLY/43Mkhym0ubcX8S9bAUBXGKVuzE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-3KhZRwVIMC2VNsRqy27m4g-1; Tue, 22 Jul 2025 09:32:08 -0400
X-MC-Unique: 3KhZRwVIMC2VNsRqy27m4g-1
X-Mimecast-MFC-AGG-ID: 3KhZRwVIMC2VNsRqy27m4g_1753191127
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4561bc2f477so33358455e9.0
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 06:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753191127; x=1753795927;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OwS927qXkgcBzQAQ1/jvGsSW5/bTXbavY6/4pe28EKI=;
        b=G3qVibwJpHqCaCIQlPHlIVKTjNYQcHwp889YmyCMmsjVGDK7Se+tLE9GxJdMs0R0Uv
         xkE3fH/DacobCUiwcL+xgHm0tgWAPKLb3JZwkYRMBpe5E5ZgIQusibAArTSeAsbBDFeT
         x0HQ14in4xBNCSRykg3Xo3yImrn33fJSG2sBcp1RJte9qDp/+grlRoSUpTpgOw5bsABr
         fnZJI439I2DrcRjdTCo1obk+lqPISjyY50wHUdGYxvShEXOcoP4FP7sXEPC5LQ7jg8Rp
         K3ZSwGK2/cozl+/utddVXszGBEgLp59vTKq+PjdJl2wginf1U4j8B+Sx6pu4ZV+6IqaT
         TPlw==
X-Forwarded-Encrypted: i=1; AJvYcCUzCyTBvhzwlkIjIrVxm9OGO+lnlTs3yo3qpL9n3j+gj0HP96Isi+ThDkottMjcjBi1N1/0d7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPdnoGnoWur5lmleHSh2Z5CR3SB1bB+2yMq2EQF394w/egSnXt
	4AT8ousqO8+XuEV6ugXBAtbcGkrl8PXQovjcIFL5iDnFoAGiy+hSrlK/0KN+nrKYyyANHFkpgkC
	WYOYhRnOsqPf5cL680kajH0Zp6CEXtnrTjvBF98J5XHZGmyfemzpoUot9ag==
X-Gm-Gg: ASbGnctGm2P3JnvCY+C1QkfjhAOTsMnTddW/WOhQk9xCAqijbeZkzRiowcTeqS+MAom
	GFxD05U0z+oFhz6yOMTftGMIH7MeYevwnFKanfjQ1fKJ4C+5U0jxLSw3+FVnbWUsWbSWQfIXs/I
	nb1buVh8V3v3LA3RdIAkQsIdqUDXusyECVJlnC7kTfzllpO528q9Vwz0i356Hnd70FHI9/jen+6
	RWo8ByqOGTK+VJh4arF9XkBJXyKDK89QO3uW6cy4Lf86CfD2+oN0/ZaY9kd/q4ikL79fr3wdOyW
	FWLl3hT+R4w4Z3bJaNdV4YSp1TYDWRSl+CljaS0ZyaKRQ0V6zraj2z1HpzkOgwe9wZsoQMTX8dM
	1r4R0bGARe28=
X-Received: by 2002:a05:600c:1c0b:b0:456:285b:db24 with SMTP id 5b1f17b1804b1-4562e37c48cmr175269885e9.28.1753191126556;
        Tue, 22 Jul 2025 06:32:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4VfzrBEkEfeWiufFOLE286BaOO0byr70jCtKKNW8Ur2B5VV4+73d0ww9UyJaZGf2nUbbPww==
X-Received: by 2002:a05:600c:1c0b:b0:456:285b:db24 with SMTP id 5b1f17b1804b1-4562e37c48cmr175269555e9.28.1753191126026;
        Tue, 22 Jul 2025 06:32:06 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45863a131aasm16633525e9.2.2025.07.22.06.32.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 06:32:05 -0700 (PDT)
Message-ID: <96927022-92d9-46be-8af4-225cab01b006@redhat.com>
Date: Tue, 22 Jul 2025 15:32:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net/sched: Fix backlog accounting in
 qdisc_dequeue_internal
To: William Liu <will@willsroot.io>, netdev@vger.kernel.org
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, kuba@kernel.org,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, savy@syst3mfailure.io
References: <20250719180746.189247-1-will@willsroot.io>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250719180746.189247-1-will@willsroot.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/19/25 8:08 PM, William Liu wrote:
> This issue applies for the following qdiscs: hhf, fq, fq_codel, and
> fq_pie, and occurs in their change handlers when adjusting to the new
> limit. The problems are the following in the values passed to the
> subsequent qdisc_tree_reduce_backlog call:
> 
> 1. When the tbf parent runs out of tokens, skbs of these qdiscs will
>    be placed in gso_skb. Their peek handlers are qdisc_peek_dequeued,
>    which accounts for both qlen and backlog. However, in the case of
>    qdisc_dequeue_internal, ONLY qlen is accounted for when pulling
>    from gso_skb. This means that these qdiscs are missing a
>    qdisc_qstats_backlog_dec when dropping packets to satisfy the
>    new limit in their change handlers.
> 
>    One can observe this issue with the following (with tc patched to
>    support a limit of 0):
> 
>    export TARGET=fq
>    tc qdisc del dev lo root
>    tc qdisc add dev lo root handle 1: tbf rate 8bit burst 100b latency 1ms
>    tc qdisc replace dev lo handle 3: parent 1:1 $TARGET limit 1000
>    echo ''; echo 'add child'; tc -s -d qdisc show dev lo
>    ping -I lo -f -c2 -s32 -W0.001 127.0.0.1 2>&1 >/dev/null
>    echo ''; echo 'after ping'; tc -s -d qdisc show dev lo
>    tc qdisc change dev lo handle 3: parent 1:1 $TARGET limit 0
>    echo ''; echo 'after limit drop'; tc -s -d qdisc show dev lo
>    tc qdisc replace dev lo handle 2: parent 1:1 sfq
>    echo ''; echo 'post graft'; tc -s -d qdisc show dev lo
> 
>    The second to last show command shows 0 packets but a positive
>    number (74) of backlog bytes. The problem becomes clearer in the
>    last show command, where qdisc_purge_queue triggers
>    qdisc_tree_reduce_backlog with the positive backlog and causes an
>    underflow in the tbf parent's backlog (4096 Mb instead of 0).
> 
> 2. fq_codel_change is also wrong in the non gso_skb case. It tracks
>    the amount to drop after the limit adjustment loop through
>    cstats.drop_count and cstats.drop_len, but these are also updated
>    in fq_codel_dequeue, and reset everytime if non-zero in that
>    function after a call to qdisc_tree_reduce_backlog.
>    If the drop path ever occurs in fq_codel_dequeue and
>    qdisc_dequeue_internal takes the non gso_skb path, then we would
>    reduce the backlog by an extra packet.
> 
> To fix these issues, the codepath for all clients of
> qdisc_dequeue_internal has been simplified: codel, pie, hhf, fq,
> fq_pie, and fq_codel. qdisc_dequeue_internal handles the backlog
> adjustments for all cases that do not directly use the dequeue
> handler.
> 
> Special care is taken for fq_codel_dequeue to account for the
> qdisc_tree_reduce_backlog call in its dequeue handler. The
> cstats reset is moved from the end to the beginning of
> fq_codel_dequeue, so the change handler can use cstats for
> proper backlog reduction accounting purposes. The drop_len and
> drop_count fields are not used elsewhere so this reordering in
> fq_codel_dequeue is ok.
> 
> Fixes: 2d3cbfd6d54a ("net_sched: Flush gso_skb list too during ->change()")
> Fixes: 4b549a2ef4be ("fq_codel: Fair Queue Codel AQM")
> Fixes: 10239edf86f1 ("net-qdisc-hhf: Heavy-Hitter Filter (HHF) qdisc")
> 
> Signed-off-by: William Liu <will@willsroot.io>
> Reviewed-by: Savino Dicanosa <savy@syst3mfailure.io>

Please avid black lines in the tag area, i.e. between 'Fixes' and the SoB.

Also I think this could/should be splitted in several patches, one for
each affected qdisc.

> diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
> index 2a0f3a513bfa..f9e6d76a1712 100644
> --- a/net/sched/sch_fq_codel.c
> +++ b/net/sched/sch_fq_codel.c
> @@ -286,6 +286,10 @@ static struct sk_buff *fq_codel_dequeue(struct Qdisc *sch)
>  	struct fq_codel_flow *flow;
>  	struct list_head *head;
>  
> +	/* reset these here, as change needs them for proper accounting*/
> +	q->cstats.drop_count = 0;
> +	q->cstats.drop_len = 0;
> +
>  begin:
>  	head = &q->new_flows;
>  	if (list_empty(head)) {
> @@ -319,8 +323,6 @@ static struct sk_buff *fq_codel_dequeue(struct Qdisc *sch)
>  	if (q->cstats.drop_count) {

Why is this 'if' still needed ? Isn't drop_count always 0 here?

/P


