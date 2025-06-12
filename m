Return-Path: <netdev+bounces-197163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94738AD7B8E
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 22:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AC3A1896B8F
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 20:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A346322D785;
	Thu, 12 Jun 2025 20:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PFTpFhBG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D783F2036FA
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 20:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749758525; cv=none; b=a+1nhRqU/eZLGvJRSuaAHmR/6m/mKPFZ+wpleysRLZ4XaoUf39b8XNZG8II0F4LlfmRwruf6DgOwd8eBFSJJfBsQwU5vvPxI+rdpA01caNivkzpoSbA5Soyf7EHpUH5DO56N+Up3dONDYFohIBej8me/VcKkQxIsRraXURKMDVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749758525; c=relaxed/simple;
	bh=1zQZwJvti3V5peI0NwKLIco5vf9r0SDnNyPGUQi6jsM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ls5fgEcKJYwWYQ73clKhXW2kIJLuX8mLOSYcfhIP9RXExcEQTtC2zdBHuimWW2BBQpbpYGNkuGpoMsYoB93d50aQ+wpNzNZKu0Dpxumaum6MxCvlynf85+vP/TcDyqEksO29Y/Iw9ilHvhtNXF2gkbkxNz/m4WDNVMewfTEAv14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PFTpFhBG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749758522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=C4px3QPbZ1SRsAzWHP3GIAiZmhSyKEE8qa7Iyubi/WY=;
	b=PFTpFhBGOLf3MiW5uI8C70mtOpCK/IEoH3qPRmWr/JpQOUUf1GjQWuGRsvRi56T8W+vO+A
	ltOtbn/EmvtN6tCilW+hj8VC6nMhDwtKkaEKzKGPmPO9MPOyN8xOq2eYrUgkwePNUoFHZe
	MfqzR4keqKM9hPpklDAXVPNHNvnlYYk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-a79Eg75qPruNzc5Sp5pqxw-1; Thu,
 12 Jun 2025 16:01:59 -0400
X-MC-Unique: a79Eg75qPruNzc5Sp5pqxw-1
X-Mimecast-MFC-AGG-ID: a79Eg75qPruNzc5Sp5pqxw_1749758516
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C22A11800294;
	Thu, 12 Jun 2025 20:01:55 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.224.169])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6AEDD180045B;
	Thu, 12 Jun 2025 20:01:47 +0000 (UTC)
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
Subject: [PATCH net-next v9 00/14] Add Microchip ZL3073x support (part 1)
Date: Thu, 12 Jun 2025 22:01:31 +0200
Message-ID: <20250612200145.774195-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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
v9:
After discussion with Jakub Kicinski we agreed that it would be better
to implement whole functionality in a single driver without touching
MFD sub-system. Besides touching multiple sub-systems by single device
there are also some technical issues that are easier resolvable
in a single driver. Additionally the firmware flashing functionality
would bring more than 1000 lines of code with previous approach to
the MFD driver - it is not something the MFD maintainers would like
to see.

Ivan Vecera (14):
  dt-bindings: dpll: Add DPLL device and pin
  dt-bindings: dpll: Add support for Microchip Azurite chip family
  dpll: Add basic Microchip ZL3073x support
  dpll: zl3073x: Add support for devlink device info
  dpll: zl3073x: Protect operations requiring multiple register accesses
  dpll: zl3073x: Fetch invariants during probe
  dpll: zl3073x: Add clock_id field
  dpll: zl3073x: Read DPLL types and pin properties from system firmware
  dpll: zl3073x: Register DPLL devices and pins
  dpll: zl3073x: Implement input pin selection in manual mode
  dpll: zl3073x: Add support to get/set priority on input pins
  dpll: zl3073x: Implement input pin state setting in automatic mode
  dpll: zl3073x: Add support to get/set frequency on input pins
  dpll: zl3073x: Add support to get/set frequency on output pins

 .../devicetree/bindings/dpll/dpll-device.yaml |   76 +
 .../devicetree/bindings/dpll/dpll-pin.yaml    |   45 +
 .../bindings/dpll/microchip,zl30731.yaml      |  115 ++
 Documentation/networking/devlink/index.rst    |    1 +
 Documentation/networking/devlink/zl3073x.rst  |   37 +
 MAINTAINERS                                   |   10 +
 drivers/Kconfig                               |    4 +-
 drivers/dpll/Kconfig                          |    6 +
 drivers/dpll/Makefile                         |    2 +
 drivers/dpll/zl3073x/Kconfig                  |   36 +
 drivers/dpll/zl3073x/Makefile                 |   10 +
 drivers/dpll/zl3073x/core.c                   |  966 +++++++++++
 drivers/dpll/zl3073x/core.h                   |  371 ++++
 drivers/dpll/zl3073x/dpll.c                   | 1496 +++++++++++++++++
 drivers/dpll/zl3073x/dpll.h                   |   42 +
 drivers/dpll/zl3073x/i2c.c                    |   95 ++
 drivers/dpll/zl3073x/prop.c                   |  358 ++++
 drivers/dpll/zl3073x/prop.h                   |   34 +
 drivers/dpll/zl3073x/regs.h                   |  206 +++
 drivers/dpll/zl3073x/spi.c                    |   95 ++
 20 files changed, 4003 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dpll/dpll-device.yaml
 create mode 100644 Documentation/devicetree/bindings/dpll/dpll-pin.yaml
 create mode 100644 Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml
 create mode 100644 Documentation/networking/devlink/zl3073x.rst
 create mode 100644 drivers/dpll/zl3073x/Kconfig
 create mode 100644 drivers/dpll/zl3073x/Makefile
 create mode 100644 drivers/dpll/zl3073x/core.c
 create mode 100644 drivers/dpll/zl3073x/core.h
 create mode 100644 drivers/dpll/zl3073x/dpll.c
 create mode 100644 drivers/dpll/zl3073x/dpll.h
 create mode 100644 drivers/dpll/zl3073x/i2c.c
 create mode 100644 drivers/dpll/zl3073x/prop.c
 create mode 100644 drivers/dpll/zl3073x/prop.h
 create mode 100644 drivers/dpll/zl3073x/regs.h
 create mode 100644 drivers/dpll/zl3073x/spi.c

-- 
2.49.0


