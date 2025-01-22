Return-Path: <netdev+bounces-160244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF40A18F97
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 11:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D7CF3A2378
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 10:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FBD211299;
	Wed, 22 Jan 2025 10:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="N7+p/p0B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB127211283
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 10:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737541282; cv=none; b=cY+KLrdLfRpCZ1Tv324ccpUokK4velu2ls5m1BKVZAAVfY1e87Qo3xpgU+2vZ545VXfQBkZb5/8DHuN/G+fQL653Q4WnugLpAaK71NivlKtESghv5HiPa7hg2N1NW8JwZ4dHkpwPA0B6Y3zykwbp0cu6eaywITubnMeCLDSHO7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737541282; c=relaxed/simple;
	bh=ed9jDh1RZMUcjVuVJhtdbA94/YBw7AVsAWDRx4bzjTY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f+oqwU01VdBBO5ytNGcytfrs2VKNovIaevbW/OK8VpVgyz6YWeq0wUzdgy9w+tB2pgYaXR2a39sPgzKrQ392JvWZ8MmsyAibQ5kGi6avzHPFKZ4/mZBqqsT8Ff69DAk+wGLKvQCT3AispIbq4dzqh3YyQGxnXfUc0qPN6UolGa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=N7+p/p0B; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1737541281; x=1769077281;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gyyUiNpAZSUmgse4Aa6uYYacZ1ezoWiBCciLzWe8gmk=;
  b=N7+p/p0BOzMWOwnpjdrY8fAF1a5Bb5a7wQySHJhp0IKhbPSRNevwAT0W
   ZiKRcO7I3qRCXFstIdtY+wKX17tLszneBoe+RI3h0imkIU79Vm8k5rQtt
   OiFWyIsdmQR4xI814LOEzFlQLeSChrEFhB4yW7LDX4dD+DpwJ6iTJ+43k
   Q=;
X-IronPort-AV: E=Sophos;i="6.13,224,1732579200"; 
   d="scan'208";a="712670962"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 10:21:16 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:9848]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.53:2525] with esmtp (Farcaster)
 id 8db83032-f7c3-4c9e-a339-1f3a20149c11; Wed, 22 Jan 2025 10:21:15 +0000 (UTC)
X-Farcaster-Flow-ID: 8db83032-f7c3-4c9e-a339-1f3a20149c11
Received: from EX19D009UWB001.ant.amazon.com (10.13.138.58) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 22 Jan 2025 10:21:01 +0000
Received: from EX19MTAUWB002.ant.amazon.com (10.250.64.231) by
 EX19D009UWB001.ant.amazon.com (10.13.138.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 22 Jan 2025 10:21:00 +0000
Received: from email-imr-corp-prod-iad-all-1b-a03c1db8.us-east-1.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.228) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Wed, 22 Jan 2025 10:21:00 +0000
Received: from HFA15-G9FV5D3.amazon.com (unknown [10.85.143.175])
	by email-imr-corp-prod-iad-all-1b-a03c1db8.us-east-1.amazon.com (Postfix) with ESMTP id 98C4080305;
	Wed, 22 Jan 2025 10:20:55 +0000 (UTC)
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
Subject: [PATCH v5 net-next 2/5] net: ena: PHC silent reset
Date: Wed, 22 Jan 2025 12:20:37 +0200
Message-ID: <20250122102040.752-3-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250122102040.752-1-darinzon@amazon.com>
References: <20250122102040.752-1-darinzon@amazon.com>
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


