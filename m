Return-Path: <netdev+bounces-144049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5719E9C5620
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 12:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D73028BFFD
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 11:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270C92229F2;
	Tue, 12 Nov 2024 10:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fgQYtBRr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653DD2229F3
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 10:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731408798; cv=none; b=URByD3IX8pVqzgpaoCjZHKYofSPrztaj9pfhn+sLVnVMyFGLWvWeDpGpVvwaRNeTTi3pbHf+NQz3MpSNdsTLBSy2JWTe5Zk1obKGVXlbhJs1IwsYDB5nDxjGADVt7mUqxZ69uATZAcZ2wCXY1PAISq+A7wbqX42OhHH2q8hY3SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731408798; c=relaxed/simple;
	bh=7H8RxNGJ3Tn8Y+PwXCQNcMflGhtqhczH5A2MVt6rEok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KgvJRSQ8Hnhd5RTeRIYwjLysAZv9N5dQ1DbNz7AizrhLwYjDhhz+hdwIzusgdTLqPAA+RjZsnTYKo/JUHEy3NUGwQJ0teauBIkcv1x3A3lCHEnSSAxk80NCiV8gGz6K6wnfG5GLXso5Yks0gKlwEueU0D9dBE5C7n7eerOhe6Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fgQYtBRr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731408795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CvGwt5eeF62MQocbkxOZXSCvVeCunSDKreviF4RD21U=;
	b=fgQYtBRr27jN0TXEQjaW66wn5LF7f2M7U1SoIWdY6GXkh38W62CvSb4l/B0MwYzPUeBiZL
	Cij5YuS1SHNAIFyLYhuKHOZOx0Tp/KFD+nkd9byQmvkQz1xgesQQhelkiVfhn42dIBn9Aa
	QSDjVqApq6eR1ItlN2zEUZq2jCZA12Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-cQj2C859PfuKNLXZvTecFw-1; Tue, 12 Nov 2024 05:53:13 -0500
X-MC-Unique: cQj2C859PfuKNLXZvTecFw-1
X-Mimecast-MFC-AGG-ID: cQj2C859PfuKNLXZvTecFw
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4314a22ed8bso39265865e9.1
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 02:53:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731408792; x=1732013592;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CvGwt5eeF62MQocbkxOZXSCvVeCunSDKreviF4RD21U=;
        b=B7zsBDdKUTyGxGKzRetCobn7hB63LhRIT5cXmj0V9v27eplFqgbEJ6oVBmz/hbdbf8
         C8WKLr2p3PM1lL76ApzSPqgJxKAZnGjlRtJIChOtjSgwlm+YBBWj74nU1it9/fR4Np7o
         +NTNZ3ghIY5lgeGD+MLNS4cMHoYjIvf6P3hIdsRz3Bz7+y8Y+wDpTtu5hIzGpydiuTNb
         rofjaT8pzl8RnyRxuVGcNaGsn/hs2orruF6pO1bWF+vVq3CnErGIUNxkwuU7d2CsHu8P
         Cr6qcyVUYbdCg7dHCFykVPs5BkRsx18KCjUsFJeVYzr2HGsLrtVC98/SyC5Dbz0QxVgM
         wkxQ==
X-Gm-Message-State: AOJu0YzxGi0i4cna+iGNPugm3ZXbSVE35XrF8KFAyUkOUemzxKYgDzaR
	lUo24EAwi39LhZx8rxmBiUHr34VJv7TBAHA5XpNJEcUZ1tKuVrxR50yUBCGWEFwh82Qd1bgftSi
	JNc74X8ipTpyqBxaIvhs6pLCdBt4HuBnHDR8kTsz7mPN9oTzd06nNcA==
X-Received: by 2002:a05:6000:4213:b0:37c:d1e3:ebd2 with SMTP id ffacd0b85a97d-381f1823488mr13854845f8f.29.1731408791791;
        Tue, 12 Nov 2024 02:53:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdTAoBkokNkzJo1qaHXHrTfCn7qtgocm+wrw0DIYXw4djic6kqzprzGi9fGMaFEx1hMbazuA==
X-Received: by 2002:a05:6000:4213:b0:37c:d1e3:ebd2 with SMTP id ffacd0b85a97d-381f1823488mr13854831f8f.29.1731408791433;
        Tue, 12 Nov 2024 02:53:11 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed7d2c0fsm15559383f8f.0.2024.11.12.02.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 02:53:09 -0800 (PST)
Message-ID: <231c2226-9b16-4a10-b2b8-484efe0aae6b@redhat.com>
Date: Tue, 12 Nov 2024 11:53:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] geneve: Use pcpu stats to update rx_dropped
 counter.
To: Guillaume Nault <gnault@redhat.com>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>
References: <c9a7d3ddbe3fb890bee0c95d207f2ce431001075.1730979658.git.gnault@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <c9a7d3ddbe3fb890bee0c95d207f2ce431001075.1730979658.git.gnault@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/24 12:41, Guillaume Nault wrote:
> Use the core_stats rx_dropped counter to avoid the cost of atomic
> increments.
> 
> Signed-off-by: Guillaume Nault <gnault@redhat.com>

It looks like other UDP tunnels devices could benefit from a similar
change (vxlan, bareudp). Would you mind to also touch them, to keep such
implementations aligned?

> ---
>  drivers/net/geneve.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
> index 2f29b1386b1c..671ca5260e92 100644
> --- a/drivers/net/geneve.c
> +++ b/drivers/net/geneve.c
> @@ -235,7 +235,7 @@ static void geneve_rx(struct geneve_dev *geneve, struct geneve_sock *gs,
>  					 vni_to_tunnel_id(gnvh->vni),
>  					 gnvh->opt_len * 4);
>  		if (!tun_dst) {
> -			DEV_STATS_INC(geneve->dev, rx_dropped);
> +			dev_core_stats_rx_dropped_inc(geneve->dev);

How about switching to NETDEV_PCPU_STAT_DSTATS instead, so there is a
single percpu struct allocated x device (geneve already uses
NETDEV_PCPU_STAT_TSTATS): stats fetching will be faster, and possibly
memory usage lower.

/P


