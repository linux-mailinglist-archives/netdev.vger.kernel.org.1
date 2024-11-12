Return-Path: <netdev+bounces-144069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F579C5710
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 12:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A01D32832D4
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 11:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0082E1BD4FB;
	Tue, 12 Nov 2024 11:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZPZDZbZ4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5F12309BE
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 11:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731412556; cv=none; b=JtT4Uof1xbeNjOi1eeHqeOyVkKMVj5Yei0974D51GE757cZjJ03IUmcc3Ifkx47dpsYzSHqpB22K7shK+i9KDSaFn9cKdSZNZ+KLDrUPROZgDa1D+s0vcgN1JvHtNE1SRDxEWJmBdGQst2Djwd1bfqLXNfz2EJKPi2Rncks85kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731412556; c=relaxed/simple;
	bh=RAnrM8rdx52Q2UP6GKYZWpJm6rC3fqhyPtxUVzyayys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mt/K1kQik1mJB557welLvip8DGeIZcKSORSiOzWbjSzjJOZcLfcpbJcjPsFIzQ9z29VbLjQqLvKrXO101D3BpesmLaf22VZP1mHSSDP70a7shh+B/AE5maTZX0gpypUglKN1/dWyHXfVqvwMYpD6K8uxUyT840beBsXgl9mPZVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZPZDZbZ4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731412554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bd9qc51re6A5a6FAkiNj1HI8rqia0+AfoPF7/bIZCmE=;
	b=ZPZDZbZ4bZ4Hf05C0+UtXpwQ55xxViIkRfDRBRs5rriz8m650gCaKsk1QS2XLEnJ+zSTI8
	8s3W3hJG5xJrnaF1j+LW/pR3vyFzbN2zCvSHxE8X1tpH4/FLwHUJyMlyujPDyzLkRUIO5C
	CbJiDpUlUBGW2vFiwgBEWPFvvY1pJu4=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-MgGDgI8sMWeWI7kCEgZ3dQ-1; Tue, 12 Nov 2024 06:55:52 -0500
X-MC-Unique: MgGDgI8sMWeWI7kCEgZ3dQ-1
X-Mimecast-MFC-AGG-ID: MgGDgI8sMWeWI7kCEgZ3dQ
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-6e9d6636498so103163967b3.2
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 03:55:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731412552; x=1732017352;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bd9qc51re6A5a6FAkiNj1HI8rqia0+AfoPF7/bIZCmE=;
        b=U/cXsXqQjjl3Cnrlbg1ZO5bdHfJP94KSvN1b+1IDsn/EtpMfyTi31q6annWsBxm7h4
         9knlymSYNSo3Uba35Axov8LzD6NwVZtbDAozOoBsHhmYJWwf5P1BpkR1RSxsT64Z2lrR
         lY3kSyoAbcrhreI5B/O5+hrT9IrOh8MFe53/ETJQRb4GMPZP360i4eNeNFbKGfHpyLVL
         14rKAQatx3OnZAIs0wR5s4zE2bcROKWuy68vji1Jtf29pPrQE41Cpe8osPEgE1I4nsUO
         kIZP3G7Ic+qqct9aHflxW6UEMHZGbXmpcOFGTJsA2hyKNtYyRakZ78WM/I8Xyl7JQki5
         bKrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfgjdTOmmeUGfksWxZe/KFVnZSjWYUlkt6fyU8/aystAPoXjd8vDupe5iSeJFjNf7hi2XdVpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAqqJ4oshLzmoLc5CLXxEkTCqtkotpLbh87wP0DRkHFt1kEbUT
	jm/8z8z7cbkecuIUKRHt/TMMzsNHRTnc13ii3K0RkUVaQMkmW5n9k9pQwwQDhS6uVNpbnaeHITR
	nepH9R4KVQnhyFQBURkaVNHf3aa2wxHENQSxaaoxYR1Sfrs3sEDHuBA==
X-Received: by 2002:a05:6902:1826:b0:e30:cd98:56dd with SMTP id 3f1490d57ef6-e337f8621d9mr11135347276.19.1731412552092;
        Tue, 12 Nov 2024 03:55:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExxsL8KQH6sSlTqzq5ybTHyM0xyItjc9HT4wepfzFL7i/TIMY1vaRLkkc9Foohkv+wz8eXKw==
X-Received: by 2002:a05:6902:1826:b0:e30:cd98:56dd with SMTP id 3f1490d57ef6-e337f8621d9mr11135336276.19.1731412551763;
        Tue, 12 Nov 2024 03:55:51 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff3df16fsm74010941cf.14.2024.11.12.03.55.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 03:55:51 -0800 (PST)
Message-ID: <c882e54c-34ac-4258-83c8-d900c3893a4c@redhat.com>
Date: Tue, 12 Nov 2024 12:55:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mptcp: fix possible integer overflow in
 mptcp_reset_tout_timer
To: Dmitry Kandybka <d.kandybka@gmail.com>,
 Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, netdev@vger.kernel.org,
 lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
References: <20241107103657.1560536-1-d.kandybka@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241107103657.1560536-1-d.kandybka@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/24 11:36, Dmitry Kandybka wrote:
> In 'mptcp_reset_tout_timer', promote 'probe_timestamp' to unsigned long
> to avoid possible integer overflow. Compile tested only.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Dmitry Kandybka <d.kandybka@gmail.com>
> ---
>  net/mptcp/protocol.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index e978e05ec8d1..ff2b8a2bfe18 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2722,8 +2722,8 @@ void mptcp_reset_tout_timer(struct mptcp_sock *msk, unsigned long fail_tout)
>  	if (!fail_tout && !inet_csk(sk)->icsk_mtup.probe_timestamp)
>  		return;
>  
> -	close_timeout = inet_csk(sk)->icsk_mtup.probe_timestamp - tcp_jiffies32 + jiffies +
> -			mptcp_close_timeout(sk);
> +	close_timeout = (unsigned long)inet_csk(sk)->icsk_mtup.probe_timestamp -
> +			tcp_jiffies32 + jiffies + mptcp_close_timeout(sk);
>  
>  	/* the close timeout takes precedence on the fail one, and here at least one of
>  	 * them is active

The patch makes sense to me. Any functional effect is hard to observe as
the timeout is served by the mptcp_worker, that can and is triggered
also by other events and uses the correct expression to evaluate the
timeout occurred event.

@Mat: are you ok with the patch?

Thanks,

Paolo


