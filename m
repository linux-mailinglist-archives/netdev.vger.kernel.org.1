Return-Path: <netdev+bounces-184805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45292A97403
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 19:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11FDA3A70E8
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 17:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79BD290BC5;
	Tue, 22 Apr 2025 17:52:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7969219F42C
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 17:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745344370; cv=none; b=cV0CzJH80P7sw90vKDc7XdO8qK47j27H1YMB/mTgTZLEehzCgypLaRnU5lUZgdSzhwGdBVaCCdMEx6uZRLUAaEH1CjR9v61FAjiU4rxHv7GU7UwODsGqu3bdKkDF3+SDFMDCep0xovwfEyk3zS6da5hKLZOb3bJK7Fy88i0lnbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745344370; c=relaxed/simple;
	bh=MOLmDAOO1CE3zG1odqQiLK+uVB8Jn3ZNcsK+kezwbLk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=i8sH1nNp0uFSjAVa9GXO09kZuxkz3TnTGRTJAaccUcAysRrHp/yJp23qvSttzNDWC3cNvUfEzhgX1hNcsHG0HVJllAWu7v7IF0aGgGWJIUjzf4tafrZDgMB+x4MxRSNSksdXn+RgjmAnjB+i9zBnpxCYYAIb//oBgZqzNTpuCoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-39129fc51f8so4692099f8f.0
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 10:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745344367; x=1745949167;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKt0zxRJs2mpAJB34yomFh6UpX9YLkVDM20kVIrhWGI=;
        b=EoeFu0nlelY5kRL9rXj4xG0r0ufDDEP3aRy1GvKKf2LyggH6ukSaqqMYKpHMWrdUIk
         X5p0pjrbfDU77QUJcqgguommwz3ob9G1QRF9TbuvxwYUZRZpHK43OiSiYi/2icHd8dn7
         0HICmrGKYMHZQy4pNKc2lafvKydWV8svrSP7GjahPylDPaUwE31lIwFThYkB7aolfd5e
         ol4xKYl8g5a+NIv5/aq5Se0rjms4w5PBzGzQjkscZNB9T4TQ2X6TmYT79GbpGCQEkeAq
         HuPPuVZDxSIYUU00CDfZDy4aKmV9ml05Gmn1hjJHo0VM9bjvEDgiflW8EYGcbMFjqIDY
         Aodg==
X-Forwarded-Encrypted: i=1; AJvYcCVYS9TRDO3eg8aYciZGgK5IfCv874e4xe1vsKdwrjmKogr7/PwRU0UrtviGH1eOCSRTEdYceN8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2y+RnpW9IHn/l/FDNBboLYKkJaZ+y7xVFnxpCtxyhSFL51ML+
	k6yiDytoyOz8DOwYZIQGvCb4z5B59T0dwqMZzZQZFdjegkskqY4q
X-Gm-Gg: ASbGncvN1UcI1dwHzg4cbrZZ1wJunlXh391V/o3aurUKX09BT3S8ObOsdqqueXJmEn7
	XP+WlGqTGbcergVHl/R8KUumZS2Y5Ien/hos5sVvrEr3RHa/8+2yOYYvb2slp69MFO6oWuVrHYr
	kRwhLJK4wGYrPd3KLMoGEo7+TV/TsCwFU3+tY2vgbDfyoRuLo3PMfuWMF/3NNzh3pVHAxUn1et6
	OpyNfgmhmiQuFkw03NwTbAJGGEO4qqY5lYbj6ixIYZi+weD3LqKAfns27iLQuvIdFdA7lenh3U5
	0zHtyZte+WqUQ7GzFySPxESihQvecipN30RRQhgHO1pFxNz2LrcWAk335uJSbZ4PkOsVTaJvF0N
	G2BvGqlU=
X-Google-Smtp-Source: AGHT+IE2F/DyKTn4eDps421JdlgQvRNaa20pJRmv84T8Fqt1mwn5II8Hd+dkuUI7jsDo6hWm7rqlBg==
X-Received: by 2002:a5d:5987:0:b0:39e:e438:8e4b with SMTP id ffacd0b85a97d-39efbaf6e96mr13137621f8f.50.1745344366475;
        Tue, 22 Apr 2025 10:52:46 -0700 (PDT)
Received: from [192.168.88.252] (194-212-251-179.customers.tmcz.cz. [194.212.251.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5bbc81sm179193525e9.19.2025.04.22.10.52.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 10:52:46 -0700 (PDT)
Message-ID: <72dd193a-99c3-46bd-8263-1502e910b725@ovn.org>
Date: Tue, 22 Apr 2025 19:52:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, Eelco Chaudron <echaudro@redhat.com>,
 dev@openvswitch.org, netdev@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] openvswitch: fix band bucket value computation in
 ovs_meter_execute()
To: Dmitry Kandybka <d.kandybka@gmail.com>, Aaron Conole <aconole@redhat.com>
References: <20250421212838.1117423-1-d.kandybka@gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20250421212838.1117423-1-d.kandybka@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/21/25 11:28 PM, Dmitry Kandybka wrote:
> In ovs_meter_execute(), promote 'delta_ms' to 'long long int' to avoid
> possible integer overflow. It's assumed that'delta_ms' and 'band->rate'
> multiplication leads to overcomming UINT32_MAX.
> Compile tested only.

Hi, Dmitry.  Thanks for the patch.

It's true that the overflow is possible, however, it will only occur in
cases where meter configuration doesn't make any practical sense, e.g.
when the rate is very low, but the burst size is comparable with U32_MAX.
If the overflow happens in such a scenario it shouldn't cause any real
issues for the traffic, since the original meter was not really enforced
in the first place.

But I agree that the code can be improved to avoid mixing different types.
There is another potential overflow in a way max_delta_t is calculated,
and that is directly related to the overflow here.  So, I'd suggest
instead of just adjusting this one place, move all the internal variables
that can overflow to u64 and get rid of signed long long int usage by
comparing values before subtraction.  i.e. convert band_max_delta_t,
max_delta_t, delta_ms, now_ms and max_bucket_size into u64 and get rid of
the long_delta_ms.  Keep all the checks, obviously, so the math stays
the same.  Types of all the variables that come from uAPI should stay
as they are.  Such unification of types should help avoiding any potential
overflows.

While at it, may also optionally convert all the local 'int' variables
and iterators that store or walk over n_meters or n_bands to u32/u16.

Best regards, Ilya Maximets.

> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Dmitry Kandybka <d.kandybka@gmail.com>
> ---
>  net/openvswitch/meter.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/openvswitch/meter.c b/net/openvswitch/meter.c
> index cc08e0403909..2fab53ac60a8 100644
> --- a/net/openvswitch/meter.c
> +++ b/net/openvswitch/meter.c
> @@ -594,11 +594,11 @@ bool ovs_meter_execute(struct datapath *dp, struct sk_buff *skb,
>  {
>  	long long int now_ms = div_u64(ktime_get_ns(), 1000 * 1000);
>  	long long int long_delta_ms;
> +	long long int delta_ms;
>  	struct dp_meter_band *band;
>  	struct dp_meter *meter;
>  	int i, band_exceeded_max = -1;
>  	u32 band_exceeded_rate = 0;
> -	u32 delta_ms;
>  	u32 cost;
>  
>  	meter = lookup_meter(&dp->meter_tbl, meter_id);
> @@ -623,7 +623,7 @@ bool ovs_meter_execute(struct datapath *dp, struct sk_buff *skb,
>  	 * wrap around below.
>  	 */
>  	delta_ms = (long_delta_ms > (long long int)meter->max_delta_t)
> -		   ? meter->max_delta_t : (u32)long_delta_ms;
> +		   ? meter->max_delta_t : long_delta_ms;
>  
>  	/* Update meter statistics.
>  	 */


