Return-Path: <netdev+bounces-109405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B06B92863B
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 11:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBBBF1C21471
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 09:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE96D1482F3;
	Fri,  5 Jul 2024 09:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="M0q9qHrH"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1F1147C76;
	Fri,  5 Jul 2024 09:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720173333; cv=none; b=ro/LZWucG1PYZco3fzQhGi4IlDrLopPq5RbVaCQW5JNQkEwu91LDEdIJPVxsbsh3npnIUX6KLoF+xazC1uufC00bHW5K947srhWMqiULTrTMzSFXquQdzRKE6YpSNYvnpvJa4zuWgBuWOm/uHPe5e68vLorses+Yb86uVOHnnkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720173333; c=relaxed/simple;
	bh=Yho17kScQAH4kxO+Iyzl0TcHqzGMqYsT+gGg1+0OAwY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A9d+ZfG3IdidRhyXPysUso+VEUXM379f+rhEpS5bzJfEqVesZWh0mc/NXm2yV+sehSK+EnubfIZaRTYwnRECarDE/AcX528vQ/KW3tBBfv3wULnCsg5wJYIDeHmbE8ybHFl7kIMo/T05h9NVzflw/XYbxN1w0e8ScEwJLvZz/7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=M0q9qHrH; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 6B505100004;
	Fri,  5 Jul 2024 12:55:06 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1720173306; bh=9spCCaZBRNUk30iyOOynqh1AiXgGYZ5RAnraipmqhPM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=M0q9qHrHKuYcclmNyUIbV2EfxcREEr10gk+a9mb2573YLZw/RdY+FyPbB4INTJiac
	 Hr2INKNAQ4M6D4kOpwlttKOBS3zSiLwPCt6Odhk49Q0TftCkfkXFIW+3x8exS6Y4//
	 Mqf7PAvXsWoYg3X/NEzbEWDLqx2J8SJKYw1DIfQjPDXYgtrrN3Jcx0o+TD1FC2+NAy
	 52YsLkQq2ouAUXk9D9umAb+hp6rNOJN6/66LkXvWpXD+f68RuZrq0pVBST9Ja/nKON
	 y62VEZrDRNHNVqAFHtG9yh/1tyOPU5cxTtUUe/qiElyYrA0A+gf1kH93GHqrGBo0B1
	 st+0g5ozVwYqg==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Fri,  5 Jul 2024 12:53:49 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.5) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 5 Jul 2024
 12:53:30 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Sunil Goutham <sgoutham@marvell.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Linu Cherian
	<lcherian@marvell.com>, Geetha sowjanya <gakula@marvell.com>, Jerin Jacob
	<jerinj@marvell.com>, hariprasad <hkelam@marvell.com>, Subbaraya Sundeep
	<sbhatta@marvell.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH net] octeontx2-af: Fix incorrect value output on error path in rvu_check_rsrc_availability()
Date: Fri, 5 Jul 2024 12:53:17 +0300
Message-ID: <20240705095317.12640-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186342 [Jul 05 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 21 0.3.21 ebee5449fc125b2da45f1a6a6bc2c5c0c3ad0e05, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;t-argos.ru:7.1.1;mx1.t-argos.ru.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/07/05 09:22:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/07/05 03:12:00 #25860202
X-KSMG-AntiVirus-Status: Clean, skipped

In rvu_check_rsrc_availability() in case of invalid SSOW req, an incorrect
data is printed to error log. 'req->sso' value is printed instead of
'req->ssow'. Looks like "copy-paste" mistake.

Fix this mistake by replacing 'req->sso' with 'req->ssow'.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 746ea74241fa ("octeontx2-af: Add RVU block LF provisioning support")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index ff78251f92d4..5f661e67ccbc 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -1643,7 +1643,7 @@ static int rvu_check_rsrc_availability(struct rvu *rvu,
 		if (req->ssow > block->lf.max) {
 			dev_err(&rvu->pdev->dev,
 				"Func 0x%x: Invalid SSOW req, %d > max %d\n",
-				 pcifunc, req->sso, block->lf.max);
+				 pcifunc, req->ssow, block->lf.max);
 			return -EINVAL;
 		}
 		mappedlfs = rvu_get_rsrc_mapcount(pfvf, block->addr);
-- 
2.30.2


