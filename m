Return-Path: <netdev+bounces-179482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B63A7D0E7
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 00:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 141AE188CAA9
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 22:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6541F221546;
	Sun,  6 Apr 2025 22:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzGtCAtH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7678F2206A2;
	Sun,  6 Apr 2025 22:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743977703; cv=none; b=HOjHk1eB5r/qZ0e6mTEp7r0RmYWOCgYIgVtWQxpMGv+l1qksdG/M2D08/jftyQ126VYppzzVXM8lV/2nCI5yQJdvqRV9X4E1G6f3vSEhMxKzbqfqQw5X6JhM43eZzPz+YxPnSphboxNnyfyNmlSp6o+9bDtEmvosXeyjtTVW8o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743977703; c=relaxed/simple;
	bh=+gO2vOZOoGVA9CNvta4yTCJGKH2tgh0gv3r52G25KgU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=rLlNFJnXfcS7cBPYohA56vRzJjutaMvI4y/hyGath44J6ZDW4AH9VJ4jcuQq29ZBNcWscrNTrk1s0CtLhPwheId8IRGY5h/q21R/61offOXG2q4+xxQkRhusqAPxGwz+OO+rurzvLuze0JDPtVhJKjGpvsofefjpu6OJbE4Hl9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzGtCAtH; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so12371495e9.0;
        Sun, 06 Apr 2025 15:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743977700; x=1744582500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kQY49MNV2vw+RYB/lwmnIQvb/vWfn9IT+VLkvnf1e7s=;
        b=lzGtCAtHzysh40WdomGH31lO3GuMqBJvQ/sotFu5fblwV5ioah6+ZxElpCkQ42GiDS
         8RSPZeyufAdG+FOuPrYLLhn6gImZqG6PpT8i8RM4g2mj4Glc/JI9vm4YI6mec0Ciu+0P
         KDq+qeZPeuQUnCiKFM8EuqylbV14k+Bp7EbW72yJwUlySKkn/gCoo9+Vysj961gDltvb
         rNHaPkLPwzuZ0L09pHhayhsNGDRftVEB8UyR0GT9a+7rnztVSwvZzgYRKeKXMKGzmAyk
         2pBwli+KZEl4RZY+k/HLl4NZ1DoMMc35hQYOzXtmfdqeF7me9uSJwR2lT9/2dg+wCkwe
         6JvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743977700; x=1744582500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kQY49MNV2vw+RYB/lwmnIQvb/vWfn9IT+VLkvnf1e7s=;
        b=dldmVeK7vuVzB3bOxXKf3ffdO99itYz+srm2oVKYEh8ZV9tohZue+L3yghqJInP27f
         bjjCK+oJuGDnlByIArVwjUKs1eftmADYsiv4w2CFpuOyG99SdL/kg+M9C6ZuEG36OifC
         R8BKvPGQjlC9vFtzoJFXggl04XWh+fvEYeP0kcP1b/KOE55O3SGzRwEhIyrpyIjCvbhu
         n7YYQOaokWCqAvab2bo/guIm7eoU9gVHT1QwlluhGM/q+Ez1sgUIt9xCc6ABaPOZzC28
         GfgJ7+LROpZzu2z0YqaXQndcRWhVYojsfdI0KbPJBTHUgv354zpOcMlb6LS2n701W3zc
         07bQ==
X-Forwarded-Encrypted: i=1; AJvYcCUK2qRMmw8PJz+UVpJ5QKO8F1O9GogBo7j0cu9VeHi15UpUsVZGQDDGF+brLICPRBxUNsU4uIZm@vger.kernel.org, AJvYcCXMyHBzbgOX9RVBz6YoWC7r556X555W6+Ed+ty2j2QI2s7l0WREkPlN2W06VMW6O369sQJtbIVGPCCS@vger.kernel.org, AJvYcCXwW0vfyrSiLZiJNoGpAJArqifhiznE3EvtBjoYWWpCkNnEO4ZxXwzq5tS+WhH5q9/Sqh+JO0FBHrJCTMgo@vger.kernel.org
X-Gm-Message-State: AOJu0YxrNARJzxldAsLOnW9cX5SNTdhnbsG479tKLJ54dFWl61rMqmBU
	nLWTc7uQxwZ5g6rqQzaYsCOf7g9Jye0cRNe5h2xLUJCZpZMVwHRM
X-Gm-Gg: ASbGncumv4PBuAhoW3S6XM5s7MeLYLT465OIpnFEnLohxGFARWLSIefcebQMcspX0++
	PO+M9F/sA73yRydJelk1XmgyBzkDYwdplOto056RYsq7iv52kObWkrkX5x55IRDKFq413Pjbaew
	Ra86q8bSJupKDprd8sbY2W6Z4LmomMnwbeCSPA7BIMtbVGikSJPTFF6w+avjaTyYUpLwa3Zxbvy
	fllOqV4zX2b+nZMx4/eqK8/a42uZesfHgStuUCLQE++KnJIuI85CyFDUv0u/p/EqVBPh9RW3TPG
	00hibruQOlaE/T1QACY4aH7zTib+0RaJRdAa8cuKBGNRv2ME1jou2PQmyFzMXjtFiM/RQPmPWUW
	Xkt6XKpGWzrXapQ==
X-Google-Smtp-Source: AGHT+IFHPZSGfdYEiMrh30dapV2ATq2oroNmn/OyTiAdMgqfo6FsGmPAIu/fmpb4M1YuUBVOTcPLPg==
X-Received: by 2002:a05:600c:35c8:b0:43c:f513:9591 with SMTP id 5b1f17b1804b1-43ecf86b406mr90635615e9.14.1743977699324;
        Sun, 06 Apr 2025 15:14:59 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43ec366aa29sm111517055e9.39.2025.04.06.15.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 15:14:58 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	"Lei Wei (QUIC)" <quic_leiwei@quicinc.com>
Subject: [RFC PATCH net-next v2 00/11] net: pcs: Introduce support for fwnode PCS
Date: Mon,  7 Apr 2025 00:13:53 +0200
Message-ID: <20250406221423.9723-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduce a most awaited feature that is correctly
provide PCS with fwnode without having to use specific export symbol
and additional handling of PCS in phylink.

First the PCS fwnode:

The concept is to implement a producer-consumer API similar to other
subsystem like clock or PHY.

That seems to be the best solution to the problem as PCS driver needs
to be detached from phylink and implement a simple way to provide a
PCS while maintaining support for probe defer or driver removal.

To keep the implementation simple, the PCS driver devs needs some
collaboration to correctly implement this. This is O.K. as helper
to correctly implement this are provided hence it's really a matter
of following a pattern to correct follow removal of a PCS driver.

A PCS provider have to implement and call fwnode_pcs_add_provider() in
probe function and define an xlate function to define how the PCS
should be provided based on the requested interface and phandle spec
defined in fwnode (based on the #pcs-cells)

fwnode_pcs_get() is provided to provide a specific PCS declared in
fwnode at index.

A simple xlate function is provided for simple single PCS
implementation, fwnode_pcs_simple_get.

A PCS provider on driver removal should first call
fwnode_pcs_del_provider() to delete itself as a provider and then
release the PCS from phylink with phylink_release_pcs() under rtnl
lock.

This series also introduce handling of PCS in phylink and try
to deprecate .mac_select_pcs.

Phylink now might contain a linked list of available PCS and
those will be used for PCS selection on phylink_major_config.

MAC driver needs to define pcs_interfaces mask in phylink_config
for every interface that needs a dedicated PCS.

These PCS can be provided to phylink at phylink_create time
by setting the available_pcs and num_available_pcs in
phylink_config.
A helper to parse PCS from fwnode is provided
fwnode_phylink_pcs_parse() that will fill a preallocated array of
PCS.

phylink_create() will fill the internal PCS list with the passed
array of PCS. phylink_major_config and other user of .mac_select_pcs
are adapted to make use of this new PCS list.

The supported interface value is also moved internally to phylink
struct. This is to handle late removal and addition of PCS.

The supported interface mask in phylink is done by OR the
supported_interfaces in phylink_config with every PCS in PCS list.

PCS removal is supported by forcing a mac_config, refresh the
supported interfaces and run a phy_resolve().

PCS late addition is supported by introducing a global notifier
for PCS provider. If a phylink have the pcs_interfaces mask not
zero, it's registered to this notifier.

PCS provider will emit a global PCS add event to signal any
interface that a new PCS might be avialable.

The function will then check if the PCS is related to the MAC
fwnode and add it accordingly.

A user for this new implementation is provided as an Airoha PCS
driver. This was also tested downstream with the IPQ95xx QCOM SoC
and with the help of Daniel also on the various Mediatek MT7988
SoC with both SFP cage implementation and DSA attached.

Lots of tests were done with driver unbind/bind and with interface
up/down also by adding print to make sure major_config_fail gets
correctly triggered and reset once the PCS comes back.

The dedicated commits have longer description on the implementation
so it's suggested to also check there for additional info.

While this was developed there was a different version that was
proposed for the feature, this is posted with the hope of
implementing a more streamlined implementation and as a
continuation of v2 with the addressed request from Russell.

Changes v2:
- Switch to fwnode
- Implement PCS provider notifier
- Better split changes
- Move supported_interfaces to phylink
- Add circular dependency patch
- Rework handling with indirect addition/removal and
  trigger of phylink_resolve()

Christian Marangi (11):
  net: phylink: fix possible circular locking dep with config in-band
  net: phylink: keep and use MAC supported_interfaces in phylink struct
  net: phy: introduce phy_interface_copy helper
  net: phylink: introduce internal phylink PCS handling
  net: phylink: add phylink_release_pcs() to externally release a PCS
  net: pcs: implement Firmware node support for PCS driver
  net: phylink: support late PCS provider attach
  dt-bindings: net: ethernet-controller: permit to define multiple PCS
  net: pcs: airoha: add PCS driver for Airoha SoC
  dt-bindings: net: pcs: Document support for Airoha Ethernet PCS
  net: airoha: add phylink support for GDM2/3/4

 .../bindings/net/ethernet-controller.yaml     |    2 -
 .../bindings/net/pcs/airoha,pcs.yaml          |  112 +
 drivers/net/ethernet/airoha/airoha_eth.c      |  266 +-
 drivers/net/ethernet/airoha/airoha_eth.h      |    4 +
 drivers/net/ethernet/airoha/airoha_regs.h     |   12 +
 drivers/net/pcs/Kconfig                       |   14 +
 drivers/net/pcs/Makefile                      |    2 +
 drivers/net/pcs/pcs-airoha.c                  | 2855 +++++++++++++++++
 drivers/net/pcs/pcs.c                         |  235 ++
 drivers/net/phy/phylink.c                     |  283 +-
 include/linux/pcs/pcs-airoha.h                |   26 +
 include/linux/pcs/pcs-provider.h              |   41 +
 include/linux/pcs/pcs.h                       |  104 +
 include/linux/phy.h                           |    5 +
 include/linux/phylink.h                       |   12 +
 15 files changed, 3942 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/pcs/airoha,pcs.yaml
 create mode 100644 drivers/net/pcs/pcs-airoha.c
 create mode 100644 drivers/net/pcs/pcs.c
 create mode 100644 include/linux/pcs/pcs-airoha.h
 create mode 100644 include/linux/pcs/pcs-provider.h
 create mode 100644 include/linux/pcs/pcs.h

-- 
2.48.1


