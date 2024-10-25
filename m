Return-Path: <netdev+bounces-138919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C039AF69C
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 03:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C09A1F224CA
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 01:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E7B38389;
	Fri, 25 Oct 2024 01:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUpl2FHM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77041173F;
	Fri, 25 Oct 2024 01:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729819263; cv=none; b=mG3of/2lUXndr0bFU3KGorRThX+hZlm+eUiliF3OB5ogmFx3laFbN706um7YYPfvtZcwS3hUSt07VKS45552vnh2oQCUjYDab5mBzs+hiOMzZg+zvZJ45bEt3YqlwM8N/esPz5/RCrSg9JiC7dC8kJm3dy+7QlrZYivgoy9SrZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729819263; c=relaxed/simple;
	bh=dNyqJYC+zOgdeFmmz+dCYzAPL6UxHm6lnvbddLBYDlw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rmwmj7x9JkSSvWOEEV+i82nEGrwClQXaP7Lew5bZ4PCMNEdvrZCjHkLHiShvZvaxksIruvAeZtRWAbUzrNqNvcK6oLZZ5Bj4IJjRt278YXvTNOtAuf1Xuly46rEBNYMuiCSCDP+L9vkHU5oEeNJautgSufBlVCnDsxDmDXh8FUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUpl2FHM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 828C5C4CEE4;
	Fri, 25 Oct 2024 01:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729819263;
	bh=dNyqJYC+zOgdeFmmz+dCYzAPL6UxHm6lnvbddLBYDlw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YUpl2FHMAsMENCRXfJo7TOxaKwuhavzaR774ABrZ6ftqObKRIkU6PMiXQ5YXHenYs
	 wWkAkkynFwg9mdKu0DFmtjgmFUKCw6nv6Y8pBXyOHOEVjSonq8ssCgxMk2wyPNnSfM
	 ZtlVELyE4jBn78DqK/c9fdoc0xAU113sFEus+iUgCBHG6Ps9uMS1R16qfX8DYXWhoW
	 pfRKwP7QLCdeHqJIzlPSeREyVU3W0sHHg0TRxhMIVmsLSM/RKxJ5lONwGi/deyTPVw
	 1LtyFzvg9HGnbM7WW0fol6r9MIpCOPZL0hGMHisWYPNZTpM216vFzhirt+QkSbzRC4
	 JSTj0/2J4s+7g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AF1D1039D;
	Fri, 25 Oct 2024 01:21:03 +0000 (UTC)
From: Nelson Escobar via B4 Relay <devnull+neescoba.cisco.com@kernel.org>
Date: Thu, 24 Oct 2024 18:19:44 -0700
Subject: [PATCH net-next v2 2/5] enic: Make MSI-X I/O interrupts come after
 the other required ones
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-remove_vic_resource_limits-v2-2-039b8cae5fdd@cisco.com>
References: <20241024-remove_vic_resource_limits-v2-0-039b8cae5fdd@cisco.com>
In-Reply-To: <20241024-remove_vic_resource_limits-v2-0-039b8cae5fdd@cisco.com>
To: John Daley <johndale@cisco.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nelson Escobar <neescoba@cisco.com>, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729819262; l=2857;
 i=neescoba@cisco.com; s=20241023; h=from:subject:message-id;
 bh=V+fNI/BLR6TzQSd85AV74fwLJ9hCh1MBL/3lYOO6PGg=;
 b=09v3X3zJZsYBT9WqWNU4gM9VMZedzVna8urS8sZQ5I9GtANe1ghYqHwcv3chMd+eb3wDvYAMc
 mDszeyDiqowAg4g6IuljhM8knb3ZYvPUlt+9Xq1NJUXf1w/dvaoNCUK
X-Developer-Key: i=neescoba@cisco.com; a=ed25519;
 pk=bLqWB7VU0KFoVybF4LVB4c2Redvnplt7+5zLHf4KwZM=
X-Endpoint-Received: by B4 Relay for neescoba@cisco.com/20241023 with
 auth_id=255
X-Original-From: Nelson Escobar <neescoba@cisco.com>
Reply-To: neescoba@cisco.com

From: Nelson Escobar <neescoba@cisco.com>

The VIC hardware has a constraint that the MSIX interrupt used for errors
be specified as a 7 bit number.  Before this patch, it was allocated after
the I/O interrupts, which would cause a problem if 128 or more I/O
interrupts are in use.

So make the required interrupts come before the I/O interrupts to
guarantee the error interrupt offset never exceeds 7 bits.

Co-developed-by: John Daley <johndale@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
Co-developed-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: Nelson Escobar <neescoba@cisco.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/cisco/enic/enic.h     | 20 +++++++++++++++-----
 drivers/net/ethernet/cisco/enic/enic_res.c |  2 +-
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index e6edb43515b97feeb21a9b55a1eeaa9b9381183f..ac7236f76a51bf32e7060ee0482b41fe82b60b44 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -280,18 +280,28 @@ static inline unsigned int enic_msix_wq_intr(struct enic *enic,
 	return enic->cq[enic_cq_wq(enic, wq)].interrupt_offset;
 }
 
-static inline unsigned int enic_msix_err_intr(struct enic *enic)
-{
-	return enic->rq_count + enic->wq_count;
-}
+/* MSIX interrupts are organized as the error interrupt, then the notify
+ * interrupt followed by all the I/O interrupts.  The error interrupt needs
+ * to fit in 7 bits due to hardware constraints
+ */
+#define ENIC_MSIX_RESERVED_INTR 2
+#define ENIC_MSIX_ERR_INTR	0
+#define ENIC_MSIX_NOTIFY_INTR	1
+#define ENIC_MSIX_IO_INTR_BASE	ENIC_MSIX_RESERVED_INTR
+#define ENIC_MSIX_MIN_INTR	(ENIC_MSIX_RESERVED_INTR + 2)
 
 #define ENIC_LEGACY_IO_INTR	0
 #define ENIC_LEGACY_ERR_INTR	1
 #define ENIC_LEGACY_NOTIFY_INTR	2
 
+static inline unsigned int enic_msix_err_intr(struct enic *enic)
+{
+	return ENIC_MSIX_ERR_INTR;
+}
+
 static inline unsigned int enic_msix_notify_intr(struct enic *enic)
 {
-	return enic->rq_count + enic->wq_count + 1;
+	return ENIC_MSIX_NOTIFY_INTR;
 }
 
 static inline bool enic_is_err_intr(struct enic *enic, int intr)
diff --git a/drivers/net/ethernet/cisco/enic/enic_res.c b/drivers/net/ethernet/cisco/enic/enic_res.c
index 60be09acb9fd56b642b7cabc77fac01f526b29a2..6910f83185c44797d769434fbe8af3105215b143 100644
--- a/drivers/net/ethernet/cisco/enic/enic_res.c
+++ b/drivers/net/ethernet/cisco/enic/enic_res.c
@@ -257,7 +257,7 @@ void enic_init_vnic_resources(struct enic *enic)
 
 		switch (intr_mode) {
 		case VNIC_DEV_INTR_MODE_MSIX:
-			interrupt_offset = i;
+			interrupt_offset = ENIC_MSIX_IO_INTR_BASE + i;
 			break;
 		default:
 			interrupt_offset = 0;

-- 
2.47.0



