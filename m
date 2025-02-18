Return-Path: <netdev+bounces-167469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C344A3A5EA
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 19:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDE38176F33
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 18:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4CC23FC74;
	Tue, 18 Feb 2025 18:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="hDsFM+VX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33AB1EB5D8
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 18:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739904024; cv=none; b=qIG4LwvKQPa8NKwcTFK6IGskV1do9Ep59kfMYC2UiGHg5g/akG6qYPFFki8g9Uuapru4kk+arAfbmDXZiOqdFmB9FZj5Mq6IaoNcAg161pV0ALlEnf12OlNNn6jcghOuU7m8pvRfvg9AsrFwdPbMqGXnVOf9Jo9Cw2MqKZ/HBo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739904024; c=relaxed/simple;
	bh=QAmxs8snv5VRKNiFV9z423u9dH0XFOtJnV1N/HLWVIM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aSzmqDNxaZZBfLCrK2BmLjJVtCjyGtwUX6nIu0PpWUFr4L1vzt+4PgLJFKkNuS0hMOpj7M7x7HqUua4JAk7zitH1Ix7YNccEefkGmirrV6MWCM8XoVtEXOW+Zt6Om8189FyeSmWKu9DjtKE1fTIne8h9vMwtgwkeQdtcrToxwdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=hDsFM+VX; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739904023; x=1771440023;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6U+zRrO7AvAwt+WDAOn9R2KoIQOBFdSNnELb1aLlegk=;
  b=hDsFM+VXDyP5/e0obaN4E/xOuBKuiBIpW27KQ73UpUEjgr86tha7Uotj
   BFZaNwUN7lhu1mMDGo7mP2NkH4HNCLvlWlWUqH6I9y/seamVPkxME58at
   vs/j0cfnDtw7iYjd9ofZCnlQrVy9JFw8O7wkQnV0PmPK+0Nn0IGJ5D6bR
   E=;
X-IronPort-AV: E=Sophos;i="6.13,296,1732579200"; 
   d="scan'208";a="378467544"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 18:40:19 +0000
Received: from EX19MTAUEA002.ant.amazon.com [10.0.44.209:49386]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.40.185:2525] with esmtp (Farcaster)
 id 119261df-3a74-41b5-b62f-05fa3b84710b; Tue, 18 Feb 2025 18:40:18 +0000 (UTC)
X-Farcaster-Flow-ID: 119261df-3a74-41b5-b62f-05fa3b84710b
Received: from EX19D008UEC003.ant.amazon.com (10.252.135.194) by
 EX19MTAUEA002.ant.amazon.com (10.252.134.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 18 Feb 2025 18:40:17 +0000
Received: from EX19MTAUEA002.ant.amazon.com (10.252.134.9) by
 EX19D008UEC003.ant.amazon.com (10.252.135.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 18 Feb 2025 18:40:17 +0000
Received: from email-imr-corp-prod-pdx-all-2b-dbd438cc.us-west-2.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.134.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Tue, 18 Feb 2025 18:40:17 +0000
Received: from HFA15-G9FV5D3.amazon.com (unknown [10.85.143.176])
	by email-imr-corp-prod-pdx-all-2b-dbd438cc.us-west-2.amazon.com (Postfix) with ESMTP id 0122CA0065;
	Tue, 18 Feb 2025 18:40:09 +0000 (UTC)
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
	<amitbern@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>, "Abboud, Osama"
	<osamaabb@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik,
 Ofir" <ofirt@amazon.com>, "Machnikowski, Maciek" <maciek@machnikowski.net>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [PATCH v7 net-next 2/5] net: ena: PHC silent reset
Date: Tue, 18 Feb 2025 20:39:45 +0200
Message-ID: <20250218183948.757-3-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250218183948.757-1-darinzon@amazon.com>
References: <20250218183948.757-1-darinzon@amazon.com>
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


