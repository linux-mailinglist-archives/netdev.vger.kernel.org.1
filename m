Return-Path: <netdev+bounces-198522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D92F7ADC8FC
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 13:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B679162B11
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 11:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9767421882F;
	Tue, 17 Jun 2025 11:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EYDy7cpD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7FE18DB35
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 11:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750158064; cv=none; b=IKzfyEN5knLt/sXfUfEdy3Nmx9hf6Ykv6xocYB3rhznQFnqFkH34S1xMNAnVaSjJCQLSH0AeYE7SvGuB6WoyAFZIuAXpb5Q7j4Dc1iuLDaGz9X5SZTztshmiTxVDA80wT8Fuc5okGWgS70ExAZ1uthNQwvhaMclziikIx+8pNnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750158064; c=relaxed/simple;
	bh=Jy4lsrusakvX9u6DHHyu1tpppoeRSJrKpQOBCTREiTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=co9BQDRY9uls7H7GCcPw6hFLO1KaRPa9X+K0AtYcORoCUcYjszfTnlckpMN0EKTTIfU+vZbj2zOrTAPkv7YvZtsjV1fde2Wq4wIV3kzSUhy6n4/6YVLDceoGekn9nVUYlxBZDgDrO7PPmdIkB/YsRCwpCkiwOekRtrlOfFeDiAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EYDy7cpD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750158062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rPzSBRIX8lNbzruQuHcxrBhpa2JtXIadSLv81sT6P6c=;
	b=EYDy7cpDrgaCGg/tJGq+XbyEjVsSqBEJJBlJKbxdXMwLo2hbxZk3H+siw7UmFeOEmF2+lu
	+at1R+tHFcEUvbTR+PTMCnOctSzbBVfEHbQpvLI0Oq6LvuXcSr1ZyVpT3qja+/ZVFXpOYo
	fvwx1wXooflVwfSRLmACF4j23l220DE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-aYMmxNYsMqi_jlTozl0kRw-1; Tue, 17 Jun 2025 07:01:00 -0400
X-MC-Unique: aYMmxNYsMqi_jlTozl0kRw-1
X-Mimecast-MFC-AGG-ID: aYMmxNYsMqi_jlTozl0kRw_1750158059
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a37a0d1005so3357207f8f.3
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 04:01:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750158059; x=1750762859;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rPzSBRIX8lNbzruQuHcxrBhpa2JtXIadSLv81sT6P6c=;
        b=no3PCX+yipG7BEtgVyp7dr2Carti949KBMWotz1c1YxTfcVNfIG7lwzeTBfqNXwNpm
         8wgMqFymGwHsLwUj7MNOg3lesl797NV04sSCPcckHeyUoDJNDIOXG0z/tY/QpljBsm4z
         deEZ+WxLJnBUCrMYSE7e9vI1wcI/wxj9+f2mKt0SGy+FEGDqd9hE8xLg1uQKI4HPCn0R
         hgzwm7O5C3rTOjQaxBcEnVoNfwcpqJl11hpsQ5yZL/xLJCxt7GXCt4lpN+/ZRJ23Bd6w
         7yUpF8KcSPwCzCDAqThsyDhdXvDIErGCcnW7U3EQ2VO6LXR5IToy2y/Tdnyq7fRMIf9X
         +tIA==
X-Forwarded-Encrypted: i=1; AJvYcCXAvc0whVrcWgmg7GaF2S47zOt52RGawTkEKAi0v2W2Cw+1G4xaVdUrJNd8Qxh7nRo1cEXEfrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZpCr3kfpuFdrIOyoNDCGau2axr0/pp3Ykb0ZTQp5gQiXfiIlS
	CA1zaDItjzZ0/Qj6GoYvXzdSCyF4AInKIZd5yYM/9keLcPyAL9Ioraw2kSJX2HE/8L1OGHvWFxJ
	ef1POklKGzFNusayG/4EIey8ENQ84QTHOacB6NiZ1BCLZdFVaOL1fABzMRg==
X-Gm-Gg: ASbGncsMM3pl+adzmgNnVRVHHylTY46mK/BFPRW3CEO289z2Ct8dm1KVvkKyeFylp+f
	3kT/PBhAGKm6LvgndkNVirQOhm/HykJC6uXPu1jan4jifIR8IofnhO0YhVZ8cKhy67f7Gsz7tj7
	ZwHPyburbY1EZ3QFe2Y96CeIpjbOPnijUE0SQWivkPwcf8iWqagFOlSZ8zBv3YnoXfVoJMjE0HY
	DCkF2oLgvrILCXHaGNsELvlCgX9c/YS2d3vRJy8nijbBFm2WIsdq9qGHGOnxXdx1JyeGxjuWlML
	3mLmmKfN5QJx1Bemwuelk7FwDKmIZXjbHJ0ITfivvzdDVAuRHVvP33ov9agmuYqLRK4Qlw==
X-Received: by 2002:a5d:64ca:0:b0:3a5:34ea:851e with SMTP id ffacd0b85a97d-3a5723a15ccmr11339942f8f.25.1750158058552;
        Tue, 17 Jun 2025 04:00:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCaVw5kHOpYYCnYDEK29xi4S4qdkGakFHB4vHzCbXbbNO46yHFb/HC43oPZrbhbnAnFGzcRw==
X-Received: by 2002:a5d:64ca:0:b0:3a5:34ea:851e with SMTP id ffacd0b85a97d-3a5723a15ccmr11339824f8f.25.1750158057393;
        Tue, 17 Jun 2025 04:00:57 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2448:cb10:3ac6:72af:52e3:719a? ([2a0d:3344:2448:cb10:3ac6:72af:52e3:719a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b087a9sm13905989f8f.55.2025.06.17.04.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 04:00:56 -0700 (PDT)
Message-ID: <da990565-b8ec-4d34-9739-cf13a2a7d2b3@redhat.com>
Date: Tue, 17 Jun 2025 13:00:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] tcp_metrics: set maximum cwnd from the dst entry
To: Petr Tesarik <ptesarik@suse.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 "open list:NETWORKING [TCP]" <netdev@vger.kernel.org>
Cc: David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250613102012.724405-1-ptesarik@suse.com>
 <20250613102012.724405-2-ptesarik@suse.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250613102012.724405-2-ptesarik@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/13/25 12:20 PM, Petr Tesarik wrote:
> diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
> index 4251670e328c8..dd8f3457bd72e 100644
> --- a/net/ipv4/tcp_metrics.c
> +++ b/net/ipv4/tcp_metrics.c
> @@ -477,6 +477,9 @@ void tcp_init_metrics(struct sock *sk)
>  	if (!dst)
>  		goto reset;
>  
> +	if (dst_metric_locked(dst, RTAX_CWND))
> +		tp->snd_cwnd_clamp = dst_metric(dst, RTAX_CWND);
> +
>  	rcu_read_lock();
>  	tm = tcp_get_metrics(sk, dst, false);
>  	if (!tm) {
> @@ -484,9 +487,6 @@ void tcp_init_metrics(struct sock *sk)
>  		goto reset;
>  	}
>  
> -	if (tcp_metric_locked(tm, TCP_METRIC_CWND))
> -		tp->snd_cwnd_clamp = tcp_metric_get(tm, TCP_METRIC_CWND);
> -
>  	val = READ_ONCE(net->ipv4.sysctl_tcp_no_ssthresh_metrics_save) ?
>  	      0 : tcp_metric_get(tm, TCP_METRIC_SSTHRESH);
>  	if (val) {

It's unclear to me why you drop the tcp_metric_get() here. It looks like
the above will cause a functional regression, with unlocked cached
metrics no longer taking effects?

/P


