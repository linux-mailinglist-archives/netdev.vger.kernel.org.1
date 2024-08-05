Return-Path: <netdev+bounces-115923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5138F94866A
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 01:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 073D51F23CB9
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 23:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A2516BE32;
	Mon,  5 Aug 2024 23:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCDYhmwz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3129416F850;
	Mon,  5 Aug 2024 23:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722902062; cv=none; b=j+9vEwFzy+si0yZQgI5oQQjLShTpQm8+eMYei897B2F7ZPXCibWtWuuzSM52QSSFFPTniNZ+ecgkKbUs8qd6Cq2BQvSZpvOMuhPGcSzx9Pk1Df5RumLtGmvuEds2Sa2WaX7Ea5onqXGlyGJcLToSLMAL0XofdmZIlJNfYA/t5EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722902062; c=relaxed/simple;
	bh=CN5YyONF5oxc/Hb/WMwxJ5h5JLKd/ev5Wby6OiPK5xQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BVGeWb+wxwSXNSac/zOeUc2z9g/5tj616b8WNEW/kDWOcPAT/0JZEH7WSEz0WkL/q/Oll/Yrv0ZrmAxYymu4CIfN2VaL1maTxr0Cw11QY2ZH5EKV5pZ7xT8o35ssoiHW04SGO6fLD0Z/yj/K6gXMnpojJDYT4NkENh+LvM4cTQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCDYhmwz; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a1d81dc0beso656385a.2;
        Mon, 05 Aug 2024 16:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722902060; x=1723506860; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YWc14kDySKSh3sWURkdqCJobA5WfeILUoFE6tZ15XEA=;
        b=WCDYhmwzABz614P0Qosmh3ONC6pys18xp2ycw6Md5jP7P3zxhIgRPt1tN1TpxsnvXX
         74/yfwm7m3YxBS6IT6wJeKu1xTicifTS9zSasLX+i7Ce+kERI42jV7zGybWU5sn3KaKW
         vESA59FmQ51s6tP2XNIluk5iYKzmbhouQrsBt/70EUfHerYQvoNGh+ZSL8y958o6WD5D
         GDy2KLI8UubXxEzvDfzLtgfK6p6C+JwJ/+YhkhI7ZxrDgUzUUjOZAbdJtiyJ+2upv+8Q
         7TY50s/nFCXkUpMhB3pbXgfCrdgvXWVATYVKxjSNaMBvrkysv8iPPalJZBMxMQbyIPm8
         guCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722902060; x=1723506860;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YWc14kDySKSh3sWURkdqCJobA5WfeILUoFE6tZ15XEA=;
        b=iXBihcYHKJg/LnEDOwX5hofA38s6Boo/FoUjHlZciO7WLSsgiIt1M1sWuIHVa/lq1j
         WlEls0wvUn29JHqWVOuxXrrqaZQ2mrCam9pB66z5L4Dp6TuUQylgdUKZKBQ7Wpm62wYz
         cVype5pvoyhvMvdQydCM4onQStlKpNjJm5Ze0DijX36bQqIEfksNLUHs3e98VzdgfU6z
         PqbEGPnDlB7Adg+MC0TI0STIgD0MIsB3btrpwLQ36LlOiFfKIJslmYngIppJLeCEM8Gu
         Sv3WTO3ln1+tqq3k9ddCyB1wu5Oj/gZZOTIyTyDoVasfKgu6JZ8FBaL95mUw/IUtEpvh
         Orvg==
X-Forwarded-Encrypted: i=1; AJvYcCXc9pCbjk3M7k+FiiU6hHpYMyksXITQ1XzDMJG2CYB6XN2TZYKowMuLnYsGGCZMrQlgtdACbflEtF9fpd42SOXGEpmtBWdig7vDG4tebl60MAig4KPB4LI+TbzevWSdxQxat3E5
X-Gm-Message-State: AOJu0Ywv/NzrFxyBgsEMKA5e+Hra2U7x5qOpifGsqm9SrSbrQE4VKLym
	1x23QKVjeWBvskgCzXcXcePK2+Qv60wVuZc1v9FUfkVooZr59LHo
X-Google-Smtp-Source: AGHT+IHKkWH1gJGXMhBpgClsAu3LULO2nfx28Yb5L5lMQtQQZncx/n5DKnhJ5pPu3TC7uyyrVuYadQ==
X-Received: by 2002:a05:620a:28d5:b0:7a2:c6f:fa4b with SMTP id af79cd13be357-7a34ef0aae2mr1714810585a.21.1722902060058;
        Mon, 05 Aug 2024 16:54:20 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-7a34f78adadsm395310085a.123.2024.08.05.16.54.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 16:54:18 -0700 (PDT)
Message-ID: <5446a293-b5cb-4d1d-b82e-6a63aed03b2a@gmail.com>
Date: Mon, 5 Aug 2024 16:54:15 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: dsa: microchip: Fix Wake-on-LAN check to not
 return an error
To: Tristram.Ha@microchip.com, Woojung Huh <woojung.huh@microchip.com>,
 Andrew Lunn <andrew@lunn.ch>, Vivien Didelot <vivien.didelot@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240805235200.24982-1-Tristram.Ha@microchip.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240805235200.24982-1-Tristram.Ha@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/5/24 16:52, Tristram.Ha@microchip.com wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> The wol variable in ksz_port_set_mac_address() is declared with random
> data, but the code in ksz_get_wol call may not be executed so the
> WAKE_MAGIC check may be invalid resulting in an error message when
> setting a MAC address after starting the DSA driver.
> 
> Fixes: 3b454b6390c3 ("net: dsa: microchip: ksz9477: Add Wake on Magic Packet support")
> Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
> Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


