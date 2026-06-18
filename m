Return-Path: <netdev+bounces-300297-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wg33B4pRM2rO/QUAu9opvQ
	(envelope-from <netdev+bounces-300297-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 04:01:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C77469D191
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 04:01:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cisco.com header.s=iport01 header.b="XF1T/QE9";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300297-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300297-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cisco.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4B083055DDB
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 01:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B7D2E7388;
	Thu, 18 Jun 2026 01:54:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-3.cisco.com (rcdn-iport-3.cisco.com [173.37.86.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8548C2E736A;
	Thu, 18 Jun 2026 01:54:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781747650; cv=none; b=nTnUglaWdS+OzgcxqOP4UFWQTIq668c/ijTt/R9v5NjSijYPIMzh7rNcX2pxLJfXKdYwFZ7saMfWNEYurzEcJl1CgrzhNR0rJhtXbPmNOhWrPk9VZ5Uy3YNWDKFmSgGonrrrf0sp7LWeGaI97bHcOrorTpyudxfSAqUQw5U9Xrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781747650; c=relaxed/simple;
	bh=t34WFg1OJPAyXY9QMriV4a3e8O+6EvDBd8KRpI56OF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j+QP+X880hMU4DwYQzqeNhAN5QuKypeLJzXgpJthT+HkTLSdNOQgULFEAU8WDp5yxH6EkPEeiIEjMmH/gcennsvHd4orWpxk6ZiwskJXIe5JVOqVs3njOrpEYgdzP6d4pAyF3eonGLOngWT+8TWb3dFaKfMLbZYjbjAS6WxFnpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=XF1T/QE9; arc=none smtp.client-ip=173.37.86.74
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2592; q=dns/txt;
  s=iport01; t=1781747643; x=1782957243;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=EQWp/i9x4NzDrC5VaN05TPdpcwXUJymdJW1VclAN818=;
  b=XF1T/QE9mCEUXZwTvR/KTodffvEqjxoPXLUDj8yc4oMAvGS0yqEWZFYZ
   GSahlv9kVr93FrvDWMAiaJqgNp/7wiC1wRDRZM8ogG9X5lcfhRBwOInso
   BRqMOYeUBuJu33CgR80EW9VX7lByLHULUprbqZU10LSt6/t+4mMle60Ob
   SzBuwiEiByPKUg3zas8++WB/oWj53CTkgO4BXKaz+GajIElOfMZHD8W4p
   H+ci11PAicpGnTCIa+6JWA/U4eZZJzCaCZZRNvfG2JpdkUM7hAqDGaFOg
   lEQpZNuDsFDIpb4TYOy1oxffnumsroEloUM9hDHbn3/0dxbLfv6+Ant6X
   w==;
X-CSE-ConnectionGUID: gSwSAY7qRV+yNZAlgDXtrw==
X-CSE-MsgGUID: P2+IF1JGSx+xaOOik4MK5g==
X-IPAS-Result: =?us-ascii?q?A0AmAAByTzNq/4r/Ja1aHQEBAQEJARIBBQUBgXwIAQsBg?=
 =?us-ascii?q?laBUkNJhFeIHIc3giGeHoF+DwEBAQ9RBAEBhQYCjUQCJjQJDgECBAMCAwEBA?=
 =?us-ascii?q?QEBAQEBAQEBCwEBBQEBAQIBBwWBDhOGXIZbAgEDIwRSECUCJgICRhAGARKDA?=
 =?us-ascii?q?oJ0A7Jqen8zgQGEfdlGgWYBCxQBgQouAYVwgmoBgXCEBjuEQScbgUlEhH6EC?=
 =?us-ascii?q?oQUgmoEgxwSkScJP4ECHANZLAFVEw0KCwcFYVIzAyAKCxISGBUCFC8PBBYyH?=
 =?us-ascii?q?XAMJxIsFzRYGwcFgR6BJy8EIYEDhQMjHwM5f4FtgSVnZhUwNYEBAREfCoEbA?=
 =?us-ascii?q?wsYDUgRLDcGDhsEPQFuB4x5Fw+BTHE9UoJoKZNAgzKNX2uhD4QngWagDwEyl?=
 =?us-ascii?q?2eTBSyYXCOkADeEaIFoPIFZMxoIGxWDIlMZD44tFhzJSScyPwcCBw8CkXOBf?=
 =?us-ascii?q?QEB?=
IronPort-Data: A9a23:82qbNq5SB/FE0QIiAAMFsgxRtOTGchMFZxGqfqrLsTDasY5as4F+v
 jYYWT3TOPiMZjD3Kdx3PImw9RwP7JKHydRiGQpqqSFgZn8b8sCt6fZ1gavT04J+CuWZESqLO
 u1HMoGowPgcFyGa/lH2dOC98RGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUw6mJSqYDR7zil5
 5Wo/6UzBHf/g2QqajxNtPrfwP9SlK2aVA0w7wRWic9j5Dcyp1FNZLoDKKe4KWfPQ4U8NoaSW
 +bZwbilyXjS9hErB8nNuu6TnpoiG+O60aCm0xK6aoD66vRwjnVaPpUTaJLwXXxqZwChxLid/
 jniWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I0DuKxPRL/tS4E4eMrYHwc9GXnh0y
 78JDgIkah+vt/6s3+fuIgVsrpxLwMjDJogTvDRkiDreF/tjGcmFSKTR7tge1zA17ixMNa+BP
 IxCNnw1MUmGOkYfUrsUIMpWcOOAnXDjciZYq1K9rqss6G+Vxwt0uFToGIaEJILaHpQIzy50o
 Er+pSfYLEg4G+ePiiqM1VWthbPqvn70Ddd6+LqQs6QCbEeo7mAaFhATfVeyv/S8jkmwR5RZJ
 lB80i4jrLQ782SnQ9P8Vhv+p2SL1jYRV8dVGv839CmCza3b5wvfDW8BJhZCddYvnMw7Xzon0
 hmOhdyBLTVpvKeYVjGb+6uYoC2aPTUTKykJZUcsVQIP7t/iiJs+ghLGUpBoF6vdptn0Hyzgh
 jOHti4zg50NgsMRkaa251bKh3SrvJehZgg4+gnaQEq74Q5jIo2ofYql7R7c9/koEWqCZkOKs
 H5Bn42V6/oDSMnU0ieMW+4KWrqu4p5pLQHhvLKmJLF5nxzFxpJpVdkKiN2iDC+F6vo5RAI=
IronPort-HdrOrdr: A9a23:qfsX9q8nFG5vHFY0ErRuk+AuI+orL9Y04lQ7vn2ZhyYlFvBw8P
 rOoB1773HJYVkqNU3I9errBEDEewK/yXcX2+Ys1MmZPDUO0VHAROpfBMnZsl7d8kbFmtK1u5
 0QFpRWOZncAUd3iMDi7BL9MdoxqeP3iZyAtKPyw2hgSAdyZ7ol1Qd2DQ6HDlZ7LTM2Y6bRbK
 DsgfZvln6HZWkdaNi9Cz0uWujOoMCOqbfdCCR2fyLOLGK1/EmVAHmQKWni4isj
X-Talos-CUID: 9a23:HSFBxWxCUZ1SXUM+ogGxBgUbId8eW0yC1U3uYF6eO09tR5GlVUWPrfY=
X-Talos-MUID: 9a23:34Q43AgAj/UW+XdEpqxNaMMpDJ0rwor3Km82gdYWsu6jNC8sHhTAg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.24,210,1774310400"; 
   d="scan'208";a="496683959"
Received: from rcdn-l-core-01.cisco.com ([173.37.255.138])
  by rcdn-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 18 Jun 2026 01:53:50 +0000
Received: from [127.0.0.1] (unknown [10.25.128.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-01.cisco.com (Postfix) with ESMTPS id 5637A1800030F;
	Thu, 18 Jun 2026 01:53:49 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Wed, 17 Jun 2026 18:53:24 -0700
Subject: [PATCH net-next v9 01/10] enic: verify firmware supports V2 SR-IOV
 at probe time
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-enic-sriov-v2-admin-channel-v2-v9-1-37f5f5af4c93@cisco.com>
References: <20260617-enic-sriov-v2-admin-channel-v2-v9-0-37f5f5af4c93@cisco.com>
In-Reply-To: <20260617-enic-sriov-v2-admin-channel-v2-v9-0-37f5f5af4c93@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sesidhar Baddela <sebaddel@cisco.com>, Satish Kharat <satishkh@cisco.com>, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781747628; l=2641;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=t34WFg1OJPAyXY9QMriV4a3e8O+6EvDBd8KRpI56OF4=;
 b=l7Wt5Zigf/Y7f8LqlkeRg3LcrCjko739Me8S+4SLfYx7PAPYNvylNGRMc3OlimaKa8qpKujFo
 jbSEhZEpCNiACgWgsZ00sgUTWrwR2nn/KMAhaVgezR1XRcWRQ3eDZi1
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.189];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.189, [10.25.128.189]
X-Outbound-Node: rcdn-l-core-01.cisco.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[cisco.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cisco.com,reject];
	R_DKIM_ALLOW(-0.20)[cisco.com:s=iport01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-300297-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[satishkh@cisco.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sebaddel@cisco.com,m:satishkh@cisco.com,m:leitao@debian.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[satishkh@cisco.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[cisco.com:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,cisco.com:dkim,cisco.com:email,cisco.com:mid,cisco.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6C77469D191

During PF probe, query the firmware get-supported-feature interface
to verify that the running firmware supports V2 SR-IOV. Firmware
version 5.3(4.72) and later report VIC_FEATURE_SRIOV via
CMD_GET_SUPP_FEATURE_VER. If the firmware does not support the
feature, set vf_type to ENIC_VF_TYPE_NONE and log a warning so the
admin knows a firmware upgrade is needed.

VIC_FEATURE_SRIOV is assigned the explicit value 4 to match the
firmware ABI.  Slot 3 (firmware's VIC_FEATURE_PTP) is reserved with
a comment rather than a placeholder enum entry, since PTP is not
used by the upstream driver.

Suggested-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic_main.c   | 21 ++++++++++++++++++++-
 drivers/net/ethernet/cisco/enic/vnic_devcmd.h |  2 ++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index e7125b818087..53d68272d06a 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -2641,8 +2641,10 @@ static void enic_iounmap(struct enic *enic)
 static void enic_sriov_detect_vf_type(struct enic *enic)
 {
 	struct pci_dev *pdev = enic->pdev;
-	int pos;
+	u64 supported_versions, a1 = 0;
 	u16 vf_dev_id;
+	int pos;
+	int err;
 
 	if (enic_is_sriov_vf(enic) || enic_is_dynamic(enic))
 		return;
@@ -2669,6 +2671,23 @@ static void enic_sriov_detect_vf_type(struct enic *enic)
 		enic->vf_type = ENIC_VF_TYPE_NONE;
 		break;
 	}
+
+	if (enic->vf_type != ENIC_VF_TYPE_V2)
+		return;
+
+	/* A successful command means firmware recognizes
+	 * VIC_FEATURE_SRIOV; supported_versions is available
+	 * for sub-feature versioning in the future.
+	 */
+	err = vnic_dev_get_supported_feature_ver(enic->vdev,
+						 VIC_FEATURE_SRIOV,
+						 &supported_versions,
+						 &a1);
+	if (err) {
+		dev_warn(&pdev->dev,
+			 "SR-IOV V2 not supported by current firmware. Upgrade to VIC FW 5.3(4.72) or higher.\n");
+		enic->vf_type = ENIC_VF_TYPE_NONE;
+	}
 }
 #endif
 
diff --git a/drivers/net/ethernet/cisco/enic/vnic_devcmd.h b/drivers/net/ethernet/cisco/enic/vnic_devcmd.h
index 605ef17f967e..3b6efa743dba 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_devcmd.h
+++ b/drivers/net/ethernet/cisco/enic/vnic_devcmd.h
@@ -734,6 +734,8 @@ enum vic_feature_t {
 	VIC_FEATURE_VXLAN,
 	VIC_FEATURE_RDMA,
 	VIC_FEATURE_VXLAN_PATCH,
+	/* slot 3 reserved for firmware VIC_FEATURE_PTP */
+	VIC_FEATURE_SRIOV	= 4,
 	VIC_FEATURE_MAX,
 };
 

-- 
2.43.0


