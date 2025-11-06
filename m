Return-Path: <netdev+bounces-236282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB2BC3A8C8
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 12:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6DEF54FCB9C
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 11:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A5B2E8B91;
	Thu,  6 Nov 2025 11:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGsPOn/1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052D72E0916
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 11:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428010; cv=none; b=ZcfBsHzGtP34i2MODWb+ceRbkpNS5VFfwJvh5zdcaZI+rSehqku3RCP3PcpUUbA8vjUOXzOLqQSqOfg3nv11Uvx7gDHAXC/rRj7uolJuSrxyptvdiH/RuxYBDPFlDUo4kd5HL57vKeRemQjFvOdfV0GVpMoz4qovDSUyd9rHE/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428010; c=relaxed/simple;
	bh=FP9NM+3aCaFyy8S8X4uShfckyRpPcF7PbkxpFQEZXaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KZF7YQJ6RBSJaeN2ND4Tt2GLPa0vLnKQ8kB1jS4sRQ1ute/6nE8lCYm5M8fJqP8mnddBejcFAX57eKRBYWV082H5cSXNaP+GCAKmm7d6G9Ilt4IuLU1JM79kna1Dh4udlKvtIH7pd9JA92TCOuLZ2rX0c0udiU7OW7A+q51JIjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGsPOn/1; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47118259fd8so6175465e9.3
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 03:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762428006; x=1763032806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f7dWREg84wLVwTN0Z31lc7M5a+XEMVB4V95uAvuHHC4=;
        b=OGsPOn/1YzwLu6kMCvkLQSkest1tcUeKSFkOT0fazdxxqH+RsAfA1K+ZreMebVBO/9
         e/2SOdZxsi7IDiEjz3ArH5apOKCJV81R/xicn8HsPazs3Z1pnLQZ6kHr/rYwL9+7hS7V
         NLaswDsOSlga5cruWjM3f1XrJQMk6G5xkrBx4n9wNH2i8eW5wq71zWL4hrKtIc1zstYm
         ltMX/eebKlHpAz4G+CcFTZM15XhrRxcv/gpfNVkKo5/rHpL0j8QBQSL1BRlEpan9bxqR
         Ur3La83Qde4ftE6PB1OEFJ2UzUZL/IULmQjQuHQxVBWBbkIXIrbjv2GjYkklwDWU13MY
         U++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762428006; x=1763032806;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f7dWREg84wLVwTN0Z31lc7M5a+XEMVB4V95uAvuHHC4=;
        b=qOupjBG2azD0sdNIiWEXb95lNkB/iqFxKN7kCHqJVDIQID8ikzzw2CSfKW6N5VtCXy
         Xy0lrVD3xOnYxSdvZCgtxzRqZcFhCijcut0lFNQ/Jri9omK42+UYm3lQcePEfHhZVNaS
         Xb+ZQLKGDYPij0qSGRI06TAhzpGC+dLt09QECOYcwT/mE80vLekg3oTgKYnPGnxu6kjF
         daP1TrI6woqebptJKfWa/oC3mZTQH0+K3Xt71dT4WWX6C6OVGraJbbZOLLjY9F847FcB
         FnW86TeYftSvBjderrni2vsJJIK/sKQcCSEWbaBiIG8WRu0f2GmQgb91g43pDo7GbfWU
         rf5g==
X-Forwarded-Encrypted: i=1; AJvYcCUswXPr1mrSm8+kpqwF709p6nBegOR1M/YbSeq9Gdg4eKVkKoIPLUBJtpC6f7QSGoOliCuwVBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkCJjTANjck6KPM3AjoSvnziYqcWYpU2S07NqVNfaOa+c6Zztj
	skdHcGyFhwcCwz/IalCQC5/Ge2ViZYNrbCOWSB144Tp72nCY1KhgiYDa
X-Gm-Gg: ASbGnctONz55U1jlh7yz+A9byeq/Ufm/bN0fZY+mzEiNS30a4TgAQPcSCTExi7E7TYF
	3aBNvOxPWkwUmReQAeb4yzcfrwSQtSzqIfzzo0Q/+YWS3mw+LUILoUpHJtFkeU9WU6qpeefd/pK
	rwim0asmt9MYpHqRyyKDyQuthTUV3g2xG6Ggx+AGnhXFsXLVnH/i9EgRYpdT7pKPTJQPw6rl5FH
	QG7e+vqggDdd4BL7NMMCgaA2HawxEcqwHsnzBsUKDstjWx6pz3M7UfJjpmCmnof/JiOqZV1no5H
	AIVzQMOZ0zj49whjrRhHQHMmwJ63fofxY4PQkGKqzQdm+SNjJaOMqeZaGrF8Y29Eqp3CaIsuhUS
	9c1PQNeJ50ttmCtSzColRctmJuPR4xziVc5EY/M4QKMlQcLv6bINA7cw1tZ7csj1zi+0Nm32IMF
	YtuZ52ogGExhkGuffEUkuVS7b7IwNprAo7CTYeDnPi75L6gBP/v8FK5Ry7QQDUIw==
X-Google-Smtp-Source: AGHT+IFmPEOGXwmiNYFV8qNYtQCERc0uP4rcrWry1AtWNHepXQvSUroPgf3ymb0aUW3f85vOL9FEbQ==
X-Received: by 2002:a05:600c:1993:b0:46d:996b:826a with SMTP id 5b1f17b1804b1-4775ce2491bmr71488725e9.36.1762428006179;
        Thu, 06 Nov 2025 03:20:06 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47763dc2b8asm14874085e9.2.2025.11.06.03.20.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 03:20:05 -0800 (PST)
Message-ID: <12e904e4-92da-497d-8bf3-27f3018232d9@gmail.com>
Date: Thu, 6 Nov 2025 11:20:04 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/7] io_uring/zcrx: move io_unregister_zcrx_ifqs() down
To: David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
References: <20251104224458.1683606-1-dw@davidwei.uk>
 <20251104224458.1683606-7-dw@davidwei.uk>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20251104224458.1683606-7-dw@davidwei.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/25 22:44, David Wei wrote:
> In preparation for removing the ref on ctx->refs held by an ifq and
> removing io_shutdown_zcrx_ifqs(), move io_unregister_zcrx_ifqs() down
> such that it can call io_zcrx_scrub().

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov


