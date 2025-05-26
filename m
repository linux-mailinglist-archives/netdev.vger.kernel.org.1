Return-Path: <netdev+bounces-193358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD55AC39B5
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 08:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3C007A18ED
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 06:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271A01957FC;
	Mon, 26 May 2025 06:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="kyqGcBjZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748527E110
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 06:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748239951; cv=none; b=taCN0mLGTmxDuzcr+gs6XUAzN0WvguZZkrXDeJ88nA/uixmQrPl89spC0GgQcy2iKuxXO8qLh+8ms7AK6l/9WBDiY8Wn+xdcji8jD5dLD39laxFiReiStob1umQeQw6g1xaVJOoVOne7Oi0xFV1bgHe33y6W9QdRAztvT58j8jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748239951; c=relaxed/simple;
	bh=vKiTYOcvwoQmM0ImQU64EU7uXY0aj4ywj0be8wiZjD4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pawEH6TNR3Jum3lfalB+6vaWNRSuRRc6W7AT9WI0kKyX9yGxb+ip5cBI6T9KBSfsC+layxwwlnblVkYr/HVYLunue3eCQnyyhYRWDUUyK0/p6A715VG4SugbecWdoJ9nq+pteYQC9B7PH1GDQioaHY8aXWm7Z4lkHYrXA2FwIXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=kyqGcBjZ; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1748239949; x=1779775949;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mh3kzTbRrFl/E7avOcV9qzXi75piTAx505VHtT6pCAk=;
  b=kyqGcBjZtLIf3SmPMEWGUyhrnDOFl80YNu7Z22xNeDRWJsA3N9p4AMgx
   JJpBuIw5etXpuQJLuncYtGjY9C5+xxG9OU6pHSAxSxqDlV+0fb6AfGD2m
   6UAriRrEa/JccebmqxBSbI1IT4YV+eLHskQepyLo6ROrfM2AjVEaNOUys
   ZQrjzrfyyzrN/fioNGlyI0tAHSuUgBnIT+KWk4+96I7O4LcCSbH6SghZr
   k8V8/4kivO55/zwkkAk2+6wRrako1h92egC9lzcfD6SIypEda3UgNQwpF
   mfkVcgJF0vfEDfn72Kt57gykQ/KjtiS55qHFXbUHO1l5tgdQ7AHZr28sT
   g==;
X-IronPort-AV: E=Sophos;i="6.15,315,1739836800"; 
   d="scan'208";a="496118626"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 06:12:28 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.43.254:56961]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.35.44:2525] with esmtp (Farcaster)
 id b0dbafe9-81c3-4252-b84a-25860cc5f158; Mon, 26 May 2025 06:12:27 +0000 (UTC)
X-Farcaster-Flow-ID: b0dbafe9-81c3-4252-b84a-25860cc5f158
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 26 May 2025 06:12:26 +0000
Received: from HFA15-G9FV5D3.amazon.com (10.85.143.177) by
 EX19D005EUA002.ant.amazon.com (10.252.50.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 26 May 2025 06:12:15 +0000
From: David Arinzon <darinzon@amazon.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: David Arinzon <darinzon@amazon.com>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, "Richard
 Cochran" <richardcochran@gmail.com>, "Woodhouse, David" <dwmw@amazon.com>,
	"Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky, Alexander"
	<matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt"
	<msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
	<nafea@amazon.com>, "Schmeilin, Evgeny" <evgenys@amazon.com>, "Belgazal,
 Netanel" <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur"
	<akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Bernstein, Amit"
	<amitbern@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>, "Ostrovsky,
 Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>,
	"Machnikowski, Maciek" <maciek@machnikowski.net>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Gal Pressman <gal@nvidia.com>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Andrew Lunn <andrew@lunn.ch>, Leon Romanovsky
	<leon@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH v11 net-next 8/8] net: ena: Add PHC documentation
Date: Mon, 26 May 2025 09:09:18 +0300
Message-ID: <20250526060919.214-9-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250526060919.214-1-darinzon@amazon.com>
References: <20250526060919.214-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA003.ant.amazon.com (10.13.139.42) To
 EX19D005EUA002.ant.amazon.com (10.252.50.11)

Provide the relevant information and guidelines
about the feature support in the ENA driver.

Signed-off-by: Amit Bernstein <amitbern@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 .../device_drivers/ethernet/amazon/ena.rst    | 103 ++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/Documentation/networking/device_drivers/ethernet/amazon/ena.rst b/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
index 347aec34..6892e3f1 100644
--- a/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
+++ b/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
@@ -224,6 +224,109 @@ descriptor it was received on would be recycled. When a packet smaller
 than RX copybreak bytes is received, it is copied into a new memory
 buffer and the RX descriptor is returned to HW.
 
+.. _`PHC`:
+
+PTP Hardware Clock (PHC)
+========================
+.. _`ptp-userspace-api`: https://docs.kernel.org/driver-api/ptp.html#ptp-hardware-clock-user-space-api
+.. _`testptp`: https://elixir.bootlin.com/linux/latest/source/tools/testing/selftests/ptp/testptp.c
+
+ENA Linux driver supports PTP hardware clock providing timestamp reference to achieve nanosecond resolution.
+
+**PHC support**
+
+PHC depends on the PTP module, which needs to be either loaded as a module or compiled into the kernel.
+
+Verify if the PTP module is present:
+
+.. code-block:: shell
+
+  grep -w '^CONFIG_PTP_1588_CLOCK=[ym]' /boot/config-`uname -r`
+
+- If no output is provided, the ENA driver cannot be loaded with PHC support.
+
+- ``CONFIG_PTP_1588_CLOCK=y``: the PTP module is already compiled and loaded inside the kernel binary file.
+
+- ``CONFIG_PTP_1588_CLOCK=m``: the PTP module needs to be loaded prior to loading the ENA driver:
+
+Load PTP module:
+
+.. code-block:: shell
+
+  sudo modprobe ptp
+
+**PHC activation**
+
+The feature is turned off by default, in order to turn the feature on, the ENA driver
+can be loaded in the following way:
+
+- devlink:
+
+.. code-block:: shell
+
+  sudo devlink dev param set pci/<domain:bus:slot.function> name enable_phc value true cmode driverinit
+  sudo devlink dev reload pci/<domain:bus:slot.function>
+  # for example:
+  sudo devlink dev param set pci/0000:00:06.0 name enable_phc value true cmode driverinit
+  sudo devlink dev reload pci/0000:00:06.0
+
+All available PTP clock sources can be tracked here:
+
+.. code-block:: shell
+
+  ls /sys/class/ptp
+
+PHC support and capabilities can be verified using ethtool:
+
+.. code-block:: shell
+
+  ethtool -T <interface>
+
+**PHC timestamp**
+
+To retrieve PHC timestamp, use `ptp-userspace-api`_, usage example using `testptp`_:
+
+.. code-block:: shell
+
+  testptp -d /dev/ptp$(ethtool -T <interface> | awk '/PTP Hardware Clock:/ {print $NF}') -k 1
+
+PHC get time requests should be within reasonable bounds,
+avoid excessive utilization to ensure optimal performance and efficiency.
+The ENA device restricts the frequency of PHC get time requests to a maximum
+of 125 requests per second. If this limit is surpassed, the get time request
+will fail, leading to an increment in the phc_err_ts statistic.
+
+**PHC statistics**
+
+PHC can be monitored using debugfs (if mounted):
+
+.. code-block:: shell
+
+  sudo cat /sys/kernel/debug/<domain:bus:slot.function>/phc_stats
+
+  # for example:
+  sudo cat /sys/kernel/debug/0000:00:06.0/phc_stats
+
+PHC errors must remain below 1% of all PHC requests to maintain the desired level of accuracy and reliability
+
+=================   ======================================================
+**phc_cnt**         | Number of successful retrieved timestamps (below expire timeout).
+**phc_exp**         | Number of expired retrieved timestamps (above expire timeout).
+**phc_skp**         | Number of skipped get time attempts (during block period).
+**phc_err_dv**      | Number of failed get time attempts due to device errors (entering into block state).
+**phc_err_ts**      | Number of failed get time attempts due to timestamp errors (entering into block state),
+                    | This occurs if driver exceeded the request limit or device received an invalid timestamp.
+=================   ======================================================
+
+PHC timeouts:
+
+=================   ======================================================
+**expire**          | Max time for a valid timestamp retrieval, passing this threshold will fail
+                    | the get time request and block new requests until block timeout.
+**block**           | Blocking period starts once get time request expires or fails,
+                    | all get time requests during block period will be skipped.
+=================   ======================================================
+
 Statistics
 ==========
 
-- 
2.47.1


