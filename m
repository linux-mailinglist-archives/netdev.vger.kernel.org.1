Return-Path: <netdev+bounces-216493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1131BB34234
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 15:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB67B4E3471
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 13:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE9E2F0C4D;
	Mon, 25 Aug 2025 13:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="kxVGwWCy"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176852F0C44;
	Mon, 25 Aug 2025 13:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756129721; cv=none; b=i90n4m9x0mUF9mnO7mLel0/sQus+HLJSGoYksXtkYlbZonF2cB+UXKc69u7DUhErxoBteOXRMhzzQf5xVg4JEKp2jNBdbHM82U1jjoKZtIyomt5Dy4tCn9cCmDr1ZQObGegYhLdWxaX+v0Ors0UeO5wzzm20m1Hb/xltW4RHFmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756129721; c=relaxed/simple;
	bh=debTZXkkIpj9zmW8PgTAccY0m2emTzb1QtwH00Px3r0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R3bbZfEfENJvq0/B60pkZtQqpAwhkwGBNDv18neREjFQW0Z21xlSSGwi87A92J76coKHJeuxxRx585JajvExH/gcFAcfacQ7P1w6+RKM/6//eIZ/onosrDiFCVUUkp5UsFd7YpcJY7mSDvyO1Edh/NGXhilMvICfCYcmC7xLvtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=kxVGwWCy; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PDm3nL021849;
	Mon, 25 Aug 2025 06:48:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=btcG3PoWQXAVDS5VoFlRoJV
	NVK/NQl6OsYRo9KlZmBY=; b=kxVGwWCy07G/8+B9yOJyDWNLEZXaufzXLwTPtVw
	f6yzli7frxbOcJtpm6NTluNv+nfRHcF3lcPbvNvzo3WJuZmpIOndUaSMF7VweDdq
	2lGC4m0EsHJ9Wy0EtHWpmW09h/IBu1aWmtjkIoFbJpevSvBHEOGQFqj1SZBU+z79
	DUGqF+UiTym2xrkUBM31Ls5+BgjlxET+388+GyX8vbxK64T5jVIg7+ucbnWHNDka
	o7S2AQJfjw0UqkrxvVmC0glSFMcVqYXxrA7cf9dLAeJk/oF5IGyYsiVCCO2wH2df
	W67bnGiY1qRWh+UdGC0gQUsVrnt82X0m0Nxy7Mn8ZbeSevA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 48rs1kr00g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Aug 2025 06:48:11 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 25 Aug 2025 06:48:09 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 25 Aug 2025 06:48:09 -0700
Received: from naveenm-PowerEdge-T630.marvell.com (unknown [10.29.37.44])
	by maili.marvell.com (Postfix) with ESMTP id 5985B3F7055;
	Mon, 25 Aug 2025 06:48:06 -0700 (PDT)
From: Naveen Mamindlapalli <naveenm@marvell.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>, <corbet@lwn.net>,
        <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Naveen Mamindlapalli <naveenm@marvell.com>
Subject: [PATCH net-next] docs: networking: clarify expectation of persistent stats
Date: Mon, 25 Aug 2025 19:17:55 +0530
Message-ID: <20250825134755.3468861-1-naveenm@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDEyNCBTYWx0ZWRfXzSKSk+jAVbOp nzoUNhZewD5twwTNOYrkKZk1Wr8H7cCJIIJAu4MjKol0IWohr1X7UVINbQu8pE4wvG1VhVpLe18 eMElFqwnOcmhlz4gVrCVz9+jD997KJQeC4aXangzxCcsIBCvHO30wsj5LLHbfOydk8CeuCcKkkA
 Y19pJti0VBYEKJjVDMMR0sGjYgTiDSUUmLG0/WIFLgdZF2zWaiazy81xBv1MEjs5QamweG8+3pI 3wsAjIR9KWrxPArGdVdI+SMl1/DhoBzTiVk/C4lSNtJNJIsVjzNmw1D9wyObbQhQpRqq5oFniQn e5tj2GW6JbMgIOIiDXdTJvpnaJMCo82veHXB2GwDzeVdlgC899EHakWOpRQG+nCitfQHVjH7vms
 VNZftndrpADf6WSHyiTQGMicZohcpuCuz2FkJBQlL/sIbcTRoFaIQoTD9r3GDrIcrjF5XGxo
X-Authority-Analysis: v=2.4 cv=Lf886ifi c=1 sm=1 tr=0 ts=68ac699b cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=2OwXVqhp2XgA:10 a=M5GUcnROAAAA:8 a=ztq4QwoSifUOyHU0YMQA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: PlkojfvPRGIC7xtThaC7Lhm3IHyfDX2W
X-Proofpoint-GUID: PlkojfvPRGIC7xtThaC7Lhm3IHyfDX2W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_06,2025-08-20_03,2025-03-28_01

This update clarifies the requirement for preserving statistics across
interface up/down cycles, noting that some drivers may not support this
due to inherent limitations. It also outlines the potential effects on
monitoring and observability tools.

Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
---
 Documentation/networking/statistics.rst | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/statistics.rst b/Documentation/networking/statistics.rst
index 518284e287b0..857b08d633f7 100644
--- a/Documentation/networking/statistics.rst
+++ b/Documentation/networking/statistics.rst
@@ -222,8 +222,18 @@ Retrieving ethtool statistics is a multi-syscall process, drivers are advised
 to keep the number of statistics constant to avoid race conditions with
 user space trying to read them.
 
-Statistics must persist across routine operations like bringing the interface
-down and up.
+Statistics are expected to persist across routine operations like bringing the
+interface down and up. This includes both standard interface statistics and
+driver-defined statistics reported via `ethtool -S`.
+
+However, this behavior is not always strictly followed, and some drivers do
+reset these counters to zero when the device is closed and reopened. This can
+lead to misinterpretation of network behavior by monitoring tools, such as
+SNMP, that expect monotonically increasing counters.
+
+Driver authors are expected to preserve statistics across interface down/up
+cycles to ensure consistent reporting and better integration with monitoring
+tools that consume these statistics.
 
 Kernel-internal data structures
 -------------------------------
-- 
2.34.1


