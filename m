Return-Path: <netdev+bounces-73710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8255585DFC3
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 15:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 084AA1F23A4E
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 14:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75E17F7DB;
	Wed, 21 Feb 2024 14:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qywF37CZ"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190F67F7D6
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 14:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708525970; cv=none; b=MpZMvHRWw9qQKYCcoc8/+kgoxmC2702lgC4apuB+jpHY59uw70BogADlwWYQe08Yr+dZjHDBzqX7hF7yJIzXXUdFRcemHYaQVmKd+xoHN5d+ocBGVD6ux33s1WM3e4uvBbKksdzqP1BhKfXANn8j8PTRn+25E7JN1/hswBPesLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708525970; c=relaxed/simple;
	bh=HTBdsUYgPTyvTc8rSTN1m17WO2v2rVbHMnytGc16Ur8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=prZ1aplzjtoH2YeMLAHsGL5eAaQO11yZgWcCFa7tBZsYHem8nH6F77lEr3xcvW6nbtosfr7rARCJ27Y+TBbFjR2qyYqmsrMc5tnp/oa16E107kvCMmpjXCiwcIVl7pWCP7tB1nGye/Wq47nSsCQtRV7OOaYIn9nIb7+Apxhc/r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=qywF37CZ; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240221143240euoutp019a541034520976dcd46062bc03754b6d~15079PR7O2771927719euoutp01Z
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 14:32:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240221143240euoutp019a541034520976dcd46062bc03754b6d~15079PR7O2771927719euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1708525960;
	bh=gJhzzTrdEP3uesqHQ/Y44omJiRTlA1MiG0Caetvk4Tc=;
	h=From:To:Cc:Subject:Date:References:From;
	b=qywF37CZdYLReyTKD0hIfJ/fmNtiVt4uofI+eD/ZROnkA2N3Y20XoNw9cxONdvVkS
	 H1kXFsMbIrVFVBXfzKDsv7fsqB2pdOh9MMT2b3gVpiFqj9RKmPK6yTXJvjEWGTKKpF
	 BQefEhJXwoe793ixL53dIt2zyBNTs8ElT0nVzdo0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240221143239eucas1p19a208e5bca36717582f9fadb83550f4e~1507us7BV3130331303eucas1p1D;
	Wed, 21 Feb 2024 14:32:39 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id BE.0A.09814.78906D56; Wed, 21
	Feb 2024 14:32:39 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240221143239eucas1p259ca215d24490cd7fc073a6c3c35693b~1507a_Fjb1862018620eucas1p2u;
	Wed, 21 Feb 2024 14:32:39 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240221143239eusmtrp29ee2a2c1dac9a48a52b8842cac03279f~1507ZrWUu2098720987eusmtrp2f;
	Wed, 21 Feb 2024 14:32:39 +0000 (GMT)
X-AuditID: cbfec7f4-727ff70000002656-85-65d60987da98
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 9B.74.09146.78906D56; Wed, 21
	Feb 2024 14:32:39 +0000 (GMT)
Received: from AMDC4622.eu.corp.samsungelectronics.net (unknown
	[106.120.250.240]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240221143239eusmtip2f1d01520c81e527bf79bd77bfb4dee6d~1507D-j9m2103721037eusmtip2H;
	Wed, 21 Feb 2024 14:32:39 +0000 (GMT)
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jakub Raczynski
	<j.raczynski@samsung.com>
Subject: [PATCH] stmmac: Clear variable when destroying workqueue
Date: Wed, 21 Feb 2024 15:32:33 +0100
Message-Id: <20240221143233.54350-1-j.raczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsWy7djPc7rtnNdSDR4u0rf4+XIao8Wao1uZ
	Le4tesdqcWyBmAOLx9P+rewefVtWMXps2f+Z0ePzJrkAligum5TUnMyy1CJ9uwSujN1v5jAV
	LOGr+PVkKWMDYydPFyMnh4SAicT5+TcZuxi5OIQEVjBKvFx5kQ3C+cIoce//VDaQKiGBz4wS
	H28ownR82HcaqmM5o8SxJ7uhOtqZJE7uWccKUsUmoC8xbVkDI4gtIiAl8XHHdvYuRg4OZoFk
	idMn9UHCwgKOEj9PTwIrYRFQleh51wXWyitgI9E4+wITxDJ5if0HzzJDxAUlTs58wgJiMwPF
	m7fOZgbZKyHwl13i7bdzzBANLhKvdy1mgbCFJV4d38IOYctI/N85H2povcTFA4eg7B5GiXM/
	jSBsa4m9B66wQtypKbF+lz6IKQF059LpzhAmn8SNt4IQF/BJTNo2nRkizCvR0SYEYapKtP0Q
	hxgnLTFt50WoNR4S884fgwZmrMSNlxOZJzAqzELy1iwkb81CuGABI/MqRvHU0uLc9NRio7zU
	cr3ixNzi0rx0veT83E2MwMRx+t/xLzsYl7/6qHeIkYmD8RCjBAezkggvS/mVVCHelMTKqtSi
	/Pii0pzU4kOM0hwsSuK8qinyqUIC6YklqdmpqQWpRTBZJg5OqQYmAf1FFxb5bvYVr3PeKJyj
	5Pbu2pJi62/Pjv0+pOAys2a11BLB8sW/FoW9EdPXiPiX/WjS/Gqrd3uzyw1XN987Yvvu++0H
	QTtlfz251mmzU77nUfqOm25OkotO8ZivyTW7MPOXthbTrVOms4OjF90OqD/y8JfWk/5i7prH
	zcnv7NjLn7F++lWWl+1p+mTa1+v6GRvb79Sw1wtmfz/CVvqO72KNjOx+44mngn65f//4JHfW
	+mNTIpRyW3c5eL+e7H+dR2dqCN9enxTRZfMi5zVvvbho6/QXS7qepDKrPPzg93+x/pnlX48p
	fdgU5eLzO1CYjfHScluJf0+L5qwPb/obF991dx5j69/ywqSlGVrFu5VYijMSDbWYi4oTAe3F
	TvWLAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsVy+t/xe7rtnNdSDebtlrL4+XIao8Wao1uZ
	Le4tesdqcWyBmAOLx9P+rewefVtWMXps2f+Z0ePzJrkAlig9m6L80pJUhYz84hJbpWhDCyM9
	Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jN1v5jAVLOGr+PVkKWMDYydPFyMnh4SA
	icSHfacZQWwhgaWMEjP21nYxcgDFpSUmbgmCKBGW+HOti62LkQuopJVJ4smrV6wgCTYBfYlp
	yxrAekUEpCQ+7tjODmIzC6RKTO5YBmYLCzhK/Dw9CayGRUBVouddF1gvr4CNROPsC0wQC+Ql
	9h88ywwRF5Q4OfMJC8QceYnmrbOZJzDyzUKSmoUktYCRaRWjSGppcW56brGhXnFibnFpXrpe
	cn7uJkZg2G479nPzDsZ5rz7qHWJk4mA8xCjBwawkwstSfiVViDclsbIqtSg/vqg0J7X4EKMp
	0H0TmaVEk/OBkZNXEm9oZmBqaGJmaWBqaWasJM7rWdCRKCSQnliSmp2aWpBaBNPHxMEp1cDU
	L9Ra9q3q9+OKlv+xB+b03H6b/c8oNel89bqlEbzX7IJS75dK+h+KC1SsmXL9rOJ8q7zEwFZX
	LianlxlCTH9Xr2kOSmvW5o2f8HYma25o9xkdp4CqvymFe/22nD2U7CMo/mRnmDLnm22XGies
	6OYs15VX0JL8X6B7+lTtga1RGYpPfZdryF0qq7jzr3jWM/5J79SfRuyYKKR4ULB0ZkmS7p+I
	T5OmqN+wuCWrPlMs8F3kR6WmMyfeyhcEHeu52lcyc9HBCgvXVYwFii6r5Zz0Q6pU2A5Y/f/f
	ph/9/EPh7CfrO4xrMlm1Lslr7jt8rEdQadt83ccrbyR8bEprcZQXODgrNK/83CMTr4MPopRY
	ijMSDbWYi4oTAQWGODXkAgAA
X-CMS-MailID: 20240221143239eucas1p259ca215d24490cd7fc073a6c3c35693b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240221143239eucas1p259ca215d24490cd7fc073a6c3c35693b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240221143239eucas1p259ca215d24490cd7fc073a6c3c35693b
References: <CGME20240221143239eucas1p259ca215d24490cd7fc073a6c3c35693b@eucas1p2.samsung.com>

Currently when suspending driver and stopping workqueue it is checked whether
workqueue is not NULL and if so, it is destroyed.
Function destroy_workqueue() does drain queue and does clear variable, but
it does not set workqueue variable to NULL. This can cause kernel/module
panic if code attempts to clear workqueue that was not initialized.

This scenario is possible when resuming suspended driver in stmmac_resume(),
because there is no handling for failed stmmac_hw_setup(),
which can fail and return if DMA engine has failed to initialize,
and workqueue is initialized after DMA engine.
Should DMA engine fail to initialize, resume will proceed normally,
but interface won't work and TX queue will eventually timeout,
causing 'Reset adapter' error.
This then does destroy workqueue during reset process.
And since workqueue is initialized after DMA engine and can be skipped,
it will cause kernel/module panic.

This commit sets workqueue variable to NULL when destroying workqueue,
which secures against that possible driver crash.

Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 75d029704503..0681029a2489 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4005,8 +4005,10 @@ static void stmmac_fpe_stop_wq(struct stmmac_priv *priv)
 {
 	set_bit(__FPE_REMOVING, &priv->fpe_task_state);
 
-	if (priv->fpe_wq)
+	if (priv->fpe_wq) {
 		destroy_workqueue(priv->fpe_wq);
+		priv->fpe_wq = NULL;
+	}
 
 	netdev_info(priv->dev, "FPE workqueue stop");
 }
-- 
2.34.1


