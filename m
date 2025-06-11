Return-Path: <netdev+bounces-196489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7414AD4FB3
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 11:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C1BE3A4836
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 09:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B846725C834;
	Wed, 11 Jun 2025 09:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Ic7yJBM+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEED013A3F2
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 09:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749633992; cv=none; b=MZq5FtazefVTr1+L1g+wGIHkvhPMXtkDy27h2wubegRskz4qv9zyZT0xy+WhyzYRVLrUlc15OySu2KO9Zsb6YJYBpGVNThq+GPOKbNwhV2g6o06jBgiMz90+WhqL4JdzJmDijGcZ5EllkOLGr1pnpaeud8uULwYxgEMr0gpOR1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749633992; c=relaxed/simple;
	bh=vKiTYOcvwoQmM0ImQU64EU7uXY0aj4ywj0be8wiZjD4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t0nK316qLEX9IvPzy9eIZViJOa5XSTB5lhCKCwUXlVjfRRWyprv3Dnnp1lZdG207GvJT3FDGYMXwtrdTqpK5jIUPIP8EFPfIa6THbC+oL9hHpxEpbsJka2y78BCkKFROHM9SvsBmgTSZgm90d1nO2On1yYgMIsF9NXTWe8dBBwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Ic7yJBM+; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1749633991; x=1781169991;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mh3kzTbRrFl/E7avOcV9qzXi75piTAx505VHtT6pCAk=;
  b=Ic7yJBM+ED11SGZR1F2dExsl3iQ8mKzBmA25cRoxpFWrdtWTmLq/5xtM
   /pIdftzONrbjrPbzsViMgD345ul1S9/S5LErAZLwSvTL2KTSrKSVa/uyH
   82j1OhcVxUDt27UYtsUN5nBLIr3Nc9ZXDopyX8YAL/XAAWqCYGMkNaT5Z
   cCz3BALd+fjkVA7sbTPpmONikUaxHOriaaFh4tLaiC6knaR6KhTtWqbZg
   YViOdJ28mQXWH1+ztxmrq+23XvYwNJv88LS42rv5mqTnB1Mc7chdumiBO
   454mZ8CUTU0AXgRUgtguGUdQCHJjST2geqrYGSGj4RqGxwqjQafxYngOL
   w==;
X-IronPort-AV: E=Sophos;i="6.16,227,1744070400"; 
   d="scan'208";a="732189949"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 09:26:25 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.10.100:7500]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.7.229:2525] with esmtp (Farcaster)
 id 0d4e7372-33bd-4c6d-b1d9-00deb04a4d77; Wed, 11 Jun 2025 09:26:24 +0000 (UTC)
X-Farcaster-Flow-ID: 0d4e7372-33bd-4c6d-b1d9-00deb04a4d77
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 11 Jun 2025 09:26:23 +0000
Received: from HFA15-G9FV5D3.amazon.com (10.85.143.176) by
 EX19D005EUA002.ant.amazon.com (10.252.50.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 11 Jun 2025 09:26:12 +0000
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
Subject: [PATCH v12 net-next 9/9] net: ena: Add PHC documentation
Date: Wed, 11 Jun 2025 12:22:38 +0300
Message-ID: <20250611092238.2651-10-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611092238.2651-1-darinzon@amazon.com>
References: <20250611092238.2651-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA003.ant.amazon.com (10.13.139.46) To
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


