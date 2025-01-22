Return-Path: <netdev+bounces-160243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55370A18F95
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 11:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 374D93A0344
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 10:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD341EF085;
	Wed, 22 Jan 2025 10:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="EpS9WekJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088F3145FE0
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 10:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737541278; cv=none; b=PeSqA4FduQzirFFyvpDJQbjG+RrNY853MizYsHY0q/F+Zh3Nf3Zks9l42P4Ux2owC78R4MYf9Oeiqqw1xW1d1NtGTOuTNA+gBkfqeuxTy00FkfD4hvJliuslnjobfJLCm/gZ5C32JFqVv+hbx0anlfZEUvOP5gC2tdLZiYyKriM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737541278; c=relaxed/simple;
	bh=IWRDNEJGtorkKJClEVpqVKqfdWoRUU6d9OpeaNaJZk4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dNR9+jtWV1Dted6oxwjmHuMgX9iUq3BL4VsK88BZF/6zUiyV8PLc7mqd7JI+pIPw90BgZs20viMWg3DxGtiFninAeavATMRxW4mXep69k1hRAv400pv9X610OnSxbPeuOgwHuPc5+yTS0Lt6bY+xKbJK2cw97Fd28JlJg5AGc4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=EpS9WekJ; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1737541277; x=1769077277;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Sk6p9PgliEub32hg6O+islq6mXCm3h6z8IujnE4zmCc=;
  b=EpS9WekJLKQj/i/mMsGaXSns0V3Q7nAP02v1CAPqxl9nSjBSiAqL7AHj
   tfRCvGiHNqgwCG5XKIdNkqwczRGg98NEOJ5aB4E72o2uHyWJZmcTCnN7V
   iLr7yHZATiMcA1zjvqf3KiqG4YliqdllXyNm8WrnsBxMe2qahl3GkYjrR
   M=;
X-IronPort-AV: E=Sophos;i="6.13,224,1732579200"; 
   d="scan'208";a="163305952"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 10:21:13 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:64448]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.12:2525] with esmtp (Farcaster)
 id eaa0f16e-0c4b-4484-b24c-6f4624a1bba7; Wed, 22 Jan 2025 10:21:12 +0000 (UTC)
X-Farcaster-Flow-ID: eaa0f16e-0c4b-4484-b24c-6f4624a1bba7
Received: from EX19D009UWB002.ant.amazon.com (10.13.138.74) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 22 Jan 2025 10:21:07 +0000
Received: from EX19MTAUWB002.ant.amazon.com (10.250.64.231) by
 EX19D009UWB002.ant.amazon.com (10.13.138.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 22 Jan 2025 10:21:06 +0000
Received: from email-imr-corp-prod-iad-all-1b-a03c1db8.us-east-1.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.228) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Wed, 22 Jan 2025 10:21:06 +0000
Received: from HFA15-G9FV5D3.amazon.com (unknown [10.85.143.175])
	by email-imr-corp-prod-iad-all-1b-a03c1db8.us-east-1.amazon.com (Postfix) with ESMTP id 5A0F380305;
	Wed, 22 Jan 2025 10:21:01 +0000 (UTC)
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
Subject: [PATCH v5 net-next 3/5] net: ena: Add PHC documentation
Date: Wed, 22 Jan 2025 12:20:38 +0200
Message-ID: <20250122102040.752-4-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250122102040.752-1-darinzon@amazon.com>
References: <20250122102040.752-1-darinzon@amazon.com>
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


