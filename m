Return-Path: <netdev+bounces-108058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6DF91DB1A
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 11:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CABE728505F
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 09:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D5C13C3D5;
	Mon,  1 Jul 2024 09:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="eGWZdQuC"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D3513AD22;
	Mon,  1 Jul 2024 09:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719824904; cv=none; b=QIUhmZp9Ljiz+u2Y7+LXTO6yyHeaUv1q2m105IdrfWWfr4z6aX33V/WphxuClLzuFU6dsM/xNYoVjN4kEdQuD2vD5Qu0Uo1rJeNGviAMFIowGlOcaBLEo+eND+xYeqjau1ZUtyzfuvhJ8Y/D19U0NuaK7wGWUU3p2ZSfcOYo5sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719824904; c=relaxed/simple;
	bh=jeUQ0yIq7XMucqUDMuSJEaD1CvMB//lfRmjQgfyIuJY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AsR3rZKcZ+aP4OOuVL2KTM7/B2eHuBtd2RPe+JgnRW/Noh7DFOQyrWX+QB4NHzJfAfw/+MLKlEQEzKOK1X/c9KZNsruf+QJLZVNe8cjJP46n6yDAM2VItBboAD14is8OE0thWPLjKmhaHsRpd5NvGZchOcLxvJL6Spf6TnnU5wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=eGWZdQuC; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461935LW011471;
	Mon, 1 Jul 2024 02:08:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=r
	LPeCHPva5xdjbFodgCApPwJQrkYa21owH/9isfRLMU=; b=eGWZdQuCACYT6tnaj
	Jp4mflaAZ/rhptF0C9E0RHacOCx58l6PTWmTlLXQos0CuEabqFJqcLYKwvD5V+NY
	B/XgiiPGapv3QzNOU/n0yvX+oL5xOKjJE+XqVxajVDJisWQ3+jyoQ5t5JlyL7sa3
	NHcY1p0MXDbpYpjlDONK1onfes7rESHuQojL937TgYR9wT5PFKH0ni9Lo7zKxQUT
	6cIt+iU/8RkVYeerEVSqZedfeKgmhhWJJL2ycN3svLSd5AdgK0he+/5oJoC9QeAQ
	P8Vs1Z9MAddt5GjAHrDjHIwym76JnbJjSGz4tCRtotmERlULhslFGIslkRIQGBUm
	tkd9g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 403207k45t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 02:08:05 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 1 Jul 2024 02:08:04 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 1 Jul 2024 02:08:04 -0700
Received: from localhost.localdomain (unknown [10.28.36.175])
	by maili.marvell.com (Postfix) with ESMTP id CDBF83F7044;
	Mon,  1 Jul 2024 02:08:00 -0700 (PDT)
From: Srujana Challa <schalla@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <sgoutham@marvell.com>, <lcherian@marvell.com>, <gakula@marvell.com>,
        <jerinj@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>,
        <schalla@marvell.com>
Subject: [PATCH net,3/6] Fix CPT_LF_ALLOC mailbox error due to incompatible mailbox message format
Date: Mon, 1 Jul 2024 14:37:43 +0530
Message-ID: <20240701090746.2171565-4-schalla@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240701090746.2171565-1-schalla@marvell.com>
References: <20240701090746.2171565-1-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: blQymByXfdP4tOikT9NY7Uszv2KDvmcj
X-Proofpoint-GUID: blQymByXfdP4tOikT9NY7Uszv2KDvmcj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_07,2024-06-28_01,2024-05-17_01

This patch addresses the issue introduced by commit de2854c87c64
("octeontx2-af: Mailbox changes for 98xx CPT block"). Specifically, it
corrects the `blkaddr` field type from `int` to `u8`.

Signed-off-by: Srujana Challa <schalla@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 41b46724cb3d..799aa54103a2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1745,7 +1745,7 @@ struct cpt_lf_alloc_req_msg {
 	u16 nix_pf_func;
 	u16 sso_pf_func;
 	u16 eng_grpmsk;
-	int blkaddr;
+	u8 blkaddr;
 	u8 ctx_ilen_valid : 1;
 	u8 ctx_ilen : 7;
 };
-- 
2.25.1


