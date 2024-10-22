Return-Path: <netdev+bounces-137714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 538489A97B9
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 06:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6899A1C230AD
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 04:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6A88BFC;
	Tue, 22 Oct 2024 04:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="D41BZzgO"
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-9.cisco.com (rcdn-iport-9.cisco.com [173.37.86.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C328B6EB7C
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 04:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729570705; cv=none; b=g4fiqDtOWqBuuu1K5O8Q5ijlT6sPKX2VZ0a9kFUNNndQQ3WaAXvl2M76kaKkEXfBp2BOevGjILtQnUvievBW0TwGEHHT/iQQQxMF3xdo4KurcBS7YvBGof5Hsdco044rf3KXbIiQ6C4Y1LWU/MM26yKzi8chNlc2FMwvC3SXjgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729570705; c=relaxed/simple;
	bh=SSVOZUhdiMtDzgvAvLrwSTVWiADUkQOXxXVUQwOEbrc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NzEhAwaCp+L1mBrTh1XZXlmqhYh5l/nexuSrckIWCcxSFPl/GGD8byVyEPPyJux9QhWeT4NoJAZg0FscvpncNj78KDcXe/8XwmnFGonDIArGr/NlqNhOw6/qQG+MK7I/8xLMKlwV8IPU2CPE9MwIkgvyQxT/PYNdkF7wPs6RM5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=D41BZzgO; arc=none smtp.client-ip=173.37.86.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2564; q=dns/txt; s=iport;
  t=1729570703; x=1730780303;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HcUKEv2emSx5BAHfHG306BIQJWaOigYcS0Z6xNllAG0=;
  b=D41BZzgOzs6NG9pRLgWuT48ZjlQEr6bqjLQQI8xZoq9Qz4uJ0g7tTiFh
   pTbGYySEkyj5nRK9SJBEt2eDPmldmddrUQFg2GNmRvzYnxegQUXmKNvUK
   ScpngMPNEjF4lj8zdPfqPKTi6+55ZE4kJXp52UlxFOposTssIJzCLpteo
   0=;
X-CSE-ConnectionGUID: effnDKefTWi2OMGEJTbcKw==
X-CSE-MsgGUID: Ev34CNMZReaH7XA6AC7jXg==
X-IPAS-Result: =?us-ascii?q?A0ApAABGJhdn/5T/Ja1aHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?wcBAQsBgkqBT0NIjHJfiHKLdZIigSUDVg8BAQEPRAQBAYUHAoojAiY0CQ4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBBwWBDhOGCIZbAgEDJwsBRhBRK?=
 =?us-ascii?q?ysZgwGCZQOvW4F5M4EBhHvZOIFsgUgBjUVwhHcnG4FJRIEUAYNohRCFdwSHa?=
 =?us-ascii?q?IwtiVoliT2RdkiBIQNZIQIRAVUTDQoLCQWJNYMmKYFrgQiDCIUlgWcJYYhHg?=
 =?us-ascii?q?QctgRGBHzqCA4E2SoU3Rz+CT2pONwINAjeCJIEAglGGR0ADCxgNSBEsNRQbB?=
 =?us-ascii?q?j5uB6x6RoJfB3sUgS4CQD+lZ6B+hCShPxozqkyYd6Q6hGaBZzyBWTMaCBsVg?=
 =?us-ascii?q?yJSGQ+OLRYWzCgmMjsCBwsBAQMJjigBAQ?=
IronPort-Data: A9a23:4d2diqhDmWBJ0lJopzVHwfVoX161JxEKZh0ujC45NGQN5FlHY01je
 htvXWjQbvqLMTOnfYp/aoi+oEpV7MXRn9FlT1Zq+y5kRX5jpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+1HwdOKn9SAsvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRW2thg
 vus5ZSGULOZ82QsaD5Ns/jZ8EoHUMna4Vv0gHRvPZing3eG/5UlJMp3Db28KXL+Xr5VEoaSL
 87fzKu093/u5BwkDNWoiN7TKiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JAAatjsAhlqvgqo
 Dl7WTNcfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQqflO0q8iCAn3aMqUV9OhxLUJD+
 8AnKWoqSz+upd68y5GkH7wEasQLdKEHPasFsX1miDWcBvE8TNWaGuPB5MRT23E7gcUm8fT2P
 pVCL2EwKk6dPlsWZgd/5JEWxI9EglH5fjBDo1WfrII84nPYy0p6172F3N/9IIPUG50Kxx3Jz
 o7A10nnWU0xEvmt8zeM0i2cr7Hmtnz5aI1HQdVU8dYv2jV/3Fc7DhAKWValiee2h1T4WN9FL
 UEQvC00osAPGFeDVNLxWVi85XWDpBNZAoMWGOwh4wbLwa3Ri+qEOlU5ovd6QIROnKcLqfYCj
 zdlQ/uB6eRTjYCo
IronPort-HdrOrdr: A9a23:rWfXA6C2SlFZxYXlHemr55DYdb4zR+YMi2TDGXofdfUzSL3+qy
 nAppUmPHPP5Qr5HUtQ++xoW5PwJU80i6QU3WB5B97LN2PbUSmTXeRfBODZrQEIdReTygck79
 YCT0C7Y+eAdGSTSq3BkW+FL+o=
X-Talos-CUID: =?us-ascii?q?9a23=3AqfhLJmk2aE/uT9gqG6irCN3ijxDXOXDTwnH8AEK?=
 =?us-ascii?q?2NVloEpqwZnKyxKlvsNU7zg=3D=3D?=
X-Talos-MUID: 9a23:Qh/2uQbVKg2ci+BTmiG32BpEEfVS7q2OV3Akz7wt5Mu0Onkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,222,1725321600"; 
   d="scan'208";a="276607139"
Received: from rcdn-l-core-11.cisco.com ([173.37.255.148])
  by rcdn-iport-9.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 22 Oct 2024 04:18:17 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-11.cisco.com (Postfix) with ESMTP id F36821800024F;
	Tue, 22 Oct 2024 04:18:16 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 412739)
	id BC87320F2003; Mon, 21 Oct 2024 21:18:16 -0700 (PDT)
From: Nelson Escobar <neescoba@cisco.com>
To: netdev@vger.kernel.org
Cc: satishkh@cisco.com,
	johndale@cisco.com,
	Nelson Escobar <neescoba@cisco.com>
Subject: [Patch net-next 2/5] enic: Make MSI-X I/O interrupts come after the other required ones
Date: Mon, 21 Oct 2024 21:17:04 -0700
Message-Id: <20241022041707.27402-3-neescoba@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20241022041707.27402-1-neescoba@cisco.com>
References: <20241022041707.27402-1-neescoba@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-l-core-11.cisco.com

The VIC hardware has a constraint that the MSIX interrupt used for errors
be specified as a 7 bit number.  Before this patch, it was allocated after
the I/O interrupts, which would cause a problem if 128 or more I/O
interrupts are in use.

So make the required interrupts come before the I/O interrupts to
guarantee the error interrupt offset never exceeds 7 bits.

Signed-off-by: Nelson Escobar <neescoba@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h     | 20 +++++++++++++++-----
 drivers/net/ethernet/cisco/enic/enic_res.c |  2 +-
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index e6edb43515b9..ac7236f76a51 100644
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
index 60be09acb9fd..6910f83185c4 100644
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
2.35.2


