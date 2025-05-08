Return-Path: <netdev+bounces-188941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8562AAF7C0
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 12:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14B847AAE2E
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 10:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C44A1F5821;
	Thu,  8 May 2025 10:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DPBtOwcU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0124B1E5C
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 10:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746700000; cv=none; b=t2Z//H5oFXzqtpW6F1sCD7dHwQYdzkoDsR0igRtAqhgFeajfXezZchJc8mBdXnpQyvrB8jAaqZdo+z+YkN8hfJJSBgU3yiyt15WDOWY8mz7hK6ucL2jA7tQt/9Qr88G+hGTJ8jmu+uDPSZUMbZzJZRc8eUVB5mFcKUZfJp/+YIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746700000; c=relaxed/simple;
	bh=O5sg1BdVwS+BGVIQFRAuuA3B+8BgbatoZX8uGiY0FZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K4gsG4bCRIV5OqXuM5e9v4QJuaDi3430eHjeHG+60btkZ5xpVNybY3jmYc4GKdfobjPArWdgWyElCxwN4dxuK9XEfq8DqN3VkzRdCMzVwu0pSBo0kyr94o+PqzD7t4vOZFciCZIhxTkTBmj8pVpP0CipLWOFLOytYayI4ZiS6oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DPBtOwcU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746699996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b4GAeEZPp8CdpyBS3JXJkVNkHtqroVKhF9UFtHhwxv8=;
	b=DPBtOwcUr4/tn0RnroCPyESPKoBfS3aaPjT1jt2upJgCcQDcMfy8WpFgo+BlUGPgvLWmiB
	bufYa0LY23v6arujetyZEhZ/NNlmyFYx0MhKOlA6AqnOQJQULLsyyEf/Iss1oCJx5vXARg
	nrOiR8GvYLb0qei1T0c4wqrnU5C1j8g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-76Z_CCwJPgGHk-stwuGbwQ-1; Thu, 08 May 2025 06:26:35 -0400
X-MC-Unique: 76Z_CCwJPgGHk-stwuGbwQ-1
X-Mimecast-MFC-AGG-ID: 76Z_CCwJPgGHk-stwuGbwQ_1746699994
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a0ac55e628so296951f8f.3
        for <netdev@vger.kernel.org>; Thu, 08 May 2025 03:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746699994; x=1747304794;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b4GAeEZPp8CdpyBS3JXJkVNkHtqroVKhF9UFtHhwxv8=;
        b=sPODdLsNQs7exKRbaaZdkI5LXlvYtTC45NI4vlCTevFGQW2xn3FI/ZGwvcjkskev/h
         7eRpAkCPO1RYcUN5I3Hsigq/dTkqOq6oFkWhN+Rpzr7+huSM9PLPksnZIHtcZDBxpdp8
         FoUP4F84cwbvzjeS0ZRL8WeVjlXbnCTxVR4/VqZOQMvxXtFasyZAyMz3d4GArnCiU7q/
         LGgEuEoud+q2VfWnYKNuh9kll5wWwj9e3jjebqM1aurw0TMAW6MpfMz6ew+NHmnFvftk
         JDgMwh5VkCRyJ+1ND+Sqjtnbd2T0OY53BW3HZVbUk0KC0+DaCs9jU4Krw8RT+IyoT6GX
         4B4w==
X-Forwarded-Encrypted: i=1; AJvYcCXb9okkJ3BLCcSPYoZLy779EZJkYZ9DizAGFjDvrkf/Ca7wwQ/tvXno4p9zPYUm5ZHaD7Rh+yQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP4psCPngHHhQgZSGCOALPmTJ8Ssu4o+UhxdCeBbgHEj2u4TWr
	Zh/7R1mZDhysggBQExVw4Ql4pPKUv66W8qth9h2vx+cLrag70WzhfwN4f9gBHwTn1mB7L7X6WNo
	rP2xQAmiWlDcEiHoPeQvtclaNrAnc+mLd+cecYpiAGqv6Y0Cceb04Zg==
X-Gm-Gg: ASbGncutzZRSq2R3hS3tR0YI6lAk7SFuC6n1ueGZK5Hm3ervLNTo9jNp7MRVh38fS87
	PH1uKRCdwAYK8Zsy08xQSifnI2VObyyoLmYv1DEYeJ3pAeKm5+bbOzw6XkXGEPpc+ZXAL2K3DJ5
	iWNA+Roiz8vgt+dasffEvBP+e6Ku44qm4dDlb05yKY7eKg7K5zseU2IoGowrpKWeVHbdb+tRZcn
	EzlBWqWR7jjpIN44Y/TD/kDbDAj5f5Fi0XFMkvajELHXS8PDBh9my3TERamGff9EQdcbq+TCfBJ
	GZb4y7/Cso3Kfq2q
X-Received: by 2002:a05:6000:1ace:b0:3a0:8429:a2e2 with SMTP id ffacd0b85a97d-3a0b4a22cb9mr5617136f8f.32.1746699994464;
        Thu, 08 May 2025 03:26:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG94ERxZ5WyE5e2t5JPzgyvWW3/AfvlPu2y1cqUqf9ltONYcTXbLCYaddar4/JAmCyCYOdq6g==
X-Received: by 2002:a05:6000:1ace:b0:3a0:8429:a2e2 with SMTP id ffacd0b85a97d-3a0b4a22cb9mr5617114f8f.32.1746699994068;
        Thu, 08 May 2025 03:26:34 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244b:910::f39? ([2a0d:3344:244b:910::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a0b6d0e1ebsm4070674f8f.80.2025.05.08.03.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 03:26:33 -0700 (PDT)
Message-ID: <9ad2d46f-7746-45e3-b5c3-e53d079d1b8e@redhat.com>
Date: Thu, 8 May 2025 12:26:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net v2 1/2] net_sched: Flush gso_skb list too during
 ->change()
To: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org
Cc: jiri@resnulli.us, jhs@mojatatu.com, willsroot@protonmail.com,
 savy@syst3mfailure.io
References: <20250507043559.130022-1-xiyou.wangcong@gmail.com>
 <20250507043559.130022-2-xiyou.wangcong@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250507043559.130022-2-xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/7/25 6:35 AM, Cong Wang wrote:
> Previously, when reducing a qdisc's limit via the ->change() operation, only
> the main skb queue was trimmed, potentially leaving packets in the gso_skb
> list. This could result in NULL pointer dereference when we only check
> sch->limit against sch->q.qlen.
> 
> This patch introduces a new helper, qdisc_dequeue_internal(), which ensures
> both the gso_skb list and the main queue are properly flushed when trimming
> excess packets. All relevant qdiscs (codel, fq, fq_codel, fq_pie, hhf, pie)
> are updated to use this helper in their ->change() routines.

A side effect is that now queue reduction will incur in an indirect call
per packet, but that should be irrelevant as it happens only in the
control path.

> Fixes: 76e3cc126bb2 ("codel: Controlled Delay AQM")
> Fixes: 4b549a2ef4be ("fq_codel: Fair Queue Codel AQM")
> Fixes: afe4fd062416 ("pkt_sched: fq: Fair Queue packet scheduler")
> Fixes: ec97ecf1ebe4 ("net: sched: add Flow Queue PIE packet scheduler")
> Fixes: 10239edf86f1 ("net-qdisc-hhf: Heavy-Hitter Filter (HHF) qdisc")
> Fixes: d4b36210c2e6 ("net: pkt_sched: PIE AQM scheme")
> Reported-by: Will <willsroot@protonmail.com>
> Reported-by: Savy <savy@syst3mfailure.io>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>

LGTM, but it would be great if any of the reporters could explicitly
test it.

> diff --git a/net/sched/sch_codel.c b/net/sched/sch_codel.c
> index 12dd71139da3..c93761040c6e 100644
> --- a/net/sched/sch_codel.c
> +++ b/net/sched/sch_codel.c
> @@ -144,7 +144,7 @@ static int codel_change(struct Qdisc *sch, struct nlattr *opt,
>  
>  	qlen = sch->q.qlen;
>  	while (sch->q.qlen > sch->limit) {
> -		struct sk_buff *skb = __qdisc_dequeue_head(&sch->q);
> +		struct sk_buff *skb = qdisc_dequeue_internal(sch, true);
>  
>  		dropped += qdisc_pkt_len(skb);
>  		qdisc_qstats_backlog_dec(sch, skb);

Side note: it looks like there is room for a possible net-next follow-up
de-duplicating this loop code from most of the involved qdisc via a
shared helper.

Thanks,

Paolo


