Return-Path: <netdev+bounces-146829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D09C9D621C
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 17:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C541D28161E
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 16:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7321E00B3;
	Fri, 22 Nov 2024 16:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="YkVI2maM"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D215D1DF249;
	Fri, 22 Nov 2024 16:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292468; cv=none; b=e/4F1j345rjbHOf5LU/C5hfCbCOJYWjpRfjKhIw1v9B6I4AOQzLbAu/ktwuS8FmxaBerM9b1RNLzOqRVz8qluk5COFXKbj683e1g/Ql2/mvvbH8VNgyOvHadxBANtX0ADRWDeSi40WUiXH8CelUIe4PFQqShvub3XzCQVPnjNbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292468; c=relaxed/simple;
	bh=WQWyYKsarxHszR8geMSVklkb24WyxXeoYLNInORqlk0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nLYvsngnNA9Ky24PJU764oYgBsPWco1DQ5Jv6+24Y2cvwKMOWI6vmMST2VFXZ9VzFbSm19ChkQPvO2UPHBbStUVAMeh3wNqrBnPLUEqZaFzHZJgJdmpbV3ejeKow5lXjcDubaN3rGY8sU/YJT4A3FZBzZ//7rOHMu+KjV2MzkXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=YkVI2maM; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMEUwAk021124;
	Fri, 22 Nov 2024 08:20:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=PjkAHWVtGKdvtxpclvbyIFu2w
	wwLueqWwVX5ObfgF6A=; b=YkVI2maMjP+5/cgk34HC0qBO79NHEsitGjs+wJE+x
	cbHhLBjmfLxKQQ4jpa3PCYLSjqraYPrjvPIzJC3CmiOPi23tndMbH21DAE/EtIWG
	Nu8ai/RYETrOEPQ/q9vwfHFcdGHnvtX/dnHpTB4h5zoV0g3Xuokm71gUl1cJvVQY
	bRtS8llcn510z3nUv3JW4ECGKgHWzm9UxK1LYZcQUFKBzQ2q8K2UaXmsNcsC8UYf
	ESP5+wu2zeVGLytMwZ70/58vu78MByOS6YzunTg6Ck0MDsZsS1+c7v/pM7Vz9k00
	76K1dzD5ajMvxZWLN6DZiALs2CyexopDgM53lBUBWJQ2Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 432tdwgfwx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 08:20:47 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 22 Nov 2024 08:20:46 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 22 Nov 2024 08:20:46 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 9E8F53F7080;
	Fri, 22 Nov 2024 08:20:41 -0800 (PST)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>
Subject: [net 1/5] octeontx2-af: RPM: Fix mismatch in lmac type
Date: Fri, 22 Nov 2024 21:50:31 +0530
Message-ID: <20241122162035.5842-2-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241122162035.5842-1-hkelam@marvell.com>
References: <20241122162035.5842-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: xwWc3yWJbcLe9M_22uIg78KXlOSbVJo0
X-Proofpoint-GUID: xwWc3yWJbcLe9M_22uIg78KXlOSbVJo0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Due to a bug in the previous patch, there is a mismatch
between the lmac type reported by the driver and the actual
hardware configuration.

Fixes: 3ad3f8f93c81 ("octeontx2-af: cn10k: MAC internal loopback support")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
index 1b34cf9c9703..9e8c5e4389f8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
@@ -467,7 +467,7 @@ u8 rpm_get_lmac_type(void *rpmd, int lmac_id)
 	int err;
 
 	req = FIELD_SET(CMDREG_ID, CGX_CMD_GET_LINK_STS, req);
-	err = cgx_fwi_cmd_generic(req, &resp, rpm, 0);
+	err = cgx_fwi_cmd_generic(req, &resp, rpm, lmac_id);
 	if (!err)
 		return FIELD_GET(RESP_LINKSTAT_LMAC_TYPE, resp);
 	return err;
-- 
2.34.1


