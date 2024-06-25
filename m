Return-Path: <netdev+bounces-106611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97795916F62
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 19:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51A6F2835B9
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 17:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF93178394;
	Tue, 25 Jun 2024 17:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="cUZKOmoj"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C865817838E;
	Tue, 25 Jun 2024 17:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336891; cv=none; b=HHOswfVvbN7C5Y2DsK5HIbUrqINBM4Q70rIpqcsorl+3rWsbfRMbe+QlvjnsYw3lgk1KUkblZognlw/IceXOiGHDFxK6eoGp8G4sjlmZjcxbUCcwNOdlAnArWAJcwg1PbWmT01GEBp45M+one0OdmxAzGxnFJd+k7l+syzKpDaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336891; c=relaxed/simple;
	bh=rXyeFlcUAQvcusm1isKCzLlJcBU8u/T8LnRE8Ytj0V0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GA6KYWNqS3G0KEW7ZAmRwaUWYwJxUiEC40368RsCZm4StfFfaB3LgZuOtOumtuXe7jAoS5QR/3iYKLlAOlv/ZYACUca+hNT23cSxZpyz1ECRNjU6QuMAEMJFsD9r2dKkorqyt74+b1WnzbwPc6mhYtXpQXhQNBcFTwI2s7U9KfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=cUZKOmoj; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PBssm7032688;
	Tue, 25 Jun 2024 10:34:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=+
	OHJdafb26V/u9gjT72eS17RRGNSNRVIos+oqvZgfXA=; b=cUZKOmojYNggpY+HV
	EJO4I+hwNf3Itkzc7dPa1RwWNW5AGN9heuO5nZEe4RTxDljQZQjBD0dq2O21+7k1
	wU8sZbBg6oVqD2s8KRU1JMVNHkEPrAfyQhmiHFpP2HoxiyERWYqoLhRdgE6Zi2yV
	VgV0tRtRyALvsxzOkqJ13zncM8IfkvVyhpVACEJQBxIiDwNo6M8dyoOOAQ32c6it
	qVPn7Myx7ZyY9kzWafqtzxJ8KG6952NoYQgNGwZ/PFL1YNRnSv/6x9Gay3L2i1/Y
	7WPt7GJMWSWKSS0PuoLlJWN1nPBzjW6YLknQ4v6uGhko3Sq90jJK4gq5ycmjtGZy
	By4WA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3yywec9kks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 10:34:44 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 25 Jun 2024 10:34:43 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 25 Jun 2024 10:34:43 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id 576273F7063;
	Tue, 25 Jun 2024 10:34:39 -0700 (PDT)
From: Suman Ghosh <sumang@marvell.com>
To: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lcherian@marvell.com>,
        <jerinj@marvell.com>, <markus.elfring@web.de>
CC: Suman Ghosh <sumang@marvell.com>
Subject: [net PATCH v2 7/7] octeontx2-af: Fix klockwork issue in rvu_npc.c
Date: Tue, 25 Jun 2024 23:03:50 +0530
Message-ID: <20240625173350.1181194-9-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240625173350.1181194-1-sumang@marvell.com>
References: <20240625173350.1181194-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: pJVykOLgFoj5ue05hbXFEKA-BOIJOJU-
X-Proofpoint-GUID: pJVykOLgFoj5ue05hbXFEKA-BOIJOJU-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_12,2024-06-25_01,2024-05-17_01

Set the pointer value to NULL after freeing to avoid wrong access.

Fixes: 5d16250b6059 ("octeontx2-af: load NPC profile via firmware database")
Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 97722ce8c4cb..a69438921a8e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -1765,6 +1765,7 @@ static void npc_load_kpu_profile(struct rvu *rvu)
 				rvu->kpu_prfl_addr = NULL;
 			} else {
 				kfree(rvu->kpu_fwdata);
+				rvu->kpu_fwdata = NULL;
 			}
 			rvu->kpu_fwdata = NULL;
 			rvu->kpu_fwdata_sz = 0;
-- 
2.25.1


