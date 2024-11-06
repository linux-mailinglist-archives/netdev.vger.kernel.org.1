Return-Path: <netdev+bounces-142519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 125379BF7E2
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 21:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE5F6283300
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 20:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117D720C471;
	Wed,  6 Nov 2024 20:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OP44QM7k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E2520C015
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 20:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730924346; cv=none; b=Ip8xqjRU2xPNYMcz9GjlL5YipLUTwtHAmWqweNfGkF6TrytdY0l4rMwR/8Y+5pBNkACK94l9+701EeDdeoEqMS/SVSh18UKKDmN5u5Kz83SyKm/390M1fVgSSteHyBj0HCRBx+oPJBCFt0OQoyQSM0ulgL9OJBe3jrZC01eoALI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730924346; c=relaxed/simple;
	bh=IXQbAM6zvY+9UT8cFWICwKrAVJeJLZ1u2UNGcCwn02U=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=CNa6EJ9bCDwZPIPebzk6vQWyQJV7Z/OXpxSHhkVV9X9HUMdh+0B/EWnU5kWgIO9xB3v+AvjtrNzmGRpfE1TLmFQK0ANYeRJcfubqtWhWMZIL4V8brwyhn7u+VvYABilLlYxO/0ZGI0gqS+RpuyuHyC7lNaOow/lFcBkfqo+G2sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OP44QM7k; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a99ebb390a5so242948366b.1
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 12:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730924343; x=1731529143; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UNpI2k3nON69g65de+2kfn7OHaYRJaF4l8miRYid1U8=;
        b=OP44QM7k/J/7F5v1GqHhsfttvZZqiXCCZzCyiF4Jyh8+b9nIHoOjMoyB6tbtncPrXQ
         FjK/JrhToj0o5o4GkkdrW7Y8DID4mae57rbZ2CbvCalRVdO6AJz4YnkPH4tBC4/cFKhc
         WYCpv9OidpPROXDe8/LTKeqH9pk1InfL0UI7qbb6zRazRSPWe/S43sTSEszVsS72fxtY
         UsEggrY/qk9YjpIFs2MWSVhhmvYFZwyA7foTjPo1hy3oxroqAtTlWwI75iP7smoeWd3d
         9epSmLsdU6UVv0clxvR4G70sH82xHYEY7FU9UYEHRneko/F8hFY9A++BSeOPaYcuDD8H
         /8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730924343; x=1731529143;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UNpI2k3nON69g65de+2kfn7OHaYRJaF4l8miRYid1U8=;
        b=HG5jn7IbKLuXelIuaztbRtWIBsl6GD47O2xq/md8GJmf5DNtF5mkMFye5KZXqrVkr3
         l2kx0Q5eV1ss+AUrvmBBs2L3UKUO4h+BaREhgR6zuMmON3FDgWt45kL0hSAGwD6FWLWH
         SrdmshMxSMWyldwKw4cjUhudEbT6iwEZtTorWPB8geylZ7gqedoFK+lMWfMDkloi2iRD
         itYBBTli+fwTqQoumRkT6UqpB4SNXtDEspc91FAWD3r1+sJ6a0ity1Rv3SNNsjH3j7iY
         WqQ1+IRtVH3yc27oU1VBCTIPxfgc803JsBpW8vDSf6GtCTCY2xWe5ZRO+jH8pCHqV1+c
         tyPA==
X-Gm-Message-State: AOJu0YyDMc0gdPX1O+Ppt8BUrMGDxYUldo4h81PrMQS/HISyaWD0uKRu
	tFAD8hewMAWmxt7/bamdSAORRH7GhVhQae6KMb4OJF0YUK5eya05
X-Google-Smtp-Source: AGHT+IGA8SAUOpUbiWNlBexkG0BvlJbq8q5FmrTTDVWFEm67lcYYeDHX1F1u4q/KRKCckBvRaIkg3Q==
X-Received: by 2002:a17:907:9725:b0:a9a:8042:cb9b with SMTP id a640c23a62f3a-a9ed510074emr48272466b.20.1730924343363;
        Wed, 06 Nov 2024 12:19:03 -0800 (PST)
Received: from ?IPV6:2a02:3100:a488:4700:cc12:ac39:a3b8:6ff6? (dynamic-2a02-3100-a488-4700-cc12-ac39-a3b8-6ff6.310.pool.telefonica.de. [2a02:3100:a488:4700:cc12:ac39:a3b8:6ff6])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9eb16d6637sm325071566b.46.2024.11.06.12.19.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 12:19:02 -0800 (PST)
Message-ID: <69d22b31-57d1-4b01-bfde-0c6a1df1e310@gmail.com>
Date: Wed, 6 Nov 2024 21:19:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 David Miller <davem@davemloft.net>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next 0/4] net: phy: remove genphy_config_eee_advert
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This series removes genphy_config_eee_advert().

Note: The change to bcm_config_lre_aneg() is compile-tested only
as I don't have supported hardware.

Heiner Kallweit (4):
  net: phy: make genphy_c45_write_eee_adv() static
  net: phy: export genphy_c45_an_config_eee_aneg
  net: phy: broadcom: use genphy_c45_an_config_eee_aneg in
    bcm_config_lre_aneg
  net: phy: remove genphy_config_eee_advert

 drivers/net/phy/bcm-phy-lib.c |  2 +-
 drivers/net/phy/phy-c45.c     |  4 +++-
 drivers/net/phy/phy_device.c  | 23 -----------------------
 include/linux/phy.h           |  2 --
 4 files changed, 4 insertions(+), 27 deletions(-)

-- 
2.47.0


