Return-Path: <netdev+bounces-196696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA03FAD5FD2
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 22:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B7383A8F5D
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 20:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D365286D57;
	Wed, 11 Jun 2025 20:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBQN8TI1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01DA22E01E
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 20:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749672526; cv=none; b=dDBEpoEmYwvlXf2bb7vclosJlthMrmralwq1osHw0NWabcbzDHyjGExJhtuzaYYWQoilo3hBJb0uvP6ESWobgvDFaLgUNllJX/4/0ZRVNCOxW2AMxdcod2zSEYTHlApdzFrr5vQkx/g6cIwZGm5inHfPMwS9+fb4GQrO0BBhHXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749672526; c=relaxed/simple;
	bh=6AhyEK5giZWmGi8bqGKQJGz0VU8Md9FsF+tjvwF0y7g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=RCeHpMEkuLgALpF4n+pQ63kzFVRdayZEm94Y/9sivinCr2tmt8a7Egz4WOhKW0MEhB9Wn/4Rm2aUKixBd2Hcjq1qyU769EPW0NwfkxUNfaZCKC6b3Cp/GuyeFzaH11AOomVSDB5hLRGuk2ZS9f/Ku+lCtAh2+baNh2sBAH+NkEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBQN8TI1; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-450ce671a08so1040295e9.3
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 13:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749672523; x=1750277323; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TjVtKIM5pPO+K8LZ5hfiImShHvU2AYoeNklXm9bz80o=;
        b=gBQN8TI1v4+LI3j3ELzK64lynH9JQy5iiVZuIiSXt/sYesOI61fSHU8C1XRI7oHHCl
         XLwxN3YElmtprAOgQa/3fpO5g7VddAHjtr98vENlH1OSrMcp2cTptD6PPGz58e48s/Bs
         u351XV0HKk6WIkyzY7QqermkhE+CRClLH61tRoEMWoATIoRhq5QXXlXH4ITf0+52O1XU
         qXwYxsH5BZxykvkfYufJK6bDAyRyjUT3PV8PrHAkSJ2MAVr6+e14b5oUmsCj/AgoeBIH
         J6bQI9wj/biPWb1Fkr8OS5dl+JMeSIyd8zmwVl6MgTEBDMhwJv2fEhg5AW8f7/4GOo0C
         Mylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749672523; x=1750277323;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TjVtKIM5pPO+K8LZ5hfiImShHvU2AYoeNklXm9bz80o=;
        b=PJykwQkEOuYF7OwsJzGDxtTYptu7ghuzl/gFpZmttTOJtJSSO/CIMgIZ/8SC8n8D3j
         GQqjeZzqDiW7LvU0cL3aeNmE438llNcCgEJ3HNeAlUDZenGPDuLBhmCHxNWeX51TV/Pa
         iPP732inXM9YHvBXRx+ssYvYE5kJYJ3yEUyB19sa84rV9wRunlb3PWaWqHkjjvQRIeZ9
         iBbktNhnKkK2/O4pXB15AvURpdofOoYDvS517lG44zrkWrb98Fk71WW2HC6czLTUGjrN
         VMLG/DSbOGHH3fmQJrmLNHpFZJAwlCZY/YddPvTlMhTHOMK7zP23wWpDAeMaLXX0OfA5
         lWcw==
X-Gm-Message-State: AOJu0YwSegcaURrgZn3TpRLkZ8o1pNHfdHnI0gQgEnLiX4ZlboH3ljVD
	awTqNx8QM7c0M1csJ+IXXLISxplXNPDCqud2Qpy2K1VJBaydnHR6oGq5
X-Gm-Gg: ASbGncuhvrhG8jKMUQQPV1U1sOCkbsAmMjZg1W4I7bnJfg9cTF0vVzaMXvY0dQOMypL
	29hh3dr1hWgUzm7G2efmTLuXs4+o/3SThd7yaOXwBL9JBmcdAFCuiOMb5m22X/gTZNGIijJiy6C
	1qB3DBIeZ047AYVftmspai0Z/O3ocZALI4BzQi3n2sEMrXJOJopl7W2Ioxqx9SlHasUAt/9vsKo
	c/QUYe4jHjQZT8188kV3eB+68K/lYC5t78fRDCjTj4ffIWrPMomh62IscLAiqerHcT3cM9ANkT7
	x9fq2XI9yn6nl3MQv9EdtTh3rUUKknaDHpV93dretit9TAQgxVA3E3bu0zSj7Xf9IUWjq2N8DGL
	GriIwDMWzm/1JwNLaJz3z2FFKKCq0lCbmRe42vC3sS6K9kDIvoZGBAIDqPI9ktZk2B05X3amBL4
	Ar6KAQGJkfgsf4wmHn10SPFYvM/Q==
X-Google-Smtp-Source: AGHT+IEDaeL6TnggTf2WVPEZKqSCC+0+Ttje/g5aVuHTgWF8OX2yncTpu/2C8jNfe9HYuqXU6h9cJQ==
X-Received: by 2002:a05:600c:5395:b0:445:1984:247d with SMTP id 5b1f17b1804b1-4532d293cf5mr2781755e9.7.1749672522952;
        Wed, 11 Jun 2025 13:08:42 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f1d:5400:69f2:2062:82e9:fc02? (p200300ea8f1d540069f2206282e9fc02.dip0.t-ipconnect.de. [2003:ea:8f1d:5400:69f2:2062:82e9:fc02])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4532da8fc18sm465685e9.25.2025.06.11.13.08.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 13:08:42 -0700 (PDT)
Message-ID: <6ae7bda0-c093-468a-8ac0-50a2afa73c45@gmail.com>
Date: Wed, 11 Jun 2025 22:08:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next 0/4] net: phy: improve mdio-boardinfo handling
To: Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This series includes smaller improvements to mdio-boardinfo handling.

Heiner Kallweit (4):
  net: phy: simplify mdiobus_setup_mdiodev_from_board_info
  net: phy: move definition of struct mdio_board_entry to
    mdio-boardinfo.c
  net: phy: improve mdio-boardinfo.h
  net: phy: directly copy struct mdio_board_info in
    mdiobus_register_board_info

 drivers/net/phy/mdio-boardinfo.c | 29 ++++++++++++++---------------
 drivers/net/phy/mdio-boardinfo.h |  9 ++-------
 2 files changed, 16 insertions(+), 22 deletions(-)

-- 
2.49.0

