Return-Path: <netdev+bounces-128914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B81997C68A
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 11:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E06DC284F52
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 09:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AD919924F;
	Thu, 19 Sep 2024 09:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G77X70fw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41AF199259
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 09:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726736758; cv=none; b=phGYXVUHq/iXHdyEpRQ2TDNQFkXxCzanaehDz+4Y2Z5fvGPg8nA+YB9t3e5Ei68551ZYDOVaEt0OJmphFFvAFvJMoUDIeXGYXr+A7VGm1xyxGnflb+rNckbLoVq0TIH1U4adXvrXWl1D/95CR17vE9YGAg/oauAKoj9vHXJH3ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726736758; c=relaxed/simple;
	bh=VWWBTcxk4hORGaLkX+0fM//HV8ZJSc6yfLE5/ZxEq80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KsXTYWIoq8XxZqzjk4BYcATYra68icA0NrT+znLnQKMRzHyBu310nawu3zg6w1dxIZfZDgDlynyP66+D5GKSVUiOhs1A6IKxyf7cfgAZqTtHjzoYqOfbtcArNq+SgheVMXxkjx8+nS7APDrBVAFNy5yGxyJpiCZGd6MDm0Du95g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G77X70fw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726736755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nnex9kdS8NwvyPRASviDUdMuudMC1PvpZvkVEh7NFiQ=;
	b=G77X70fw1ZBdLXOQuqT2yRDDz+2ZHNw+pwIJISNQbF6uLlUibLXH0Pp9LqxprOsi3qkHs8
	gBGOH7roApUfKQBoBnP9ewtPbzSYa/xkD0k+Cnb+yrb7q4h4LE3VKmJ13CUXgtUrfWzSlM
	Xpy1C7YvmAqA8jiItyqjD6TgpqGz0R8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-W3J0_XpmN6y2V23Fr9MjLg-1; Thu, 19 Sep 2024 05:05:54 -0400
X-MC-Unique: W3J0_XpmN6y2V23Fr9MjLg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-374cbbaf315so298858f8f.0
        for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 02:05:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726736753; x=1727341553;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nnex9kdS8NwvyPRASviDUdMuudMC1PvpZvkVEh7NFiQ=;
        b=vs6C6iSuDrYPWyYOBtwyiAV3ZWs+R4aTxgcDUigpaBIFqNFPPmNcR30sE7MsZE8Slm
         rEFZpSSyq6YYgCydT5YnvyAdx2XOVYmwVT5dyOugCjB4Zfwsx0NE//rw3MoAvkyZouL8
         AD5mM6yaMSjK5isft8h2GnkpEE0PiaTQJmTse9YOGxpnWha7T+hVrcESHOfhFRQl41ZB
         nqu3PP5KHOoEYX0HwxncVeZpxI2ilvSuVYPqUs/uAQ/mtS9s+e8u9j6pJ0EvGxLNnvGG
         ogBKpSCHDyYFWqkLIB1M030nzs+vToNPH/Wbf3l3gqIFLOlHEoHjn29XgLQTrYZyJWTe
         oikg==
X-Forwarded-Encrypted: i=1; AJvYcCWmeMr6lrhVRu9j39bMVM0yyGwK38nSZg0jBbgMnbxsIvw89Gp3pCDQqxz9FLxE08TjRPfsNWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvv7AmG6/5XTCi04cUMfJYrBTZ2wLyi9m0L/TiOgY4weXCzM6G
	2/JIeFWCIy9kuwbRt78hM+K6TMJaFBYRVZibP4tpVCm79FBLi4l/QujHWYd9XirWBjv1X/bxA6x
	N2KzkHxPQ4AAf/XP99SGqvpcmb1Y66hI4cgo9kVSaoJwDmERHkRCS7g==
X-Received: by 2002:adf:f94a:0:b0:374:ba78:9013 with SMTP id ffacd0b85a97d-379a8600601mr1235067f8f.9.1726736752931;
        Thu, 19 Sep 2024 02:05:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiXJ8EJ3vg1Ccjo7Mce+fhOayPgntM0rtjBpNHJcnp36weYWGzu7OgB6+gevN/ScNecv4iQA==
X-Received: by 2002:adf:f94a:0:b0:374:ba78:9013 with SMTP id ffacd0b85a97d-379a8600601mr1235046f8f.9.1726736752518;
        Thu, 19 Sep 2024 02:05:52 -0700 (PDT)
Received: from [192.168.88.100] (146-241-67-136.dyn.eolo.it. [146.241.67.136])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e80eesm14456762f8f.30.2024.09.19.02.05.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 02:05:52 -0700 (PDT)
Message-ID: <5632e043-bdba-4d75-bc7e-bf58014492fd@redhat.com>
Date: Thu, 19 Sep 2024 11:05:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] tcp: check skb is non-NULL in tcp_rto_delta_us()
To: Josh Hunt <johunt@akamai.com>, edumazet@google.com, davem@davemloft.net,
 kuba@kernel.org, netdev@vger.kernel.org, ncardwell@google.com
Cc: linux-kernel@vger.kernel.org
References: <20240910190822.2407606-1-johunt@akamai.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240910190822.2407606-1-johunt@akamai.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/24 21:08, Josh Hunt wrote:
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 2aac11e7e1cc..196c148fce8a 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2434,9 +2434,26 @@ static inline s64 tcp_rto_delta_us(const struct sock *sk)
>   {
>   	const struct sk_buff *skb = tcp_rtx_queue_head(sk);
>   	u32 rto = inet_csk(sk)->icsk_rto;
> -	u64 rto_time_stamp_us = tcp_skb_timestamp_us(skb) + jiffies_to_usecs(rto);
>   
> -	return rto_time_stamp_us - tcp_sk(sk)->tcp_mstamp;
> +	if (likely(skb)) {
> +		u64 rto_time_stamp_us = tcp_skb_timestamp_us(skb) + jiffies_to_usecs(rto);
> +
> +		return rto_time_stamp_us - tcp_sk(sk)->tcp_mstamp;
> +	} else {
> +		WARN_ONCE(1,
> +			"rtx queue emtpy: "
> +			"out:%u sacked:%u lost:%u retrans:%u "
> +			"tlp_high_seq:%u sk_state:%u ca_state:%u "
> +			"advmss:%u mss_cache:%u pmtu:%u\n",
> +			tcp_sk(sk)->packets_out, tcp_sk(sk)->sacked_out,
> +			tcp_sk(sk)->lost_out, tcp_sk(sk)->retrans_out,
> +			tcp_sk(sk)->tlp_high_seq, sk->sk_state,
> +			inet_csk(sk)->icsk_ca_state,
> +			tcp_sk(sk)->advmss, tcp_sk(sk)->mss_cache,
> +			inet_csk(sk)->icsk_pmtu_cookie);

As the underlying issue here share the same root cause as the one 
covered by the WARN_ONCE() in tcp_send_loss_probe(), I'm wondering if it 
would make sense do move the info dumping in a common helper, so that we 
get the verbose warning on either cases.

Thanks,

Paolo


