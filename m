Return-Path: <netdev+bounces-157452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34056A0A5E0
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 21:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADE617A3603
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 20:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5571B422A;
	Sat, 11 Jan 2025 20:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFNKsXS2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC18A1B042E
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 20:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736627054; cv=none; b=gmio8bt8jA87T8ZQfuWoZPacZ5bxGAE+V1tnpdl7RnDEGVhpSw2SlwKJbuGia6izHQ9pda/NhSPmwgyVn+MqgYc4QyqHdPXpxIcDu4vpecnZpCWeUYEVF6OJqDLdGCxpsgd2wx3uVuNHM6LEvt1A7TmwjSXpXX7FD1X0NJEqC00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736627054; c=relaxed/simple;
	bh=22zk0Gve2q5KDrIp0h/LUWMmETf8pM4yCJEuB0bIlrI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=QBvD0gR3t3z8liQexFe2HN96J8gDkX0fRY6Eu4HyuFvEp53+/qdzkkBi75VfWaMvEhw+jWUXdW7O5HZShWwnzRel5t02iRkrK18gHpC1eBdvfJuzhKw3CH9kWJGOKSs/+iuESXtUmadODvQhRR9IXhd05OGLuQW1jL1pDNaiwLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFNKsXS2; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aab6fa3e20eso553970366b.2
        for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 12:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736627051; x=1737231851; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y/nwNiEa3wBOaG4xmz9aF5siLZpUX8jzzSv6TNbqnzk=;
        b=GFNKsXS2kZjAoLRjzdikVp/7KC96B4d9qHHI8V0zk3JmZvCyLRPg6l/zfsKZUIi2vm
         NOQsqkoyoLMutEMbaaXer+BF7HuGxXtspEP/D3/nFVO6LGzjlI5sq8EZMOAX4R0hRLCV
         sVNJ9b/H153Nq5PXUMX2kgLUpI9l2RupZ1Lcb55BqgqkMghMwPRuAt6+yj2uI+NcNSA8
         pftUjHrCZhuerbgG23wO4zN5UA/9vo/336QTBxYvPRGgFoMvuNFh7w8o6rO0yMJ2PYHG
         ztmHwhsBpaHak6HhQSiwah9RrBoj+yy3sfZ2JSOWPBgRfgMF6F3/xrcF1/aNGvvszl4D
         Pn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736627051; x=1737231851;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y/nwNiEa3wBOaG4xmz9aF5siLZpUX8jzzSv6TNbqnzk=;
        b=lauurbSruWPGoow3gVsnfWPgWGSvX5s1QOuiGe6R4hfhMTRm9ejdoVh+WEaSrsKx2P
         HgGTn9dbjgwoJkIPfQk8sepx65uAA0J+fUmmf5As8/FmlDlGQILb1BrzLNbNL9mdTEju
         dV4wj9XOcONJ7//993vgY82q/5OUQrIbU5ZB7kuAKlrV8eTWq2zFMr5jXMSQE8dEN0CE
         2oXvJoaF3rEoQuMDKPBFPn6Wcn4gWUb5yLTT9qOAMVy8f5Ec2RV7vPRm1ObRYGW3V6z+
         oVxKhve6D7mr21oxLxopDPAqv2HZJOdGZIq/mRkseyEYhA+Bg0OXzaNS62FgCIYz5Lx8
         MtOg==
X-Gm-Message-State: AOJu0YwAbKwonTYnsBUHH7e2GPkpH7AIzDTYHbAYnCSOKiwTa/J9mHqJ
	0jM+vMoiUMgWdKQMyevWNd3JkJlzZKPCBSSkovNy9zGtNB48gNFz1SJeMg==
X-Gm-Gg: ASbGnctUoWt4QkaxXP1Q65cTj3IhaV5rDPqIvsG0L5g9mawjKWsfLBpA7mHQVe1xlvq
	gouQVUiHxloM72T9/hJEz5Tee0G6qQdyg0voSv7BVKg9v6eOANoePzOXuLsNY3Z33MIl9SnIvT1
	Pywlv0rsixVyJGEy5d3OeudiMGpqjeKSij1WGQUCdZ8tE3GMd7Sb/igwES1bAZau+4d4MsTt0CL
	Zxxeq/NjxS9zAxUFlNqTHD/N7pOwulD9enTuLrVE51MmqZO2vXzQbk9bpCzmf4nU+mqRWYIH8qo
	ppEBSV38dTsRpg6WYNIo1o0K7e1mK9hadXks1RrfWKXF8nZ6OpMqYbE+rlMTlggy9xkjvmnL+Xt
	Gx3tcwpubVikGybnEl1exd+JjfmwZnAFHE8+JYs5Q6WZwaKYH
X-Google-Smtp-Source: AGHT+IFOhj9JVaz15ENsp8P/Fr/ZbZ9Kg+oZzjYeEXxmT8MNHyj06qXFoh46WR+t/qBrZuRz1CSrAQ==
X-Received: by 2002:a17:907:3e93:b0:ab3:10c5:9f1 with SMTP id a640c23a62f3a-ab310c5106amr3969966b.18.1736627050649;
        Sat, 11 Jan 2025 12:24:10 -0800 (PST)
Received: from ?IPV6:2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd? (dynamic-2a02-3100-a90d-e100-d8f1-2ffc-4f48-89fd.310.pool.telefonica.de. [2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab2c905e2f7sm303490566b.24.2025.01.11.12.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2025 12:24:10 -0800 (PST)
Message-ID: <90b3fbda-1cb7-4072-912c-b03bf542dcdb@gmail.com>
Date: Sat, 11 Jan 2025 21:24:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next v2 00/10] net: phy: improve phylib EEE handling
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This series includes improvements for the EEE handling in phylib.

v2:
- add patch 3
- patch 4:
  - silently filter out disabled EEE modes
  - add extack user hint if requested EEE advertisement includes
    disabled modes

Heiner Kallweit (10):
  net: phy: rename eee_broken_modes to eee_disabled_modes
  net: phy: rename phy_set_eee_broken to phy_disable_eee_mode
  ethtool: allow ethtool op set_eee to set an NL extack message
  net: phy: c45: improve handling of disabled EEE modes in ethtool
    functions
  net: phy: move definition of phy_is_started before
    phy_disable_eee_mode
  net: phy: improve phy_disable_eee_mode
  net: phy: remove disabled EEE modes from advertising in phy_probe
  net: phy: c45: Don't silently remove disabled EEE modes any longer
    when writing advertisement register
  net: phy: c45: use cached EEE advertisement in
    genphy_c45_ethtool_get_eee
  net: phy: c45: remove local advertisement parameter from
    genphy_c45_eee_is_active

 drivers/net/ethernet/realtek/r8169_main.c |  6 +--
 drivers/net/phy/phy-c45.c                 | 51 +++++++++--------------
 drivers/net/phy/phy-core.c                |  2 +-
 drivers/net/phy/phy.c                     |  4 +-
 drivers/net/phy/phy_device.c              | 23 +++++-----
 include/linux/ethtool.h                   |  1 +
 include/linux/phy.h                       | 24 ++++++-----
 net/ethtool/eee.c                         |  2 +-
 8 files changed, 52 insertions(+), 61 deletions(-)

-- 
2.47.1



