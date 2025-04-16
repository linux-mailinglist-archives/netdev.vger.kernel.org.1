Return-Path: <netdev+bounces-183381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B7BA908A2
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 18:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8D33188EB5B
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64338211A0B;
	Wed, 16 Apr 2025 16:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f5Sc6aOT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9961F8AC5
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 16:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744820523; cv=none; b=iUccnAKuWCgrR5Pz7oR7Xq1+YEjjQB1Z8HCsoiaEK1l9kQlzr6e4Pd4mqE5iHDQYzesPhRHD1SClUOeFUp52JG4gCBjx9RoHEu4hciaJ1W3aP6YwROZyobCAlQOYMxCzE78LIHpkVhRfywiiosFi5ZcWB3OIkVRqvxYGt/ZrR+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744820523; c=relaxed/simple;
	bh=5/w4MKEHC28jIWdGqfAyKCZ3+d4rZmueIB1qcLirGOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IlCeKOzoQGSA3JhYDDNinOeDn9K3H1KfO7SKDAgWxlZPYRKK1DEqK8a2b+Qfv/NyuvmsumKf3Xw66ilBjOY8LNJUwtKRpu4PkZZ4cy9j1h67e/TB7BxUKHoEZ6R+8V0MKtQxOVo6XUO3r/TsZGazlmqLOP5xto3a0CAz6bte208=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f5Sc6aOT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744820519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=46pvO5bo7cRFjcpTxq8cD32SjPKm2nm97fut9e9I2Sw=;
	b=f5Sc6aOTWpiWO3zNVFtPInrKCZfTYg4r7eGa9s0Zv9TbqIafa0xG8MKLcWlyj7zBeO0aaU
	TAQu8RhIhsgc4ycxFZFppgcIGO4d9c8TB8USsldO7QcNmDt0YYI1daojurz/kOtix8llWH
	Un4bjUbDyVag0eZpCOPlaneSvteS/B0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-N18t3VnvOQeihfOlrx5alQ-1; Wed,
 16 Apr 2025 12:21:53 -0400
X-MC-Unique: N18t3VnvOQeihfOlrx5alQ-1
X-Mimecast-MFC-AGG-ID: N18t3VnvOQeihfOlrx5alQ_1744820511
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 92E5C1800446;
	Wed, 16 Apr 2025 16:21:50 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.33.32])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6E0D8180094C;
	Wed, 16 Apr 2025 16:21:45 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Lee Jones <lee@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Schmidt <mschmidt@redhat.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3 net-next 00/10] Add Microchip ZL3073x support (part 1)
Date: Wed, 16 Apr 2025 18:21:36 +0200
Message-ID: <20250416162144.670760-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
Patch 6 - Clock ID generation for DPLL driver
Patch 7 - Fetch invariant register values used by DPLL/PTP sub-drivers
Patch 8 - Register/create DPLL device cells

---
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

Ivan Vecera (10):
  dt-bindings: dpll: Add device tree bindings for DPLL device and pin
  dt-bindings: dpll: Add support for Microchip Azurite chip family
  mfd: Add Microchip ZL3073x support
  mfd: zl3073x: Add support for devlink device info
  mfd: zl3073x: Add functions to work with register mailboxes
  mfd: zl3073x: Add clock_id field
  lib: Allow modules to use strnchrnul
  mfd: zl3073x: Load mfg file into HW if it is present
  mfd: zl3073x: Fetch invariants during probe
  mfd: zl3073x: Register DPLL sub-device during init

 .../devicetree/bindings/dpll/dpll-device.yaml |  76 ++
 .../devicetree/bindings/dpll/dpll-pin.yaml    |  44 +
 .../bindings/dpll/microchip,zl30731.yaml      | 115 +++
 MAINTAINERS                                   |  11 +
 drivers/mfd/Kconfig                           |  32 +
 drivers/mfd/Makefile                          |   5 +
 drivers/mfd/zl3073x-core.c                    | 899 ++++++++++++++++++
 drivers/mfd/zl3073x-i2c.c                     |  70 ++
 drivers/mfd/zl3073x-spi.c                     |  70 ++
 drivers/mfd/zl3073x.h                         |  31 +
 include/linux/mfd/zl3073x.h                   | 225 +++++
 include/linux/mfd/zl3073x_regs.h              | 593 ++++++++++++
 lib/string.c                                  |   1 +
 13 files changed, 2172 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dpll/dpll-device.yaml
 create mode 100644 Documentation/devicetree/bindings/dpll/dpll-pin.yaml
 create mode 100644 Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml
 create mode 100644 drivers/mfd/zl3073x-core.c
 create mode 100644 drivers/mfd/zl3073x-i2c.c
 create mode 100644 drivers/mfd/zl3073x-spi.c
 create mode 100644 drivers/mfd/zl3073x.h
 create mode 100644 include/linux/mfd/zl3073x.h
 create mode 100644 include/linux/mfd/zl3073x_regs.h

-- 
2.48.1


