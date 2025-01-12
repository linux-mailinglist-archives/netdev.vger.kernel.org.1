Return-Path: <netdev+bounces-157528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 569CEA0A987
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 14:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31483165ECC
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 13:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4856D1B424F;
	Sun, 12 Jan 2025 13:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXL0Pri9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833D51B218B
	for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 13:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736688291; cv=none; b=lBhrUeDETsP4OEaOYKQIPpUCRbIu9covWXPMcdXNNP287RiAHN2Kueqr+Epuroq/+SGgAvu9Nj11xATa5szbdsVltqX9BWHfrmyeivzCI4eR4TqG3x/OCWUyEUA4TdZQxeRYzJnSmlfnQDBIyO2hsCyXcFKtNNUkUGls0vGTsTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736688291; c=relaxed/simple;
	bh=EigKS/FyslmimcxV4EIL+yYYPQgoAD5coCwX5Cawls4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=tc6M5HJ8CE0bfkMDzzbSKh+U7YXvlwkmM3ygDQe9baV7cDo1JHb1osECUVekGfIWGxCx4LC7QQ1LCXrMr3LoabtikBr/6hp0PVh+gjUjMaDLy943BcFIr/2NFsGYV1/zT3sRa8E34CmJckiWrpWNr86280rFUv4swplzlX0hMOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXL0Pri9; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385e87b25f0so2853282f8f.0
        for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 05:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736688288; x=1737293088; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LfTCDUBVESFb3JvdRruJcga+uReZlqSN1cqBQuvz6cM=;
        b=VXL0Pri9i1f5eJ1KveDodjJcbde1BufUQTwCUni+n+CR0c4fu9KL73pAG8TC7eqmvC
         b2X3W1udCr1aqgzMKsX7LJjBcBqGHzIQrkFme/7Uj9c2ugDU7GsqPkyE423Wsl5ZtGb7
         pKTGYotX2PWfuBhY8gLSTTkhtCiT2ImAAP4VkjTEhzqdURKqrga60XDRudvIXk03f1YF
         mqx7VVjmfIMxxz9rC3M94Vaj3+Qxi3E1jThy7jRSqDwURjiJ6RxNFHJlkyNlD7rLA4xD
         DS5o0kdSUn2tuSzdLWKflvqde3GLthQm/RZ99isJguxdItU6s6+Owfg84PUybumTu622
         8WNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736688288; x=1737293088;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LfTCDUBVESFb3JvdRruJcga+uReZlqSN1cqBQuvz6cM=;
        b=v+biTQcgMlRpY2Z0xjPc+MBFukj6HToJU/tzhKsvnuMb4mq1H/xYha7fjcTyrl5931
         pEuh1dLSV+0lAIK2hdBeSQdWoRLuPNnWKPHgJxunwJrhikb9wZ9QCNdRHRg+w85qXf4f
         jKO3ru4tEt9A1ASsADXEEeYZv8LLIaSppdSm0qTziGRaERX6I4tXLEIE0slLEZr0iXwG
         c30ALRJKADCVZFG34FYXkk35dgC/YY1chAcPduaBib4eXGUEIQbs7ahShKKSxDcl8RIW
         2wnh2CaLqk0XGGc0jDF0pNkzd0O5QmvPBVl7SuATzLIz2vTIOlRbRNfqCFdsyJmD3ZQE
         m9Rw==
X-Gm-Message-State: AOJu0YyvkWm9OCXlX82Y7nsGSef4ZOPuyAUN3Q6a49pSxaXGOlfyolB1
	fr94HwIKI/NjF28CD20k2aHmMPb5DidMBUwZqYRbosZ+s+rh3niM
X-Gm-Gg: ASbGnctKKZCXPMbFRw7y1nHiw6jTYdspxS0wqU4WZdBTkbTcGZ3g0GWyq0h8X27Ulk7
	qLlLDcc8g+2X91F6qXO9+uNFAXbOn3QrnoWwzVqr/ynpBKN0V8ZxbDCauI5gs+3cxC6Hxx3IQa0
	oE4ZUIh7AlCE+LoQpABcJ1CcjAA/ySwKe5/dm8z8fEWLjhd6ZmJd9xVNCcOMDmqqJwswVVejWmm
	RdPRhI4Cg0yE3AElCpPmd4h2mcLocEvy9w2umaREhOSAp3uAhRyLA3ZiSZ2o4Bn86rZQhmaF1fD
	aGm6idh6FIl2gMYslKyryqGvWr5R7ulgAT4EaLQt7RfQhwgBZQgC1lgSQU6FC6Tg+J0hA6F0yai
	/kuk6sEd/Son0FSWpl6cHlOR8/P0ZcVKUIzzA3++PGRyaxxlc
X-Google-Smtp-Source: AGHT+IEKyWmptU+G1ql0JimOrBGMt12glC3W+wiQGFJaERXAn27NuXMQ7mJH7/QvZm4KmElMON6ZQw==
X-Received: by 2002:a5d:648a:0:b0:386:42b1:d7e4 with SMTP id ffacd0b85a97d-38a8b0f3158mr11176237f8f.19.1736688287625;
        Sun, 12 Jan 2025 05:24:47 -0800 (PST)
Received: from ?IPV6:2a02:3100:b0d5:ab00:44ab:526d:76d3:604a? (dynamic-2a02-3100-b0d5-ab00-44ab-526d-76d3-604a.310.pool.telefonica.de. [2a02:3100:b0d5:ab00:44ab:526d:76d3:604a])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-436e2e92a50sm144462235e9.36.2025.01.12.05.24.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jan 2025 05:24:46 -0800 (PST)
Message-ID: <5e36223a-ee52-4dff-93d5-84dbf49187b5@gmail.com>
Date: Sun, 12 Jan 2025 14:24:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next v3 00/10] net: phy: improve phylib EEE handling
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

v3:
- patch4:
  - remove trailing newline from NL_SET_ERR_MSG message

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





