Return-Path: <netdev+bounces-232913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E60BC09E8F
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 20:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEEC63BB94A
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 18:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A1223D2A3;
	Sat, 25 Oct 2025 18:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Em2A6sPD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED661C69D
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 18:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761418106; cv=none; b=EKv0tESRoZ6BIKoTwECNcHayWB9Kik6raoZwKjw77YA4momvWOXIPATQjn7hVELFQl0B4MBAS0Y0zQ1jrAUzTeFGfabcO1i7OgYS0prSCVx4RvJnZoH8OVuHJ9CSF7YxFrZ0lZIS8Pr98w35+SxIT/TGhFNGL5ENhdzbzwudhmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761418106; c=relaxed/simple;
	bh=lB4Dxkt0TRaUBnvTCUZDfEdUI4b45T5lSgIADYdoQt0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=pv13YCtGTTKFUxqFDkLqqrkWhZAiJmOlEozomGnKQT2iy1j8qiWmgkhjH+2GMr52Krc8vjRb8mkYf53X6OvXoHbkSVn9AjIio4Pc0hz71BRNlIofEhxKlcbGMV0GdKH/u7yyk66RIq1r8LcFGZce1TEzV3rZrz/ljgWQz+4JfRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Em2A6sPD; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-427015003eeso2907941f8f.0
        for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 11:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761418102; x=1762022902; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4DEObF2TnlPKzUdiOnUGsTpjwM4e9ytvSs5bWLyvVw=;
        b=Em2A6sPDDz+TmipDd/iUHNmzRzHsGXT9ZP4wxNR0RSlSI3HMatMmqqVyNeYwDPkNeu
         3oiPnWGKt4fSNW7MT3CWy97NjPmqrQVohIi3mu1GoWQsL+311krIWj6e695twndKlbTW
         ZX1bTP84f79YKff3PQ9bhxf6rcdIK59SaKxnuB9QSHpkxVf1+bFS6+f4gtHsGt0aGECy
         CeiJTXAwlHyvY7S9h+nhkzGyRP/1LCk3Z+qTR4Lq8f2cpZ4qhoBA7u6tTFPvNFPRtYTA
         Ln8kJLM/JB8p0Z93deiNKjOFy5bXLVLNyS48GGk1N12I6tYqyoVZp6YxG+8xeslXvf9N
         KGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761418102; x=1762022902;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/4DEObF2TnlPKzUdiOnUGsTpjwM4e9ytvSs5bWLyvVw=;
        b=wSI7qyhHeGg8FmhPLlEpuzN4V3acIaRpiRhQDFAqTnwbHnbBDJLX3URFTMsbRV9dje
         Q9GyofHHr+wE8knLMm3hPOj7G8pMgIq7ZlvB56IMOg/9FBp7kW+I2QgV9irp028u+/JM
         QEy5Tf1E5VlixbQci5igTRtbsQK996Mp6qwxGS2tqs0ckldYDAgfZ/ij2WKJQY2Eaudw
         gcxJFH1BmyNEN1zRo+bfrxI6Txj/FoYHEEcAgfy2hmr4SqeNEoZ4m5Mz0ojFDoUhEOrl
         c+sL1y+zOBDpeottaDFfCX2a9tFjWkY4cCVNMykQZAaTfs+S8WdW1DGRxcfX1SXiXkyq
         KklQ==
X-Gm-Message-State: AOJu0YxdZtmERC5Zv3I1ezV2QNvCcBK66TB5B6cGr0WUbl0QkUVRO5OK
	gedJiYT7BuXlygXhqaC0DWV6MwehD+mjMJrUa+2j2Y5zLtKTvqk7WIjw
X-Gm-Gg: ASbGncvvplQ2n91ICXspmBlPvA9t2pLNSsRmG/9f/eJr2Z393PAgNhxGoWu4dlq5kgz
	AWKzTjxSuxpQEoqAhJIPlZq6z+WGko5XRasef/tZkkYpG8ACR6TMO/RcQXiFmDmVoN0JyBAoBw1
	2hg7f+p34xq/c/jJLRbb9cZWskcKdCkXAtF7FOzZroP8sUHmXmmrjj+5BLhF8kUsXQ4Hxu46HDg
	00L1i8niT+7j05MbuOfWvR8j1Hhf3W3e3bphj4hxfbTJoqKrskTjM89oDzyXj1P8QeXjgMXbC92
	xfYSoHpHUWWrXMogz8DqV/GZzFcbSzmiqV5YzexSwBxEgLHt85GdD0LOze02ExlunOfYj75l/Wn
	GYoE+uGnOH8WRqA5W8CnkGyzDC8iDI0fJm3ESgZasee4yqC0aB63SPk0d84OCbyZkkriFYLQu3O
	JDwLQF/ymQvAInioFNPalM4i9n6aU65cwTrZ+/4nFAFxPHEW0wXcOgqxz80QNV6q+bIAdvJXnqR
	n6lykwHfD9qUDdPmseIfG1N/LJTiNdE7GcamfLQVEgqYyTdvWBR4Q==
X-Google-Smtp-Source: AGHT+IHCcJrVSR0S/2bwLvXjTXNpPmTtljDkbM3kYmLozHWMGTFvMyAitKH80oZ9JGOJZmbETpzfsQ==
X-Received: by 2002:a05:6000:4310:b0:428:3f7c:bcf7 with SMTP id ffacd0b85a97d-4283f7cbf5fmr20516277f8f.62.1761418102292;
        Sat, 25 Oct 2025 11:48:22 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f39:8b00:d401:6211:9005:e76e? (p200300ea8f398b00d40162119005e76e.dip0.t-ipconnect.de. [2003:ea:8f39:8b00:d401:6211:9005:e76e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7a94sm5404597f8f.5.2025.10.25.11.48.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Oct 2025 11:48:21 -0700 (PDT)
Message-ID: <07fc63e8-53fd-46aa-853e-96187bba9d44@gmail.com>
Date: Sat, 25 Oct 2025 20:48:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 linux-omap@vger.kernel.org, imx@lists.linux.dev
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v3 net-next 0/4] net: phy: add iterator mdiobus_for_each_phy
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add and use an iterator for all PHY's on a MII bus, and phy_find_next()
as a prerequisite.

v2:
- rename iterator to mdiobus_for_each_phy
v3:
- add missing return value description for phy_find_next

Heiner Kallweit (4):
  net: phy: add iterator mdiobus_for_each_phy
  net: fec: use new iterator mdiobus_for_each_phy
  net: davinci_mdio: use new iterator mdiobus_for_each_phy
  net: phy: use new iterator mdiobus_for_each_phy in
    mdiobus_prevent_c45_scan

 drivers/net/ethernet/freescale/fec_main.c |  8 ++------
 drivers/net/ethernet/ti/davinci_mdio.c    | 14 +++++---------
 drivers/net/phy/mdio_bus_provider.c       | 13 ++++---------
 drivers/net/phy/phy_device.c              | 16 +++++++++-------
 include/linux/phy.h                       | 11 ++++++++++-
 5 files changed, 30 insertions(+), 32 deletions(-)

-- 
2.51.1


