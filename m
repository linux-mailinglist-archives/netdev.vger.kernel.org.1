Return-Path: <netdev+bounces-188703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7F6AAE496
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 17:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12AC21723DE
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 15:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1FF28A417;
	Wed,  7 May 2025 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ibpfTMSy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587B228A1C0
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 15:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746631519; cv=none; b=h5/3jJQacncIFLccLvehoPcGA43g+2q63crcnwVJoO1B/BY5yB+sxcKI1WAgY3oCyK0tcdHtGapwhpz/IJ99kLi+BFUiQHW3120V9SwUFu8tJb+Lw+tObqI4XA2QBy/wzN0jqq6o+kMn6a6uoPC/sRphbP2JMjqcw+4EwjS+wxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746631519; c=relaxed/simple;
	bh=K9BRDIL0CVS4oITjOHrWKVkCotibvzU+S8xnmOlOKZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=scW8bDAtCget6sC6xgXx+MEZeMuJtLRbA0eaZc758msySNJERCEa13W9HZTojODV7nOMwwAwwTnyAPFGXpPjz20gU/5RcpkKAp8da7iJrQqtfVjmwWef60DS9Sy8IkmbpYH0U7oxKL/g7B7F56L3USlpHmBsNTrICLu4/epAI7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ibpfTMSy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746631516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PUIklBSjevHpLqEddNRNlR2otYrePkDDS5il9MiLCxc=;
	b=ibpfTMSyfzV8CEsf20iqlTS5XftWYWxDpY0zBHZMv2miNucHt78OpQeA7SgTlDtJrp39p5
	d81Y4mG/stkA52cGUHETJn2V8VM5A9k+BkyW47nYZUQcy7QumiVuLr30eA82P2ZkUbjsOG
	DDz70G/OZwKbzB4Eg1ztf6UIwDnEmiA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-oUgHaqJyM3esGBBJ2G8R-w-1; Wed,
 07 May 2025 11:25:14 -0400
X-MC-Unique: oUgHaqJyM3esGBBJ2G8R-w-1
X-Mimecast-MFC-AGG-ID: oUgHaqJyM3esGBBJ2G8R-w_1746631512
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9294B1800360;
	Wed,  7 May 2025 15:25:11 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.33.91])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 444BC30001B9;
	Wed,  7 May 2025 15:25:06 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Michal Schmidt <mschmidt@redhat.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next v8 0/8] Add Microchip ZL3073x support (part 1)
Date: Wed,  7 May 2025 17:24:56 +0200
Message-ID: <20250507152504.85341-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add support for Microchip Azurite DPLL/PTP/SyncE chip family that
provides DPLL and PTP functionality. This series bring first part
that adds the common MFD driver that provides an access to the bus
that can be either I2C or SPI.

The next part of the series is bringing the DPLL driver that will
covers DPLL functionality. Another series will bring PTP driver and
flashing capability via devlink in the MFD driver will follow soon.

Testing was done by myself and by Prathosh Satish on Microchip EDS2
development board with ZL30732 DPLL chip connected over I2C bus.

Patch breakdown
===============
Patch 1 - Common DT schema for DPLL device and pin
Patch 2 - DT bindings for microchip,zl3073* devices
Patch 3 - Basic support for I2C, SPI and regmap configuration
Patch 4 - Devlink device registration and info
Patch 5 - Helpers for reading and writing register mailboxes
Patch 6 - Fetch invariant register values used by DPLL/PTP sub-drivers
Patch 7 - Clock ID generation for DPLL driver
Patch 8 - Register/create DPLL device cells

---
v7->v8:
* replaced zl3073x_pdata array ZL3073X_PDATA macro in patch 8
v6->v7:
* pass channel number using platform data instead of mfd_cell->id
v5->v6:
* fixed devlink info firmware version to be running instead of fixed
* added documentation for devlink info versions
v4->v5:
* fixed DT patches description
* dropped mailbox API
* added type-safe register access functions
* added an ability to protect multi-op accesses
v3->v4:
* fixed shortcomings in DT patches
* completely reworked register access
* removed a need to manage locking during mailbox accesses by callers
* regcache switched to maple
* dev_err_probe() in probe path
* static mfd cells during sub-devices registration
v1->v3:
* dropped macros for generating register access functions
* register access functions are provided in <linux/mfd/zl3073x_regs.h>
* fixed DT descriptions and compatible wildcard usage
* reworked regmap locking
  - regmap uses implicit locking
  - mailbox registers are additionally protected by extra mutex
* fixed regmap virtual address range
* added regmap rbtree cache (only for page selector now)
* dropped patches for exporting strnchrnul and for supporting mfg file
  this will be maybe added later

Ivan Vecera (8):
  dt-bindings: dpll: Add DPLL device and pin
  dt-bindings: dpll: Add support for Microchip Azurite chip family
  mfd: Add Microchip ZL3073x support
  mfd: zl3073x: Add support for devlink device info
  mfd: zl3073x: Protect operations requiring multiple register accesses
  mfd: zl3073x: Fetch invariants during probe
  mfd: zl3073x: Add clock_id field
  mfd: zl3073x: Register DPLL sub-device during init

 .../devicetree/bindings/dpll/dpll-device.yaml |  76 ++
 .../devicetree/bindings/dpll/dpll-pin.yaml    |  45 +
 .../bindings/dpll/microchip,zl30731.yaml      | 115 +++
 Documentation/networking/devlink/index.rst    |   1 +
 Documentation/networking/devlink/zl3073x.rst  |  37 +
 MAINTAINERS                                   |  11 +
 drivers/mfd/Kconfig                           |  32 +
 drivers/mfd/Makefile                          |   5 +
 drivers/mfd/zl3073x-core.c                    | 872 ++++++++++++++++++
 drivers/mfd/zl3073x-i2c.c                     |  68 ++
 drivers/mfd/zl3073x-regs.h                    |  54 ++
 drivers/mfd/zl3073x-spi.c                     |  68 ++
 drivers/mfd/zl3073x.h                         |  31 +
 include/linux/mfd/zl3073x-regs.h              |  88 ++
 include/linux/mfd/zl3073x.h                   | 202 ++++
 15 files changed, 1705 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dpll/dpll-device.yaml
 create mode 100644 Documentation/devicetree/bindings/dpll/dpll-pin.yaml
 create mode 100644 Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml
 create mode 100644 Documentation/networking/devlink/zl3073x.rst
 create mode 100644 drivers/mfd/zl3073x-core.c
 create mode 100644 drivers/mfd/zl3073x-i2c.c
 create mode 100644 drivers/mfd/zl3073x-regs.h
 create mode 100644 drivers/mfd/zl3073x-spi.c
 create mode 100644 drivers/mfd/zl3073x.h
 create mode 100644 include/linux/mfd/zl3073x-regs.h
 create mode 100644 include/linux/mfd/zl3073x.h

-- 
2.49.0


