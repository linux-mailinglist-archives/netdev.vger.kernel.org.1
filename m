Return-Path: <netdev+bounces-150698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 758C79EB31D
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 15:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6661A1636A7
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FCC1ABED8;
	Tue, 10 Dec 2024 14:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KW87OCZW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E86B1A9B3F
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 14:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733840710; cv=none; b=eZg9V5dOEngZZTXkwHlYLJwvF0wW6VohwJA/R2dyOVVk5EXjiFTV9BdO0rvNPJyzaWaqPFp+CTM1aV/LfpZ7vYDWPFGL8vR7lvs1pTW8bMCL70Bein6Lcb6aVxzmcMVXYT2LY7CQfCuevlF/clEVgsPhF53WzgfNASInY6xAyzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733840710; c=relaxed/simple;
	bh=xt5lTOar+7nrotCo2WAR+KuTjDN5yiuWSjL2mS1sfLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RBFfef61uDQTnUrPkWuTIqQmG7VJOcNVo7NGrVxNIgAmCupw3L4reH6XgkptvFo/eVYbhSDm87IOAs0mwckTxSqgNy0BZ1pu19vFl81aeOa1uRbhbd3pJ2Pd14XT7b7B8FTvjXhQVbUphJf0FlykKDDvFmtyJlxnNDRRWvzWo7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KW87OCZW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733840707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KSBpoyuyoq7AbbwaKguYDJp8F1m4JYvs0O3+5sDci0Y=;
	b=KW87OCZW/NIiCtrXzz7aaWf/Vrj1Gymp3VGLC4Qeh8BVZlWkoeuc2ieIPELGolXBHYiIuk
	B5cQy4oCfR2g0zTrfi10EIYqrfyLhH/GJX5sqx/IO3BZX5/32IXJA4vmp5lad8+t6D+pmt
	ztQwm9n7sHjJNGk6Hh6R83G9vDCxkT8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-x3Ibi2iiP_OIs4jez0f6bQ-1; Tue, 10 Dec 2024 09:25:05 -0500
X-MC-Unique: x3Ibi2iiP_OIs4jez0f6bQ-1
X-Mimecast-MFC-AGG-ID: x3Ibi2iiP_OIs4jez0f6bQ
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-434f5b7b4a2so20912605e9.0
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 06:25:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733840704; x=1734445504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KSBpoyuyoq7AbbwaKguYDJp8F1m4JYvs0O3+5sDci0Y=;
        b=qh9+7r/yo4gGHXlEB9VU9tzfVJmH3pQnhJ3PReFG9yicPET9J+YgwIDLSnfr2k4oUU
         lYTzD3JU6HyYgv9Ai+VpveLrdhUII61Mt/VCgAhLZjzzUyHPDQHk18rpk6Nj6BOQbmto
         FDIo7Jyhjp8jwLbV4ZnKcI3X436WQJxF7wHzlU9LpYgktNlGxAGlqzI1CRAZ36OfXIza
         XQ1htNz2GdzNFyNZCOHwNahvPwukLPDdfGQHfhhdNADi7FjwodAnNtm26fknaeYWWMLH
         7Y2lstdOX4VX/zqQKybgO8UT+cQ/lbIEEPLI8Nk15taWJf5hGG95zf1L0vfmpyxN5xY1
         ASBg==
X-Gm-Message-State: AOJu0YzLsD7prOYPtbEOFUZmDY09uZSY46uHFncGOyS8vI7/EXlSz3bi
	kX9XGSY0coFXPIln1L2e9IlnWcohZCs7e3l87IaZbXREgg2cZvFnJVyNsrKs1f7sp7VZe1PMMZB
	w9t16vGqUkxoATAEiG/OGnY3d+zVHjxBbHBxlU2fYCYqu9IflOv/9hQ==
X-Gm-Gg: ASbGncvV6vUeXoltsgdD7ckFM0GY8AbFyk/dA8IGFP06E+hcko3+zFPDuTmF1HbVKbU
	zGtiq+tI8281ChwWMSZc9WSMKrSgYXliClQzccwKexA+0LHIOYDewrmgYmefmAB8hMSV9x7spQ0
	g5S6Y4+MH5lX03O5pBUWIaGG2AcRNBZAkp2Al0RoB7TBjp4Y603M/KQ2ch5pGLeCLZ+cuIiMaEo
	plWAFzFmysuawuvqdjTV4V05rCvs72g8Qzumcm2pjtY6WkzMM5LCJvE/ZCDPDC1+4UKMa+VHr4c
	DoT4HUFnI0CxBaTcfpj7zYlQ4zEDt6Hvxpz0gXmSL6WO2/M=
X-Received: by 2002:a05:600c:1d95:b0:434:fddf:5c0a with SMTP id 5b1f17b1804b1-434fff306bamr49154825e9.3.1733840704107;
        Tue, 10 Dec 2024 06:25:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVkBJbiYTxM4lCwr7ozoD0dxYJG7OZKBPWAUCIFgw+4hPV8P/tiAzOhycek6RzVuTiPSf1AQ==
X-Received: by 2002:a05:600c:1d95:b0:434:fddf:5c0a with SMTP id 5b1f17b1804b1-434fff306bamr49154615e9.3.1733840703812;
        Tue, 10 Dec 2024 06:25:03 -0800 (PST)
Received: from lleonard-thinkpadp16vgen1.station (net-37-119-201-53.cust.vodafonedsl.it. [37.119.201.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436178bd62dsm14195555e9.36.2024.12.10.06.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 06:25:03 -0800 (PST)
From: Luigi Leonardi <leonardi@redhat.com>
To: mhal@rbox.co
Cc: netdev@vger.kernel.org,
	sgarzare@redhat.com,
	Luigi Leonardi <leonardi@redhat.com>
Subject: Re: [PATCH net-next 1/4] vsock/test: Use NSEC_PER_SEC
Date: Tue, 10 Dec 2024 15:24:35 +0100
Message-ID: <20241210142434.15013-2-leonardi@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206-test-vsock-leaks-v1-1-c31e8c875797@rbox.co>
References: <20241206-test-vsock-leaks-v1-1-c31e8c875797@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Series adds tests for recently fixed memory leaks[1]:
>
> d7b0ff5a8667 ("virtio/vsock: Fix accept_queue memory leak")
> fbf7085b3ad1 ("vsock: Fix sk_error_queue memory leak")
> 60cf6206a1f5 ("virtio/vsock: Improve MSG_ZEROCOPY error handling")
>
> First patch is a non-functional preparatory cleanup.
>
> I initially considered triggering (and parsing) a kmemleak scan after each
> test, but ultimately concluded that the slowdown and the required
> privileges would be too much.
>
> [1]: https://lore.kernel.org/netdev/20241107-vsock-mem-leaks-v2-0-4e21bfcfc818@rbox.co/
>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
> Michal Luczaj (4):
>       vsock/test: Use NSEC_PER_SEC
>       vsock/test: Add test for accept_queue memory leak
>       vsock/test: Add test for sk_error_queue memory leak
>       vsock/test: Add test for MSG_ZEROCOPY completion memory leak
>
>  tools/testing/vsock/vsock_test.c | 159 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 157 insertions(+), 2 deletions(-)
> ---
> base-commit: 51db5c8943001186be0b5b02456e7d03b3be1f12
> change-id: 20241203-test-vsock-leaks-38f9559f5636
>
> Best regards,
> --
> Michal Luczaj <mhal@rbox.co>

Thanks!

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>


