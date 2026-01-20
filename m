Return-Path: <netdev+bounces-251429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1975D3C621
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 11:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F4CD6C8667
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 10:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEFB3B95F8;
	Tue, 20 Jan 2026 10:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZiSUcfw1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DdV/SEW6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F66B37BE86
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 10:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768903730; cv=none; b=l/KobanfQn38BW3r4EAW2mrryoltbqk3Yy9ZehJGMdzDsjTnWvx0qHFPIJz3yi9ih9yLnhudFC1n4zCf4qwgbJ72puWUo16rnlJ/8JnRgARfX2JQKSAgdjidWV/wNGT/FDdMHe/B/PNVz6jDI3Pw8gyvk8fqMjw68cdM+6cX9RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768903730; c=relaxed/simple;
	bh=H8E5ZexNwUvepWRnAB8kom9407PvcV1LCFOFpBHsJ7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e/1UN0LZ3sE5hDBpkeCyYW7As8LiJs2aSK57dLCmPkbUXS4z6rqefR9yy71wL/OiAI0DZ9hL0XHZ1zF03zDG4ysAmyONxoxBff/RRgcpbJWorYVKuT9C0GPvWfRDU1atajnYoCOaNHNbY+pETBYH4qwLsH1lxeLAk1Im2M7n96g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZiSUcfw1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DdV/SEW6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768903727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H8E5ZexNwUvepWRnAB8kom9407PvcV1LCFOFpBHsJ7Q=;
	b=ZiSUcfw1/s/HITg2mEY2w6UQIytWHNqdy+FV2wAbSA0XEOvQ7m96K6TaXWBbPXvwjoY0I2
	/mGOgzWhmzZKo3JP6xrDcE7MkbnBVxvNHnbTMmEyaAEQBjUwlIgT5y/nRd3aO9IQ9K2FEu
	Yjdz0oQ0zb562RpibYdx6euuoq7u7aI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-ic07H3CmOPKL8pg4uU0apA-1; Tue, 20 Jan 2026 05:08:46 -0500
X-MC-Unique: ic07H3CmOPKL8pg4uU0apA-1
X-Mimecast-MFC-AGG-ID: ic07H3CmOPKL8pg4uU0apA_1768903725
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-432a9ef3d86so2408305f8f.2
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 02:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768903724; x=1769508524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H8E5ZexNwUvepWRnAB8kom9407PvcV1LCFOFpBHsJ7Q=;
        b=DdV/SEW6MMybPTLHGVg2BrudHoQCh47XlwOtwkKQXk0lRKhUIN9g4wB0eVma/YuUUf
         Q/GetDZMRQjsIYnuELAcPjACDB6T5v2rqweiuD+/Md2oXU0e6QWPH4O0iEtQc66XN8dT
         cR2gJYG7Z8yn9BSpAmJb2938KM1aBxWhkc7GU9M9LVWhszeigWuzGKuenLPPtiMsZx8s
         uyP7FURJrnSP6usgvjy4eLhGJqt6jf19vvsexToNpUPqFe4oFRrZkbYF100DsfzttDlH
         gkSjWzJe0VqcAfMoP9Dxb3Uv6+/jeNoUc7YCFjCHvsoxgr15sHAgPuksTAoTsnb2XLAt
         bImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768903724; x=1769508524;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H8E5ZexNwUvepWRnAB8kom9407PvcV1LCFOFpBHsJ7Q=;
        b=vP8vZsfUYHgq2f7wpiEfVksz+guERqLN+r6BTkLgBoFyrAlRBzJMr4jmTV9gdKiEf8
         lO2ZbRRbE2aY2/VPjGqlRV9rC/n94t3WDj7ct1hM0gvyZn2eve1uK2bnuaFXUKmkoY/C
         XCnS04w9cR4KKgp0DMHmUbTqkjYXuL8xXSS0DQHwNDBjlCxgTG5//j+hjEu2MFj/zqrQ
         sVNwfxTRr0nO+a6qWuk1nOZojMpzlXVAU9+tiPNJvc1t7XJP7X7ueskXfO5wYxG+UUf9
         91rgLq657GApYJQxUiKiiCNKDjCXYKSdz3koxEzIXn++5T4s6fz7mXL4rDLWKlThUmy1
         SBLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMbx6vpI7blaSCbEIV/D1ZS2hav/3XwQ14RnZ6yBWLGhihobnIknJ28BGUuofp9xDDCiVhYRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGf5lZC3OlndcRz0KoO2w335ndNOyvLXY4IgpPnmcdK5viIDhF
	5x1PtoRqT4s9N8E/a1kdXQa81zxDT7i6PfM6OIGs/Wex7MkLG1z/1xl/2MPRtaSKkZt22Ko90KA
	nWlO75vZ0o74uTtpusSrIRd3gJOgprd3ADAflp1YcQDHcLr4XlHtMlu9PzdoAyqFRiQ==
X-Gm-Gg: AZuq6aK0Lu6Y2KYy0Mbw18ymB0y9PAc6qXeN5yjrD/oOKSJ51MJVkpI7Q9dUGX2MZtk
	x3+2XxpURaEcyU9WTCV7AhIJFpJp7A26ABBNHAFguEQZ2IaYuSHVZjcPtRkpz6bPeLkDm1+gkcD
	ZdqjNZL8oKs2y9OUmcFvvstT7zNGbqcIf//vTU36dwpaIm8ZSepCjeEU1iYyrkIxapvlENCVjB2
	NTT5tn2bzc3vYSXaAFaLtbVIft51mSMgtYKN//mMLvxcHqBPlwdom1tlHBT+qlF/MH6Ow3JhgEH
	Ze043v5tnP09zmaJIuknnIdtImJkkyCpoeEeX/2as9OKjCidibSXC+OgMGK5109D1HJOHg/KN3L
	OrwVcExgSX5qv
X-Received: by 2002:a05:6000:25c8:b0:430:f41f:bd42 with SMTP id ffacd0b85a97d-4356a0662e3mr18086970f8f.57.1768903724441;
        Tue, 20 Jan 2026 02:08:44 -0800 (PST)
X-Received: by 2002:a05:6000:25c8:b0:430:f41f:bd42 with SMTP id ffacd0b85a97d-4356a0662e3mr18086936f8f.57.1768903724027;
        Tue, 20 Jan 2026 02:08:44 -0800 (PST)
Received: from [192.168.88.32] ([150.228.93.113])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997eb1fsm28563115f8f.35.2026.01.20.02.08.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 02:08:43 -0800 (PST)
Message-ID: <f35ba439-bb32-4c62-a057-29f45f95083e@redhat.com>
Date: Tue, 20 Jan 2026 11:08:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: airoha_eth: increase max MTU to 9220 for DSA jumbo
 frame support the industry standard for jumbo frame MTU is 9216 bytes. When
 using DSA sub-system, an extra 4 byte tag is added to each frame. To allow
 users to set the standard 9216-byte MTU via ifconfig ,increase AIROHA_MAX_MTU
 to 9220 bytes (9216+4).
To: Sayantan Nandy <sayantann11@gmail.com>, lorenzo@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, sayantan.nandy@airoha.com, bread.hsu@airoha.com,
 kuldeep.malik@airoha.com, aniket.negi@airoha.com
References: <20260115064043.45589-1-sayantann11@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260115064043.45589-1-sayantann11@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/15/26 7:40 AM, Sayantan Nandy wrote:
> This change ensures compatibility with common network equipment and jumbo frame configurations.

It looks like that a significant amount of the description landed in the
subject, which is not good.

Please reformat the changelog carefully.

Also it looks like this is intended to address a bug; if so it should
target the 'net' tree and include a Fixes tag.

Thanks,

Paolo


