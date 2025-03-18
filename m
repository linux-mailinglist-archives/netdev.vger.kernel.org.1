Return-Path: <netdev+bounces-175722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 829DFA6742F
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 13:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B638D188A3C4
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 12:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A92F20AF88;
	Tue, 18 Mar 2025 12:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="glaTmyIq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F0B207665
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 12:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742301883; cv=none; b=NlL1TOcQwn9DGFodOkWojnK0+VYe43qodk8UJ+ZZ80STXrLJ2oHAqNk3fHvND8guQi7l5dJ7MRi3n1da+w+4DD1g0YavRAcob0o4a813Gn+5rNBTFMgJos907bezQwAbYyrfwNsH2kS+Fe0LrKni0zDMb9xGY8u2YjDuPjyo4Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742301883; c=relaxed/simple;
	bh=TcE5RgtDuXqJEV3XpB3g+eQU06ePl12P8xQrVepC3Rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LaAPo+gGbtEy7ouokvs6VVo88taU8lmfXTjAn+GHQoqiQwG9MEuPZxUB1zyxRB8BaJxV41cYCTceI5U6r8C/ybKIeFPApgMFOBjVak0Ay5kdSSUTSzQXKmhjQIj6QBvzlrlEN59PIA3IqZRszP/Fkj3eRkGkD5hFa8BtK7pApwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=glaTmyIq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742301879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rmx6lMq9SxqwiLRc4324IBVrgzXkGFnSj4EmSTHL05Q=;
	b=glaTmyIqJmQi7TrqOdQj6ENELSqlVOr8SiaYL+A6+ZgYFGd09/p71avBpSq5ERxsPlENGS
	7sWI2acSxb6q1QRhWMN97bR1wwDCE2vBUpoCcnQ3CwmCKa6DOyNByrAerdv1Lsl82YcX40
	z3sCzAfUBMZ18sQj0JOpMSCq2JjabM8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-CrwB0QC0OCew_24AR4KSTw-1; Tue, 18 Mar 2025 08:44:38 -0400
X-MC-Unique: CrwB0QC0OCew_24AR4KSTw-1
X-Mimecast-MFC-AGG-ID: CrwB0QC0OCew_24AR4KSTw_1742301877
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43935e09897so21139665e9.1
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 05:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742301877; x=1742906677;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rmx6lMq9SxqwiLRc4324IBVrgzXkGFnSj4EmSTHL05Q=;
        b=ORdb+4XA7oUOuqj+zYTONqq8CVKpkE4IlIqCcQOFgqRz9eU/3yZ0uY0BELgaVWuH77
         Ke+vVEIC53hbWrZjI5KevYT3oGS8Shmq6qctEakkSHKJUpuClwLhEk5vF2FWTiSyDs7x
         rCjlEEZYI+/YHK7rB/ayanTQhiLJPiBK28padPCCntb+tb9EEbEZ0QPDNV2OxkGa6bHV
         Asuz+5hZAyBTOJ1Ij/bvjTgKaz7wEjLXIvZW5TflQLsA7nx/K/MeVl1cCOLYlZEdSFmA
         f/UKlKDpKd/rnThRPnunr9xblZd9r6uff/jAdUxNo8bMrJ3Ra58MwbPvX83DoSkq8yqv
         PL0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUapaQ8bTqUh+xZ5lFWn5ZzCXu0kBQd/7F4RrSFLIqkiviXWK4G0o5gQW3LeRz7o+kTMOF1lqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqWKabg9Yxevng0+q0///8lgpDCor/dMEGRoecASVhYgotOJWT
	MlhnupKnZMWz3Qrs1KPgDWxhGLXD68l9DHP9NU22QxioNKOKg7Bbw/RI/dMgv5WerbPykQSOIKv
	rt/qczSV+ALZ13Zkbux7xL1MH+SQvMplhjxnWVLaD+79m8XZqB+9n9g==
X-Gm-Gg: ASbGncsOt9HU5TK1ulDiOJoZ6hMmm4W797lS4/W6lijylOt7P7Kfkq6NVnKF2cA906r
	tue+fPHt5DlkR2ZhT1RPZUQ7l8es7K+fT97HO4Wjg744YDGo/asu0FfhgdpYeh7DalgfqOxgwsA
	9alAMzDoOqBcKAXknTx/qOI4nEc7t8yAT67HOMo+owVNiDf4TcT73xIqYM1TxDt1IbCx2PgNhF/
	fYK9I4sqBuNHEo6uNN4py1DiX0KiShAshAtieoijz0T3lnA1FM6yFSLCf4KdeKmQR8pJg1u5Rau
	VSpSW+I8qETEhPrA7Masmh1JpsiTblhPP8FgahMrC01a2g==
X-Received: by 2002:a05:600c:450d:b0:43c:ea1a:720c with SMTP id 5b1f17b1804b1-43d3b9b2b2bmr17984805e9.18.1742301876861;
        Tue, 18 Mar 2025 05:44:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF40JxTXemT4lPzuhCK4OlJib5amvoN4tlmPCi102ASjrEHYtfmSf9L0nYxo8vLIzalDxZmBg==
X-Received: by 2002:a05:600c:450d:b0:43c:ea1a:720c with SMTP id 5b1f17b1804b1-43d3b9b2b2bmr17984605e9.18.1742301876482;
        Tue, 18 Mar 2025 05:44:36 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffc3e72sm133082525e9.18.2025.03.18.05.44.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 05:44:36 -0700 (PDT)
Message-ID: <7f89705b-f4a8-4635-afd0-55dffe84ab22@redhat.com>
Date: Tue, 18 Mar 2025 13:44:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tcp: cache RTAX_QUICKACK metric in a hot cache
 line
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Neal Cardwell <ncardwell@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20250312083907.1931644-1-edumazet@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250312083907.1931644-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/25 9:39 AM, Eric Dumazet wrote:
> diff --git a/net/core/sock.c b/net/core/sock.c
> index a0598518ce898f53825f15ec78249103a3ff8306..323892066def8ba517ff59f98f2e4ab47edd4e63 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2565,8 +2565,12 @@ void sk_setup_caps(struct sock *sk, struct dst_entry *dst)
>  	u32 max_segs = 1;
>  
>  	sk->sk_route_caps = dst->dev->features;
> -	if (sk_is_tcp(sk))
> +	if (sk_is_tcp(sk)) {
> +		struct inet_connection_sock *icsk = inet_csk(sk);
> +
>  		sk->sk_route_caps |= NETIF_F_GSO;
> +		icsk->icsk_ack.dst_quick_ack = dst_metric(dst, RTAX_QUICKACK);
> +	}
>  	if (sk->sk_route_caps & NETIF_F_GSO)
>  		sk->sk_route_caps |= NETIF_F_GSO_SOFTWARE;
>  	if (unlikely(sk->sk_gso_disabled))

Not strictly related with this patch, but I'm wondering if in case of
ipv4_sk_update_pmtu() racing with a re-route, we could end-up with the
first updating the sk dst cache instead of the latter, missing the sk
status update. Should ipv4_sk_update_pmtu() call sk_setup_caps() instead?

Thanks,

Paolo


