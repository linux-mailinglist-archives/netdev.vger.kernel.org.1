Return-Path: <netdev+bounces-250201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D37F4D24FC5
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 15:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54D1730392A6
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 14:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE01E3A4F4B;
	Thu, 15 Jan 2026 14:38:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A20430B53C
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 14:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768487903; cv=none; b=Pww3OCxduuxfDk1Jh3FvpjphCScLG2WjibaDRLD4PzFXoH8TUBQYb+TY3B6UbEHBbpmLO1EzINBiU2tpaReQalsnuzL861reXaixqKDF/m7UKp1fXAdHTegRvecnD0Z4dylu1wDGAvJyq2iflDB9ghduJg4PuP3Gp8USdltgD6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768487903; c=relaxed/simple;
	bh=Jym+hB7alQQy54wZeliTw3/vUjoLAwmzKirUqnTIOwM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jNEb6MuPJE3eZAs75k7F18dt+PQ42PYf7y9V/QSHFJorXeuqp2nsg+VmpwJzXw8nBHPfReyDJ9uSiyVqLb8Pf2g/0vZTGhn6Z5tgyp9iRmqT5+a9edS9dRDJVtcxlNe2nz2G61TRd23QIwm/x4MB8yurnywwav9RSxUfqepQfLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-45c715116dbso631827b6e.3
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 06:38:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768487892; x=1769092692;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obRPckYhjEiJNPLv4O3955QSZYUHJdHSvxM4hv9Cxmk=;
        b=IyBc9Vp93aM5CrOQfL95PdzzCMzCoT1lOUU67qyPnnwyrICckIDTNcmfTEmmm8TIfT
         b7h/a2sSMWyL6BwBtGGIjtNZGsadVhLuEdmKTmdg7CAe37GJ293A6zas8Jg81WHF6AnX
         vOteFQ5+rkJjUW5H9WM4Nb4Xgt2s9pRS/AlBI8XXMPO+wZJgMZcQdnfTVjGDKLTASQkR
         7UrbFEawsdhyoaBVoSqWs8tuIetMJBKpCV71LCcHKq058Zv9wnzvGNSxAJPWE3E5tXrS
         ROIO9lJJ6GeacSsULlJpFagbGSBcH0AHIpmObsrJ7hdvC2OVdohSZ1L4cW/sBHk/NxNT
         d1nQ==
X-Gm-Message-State: AOJu0Yyf/cieuJNNvMrb61BK1x2Ywrgr7GOtSl4IAmu4k6sbEaP6PMBl
	MhmCL3VDJ3/rVGyG7F1hS100ogb93iBq2hEZJdMvmozY1Jwk2mDd7itw
X-Gm-Gg: AY/fxX4saLxtaos5DFfTlqgOQhTUsxMQJyDVAORDJ/AYZTnhPyo73FPpiXet63+kiPU
	ueOxdAruVCMwKao/x1yBFzJsjayv+y/xqlezj1GPDw0OEfbmV7Ti/ardNc4Gn4d1Wtatg3Zdxhu
	GF7hn6UVe060Gag2p8irrD9SHTOrKqPPzV+BWpvss/9Mnue613ETlMqvStG1v45G1mrLIsmLAZD
	uE+edumiAiZ7hdufv9otVMEsr/w7Sv+xsvFut+DMQvQ9i2ZTnnS0IP1C+GAbngVeymsyJgREoCU
	AICIxTsYuiarR6Iy41viLAK5Josp8Kk8e45VKNh6ym64TIT+/eXzIJ5pbciGHRvBP3ZG5R/D8nT
	UnBThU5BtYs7dDWFjPy/3HhX3NiXmElA8CSczT8UPxXpk+P3Y+FjOxtpvgrxtihxiyzYrFno6NI
	APYkWHpzRvSndh
X-Received: by 2002:a05:6808:83cd:b0:45c:73b0:893c with SMTP id 5614622812f47-45c73b0aae1mr3347077b6e.11.1768487892230;
        Thu, 15 Jan 2026 06:38:12 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:5e::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5dfb6256sm12849514b6e.0.2026.01.15.06.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 06:38:11 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next 0/9] net: convert drivers to .get_rx_ring_count
 (part 2)
Date: Thu, 15 Jan 2026 06:37:47 -0800
Message-Id: <20260115-grxring_big_v2-v1-0-b3e1b58bced5@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL37aGkC/yXMTQrCMBAG0KuEb91AklrRXEWk9GeM42KUSSyB0
 ruL7frBW5FJmTKiWaG0cOa3IBrfGEzPQRJZnhENggtn531nk1ZlSf3IqV+CJZqvQ3dx7an1aAw
 +Sg+ue3iDULFCteB+SP6OL5rK/8O2/QCuTJhFfAAAAA==
X-Change-ID: 20260115-grxring_big_v2-eed9a5803431
To: Ajit Khaparde <ajit.khaparde@broadcom.com>, 
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>, 
 Somnath Kotur <somnath.kotur@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Shay Agroskin <shayagr@amazon.com>, Arthur Kiyanovski <akiyano@amazon.com>, 
 David Arinzon <darinzon@amazon.com>, Saeed Bishara <saeedb@amazon.com>, 
 Bryan Whitehead <bryan.whitehead@microchip.com>, 
 UNGLinuxDriver@microchip.com, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
 Raju Rangoju <Raju.Rangoju@amd.com>, 
 Potnuri Bharat Teja <bharat@chelsio.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Jiawen Wu <jiawenwu@trustnetic.com>, 
 Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2118; i=leitao@debian.org;
 h=from:subject:message-id; bh=Jym+hB7alQQy54wZeliTw3/vUjoLAwmzKirUqnTIOwM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpaPvR64rLYjr2/iNqLeLLq4WUcZf2UrXiopTlb
 njcXO6FZImJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaWj70QAKCRA1o5Of/Hh3
 bZroD/0RDCaNjdoDbu0mv1OiLrdFYjfSMbkXoNZQmy/Ib1BSBZcMkshG7AJyuWcGBafcCmjj03x
 VKqJbxcSyWQ+tpj8TL1dqoqagPpMLEixz4HugR9MHu39GxRHg67sAwg+bPc4+wBaKuZLdJrov+i
 k4fLF83CLgthdt8vpKY08wNYHyNdWcaH9Gf1xQ1hbACXK2Knoyo3vVPYYVqwqG4Mrjc1N6tnItO
 ShNU2XPOjTekErc+spOHazhTgbPOS2cL1cBA5An3oEfBvoryhf7jy/IljJdNYk3YOJxER/wCgWH
 DktqZGJ03Tmty7FkBdzUv01Q7oMMOdia7Xa9xf7HBkWx1OmpOATfQhLnUwSusKwm6zxbDTy6jqL
 5h0No4RHrYc/ivjDAoBCmrG8u8LrAxElbmUm48x6nm7hIF8rSY/U0/FT87qYDJJuFycgyP2cQnR
 mUzjeKJYEDqQw+vGd4Pg9Gjl+EenugTNENvN4aV8R3+z7BaR4NIsrT7N39bXBBxKSIOK9I26bGc
 IkQovYC7ZbWc5SU7+e4ShGDEeeEjC9S8qIdwuLLXtglOSDGpEPrWbZDLSSURHuVTjjIzuEnFupK
 C4GynyaMc4wqYJmfPgo5TVI7Bu+0yzeda7t8AfkbLDXnzDtVS07r4lJVG/ZyrVOJVsUKD89MXcG
 47Q/f6pZkmqcEEg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Commit 84eaf4359c36 ("net: ethtool: add get_rx_ring_count callback to
optimize RX ring queries") added specific support for GRXRINGS callback,
simplifying .get_rxnfc.

Remove the handling of GRXRINGS in .get_rxnfc() by moving it to the new
.get_rx_ring_count().

This simplifies the RX ring count retrieval and aligns the following
drivers with the new ethtool API for querying RX ring parameters.
  * emulex/benet
  * engleder/tsnep
  * mediatek
  * amazon/ena
  * microchip/lan743x
  * amd/xgbe
  * chelsio/cxgb4
  * wangxun/txgbe
  * cadence/macb

Part 1 is already merged in net-next and can be seen in
https://lore.kernel.org/all/20260109-grxring_big_v1-v1-0-a0f77f732006@debian.org/

PS: all of these change were compile-tested only.
---
Breno Leitao (9):
      net: benet: convert to use .get_rx_ring_count
      net: tsnep: convert to use .get_rx_ring_count
      net: mediatek: convert to use .get_rx_ring_count
      net: ena: convert to use .get_rx_ring_count
      net: lan743x: convert to use .get_rx_ring_count
      net: xgbe: convert to use .get_rx_ring_count
      net: cxgb4: convert to use .get_rx_ring_count
      net: macb: convert to use .get_rx_ring_count
      net: txgbe: convert to use .get_rx_ring_count

 drivers/net/ethernet/amazon/ena/ena_ethtool.c      | 22 +++------------
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c       | 15 +++--------
 drivers/net/ethernet/cadence/macb_main.c           | 11 +++++---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c | 11 +++++---
 drivers/net/ethernet/emulex/benet/be_ethtool.c     | 31 ++++++----------------
 drivers/net/ethernet/engleder/tsnep_ethtool.c      | 11 +++++---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        | 15 ++++++-----
 drivers/net/ethernet/microchip/lan743x_ethtool.c   | 13 +++------
 drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c | 12 ++++++---
 9 files changed, 58 insertions(+), 83 deletions(-)
---
base-commit: cc75d43783f74fe0a1c288aba9e6ac55f1444977
change-id: 20260115-grxring_big_v2-eed9a5803431

Best regards,
--  
Breno Leitao <leitao@debian.org>


