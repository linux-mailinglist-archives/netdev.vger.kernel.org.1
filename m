Return-Path: <netdev+bounces-144778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9DA9C86BE
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37ECD28267E
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 10:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409001F76D9;
	Thu, 14 Nov 2024 10:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ot/KTZZR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8106D1F76D6
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 10:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578424; cv=none; b=PsdnBT0PHeC/nqLEocLnJ0ia/qsqaE+CtAr+abuA1WjzhQa/5pvrf8ytI7r9WSL9KtE6a8v5sEhFyeplvC8640Emwk57vnc08wLOFnbg7kHgdM7T4U7FzmT1N/3N2l4BONwA1+mBIrM2/57yStRTC6vCarNbrNwpqJnGcZ4uwxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578424; c=relaxed/simple;
	bh=IWRDNEJGtorkKJClEVpqVKqfdWoRUU6d9OpeaNaJZk4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jed2Nij0sAx6cHYqMZNOs8iOVSadUJrv+yPHvQZ5XH4fHhpV2U6c8vz9u97ZXNpFK3IAvEoTGKIAzB8iShVx3FXE/WWTG8+naBQz4kQYJ9Dr4HnlGOLtyxtBmUu2FFGmkNVxbOqAO1+B2eAFDidsgTlfFqZ5BbkIL+IDoBGBEGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ot/KTZZR; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1731578423; x=1763114423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Sk6p9PgliEub32hg6O+islq6mXCm3h6z8IujnE4zmCc=;
  b=ot/KTZZR/FcdfFOvlVuZIDZHm+Uh5NRvozw50c+B9ZvZ7s3+7rUPP5S2
   d4IYDusVLmHc9RjoYoyibJsTT1EOpS57R0+FVi3vCiT2rbM2E1VpQLT58
   ofgJvIDIqLR7KWE7dL8iZ0r2G3ZadC018xqheJNgD2fUjb62RBuW4RXcz
   k=;
X-IronPort-AV: E=Sophos;i="6.12,153,1728950400"; 
   d="scan'208";a="442752850"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 10:00:22 +0000
Received: from EX19MTAUEB002.ant.amazon.com [10.0.44.209:42098]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.12.16:2525] with esmtp (Farcaster)
 id 95721b88-5d87-451f-9c93-fffd68bbb44b; Thu, 14 Nov 2024 10:00:21 +0000 (UTC)
X-Farcaster-Flow-ID: 95721b88-5d87-451f-9c93-fffd68bbb44b
Received: from EX19D008UEA001.ant.amazon.com (10.252.134.62) by
 EX19MTAUEB002.ant.amazon.com (10.252.135.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 14 Nov 2024 10:00:15 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D008UEA001.ant.amazon.com (10.252.134.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 14 Nov 2024 10:00:15 +0000
Received: from email-imr-corp-prod-pdx-all-2b-22fa938e.us-west-2.amazon.com
 (10.124.125.2) by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Thu, 14 Nov 2024 10:00:15 +0000
Received: from HFA15-G9FV5D3.amazon.com (unknown [10.85.143.176])
	by email-imr-corp-prod-pdx-all-2b-22fa938e.us-west-2.amazon.com (Postfix) with ESMTP id D9227C0209;
	Thu, 14 Nov 2024 10:00:08 +0000 (UTC)
From: David Arinzon <darinzon@amazon.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: David Arinzon <darinzon@amazon.com>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
	"Woodhouse, David" <dwmw@amazon.com>, "Machulsky, Zorik" <zorik@amazon.com>,
	"Matushevsky, Alexander" <matua@amazon.com>, Saeed Bshara
	<saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori, Anthony"
	<aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>, "Schmeilin,
 Evgeny" <evgenys@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt, Benjamin"
	<benh@amazon.com>, "Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam"
	<ndagan@amazon.com>, "Bernstein, Amit" <amitbern@amazon.com>, "Agroskin,
 Shay" <shayagr@amazon.com>, "Abboud, Osama" <osamaabb@amazon.com>,
	"Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir"
	<ofirt@amazon.com>, "Machnikowski, Maciek" <maciek@machnikowski.net>, "Rahul
 Rameshbabu" <rrameshbabu@nvidia.com>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH v4 net-next 3/3] net: ena: Add PHC documentation
Date: Thu, 14 Nov 2024 11:59:30 +0200
Message-ID: <20241114095930.200-4-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241114095930.200-1-darinzon@amazon.com>
References: <20241114095930.200-1-darinzon@amazon.com>
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
index 4561e8ab..12b13da0 100644
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


