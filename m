Return-Path: <netdev+bounces-179780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A661A7E836
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1F503AB77B
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 17:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764252163B6;
	Mon,  7 Apr 2025 17:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P9AxCx8F"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E341A5BA3
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 17:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744046931; cv=none; b=fB9cNCYddhHF6R+N4H9lIb7LB02SvU7i4E6AiaA2ON+W1qpXgmw/sxEM9Y2k53Qji2GWciTzEYoNz1oIU+OK7qWtn3pg5FeqJmh4d8XcuGWRJElqbMVqEoS3MsJHFfjH8MYt8nGthaNfkT9Gjefp6mOToRtv6BurQ3WFfeH01og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744046931; c=relaxed/simple;
	bh=wsHHJZqntazBpATd7YuS+J2IlhAOuKOpdFMOBcPiE/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a6zQvCtmetpMZup/XUuCClaFvL9V9alZ57xm9QjCxsZRiBstNIuT5y45WnDBVHZ2ruaEdGOw9Bb+LGtdI1xgYsroWi0Kcy45xBiSUJz5ySwDD0AZGcE4xjyubJoEZfHQqhqVGDN7D6DZida/Rsf67P/rk6m/e5TX4+lUODSNABg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P9AxCx8F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744046928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bFO8XTLN8X6PR8VKPvsVUaoldbdxYBtD0THNWLQS6Mk=;
	b=P9AxCx8FIpokua68b53oPvOpL/1dJ+nXkNXmwJYOHSRuVY/IBIfyDsp3CH3kpAxHPTnVFH
	inz1pkw1/7jwMj7CMpsCeNoX7jS0JXSTk2P4JC365TXEqYNRSkOCH1bQRKMf9lBhM60bNz
	NRaPl6xThvl3EeRACkcHRTN/u/a+j3s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-Thv6vA51MdGQe-uhtfgtTA-1; Mon,
 07 Apr 2025 13:28:46 -0400
X-MC-Unique: Thv6vA51MdGQe-uhtfgtTA-1
X-Mimecast-MFC-AGG-ID: Thv6vA51MdGQe-uhtfgtTA_1744046924
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 979BE180034D;
	Mon,  7 Apr 2025 17:28:43 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.4])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8A186180A803;
	Mon,  7 Apr 2025 17:28:37 +0000 (UTC)
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
Subject: [PATCH 00/28] Add Microchip ZL3073x support
Date: Mon,  7 Apr 2025 19:28:27 +0200
Message-ID: <20250407172836.1009461-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This series adds support for Microchip Azurite DPLL/PTP/SyncE chip
family. These chips provide DPLL and PTP functionality, so the series
adds the common MFD driver that provides an access to the bus that can
be either I2C or SPI. The second part of the series is DPLL driver that
covers DPLL functionality. The PTP support will be added by separate
series as well as flashing capability.

All functionality was tested by myself and by Prathosh Satish on
Microchip EDS2 development board with ZL30732 DPLL chip connected over
I2C bus.

Patch breakdown
===============
Patch 1 - Basic support for I2C, SPI and regmap
Patch 2 - Devlink registration
Patches 3-4 - Helpers for accessing device registers
Patches 5-6 - Component versions reporting via devlink dev info
Patches 7-8 - Helpers for accessing register mailboxes
Patch 9 - Clock ID generation for DPLL driver
Patch 10 - Export strnchrnul function for modules
           (used by next patch)
Patch 11 - Support for MFG config initialization file
Patch 12 - Fetch invariant register values used by DPLL and later by
           PTP driver
Patch 13 - Basic DPLL driver with required only functionality
Patch 14 - Registration of DPLL sub-devices by MFD driver
Patch 15 - Device tree bindings for DPLL device and pin
Patch 16 - Device tree bindings for ZL3073x device
Patch 17 - Read DPLL device types from firmware (DT,ACPI...)
Patch 18 - Read basic pin properties from firmware
Patch 19 - Implementation of input pin selection for DPLL in manual mode
Patch 20 - Implementation of getting/setting priority for input pins
Patch 21 - Implementation of input pin state setting for DPLL in auto mode
Patch 22 - Implementation of getting/setting frequency for input pins
Patch 23 - Implementation of getting/setting frequency for output pins
Patch 24 - Read pin supported frequencies from firmware
Patch 25 - Implementation of getting phase offset from input pins
Patch 26 - Implementation of getting/setting phase adjust for both
           pin types
Patch 27 - Implementation of getting/setting embedded sync frequency
           for both pin types
Patch 28 - Implementation of getting fractional frequency offset for
           input pins

Ivan Vecera (28):
  mfd: Add Microchip ZL3073x support
  mfd: zl3073x: Register itself as devlink device
  mfd: zl3073x: Add register access helpers
  mfd: zl3073x: Add macros for device registers access
  mfd: zl3073x: Add components versions register defs
  mfd: zl3073x: Implement devlink device info
  mfd: zl3073x: Add macro to wait for register value bits to be cleared
  mfd: zl3073x: Add functions to work with register mailboxes
  mfd: zl3073x: Add clock_id field
  lib: Allow modules to use strnchrnul
  mfd: zl3073x: Load mfg file into HW if it is present
  mfd: zl3073x: Fetch invariants during probe
  dpll: Add Microchip ZL3073x DPLL driver
  mfd: zl3073x: Register DPLL sub-device during init
  dt-bindings: dpll: Add device tree bindings for DPLL device and pin
  dt-bindings: dpll: Add support for Microchip Azurite chip family
  dpll: zl3073x: Read DPLL types from firmware
  dpll: zl3073x: Read optional pin properties from firmware
  dpll: zl3073x: Implement input pin selection in manual mode
  dpll: zl3073x: Add support to get/set priority on input pins
  dpll: zl3073x: Implement input pin state setting in automatic mode
  dpll: zl3073x: Add support to get/set frequency on input pins
  dpll: zl3073x: Add support to get/set frequency on output pins
  dpll: zl3073x: Read pin supported frequencies from firmware
  dpll: zl3073x: Add support to get phase offset on input pins
  dpll: zl3073x: Add support to get/set phase adjust on pins
  dpll: zl3073x: Add support to get/set esync on pins
  dpll: zl3073x: Add support to get fractional frequency offset on input
    pins

 .../devicetree/bindings/dpll/dpll-device.yaml |   84 +
 .../devicetree/bindings/dpll/dpll-pin.yaml    |   43 +
 .../bindings/dpll/microchip,zl3073x.yaml      |   74 +
 MAINTAINERS                                   |   12 +
 drivers/dpll/Kconfig                          |   16 +
 drivers/dpll/Makefile                         |    2 +
 drivers/dpll/dpll_zl3073x.c                   | 2768 +++++++++++++++++
 drivers/mfd/Kconfig                           |   33 +
 drivers/mfd/Makefile                          |    5 +
 drivers/mfd/zl3073x-core.c                    |  840 +++++
 drivers/mfd/zl3073x-i2c.c                     |   71 +
 drivers/mfd/zl3073x-spi.c                     |   72 +
 drivers/mfd/zl3073x.h                         |   13 +
 include/linux/mfd/zl3073x.h                   |  335 ++
 lib/string.c                                  |    1 +
 15 files changed, 4369 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dpll/dpll-device.yaml
 create mode 100644 Documentation/devicetree/bindings/dpll/dpll-pin.yaml
 create mode 100644 Documentation/devicetree/bindings/dpll/microchip,zl3073x.yaml
 create mode 100644 drivers/dpll/dpll_zl3073x.c
 create mode 100644 drivers/mfd/zl3073x-core.c
 create mode 100644 drivers/mfd/zl3073x-i2c.c
 create mode 100644 drivers/mfd/zl3073x-spi.c
 create mode 100644 drivers/mfd/zl3073x.h
 create mode 100644 include/linux/mfd/zl3073x.h

-- 
2.48.1


