Return-Path: <netdev+bounces-74700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CEB862434
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 11:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 889241F23063
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 10:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F142820DE8;
	Sat, 24 Feb 2024 10:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XqwXyx1U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487051B977
	for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 10:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708770222; cv=none; b=g6ft9PTRHmww/QveNKrft8giqsK4cW2bKQGjnxJhCNmtzCwO0pBrp+7p9twh/79lfVbkRRJ5iwzeSIzxQUqEoFz/1AXP50a93Iw0JVB8P2dhfHtfNKT42tWq6TmVTcQRQHtG5ik/DU+alnfMyVnxq49ghOcDMv0b72a1dDymX8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708770222; c=relaxed/simple;
	bh=T5wrB1y3FYrvfympAhsC26CiLclm0cOY7uMLJXMSxvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e8y73aZOM3q9qPFnzzVZ4tUbJ0y4Fsq+gnhQchNlsHfRzwcgy0tMLu3KID2U7XocxZTuuaViG0Di7eM57xleDhzAjNAySkegQrf+uE+RjBGgGHEYilMIx7uS/ApIb7+2W4y43BQ3AFHVYfkkbrFdjrPe/nvUF1JC08ZIZNrWZxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XqwXyx1U; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so253298266b.2
        for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 02:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708770219; x=1709375019; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BQ/3iA+AtMLXFse8PzJU2UeHtHNyq+EdQg0glBo+CF4=;
        b=XqwXyx1UlDOm1egwDf728fsVoCCVnbpHcTYxoGrb01UMiD4iMxrMgErF0so/zDdu9o
         KasUbJ9qaEIna6pCYscQ7dm1nY4EfM/P91ZyRa1+hDIM0f50cMjIhpYtrhZseQ+Uxtql
         mO+3xvAF49yAgHW/C3HI+PzadSVuLSZKy2cWxGid1qlH9+5VYT4B7JSXc+f/ynJlw/eG
         el/qbiynLBXbUlelGoQ+ub+hB8jn+dBCJn517heBCDWhVbK5GFCEmHyAhLwmUAp4GDvm
         obbj2h8iFzp3nytXnqOUAjRxi2bBs/g/GgWagwxG3THbbSUreOSZSfHykgXdSyPFZ0x4
         heWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708770219; x=1709375019;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BQ/3iA+AtMLXFse8PzJU2UeHtHNyq+EdQg0glBo+CF4=;
        b=Ixci3B73T7WwYo2VBZ90AtAOvoofmfasykrsUmryJB+tdNyc4EIY8mUhCp5gRQsas1
         ck2WBZXWSBalF803NfujWIXTAMiwlQSFbI6YNkeLOhMq51Ar5SEmOBj52I4gcViP61LG
         gU8xJQOw8O6sbVMubb+6rV9DF41r+KxQ6JX183NC3Qdd554vnBSfZWY4ClfvtOpnzR0q
         6++rT/6mvgOXpBf8ye470sCHtR0+fFnXION/+2Ag2ucuCzfIIXFtmMXniRfenJFGioIJ
         Hfaw9nWBocDLqHiRT2Lb07IXMHtv/37L1PPXo1WxrqhsLvmOAMkm1wJZ5BZqv0mO9RYv
         ocpg==
X-Forwarded-Encrypted: i=1; AJvYcCXXSuW1123YnSjjfPejmtT+SAe974IZinY69waFEZunfTshT81iBAgqi/153RuqwmzdFqeca2SZh/kUGhYgRs+1t59/R/4u
X-Gm-Message-State: AOJu0YzfrFTfho3eS+6uRc1Q7ZshkODt6kQqfaIgpny6ug0u4jVToedl
	hQWE+cmY65O4Mk1e4ZDQJUTYT0HiCdzXPxZa4G+Wd610e4XWP/sFJRFlmb7+KSY=
X-Google-Smtp-Source: AGHT+IGHDhuRWWZ2E/Nf6I4QdU5ILwIBFV6sZW30Ka5ZkIh2j6dzEZ8gWXSqNqhwOo7zEnwUdv+wnw==
X-Received: by 2002:a17:906:528c:b0:a3f:d1f5:c954 with SMTP id c12-20020a170906528c00b00a3fd1f5c954mr1379362ejm.20.1708770219661;
        Sat, 24 Feb 2024 02:23:39 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id k10-20020a17090646ca00b00a3d004237ebsm447339ejs.212.2024.02.24.02.23.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Feb 2024 02:23:39 -0800 (PST)
Message-ID: <b2435add-6f3b-44f1-bd11-68c0dd5268d7@linaro.org>
Date: Sat, 24 Feb 2024 11:23:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next resend 0/6] Support for ASP 2.2 and optimizations
Content-Language: en-US
To: Justin Chen <justin.chen@broadcom.com>, netdev@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com, florian.fainelli@broadcom.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, opendmb@gmail.com, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, rafal@milecki.pl,
 devicetree@vger.kernel.org
References: <20240223222434.590191-1-justin.chen@broadcom.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240223222434.590191-1-justin.chen@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/02/2024 23:24, Justin Chen wrote:
> ASP 2.2 adds some power savings during low power modes.
> 
> Also make various improvements when entering low power modes and
> reduce MDIO traffic by hooking up interrupts.

Why are you resending?

Why did you ignore tags/feedback?

Best regards,
Krzysztof


