Return-Path: <netdev+bounces-171820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC0CA4ECC3
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 20:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDD327A6FF2
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 19:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BC42641DB;
	Tue,  4 Mar 2025 19:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bsAFW2Lc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F8925523D
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 19:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741115155; cv=none; b=BmKEn2LGQiz1Gj2mDCQdwS2COfLrbNUif/kE1jzyBmiiNDfLXh8cZ2E5uZBYT6a8MckoQzSl1BCVtnYHXU1j10NmUW6wdK/8lJ5F9zUGXaDWwWagFd+t4ojNCnxODwaAm/hJBQFogZQRwceeKB0DpfGUNcOfAhSZxn4tJG8Hy68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741115155; c=relaxed/simple;
	bh=a4Jr15M8dtafmzyeZDsGBMlM+DQJ4K8lBD8M8v2cUFg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q7DpXsrcH9TiHktej7H/6laIN2lNYPBVJxjDzejGE0St8kmyMF4pYOgvO2mu8Wk/snmnhowH4TZbVHDmAmpbhggsVIZLKEbJ695tQ2IA6xU1kuSl9QMFnIJcSIqs/YuzH426fdyNDq4MImlGd2leSvdjqWR1BN4x5WBXzYDA4yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=bsAFW2Lc; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741115154; x=1772651154;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yiNQ61dCH69G7yxmYLb8iVzZwRIE1QdYWxBdn7nqPeM=;
  b=bsAFW2LcegSuMmC758aYfpuzD+Rm+WQrNBWZvy22+8G+HbbwJ9a/p8YH
   z8My06oS0qwVokw83bZn9sZoIo2oMPLe0JdM6hzsnjtERTYo3OlnQY8rK
   CmTDjLmGFwp8nJWtH02H2L9MJ4IIQcZBGoUqQFXp+ngJ/SB/c7WAXSxqc
   U=;
X-IronPort-AV: E=Sophos;i="6.14,220,1736812800"; 
   d="scan'208";a="723784124"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 19:05:51 +0000
Received: from EX19MTAUEA001.ant.amazon.com [10.0.29.78:19406]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.49.99:2525] with esmtp (Farcaster)
 id 1c09af11-92d8-4d2b-9c87-4d8a8e472d9a; Tue, 4 Mar 2025 19:05:50 +0000 (UTC)
X-Farcaster-Flow-ID: 1c09af11-92d8-4d2b-9c87-4d8a8e472d9a
Received: from EX19D008UEA001.ant.amazon.com (10.252.134.62) by
 EX19MTAUEA001.ant.amazon.com (10.252.134.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 4 Mar 2025 19:05:50 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D008UEA001.ant.amazon.com (10.252.134.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 4 Mar 2025 19:05:50 +0000
Received: from email-imr-corp-prod-iad-all-1a-93a35fb4.us-east-1.amazon.com
 (10.43.8.6) by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 19:05:50 +0000
Received: from HFA15-G9FV5D3.amazon.com (unknown [10.85.143.178])
	by email-imr-corp-prod-iad-all-1a-93a35fb4.us-east-1.amazon.com (Postfix) with ESMTP id 705F740477;
	Tue,  4 Mar 2025 19:05:45 +0000 (UTC)
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
	<vadim.fedorenko@linux.dev>
Subject: [PATCH v8 net-next 5/5] net: ena: Add PHC documentation
Date: Tue, 4 Mar 2025 21:05:04 +0200
Message-ID: <20250304190504.3743-6-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250304190504.3743-1-darinzon@amazon.com>
References: <20250304190504.3743-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Provide the relevant information and guidelines
about the feature support in the ENA driver.

Signed-off-by: Amit Bernstein <amitbern@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 .../device_drivers/ethernet/amazon/ena.rst    | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/Documentation/networking/device_drivers/ethernet/amazon/ena.rst b/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
index 4561e8ab..158d7100 100644
--- a/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
+++ b/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
@@ -53,9 +53,11 @@ ena_eth_io_defs.h   Definition of ENA data path interface.
 ena_common_defs.h   Common definitions for ena_com layer.
 ena_regs_defs.h     Definition of ENA PCI memory-mapped (MMIO) registers.
 ena_netdev.[ch]     Main Linux kernel driver.
+ena_sysfs.[ch]      Sysfs files.
 ena_ethtool.c       ethtool callbacks.
 ena_xdp.[ch]        XDP files
 ena_pci_id_tbl.h    Supported device IDs.
+ena_phc.[ch]        PTP hardware clock infrastructure (see `PHC`_ for more info)
 =================   ======================================================
 
 Management Interface:
@@ -221,6 +223,100 @@ descriptor it was received on would be recycled. When a packet smaller
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
+The feature is turned off by default, in order to turn the feature on,
+please use the following:
+
+- sysfs (during runtime):
+
+.. code-block:: shell
+
+  echo 1 > /sys/bus/pci/devices/<domain:bus:slot.function>/phc_enable
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
+will fail, leading to an increment in the phc_err statistic.
+
+**PHC statistics**
+
+PHC counters can be monitored using the following:
+
+sysfs:
+
+.. code-block:: shell
+
+  cat /sys/bus/pci/devices/<domain:bus:slot.function>/phc_stats/<stat_name>
+
+=================   ======================================================
+**phc_cnt**         Number of successful retrieved timestamps (below expire timeout).
+**phc_exp**         Number of expired retrieved timestamps (above expire timeout).
+**phc_skp**         Number of skipped get time attempts (during block period).
+**phc_err**         Number of failed get time attempts (entering into block state).
+=================   ======================================================
+
+PHC timeouts:
+
+=================   ======================================================
+**expire**          Max time for a valid timestamp retrieval, passing this threshold will fail
+                    the get time request and block new requests until block timeout.
+**block**           Blocking period starts once get time request expires or fails, all get time
+                    requests during block period will be skipped.
+=================   ======================================================
+
 Statistics
 ==========
 
-- 
2.47.1


