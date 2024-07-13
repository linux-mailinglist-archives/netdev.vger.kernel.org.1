Return-Path: <netdev+bounces-111208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CED9303D1
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 07:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71A201C2141E
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 05:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D721BC3C;
	Sat, 13 Jul 2024 05:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5844tnU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810AA14F70;
	Sat, 13 Jul 2024 05:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720850094; cv=none; b=oL5zsD3dTXfmEbs4NSqZakwcxKdU1YOfy9FeZY5JV8C+29hKIIdvPXBeqign2lXREwih/oNwQ4HNyDHSqmllYhBN2PPqcZIXe6x38M+zTRffH3KwM+rTknDzjBfdL8yosbAVM/+K7rCyhbuar0meV+QTUShFOMP9YheTQmrW4ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720850094; c=relaxed/simple;
	bh=WyPWoJsqzT8kItOichOJcnipjqxJRXai1rCYuSJbRak=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JVu5m/XEdlPlqWvGBVJoc0Ipt31DQQF1+MwhCGGqW1rDc+MEV7E7KUjPNj/I4GyyzTN0NGZpuUiW5icUUiBglP9uLQzJFqt8HhSVXKVR8zpVGxqctkRhsUOH539WZ8JsvCwcPXOVmOIFWuTFGVilVOCoyR2zBcmbTLSbN3Uhi7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5844tnU; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-585e774fd3dso3554131a12.0;
        Fri, 12 Jul 2024 22:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720850090; x=1721454890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hn2L2q1+hFZJXMemazXtNxCxJhPrr1PO0Hw0zjIThmE=;
        b=G5844tnU6+S4lskauue0y+Aac49JPqCPSSXaMMX9TIPnLiJzTFIJ7W+If71wpH1VZA
         MSY/2Kyda2xQ/8jNWBNm3YneWcClVgOf95FrIx/5W8BK5lIkHb/GD3b9fUYxrhY34gLH
         g587K3pI2EYX+qh7RBpl2/GCbfrIkToEjb+Ln7fSda/YwZ79MZrgn4ly7jfjw1gw4day
         nQkg5f2arzzpVe5Cdw7E3pWnT/DYOVAaDySsxsU+zsemesALtto7FuFDA1fkMTjs0Zzb
         u06M+USYaeEUmesrKRzXtqeKphP+31/sgxxvIA5m1FFXmYacs1ZSnHGkEx+oH7ic5ULV
         zKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720850090; x=1721454890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hn2L2q1+hFZJXMemazXtNxCxJhPrr1PO0Hw0zjIThmE=;
        b=D5Q8+Hl1g47DnGsjXOwx1M6YEQPdLywvAtySOWhcu9wghz+G6irIZv5QpcsGP57x/O
         YXp3qL1vcfVb/tOMtPHKS782t0Pn6Jlb/hDu2lheqB6JnuVv/5PDus7g8r9wjJxW4tUI
         by3tJ9MpsbjOD2bU6rPDZqzZb8GZQY+tYDRUnLYHtzYiKGhHHFnbt1wd3caQFSaPw9pk
         hL/7AzQW8E/qwkEB+5Qhs4oDwQvfW5M0DfoAKVkOImu13Uk01VnJ3/ZjxcOQ2iptAVZM
         AYdmw8Ms1eRq1Mu0KI2tBF+UFwz6PlTUURoGZYnlTvxI1xaplhCJbpAxp38q5pjJi2HC
         Uz+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWAjioJykabqoVI1k0VwcJX8Hl5mv2eTqEleAU45XzpGyu2IVr6lPAOAdfMdyThQ1CBCUzB43k9rbVPCazzmtNW3lU+050+185q9zJV
X-Gm-Message-State: AOJu0Yym2Buptwv3fdX5zXE1cH3A6eYDuWOSVrARUvgVJgo9KtsDJCw3
	g7ZD149+h7Ow+8Mc0+5XcRvd5vjFUpPbFBIpY0T3iUg5DKNsUtOtZziCpMjM
X-Google-Smtp-Source: AGHT+IFZN9p4Gtd1Oy2CTflmHdKllO8cqgzgQDcVP0nscUijT+iurS9SMsYAJ4EPiqrodb1XT17dgw==
X-Received: by 2002:a17:906:3951:b0:a79:7ec8:f3f3 with SMTP id a640c23a62f3a-a797ec8fd28mr544862366b.58.1720850090327;
        Fri, 12 Jul 2024 22:54:50 -0700 (PDT)
Received: from WBEC325.dom.lan ([2001:470:608f:0:b4ea:33f8:5eca:e7fc])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7f1ceesm20515666b.126.2024.07.12.22.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 22:54:49 -0700 (PDT)
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
Subject: [PATCH net-next v3 00/12] net: dsa: vsc73xx: Implement VLAN operations
Date: Sat, 13 Jul 2024 07:54:28 +0200
Message-Id: <20240713055443.1112925-1-paweldembicki@gmail.com>
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
 drivers/net/dsa/vitesse-vsc73xx-core.c | 726 ++++++++++++++++++++++++-
 drivers/net/dsa/vitesse-vsc73xx.h      |  37 ++
 include/linux/dsa/8021q.h              |   8 +-
 include/net/dsa.h                      |   2 +
 net/dsa/Kconfig                        |   6 +
 net/dsa/Makefile                       |   1 +
 net/dsa/tag_8021q.c                    |  84 ++-
 net/dsa/tag_8021q.h                    |   7 +-
 net/dsa/tag_ocelot_8021q.c             |   2 +-
 net/dsa/tag_sja1105.c                  |  72 +--
 net/dsa/tag_vsc73xx_8021q.c            |  68 +++
 13 files changed, 925 insertions(+), 98 deletions(-)
 create mode 100644 net/dsa/tag_vsc73xx_8021q.c

-- 
2.34.1


