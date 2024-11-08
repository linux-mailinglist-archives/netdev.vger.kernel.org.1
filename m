Return-Path: <netdev+bounces-143444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C89769C2731
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 22:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E48F31C218A4
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 21:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CB71F26E6;
	Fri,  8 Nov 2024 21:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="M9asuuQS"
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-8.cisco.com (rcdn-iport-8.cisco.com [173.37.86.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327501EF0BD;
	Fri,  8 Nov 2024 21:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731102623; cv=none; b=JGQeZIgVv6yDvaVwvq+VrXYKFe4NKcs58QioIJ5HijO/aZ6ROFK5eosQsrMHVHT/uH/JAJ5EE77Q2wqf2LFx7rw7u0M3hfPdlJ57oz+/3rbHgEeC1DcCH9J34RSYIAa29F8U0OTvIMjFA9xyqGGkBdOoUm0GRMcznrvV3HIVp4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731102623; c=relaxed/simple;
	bh=XQ3jHf1N8vFfVXlcACUMbfR0xqkNz6oH2BhWU4pzZ/0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=diH1IfXy3ZpMvP3mutfoEy7JX1QdPkUDi0YzAVZH3YkkSEtdnE3FNFLnXRxae5OEiCo/WQ5A+QemETLlIZfsZ6g98lk0wOFTpKvafgMkZq/DBEqgjRUXRvqItROssIB0KrVIz2fGXF0ZUexIWT73xDZXf9izEfDbMwG0x1+gRK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=M9asuuQS; arc=none smtp.client-ip=173.37.86.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=3516; q=dns/txt; s=iport;
  t=1731102621; x=1732312221;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=/2cgGfNC+AxfAfMGCkaQxOgbTkx4rZWj1kqd0GxZ8Wo=;
  b=M9asuuQS5BqUUbI1/DPNvQcq+ShKAWTkAe/BHmM5GCOG7S1Ha196YG96
   1gesMv1SEKq5ZA1bsFWtmZaan04Ie3Ja0i1N9F7U8iYLm1lTOAfntc7v0
   LWXUGGFFmIdcqrhrnuzunlCoscS3OabLhmzJcY21vs1fRIGlUcbVOeZlU
   I=;
X-CSE-ConnectionGUID: QPMTbMA6QSSOTS6w0Yh93w==
X-CSE-MsgGUID: NA2JPclQQa+5ytNLi30wFQ==
X-IPAS-Result: =?us-ascii?q?A0AHAAA5hi5n/43/Ja1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAYJKgVBCSIRViB2HMIIhi3WSI4ElA1YPAQEBD?=
 =?us-ascii?q?0QEAQGFBwKKOgImNAkOAQIEAQEBAQMCAwEBAQEBAQEBAQEBCwEBBQEBAQIBB?=
 =?us-ascii?q?wWBDhOGCIZbAgEDIwRSECUCJgICKxsQBgESgwGCZQIBsFp6fzOBAYR72TiBb?=
 =?us-ascii?q?YEaLgGISwGBbIN9O4Q8JxuBSUSBFAGDaIgegmkEh2IliRWYUgk/gQUcA1khE?=
 =?us-ascii?q?QFVEw0KCwcFY1g+AyJvaVx6K4EOgRc6Q4E7gSIvGyELXIE4gRoUBhUEgQ5BP?=
 =?us-ascii?q?4JKaUs3Ag0CNoIkJFmCT4UdhG+EaIISHUADCxgNSBEsNQYOGwY9AW4HnilGg?=
 =?us-ascii?q?yYHexSBLgJAP5dHjT2ha4QkoVkzqk2YdyKkG4RmgWc8gVkzGggbFYMiUhkPj?=
 =?us-ascii?q?i0WFpMAAbU6QzU7AgcLAQEDCZIZAQE?=
IronPort-Data: A9a23:5lIL56xyXLDUNzO7QVp6t+f3xyrEfRIJ4+MujC+fZmUNrF6WrkVUy
 mYfUWDVPKqDYGbzfdlyPI/i9UgDv5WAmNNmTldlpFhgHilAwSbn6Xt1DatR0we6dJCroJdPt
 p1GAjX4BJlqCCea/lH1b+CJQUBUjcmgXqD7BPPPJhd/TAplTDZJoR94kobVuKYw6TSCK13L4
 ImaT/H3Ygf/h2ctajJMt8pvlTs21BjMkGJA1rABTagjUG/2zxE9EJ8ZLKetGHr0KqE8NvK6X
 evK0Iai9Wrf+Ro3Yvv9+losWhRXKlJ6FVHmZkt+A8BOsDAbzsAB+vpT2M4nVKtio27hc+adZ
 zl6ncfYpQ8BZsUgkQmGOvVSO3kW0aZuoNcrLZUj2CCe5xWuTpfi/xlhJHgOGLES388pOFp10
 sAjdi9VXxDS3P3jldpXSsE07igiBNPgMIVavjRryivUSK56B5vCWK7No9Rf2V/chOgXQq2YP
 JVfM2cyKk2cOnWjOX9PYH46tOGli2L0dDdRgFmUvqEwpWPUyWSd1ZC3b4eEJ4TaHpw9ckCwg
 Euc3VzyBigjPZ/C2Caj1nP33vDhpHauMG4VPPjinhJwu3Wfz3IeDTUaXEW2pP2+hFL4Xd9DQ
 2QZ9jcrpLo/6GSkSd7yWxD+q3mB1jYfRtBZO+438geAzuzT+QnxLmECQiRMd58gudM6SCIC0
 kKPmZXiBVRHqLSfRHSc3q2ZoTO7JW4eKmpqTSsFSxYVptruuoc+ijrRQdt5Vq24lNv4HXf32
 T/ihC4zm7kek+YV2Kihu1PKmTShot7OVAFd2+nMdniu4gU8YMuuYJalrACHq/1BN42eCFKGu
 RDohvSj0QzHNrnV/ATlfQnHNOjBCyqtWNEEvWNSIg==
IronPort-HdrOrdr: A9a23:Km9ghqrggEVQ8UPYhyqcT9AaV5r0eYIsimQD101hICG9vPbo8P
 xG+8566faUslcssR4b9exoVJPsfZqYz+8R3WBzB9mftXfdyQiVxehZhOOIqQEIWReOlNK1vp
 0OT0ERMqyVMXFKyev3/wW8Fc8t252k/LDAv5an815dCSxndK1k6R50EUKgEkNwTBRbHpZRLu
 vk2iM+nUvHRUgq
X-Talos-CUID: 9a23:eY6UGmGO2zUPbUEPqmJezGsoEOUMLETm91DsGBGnUVdpGeaKHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3ABO8QUw7/rZl//fIoQJEAH/rOxoxOyv6MMEsJqKw?=
 =?us-ascii?q?P+JSVKQpUOmzFkxqOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,139,1728950400"; 
   d="scan'208";a="275950831"
Received: from rcdn-l-core-04.cisco.com ([173.37.255.141])
  by rcdn-iport-8.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 08 Nov 2024 21:49:12 +0000
Received: from neescoba-vicdev.cisco.com (neescoba-vicdev.cisco.com [171.70.41.192])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-04.cisco.com (Postfix) with ESMTPS id 81F9B1800019C;
	Fri,  8 Nov 2024 21:49:12 +0000 (GMT)
Received: by neescoba-vicdev.cisco.com (Postfix, from userid 412739)
	id 0488BCC128F; Fri,  8 Nov 2024 21:49:12 +0000 (GMT)
From: Nelson Escobar <neescoba@cisco.com>
Date: Fri, 08 Nov 2024 21:47:48 +0000
Subject: [PATCH net-next v3 2/7] enic: Make MSI-X I/O interrupts come after
 the other required ones
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-remove_vic_resource_limits-v3-2-3ba8123bcffc@cisco.com>
References: <20241108-remove_vic_resource_limits-v3-0-3ba8123bcffc@cisco.com>
In-Reply-To: <20241108-remove_vic_resource_limits-v3-0-3ba8123bcffc@cisco.com>
To: John Daley <johndale@cisco.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nelson Escobar <neescoba@cisco.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731102551; l=3573;
 i=neescoba@cisco.com; s=20241023; h=from:subject:message-id;
 bh=XQ3jHf1N8vFfVXlcACUMbfR0xqkNz6oH2BhWU4pzZ/0=;
 b=z0jDXtD93+vpE09VO+RoS0uNefrG35ZmyKaYkFc0+QTtsWmvNkPiXSVJSUz6Md6lUUoLk9m5O
 lKjUhdSt4qxC4jE9x+O4jVtkD/vh0OoGemyl7PRtVDZ3Ef8+QFrwbME
X-Developer-Key: i=neescoba@cisco.com; a=ed25519;
 pk=bLqWB7VU0KFoVybF4LVB4c2Redvnplt7+5zLHf4KwZM=

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
---
 drivers/net/ethernet/cisco/enic/enic.h     | 20 +++++++++++++++-----
 drivers/net/ethernet/cisco/enic/enic_res.c | 11 +++++++----
 2 files changed, 22 insertions(+), 9 deletions(-)

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


