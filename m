Return-Path: <netdev+bounces-76902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6112F86F582
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 15:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1653F1F21F11
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 14:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49625A102;
	Sun,  3 Mar 2024 14:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ts34U3IO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254B359B78;
	Sun,  3 Mar 2024 14:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709475757; cv=none; b=NUFEEAeXqrzRfySMBDfxqAuix+QFre5BBCUeQSlwAGEiHt8qvvQ/ogHor9AUsDb9WDQrVSWmOojfM+PgyNgLAeiQhSQkfcwrbDiS8zk5IMdDjDKYnJrXyar6FrlHibCFXX4kmD14v4PUeOOetjKK8idu77flKtoJBqTBBVkHbcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709475757; c=relaxed/simple;
	bh=dEoI8+Y6evE+5Ghh9a8OXg7doC5akRrXNHsbHzSrFUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qTq2RhD8JzM2pWajdjou7/oq1il9Q0bUzabEaPdLLBSYI38BCwiQtG3/DOT9Dz88M9tb4Z5Bvy7JEY8AWOeXE7oHTkovac0bExMObxUj8Q27kGiEfxjMEFEkUmc4Ap64KqXry+bfVLmJEE9nl6AXT0uMheMdQbEgReczSXikSZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ts34U3IO; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d208be133bso46278891fa.2;
        Sun, 03 Mar 2024 06:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709475754; x=1710080554; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1/ki2/RE7Lf64PFKVEEzHdKXP6S/+P7mkgvPKDo5WrA=;
        b=Ts34U3IOAUUfLJh20h3WVnt5uDFWLq7awzzZsCe4GQ4c+F2ttDw0vSehtjhsLSU/gx
         +J2ZLJ9Z4kuCFCePJu/IsL3YUPCQtTm0UtqqWP8Nw6DpVn5Nf7ub6XG1M6ysmeqSp16v
         EOYAda2pKQ1Uv5Fse9rVwDnBWRqH+JPN3BX8xFTcImyrX6u2rbjWXiYO+udWkahpOoeC
         wd/i1fhThdkqVKKOlhIj/d/p+LcPE+UCTOY86jHWQM1/OpkmKiRFp4Vo6uPTKG306i8b
         /Af1hlHgasA5z7XZCiXqNNKp9xhRoBz9MlLkHht+t4tg7EX7V//8e7J0QidcE9ZrLHLv
         FwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709475754; x=1710080554;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1/ki2/RE7Lf64PFKVEEzHdKXP6S/+P7mkgvPKDo5WrA=;
        b=vfecoZXBXk0XvgSkMahDQuUXn9Un8B9392B1BA1frT5zlcXQau6jPtizFniOX0wDQv
         cj/HZXb/thIPrvJfdbYxdsykcnFf7DAKfjfjKn9yBwIUlwP03oJaqJbARqJtyjjsYxJ5
         FWfHOjlXeq25Nt9WmUYPcCoXD2K/767UYyViYveafsXw9bdQgX+V5SGNe1ZzEcDO7Ebg
         FdZuPvUkoS2yXcN92VZ0CBmrYVX5fk8dBQdrrtK+gCzdlsZt+Eq3VC5PuRvaXK4W3Gae
         H3GIhtlHNjChPgny6oRiNxRuMsXmPmAGQmAS3lgxZlhQWbrycjGCi2ghvikKoP5gI+SK
         LDBw==
X-Forwarded-Encrypted: i=1; AJvYcCVcWBm7egBqHQC0bHVFG3nfA4XT5vNT9tcxfDix2IL4MuubvkRLRKCMEs1iDE7upaDhqiAM7L3/VJYDIqnhtTYvy674zbpUcQkgarZbjlJSFPFuWSUUSyegPpAGw2fsR2LOAw==
X-Gm-Message-State: AOJu0YyG81AGvGX+vRah9BtdwSET9L/IXS5ewBD7WknwDbpy8vKcD54d
	izx3Qoft2hfP6FNo9GTtZE8Z3WwwafCfKZuNVfLcSUyfR3aPMW9T
X-Google-Smtp-Source: AGHT+IEalUf1X6Z6TIye7uXheYO0SHCuJXcB+Aa3XVNG85+TOoOyvPR8FFd27AQCLzC3AKCxgVw+Bg==
X-Received: by 2002:a05:651c:19a9:b0:2d3:28b3:d9db with SMTP id bx41-20020a05651c19a900b002d328b3d9dbmr5327982ljb.16.1709475754071;
        Sun, 03 Mar 2024 06:22:34 -0800 (PST)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id s9-20020a508dc9000000b005651ae4ac91sm3499722edh.41.2024.03.03.06.22.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Mar 2024 06:22:33 -0800 (PST)
Message-ID: <049689b5-2b36-4dbe-b910-5e570618ce05@gmail.com>
Date: Sun, 3 Mar 2024 15:22:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 2/2] net: phy: air_en8811h: Add the Airoha
 EN8811H PHY driver
To: Daniel Golle <daniel@makrotopia.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Lucien Jheng <lucien.jheng@airoha.com>, Zhi-Jun You
 <hujy652@protonmail.com>, netdev@vger.kernel.org, devicetree@vger.kernel.org
References: <20240302183835.136036-1-ericwouds@gmail.com>
 <20240302183835.136036-3-ericwouds@gmail.com>
 <ZePicFOrsr5wTE_n@makrotopia.org>
Content-Language: en-US
From: Eric Woudstra <ericwouds@gmail.com>
In-Reply-To: <ZePicFOrsr5wTE_n@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/3/24 03:37, Daniel Golle wrote:

>> +
>> +	/* BUG in PHY firmware: MDIO_AN_10GBT_STAT_LP2_5G does not get set.
> 
> EN8811H completely lacks MDIO_AN_10GBT_STAT, hence referencing
> MDIO_AN_10GBT_STAT_LP2_5G here is confusing.
> 
> Suggestion:
> 	/* BUG in PHY firmware: EN8811H_2P5G_LPA_2P5G does not get set.
> 
> Or just skip that line entirely as the following two lines already
> perfectly explain the situation.
> 

Thanks

I also have a reply from kernel test robot, so I'll need to fix some more.

Better to see if I can only send to the test robot first.

