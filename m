Return-Path: <netdev+bounces-193352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E46AC39AD
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 08:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6124917169A
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 06:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165961D54FA;
	Mon, 26 May 2025 06:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="TOHYp420"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EC31C8639
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 06:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748239827; cv=none; b=RbJYx5z34EqaF9GJX/HhCfFZ7Yvs0OtksXJITm+FwjNLoJk0kDBoYBFNy/SvyIf2M4V1pEHL8l82H9t5zLY0fHz/XZQJeufz8GQc1tKY2pGoLrPjUjZpMAcy05b5I4XQrv0ObOJ2K42Dl2g07sRKf1NjVgntQu8XvCyovS7RNdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748239827; c=relaxed/simple;
	bh=J8XmalK6MbOm1ie8kcN5WGmUMUDUHea8EW/A9ylB228=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YPd2pu1htJxh6T5E9204V8O5534fHz5nq7O2RXBERhNEjCtPmosw7fOw6B186rmX5dJ1CKuX3yPAALVSHvs39xPae6lknbpDXN8wDNqEiVuB+v5dd9BZsOGmwIgigWxizVDSrVlzeHK2JJrXnlFz3cIkg81BlbPphRaY/d4Fs28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=TOHYp420; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1748239825; x=1779775825;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sU1MI44/hcKTCnvVrxhOeocOjlsqgDWbL9B3bn66tck=;
  b=TOHYp420mfyoO+d/ZCe8qUJjMHsw4loDxv7dI/gwGh1TstpOZMNtP4Ec
   YNq0cB4rGd346U3eeAv/erNIXv7cNTp4O7dYGZ7udqkjvW2Jyueq65js6
   fHSX+whWlVptuIMwsMJ7XvYpgNffCb0Z1lo/WDvrcVTyiRIePgdj0Qs9/
   bDzKYmXRN0mQ7jAFlnzLIcpFMv2aTLhMKrlo803GbhyiZrlskZwkOtnmm
   5oCkY96UKGlGfna9JMmzYv+LTMaDvaEcNeZTzMMOIuw5Xtl8ayanbOQVg
   Js/EOOK3eZ2jEfY41ef/BMBoT0PeVzYzvIJz8Xc+s3bOa7+8H3Hklr+tR
   A==;
X-IronPort-AV: E=Sophos;i="6.15,315,1739836800"; 
   d="scan'208";a="828389966"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 06:10:17 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.43.254:52919]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.1.135:2525] with esmtp (Farcaster)
 id 6125f13b-6c44-47d3-ac40-eca8d6a3c9ef; Mon, 26 May 2025 06:10:16 +0000 (UTC)
X-Farcaster-Flow-ID: 6125f13b-6c44-47d3-ac40-eca8d6a3c9ef
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 26 May 2025 06:10:16 +0000
Received: from HFA15-G9FV5D3.amazon.com (10.85.143.177) by
 EX19D005EUA002.ant.amazon.com (10.252.50.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 26 May 2025 06:10:04 +0000
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
Subject: [PATCH v11 net-next 2/8] net: ena: PHC silent reset
Date: Mon, 26 May 2025 09:09:12 +0300
Message-ID: <20250526060919.214-3-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250526060919.214-1-darinzon@amazon.com>
References: <20250526060919.214-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D044UWB001.ant.amazon.com (10.13.139.171) To
 EX19D005EUA002.ant.amazon.com (10.252.50.11)

Each PHC device kernel registration receives a unique kernel index,
which is associated with a new PHC device file located at
"/dev/ptp<index>".
This device file serves as an interface for obtaining PHC timestamps.
Examples of tools that use "/dev/ptp" include testptp [1]
and chrony [2].

A reset flow may occur in the ENA driver while PHC is active.
During a reset, the driver will unregister and then re-register the
PHC device with the kernel.
Under race conditions, particularly during heavy PHC loads,
the driver’s reset flow might complete faster than the kernel’s PHC
unregister/register process.
This can result in the PHC index being different from what it was prior
to the reset, as the PHC index is selected using kernel ID
allocation [3].

While driver rmmod/insmod are done by the user, a reset may occur
at anytime, without the user awareness, consequently, the driver
might receive a new PHC index after the reset, potentially compromising
the user experience.

To prevent this issue, the PHC flow will detect the reset during PHC
destruction and will skip the PHC unregister/register calls to preserve
the kernel PHC index.
During the reset flow, any attempt to get a PHC timestamp will fail as
expected, but the kernel PHC index will remain unchanged.

[1]: https://github.com/torvalds/linux/blob/v6.1/tools/testing/selftests/ptp/testptp.c
[2]: https://github.com/mlichvar/chrony
[3]: https://www.kernel.org/doc/html/latest/core-api/idr.html

Signed-off-by: Amit Bernstein <amitbern@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_phc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_phc.c b/drivers/net/ethernet/amazon/ena/ena_phc.c
index 612cf45e..5ce9a32d 100644
--- a/drivers/net/ethernet/amazon/ena/ena_phc.c
+++ b/drivers/net/ethernet/amazon/ena/ena_phc.c
@@ -108,6 +108,10 @@ static int ena_phc_register(struct ena_adapter *adapter)
 	phc_info = adapter->phc_info;
 	clock_info = &phc_info->clock_info;
 
+	/* PHC may already be registered in case of a reset */
+	if (ena_phc_is_active(adapter))
+		return 0;
+
 	phc_info->adapter = adapter;
 
 	spin_lock_init(&phc_info->lock);
@@ -134,7 +138,11 @@ static void ena_phc_unregister(struct ena_adapter *adapter)
 {
 	struct ena_phc_info *phc_info = adapter->phc_info;
 
-	if (ena_phc_is_active(adapter)) {
+	/* During reset flow, PHC must stay registered
+	 * to keep kernel's PHC index
+	 */
+	if (ena_phc_is_active(adapter) &&
+	    !test_bit(ENA_FLAG_TRIGGER_RESET, &adapter->flags)) {
 		ptp_clock_unregister(phc_info->clock);
 		phc_info->clock = NULL;
 	}
-- 
2.47.1


