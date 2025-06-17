Return-Path: <netdev+bounces-198532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0950ADC919
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 13:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 513F71886D80
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 11:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA4D2D9EDC;
	Tue, 17 Jun 2025 11:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="tPhMl3bZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E029D2D9EC2
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 11:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750158536; cv=none; b=bvBr9kMFOSpdE7adH5GvlHGi7lHlF0tzpG4FHOPmoNOofCHSG5xLiKYeqUSBb9z0vgw/fU3l8qLBxfjA0MqJsdZuURHOy8TcIFwjmeN6Q5cRDoarGFe1OkxONBHe3d0u9lcgNHDL0cUQgMPkcKtY5Bg/lWOkaMehU5Q3967ahJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750158536; c=relaxed/simple;
	bh=Go3XF2QRyP8C6K/W70V35BJZysinNasBBl2ihRJdpJ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bJG1VFAg6RMR4JX1gcaZIYVkMr6IjVFmOXlBfaolsO5GMW4z8vVxcvFguqil1MPvUHyLRWDMmpDHSl5I82aEDX9osZrTZ6agaj8VUOeQKjsoVoO/W/5IL+vor9HoY/M4qBLFcpevB0Hhd65N6dBSfJGoqxuqebJ9FhLViaLuOSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=tPhMl3bZ; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1750158534; x=1781694534;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GbwxBityWS0tMEbwOAubEYR9XH67BBHvE190oDqFUO4=;
  b=tPhMl3bZ/ESZ31LNAQYuHcyhTTWa7tC44bprWEK91H8Y6u7OlDJrjYrn
   /oFXfv6ZH+zG8mOMbD36oQZl4KZwfpt6U3HY6BWq2h+5jxh2bV+8swdPv
   NzBn8AlH26pQKjram7fLSSwa0R+HxlzjK1SYec1tM/qU7qc1C0ipZ6bFX
   kjRgElY7AtHVfNUWqIYOCDQJyMlv82QSmEeCwN606kVX4NfsuINIuJrJC
   CBN0DE+kgtTgU1qaCT6+ceI9yqWV5fe9VCa2qwa1vzZa9eJCrQ+4X85zK
   hv7ok6JuPIOHt2y0E7QJ9/c5GTDypbHCUP+fIbfZ2Yk94RVROMHBxeJ98
   w==;
X-IronPort-AV: E=Sophos;i="6.16,243,1744070400"; 
   d="scan'208";a="212749553"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 11:08:54 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.17.79:48482]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.31.140:2525] with esmtp (Farcaster)
 id 1546e7be-67f2-4e19-a508-686fd2b13187; Tue, 17 Jun 2025 11:08:53 +0000 (UTC)
X-Farcaster-Flow-ID: 1546e7be-67f2-4e19-a508-686fd2b13187
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 17 Jun 2025 11:08:53 +0000
Received: from HFA15-G9FV5D3.amazon.com (10.85.143.172) by
 EX19D005EUA002.ant.amazon.com (10.252.50.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 17 Jun 2025 11:08:41 +0000
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
Subject: [PATCH v13 net-next 9/9] net: ena: Add PHC documentation
Date: Tue, 17 Jun 2025 14:05:45 +0300
Message-ID: <20250617110545.5659-10-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250617110545.5659-1-darinzon@amazon.com>
References: <20250617110545.5659-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D005EUA002.ant.amazon.com (10.252.50.11)

Provide the relevant information and guidelines
about the feature support in the ENA driver.

Signed-off-by: Amit Bernstein <amitbern@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 .../device_drivers/ethernet/amazon/ena.rst    | 93 +++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/Documentation/networking/device_drivers/ethernet/amazon/ena.rst b/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
index 7b7b8891..14784a0a 100644
--- a/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
+++ b/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
@@ -224,6 +224,99 @@ descriptor it was received on would be recycled. When a packet smaller
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


