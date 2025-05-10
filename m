Return-Path: <netdev+bounces-189452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E8AAB2350
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 12:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29389A05786
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 10:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AD5235340;
	Sat, 10 May 2025 10:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lV6MF5yv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6BD259C;
	Sat, 10 May 2025 10:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746872669; cv=none; b=CZ/ej/sCxj9RerUxNPpwVg4UtSN5I/8hPNiou2CKIajNz0HGvLUf/F0AS1DgubyGJelvoe1yhe/EWth48xqZEKR+OHKaph3jvFaMVYySfo/40JKUTGaeoK5tL0HI0QGPm5IW7GmjDTz2poUYM/IylOBDFY6OrwNaRTC7oBf1Yn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746872669; c=relaxed/simple;
	bh=wnHNMgoot9KpGEi5CBooTZqBluK/Q3+vxIHecX2g2eQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Z9lnNVHT6Lr5JMIP4McY6TS5H8veS9daCkQ2/fVENKBYccbaTg0OExYrboBHD+FVa9hxBu+8rAQvdQw27HduFP5wEwIm34poidYDQ3wSGDOTU1g4YDvRB8WtVni5FlqxC+jEM5YkppSDgc91OLPPuWCNnJ8MUkJv4+UZAJWcqMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lV6MF5yv; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so21397865e9.1;
        Sat, 10 May 2025 03:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746872666; x=1747477466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zKxSsCzPd9u4xpd7kmKpWDs7KnLnF8iUPkHfPwwlEy8=;
        b=lV6MF5yvl0+k5Da0aD9A7uMWx8tkd++FuXG82WBNorR7BfOUOpa0hGdL6Zl0djdhN2
         9TzAltnjEJFYzXaro6XnhnBVhTh/8pP4jMPgqzWja2YGecjPtQ0tsLIHE6yzsfibXfa4
         fL4IAdfEfCP2+VVkvpUQyvRJpORIml7VobYqB0VLr+h587qyRazInP4armn4IXdYfT5a
         EuSe3Kv/aTf4do0wOBijFvZNKQonslHW2LIOkbxBPa9Itg4x2fM+p5u0uUASslt9vpCc
         +ZFX5bltq8EYXFpyM/ucRcZPid/mG9abt0Wb2OsLBTaj1DVY3/HVJnQjQgMPjddEpplR
         6lUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746872666; x=1747477466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zKxSsCzPd9u4xpd7kmKpWDs7KnLnF8iUPkHfPwwlEy8=;
        b=vhuiX09+mRF6RB+437bSDZ8hFsBY1S9DF6SIR63WSkFUiqaYUQnizmt6aoAV3ghO0S
         8umqeBMbMhYFWp26LA3NUVleNyJL1weILGIkLRh5iW1eumX58EnrA/XwCb6K5Bs7eMiA
         cGwsGbEvahZwyyIoyQ7pxcrQD6UTf1HmCXO2HIPHRV2PykPR3m2a52is5ylIVLePzLOx
         fTnIaPQY3yKUZXEj8pD9ffoJIf2UNxGZ3xyiKCFVQR0SiYV+LP62auf3PM8S9efVMSHb
         mghWtDJQzAMEJ1I1isubnYHZEi1sJ/rqmypK9o9bt+wIlsFwacsLS8dDaVXXVkZpRCWh
         gzXQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4ncDifv52RzxlZvZUL7PlZe3OWitaD+Wx9yNyX2suaqk0+Dm2T6GiofiLhhcnChnGYykNhsRK6nV9@vger.kernel.org, AJvYcCWHiqZHKrxeu1eeb+1G7Uqex+82miLehMeKN9L/50JYqsd+8v5Xf+zSaljcOK1sGB0fFR9Np0T9qzSp4w7l@vger.kernel.org, AJvYcCXzVfzR4+Zh/yA47Krfw4lHL8GWut80d8SmFIvnn+5zL8U946dkF5MXiwJoLLv+vS9dny2wxWjQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3zC0Sy2Fs+NtWemrey5UtBQZLVak1X0JzpOkIOS2EgZu7fNVw
	JqQPsI27N3ef9d3HY/OEo4d9+z56pT0imE6oEbrLIBP1zU0Y6s7prYlxig==
X-Gm-Gg: ASbGncte+2QPMdSxl8m1UlAZjYlDE5lA92LXLXCl8vvuSkGeJJWGUUem0kCY0d430gW
	eU6xMeN7Ltfo3Q5ZA2jKbFLYoQbtZE0zT03qnKn0+1SzpM/pCrWswotqHReXA5+A/ucY9+P/kBy
	Ty/nDG3upD4yqyl14hbfHS6bDpGzmQDuyfIh1dwww03+/5KFa1GPlB/msMP+pTPolqTFrdyM0I8
	tGeJi+XdFxq9mylnWAm8Oa70GDxo74y8LH8MZhW9WEzGQa6ETyhFnZKmW7uaj1PxwgNYbHCURDR
	grTEFJ7EYj9ydE6PEZGOLNYO5otv/4jRfTEYzxASxEYHTvrGSClmPTghnxBgGcMnmdWPLa1FzSL
	Gfu6giMXELL+2o0dmzgYo
X-Google-Smtp-Source: AGHT+IER7aYGVjZvmxZddHRM9lepgv9quMoiGYDbNTLn8P/0KGg+V5JhDH8HVNHzudh0XVsJecAxFA==
X-Received: by 2002:a05:600c:528e:b0:43d:77c5:9c1a with SMTP id 5b1f17b1804b1-442d6d19253mr56581905e9.4.1746872665475;
        Sat, 10 May 2025 03:24:25 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442d67df639sm57981265e9.13.2025.05.10.03.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 03:24:25 -0700 (PDT)
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
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [net-next PATCH v3 00/11] net: pcs: Introduce support for fwnode PCS
Date: Sat, 10 May 2025 12:23:20 +0200
Message-ID: <20250510102348.14134-1-ansuelsmth@gmail.com>
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

There is currently an equivalent series for this feature where
a wrapper implementation is proposed. I honestly don't really like
introducing layer of layer of wrapping to workaround stuff, so
this is my attempt at giving a more direct approach to this.

---
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

---
Second PCS handling in phylink:

We have the PCS problem for the only reason that in initial
implementation, we permitted way too much flexibility to MAC driver
and things started to deviate. At times we couldn't think SoC
would start to put PCS outside the MAC hence it was OK to assume
they would live in the same driver. With the introduction of
10g in more consumer devices, we are observing a rapid growth
of this pattern with multiple PCS external to MAC.

To put a stop on this, the only solution is to give back to phylink
control on PCS handling and enforce more robust supported interface
definition from both MAC and PCS side.

It's suggested to read patch 0003 of this series for more info, here
a brief explaination of the idea:

This series introduce handling of PCS in phylink and try to deprecate
.mac_select_pcs.

Phylink now might contain a linked list of available PCS and
those will be used for PCS selection on phylink_major_config.

MAC driver needs to define pcs_interfaces mask in phylink_config
for every interface that needs a dedicated PCS.

These PCS needs to be provided to phylink at phylink_create time
by setting the available_pcs and num_available_pcs in phylink_config.
A helper to parse PCS from fwnode is provided
fwnode_phylink_pcs_parse() that will fill a preallocated array of
PCS. (the same function can be used to get the number of PCS
defined in DT, more info in patch 0005)

phylink_create() will fill the internal PCS list with the passed
array of PCS. phylink_major_config and other user of .mac_select_pcs
are adapted to make use of this new PCS list.

The supported interface value is also moved internally to phylink
struct. This is to handle late removal and addition of PCS.
(the bonus effect to this is giving phylink a clear idea of what
is actually supported by the MAC and his constraint with PCS)

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

---

Changes v3:
- Out of RFC
- Fix various spelling mistake
- Drop circular dependency patch
- Complete Airoha Ethernet phylink integration
- Introduce .pcs_link_down PCS OP
Changes v2:
- Switch to fwnode
- Implement PCS provider notifier
- Better split changes
- Move supported_interfaces to phylink
- Add circular dependency patch
- Rework handling with indirect addition/removal and
  trigger of phylink_resolve()

Christian Marangi (11):
  net: phylink: keep and use MAC supported_interfaces in phylink struct
  net: phy: introduce phy_interface_copy helper
  net: phylink: introduce internal phylink PCS handling
  net: phylink: add phylink_release_pcs() to externally release a PCS
  net: pcs: implement Firmware node support for PCS driver
  net: phylink: support late PCS provider attach
  dt-bindings: net: ethernet-controller: permit to define multiple PCS
  net: phylink: add .pcs_link_down PCS OP
  net: pcs: airoha: add PCS driver for Airoha SoC
  dt-bindings: net: pcs: Document support for Airoha Ethernet PCS
  net: airoha: add phylink support for GDM2/3/4

 .../bindings/net/ethernet-controller.yaml     |    2 -
 .../bindings/net/pcs/airoha,pcs.yaml          |  112 +
 drivers/net/ethernet/airoha/airoha_eth.c      |  138 +
 drivers/net/ethernet/airoha/airoha_eth.h      |    3 +
 drivers/net/ethernet/airoha/airoha_regs.h     |   12 +
 drivers/net/pcs/Kconfig                       |   14 +
 drivers/net/pcs/Makefile                      |    2 +
 drivers/net/pcs/core.c                        |  241 ++
 drivers/net/pcs/pcs-airoha.c                  | 2920 +++++++++++++++++
 drivers/net/phy/phylink.c                     |  287 +-
 include/linux/pcs/pcs-provider.h              |   41 +
 include/linux/pcs/pcs.h                       |  104 +
 include/linux/phy.h                           |    5 +
 include/linux/phylink.h                       |   14 +
 14 files changed, 3867 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/pcs/airoha,pcs.yaml
 create mode 100644 drivers/net/pcs/core.c
 create mode 100644 drivers/net/pcs/pcs-airoha.c
 create mode 100644 include/linux/pcs/pcs-provider.h
 create mode 100644 include/linux/pcs/pcs.h

-- 
2.48.1


