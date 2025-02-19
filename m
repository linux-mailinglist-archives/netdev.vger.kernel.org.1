Return-Path: <netdev+bounces-167631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E39AA3B1B4
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 07:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF54B172747
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 06:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D1F1B425D;
	Wed, 19 Feb 2025 06:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jj85mlx5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F2F4C6D
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 06:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739947033; cv=none; b=iyxv+z7t37iaRKpZAYQRLdPVcP7EXFpmPFkM54oV0uuJeSsN0LvDu6qGPgr73Og9N3lWHrUyc90DrXLQYQKU5scnAb69yNsWRIMpD1d35GxocIf+KQD1EnvRv6FVtupHZSBCMxL7bbwe0cGU30k+4RzWD8H/6xHtAAW2FqAN1+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739947033; c=relaxed/simple;
	bh=59DY9Uq3JnOEboD/8p0HFYMtBVYdKcUe5SFl9jrohOo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Y1Kqtxr2xzKRW4dEr+b986eBdndX/F6UeG29Qtf1DioAePiVQfZTisCiGSYNtyEDk3/4xd4Ocb42YiG2IakRtJDrJR5e5Yl7djl1OyLi4lk5dRTr5JUiH5pPRvbbr1BNqsc/bEdTVWuBbwDBzngLxYHEMtIo+cS+FF1LHczd6uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jj85mlx5; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaec61d0f65so1295352866b.1
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 22:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739947030; x=1740551830; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eXcsT6EBHeRzjpifAvGOJupya5mbWmpkLfsBOVI1WOw=;
        b=Jj85mlx5xiZbkrF68pltrtY8lDhXi2RPGwSnszdWSSFn9qwKWyasbBLAto181xDeVj
         J6MCIj7CE1MvC96DVs6m1ttlWC4ZfqKQgLnKfz6wyLh4Kfw+v0CtayYpxSxCbyRglSLF
         cxBKBbgay0OQHcNTFABJPTTNcCWlLafbiwf8wpdi7RQ/zoaclPjqwpn9oTYJhI5Xcdk4
         ESGOgndEyv075orxRUQ/V41FDC/h/vJpuzTweq2kNkGTGJsLCf+iqL5UAImpLNRlp4Ik
         aVU4Zp3ZZ4UVBb5U5QJfRexAgRPr0TzqcArm18NH4gQ82MFq7j7QHw96rxNWE6Xlnbe4
         P9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739947030; x=1740551830;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eXcsT6EBHeRzjpifAvGOJupya5mbWmpkLfsBOVI1WOw=;
        b=MXNj0qp6LVz4zBsEQY440PSBZbtx53diUrz0f4xxGaGhaMMUsAVZQNbQkr9hSlWMoc
         btboVGdq00KQFvOY4M2FHxSRe7f07c6g+XmYO/l+DKxLY4T76ZEKzyLmp+j0NX7NmdbX
         ufJ5iCp+ztQ8Z6lmhwauOWLCPY/3rP0AnZpWjepCbPQnNdJIbzFMnLmk34AZPakQK6+S
         DxgZu+2/13FcLiTdwyzwFNy5s5QMPe0wmRLL22Xm9viVaLI3KGaw1ZCatJo7FyA3S7VB
         90swduVEtyJ7GAjBSKJOQXLXi1grlEopUqHCBlIt9jljWUGnvfIfHWbEVMUkCFpL4qV0
         hg2g==
X-Gm-Message-State: AOJu0YzQI1OWVLPJE+4zvhK0freRW7HBT4cVvSzLyw+8TTn/8eqUXRaL
	hspiTM3ro9l4gX69KoWQcYwuP5idrsgwnU4cIYvVgzfK8vQd0F3U
X-Gm-Gg: ASbGnctaVFajbPjDpXQP/XaJgfpSU7cII8LmOQH4/Rkv+bcSOpiSEOQgEAZ/7vgMbKb
	6ma5BD7HrYTCrHuXB+zvGOvIKAMmIjAVdc0QE/kuSEucypFJ2uWpO0ydRhv+SyGWNNX/2hWPRib
	gKo8O9xD/lIsGXZe1o4xuccTQB1sOpmYU/hh2+3Tvhsxrwq5MMB+gfrB0xn8e/Opy6EXxq1ShdB
	QQtUPxmUtcM6HP+4VeRb4xWeX3ZqT/WM5748HTzOti4ULgPseb9r+I1JRLZGpg73krfwhD/k76R
	dmNlHobk6NjbT+y53BFmlejxOSOzkT2Gx45sARUykRPNM2wxI/hzfhyA25rLYZo1uDXSBrlxh/Z
	BNKKW7GPBK76HUZFoipqQrsWK/nsdeJcMmqCliTSvCWKt4YUXxnJay+dWz53pJFukK/lCy7ejCt
	MYLf/MtZE=
X-Google-Smtp-Source: AGHT+IElPr/8IxtkGS0IaRiGo1OB7/YqFrnlASLgg88k2wPONpPYQxUpbcPOc6D3mFmbZwR6P5uMPg==
X-Received: by 2002:a17:906:c154:b0:ab7:8930:5669 with SMTP id a640c23a62f3a-abb70d2f836mr1603442066b.18.1739947029565;
        Tue, 18 Feb 2025 22:37:09 -0800 (PST)
Received: from ?IPV6:2a02:3100:a982:e400:a8b2:dfb2:4efb:8f82? (dynamic-2a02-3100-a982-e400-a8b2-dfb2-4efb-8f82.310.pool.telefonica.de. [2a02:3100:a982:e400:a8b2:dfb2:4efb:8f82])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aba5337673dsm1193565766b.89.2025.02.18.22.37.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 22:37:08 -0800 (PST)
Message-ID: <8f7cf3ac-14f4-4120-a8ed-01b83737e6b8@gmail.com>
Date: Wed, 19 Feb 2025 07:37:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: add phylib-internal.h
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <290db2fb-01f3-46af-8612-26d30b98d8b3@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <290db2fb-01f3-46af-8612-26d30b98d8b3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18.02.2025 23:43, Heiner Kallweit wrote:
> This patch is a starting point for moving phylib-internal
> declarations to a private header file.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/phy/phy-c45.c          |  1 +
>  drivers/net/phy/phy-core.c         |  3 ++-
>  drivers/net/phy/phy.c              |  2 ++
>  drivers/net/phy/phy_device.c       |  2 ++
>  drivers/net/phy/phy_led_triggers.c |  2 ++
>  drivers/net/phy/phylib-internal.h  | 25 +++++++++++++++++++++++++
>  include/linux/phy.h                | 13 -------------
>  7 files changed, 34 insertions(+), 14 deletions(-)
>  create mode 100644 drivers/net/phy/phylib-internal.h
> 
Patch only applies on top of patches which weren't applied yet.
So I'll resubmit.

--
pw-bot: cr


