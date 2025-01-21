Return-Path: <netdev+bounces-159979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68032A17944
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 09:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 257AC18849B2
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 08:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CD11B21B4;
	Tue, 21 Jan 2025 08:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OjVuqXD4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5009E18FC74
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 08:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737448106; cv=none; b=Kq5Q72kEg0EK7dPcAcvnn+hkLG9RwThrGbjDhrQTiweb2fM4no5eksy673kp0KOAPnuK4rI8FhoxovcQPVdvd/L5LrCioAssnytLOsjYZy/PD5wGdfO3DTwuqGgqsuQTr8KGnZS8zH/1p/sUQyU3T7BeJb6nkF+n1SPvLStlsZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737448106; c=relaxed/simple;
	bh=5iHmUYwIfoIKPLFJjEMTMUmo289yUkiCu7vo2YkD8IA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZGBSQjPTa0wLOgOQbUA4tkkpxHuNR6IAR4r+ji1T587j5Efh/QKm8cwYdQNAGBV4Gll8QznWXMxMcb0IAeY46UW+EguDH9PK5OBGUH3BaKAsHpy6yEMCPKapQumKSDKmY+tgvDWUkaURvD9VNpl0odHXGKx2FyMcoytuRkQ1u7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OjVuqXD4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737448103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5iHmUYwIfoIKPLFJjEMTMUmo289yUkiCu7vo2YkD8IA=;
	b=OjVuqXD4C+XbLxUmzl6aUikkNKYAn/9aK4QXcMGKzS0QblXEhoYWKXhCszBp7R/Na9Pmbj
	tdWn5LtsKXf3BpWzAGVNzP9fW2OA80a4Q4PScG+Bs2UaC6zuHrzKJIsLla3qteYdIamFDL
	yCx8m6z8WHOEm7SCudPACOnkTlbjSjo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-axXB71svM1edbr4k14fm9g-1; Tue, 21 Jan 2025 03:28:22 -0500
X-MC-Unique: axXB71svM1edbr4k14fm9g-1
X-Mimecast-MFC-AGG-ID: axXB71svM1edbr4k14fm9g
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4362b9c1641so26000945e9.3
        for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 00:28:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737448101; x=1738052901;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5iHmUYwIfoIKPLFJjEMTMUmo289yUkiCu7vo2YkD8IA=;
        b=Yi9iNaQeeLq1Q9q92TZp8HcM20KWRMDeHuCKlV0pTct1CbeI10db+unD3BmiHLFzQJ
         KQpf7ninHj4KSZj3lpM78xt/mXf5Pa0s8kpyDMW+yft43xApjQYbvte7OI7d18Qbg5y5
         ayGDTKwPoLitGIJ5GtjSAAIJlx2PRDDEMUw9Mxzluf+N+8pRrNjfmbeagfro+JcHDna+
         OEfM2qCMsp6LHImGi63s4QhopnjuVdJJcJ3TFjly6UoJG8oMwDfprK+8L1aZBqYl/sxP
         rqhRbICUIQ7iONerFvwN5b2Nkt6hSZAaSNqTiM4ghWN/q6JuFOkjYmr9CSLYgiSXoLO+
         3mVg==
X-Forwarded-Encrypted: i=1; AJvYcCWjbz02H2eiyHUArcyvvA3AhteScSIZUspIVJkC3esPQroWwP3Bj+smVMpEVJZx80D3P/HNqYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIs0pnNA3g+DcyYliQRr9FeaFQfpPRjkIm40bqVdrqMHyMNA3E
	tFhQQlTLfrS8M0lT4OcM+hrv0KKVRhKU28dYCSzDm6xbs0PSpyIPIZm9a9fGDHMJQY5MsjFA3qg
	EaJsXxdZuET39hain2ERWWwcNYmdbS3UL2T/iNCc5oC0l2ZVF9ZTBrg==
X-Gm-Gg: ASbGncvLQUT4XTYbQcv/3Vw4Ku++eOfjqA3A2/716sIe+d3Zp7pTjKLQTJfkdpocpnl
	Q2zyy1sA3xFMGtx72mdQeLV4NbUnbSGfJ1SSYQI6xDU2Nx5FN/Ps3GcMqOK4O5sCEqkVPyIptci
	Tg08kwimOtDoaVIRxwD1I+EZBYjdZOCNAfN0dAE46bDtUrejbY9LRd5gsUWB4ZomybrXsyj6wKn
	d8eGbPlFvaXBHV3GQj42pMuHhYSSFGR7lK/iBYsSumyfJo8AiITBtgC/7rJvg1jsa4y1lsKosa4
	81sP89o/T+Z8/yrKv6oyry69
X-Received: by 2002:a05:600c:511b:b0:432:d797:404a with SMTP id 5b1f17b1804b1-4389142e0e8mr137251575e9.22.1737448101084;
        Tue, 21 Jan 2025 00:28:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGateLLRqFO6pgBAyQrfwZmzLT+2JUy4zXGwP9C/AUrhSw3hu0TnbxS+msir2bfqh1FkRxhlQ==
X-Received: by 2002:a05:600c:511b:b0:432:d797:404a with SMTP id 5b1f17b1804b1-4389142e0e8mr137251365e9.22.1737448100733;
        Tue, 21 Jan 2025 00:28:20 -0800 (PST)
Received: from [192.168.88.253] (146-241-15-169.dyn.eolo.it. [146.241.15.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c753bee8sm232299195e9.34.2025.01.21.00.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2025 00:28:20 -0800 (PST)
Message-ID: <32e34de5-70e4-435d-8aed-24f18cfb99e1@redhat.com>
Date: Tue, 21 Jan 2025 09:28:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 0/4] Support PTP clock for Wangxun NICs
To: Jiawen Wu <jiawenwu@trustnetic.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 richardcochran@gmail.com, linux@armlinux.org.uk, horms@kernel.org,
 jacob.e.keller@intel.com, netdev@vger.kernel.org, vadim.fedorenko@linux.dev
Cc: mengyuanlou@net-swift.com
References: <20250121022034.2321131-1-jiawenwu@trustnetic.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250121022034.2321131-1-jiawenwu@trustnetic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/21/25 3:20 AM, Jiawen Wu wrote:
> Implement support for PTP clock on Wangxun NICs.

## Form letter - net-next-closed

The merge window for v6.14 has begun. Therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after Feb 3rd.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle


