Return-Path: <netdev+bounces-222805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C178B56300
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 23:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C5175641C5
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 21:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF05F26FA57;
	Sat, 13 Sep 2025 21:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myWhZn7W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FA71DFCB
	for <netdev@vger.kernel.org>; Sat, 13 Sep 2025 21:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757797493; cv=none; b=iilwYa8JB5SVBB2pAlcb0HM8BW9VMRG3Ee38ja6cVzu6ipGsMExXIE0jeBo5i16qoOSQXlYQ210hqvlgNDsM39vkU7kCk4ddJUtvCl39ugYJ3OuGpjXbo7/P5wCnZwYIMHfYLhLHZwO1SrMWZDs7fPJCSud7/PHwXzaASCuXfz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757797493; c=relaxed/simple;
	bh=BE56xlBeHDj63bz/z+38OV80maLJfXFtiONeTSxOEXE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=H5OUoVl4mMJOgP+GJ0l1emTyt5EpCEaSGBPORTkQ4QByiToOOJIp4norSm5BSE/Z2xfcRxDUcEW7DDoZY40arAZczeIFhVx2CfNZ4EVolMQnUr62q+0oZR2MRvD10MlwvWzKlHZNdPwiNc7W3rvrAvvY0+rHX+ukpxApPuf1hhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=myWhZn7W; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45dcfecdc0fso29716925e9.1
        for <netdev@vger.kernel.org>; Sat, 13 Sep 2025 14:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757797490; x=1758402290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:autocrypt:subject:from
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q2BwMahvZRsESwMk4PLaHswLNbJoMEX3iSBjcacTxtw=;
        b=myWhZn7Wn2qiuOXXdCuTye1IlmknBw9ccbwMr0Jm1ZOaslg1M9klEUfcZNOv67wUpv
         J3c8E2AXKZAWArmAV1g1/xO7W8QGYjyLGUieNWM66t06AqxJKcZ7Q/BPXOqlzsfC+yju
         2Osdz5cdeKpJYGtJlYkAfAIAb52ziLlm/t+VzkEcE3KojugY57agU/x1k4acjU1Bjgno
         a3Bp4Pz3oYG8RopUHf0xY1iWlCepvC5SCk9X0qrY/NYn/0EWpBDwuDnCtKOqyoG0vXTo
         3x/iDzT626u4GZEnUi8kWbWrAMpVruM8bZpj0m5lTfyRxzOrn6iIAxdoTGchVzqAbpCB
         AOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757797490; x=1758402290;
        h=content-transfer-encoding:cc:to:autocrypt:subject:from
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2BwMahvZRsESwMk4PLaHswLNbJoMEX3iSBjcacTxtw=;
        b=CLVYM/2Ptf+ScbbEW+IS9sRX/U9WVub/VJ5DmYJnl4escbfG8sbih+OdrVsszMZYWo
         x5ig86FsilcRMs/2/RihlwfFeD4XPox+UQiH/7xO0NL63TjH9VTUIAg7kD7sOs7WESfS
         6KMDKZN4A0IytvMoMWJKHuug8sSUxISUjGE/qDpNKVWidykVddKGXMRKgOv0YSYYCV/w
         X/IrcONsnYMvxKku6IrIG6ujMhTKkTE8hW1IorAWNI6RXX9hYfAIsCuS/pXFq+seP6pW
         9QDl+E561umNVnfMhVKrXz7QpPtQ4ypldbpVF3eF+vYs5VJysoxUYa8qpsNYTk8+MoFU
         5BXA==
X-Gm-Message-State: AOJu0YwYs7zZOfzK9jNVmmCOZHxA+S13covMeV6lhRV2uwr4ZvE7n3HD
	T8GmSyqKjhXJXM09HAyl3Kj/bGQxQwHalb23fQPyQ4RG82ZLr06M6lU6
X-Gm-Gg: ASbGncvxHO+KVH2amurVJwntenccvY65hX5xuOrWFDMuM4A8viCo9pXrF6GSOwpYCyQ
	A/YhuIw69xIEB4O8mZBB8C9G5jB9+h0QXNe8N3bSckPZqrb9wHYDTeFdMbyZSdKvJrW16yqxmQv
	oFa+i3DJa3pTZvCkvEyW3x6H3wLCqiCJBegVOK2bZRjEw5xMrXJc5Pb2GuYNPQRB2EwAwPMCJPK
	aiLocIHcX5+qiPa/keSVijBIpqOiBTqsNSIo24Oeb/FClDZk3o/GBJQP4++GdOkm4Lrm2KMS2/v
	IuwiAiJe4QLVVjUiTnHuzmEmZvhC+Tr7oaezRVVh0K9qcLJ5VpjUUvrBrWCIYPTJ8TX6ptkmnJS
	ZEf6f+aLW3mKv3MlKm+TUf9B+eT8aRcaioEeURRM8ikUk8BRJuwjH+uDtkL0ygyD0WhGd7ZIJz3
	+eBg5bjDSQ/8X1StKkJYICYHUXhy22jDH1kHbztFbnP4xvt7hcMjFOXzSpd2BLaQ==
X-Google-Smtp-Source: AGHT+IE0tULOOOUnLxjm7f2vuc0tQ7dpj0lyQ2nukzuYjUgFAI1anwXDFbsITcKDWyOlshw7lIO7XA==
X-Received: by 2002:a7b:c857:0:b0:45b:7be1:be1f with SMTP id 5b1f17b1804b1-45f211f300dmr39517945e9.32.1757797490142;
        Sat, 13 Sep 2025 14:04:50 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f24:8500:34bf:776f:e57e:cca6? (p200300ea8f24850034bf776fe57ecca6.dip0.t-ipconnect.de. [2003:ea:8f24:8500:34bf:776f:e57e:cca6])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45e01575fadsm112371515e9.6.2025.09.13.14.04.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 14:04:49 -0700 (PDT)
Message-ID: <4ccf7476-0744-4f6b-aafc-7ba84d15a432@gmail.com>
Date: Sat, 13 Sep 2025 23:05:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next 0/2] net: phy: remove mdio_board_info support from
 phylib
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
To: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>,
 Vladimir Oltean <olteanv@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Since its introduction in 2017 mdio_board_info has had only two users:
- dsa_loop (still existing)
- arm orion, added in 2017 and removed with fd68572b57f2 ("ARM: orion5x:
  remove dsa_chip_data references")

So let's remove usage of mdio_board_info from dsa_loop, then support
for mdio_board_info can be dropped from phylib.

Heiner Kallweit (2):
  net: dsa: dsa_loop: remove usage of mdio_board_info
  net: phy: remove mdio_board_info support from phylib

 drivers/net/dsa/Makefile            |  3 --
 drivers/net/dsa/dsa_loop.c          | 63 +++++++++++++++++++++--
 drivers/net/dsa/dsa_loop.h          | 20 --------
 drivers/net/dsa/dsa_loop_bdinfo.c   | 36 -------------
 drivers/net/phy/Makefile            |  2 +-
 drivers/net/phy/mdio-boardinfo.c    | 79 -----------------------------
 drivers/net/phy/mdio-boardinfo.h    | 18 -------
 drivers/net/phy/mdio_bus_provider.c | 33 ------------
 include/linux/phy.h                 | 10 ----
 9 files changed, 61 insertions(+), 203 deletions(-)
 delete mode 100644 drivers/net/dsa/dsa_loop.h
 delete mode 100644 drivers/net/dsa/dsa_loop_bdinfo.c
 delete mode 100644 drivers/net/phy/mdio-boardinfo.c
 delete mode 100644 drivers/net/phy/mdio-boardinfo.h

-- 
2.51.0


