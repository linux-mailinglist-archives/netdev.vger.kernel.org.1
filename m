Return-Path: <netdev+bounces-137368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2919A59B1
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 07:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 023ACB21A79
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 05:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E51F156C63;
	Mon, 21 Oct 2024 05:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NhcC6fQZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C7B192B79
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 05:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729488049; cv=none; b=l5Jt5RyP/1rgUy90BGPuC5jjoZqPCrgl1EuOQLNVTTJA04c8p77KKZ6bvLmId6lZhSi1+v387KaLFuHIM3TWuxuxOQYplimHB0wZ1IKctDZdJ9yEWd5smCH7/9xd378ZwqmbXzkB16u57CGjaFO0T24o2Xe9YvAPs3yFdyfjLO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729488049; c=relaxed/simple;
	bh=SlySsxs0PeqXFlnOM9toTTm/y5eLSftJ+IY7NhLmb/Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AD+EoIiaHixNqykR9pupKhaWI1kPjJeacrDunQVQ5EkjuGsmq2V/sz56II+Bs+V5v2hFEQ4E06Ygf3ghm7Io4ri/fVWsV/nmUk3hroaNsjU0vgxam/Kd0oXyc0lsMogOviFCV3PjYopYNRNus+v+M6PTDlnmGVT4NmI4ugnEO2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=NhcC6fQZ; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729488048; x=1761024048;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TAb7n2c6VPnHQXZYngRL94UCUlpjV3XmVg7OEIVa4bY=;
  b=NhcC6fQZRy3UuP+OPMjVhHLTcShwYRuwJJ6/pq6+0ki55K1RibLSSuxf
   PeqcIVg/l8HtbnWT79hNnBmRjOFq74L7bzVj3gAkSWdMsId5j/xiKIBrd
   +v3PHE4+HoB/7ROVelWKOjHxiOcpPhEOdgyovHtuOsb7uXCM3bybUr9Ep
   g=;
X-IronPort-AV: E=Sophos;i="6.11,220,1725321600"; 
   d="scan'208";a="433170489"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 05:20:46 +0000
Received: from EX19MTAUEA002.ant.amazon.com [10.0.0.204:29853]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.51.223:2525] with esmtp (Farcaster)
 id 3d5b3624-778a-4698-9b9e-47d32b67e28e; Mon, 21 Oct 2024 05:20:45 +0000 (UTC)
X-Farcaster-Flow-ID: 3d5b3624-778a-4698-9b9e-47d32b67e28e
Received: from EX19D008UEA004.ant.amazon.com (10.252.134.191) by
 EX19MTAUEA002.ant.amazon.com (10.252.134.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 21 Oct 2024 05:20:42 +0000
Received: from EX19MTAUEB002.ant.amazon.com (10.252.135.47) by
 EX19D008UEA004.ant.amazon.com (10.252.134.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 21 Oct 2024 05:20:42 +0000
Received: from email-imr-corp-prod-pdx-all-2c-d1311ce8.us-west-2.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.135.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Mon, 21 Oct 2024 05:20:42 +0000
Received: from HFA15-G9FV5D3.amazon.com (unknown [10.85.143.175])
	by email-imr-corp-prod-pdx-all-2c-d1311ce8.us-west-2.amazon.com (Postfix) with ESMTP id 4B559404EA;
	Mon, 21 Oct 2024 05:20:36 +0000 (UTC)
From: David Arinzon <darinzon@amazon.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: David Arinzon <darinzon@amazon.com>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, "Woodhouse, David" <dwmw@amazon.com>,
	"Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky, Alexander"
	<matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt"
	<msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
	<nafea@amazon.com>, "Schmeilin, Evgeny" <evgenys@amazon.com>, "Belgazal,
 Netanel" <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur"
	<akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Bernstein, Amit"
	<amitbern@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>, "Abboud, Osama"
	<osamaabb@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik,
 Ofir" <ofirt@amazon.com>, "Machnikowski, Maciek" <maciek@machnikowski.net>
Subject: [PATCH v1 net-next 3/3] net: ena: Add PHC documentation
Date: Mon, 21 Oct 2024 08:20:11 +0300
Message-ID: <20241021052011.591-4-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021052011.591-1-darinzon@amazon.com>
References: <20241021052011.591-1-darinzon@amazon.com>
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
 .../device_drivers/ethernet/amazon/ena.rst    | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/Documentation/networking/device_drivers/ethernet/amazon/ena.rst b/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
index 4561e8ab..9f490bb8 100644
--- a/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
+++ b/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
@@ -56,6 +56,7 @@ ena_netdev.[ch]     Main Linux kernel driver.
 ena_ethtool.c       ethtool callbacks.
 ena_xdp.[ch]        XDP files
 ena_pci_id_tbl.h    Supported device IDs.
+ena_phc.[ch]        PTP hardware clock infrastructure (see `PHC`_ for more info)
 =================   ======================================================
 
 Management Interface:
@@ -221,6 +222,83 @@ descriptor it was received on would be recycled. When a packet smaller
 than RX copybreak bytes is received, it is copied into a new memory
 buffer and the RX descriptor is returned to HW.
 
+.. _`PHC`:
+
+PTP Hardware Clock (PHC)
+======================
+.. _`ptp-userspace-api`: https://docs.kernel.org/driver-api/ptp.html#ptp-hardware-clock-user-space-api
+.. _`testptp`: https://elixir.bootlin.com/linux/latest/source/tools/testing/selftests/ptp/testptp.c
+
+ENA Linux driver supports PTP hardware clock providing timestamp reference to achieve nanosecond accuracy.
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
+PHC can be monitored using :code:`ethtool -S` counters:
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
2.40.1


