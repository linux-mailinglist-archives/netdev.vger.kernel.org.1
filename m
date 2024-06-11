Return-Path: <netdev+bounces-102689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A80FF904537
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 21:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31F211F268B5
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 19:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8DB15250A;
	Tue, 11 Jun 2024 19:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvD5/ojr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A641509A6;
	Tue, 11 Jun 2024 19:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718135460; cv=none; b=hGrz5BR4qw0D6qT1XAa8fBkfqkyCbwBseZ4Ze2+N5YtR8rGW+58o2j6+IYw1gevGxMWjHGgtsTyzoULxah36n7IilVu95eBKtPc3BFjmLga2PFhl3TfnQUMw2hqeBaTM2PjVdjnQPdZTaLkJQcq3d6qfc/ZTQv4fjoEJGYppgNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718135460; c=relaxed/simple;
	bh=HzqcVLgLFPi42NaNdIhRWUIJxrsIoPw50BWUznbNunY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NAMR+bneLERYbIOiF8dvVwXztnapG2PWyxQFaMQIAWkBdma49jNcQFrJ2+naZomQpXAbWAejmyoBlS6djgbIFFvJweooSARotj3L88lZnYxMM1kNpggBroyRU/qTFDpgsRDuC2E2saW5UMMMC3uXt+kg76N9IHjgRt41TETL74I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvD5/ojr; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52c525257feso4529618e87.1;
        Tue, 11 Jun 2024 12:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718135456; x=1718740256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K+DQW8mEWgMpkm6H9SEcHthcwoLYLPs2cBM5ZY3afc4=;
        b=UvD5/ojrWxYryxvtpOONe7NtJHHC5fp3Ok9n6sTGxEqvAzeezam6AQ4ECwc5xm8iuH
         zzU7GRPp8kW1D0ghd926iHuetMI+oydDEv5R770bRcs15BXxGtKHLTrH2OvnlUZ/P1nT
         xe4vfk9jfy04SQWeaZGHSgxC0OCFial9qSgUBjo2PX/Ypujx6TaV4CGeNG73dpPQQTyU
         YiCTNFRiEexVL8HiK9GQ7TWrTByDoJ7Aj+c7mtYli6LXJ1FB8rzxQpq6uKgxyxNOMbx2
         VmY8n0TOhmsBOQIv7b+aqd47Cl9+hLBOKXy1Wo7AL8v9+FgqoBaWP7Q7Nk5oRwEOHmAb
         xihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718135456; x=1718740256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K+DQW8mEWgMpkm6H9SEcHthcwoLYLPs2cBM5ZY3afc4=;
        b=hwuWNr4iz8zR/sQaT2/nIEePzZxK7cXXlYo6ASRohKpZOd2Fcj6JoyCZMAiDnNsgsG
         Zx9TzP2D86oVauYEZyZ6G4WqOFBptXm/IYkwPtw/OPbRSdtf2tFss/G8tX91x+JEurzq
         +674BIn/mS2avQEk8rerpG2E3hDu1A1PCpNLVuxscIjVD479G3qp+ACxFlvioORoFkXb
         IAZQK8lCrzkKCi6ONwGHSfd9mp4fVElNaApDll7g9HiknQ0JBjEN05o/zEd0zYxD5N3T
         kdIXEgy5AJyzPwtglVvEOAMY3dXVMAQWOktARIU1hfUZFkmSmBSu/JTV1p2RcvDl2rjH
         Ah+w==
X-Forwarded-Encrypted: i=1; AJvYcCWLiaOCRvgT12fLU/hpI6Vh52ZAh83k1vsNRht9xiukXmwzWNwGNApxqlA80wfVTnrGENFdZ4pX1oY5JuEF4XHibsOo/JkLraGg/mp3
X-Gm-Message-State: AOJu0Yz1O/B5i7ymgbmSj+aOQbPMMZ5yt8P/flARHhfppoFwRfaiiqrz
	Np49OI5H/7KPqdwqNGRl3bh1Hr9RMFC6HdXtNLLD2fTIlxcswARAnvdlsT7ThrQ=
X-Google-Smtp-Source: AGHT+IGxx+GedmwUCdxuIKlFvLE8lRy7drxxAwBYA7ggKBPqJarKQdP2QW/N98aL0bmQa5x+WXSeOw==
X-Received: by 2002:ac2:4e0b:0:b0:52c:896c:c10f with SMTP id 2adb3069b0e04-52c896cc334mr4751992e87.53.1718135456111;
        Tue, 11 Jun 2024 12:50:56 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c7650b371sm5286737a12.76.2024.06.11.12.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 12:50:55 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 00/12] net: dsa: vsc73xx: Implement VLAN operations
Date: Tue, 11 Jun 2024 21:49:52 +0200
Message-Id: <20240611195007.486919-1-paweldembicki@gmail.com>
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
 drivers/net/dsa/vitesse-vsc73xx-core.c | 668 ++++++++++++++++++++++++-
 drivers/net/dsa/vitesse-vsc73xx.h      |  42 ++
 include/linux/dsa/8021q.h              |   8 +-
 include/net/dsa.h                      |   2 +
 net/dsa/Kconfig                        |   6 +
 net/dsa/Makefile                       |   1 +
 net/dsa/tag_8021q.c                    |  86 +++-
 net/dsa/tag_8021q.h                    |   7 +-
 net/dsa/tag_ocelot_8021q.c             |   2 +-
 net/dsa/tag_sja1105.c                  |  72 +--
 net/dsa/tag_vsc73xx_8021q.c            |  68 +++
 13 files changed, 874 insertions(+), 98 deletions(-)
 create mode 100644 net/dsa/tag_vsc73xx_8021q.c

-- 
2.34.1


