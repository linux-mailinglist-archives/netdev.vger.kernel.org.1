Return-Path: <netdev+bounces-131109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DAB98CC09
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 06:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8795228677B
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 04:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE43317BA9;
	Wed,  2 Oct 2024 04:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UB+6n0qy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF1914A90;
	Wed,  2 Oct 2024 04:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727843360; cv=none; b=X71gSOkbd1Oaqu3lrC/ul6I5+57JwYZzRkODIoPoX41MRvDTz+PCM72bNoZE/TaRda9V0xUmk9a2K5g7J/McOi6166SXDV1laDbUIhd9Z0Jgzi0PSxi8gtuyyNc3GQ+R6CTuSXjgiGQwtjH2oQhRw7JeO6W0aro2zERiRR4mhLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727843360; c=relaxed/simple;
	bh=DCzmD9IPpEPwpla5NfgLsIuzVkeaLq5oPqeKUskXVlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oz5xBvKBgBrUNejlyZL9TrpW11favASRs1uzObWFKWn0v+oOntYbqlYKIb31mSGLKyUtJGPAUKJ6TZcBU/guwRjcS276fn1Lts0ncqZ6av+adCTU3mSqpmlzrdEuzJaulJb2uoE6L3OkjJGNYSd3WPYtSANZoh2c8niQnJczq1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UB+6n0qy; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20aff65aa37so50063605ad.1;
        Tue, 01 Oct 2024 21:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727843358; x=1728448158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgNKPOKqhHd0+yj/GvA9YfAaPfbTAUbJ+liUYI4I2bQ=;
        b=UB+6n0qyI6PMLDsdOLjcnRAsz8+v7JDOefAOxnDPgb0B3OayR02+DihgGEmsnmLta4
         EphufFKXqYLozaZ51g2hykenlfel0YHDDZIAmBjaxVweiXHT7KYvG7Yz58hgpN7wHBTh
         /yPWdc8qTk27lBb6oJ/jpGvYujvKTh+6ar5u1CHJCABvPmM670Zh6/WSNuix7UmvnYTX
         TLyJreCzdraIFwyl87Y6gRLHcp4W7E4tBjlrDRUI3k/Gwoit8ogCdJ3JKY3i1H16zCgM
         WNekU3CIXVHS0UKcl1Va/B5xjWp3TZpSp9KCaECz9hU0FCkuoZ+MrUBExZ8Iukkbn0iA
         +lzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727843358; x=1728448158;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZgNKPOKqhHd0+yj/GvA9YfAaPfbTAUbJ+liUYI4I2bQ=;
        b=cCLAd/YYiX21FuNh4SBtvTrw6+P39slc426m+oBJNPXioCH15OuUxfIPVUSGAKcvGe
         9EnC3KB7txalVKSPmBk5E8LlDakEkKNfVbr1nPKXwEzRLkLmFspCtB4RAjyPaxNSxIDI
         31a1GVGVYzLXwWO3NduBexvRU7I5r6nkBFR5h1EAH1ijoBWOMbysvVCF9vZfEWjrrACj
         3KV/xhjMSzXFZCXuEj6407ooK1NLDq5X52Z0x9E08PAccug4G8zQ/dY6Zt3M7Jsbps6V
         VaoPb9TX3oc5qjmlpozCmFnhdGLyVvvRruJ6BT1kgy0r20wjM/QHbhOGBvY20evKzo8m
         se1A==
X-Forwarded-Encrypted: i=1; AJvYcCUrkF0NYs4td1wwD+1TAjRbIuA4EGsURXPR9yuqvBX3BzDvVjHGQ0h31kE2Ne9IEFb2pvuzz/ih@vger.kernel.org, AJvYcCW6Bjjx1fk0T6LOXMsI8XepTavEI1y3nT+VPKAPmmsLF3pabmklGSgJ9EP/Ih2C93gZMpMoL+X2bFZDM3tE@vger.kernel.org, AJvYcCWeHRch3JJAhEkxXEIACqurbg2TL1Y+F8vz2Pxjm1DaWDyizeTl/dxu1y34EtsFlSkHHWvifCalutq2@vger.kernel.org
X-Gm-Message-State: AOJu0YzVKPF/zZYTSQAFIFI3am36XvffL62Lx/ZR4nwHAAMckhtXXb3Y
	GVxB/VOeFYcCF25fQzTRSLopSyr/j0Myj9WpIuG8gW09Z0yRub0X
X-Google-Smtp-Source: AGHT+IF17lxCTxtFJRcqcWe90SIWSHBLdPEh++vUCX0AGStoX/SOBu28zhLTtwBWKTebRlGGDcEpoA==
X-Received: by 2002:a17:902:d2d0:b0:1fb:90e1:c8c5 with SMTP id d9443c01a7336-20bc5a42c3dmr28274585ad.33.1727843358398;
        Tue, 01 Oct 2024 21:29:18 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e62103sm76780725ad.281.2024.10.01.21.29.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 21:29:17 -0700 (PDT)
Message-ID: <2e5d5c39-201c-4087-b176-30fa7313a65b@gmail.com>
Date: Tue, 1 Oct 2024 21:29:16 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/2] dt-bindings: net: ethernet-phy: Add
 timing-role role property for ethernet PHYs
To: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 devicetree@vger.kernel.org
References: <20241001073704.1389952-1-o.rempel@pengutronix.de>
 <20241001073704.1389952-2-o.rempel@pengutronix.de>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20241001073704.1389952-2-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/1/2024 12:37 AM, Oleksij Rempel wrote:
> This patch introduces a new `timing-role` property in the device tree
> bindings for configuring the master/slave role of PHYs. This is
> essential for scenarios where hardware strap pins are unavailable or
> incorrectly configured.
> 
> The `timing-role` property supports the following values:
> - `force-master`: Forces the PHY to operate as a master (clock source).
> - `force-slave`: Forces the PHY to operate as a slave (clock receiver).
> - `prefer-master`: Prefers the PHY to be master but allows negotiation.
> - `prefer-slave`: Prefers the PHY to be slave but allows negotiation.
> 
> The terms "master" and "slave" are retained in this context to align
> with the IEEE 802.3 standards, where they are used to describe the roles
> of PHY devices in managing clock signals for data transmission. In
> particular, the terms are used in specifications for 1000Base-T and
> MultiGBASE-T PHYs, among others. Although there is an effort to adopt
> more inclusive terminology, replacing these terms could create
> discrepancies between the Linux kernel and the established standards,
> documentation, and existing hardware interfaces.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


