Return-Path: <netdev+bounces-192272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9F9ABF335
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 13:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7CF73B7B52
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 11:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B905926463E;
	Wed, 21 May 2025 11:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="JZ2WOoJV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E698478F4C
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 11:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747827921; cv=none; b=bnYLiE16aR3zSwD/A5UGLo3yX69hMizzbzWXFyQpux1F+GhIxjZ9GV5ZZKjDzf/zPO/CpYay74RdLH/Gz2wkRofnX4KcjkaHfz91mA6Q8jI5+m9EOP/AYTYpgzfosTTOOSCIVJyWh4jW+TE5lSCxyKE4Iol0KYCsFAQlKh/pzMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747827921; c=relaxed/simple;
	bh=9pag9YnkAqnC70WuJaocqFx0wpe9vrLSPlNpUI9KGWg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VORa2YQ4BLvfZ0X3iGWrx7Py42wymvYCvckNWXS36iyoHoTlIA+fNPCQl7LiO6GULZALTQIk9q2prs7MVU+ANyIXRHPsCdsFCvVkvROU0/UjD6Yhv+MSyt/dlPGIXYsC4gZSwCfnVzHM2ukw9Se5FsLEja+251rAcMSxi4rE9Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=JZ2WOoJV; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747827920; x=1779363920;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/X4KDBtjYgv0m5gL70Kmk0vE1gaE+QBPavgt+CXHOpw=;
  b=JZ2WOoJV/Yd3EiEq5VZ2TwLsXv1FPnFMWxSax+k6WkCGJWtZ+Yw2fEJP
   /ghFfhZw1ppCmk9w8g2BPdx+XCzRp1UqhaFQVhxgn9BYOirkp15CHams2
   O95Rg5Hl+nvgj+R/f/guWlHuaJBYrAl3uu9OuM6GVQUZgeHCc5GstX2+E
   j8eGaunHcefz1+QatMfb/XFKNQx8TAiF7VtB7tjWL0pg0vP6Pd0jcuBwS
   oHM4P3nFc3cP1BKuPqqjKS7WYYyk/tY9fN368ATxpY+XYYf0PZ6l6dM4m
   mE6RSTsL7HCQRTPJzf/ZV15lCmptZqrTl3HQL3KNgyH5IlQWp5pzNwbu2
   w==;
X-IronPort-AV: E=Sophos;i="6.15,303,1739836800"; 
   d="scan'208";a="501016244"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 11:45:16 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.10.100:14949]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.9.121:2525] with esmtp (Farcaster)
 id 5a7c9b53-1a10-4d57-a3e3-e1e680b3ff41; Wed, 21 May 2025 11:45:15 +0000 (UTC)
X-Farcaster-Flow-ID: 5a7c9b53-1a10-4d57-a3e3-e1e680b3ff41
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 11:45:15 +0000
Received: from HFA15-G9FV5D3.amazon.com (10.85.143.172) by
 EX19D005EUA002.ant.amazon.com (10.252.50.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 11:45:04 +0000
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
	<leon@kernel.org>
Subject: [PATCH v9 net-next 7/8] net: ena: Add PHC documentation
Date: Wed, 21 May 2025 14:42:53 +0300
Message-ID: <20250521114254.369-8-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521114254.369-1-darinzon@amazon.com>
References: <20250521114254.369-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB001.ant.amazon.com (10.13.139.160) To
 EX19D005EUA002.ant.amazon.com (10.252.50.11)

Provide the relevant information and guidelines
about the feature support in the ENA driver.

Signed-off-by: Amit Bernstein <amitbern@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 .../device_drivers/ethernet/amazon/ena.rst    | 103 ++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/Documentation/networking/device_drivers/ethernet/amazon/ena.rst b/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
index 347aec34..949b295b 100644
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
+  sudo devlink dev param set pci/<domain:bus:slot.function> name phc_enable value true cmode driverinit
+  sudo devlink dev reload pci/<domain:bus:slot.function>
+  # for example:
+  sudo devlink dev param set pci/0000:00:06.0 name phc_enable value true cmode driverinit
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


