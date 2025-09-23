Return-Path: <netdev+bounces-225554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9BFB95611
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 12:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 880AA3B305C
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 10:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3074D286413;
	Tue, 23 Sep 2025 10:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fscTTd83"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7709C26E709
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 10:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758621905; cv=none; b=OpQokXn4HHc1iaT1fK6Cp309unPqiHQRKCYOz2xGglgz5HirpFhPotscJ+qBK4R0sSPMuTz0mTA3NoIyx0fqbRjwnDmXPYWT0ight/+9Z4NBSNqy4lsKda2d7hL98YFp9KdzkkLaJLKg2O9W1qNnBW/9rcvYL0vz1u/cp3nxFiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758621905; c=relaxed/simple;
	bh=ZumSwhxH522m/LliPqf9t5tJA+MJDBIhWI+I852334M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pZA+qkeviucOu/64zz2oP06b4aVtaPY/XaNGVv0tQ3xEWAyVKnLTmIgdHDhP7ceKF7uR9g/fPZUHMSbc1njW0De/or6ZjSM5iyT64rVRHg10n3tITl6NWRMN59wB0j5g6Gcg7UFUVnNfTK8bU6aHzXSdKE8WgJVm28sO7QSHoLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fscTTd83; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758621902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8MlXEXY9viVFYgaW7HM7/EGwK4GqnOUp4Wcb/T7Io6s=;
	b=fscTTd83rxPbkWP1sUCnnvULMMOB9UtIprODnFxnmM5LSo7jo/UPtXXr11+iNKLx8jHDxS
	+yueW/YUw7QlUVOTPvSDimmafIWZgxRcRvs7CqFxxGYAkyft0AN0B93alIEs/2vMTkDUAL
	qZArSgEA+Xne/2hf/I5W3wZ7wW+fIaw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-At-NgoYWM2aw3jKt5czWRA-1; Tue, 23 Sep 2025 06:05:01 -0400
X-MC-Unique: At-NgoYWM2aw3jKt5czWRA-1
X-Mimecast-MFC-AGG-ID: At-NgoYWM2aw3jKt5czWRA_1758621900
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46d46692831so12803905e9.3
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 03:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758621900; x=1759226700;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8MlXEXY9viVFYgaW7HM7/EGwK4GqnOUp4Wcb/T7Io6s=;
        b=o7CBoed77FdKApWQ+yu2HziovL5IBKMSSBEOGiPoGLE5kJFd15LYkn+xeUe+9o2CuB
         xmqfLiNlKrSRMysCL5dkvcmC6X2p3q6aH8kKLc4H5a36TiQuZI3o95Jqm0iVJrgC5Ubj
         sSoFXfJ1sjN8Ys1ZYRkqNAKOtgvYybrlMJ/Kc4uA9u5BnpuLcMevhNyynNyd/YdczDyn
         8UiMLxhYjeYQ+sU8z5OdnytdeBW5rdeMYJBi7c8DOhjE05pGdDFF8zwpB3b1/pWsQliT
         iCI3iJV+Rr2nQy2JfUR0GMVGBAs1dzCcp6taYQAw40RCHAMDqly8Ro5GazTImSZle49C
         vy6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUIbH3UqCuDXnOKHXB6kMIeJtQc9qBCxsyso6aezgZj0iIP3JWfpHXKaYzteBOOqdP+TggABeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaqtV8KZUN5pt1bMPm869kIM+5I9uky1ZSo+wICLyPMJ47Zkk3
	fC32brkLkjX5wyqRCI38t5JPTT+2Ue5OftzXrAU/FcZKHCF025HI+bRM/XaxGcvp4uR9Rd734up
	tN/YcDusfnEIkyEKA8yoLD6hb9QtwPpx7S2rIgEh5GLgUdYpj5b/izTAP7Q==
X-Gm-Gg: ASbGncu+L+CJCFiAipteGrDqMRwu4yX1+Xn+WabxcRrlrKXupLRWKCogubjpm7aUMQ4
	QZ0s8ZFT2tJIqkWSo8UUZkPUYmrEVQKM6DpqC7Hj8i6Dp7+KzymiKQ4Y3IRoaZkcSY5HQFRgWGg
	n4OhM4qnDx2170eVOt4IWoxFliuhXCbcPPDaVaWeCYOwifOnzLed1DgwQtVTlOtO2bT8xBjVFhl
	b8ciKiXIZ4xcbFHamnOBgf/NXPpazIu13Gg65ryjFvKZ8v0aJByC8vYXWUj10eHZXi0RX5o2WJB
	6kaYbL3Mxq8o/gaRmsCdtOKB53OxfsPV2gkkDKxzGhggYOyvi2Xhv29VJvKN96e+c9a4kYldb1s
	rElCxhDAtJxNM
X-Received: by 2002:a05:600c:c8a:b0:46e:978:e231 with SMTP id 5b1f17b1804b1-46e1e0aec9bmr21981395e9.17.1758621899782;
        Tue, 23 Sep 2025 03:04:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI25GAUzFMzn1I18q3eiplupnGbcDgSnNTWVjo5qrpHHjC0ezlLXo+X0Ba4DizXVJNpGvdsQ==
X-Received: by 2002:a05:600c:c8a:b0:46e:978:e231 with SMTP id 5b1f17b1804b1-46e1e0aec9bmr21981025e9.17.1758621899350;
        Tue, 23 Sep 2025 03:04:59 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-403ec628ff7sm3599419f8f.4.2025.09.23.03.04.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 03:04:58 -0700 (PDT)
Message-ID: <476c5c79-bc37-4c41-865d-d04d1d6974c4@redhat.com>
Date: Tue, 23 Sep 2025 12:04:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 04/14] tcp: L4S ECT(1) identifier and
 NEEDS_ACCECN for CC modules
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Olivier Tilmans <olivier.tilmans@nokia.com>
References: <20250918162133.111922-1-chia-yu.chang@nokia-bell-labs.com>
 <20250918162133.111922-5-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250918162133.111922-5-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/25 6:21 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Two CA module flags are added in this patch. First, a new CA module
> flag (TCP_CONG_NEEDS_ACCECN) defines that the CA expects to negotiate
> AccECN functionality using the ECE, CWR and AE flags in the TCP header.
> The detailed AccECN negotiaotn during the 3WHS can be found in the
> AccECN spec:
>   https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt
> 
> Second, when ECN is negociated for a TCP flow, it defaults to use
> ECT(0) in the IP header. L4S service, however, needs to se ECT(1).
> This patch enables CA to control whether ECT(0) or ECT(1) should
> be used on a per-segment basis. A new flag (TCP_CONG_WANTS_ECT_1)

I find this description confusing/contradictory with the implementation
where TCP_CONG_WANTS_ECT_1 is actually a mask.


> @@ -1322,6 +1328,18 @@ static inline bool tcp_ca_needs_ecn(const struct sock *sk)
>  	return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ECN;
>  }
>  
> +static inline bool tcp_ca_needs_accecn(const struct sock *sk)
> +{
> +	const struct inet_connection_sock *icsk = inet_csk(sk);
> +
> +	return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ACCECN;
> +}
> +
> +static inline bool tcp_ca_wants_ect_1(const struct sock *sk)
> +{
> +	return inet_csk(sk)->icsk_ca_ops->flags & TCP_CONG_WANTS_ECT_1;

Should the above tests be:

	(inet_csk(sk)->icsk_ca_ops->flags & TCP_CONG_WANTS_ECT_1) ==
TCP_CONG_WANTS_ECT_1

?

Otherwise existing CC with TCP_CONG_NEEDS_ECN will unexpectedly switch
to ECT_1 usage.

[...]
> diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
> index df758adbb445..f9efbcf1d856 100644
> --- a/net/ipv4/tcp_cong.c
> +++ b/net/ipv4/tcp_cong.c
> @@ -227,7 +227,7 @@ void tcp_assign_congestion_control(struct sock *sk)
>  
>  	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
>  	if (ca->flags & TCP_CONG_NEEDS_ECN)
> -		INET_ECN_xmit(sk);
> +		__INET_ECN_xmit(sk, tcp_ca_wants_ect_1(sk));

Possibly a new helper for the above statement could be useful

/P


