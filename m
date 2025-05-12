Return-Path: <netdev+bounces-189660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 163CBAB31E5
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 10:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EC2018831FA
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 08:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FD2259C8D;
	Mon, 12 May 2025 08:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="j6LH5J+W"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35AC2528F6
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 08:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747039352; cv=none; b=Q89ePRM0dWMrAKMwiIjquFMomHCH+ohaC7SVEYIqK9Oc8gByCpNcLcGQ7zX+uhEs/xqfggjyFrJRLJcjlBetwxhSY8I+b7lb+9QC732nerb21bFWe5cCZc5hFTP1vXsU1/Y/UHulqeQszBQXyGmMLfQ8XWDEbCXOPH3HRH1j25U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747039352; c=relaxed/simple;
	bh=YU9UnGndmCz0YXofEFz6I+80yJBcfOaaL3DD2BTaWZM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g0IUWRK246O2KHQ4hYM+3//3B2na/baMxpMaEd3Yd8qnZ/ifXnRGVed3gzfqpC4Ib2iSWPgxkZnmHVuWIV5p71EgDhLDOsb3xUkBwGAZ4ICUeTvdC6gT56f0aS2MbCG2eZh9vvf8U4n4z0IHVBNYU5GddphuIxRw0b1PHNbWcqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=j6LH5J+W; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54C5C3KN020008;
	Mon, 12 May 2025 01:42:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=c3VR9eREJWkHXFj9r+75/496J
	6LUjlFC+75HrXYY9Jc=; b=j6LH5J+WofUhR6x5olLYtBkyNCEDAJ+Jxde9eeaDI
	L1sG8i+/Ywex2fpF0Xg/QyksiGT2T8xc8FZduys0yE03G1CYKUblgRIEiNogfkEX
	rLGUuWExV/iY5NDGHAS1EGib1tK/jNlYHxQZa6+kVnMiSjZH4SDB/MEG2Kx0a/Ww
	nLSDjIlj3t6jCS4Zxj5CFY3bEjJLGlFJ5qAbxyroRJmaGoyt7bjiusYgO+ZRmjA9
	Qob9+e7/vlheHareexXtE3SFqeODoqsHFgRUXIB+iExN2PjZYtxV5QcK2davwt5B
	wY40a0ejN7IR1SUr7TkWNAFX93/l8ikfOaqiILV7OSxeQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46kamdg9jp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 01:42:19 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 12 May 2025 01:42:18 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 12 May 2025 01:42:18 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id DFBBF3F7097;
	Mon, 12 May 2025 01:42:13 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <bbhushan2@marvell.com>, <jerinj@marvell.com>
CC: <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next PATCH 2/4] octeontx2-af: Display names for CPT and UP messages
Date: Mon, 12 May 2025 14:11:52 +0530
Message-ID: <1747039315-3372-3-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1747039315-3372-1-git-send-email-sbhatta@marvell.com>
References: <1747039315-3372-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=DtpW+H/+ c=1 sm=1 tr=0 ts=6821b46b cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=TUI-8gK_6JqeD_B3SqwA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: sRcWaH6t6a5AKoH-CpuOSVAFMKlJMI3e
X-Proofpoint-ORIG-GUID: sRcWaH6t6a5AKoH-CpuOSVAFMKlJMI3e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDA5MSBTYWx0ZWRfX0dTZh8CCymJk BuptxfWIkVK6r8j+FB1wR9v6GOwNpyA+Yndr5hSX/IFM2sHI5PyTtJQtuDA+9FRNqme+496qdIL ZxhVFqxFKriSPSJsbWgWrkCRE5a4IN3F0zpR/RElBjMZAqnwr9m5EIeOPGQ45cVLm765IUYWCpn
 dUYmvW0/JqQwX9GfXybr3Ihlp4I1hSyymV9JrRLpjLLDzUdYSFqxm2CD6Yr3kyAcsF5X1uw3c/9 LdzfJqlUt2xPlE4r1DhLeeh1Q5aovo+EDP2+JZktMfA9i7/H+AWEUunnED90MF8kttfa3Ngp+CI w/jwY3n7Bhs3cXjg+bPQPJXIhSAP7Z8igch9u+6KAv/Y/glB+5D8H+Lc5NeETSiAybCketAvhD+
 V4njGx0FGtLxWTnsc9Ij0eS9xhJUC5FDiCDOzAq8qtzedUt+Vy24RKq6lWA9msxeYS73oSWw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_03,2025-05-09_01,2025-02-21_01

Mailbox UP messages and CPT messages names are not being
displayed with their names in trace log files. Add those
messages too in otx2_mbox_id2name.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/mbox.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.c b/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
index 5547d20..5c457e4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
@@ -444,6 +444,14 @@ const char *otx2_mbox_id2name(u16 id)
 #define M(_name, _id, _1, _2, _3) case _id: return # _name;
 	MBOX_MESSAGES
 #undef M
+
+#define M(_name, _id, _1, _2, _3) case _id: return # _name;
+	MBOX_UP_CGX_MESSAGES
+#undef M
+
+#define M(_name, _id, _1, _2, _3) case _id: return # _name;
+	MBOX_UP_CPT_MESSAGES
+#undef M
 	default:
 		return "INVALID ID";
 	}
-- 
2.7.4


