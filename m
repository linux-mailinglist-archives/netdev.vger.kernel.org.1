Return-Path: <netdev+bounces-98701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5A18D21DD
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 18:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 590B1B216A3
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 16:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D3C172BC2;
	Tue, 28 May 2024 16:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAklmNzF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D93173339
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 16:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716914753; cv=none; b=TgzYk6OLVlWF+/rvxy/mdTUuQU0++yrgA+9UZQjC4DPBZOFlZrQx/eq4LI8zkRcOas4ZKwbBwkig1Lx/AIwIXTgVUsopr2Cramfj9QqCGid7Ss8cekkC+rxzaOiCKxMvoUmn5IUK2VVG75fGJ9FYvI2sZ6wZP7zoJsHlA8syxno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716914753; c=relaxed/simple;
	bh=WZloa0ayjO3bBzOlxz/OylG36/iO/3Oe0r0x/QDGpTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HmrKg0woN5LM72XtSpbNvQxlcr9tv/rDVrD+TpondYXBbWSN+8u2BYKV3zW6OjbzFBSNKzlhS2xyvc/OGvyr/d76b89emEQQOQbSr45Jb/jzng30BtIOcQllypXTUoGNaLE5LP+TsrBL27fkdljg7CAZ61O6hfJv9S5BuuJSD4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAklmNzF; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f4a52b9589so9504075ad.3
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 09:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716914751; x=1717519551; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q2DnNuYG7Sjbq6oiWffLP+yNQNt0+96lDSUHoEoDRcE=;
        b=bAklmNzFO/0AFEylbqNMtP59E/PIeJdaJ6twyCzFcaCImpzsqdHMnuPrdNqhGTg0ma
         DYoQq/0uERev0fT20XjPs3RUqocdeu6LoRjZrqoJsh+BSXgu0eriSEHexTOoj/IRKr7Q
         E4xI1bA7ureXBnGqQnPTIoe1PPEyF236/A2kZ8EEBNcwnF7jZDwNroGJPepG3cTmIMBK
         RKpU0bxj/8p+0SlQEOBF4aUdOvSR4V5dLUy1dHtuaTXANuB0H2TB/7VQrgPddOQ8qwZm
         YxafrnzHkH6G0NaPZTcUj8DrbQ4Kj1Edwoa6BHDHuQPprcGmEBVmbMc3EL7xeOwNVN2A
         KzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716914751; x=1717519551;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2DnNuYG7Sjbq6oiWffLP+yNQNt0+96lDSUHoEoDRcE=;
        b=pZajsTsVcZDLxXgmkiBcUvHgIaCJlbUkl3thwEuZe1G6PP9giLXbwyblZE5XC3emOx
         QWG1hrJ4mLgnckyw7SFs8gJVHfeQTYG1HSnEOTcm+7rpcyDx/K2ARIekbAVtxeAp7xea
         uR8yLPQmVr3/5PeyZ0vmU6kjNbZTqYNcWZa/zrG5jT9rM5caLgMamV2RLasZN/HwTQOt
         ZquuAFAXCFMB1MVnAbiXzHwK4gkcdcD/kTpvPcArTw0A2f3l3HQ12DYGw5ceZNiqjyAk
         AVNj1/RUSFFQIGk96rKpiX0u1tAiS4T2j10ssxJmWKCpSjU8F+I4HYCKi8oG2zDC6f1x
         NNmA==
X-Forwarded-Encrypted: i=1; AJvYcCVLmj96s8aRXAaDeqE+JTKbFCSmEgxMLAwxXHTEMKAMPFNiM0WplUmFxMKm2sr28liVZIEf21vmmT+SRO8pysu2g3CXcleF
X-Gm-Message-State: AOJu0Yy5tndHhIQy16YczJcINhIHoRmNx9o7dkHR7SwjdrKN0vzMb8cF
	ViIys5Y25SevJ+/ARcWkTYHqlhmd57/BwXC8btS6WtJgJlPU81sq
X-Google-Smtp-Source: AGHT+IEsHz1SFt7MVS5Mlh4UloUgsjx4Q/hbGrRQw+ioV4j1eY0dqniRsVGV91pZj9bU/KLSlqN+XA==
X-Received: by 2002:a17:902:f788:b0:1f4:26e1:56d2 with SMTP id d9443c01a7336-1f4497d7a4emr126520265ad.45.1716914751318;
        Tue, 28 May 2024 09:45:51 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f4724a47e1sm60887145ad.194.2024.05.28.09.45.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 09:45:50 -0700 (PDT)
Message-ID: <2b4ad941-ab18-42a0-9bb9-cf552a04fd69@gmail.com>
Date: Tue, 28 May 2024 09:45:48 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: dsa: remove mac_prepare()/mac_finish()
 shims
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <E1sByNx-00ELW1-Vp@rmk-PC.armlinux.org.uk>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <E1sByNx-00ELW1-Vp@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/28/24 08:05, Russell King (Oracle) wrote:
> No DSA driver makes use of the mac_prepare()/mac_finish() shimmed
> operations anymore, so we can remove these.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


