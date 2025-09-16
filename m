Return-Path: <netdev+bounces-223547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA5AB597B3
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 15:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C0EE164399
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 13:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDC32D9EEA;
	Tue, 16 Sep 2025 13:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="dvnnIlki"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BE921CC4D;
	Tue, 16 Sep 2025 13:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758029557; cv=none; b=O07NCkCg5n4sDYRRQk2ht1nvlzpOlOc+SPTldNXrj05EZZl76SPbDCtiaEYVDtNZwCbphf+diUTtjq9f48R8fqFoPexUN6jxGyZKN40yPn2Zba0XLEAbSVBQG4jihEffAlp7IfhFDaaXzcCA2DxIxa5boTmRnTmnsdzt1kcPN8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758029557; c=relaxed/simple;
	bh=deX/rVBPdegf69NRE/QTcz9qXpuXvCrt/VgQVjcOjaU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nVPqPyXA924h5O+5foSzizfsL46PQo+DPZhhb6YhLHCWtts/z9s/XLcqsr5YUuLmDz6O7I8PalMH8KiXuLYgisF2EY7mntE9WtO5n4dyU+i5F/zLhP02i1cSPNwmtvOqMuNQnDBGSLpIfP6cSoz79LNem3bpLJWPQ1tpUFXUdoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=dvnnIlki; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G4VDFA007140;
	Tue, 16 Sep 2025 06:32:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=n6cisBj2p2xn0aKmABWIf0u
	3dHDp6nt/8KtXwp/QwkI=; b=dvnnIlkinX6KXODabc2/r5yRA1g292h8Pk5j8uI
	5KbtNApbDD77Jm1gQssP0d7PGUJRPA4xg4ISz9l5mQLvVkZRQSC/ZL8xBjHoMwXB
	A7CrHY9wUYs6lFleaxTd+Yg15PNQYTk6mRPo5+1jvTBHRoaIIOSr0v7DMhXTj2mh
	xEUIm9jsjxTxdL8QgraurUX1fDldnJEIznPEyRNeAl70S58DKQu7PXTPD6i2oxY3
	dBgp1k9szHW8Y4h1GhtEliPKGuNinNHZ6JuL27o4HeKiUXunzXgWNXIDXup75yZw
	7b/9cFeaD7IBRFTvRe94nlZ8cvauyHijRWSkkfIv8jnw1Qg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 496vgphdv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 06:32:14 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 16 Sep 2025 06:32:20 -0700
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 16 Sep 2025 06:32:12 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 16 Sep 2025 06:32:12 -0700
Received: from sburla-PowerEdge-T630.sclab.marvell.com (unknown [10.106.27.217])
	by maili.marvell.com (Postfix) with ESMTP id 3023A3F7045;
	Tue, 16 Sep 2025 06:32:12 -0700 (PDT)
From: Sathesh B Edara <sedara@marvell.com>
To: <linux-kernel@vger.kernel.org>, <sburla@marvell.com>, <vburru@marvell.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>, <hgani@marvell.com>,
        <andrew@lunn.ch>, <srasheed@marvell.com>
CC: <sedara@marvell.com>
Subject: [net PATCH v2] octeon_ep: fix VF MAC address lifecycle handling
Date: Tue, 16 Sep 2025 06:32:07 -0700
Message-ID: <20250916133207.21737-1-sedara@marvell.com>
X-Mailer: git-send-email 2.36.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Sen3duRu c=1 sm=1 tr=0 ts=68c966de cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=yJojWOMRYYMA:10 a=M5GUcnROAAAA:8 a=RNbTXI68HHUJU8bo58UA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: R0DTh89jvXZ2uOnZSjxjffdtGTCRPYPv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDIyMCBTYWx0ZWRfX31/8vjo6xSc+ bcEX1n5+sIeUAcwli/TOrEB1yWAKYWXXNX9ilsPgvrNv5dWtHLwPoIfElFu91Zm77FlsW25d9Fn KEmv/SUFszPAAN7Ip3OM34IjRFgYT6pnD2BF51ILbvtw81e6ve59/t9cPpin+nd7y5Xua2QMocz
 TZcWni5466cdqbREZKTpHCOuEsZpO/+Z2y5cs+aAT6wHEPRH+HywhI6HmVYkcN8AZn5B4k3IFK1 U7Vkrs5GthXIQq6bzus/i+RqxdmQsAOVBQX9MIBK0KYGMqXhGDqBGsUb23RUHUmfTFx99ROxm+Q T4AZY4BmE3J5bh17aXFG9IOrNSDKo1/I3AREOpIp3YUrxPdadUZ9XaK3Vkq+eC8Mp/N/nes13SB 7c2AQfra
X-Proofpoint-ORIG-GUID: R0DTh89jvXZ2uOnZSjxjffdtGTCRPYPv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01

Currently, VF MAC address info is not updated when the MAC address is
configured from VF, and it is not cleared when the VF is removed. This
leads to stale or missing MAC information in the PF, which may cause
incorrect state tracking or inconsistencies when VFs are hot-plugged
or reassigned.

Fix this by:
 - storing the VF MAC address in the PF when it is set from VF
 - clearing the stored VF MAC address when the VF is removed

This ensures that the PF always has correct VF MAC state.

Fixes: cde29af9e68e ("octeon_ep: add PF-VF mailbox communication")
Signed-off-by: Sathesh B Edara <sedara@marvell.com>
---
Changes:
V2:
  - Commit header format corrected.

 drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
index ebecdd29f3bd..0867fab61b19 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
@@ -196,6 +196,7 @@ static void octep_pfvf_get_mac_addr(struct octep_device *oct,  u32 vf_id,
 			vf_id);
 		return;
 	}
+	ether_addr_copy(oct->vf_info[vf_id].mac_addr, rsp->s_set_mac.mac_addr);
 	rsp->s_set_mac.type = OCTEP_PFVF_MBOX_TYPE_RSP_ACK;
 }
 
@@ -205,6 +206,8 @@ static void octep_pfvf_dev_remove(struct octep_device *oct,  u32 vf_id,
 {
 	int err;
 
+	/* Reset VF-specific information maintained by the PF */
+	memset(&oct->vf_info[vf_id], 0, sizeof(struct octep_pfvf_info));
 	err = octep_ctrl_net_dev_remove(oct, vf_id);
 	if (err) {
 		rsp->s.type = OCTEP_PFVF_MBOX_TYPE_RSP_NACK;
-- 
2.36.0


