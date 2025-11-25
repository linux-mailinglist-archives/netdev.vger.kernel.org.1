Return-Path: <netdev+bounces-241339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5B0C82E62
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 01:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D2134E1367
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 00:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DC02248AE;
	Tue, 25 Nov 2025 00:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6+yGIeZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5507721CFEF
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 00:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764028824; cv=none; b=bW9bGAWVwaGJJdIFnPXa1GP4Rjp5DgX6yt8FjxfOcJYECiRXVLX9PuQb9uu/hsYSoRvKA7GmFuXle2VfbwH+oNnv00jGaEVH8emz9K1ry/HxBVIfGZD4Immn3C/9TsxfJXDBKed+Foc38QG2Ggge8ziyH4nekY2xn3s8wOabhMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764028824; c=relaxed/simple;
	bh=ax8urSg7fqw7nr5dZkgyVnSLAhBlcntsxEktfY1JNC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f3aunkzPhJNguppBV9KuFyKcQNvbRKQgiIfyudJipp5G2X+4F4kbrs+8RLaSwTyHfJhTBbVpBTefcKBXZRtuo4ydPRlavSJJUbH3Ldh2+I7BS97KSospnsK1H19OQU1CQq2fUSFJiZK/XqsJTyX7C40gY5+gZU6OthN+Z+K8XJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6+yGIeZ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-340c39ee02dso4184801a91.1
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 16:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764028823; x=1764633623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/pVSZbIbwK3ksgyy/+zRVxCJy1ucujLDzjuOppCJkcY=;
        b=C6+yGIeZKeWBmkC/KAUmBhUBlMVPgwDlwImo4LZdUmfcfFXGEv3z6A+/6tbfTgqCk3
         ZTgUEpBwBJQ68xPTjVo3EXuY6T820927xeXC5eX1ekeCsdalh672aGv0BmPzZwII0Q80
         J1Z3ZUwbeaIpL4AhKbP5en+QKGE8/SbFDY5Wu/Pxx84Z6i/awGE85zYrrceUiqndT455
         rNyJ/ZSHLCBEzSeqs3CtjKhXyMfE/pfsIZ+OoGET2l7PQnd0G6aAs2YTquR0sj1/OjVa
         wmOEAnCFuiysFqSVEf7HfeN7zAOUUaBW4awDnZzt4W5SxN0X1SPfnSjX8Qfx3pWiKeh9
         OPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764028823; x=1764633623;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/pVSZbIbwK3ksgyy/+zRVxCJy1ucujLDzjuOppCJkcY=;
        b=gQcKbjC9/z+qeGlSEUBBcZC1UNIy42WV6aKCcx7tK4wuzAnn0VGqIDxq5vxTVCuD6k
         G13+h2R7CV0tqCb/0Zh21hdhn1yz0pV9BbyOTG3Y4Z3bbLHvEFKeNPk+Y+uvCRYbn987
         uJ4JwsdQzTDU3ZzCBsLTJZA2xgxJTPyvF6s4hAdUsGAYJeiZcZ4a9bTVXiNPc13cA3SP
         zPCV8e5cEUKvxWPTUMevuKG0NK4J/WK0rV8dUFIwLptwkneJGwtrW8VKYsjIk4Xq/yiI
         LkGYJk+I0BaKNDJT+w4dLOLhZEoOi8R0iAVPQ1L79eUTFRKqK5k/j38l4Eu575wRFJcc
         W/vg==
X-Forwarded-Encrypted: i=1; AJvYcCUw8YZS8va4t8+y1u7FtU0LhVmWrhyOJxndverxES2DD9ainLRQ4NGq60tMZCTFlyWBDyr+WY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWFcKeccFvaoyUyDbavbRfF6VHmdS2Gt2LCnk7RjFw3IOhTzVn
	gb4P+bxxhhUvCT+crmbn4oxnkM2mELiVp3JSFkDIk8s7li1SjZNZL7CB29iO4w==
X-Gm-Gg: ASbGncuL8Z6F1R9iiIdyjYB3Rsy9sssFcZ1iLMszwkNB5C2Av5wBVwW6WP0f1y9XTXO
	m0G/qVgTeJNPQlC0/P2sHzyt7pJBfdpB7hYVGXrfTeAe/EtFSRHaXKaSCSuSl/Us80zpOnqUDpJ
	4KxOwIPOTdsqsuHl6YTz73UHVCWALLCzCm7cD7nQHeSNlr9YRdCtXb74ohuKohqBKMBtqO1oXh7
	24WsTR5rmMgz9Dgy82cpJnGbmDVta26aBxShHp2p8hWPe+/pw3qz0Z9VhLoSig/+9uOihfo5/TW
	v5tWdSgRcgd7bCWhTyxXzDuDrNO9OQreZmgmIv5vWLs6/BRso5rlw3X89HPJm6X7LH1+i481rzz
	coYNN9oc+7urV4iTSiHPlEjsDFQYCQlWYydUBFwHGvFAR8nZjqSxDstT/7bOFGJ0qm+6X4x7tyY
	q2a2fHnbS0kUZcVU9PWItqKNX7Ahdv
X-Google-Smtp-Source: AGHT+IGIhr1pB+Rkutrj3UKpogob8iv40eeW+eBzxKe3lgSkjClNZaTI0ECS7qofsN+gwze8tI4PbQ==
X-Received: by 2002:a17:90b:224e:b0:33e:2d0f:479b with SMTP id 98e67ed59e1d1-34733e4683cmr13777752a91.6.1764028820913;
        Mon, 24 Nov 2025 16:00:20 -0800 (PST)
Received: from [192.168.21.44] ([65.153.131.115])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3475fdfccfdsm133145a91.2.2025.11.24.16.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 16:00:20 -0800 (PST)
Message-ID: <fb5fc99e-fa3b-4499-80be-4731a8c7a297@gmail.com>
Date: Mon, 24 Nov 2025 16:00:19 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] tc: cake: add cake_mq support
Content-Language: en-US
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: cake@lists.bufferbloat.net, netdev@vger.kernel.org,
 =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>
References: <20251124-mq-cake-sub-qdisc-v1-0-a2ff1dab488f@redhat.com>
 <20251124150350.492522-1-toke@redhat.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20251124150350.492522-1-toke@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/24/25 8:03 AM, Toke Høiland-Jørgensen wrote:
> diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
> index 15d1a37ac6d8..fb07a8898225 100644
> --- a/include/uapi/linux/pkt_sched.h
> +++ b/include/uapi/linux/pkt_sched.h
> @@ -1036,6 +1036,7 @@ enum {
>  	TCA_CAKE_STATS_DROP_NEXT_US,
>  	TCA_CAKE_STATS_P_DROP,
>  	TCA_CAKE_STATS_BLUE_TIMER_US,
> +	TCA_CAKE_STATS_ACTIVE_QUEUES,
>  	__TCA_CAKE_STATS_MAX
>  };
>  #define TCA_CAKE_STATS_MAX (__TCA_CAKE_STATS_MAX - 1)

uapi changes should be a separate patch that I can drop when applying.

> diff --git a/tc/q_cake.c b/tc/q_cake.c
> index e2b8de55e5a2..1c143e766888 100644
> --- a/tc/q_cake.c
> +++ b/tc/q_cake.c
> @@ -525,7 +525,6 @@ static int cake_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr *o
>  	    RTA_PAYLOAD(tb[TCA_CAKE_FWMARK]) >= sizeof(__u32)) {
>  		fwmark = rta_getattr_u32(tb[TCA_CAKE_FWMARK]);
>  	}
> -
>  	if (wash)
>  		print_string(PRINT_FP, NULL, "wash ", NULL);
>  	else

why remove the spacing? whitespace helps readability.



