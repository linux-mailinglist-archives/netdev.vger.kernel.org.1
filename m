Return-Path: <netdev+bounces-240740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F88FC78E3D
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 12:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6375E4EBCC4
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 11:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B184834C81E;
	Fri, 21 Nov 2025 11:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4JAN0gh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC19C334696
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 11:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763725019; cv=none; b=GVWy4sORhYDUqw7rB6RLq6rbd7y4wq50BJwKe6IOAZYFbw5pcpTIb5EEtyqrUu4UeJHLA4UUkSxYM/5/QHcInBvyj9Fpy+CHXcGMhXaracaMF7Moxn/AkBLjtGDxZlrTL8sBGtP1XmvNN7Xbtafgbd1+RVpoQlu/NiF/xFZfPa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763725019; c=relaxed/simple;
	bh=2YhHun6h5TPZJPb5erjEIpsM643I39VH2RfBhKTc8MM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=izZwN0rxUa5GojBlgP/v0T0U0Kdr+iJCmrvkKgtPQ/y6RG73zdPM50Op6IUlEb0rfdK+xWM6h7tMWBz8DqXtOsO33yycdBpsarfINh8H2c9HkR6t9wZpz/hu+ps1NueteCvKZMctKGGeqzZiKdJst7EOKP89TLVmkaSnTIQnoG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4JAN0gh; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477a1c28778so21882675e9.3
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 03:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763725011; x=1764329811; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fEL/unmTGTd7Hwoq2i5Bt8Vk37qtmt2aavwNGtQcKk0=;
        b=k4JAN0ghN2HrJsm0n6OWj+TlyMhsOFDfy4duBR/1590P99RDYuI90jKderNxb07X+S
         NNpfFhmyWebzua69RfKluGPM2d62pNRBMYWGRk+OUlGVjNX34HIvNULWLlF4YiVQQP13
         0G7KnZfAW6AzANET9uZupmG3f9MePAJVUjrjprjyjmlx8hGQZ2D6ce14KjleSbbyOOjR
         al5I/2oQNbgaP8Oj5wz5aBqVbr0F8WKlQ91FSZxSlcwD6S+Bla+89kuwMQF2PuMDfljX
         mVSvk46GFCGUPY2sYID/kuCMmCiNwykILFY0ZvOO9RY9evgG3i5khmT9cpcI9d7liW09
         hwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763725011; x=1764329811;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fEL/unmTGTd7Hwoq2i5Bt8Vk37qtmt2aavwNGtQcKk0=;
        b=VDg957OvPs0wQpgctXnFNIp4du1Zbx1XAjk0W039ixCNAHnYgZRXYZAEsA9S+aOX8n
         7sv8H7/P80IDZtNwIEEbce2/ZZeBVIjpX+Wds7CjQ2j1ha4DOK6rlM1G45VTm/BCcQ3H
         WdEZjttoqevg6P7CnQUXx3GaNZPTgOIhxQ8vrvVsrJXHsXmlVJQ2uGt3cAl/tRy0UZEy
         ZPLhg9uZGdhKB61kQd7QKGD/NUltu7/8Ndhr4XxgE2Qjl2Idua/oe+HaFhvVVMhze8T9
         DefxWRFhJ4yIe4i2wSFvkh2nBLmxuw002HzG+pyc5urukWTA/acie03IWA3Zz7q3ySfi
         W4zA==
X-Forwarded-Encrypted: i=1; AJvYcCUWZzhMd3hJN615iPs5kRoF8JXoGe5cwfc3Ul1JWjn7VAveoYOPKnxoEH0yLCHjvnDkTHr6EDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVkSuMMaeacqUMx2VKhRmbc7TKtQ4AtK05mWgpWo0vgtvYP2N2
	oNb2dSO53JIaQ3DEiT6GBpEp7s4eMPCfiRh+4m7sRpWvIDBrDbXXgON9
X-Gm-Gg: ASbGncvKtRHJZvHTPUTm+vpDbnJa0VMz+k2mI/a+GuSAWvj8pN1GXv57GnCnvX4zcjD
	0rMqv/ys3uY3Pp0HzP4B71gBkO0iz8u0YwUS5RSegDKDznQTSWyEcuNgJfeqKKdMX5NTQJYMfeS
	zOkE1IR+QZp2vq7zIFNMma5LHxW0iWe4JcjBHC+IpmWkd+EhRoC84gaMQz3tWS2IwfFpylsXZUZ
	5GMIDCpo/vz1hXx/ZaBsN/7mPcTS4i2n4lKF5v/P0G8t56LkXwg9RdnvR51cbJeyShsVSroZ332
	1hYNBf+JhIbjs9O+8ATc7AyIrIjmqw1KIYfOk92Pp0UYLBsveg2ccvBU9+qqp/EZEI4ql0vIZbN
	kVHq+GO3g0wz8fHwrJSiNeAthukHZf3twQPmx1LQFSR40GXii6W1hGSDS/nkIJJOLyejLYdMYHu
	ykHDn/64NB9ZPkr+wAhtdZ1Y4=
X-Google-Smtp-Source: AGHT+IHiWl/LbQdLCaHamlI44jxsdkR7SpMvvFRZBQA37tgZFbQIG2lm/npPeeMv7MO4497KZLWILA==
X-Received: by 2002:a05:600c:1c0d:b0:471:14b1:da13 with SMTP id 5b1f17b1804b1-477c018a12cmr23820885e9.14.1763725011008;
        Fri, 21 Nov 2025 03:36:51 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:f819:b939:9ed6:5114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf1f3e63sm39654205e9.7.2025.11.21.03.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 03:36:50 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,  netdev@vger.kernel.org,  Pablo Neira
 Ayuso <pablo@netfilter.org>,  Jozsef Kadlecsik <kadlec@netfilter.org>,
  Florian Westphal <fw@strlen.de>,  Phil Sutter <phil@nwl.cc>,
  netfilter-devel@vger.kernel.org,  coreteam@netfilter.org
Subject: Re: [PATCH v5 1/6] doc/netlink: netlink-raw: Add max check
In-Reply-To: <20251120151754.1111675-2-one-d-wide@protonmail.com>
Date: Fri, 21 Nov 2025 10:03:37 +0000
Message-ID: <m2wm3j4s92.fsf@gmail.com>
References: <20251120151754.1111675-1-one-d-wide@protonmail.com>
	<20251120151754.1111675-2-one-d-wide@protonmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Remy D. Farley" <one-d-wide@protonmail.com> writes:

> Suggested-by: Donald Hunter <donald.hunter@gmail.com>
> Signed-off-by: Remy D. Farley <one-d-wide@protonmail.com>

Missing description, therwise, LGTM.

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

> ---
>  Documentation/netlink/netlink-raw.yaml | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/netlink/netlink-raw.yaml b/Documentation/netlink/netlink-raw.yaml
> index 0166a7e4a..dd98dda55 100644
> --- a/Documentation/netlink/netlink-raw.yaml
> +++ b/Documentation/netlink/netlink-raw.yaml
> @@ -19,6 +19,12 @@ $defs:
>      type: [ string, integer ]
>      pattern: ^[0-9A-Za-z_-]+( - 1)?$
>      minimum: 0
> +  len-or-limit:
> +    # literal int, const name, or limit based on fixed-width type
> +    # e.g. u8-min, u16-max, etc.
> +    type: [ string, integer ]
> +    pattern: ^[0-9A-Za-z_-]+$
> +    minimum: 0
>  
>  # Schema for specs
>  title: Protocol
> @@ -270,7 +276,10 @@ properties:
>                      type: string
>                    min:
>                      description: Min value for an integer attribute.
> -                    type: integer
> +                    $ref: '#/$defs/len-or-limit'
> +                  max:
> +                    description: Max value for an integer attribute.
> +                    $ref: '#/$defs/len-or-limit'
>                    min-len:
>                      description: Min length for a binary attribute.
>                      $ref: '#/$defs/len-or-define'

