Return-Path: <netdev+bounces-187022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D30B5AA47E8
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 12:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53714189A1D7
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 10:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AA623817F;
	Wed, 30 Apr 2025 10:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d41inHLZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020DE231859
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 10:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746007902; cv=none; b=Vd/P5q5urPc/C7Hw27Hi1Njzc8UW+pL/jPoJvrKcxwG7glHf0VED9H2QG9JZ/rILHflZY4uu4WaxHqeuhlkGuhqsitscQU70I21qnVbcgHDgssfulQHyeMmJEWO8Y8IreOB+oH6bglBgCgM+B2eus0cSr+fXlES8IA/xVcXiZZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746007902; c=relaxed/simple;
	bh=TOwUtRIAV+jPy+YMV8u3gKvjNhsZV6TyG6DxIOrn/1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K3+3iAUlY9kzF7QHS6/jvNaJqqE35yoanyyKb58BwgOKlboJwCjpYfTUDyqc29YmQhqOHZvDCMWPd2h9UKnHj4XDufVN84jw6O9+a4BiZjztbHUGr/Vhk1bi2EaakglRZya3rrwbgUnXXdP0h0Um5b8mQbrgPwTpaes7pOcoMOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d41inHLZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746007900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0IopPiKyCnXQE4fNnJ+UK76ut19IbyEAHXIe/thBuxA=;
	b=d41inHLZuKfuc1sKXMMmypUyYluGtuZa1XmOae7BpFtDgaW9V0zSWXzb4fUErOIILpGX7U
	IclU2cLr+5n/bTdiNlsFwoOS37Pnya+f0r7RhjzOvxxuMETO3K9k98cbwab2kuQ7bsEJrG
	WEMOvQSwSLRF0J3gYM/1R6XzRVxBvwk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-354-2rtPlAYKNmGGq-3dnaLeKg-1; Wed,
 30 Apr 2025 06:11:35 -0400
X-MC-Unique: 2rtPlAYKNmGGq-3dnaLeKg-1
X-Mimecast-MFC-AGG-ID: 2rtPlAYKNmGGq-3dnaLeKg_1746007893
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 860331956094;
	Wed, 30 Apr 2025 10:11:32 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.33.50])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9FD1E1956094;
	Wed, 30 Apr 2025 10:11:27 +0000 (UTC)
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
Subject: [PATCH net-next v6 0/8] Add Microchip ZL3073x support (part 1)
Date: Wed, 30 Apr 2025 12:11:18 +0200
Message-ID: <20250430101126.83708-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

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
 drivers/mfd/zl3073x-core.c                    | 864 ++++++++++++++++++
 drivers/mfd/zl3073x-i2c.c                     |  68 ++
 drivers/mfd/zl3073x-regs.h                    |  54 ++
 drivers/mfd/zl3073x-spi.c                     |  68 ++
 drivers/mfd/zl3073x.h                         |  31 +
 include/linux/mfd/zl3073x-regs.h              |  88 ++
 include/linux/mfd/zl3073x.h                   | 191 ++++
 15 files changed, 1686 insertions(+)
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


