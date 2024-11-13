Return-Path: <netdev+bounces-144613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B31FA9C7EFE
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 00:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 733A7283D83
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 23:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9DE18CBFB;
	Wed, 13 Nov 2024 23:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="iWdPgm/S"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-5.cisco.com (alln-iport-5.cisco.com [173.37.142.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D03818C01A;
	Wed, 13 Nov 2024 23:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731542217; cv=none; b=UlaTdjZuUPbEPJm4e2DNbJklzwCipcO/pnkHWaopKLAJFRgtTv/4Css5fHxvw1ipQK0EcNdwviFLUee1Zt89lX7n71eQfJnIcenFobcyNB4EBN2uyfjTLqziX+g5U630b/3R0ZX8sESCb3XVf72av/yShKAz3r+0JGa+Dsg1Rzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731542217; c=relaxed/simple;
	bh=bjDYEaN1jnLUpoSt2mCpRky26CJzLy56FeZuHu3EI4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pkh7MjkGeE+xPYADBSUNPV4de/ENCZG8xDH83Fi0upJC9neS4p4DV4ggmeF/B9Hujdazx+sv6vam3PuUcDglFVkSdJ0CGU/R1ZAafUdDzwcAQIz2iMtSPco6bc2UoFr/eG2vwseQEb2cJgrKMgDAocsgx9SqX0wY7qqGcBmbfgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=iWdPgm/S; arc=none smtp.client-ip=173.37.142.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=3562; q=dns/txt; s=iport;
  t=1731542215; x=1732751815;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=otUS7+T9V88sqMYIwIvCRgKR9l6KDUgEA7HwdHgcsl4=;
  b=iWdPgm/SDehEywARFjrWYoOeB5W0UPRHzKu19FaETUnW8uTYt+A/ajcm
   TYb8mX+rujJVQyVN4w97ilQvJYHef/6xlUdZX5cTBLKrjlCIUuT6JiICE
   i3ajxX2iSDplb8i7XcGP6nrgyCY2Id0tO9GxumkLTI1YqUObcNEbblD1r
   4=;
X-CSE-ConnectionGUID: 49hTXwsMTuiKsYzAhknrJQ==
X-CSE-MsgGUID: 044Pnhr6SQG7+68S8/jGYQ==
X-IPAS-Result: =?us-ascii?q?A0ACAADHOzVnj5EQJK1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAYQaQkiEVYgdhzCCIYt1kiOBJQNWDwEBAQ9EB?=
 =?us-ascii?q?AEBhQcCikUCJjQJDgECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFF?=
 =?us-ascii?q?AEBAQEBATkFDjuGCIZbAgEDIwRSECUCJgICKxsQBgESgwGCZQIBsGZ6fzOBA?=
 =?us-ascii?q?YR72TiBbYEaLgGISwGBbIN9O4Q8JxuBSUSBFAGDaIgegmkEh14lhR6DeZkpC?=
 =?us-ascii?q?T+BBRwDWSERAVUTDQoLBwVjVzwDIm9qXHorgQ6BFzpDgTuBIi8bIQtcgTeBG?=
 =?us-ascii?q?hQGFQSBDkY/gkppSzoCDQI2giQkWYJPhRqEbYRmglQvHUADCxgNSBEsNQYOG?=
 =?us-ascii?q?wY9AW4HnmVGgysHexSBLgJAPxCXO40+oWuEJKFcM6pNmHcipByEZoFnOoFbM?=
 =?us-ascii?q?xoIGxWDIlIZD44tDQkWkwABtj9DNTsCBwsBAQMJkEkBAQ?=
IronPort-Data: A9a23:9jWB967t4XtBwQ/LbazhgwxRtK3HchMFZxGqfqrLsTDasY5as4F+v
 jcfWW6Fa6yIazb0ctwlbNi+8ksCvZXXmtFrSgY5+C9nZn8b8sCt6fZ1gavT04J+CuWZESqLO
 u1HMoGowPgcFyGa/lH1dOC89RGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUw6mJSqYDR7zil5
 5Wr+aUzBHf/g2QoaztNsPrYwP9SlK2aVA0w7wRWic9j5Dcyp1FNZLoDKKe4KWfPQ4U8NoaSW
 +bZwbilyXjS9hErB8nNuu6TnpoiG+O60aCm0xK6aoD66vRwjnVaPpUTaJLwXXxqZwChxLid/
 jniWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I0DuKxPRL/tS4E4eYdwYxtZoGkRy6
 P07MwEfRxCAgfiU+efuIgVsrpxLwMjDNYcbvDRkiDreF/tjGcCFSKTR7tge1zA17ixMNa+BP
 IxCN3w2MlKZP0An1lQ/UPrSmM+ui3TkeDpSoXqepLE85C7YywkZPL3Fa4qMI4HSGJsP9qqej
 jqao1z/AgtED+Wwlnnbokn8we3grBquDer+E5Xjq6Y12wfMroAJMzUaXEW2pNG1g1CzXtZYJ
 VBS/CcyxYA/+FGuR8vwQzW3p3mLuhNaUN1Ve8U67xuI0YLX7hyfC2xCSSROAPQlqcU/bT8nz
 FmEm5XuHzMHmLSTRWiQ6fSSoC++NDY9KXIEY2kPTWMt+9DprYcypgjCQtZqDOi+ididMTXxx
 S2a6SsznbMeieYV2Kihu1PKmTShot7OVAFdzgPaQm6o8Ctna4O/IY+l817W6bBHNonxc7Wal
 HEAn87b6KUFCouA0XTdBu4MB7quof2CNVUwnGKDAbF9pjSRy2G4WLxN4RJlFVVAMsUCYx3QN
 Rq7VRxq2LdfO36jbKlSao23Ctg3waWIKTgDfq6IBjapSsYsHDJr7B1TiVisM3cBeXXAcJ3T2
 7/HIa5A7l5DVcyLKQZaoc9Gj9fHIQhlmQvuqWjTlUjP7FZnTCf9pU05GFWPdPsly6iPvR/Y9
 d1SX+PTlE4GDbekPHmHrNdJRbzvEZTdLc2owyCwXrPSSjeK5El4Wpc9PJt4IdU8xPUP/gs21
 irtAxQGoLYAuZE3AV7XMi84MuyHsWdXpnMgNitkJkezx3Umes6u6qxZH6bbjpF5nNGPOcVcF
 qFfE+3ZW6wnYm2ep1w1M8KnxKQ8L0vDuO57F3b+CNTJV8I7H1SRkjIlFyOznBQz4t2f7pti/
 eb4jVyEEPLuhW1KVa7rVR5m9Hvp1VB1pQ64dxKgzgV7EKk0zLVXFg==
IronPort-HdrOrdr: A9a23:02naXqBxOM/qwIflHelh55DYdb4zR+YMi2TDGXoBLiC9Ffb5qy
 nOppUmPHDP5Ar5NEtMpTnEAtjkfZq+z/BICPcqTNSftWDd0QPCRr2Kr7GSoQEIcBeQygcy79
 YFT4FOTPD9ElR+i9/3+02bH8ZI+qj+zImYwcrT0HtpSxhncOVb7wl/AhuGCUEefng+OXNALu
 v72iKCzADQA0j+qa+AdwI4Y9Q=
X-Talos-CUID: 9a23:6xNuYmCLFa0dmyT6E3U29HIkBdsATmDc72zhMWa4CmBzaoTAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3ArOl+/QxzusnQ6KAGl8zOEyIqj+SaqPzyVHgLkY9?=
 =?us-ascii?q?YgPCram8uawzNyzaYc7Zyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,152,1728950400"; 
   d="scan'208";a="381150562"
Received: from alln-l-core-08.cisco.com ([173.36.16.145])
  by alln-iport-5.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 13 Nov 2024 23:56:53 +0000
Received: from neescoba-vicdev.cisco.com (neescoba-vicdev.cisco.com [171.70.41.192])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-08.cisco.com (Postfix) with ESMTPS id 4A1AE1800022B;
	Wed, 13 Nov 2024 23:56:53 +0000 (GMT)
Received: by neescoba-vicdev.cisco.com (Postfix, from userid 412739)
	id CACC6CC128F; Wed, 13 Nov 2024 23:56:52 +0000 (GMT)
From: Nelson Escobar <neescoba@cisco.com>
Date: Wed, 13 Nov 2024 23:56:34 +0000
Subject: [PATCH net-next v4 2/7] enic: Make MSI-X I/O interrupts come after
 the other required ones
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-remove_vic_resource_limits-v4-2-a34cf8570c67@cisco.com>
References: <20241113-remove_vic_resource_limits-v4-0-a34cf8570c67@cisco.com>
In-Reply-To: <20241113-remove_vic_resource_limits-v4-0-a34cf8570c67@cisco.com>
To: John Daley <johndale@cisco.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nelson Escobar <neescoba@cisco.com>, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731542212; l=3619;
 i=neescoba@cisco.com; s=20241023; h=from:subject:message-id;
 bh=bjDYEaN1jnLUpoSt2mCpRky26CJzLy56FeZuHu3EI4M=;
 b=lMbf8PX3anuiIBjxFEGXWJKqDeQFTx6rDIaYdYU9Q92pwiXTFyigaJ+++7Z60dgfN1nwwwyt2
 nSTJMqkcbxyCxJS1/Lg31bjiI23/Sj9Zt+yIwYEFAxtPYAndQ0Ifr6b
X-Developer-Key: i=neescoba@cisco.com; a=ed25519;
 pk=bLqWB7VU0KFoVybF4LVB4c2Redvnplt7+5zLHf4KwZM=
X-Outbound-SMTP-Client: 171.70.41.192, neescoba-vicdev.cisco.com
X-Outbound-Node: alln-l-core-08.cisco.com

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
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Nelson Escobar <neescoba@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h     | 20 +++++++++++++++-----
 drivers/net/ethernet/cisco/enic/enic_res.c | 11 +++++++----
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 07459eac2592ce5185321a619577404232cfbc2c..ec83a273d1ca40ae89f3c193207cf26814f6b277 100644
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
index 60be09acb9fd56b642b7cabc77fac01f526b29a2..72b51e9d8d1a26a2cd18df9c9d702e5b11993b70 100644
--- a/drivers/net/ethernet/cisco/enic/enic_res.c
+++ b/drivers/net/ethernet/cisco/enic/enic_res.c
@@ -221,9 +221,12 @@ void enic_init_vnic_resources(struct enic *enic)
 
 	switch (intr_mode) {
 	case VNIC_DEV_INTR_MODE_INTX:
+		error_interrupt_enable = 1;
+		error_interrupt_offset = ENIC_LEGACY_ERR_INTR;
+		break;
 	case VNIC_DEV_INTR_MODE_MSIX:
 		error_interrupt_enable = 1;
-		error_interrupt_offset = enic->intr_count - 2;
+		error_interrupt_offset = enic_msix_err_intr(enic);
 		break;
 	default:
 		error_interrupt_enable = 0;
@@ -249,15 +252,15 @@ void enic_init_vnic_resources(struct enic *enic)
 
 	/* Init CQ resources
 	 *
-	 * CQ[0 - n+m-1] point to INTR[0] for INTx, MSI
-	 * CQ[0 - n+m-1] point to INTR[0 - n+m-1] for MSI-X
+	 * All CQs point to INTR[0] for INTx, MSI
+	 * CQ[i] point to INTR[ENIC_MSIX_IO_INTR_BASE + i] for MSI-X
 	 */
 
 	for (i = 0; i < enic->cq_count; i++) {
 
 		switch (intr_mode) {
 		case VNIC_DEV_INTR_MODE_MSIX:
-			interrupt_offset = i;
+			interrupt_offset = ENIC_MSIX_IO_INTR_BASE + i;
 			break;
 		default:
 			interrupt_offset = 0;

-- 
2.35.6


