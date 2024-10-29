Return-Path: <netdev+bounces-140096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0C69B5379
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 21:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C689E1C20E21
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 20:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17D520C464;
	Tue, 29 Oct 2024 20:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NO39j7PB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B8720C027;
	Tue, 29 Oct 2024 20:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730233458; cv=none; b=i74QBcqmqBmOkT81gw0LYPNa+NioHoVGCJu7oQ2OqI9ilqGBnM9/tXBH2AxP2/Ro1r9D+xAA6uII2CGutComXAlrzeoDPgxT0+W9ZzZD68HVBEo0XuxC0OTV6/8iVzYqSYj17tskLHYpIyASuBVccPfjAMgAt6HSTLEoaPXBanA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730233458; c=relaxed/simple;
	bh=uNUTiA0HvI5A7c5xE1I8y5ErznWdRKyRHGjQDeKPcAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bfBbmNhGLKFWmd/rAcuXHwuF11knlTq/1qPTh78YVAdwNG6kPeDMbWyhvOJzasm/ona6zvSWa3bQ6JKmOuwZr2mzdlw+XgOCwu94YRCO4BosRvAwMIEfuH2qLznS3oVi7piR5ayA9I5vX3WsIMXKHkK9FzNBhkniuIK+RoIRMXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NO39j7PB; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d4fa7d3baso658447f8f.0;
        Tue, 29 Oct 2024 13:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730233455; x=1730838255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rx0eMLUEzhYETTDB2Dx4nHIilzNRVf/VQgEFIdoul78=;
        b=NO39j7PB/Vs+r84wf8v/+SXBuBtfXl315WcBxSbXk7GdJzl+5lZBMOjJFFM/APF+pG
         VJgv5yYfGYlfEiAnH7ce/KzVAU9VtC/uB+7fIP/Dys8Twz24nCKEO1nZXJpLwsNeFy5d
         Lly0Hmp+TDN/COWQoVd28M7cr5xB1rNU224yRDDeBTan1/LH8eWttv55ucSGYAefg1na
         8F/X2HlEs1VuMuBHpTc8dVN+3PMntDMMXSRzW2qYUOmU6c+muJTpjCvNCp6g5HgcS5RI
         JVuBYRKIfuNeHWaSKPEuK67VZG0zqZ21dfq6dEc6KCg7eCpQHaYXW6XArLB0KysKI3Si
         LO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730233455; x=1730838255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rx0eMLUEzhYETTDB2Dx4nHIilzNRVf/VQgEFIdoul78=;
        b=Al9gfyEF5J2z2xuAQobFVSmpOKi54uKgIXhJj9CGvqEo/+yVGcGn3Ykir8wxK0a29I
         8vo6NACUIaNLOYvTJ3QsTbZgss3q7rOdKuafqJeOqCpCKPxBAqftT8F6FHudsPIO25X8
         d5GUMv0fKOcSCz6tyV73duLCVcOwa5gu8DjKFyKAdtL0OPWQrXw97Apo2Lsj+cTKq4OA
         eJ9xoUzv2qF/F/VCYz2lh5dcqYghWvTLNKWCovwUd3DlwCfL0EXzTrBJtFu4TxNdhUsw
         s6FRVGDr1viyvA6KwZsBds1Fm7fPrEL+K7UUla5BNff8Ua/5GgWVNk5xm9qVVMoSBASC
         lmRg==
X-Forwarded-Encrypted: i=1; AJvYcCVHnAzXiOtA3tjAvJ/vTGqn0I6rrMKvFiOWmFTAgKF4/GoBnE0Ia+3sme+dCQj4JTr7gdNSIHAx@vger.kernel.org, AJvYcCVt+yG801PDHtWnIJCHk8zy+Vjf+0sHkbhAmA1xeB5MGZGYMglI/ieP6ChUMOHl0e5g0aJ4h4tOm0cjOnQS@vger.kernel.org, AJvYcCWbpWBMhJHN0aTG+hqKTugvLNWetyYE4+a+ZIttBsy82euuj2dGBL8zdspLhFZA2+AwI46inff6AFND@vger.kernel.org
X-Gm-Message-State: AOJu0YxopKp5g//bApXJl2/f46V5WXnGFFXxptFgfYFghDpiDT2tSIEO
	/65ypG+E9CWydSuHfdpve7Wx2jVSso4EhprzPvi9MIQETc57/Rko
X-Google-Smtp-Source: AGHT+IEnuFjr/Zc4f6jXZAW8xbcExw/fgwTtYOC4EmQWOqcT/pxDPVKNa5Oe0HscWQqMZwS60H9tkw==
X-Received: by 2002:a5d:47c2:0:b0:374:ca43:ac00 with SMTP id ffacd0b85a97d-38061126ae4mr3904749f8f.4.1730233454663;
        Tue, 29 Oct 2024 13:24:14 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3bf85sm13619976f8f.42.2024.10.29.13.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 13:24:14 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	a.fatoum@pengutronix.de
Cc: conor+dt@kernel.org,
	dinguyen@kernel.org,
	marex@denx.de,
	s.trumtrar@pengutronix.de,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	l.rubusch@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 13/23] ARM: dts: socfpga: add Enclustra boot-mode dtsi
Date: Tue, 29 Oct 2024 20:23:39 +0000
Message-Id: <20241029202349.69442-14-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241029202349.69442-1-l.rubusch@gmail.com>
References: <20241029202349.69442-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add generic boot-mode support to Enclustra Arria10 and Cyclone5 boards.
Some Enclustra carrier boards need hardware adjustments specific to the
selected boot-mode.

Enclustra's Arria10 SoMs allow for booting from different media. By
muxing certain IO pins, the media can be selected. This muxing can be
done by gpios at runtime e.g. when flashing QSPI from off the
bootloader. But also to have statically certain boot media available,
certain adjustments to the DT are needed:
- SD: QSPI must be disabled
- eMMC: QSPI must be disabled, bus width can be doubled to 8 byte
- QSPI: any mmc is disabled, QSPI then defaults to be enabled

The boot media must be accessible to the bootloader, e.g. to load a
bitstream file, but also to the system to mount the rootfs and to use
the specific performance.

Signed-off-by: Andreas Buerkler <andreas.buerkler@enclustra.com>
Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 .../socfpga_enclustra_mercury_bootmode_emmc.dtsi     | 12 ++++++++++++
 .../socfpga_enclustra_mercury_bootmode_qspi.dtsi     |  8 ++++++++
 .../socfpga_enclustra_mercury_bootmode_sdmmc.dtsi    |  8 ++++++++
 3 files changed, 28 insertions(+)
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_emmc.dtsi
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_qspi.dtsi
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_sdmmc.dtsi

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_emmc.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_emmc.dtsi
new file mode 100644
index 000000000..d79cb64da
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_emmc.dtsi
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+&qspi {
+	status = "disabled";
+};
+
+&mmc {
+	bus-width = <8>;
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_qspi.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_qspi.dtsi
new file mode 100644
index 000000000..5ba21dd8f
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_qspi.dtsi
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+&mmc {
+	status = "disabled";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_sdmmc.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_sdmmc.dtsi
new file mode 100644
index 000000000..2b102e0b6
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_sdmmc.dtsi
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+&qspi {
+	status = "disabled";
+};
-- 
2.25.1


