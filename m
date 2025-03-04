Return-Path: <netdev+bounces-171818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D9AA4ECC4
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 20:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A96041890798
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 19:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF90260384;
	Tue,  4 Mar 2025 19:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="CRIPFmRO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EE620468F
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 19:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741115143; cv=none; b=NuNnrI1QBbkDpTKAVxF1KBUDh9DlIP1XovuOLJyhocoEJba8QpLCAJaZhyGallDVlyCiDnIXYOldHWas3NY/PP1eixRyVkUuo6+emD8ouTelDJxgX0wcT2IEFeXzoCATcEQLekC/cTsmTIAnjlYNGtIt8LWvp5Jxs/cT5o4B8ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741115143; c=relaxed/simple;
	bh=QAmxs8snv5VRKNiFV9z423u9dH0XFOtJnV1N/HLWVIM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P8QhvMzYRBXMhxCEm9DVz2bqd/kwi+i5NZXPVWh/k4jdWIaJyZF21Lletarmhx9jlsTa/HIcNpSzTNPIr++Qtsn1irVTYnPYW6YkMGcRVIA/ALx9tS6bkiBbvhUmzfBhqFz8JZejLsWnfAueRRukL5Ybi62PuJlvR9nahhUGHVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=CRIPFmRO; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741115142; x=1772651142;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6U+zRrO7AvAwt+WDAOn9R2KoIQOBFdSNnELb1aLlegk=;
  b=CRIPFmRO7R4MaB+FXsJ2OI9a7vUuOQfMKpg5q6wE2JmBoGDLVQmhYj7I
   pg8CoT1B3QKwiyRcV7kgjO7b37yoxlkkMBRDLy5oY6woBlQtXSg2NxQ9P
   EOJpmIxha0PEEDN5rnp1sDQPIgochnKf0nD3pVjkqFGJSH1KQERZrIJMD
   A=;
X-IronPort-AV: E=Sophos;i="6.14,220,1736812800"; 
   d="scan'208";a="804206824"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 19:05:35 +0000
Received: from EX19MTAUEC001.ant.amazon.com [10.0.29.78:43347]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.3.67:2525] with esmtp (Farcaster)
 id b718293c-91c5-488f-9d2b-e1d83e3feaaf; Tue, 4 Mar 2025 19:05:33 +0000 (UTC)
X-Farcaster-Flow-ID: b718293c-91c5-488f-9d2b-e1d83e3feaaf
Received: from EX19D008UEA002.ant.amazon.com (10.252.134.125) by
 EX19MTAUEC001.ant.amazon.com (10.252.135.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 4 Mar 2025 19:05:30 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D008UEA002.ant.amazon.com (10.252.134.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 4 Mar 2025 19:05:29 +0000
Received: from email-imr-corp-prod-pdx-1box-2b-8c2c6aed.us-west-2.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 19:05:29 +0000
Received: from HFA15-G9FV5D3.amazon.com (unknown [10.85.143.178])
	by email-imr-corp-prod-pdx-1box-2b-8c2c6aed.us-west-2.amazon.com (Postfix) with ESMTP id B023EA07BE;
	Tue,  4 Mar 2025 19:05:22 +0000 (UTC)
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
Subject: [PATCH v8 net-next 2/5] net: ena: PHC silent reset
Date: Tue, 4 Mar 2025 21:05:01 +0200
Message-ID: <20250304190504.3743-3-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250304190504.3743-1-darinzon@amazon.com>
References: <20250304190504.3743-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

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
index 87495de0..5c1acd88 100644
--- a/drivers/net/ethernet/amazon/ena/ena_phc.c
+++ b/drivers/net/ethernet/amazon/ena/ena_phc.c
@@ -107,6 +107,10 @@ static int ena_phc_register(struct ena_adapter *adapter)
 	phc_info = adapter->phc_info;
 	clock_info = &phc_info->clock_info;
 
+	/* PHC may already be registered in case of a reset */
+	if (ena_phc_is_active(adapter))
+		return 0;
+
 	phc_info->adapter = adapter;
 
 	spin_lock_init(&phc_info->lock);
@@ -133,7 +137,11 @@ static void ena_phc_unregister(struct ena_adapter *adapter)
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


