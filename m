Return-Path: <netdev+bounces-105037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 015B290F7C5
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 22:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90A3DB22137
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 20:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D8715A4BD;
	Wed, 19 Jun 2024 20:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evonTq0z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D2A157E82;
	Wed, 19 Jun 2024 20:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718830359; cv=none; b=uIVPNom6n3RqLZHl5CZuKZI9GuDRIu/ay9rCGNZIxRm7eTqU1PHAVXvHzI7ZwsUU+tP0mlivSm0Dod4r/yBhmTTWlgrATV2Nyxo6uXQjWqm3m8jcBZFxIVyXgtLAqsDmEdwdKpOf/cUFOO7D56YX1QiPoFEEtlozgx6zlADXYFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718830359; c=relaxed/simple;
	bh=+iuj/RrP+tBGVD1OW0yg3eQgm0KnZyvqPDjwC2sZV90=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WkA8J74iGxrCVD1E/XzA0qOm1dvjiZYcvMzKzWyYZFI9MZBy6tezGDpXOwtuJSE2szBJjEluQHdI+ktagmBIhGN5U7ddUVqHq4K0Mf7clOlNGTrzwNtyVNjqIjiNzUdup/2B3IIOIoPU9KZ5zgO0DS8Yuimya71h/Gx/mY5jPKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evonTq0z; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ebeefb9a6eso1665031fa.1;
        Wed, 19 Jun 2024 13:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718830355; x=1719435155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C3Ixn6szh7UpQ9LIgC02/gBknnNw8WK9aQGyG2S4CAE=;
        b=evonTq0zw9DVo5HDrTi5xbNFXix0kZCt34GE7VSiFHL7YZ9uF0d1sYfETqnHzF27rQ
         B0baPqtcVGlCRCKVXO8zAHgMj9/7uPDjtdSarV2shbTyA7HzcWvA6taNtrKll4A20ocF
         57SjV9UVZ8PrgLiFu/suROVy1U6d6SoehVzAOkLwfMtg84wj+UBWWCNACjO2dtFrc682
         B1uGgm78jQA0SoGnMNZ82BWHs/dQWnGfSMvrKcCGK3GHDMu/p9bEXtrnyqge5cX0pIuY
         H8WifAqrNOqGRf2w1HqzMsDkmJfMXMm8J311urvSKCcmHN2WVLZIcntvzbmPlkTQXTeh
         rkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718830355; x=1719435155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C3Ixn6szh7UpQ9LIgC02/gBknnNw8WK9aQGyG2S4CAE=;
        b=hWP4BV6iwbHtLXMvB6CmsrJNt4pmRjJNfUYraTvTq0DACfHyws9dMG5i5/Mq84NgCz
         bxo4YO5JjrmqHFE97hCAtS0Z4NYvwt7MpMsyKcuifIOO2owNCIglZUbw8g1LtpgEci/n
         7klP63ZeFnRlpvJpEq9ribh/aqclW3YNyhPgHUFEk3GmCYIl+j6Gsts7rfXaj1Sb1AOy
         LBRDuMFA3XOWpoUv2CPQj9nvT/i0j8XCFMPZd2+/behYqWJazc5K/BTGR3YLQyitSRcU
         asRqDdsDVRtK7+jfag1irH+Wdke1kKag3204ZPIUI6AiXoQp7Qvliw2md+ShY5EY6e3Q
         Tcbg==
X-Forwarded-Encrypted: i=1; AJvYcCXz2hHKbrQturLE3RuKgwITJeXk+1XpRYjIhkmRicQRoyzJGQiigWwCmmVrCtz2EXO03vraJZ6vw+QCiK6/6aJJr228OFMZzAyQ8jBe
X-Gm-Message-State: AOJu0Yx4X0DNngitnUHRg0RClmSv67D9EdEXgPPytVf2/+DcRIiZkyGk
	7M38EUsA9VNjy2l/09m0pbRG+pZLyY9Wywsmjbf9FhyGYva8qqvhn/d6aC4SQzE=
X-Google-Smtp-Source: AGHT+IE/N9pvoR8ktvYk2XPDu1sTGoyufJk43unE2m/kd2ATNBLunhPJIOjTsio3UcI61Uq+m97ggw==
X-Received: by 2002:a05:6512:472:b0:52c:9824:5be1 with SMTP id 2adb3069b0e04-52ccaa5b9e7mr1715035e87.15.1718830354891;
        Wed, 19 Jun 2024 13:52:34 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56db5b2fsm697329566b.47.2024.06.19.13.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 13:52:34 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 00/12] net: dsa: vsc73xx: Implement VLAN operations
Date: Wed, 19 Jun 2024 22:52:06 +0200
Message-Id: <20240619205220.965844-1-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series is a result of splitting a larger patch series [0],
where some parts was merged before.

The first patch implements port state configuration, which is required
for bridge functionality. STP frames are not forwarded at this moment.
BPDU frames are only forwarded from/to the PI/SI interface.
For more information, see chapter 2.7.1 (CPU Forwarding) in the
datasheet.

Patches 2, 7-9 and 11 provide a basic implementation of tag_8021q
functionality with QinQ support, without VLAN filtering in
the bridge and simple VLAN awareness in VLAN filtering mode.

Patches 3-6 came from Vladimir Oltean. They prepare for making
tag8021q more common. VSC73XX uses very similar tag recognition,
and some code from tag_sja1105 could be moved to tag_8021q for
common use.

Patch 10 is preparation for use tag_8021q bridge functions as generic
implementation of the 'ds->ops->port_bridge_*()'.

Patch 12 is required to avoid problem with learning on standalone ports.

[0] https://patchwork.kernel.org/project/netdevbpf/list/?series=841034&state=%2A&archive=both

Pawel Dembicki (8):
  net: dsa: vsc73xx: add port_stp_state_set function
  net: dsa: vsc73xx: Add vlan filtering
  net: dsa: vsc73xx: introduce tag 8021q for vsc73xx
  net: dsa: vsc73xx: Implement the tag_8021q VLAN operations
  net: dsa: Define max num of bridges in tag8021q implementation
  net: dsa: prepare 'dsa_tag_8021q_bridge_join' for standalone use
  net: dsa: vsc73xx: Add bridge support
  net: dsa: vsc73xx: start treating the BR_LEARNING flag

Vladimir Oltean (4):
  net: dsa: tag_sja1105: absorb logic for not overwriting precise info
    into dsa_8021q_rcv()
  net: dsa: tag_sja1105: absorb entire sja1105_vlan_rcv() into
    dsa_8021q_rcv()
  net: dsa: tag_sja1105: prefer precise source port info on SJA1110 too
  net: dsa: tag_sja1105: refactor skb->dev assignment to
    dsa_tag_8021q_find_user()

 drivers/net/dsa/Kconfig                |   2 +-
 drivers/net/dsa/sja1105/sja1105_main.c |   8 +-
 drivers/net/dsa/vitesse-vsc73xx-core.c | 709 ++++++++++++++++++++++++-
 drivers/net/dsa/vitesse-vsc73xx.h      |  42 ++
 include/linux/dsa/8021q.h              |   8 +-
 include/net/dsa.h                      |   2 +
 net/dsa/Kconfig                        |   6 +
 net/dsa/Makefile                       |   1 +
 net/dsa/tag_8021q.c                    |  86 ++-
 net/dsa/tag_8021q.h                    |   7 +-
 net/dsa/tag_ocelot_8021q.c             |   2 +-
 net/dsa/tag_sja1105.c                  |  72 +--
 net/dsa/tag_vsc73xx_8021q.c            |  68 +++
 13 files changed, 914 insertions(+), 99 deletions(-)
 create mode 100644 net/dsa/tag_vsc73xx_8021q.c

-- 
2.34.1


