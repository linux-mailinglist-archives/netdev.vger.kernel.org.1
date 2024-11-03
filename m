Return-Path: <netdev+bounces-141276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC159BA547
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 12:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09C851C21198
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 11:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863FB16F908;
	Sun,  3 Nov 2024 11:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="IiNIzpTd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0794270832
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 11:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730633530; cv=none; b=m869pcsxiGGKqlbBwQ/5YmpO8CNvNj76yCVlEMmIlS7W0aqrfEtxIaMTBgGmIKNNqG5moeISGxK/duRY79oCRuqv/xS68w7zLCOTicaivIq9SHzhZ/N+cMXEVpVCFaoUyHvqQkz3fn+qtJelKN4xHMrsBZu+bD7zyIAK9rckEI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730633530; c=relaxed/simple;
	bh=ed9jDh1RZMUcjVuVJhtdbA94/YBw7AVsAWDRx4bzjTY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CGYsAwFKi4rCI3JT8FPjOwWlrJPKAfL8M64/UM2izKi+5os8Yrjm+O4+3f++3eIADGDlaIv6ScOqmu+07RZOxO/RAQb8WZtG+0Lxh2sVvArQK8Da+1Ufp5USKl0IrNIv5i3smRJtDOighoFle+QSpkl8CkPNWsTX+Sre+kUlyz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=IiNIzpTd; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730633529; x=1762169529;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gyyUiNpAZSUmgse4Aa6uYYacZ1ezoWiBCciLzWe8gmk=;
  b=IiNIzpTdLlsh7dolvD69Ykp+7LyvvmuGjS45Wgbw/0SYsA5mTb6O01vh
   /kbsJKCvgXilyGzJIEHjaYzp9pF1Q0Ea3A5L9rtGF+J44Ry5tbl3GA9Dn
   24GuxD9fJxBoA4cnzavMxSGlVmVmLWs3s/TNA5XKJ4yB5u6r9AjdeB9lM
   Q=;
X-IronPort-AV: E=Sophos;i="6.11,255,1725321600"; 
   d="scan'208";a="143976443"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 11:32:07 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:42484]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.16:2525] with esmtp (Farcaster)
 id 8bfc080f-0a9e-4575-a739-e84f0c6edca4; Sun, 3 Nov 2024 11:32:06 +0000 (UTC)
X-Farcaster-Flow-ID: 8bfc080f-0a9e-4575-a739-e84f0c6edca4
Received: from EX19D009UWC004.ant.amazon.com (10.13.138.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sun, 3 Nov 2024 11:32:05 +0000
Received: from EX19MTAUWC002.ant.amazon.com (10.250.64.143) by
 EX19D009UWC004.ant.amazon.com (10.13.138.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sun, 3 Nov 2024 11:32:04 +0000
Received: from email-imr-corp-prod-iad-1box-1a-9bbde7a3.us-east-1.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Sun, 3 Nov 2024 11:32:04 +0000
Received: from HFA15-G9FV5D3.amazon.com (unknown [10.85.143.174])
	by email-imr-corp-prod-iad-1box-1a-9bbde7a3.us-east-1.amazon.com (Postfix) with ESMTP id 1B49C405DD;
	Sun,  3 Nov 2024 11:31:59 +0000 (UTC)
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
	<ofirt@amazon.com>, "Machnikowski, Maciek" <maciek@machnikowski.net>
Subject: [PATCH v3 net-next 2/3] net: ena: PHC silent reset
Date: Sun, 3 Nov 2024 13:31:38 +0200
Message-ID: <20241103113140.275-3-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241103113140.275-1-darinzon@amazon.com>
References: <20241103113140.275-1-darinzon@amazon.com>
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
2.40.1


