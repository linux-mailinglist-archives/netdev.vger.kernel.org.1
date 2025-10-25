Return-Path: <netdev+bounces-232805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 51732C08F33
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 12:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6939B4EA215
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 10:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E202F39BF;
	Sat, 25 Oct 2025 10:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="JiSxZ/42"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E88E1E1C1A
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 10:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761388449; cv=none; b=XAOJpcssvYFbOHxtNxzz6QvpictvsAKd/sC/h4A6zrf8w00O78zNt0LAVs58J3bd1ar5QBP2gC/V8Frz3DrlbmpVE9v5nWWirL2joxc+kUuOcttvkpNm3cKkoPb7GjxIpy8FZTmskAkMWUTPbG9RdR66xGMIaEbg0Q5Is2hiJpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761388449; c=relaxed/simple;
	bh=mNqsuT+SyN22s8Q6ECsHpCR56ShKH7n6HvF7Bj0JNk0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E2gV832gEf5VWKz37dxqliCK1Vgpte/3EeWoG8Qe15ZIk2PQTeg/r9YF+dI1uSxfodjApJCs/ZB0O+ietCliJ3+LNhC8W2aB/Sw4voZ4wPaX3R9yeMFVoHC2q24Gaei5h+ZXQliF3PaBPoB+PGu6y8YS3IUV4WE+D3pUXc/G6Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=JiSxZ/42; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59P9vhX5848863;
	Sat, 25 Oct 2025 03:34:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=CyRyW9Sw9LaZip5lNTKvYaUYy
	IjqaJ2BOqsGtzBugWs=; b=JiSxZ/42aCzoA6vvvu1ferEa94nn0S5iFLp82edlF
	UOuLkcCeSRh2WgJZWXiL4xEFS7GeY5xXqDPyeW3Yngz5UQ/yQdNG+gKq7qUJ1/cd
	8XrqToE7DUZ/ass0NOkoP6HPbd7x+ZFhORZA6dBqyHJwQEYf8Rqb2DWZnENRiBSs
	CXGJjHzFPRbdnWVWyf/rgvZuc9b77jmRKA6CNvGt//NmF70k5a9nvo9dVvGMfHfm
	QHi49r5yIiNQY9V8o8+IEnGDwEx7gVP1/OATM5vde9ejEerv5FQfWh0TRnlCaZeP
	TPmAIBmTk6VdPZjoNDwa+imXHdxOSiv7deTA8h0+7KSDw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4a0nm3rk0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Oct 2025 03:34:00 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sat, 25 Oct 2025 03:34:12 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sat, 25 Oct 2025 03:34:12 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 1A2225B6921;
	Sat, 25 Oct 2025 03:33:54 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <bbhushan2@marvell.com>,
        <jerinj@marvell.com>, <lcherian@marvell.com>, <sgoutham@marvell.com>,
        <saikrishnag@marvell.com>, <netdev@vger.kernel.org>,
        Subbaraya Sundeep
	<sbhatta@marvell.com>
Subject: [net-next v4 10/11] octeontx2-af: Display new bandwidth profiles too in debugfs
Date: Sat, 25 Oct 2025 16:02:46 +0530
Message-ID: <1761388367-16579-11-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1761388367-16579-1-git-send-email-sbhatta@marvell.com>
References: <1761388367-16579-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: aB6STyravOfmkD5khsHNBp4vDm8GDRr2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDA5NSBTYWx0ZWRfXyDfI7Zl4pzSp
 V8Z7QLHnkp+/uUOwZ72x5+3UxZCKlLRLyQNnGM+miGlNql2c0UwF/8yItn4w++rHnPY/S/aQbUU
 1Pu5t4f3c3tMOlivmzkOfZZC9LLjUl1qUz/tMCGAJzYtiaQcSb9X8S2AZpKLt2jrcnYAjRYfa7E
 9rDSDngQBFeic5lQU0tqiJrqWEQFeg5LEZzrG6x6Bbq2jyNr2CuubJebdHyQOB9k8xOC2ivmtbQ
 AunXmDpLcE8tQtksAKMl16L45qkB0bfc8ZaL2JFZ+1Q0V486ZrTJq7hzS8RjYmwND4kDR2SwWfU
 N7poR9dcItJcdvKYHTnplWu6S+Iq/mPL1hjTZRDae8PvGQi4YgWjI9Gy9X4wcUmH7FhbQIV/4Bh
 757FHwqvjAYZrOX5STOUusUUb9SdMw==
X-Proofpoint-ORIG-GUID: aB6STyravOfmkD5khsHNBp4vDm8GDRr2
X-Authority-Analysis: v=2.4 cv=bpJBxUai c=1 sm=1 tr=0 ts=68fca798 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=RZIP-wGVsQArKk7uDzMA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-25_03,2025-10-22_01,2025-03-28_01

Consider the new profiles of cn20k too while displaying
bandwidth profile contexts in debugfs.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index 8ab82700e826..7370812ece2a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -2121,7 +2121,9 @@ static void print_nix_cn10k_rq_ctx(struct seq_file *m,
 	seq_printf(m, "W1: ipsecd_drop_ena \t\t%d\nW1: chi_ena \t\t\t%d\n\n",
 		   rq_ctx->ipsecd_drop_ena, rq_ctx->chi_ena);
 
-	seq_printf(m, "W2: band_prof_id \t\t%d\n", rq_ctx->band_prof_id);
+	seq_printf(m, "W2: band_prof_id \t\t%d\n",
+		   (u16)rq_ctx->band_prof_id_h << 10 | rq_ctx->band_prof_id);
+
 	seq_printf(m, "W2: policer_ena \t\t%d\n", rq_ctx->policer_ena);
 	seq_printf(m, "W2: spb_sizem1 \t\t\t%d\n", rq_ctx->spb_sizem1);
 	seq_printf(m, "W2: wqe_skip \t\t\t%d\nW2: sqb_ena \t\t\t%d\n",
@@ -2639,7 +2641,10 @@ static void print_band_prof_ctx(struct seq_file *m,
 		(prof->rc_action == 1) ? "DROP" : "RED";
 	seq_printf(m, "W1: rc_action\t\t%s\n", str);
 	seq_printf(m, "W1: meter_algo\t\t%d\n", prof->meter_algo);
-	seq_printf(m, "W1: band_prof_id\t%d\n", prof->band_prof_id);
+
+	seq_printf(m, "W1: band_prof_id\t%d\n",
+		   (u16)prof->band_prof_id_h << 7 | prof->band_prof_id);
+
 	seq_printf(m, "W1: hl_en\t\t%d\n", prof->hl_en);
 
 	seq_printf(m, "W2: ts\t\t\t%lld\n", (u64)prof->ts);
-- 
2.48.1


