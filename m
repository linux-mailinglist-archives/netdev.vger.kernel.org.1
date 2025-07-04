Return-Path: <netdev+bounces-204231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6B2AF9A77
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 20:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60BA71CC181B
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 18:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293AA2080C0;
	Fri,  4 Jul 2025 18:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wy/Wmd3D"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732072E3708
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 18:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751653342; cv=none; b=LskzfMoo9qP2gM6EQ97Kp0PPIxXZ3m0l3+vCCXyTxOc6kpK6hgBMdvpsjty5AYhq2TNxMkOZJZonlnX9YhDHcFL6BAZa6Ocu/10YtXM+yUOtstrsi6YDarZA5dhlwzCvwexzTSPB2za2aS4KBtcNAlyDWU4FAh+hO47sMSvFDX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751653342; c=relaxed/simple;
	bh=FNzaQFyV61swUAZngx0cr0TM1TKpmlPcQceWaHy1EDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M25ZFVXsyARSOCQrndsDywxD54p+34/m/DZCRdlwRzGmflAdG6gOSGXyWMWKkh8CEmVFNgSx6PphhUIwRqTTl+SMD4nFZEmU0MhBMIFRt3WHos3wZHry0HbL0IiDEz3WWgfKVcmavkFpo9r4G1MlvlbgOWu7xVYppbGaBTP6nxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wy/Wmd3D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751653339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EvCttz+tHCCYPoL5GAqjlTfJavqPfxa5OWbB2hGTu6c=;
	b=Wy/Wmd3Do8MGVpvOzobIOK6EKwy8+jWqjw95wqDmx/PPEHQXBkSrO6XQVCSRP8zy4ufm/D
	1InIz18zLvr4im+Ws9H8YfEPVNlLtenFLw2UxZCP9hK9/+VCn0eJjbyME57lwF97iG66Gh
	JK26SPCL90L6BoQ3Nk2UBLBpMGs50yc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-4GI4aywrORe6zhpjKAiv4Q-1; Fri,
 04 Jul 2025 14:22:17 -0400
X-MC-Unique: 4GI4aywrORe6zhpjKAiv4Q-1
X-Mimecast-MFC-AGG-ID: 4GI4aywrORe6zhpjKAiv4Q_1751653334
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 51C771800268;
	Fri,  4 Jul 2025 18:22:13 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.226.37])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 80C6B195E752;
	Fri,  4 Jul 2025 18:22:04 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>
Subject: [PATCH net-next v13 00/12] Add Microchip ZL3073x support (part 1)
Date: Fri,  4 Jul 2025 20:21:50 +0200
Message-ID: <20250704182202.1641943-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add support for Microchip Azurite DPLL/PTP/SyncE chip family that
provides DPLL and PTP functionality. This series bring first part
that adds the core functionality and basic DPLL support.

The next part of the series will bring additional DPLL functionality
like eSync support, phase offset and frequency offset reporting and
phase adjustments.

Testing was done by myself and by Prathosh Satish on Microchip EDS2
development board with ZL30732 DPLL chip connected over I2C bus.

---
Changelog:
v13:
* added support for u64 devlink parameters
* added support for generic devlink parameter 'clock_id'
* several patches squashed into one per @jpirko's advice
* renamed devlink version 'cfg.custom_ver' to 'custom_cfg'
* per discussion with @jpirko, the clock_id is now generated randomly
  and user have an option to change it via devlink
* implemented devlink reload to apply clock_id change

v12:
* Using 'return dev_err_probe()'
* Separate zl3073x_chip_info structures instead of array
* Use mul_u64_u32_div() to compute input reference frequency to avoid
  potential overflow
* Removed superfluous check in zl3073x_dpll_output_pin_frequency_set()

v11:
* Fixed uninitialized 'rc' in error-path in patch 9

v10:
* Usage of str_enabled_disabled() where possible.

v9:
After discussion with Jakub Kicinski we agreed that it would be better
to implement whole functionality in a single driver without touching
MFD sub-system. Besides touching multiple sub-systems by single device
there are also some technical issues that are easier resolvable
in a single driver. Additionally the firmware flashing functionality
would bring more than 1000 lines of code with previous approach to
the MFD driver - it is not something the MFD maintainers would like
to see.

Ivan Vecera (12):
  dt-bindings: dpll: Add DPLL device and pin
  dt-bindings: dpll: Add support for Microchip Azurite chip family
  devlink: Add support for u64 parameters
  devlink: Add new "clock_id" generic device param
  dpll: Add basic Microchip ZL3073x support
  dpll: zl3073x: Fetch invariants during probe
  dpll: zl3073x: Read DPLL types and pin properties from system firmware
  dpll: zl3073x: Register DPLL devices and pins
  dpll: zl3073x: Implement input pin selection in manual mode
  dpll: zl3073x: Add support to get/set priority on input pins
  dpll: zl3073x: Implement input pin state setting in automatic mode
  dpll: zl3073x: Add support to get/set frequency on pins

 .../devicetree/bindings/dpll/dpll-device.yaml |   76 +
 .../devicetree/bindings/dpll/dpll-pin.yaml    |   45 +
 .../bindings/dpll/microchip,zl30731.yaml      |  115 ++
 .../networking/devlink/devlink-params.rst     |    3 +
 Documentation/networking/devlink/index.rst    |    1 +
 Documentation/networking/devlink/zl3073x.rst  |   51 +
 MAINTAINERS                                   |   10 +
 drivers/Kconfig                               |    4 +-
 drivers/dpll/Kconfig                          |    6 +
 drivers/dpll/Makefile                         |    2 +
 drivers/dpll/zl3073x/Kconfig                  |   36 +
 drivers/dpll/zl3073x/Makefile                 |   10 +
 drivers/dpll/zl3073x/core.c                   |  859 ++++++++++
 drivers/dpll/zl3073x/core.h                   |  367 ++++
 drivers/dpll/zl3073x/devlink.c                |  259 +++
 drivers/dpll/zl3073x/devlink.h                |   12 +
 drivers/dpll/zl3073x/dpll.c                   | 1504 +++++++++++++++++
 drivers/dpll/zl3073x/dpll.h                   |   42 +
 drivers/dpll/zl3073x/i2c.c                    |   76 +
 drivers/dpll/zl3073x/prop.c                   |  358 ++++
 drivers/dpll/zl3073x/prop.h                   |   34 +
 drivers/dpll/zl3073x/regs.h                   |  208 +++
 drivers/dpll/zl3073x/spi.c                    |   76 +
 include/net/devlink.h                         |    6 +
 net/devlink/param.c                           |   15 +
 25 files changed, 4173 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dpll/dpll-device.yaml
 create mode 100644 Documentation/devicetree/bindings/dpll/dpll-pin.yaml
 create mode 100644 Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml
 create mode 100644 Documentation/networking/devlink/zl3073x.rst
 create mode 100644 drivers/dpll/zl3073x/Kconfig
 create mode 100644 drivers/dpll/zl3073x/Makefile
 create mode 100644 drivers/dpll/zl3073x/core.c
 create mode 100644 drivers/dpll/zl3073x/core.h
 create mode 100644 drivers/dpll/zl3073x/devlink.c
 create mode 100644 drivers/dpll/zl3073x/devlink.h
 create mode 100644 drivers/dpll/zl3073x/dpll.c
 create mode 100644 drivers/dpll/zl3073x/dpll.h
 create mode 100644 drivers/dpll/zl3073x/i2c.c
 create mode 100644 drivers/dpll/zl3073x/prop.c
 create mode 100644 drivers/dpll/zl3073x/prop.h
 create mode 100644 drivers/dpll/zl3073x/regs.h
 create mode 100644 drivers/dpll/zl3073x/spi.c

-- 
2.49.0


