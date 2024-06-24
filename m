Return-Path: <netdev+bounces-106055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E5A914797
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 12:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E41B9286505
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 10:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FAA13790F;
	Mon, 24 Jun 2024 10:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="XlJoRFfR"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9A0136E37;
	Mon, 24 Jun 2024 10:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719225434; cv=none; b=X3FQkSFxdKm4OUoVB34lenWE6i27f3ws9Llt7aGUauV+TvHZ9a3EbA1fyNs7A0W0z9fRNfNt9c1zH0szh/NnMHit9WS2uUOB/x4ren8aNyYaD+qU99OivtIOpm0KLsFlQiA5nw2PY+xUzMJZXFtVeUnknmZgg/lvcs+2ZlFkFqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719225434; c=relaxed/simple;
	bh=dQcdSlxpKLY+y897vmkaShCjcvUMY+dpA0tM7AdUIRo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qAVhpb7069fyWF3T6xp1gqsbwvjGvhV6nW6hTCBcCLbbi5Ry+rVRKGBy9py66bguLZtmXzX7CBpZPxjZzp0hK9ZXTbCg0ib8btTipndLaq0jjyXlxwwThvcTdvlQKJGSvakP3V6JnL+DYEolza/jh4Ovg7550SBHix9ZoG1ghLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=XlJoRFfR; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OARFoU022085;
	Mon, 24 Jun 2024 03:37:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=g
	AdVWYQGoDIqNPsUw4kGFc4CtLjDM/XRaOmB73haOw4=; b=XlJoRFfRaagsfowgs
	bQCRt+Q81TF77i6n627/uaOI2gy4/CrFvCAiJVAtpAV1WZBkwo3vpbXQEvUfsSK5
	cxRb8y6ujVnJEEuUB+E1BjmEa8RhQ0cw1DgHlKP70qw86LKLeqPfP+2zn6AFX8Dl
	oZFOnRxL6J8g1l7tmtntlcmsg03ejPHqWDdF3WcuTXZgVWgpQCqgL8PivUMhE1i3
	aOHEzeP0g0LJyAkPyvF0Zw6dO+Zy89vRSzFUTuj4lItie9UH9WIenZBda9RJgNon
	LLCh4xVM5JzXEJ7SeUUdiee6qjgDzJ7e649JZDiJ87s9vorlqZK/VhE/3pf6QtHH
	PM7Mw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yy72f00t8-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 03:37:07 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Jun 2024 03:37:07 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 24 Jun 2024 03:37:07 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id C2ED33F7079;
	Mon, 24 Jun 2024 03:37:02 -0700 (PDT)
From: Suman Ghosh <sumang@marvell.com>
To: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lcherian@marvell.com>,
        <jerinj@marvell.com>, <markus.elfring@web.de>
CC: Suman Ghosh <sumang@marvell.com>
Subject: [net PATCH 4/7] octeontx2-af: Fixes klockwork issues in rvu_cpt.c
Date: Mon, 24 Jun 2024 16:06:35 +0530
Message-ID: <20240624103638.2087821-5-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240624103638.2087821-1-sumang@marvell.com>
References: <20240624103638.2087821-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 1ZIU5weHXxWyGv8ZtgL1lZuO2ZE9bxma
X-Proofpoint-GUID: 1ZIU5weHXxWyGv8ZtgL1lZuO2ZE9bxma
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_09,2024-06-24_01,2024-05-17_01

These are not real issues but sanity checks.

Fixes: 4826090719d4 ("octeontx2-af: Enable CPT HW interrupts")
Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
index f047185f38e0..a1a919fcda47 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
@@ -43,7 +43,7 @@ static irqreturn_t cpt_af_flt_intr_handler(int vec, void *ptr)
 	struct rvu *rvu = block->rvu;
 	int blkaddr = block->addr;
 	u64 reg, val;
-	int i, eng;
+	int i, eng = 0;
 	u8 grp;
 
 	reg = rvu_read64(rvu, blkaddr, CPT_AF_FLTX_INT(vec));
-- 
2.25.1


