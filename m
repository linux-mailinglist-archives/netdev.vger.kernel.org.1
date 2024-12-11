Return-Path: <netdev+bounces-150908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEDF9EC0A9
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 01:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4C201652F3
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 00:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D58F23BE;
	Wed, 11 Dec 2024 00:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2jo4Q7P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF3CECC;
	Wed, 11 Dec 2024 00:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733876758; cv=none; b=RBqQ8D6FtxQEGgFyhvxGwltKtsYb86VpP+KRTc/vlNEswRyRNcsrXiNTEbEKYqA4WOXX1Av/SFlmlf04ZFjod4FDBAIr2NRjGE5BO3F/Rs3uQ6SpxMgbJtKr4+7UlLDmugFddye3Jp0jtqnfmLEx4oGuRwkkZHKjP62nDtFhTUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733876758; c=relaxed/simple;
	bh=wM0095OKMvKklc/EiHoH/Dogbj+M7ycnYTry719vZrA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kLVZHUSCN8RC2GK3HzbqVZLWFo/GLBfh0sdHuCzI6T6MDtzhj1bCRZvcP0Pm15PAgn3I9T3JHWCjm3sWbdX7RDaG7KOlLs5sBALYF7dO4bjZKWjgsqbGTfML/khDAB5XB1Hqb4VRUUsXyGd0+gWd3oLDECwj5hzs0Gr+8DjteBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2jo4Q7P; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434b3e32e9dso65615535e9.2;
        Tue, 10 Dec 2024 16:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733876755; x=1734481555; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b8/cayzOhsqU4AsjHcoYJNNhPp9zDbVhe0OrNQHtSEU=;
        b=A2jo4Q7PD1Xxn/qKxNMyI0b6RsCIVfb/seySW6avOtFXVd+3TlKSlNPWzBd59veHPT
         fKbDwJTZSc1ZJNM6jxC/aH+2n/RNQSXUJ1ZvI2kM3Fl3+e2w5AuAnRWKz5T7B79lSUb3
         zyqZ7DOVk09j/5r1Ww6mj6u8YNGzvlxmHTrY3yrK51Z1zLEL0KWe56tGlP9hB8s5gfb4
         xnmx6A9lYgWFe/VCAZC8gG7VLkTg4kv4MgbPNIBNhXrxn/ybms8wPWhGJjnuIGIf1gsv
         nQeJGkoGW9A7g8jshCIlmj8KXPJ5R/Tatp+dxxiy5mRsJSe6JjmGALukjPhaXyV2ZGzN
         2QKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733876755; x=1734481555;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b8/cayzOhsqU4AsjHcoYJNNhPp9zDbVhe0OrNQHtSEU=;
        b=GTeZEg61qHEQZFv9O5x78I9CE3BZPLZ+FRKao6kVwOjtGv4UijNOYmMv5TD/K113VW
         L9YRqwKHJxrFHb74794cZXqrMf0aTeGoySGjMtc1kcpi4HyrDjUO154Xh3sCrAVET+NF
         e9DMi2LtVIiQhuL3XRJoOzm/ydA8IqShNZJWZwCXl2rQNY5wPdojLls/XiZ9ZADLkH/4
         5KXS4yTDDlcV7vRYpxJAWbnOMTRTeAgh3e92QgaCGotA8fNZVFMpgUSP1rvNikz4dTwB
         Hurb098HJHfilQwL0L0d7lpY9SpqABi5dfipNYmsTHluFsKLJOkpqZAMzsedUo6MTrTd
         9++w==
X-Forwarded-Encrypted: i=1; AJvYcCVveNr51Nq/9TWJzv9LM7/9oZeIx8K+FUyiztKxkjoL5OjzDgn6km05s6nXxVR5RTcgGPh5Kv7h4IQ=@vger.kernel.org, AJvYcCXOLINFNMVqr2ZoKZ7KOWjG3PAldxHODFJjB2Xfq0dtIloVwR2IwsmLuXj8gaz4pnMRyZO/ozl+@vger.kernel.org
X-Gm-Message-State: AOJu0YwiwKyoO7mifpuHEIXe7Mavdz1POlMmsbi+8yn6GWovuQGxh3I+
	v5Oh1zTS1TVg0vr4UcQyJFmP2F5sW/YYIuY2nCWOCFYDDaNxU68y
X-Gm-Gg: ASbGncsrrLgNMj1iXUR3ko+WdMckHMJ+5gAt2coxiBUoEJ35UV9sfJemHyVd+aPHSKm
	Uua7NCxEx6Em+A9SkzraPf0rGpm4aVmeL66v2Noihq34mYJ+5e1ii6PPTKLbh/RWPyKYWIa1czI
	eljpe/wft0zau712ZcuxutTvEw9giiZsf7MM5uluaXHJ2Y2Ef/iiD3crGK+2M7ZkbISefDsfVRR
	NcZ1KmCIioB6or0541c+zjYhDcKJdogP06guWR50IK6G2vRvmQQQD2DGTChVlsrXB60Cx7KdoMz
	AqMgML149mG39xw+jcSsh61YtL99WR/GjZ/kJWsGTA==
X-Google-Smtp-Source: AGHT+IEbklDrWieZb/9EH2a3HH/nUivEqGeY6jHRu3CMCKacFrbHJNqmZGkjSYN3YcEO5JWySX+qNw==
X-Received: by 2002:a5d:64e8:0:b0:385:fc8c:24b6 with SMTP id ffacd0b85a97d-3864cea22d3mr572955f8f.27.1733876754762;
        Tue, 10 Dec 2024 16:25:54 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434eba653a0sm132327145e9.22.2024.12.10.16.25.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 16:25:54 -0800 (PST)
Subject: Re: [PATCH v7 18/28] sfc: get endpoint decoder
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
 <20241209185429.54054-19-alejandro.lucero-palau@amd.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <d3646edc-281a-1e43-4db3-dd4b29e4ef3f@gmail.com>
Date: Wed, 11 Dec 2024 00:25:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241209185429.54054-19-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 09/12/2024 18:54, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl api for getting DPA (Device Physical Address) to use through an
> endpoint decoder.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>

Acked-by: Edward Cree <ecree.xilinx@gmail.com>

> +	cxl->cxled = cxl_request_dpa(cxl->cxlmd, true, EFX_CTPIO_BUFFER_SIZE,
> +				     EFX_CTPIO_BUFFER_SIZE);

Just for my education, could you explain what's the difference between
 cxl_dpa_alloc(..., size) and cxl_request_dpa(..., size, size)?  Since
 you're not really making use of the min/max flexibility here, I assume
 there's some other reason for using the latter.  Is it just that it's
 a convenience wrapper that saves open-coding some of the boilerplate?

