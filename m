Return-Path: <netdev+bounces-111268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E984B93075A
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 23:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A38EA2827F0
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 21:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30E013DDDD;
	Sat, 13 Jul 2024 21:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFw0e3WN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6AD4C8E;
	Sat, 13 Jul 2024 21:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720905391; cv=none; b=GWAW8cOPV5t7Bl7rKBcMyEuLrmACauCFPU7tfHD0LacPhXM09atW2Fs7vaEoLcwAtJjvQGhSLDsowE7RUK8WpOltgrL1LmBKTUPDE6e4miBvumyOdttYuyfn0TrEvG8GYLhy7u7cTQwdbbycU5I9fV1pTZz7/35c7B2magmu8Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720905391; c=relaxed/simple;
	bh=MW1wtjjOibkuxIr/2qxTm4Ye4Lyer2AmHIv/1EcDOVs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l6DhtLifrgGHHwEN8zs2VWDHm6rWcasPGahAGMIqxtNIEoT8vbjmlbZZ2OjyeJs0MPZsey/JQyvyyr0N6bzw3EBtqeYQmvX5nOe+YMpJ4Jjzlb2xZKWYU5q2YS0ra4+kGof4hRPjpq8g2CcFol9kbxVpUfQbtpWF2cK+5RlBRCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFw0e3WN; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52ea2b6a9f5so3270999e87.0;
        Sat, 13 Jul 2024 14:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720905388; x=1721510188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wrx78QdwM8a2BP5jMkuj8qOxD2RAOM8RMdabjloKUV8=;
        b=fFw0e3WNb2nEXcyDj+nQ37UzIiloBOS+jqFXfm5q3/fnu7YiwEUIQSGMTD8cEG+mHC
         tqBvHZU7gbjV1ryDbUuWItr5WG5CmhFd+ScO9KSFQqWuLlyPzFcnYljib6cpevQaU/qq
         tURIZ4NuYYY1YeUL2Kz7SWnJTrsoa07U19bajjPZfQ4hd7EOKp0hfTwr9hVIrlf170b+
         R96W/NqESGY6GgLc6z4QnkQkDOy9pfEnSTcSg0AjzEmZe2+0V1awPGMfeluwMsT3QPV+
         G7+ptEH+UuDcttZ0yKkEzkeQ9hjCUDN9glgP46/blrqCep3ZtKeWFkA+quSX47rKFLqV
         5JEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720905388; x=1721510188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wrx78QdwM8a2BP5jMkuj8qOxD2RAOM8RMdabjloKUV8=;
        b=lg/iXhewmtSYIOhk8rVyy05xc2Qb/83lrwJ+UB7gLrZDv+EC9VJ0MSyP7MizXxNq6H
         i1Qvv/LTV195lhHbU07r8QD62leejpPqVgfToARBlpuZRUlmce/r6QU0S/B0iSpSkNQD
         7gqKIjd6O8oQBwz5wt+uUewX6Pk8iU2I8ZNFEPqAtecosUibkno6/JR4xKGE/lkrZ9ON
         sE73X5VTHBLKGP2GSMe8VHscCxSL6QWFzrFDGlwxodGkR5+k0qLmYZDUlWEjObIQcBKr
         7Rrq9cEtUdRVw3zIxdkz3HiU+rHu3jLz2m0UoVSAYE86jQiS/iEDacparExOZ16dpBfM
         QrQw==
X-Forwarded-Encrypted: i=1; AJvYcCUqfcWXEPSfjbihMgO0v89OY8aCXlNKp7elk2ksaczxYUwRXBL2Iqs/LXTidYgjvRpTkjkvQCoLHBYFYRoscYKpAm1HmWz2p15dNOIm
X-Gm-Message-State: AOJu0Yx2yLBxqPndfdy/T9AxxbnSTzvTYxXw9SIoPJFQqVqaNRvPzVYi
	VpuvtRc6dU60HwNxTtcgdLNEwACga1QyO3Zv4fVVTMD43eaiaAtRaEmc9q9T
X-Google-Smtp-Source: AGHT+IHhTdI2ukrurOMa9jOZyq8uj4z99/WAc+YHnrztZXcWCZSTpe5RgDG7Z0X5U/1f0Yae9U7BoQ==
X-Received: by 2002:a05:6512:312f:b0:52c:b479:902d with SMTP id 2adb3069b0e04-52eb999135bmr8460688e87.4.1720905387472;
        Sat, 13 Jul 2024 14:16:27 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b255253b6sm1187286a12.41.2024.07.13.14.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 14:16:26 -0700 (PDT)
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
Subject: [PATCH net-next v4 00/12] net: dsa: vsc73xx: Implement VLAN operations
Date: Sat, 13 Jul 2024 23:16:06 +0200
Message-Id: <20240713211620.1125910-1-paweldembicki@gmail.com>
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
 drivers/net/dsa/vitesse-vsc73xx-core.c | 735 ++++++++++++++++++++++++-
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
 13 files changed, 934 insertions(+), 98 deletions(-)
 create mode 100644 net/dsa/tag_vsc73xx_8021q.c

-- 
2.34.1


