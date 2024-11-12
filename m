Return-Path: <netdev+bounces-144056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A81769C5792
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 13:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AED62B474BC
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 11:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55885230983;
	Tue, 12 Nov 2024 11:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="innycBL3"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ACB230981
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 11:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731409590; cv=none; b=VHo29BZSneT8fm7Veye79YT0CE0S6nukEJN+JzamWeeTAnHBCiQ5CIH6F/+hfBiLwYQ9REPLJtRcjN9MMEtmV1rBiokROnU9T0rrCvTt3aWQQEY+DKwvOyFKPzZWkcK3PdQHgLheimzQRQqw9atXd0uat6a6BKygVYFiOZ45CQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731409590; c=relaxed/simple;
	bh=nmBc1paTAdIIY8F0RiybLycXRApPl8Ogge7DpSO4/Ew=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a1GtfC1LiOJDMoa2IYjWKygRhlAPv61Va96Az7en0AzQ+aDXNReROuasp4TIjfU9xnav8s2CRVTth3C1TxSwCMjavpozjvSVveVuE4whGngt95152xwmbjM8YQURfBETgsn+kfUw1SJAMtvE8LxaKDJUXOHnBERnHq5hO/xFv5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=innycBL3; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 4AC8hOTq005316;
	Tue, 12 Nov 2024 03:06:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=uHsDP+sbpuBI/ZID7Q
	UKNvkeJ6eArH/mrecB/O27kg4=; b=innycBL3uqcJiqjyhHpG/Z6Ai70EI/FEWN
	rXlKsVScr18AxbvuZ0Wa01E7m3NLPd7wg6E6PrwDnc42HUUZ6MlWRtFgFKpaF+e3
	LsmRMlzQjAvWoZAhVKlGH7XFCMMT3k89UFL8a/C/FYTzzx9hIwIIwqjAdaGnXmOV
	1rq+YoHG6S2u9rgmmr7m25lsLRPEMIPfANK3/irqrtkNwDEq1hUoyks2XQ+Z6cuI
	i/Xc/fDzox3KShcNSmWS7G34BtdoENf9OBsTBdyTod6G7eF0owNM7Zle7qS4Q9rP
	l7hrkgLdC18ZZl1IZ4qgQy3jjhpzrzO86AF9dAzqJrJBpRD8cvig==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 42v3rjrnxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 12 Nov 2024 03:06:11 -0800 (PST)
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server id
 15.2.1544.11; Tue, 12 Nov 2024 11:05:42 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Pavan Chebbi
	<pavan.chebbi@broadcom.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni
	<pabeni@redhat.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Jakub Kicinski
	<kuba@kernel.org>
CC: Richard Cochran <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Vadim Fedorenko <vadfed@meta.com>,
        Simon Horman <horms@kernel.org>
Subject: [PATCH net-next] bnxt_en: optimize gettimex64
Date: Tue, 12 Nov 2024 03:05:22 -0800
Message-ID: <20241112110522.141924-1-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 5fwdvibUc_P0_dDMl9qo---N6Fv1OjJB
X-Proofpoint-ORIG-GUID: 5fwdvibUc_P0_dDMl9qo---N6Fv1OjJB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

Current implementation of gettimex64() makes at least 3 PCIe reads to
get current PHC time. It takes at least 2.2us to get this value back to
userspace. At the same time there is cached value of upper bits of PHC
available for packet timestamps already. This patch reuses cached value
to speed up reading of PHC time.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
I did some benchmarks on host with Broadcom Thor NIC trying to build
histogram of time spent to call clock_gettime() to query PTP device
over million iterations.
With current implementation the result is (long tail is cut):

2200ns: 902624
2300ns: 87404
2400ns: 4025
2500ns: 1307
2600ns: 581
2700ns: 261
2800ns: 104
2900ns: 36
3000ns: 32
3100ns: 24
3200ns: 16
3300ns: 29
3400ns: 29
3500ns: 23

Optimized version on the very same machine and NIC gives next values:

900ns: 865436
1000ns: 128630
1100ns: 2671
1200ns: 727
1300ns: 397
1400ns: 178
1500ns: 92
1600ns: 16
1700ns: 15
1800ns: 11
1900ns: 6
2000ns: 20
2100ns: 11

That means pct(99) improved from 2300ns to 1000ns.
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 32 +++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index 91e7e08fabb1..8764ce412f7b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -112,6 +112,28 @@ static int bnxt_refclk_read(struct bnxt *bp, struct ptp_system_timestamp *sts,
 	return rc;
 }
 
+static int bnxt_refclk_read_low(struct bnxt *bp, struct ptp_system_timestamp *sts,
+				u32 *low)
+{
+	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
+	unsigned long flags;
+
+	/* We have to serialize reg access and FW reset */
+	read_seqlock_excl_irqsave(&ptp->ptp_lock, flags);
+
+	if (test_bit(BNXT_STATE_IN_FW_RESET, &bp->state)) {
+		read_sequnlock_excl_irqrestore(&ptp->ptp_lock, flags);
+		return -EIO;
+	}
+
+	ptp_read_system_prets(sts);
+	*low = readl(bp->bar0 + ptp->refclk_mapped_regs[0]);
+	ptp_read_system_postts(sts);
+
+	read_sequnlock_excl_irqrestore(&ptp->ptp_lock, flags);
+	return 0;
+}
+
 static void bnxt_ptp_get_current_time(struct bnxt *bp)
 {
 	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
@@ -162,13 +184,19 @@ static int bnxt_ptp_gettimex(struct ptp_clock_info *ptp_info,
 {
 	struct bnxt_ptp_cfg *ptp = container_of(ptp_info, struct bnxt_ptp_cfg,
 						ptp_info);
-	u64 ns, cycles;
+	u64 ns, cycles, time;
+	u32 low;
 	int rc;
 
-	rc = bnxt_refclk_read(ptp->bp, sts, &cycles);
+	rc = bnxt_refclk_read_low(ptp->bp, sts, &low);
 	if (rc)
 		return rc;
 
+	time = (u64)READ_ONCE(ptp->old_time) << BNXT_HI_TIMER_SHIFT;
+	cycles = (time & BNXT_HI_TIMER_MASK) | low;
+	if (low < (time & BNXT_LO_TIMER_MASK))
+		cycles += BNXT_LO_TIMER_MASK + 1;
+
 	ns = bnxt_timecounter_cyc2time(ptp, cycles);
 	*ts = ns_to_timespec64(ns);
 
-- 
2.43.5


