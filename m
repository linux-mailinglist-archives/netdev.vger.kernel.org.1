Return-Path: <netdev+bounces-194151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A25CEAC7929
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 08:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E68053AF733
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 06:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F00D2550CA;
	Thu, 29 May 2025 06:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JEO8RFDA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6AD1DF73C
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 06:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748501021; cv=none; b=V42yAO+99WGx4QuatClqSzdaE0hsPu5EueB5Zik3X/+7+aaRRV9xkguQ14+lYfFkdSep5vdoo4kcoLODIToyWy3pIAS7vIKPgmjuqRrj7hbvX4pDVKffqmCNrwLnX8GO/wMIcikXPD7SWVP6QM7oygnVxCvEP3Lj1M2unP+rtBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748501021; c=relaxed/simple;
	bh=/qDdsTJZ93ur50jARzCGJ4oAwrp56J+SNDkDeYmuZqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EIuUD9E/A8cTjNWZgsqIDK9kgEY3IOTasyebi0y4OmNkS1PeyZCGY0VEvZyyt19L/0oHbPdug84cBH6doZOkKnQezfV0gh+FtLP/vuwZ2Ddp+UG3X6VApE/gxiowCS6fD5JDSMyMJqyUIvXgxBFUUDqAql+2uLH//Y6Gzd27z9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JEO8RFDA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748501018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hsRW+9k08y318rmeCuA7ybBmPboKnqZPbQfBzGFx5ls=;
	b=JEO8RFDAwhVrwXnqxvwJBNRJJeRFrVIi1r9r/4tL9oJRGgFf8d+VHJX40ir6ETWdrk+JiN
	pKjuxhddfj7cjS/J6b3i0GtAiIc8LJrkyCwCYi/F+bOMR4U1Qxx3ixjkY7tuUcWoE6BOqd
	VSRQWiLisAVJS+y52PnkQApEvrXJyA4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-zUan91BAO8C5uZ44molhCg-1; Thu, 29 May 2025 02:43:37 -0400
X-MC-Unique: zUan91BAO8C5uZ44molhCg-1
X-Mimecast-MFC-AGG-ID: zUan91BAO8C5uZ44molhCg_1748501016
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-442d472cf7fso4571925e9.3
        for <netdev@vger.kernel.org>; Wed, 28 May 2025 23:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748501016; x=1749105816;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hsRW+9k08y318rmeCuA7ybBmPboKnqZPbQfBzGFx5ls=;
        b=iKvhoE77KzLZVb7OGVQKvqUBVb0CES8eE5UI+7uWGNsxwf8TdSPk61xqFGZXnSaLtf
         3j37OJcvYVSxD30Habj10rR1yxvVAPpYmV/WjfSEthjAFCHWRTAewR9vd/1hOVTi3xk/
         pxtwYs6e6SBSJKcDqRbGJJOhY0obluSv5H+7DRuAhUzvF20sNgqLU6lYGg/F4JgeCuR2
         uUMqmEMpr/lKtLWlxV5jnekeXCch+bjngh5zVmJnjHgeAwWHAcw4YsGmlBR0gaST8akY
         VzM7pHyufTX/MoioRJ0yloYXzimV28YcAHOM6zFMjTXrooxEFg16s6LfPmNPFZyguWZO
         HuDw==
X-Gm-Message-State: AOJu0YzRfhtKg4djeH1F2iEI7gjFzpbVckOAVvVsNDkw1555n/+QzsY+
	wo7rsY8gnfBnvlhNpIHBZ3dQEU7ll9cpn2ysQzNvr9PGzodjObGtoxdmlmtEtMl9pGcSWwXXbKK
	U/uid6mxDbguIZ87T55iNf31DCs9AqH9jTK0EFK6uEbJsjdXFEwvdroVG0Q==
X-Gm-Gg: ASbGncvE3s4Erwl5klCVvUQZDGTeAngCqcEBoSCTITBqnvlkWivQrA/36EmiaRvS8Q5
	lSuHIEc/xIyZXxItWq8uDdzXlq5y3jEycvp9zB3lAWRJfqHBsfjhi+e4g7H96xkk/gIBAZfioXf
	Cp13d1W3oKTeJ2xZGEj82IXGpWRUmqhalye/kr4p8/FGIXPlKOTvEcfpjqs/Nv3jbjWvg6RTuhQ
	U9UQK66EAuZMi6Acmi6ehcMtG07CGcDXIYpF2AWKl4PbcfcTfKtyfixiJgQ382jiaGBVdf3/Q44
	GUDHtsg1SQL5y8qXChi0tDWv4B6OwWjOOMbe6A9O8a7ZJZC85AtCcs+cf18=
X-Received: by 2002:a05:600c:5115:b0:44b:eb56:1d45 with SMTP id 5b1f17b1804b1-450d0574c15mr9260575e9.15.1748501015788;
        Wed, 28 May 2025 23:43:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHE73xvcN8oNb/rtbonm8JOmCkL4tC4zlAHM2JVqRuYuvY1DOzRbftQC7T7HzD+wsd5Bp60fA==
X-Received: by 2002:a05:600c:5115:b0:44b:eb56:1d45 with SMTP id 5b1f17b1804b1-450d0574c15mr9260305e9.15.1748501015470;
        Wed, 28 May 2025 23:43:35 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cce5:2e10:5e9b:1ef6:e9f3:6bc4? ([2a0d:3341:cce5:2e10:5e9b:1ef6:e9f3:6bc4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450cfc2704fsm10882665e9.25.2025.05.28.23.43.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 23:43:35 -0700 (PDT)
Message-ID: <d0a7112c-d9a7-4264-b7cf-02d25eae7a13@redhat.com>
Date: Thu, 29 May 2025 08:43:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [net-next] hns3: Demote load and progress messages to
 debug level
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Jian Shen <shenjian15@huawei.com>, Salil Mehta <salil.mehta@huawei.com>,
 Jijie Shao <shaojijie@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>
References: <0df556d6b5208e4e5f0597c66e196775b45dac60.1748357693.git.geert+renesas@glider.be>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <0df556d6b5208e4e5f0597c66e196775b45dac60.1748357693.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/27/25 9:30 PM, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> No driver should spam the kernel log when merely being loaded.
> The message in hclge_init() is clearly a debug message.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

## Form letter - net-next-closed

The merge window for v6.16 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations. We are
currently accepting bug fixes only.

Please repost when net-next reopens after June 8th.

RFC patches sent for review only are obviously welcome at any time.


