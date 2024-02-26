Return-Path: <netdev+bounces-74987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A7F867AB0
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 16:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3287B25C62
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 15:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE67E12BF18;
	Mon, 26 Feb 2024 15:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="A2rGdieP"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B6612B153
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 15:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962179; cv=none; b=K2iDgcRkhbXCFT8OdAduboinSN+8+BzK2rosEKY/Bru0Ff9J5TTieXmSG3Eu0JA/Z9tiEwlfMZ4YnPwekCbO47jKpy0UwCput7EwY/TPcm6tcJg2bqjhebY8bUgfinxod+8lx9e+YeYkNeOOgkB9ygtzc63kQwA/vAoZETil388=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962179; c=relaxed/simple;
	bh=GfiNQiLV8g6LuH7eaJG/Rok+oUoDr8vShHXYcCPuCoY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=PRgaNknLFwbGdzOPtpZZHcyPltVkR+WJfDUSpORwd6mtUnylXiNNi6Wtylf1Ef7Z8UFUmbQTOLqIJaw3Ro8dEBk8HjJykw9ovrb/1uLoItwed+N65sAN353bHbtboWw7kQHvDfRWeVj+UN8HYm23Xep+1STkDxxM1wuDZThBpeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=A2rGdieP; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240226154254euoutp018d6f7346556eb972ad28de053f334e73~3dAspf2ik1677516775euoutp01j
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 15:42:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240226154254euoutp018d6f7346556eb972ad28de053f334e73~3dAspf2ik1677516775euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1708962174;
	bh=48wLizMyVjUNb75h6VNi9bB+s8O70IvAyxjlFv55Zo8=;
	h=From:To:Cc:Subject:Date:References:From;
	b=A2rGdiePTr+xNnnylKxK8GxvsPeCu8z44SEGT94tA5Uogp+JQYSZ+zHgHE3sC9vty
	 g6V7AGHun3cENJpE/jbtXQTCQPj/Muz5wdg2cvvfHNUZT8E/+vRIPY4D148PdquG74
	 cGtvvCmvOebxkNA7mbmVpZ3CnZnAr53G04V31HR0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240226154254eucas1p24e1baebfb65be1b5006ab267c24ed82e~3dAsZABK40058300583eucas1p2S;
	Mon, 26 Feb 2024 15:42:54 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id C7.35.09814.E71BCD56; Mon, 26
	Feb 2024 15:42:54 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240226154254eucas1p2bedde2c58f147809f83b23d455af9289~3dAsIdsuK2908329083eucas1p2P;
	Mon, 26 Feb 2024 15:42:54 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240226154254eusmtrp22d3b326c65ec997724275c071043c616~3dAsHrmg_3063430634eusmtrp2O;
	Mon, 26 Feb 2024 15:42:54 +0000 (GMT)
X-AuditID: cbfec7f4-727ff70000002656-ab-65dcb17e2226
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 40.F1.10702.E71BCD56; Mon, 26
	Feb 2024 15:42:54 +0000 (GMT)
Received: from AMDC4622.eu.corp.samsungelectronics.net (unknown
	[106.120.250.240]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240226154253eusmtip1e3099bc0cd604fd558d5d77334818f71~3dAruPpfI0485704857eusmtip1G;
	Mon, 26 Feb 2024 15:42:53 +0000 (GMT)
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	Jakub Raczynski <j.raczynski@samsung.com>
Subject: [PATCH net v2] stmmac: Clear variable when destroying workqueue
Date: Mon, 26 Feb 2024 16:42:17 +0100
Message-Id: <20240226154216.144734-1-j.raczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42LZduznOd26jXdSDa6uU7L4+XIao8Wao1uZ
	Le4tesdqcWFbH6vFsQViDqweT/u3sntsWtXJ5tG3ZRWjx5b9nxk9Pm+SC2CN4rJJSc3JLEst
	0rdL4Mr4/9W/4DdfxdPpP1kaGK/ydDFyckgImEg8nfaQpYuRi0NIYAWjxIqV69kgnC+MEn9e
	PIbKfGaUWLLnDRNMy7Ntq5khEssZJe7cvgjltDNJ/Jozjx2kik1AX2LasgZGEFtEQEri447t
	YHFmgRKJR///sILYwgIeEucOtoLVsAioSvy78QdsA6+ArcSz60cYIbbJS+w/eJYZIi4ocXLm
	ExaIOfISzVtngy2WEJjIIbFw0SGo81wkJv3tZoOwhSVeHd/CDmHLSPzfOR+qpl7i4gGY+h5G
	iXM/jSBsa4m9B64AHccBtEBTYv0ufYiwo8Si3R/ZQcISAnwSN94KQpzAJzFp23RmiDCvREeb
	EISpKtH2QxyiUVpi2s6LUHs8JLbNmwx2l5BArMTuvXsYJzAqzELy1ywkf81COGEBI/MqRvHU
	0uLc9NRio7zUcr3ixNzi0rx0veT83E2MwIRy+t/xLzsYl7/6qHeIkYmD8RCjBAezkghvuMzN
	VCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8qinyqUIC6YklqdmpqQWpRTBZJg5OqQamGSWbeFwq
	v+0+4zL7uN8yC/eSbWvbX208vasg5L9r0s6Yfd5GH4sOmr5Ie6nZUGyy8kJzu87qCeujLZ9Z
	HvG4o2bAfPJ0YaxY3pzPpaqP21/89bsxS020SezBl8W/zy3veWbe8WFL/B97n9Wreh+0Rh0S
	2haRUcW89aqIcM1pvYMbyisnSd9YqlC/4gg/b/1Lt/VmX8RdYir+8r6UvdSiv+vw4SgD+90V
	v0/Ll314ZLOj/4QMa3Hm88sPdKY8mebFF6+Yesb17/HW30o1S5UfXg6fdFn0QQdr/4WQV7HP
	ZJ6pZ37YLVTWYTrjc9NCwfuWVYo/LKS1Tx9/azHv4OEzzX6Z599xO95tamgI7mi/rcRSnJFo
	qMVcVJwIANi6ur+XAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsVy+t/xu7p1G++kGhy8zGfx8+U0Ros1R7cy
	W9xb9I7V4sK2PlaLYwvEHFg9nvZvZffYtKqTzaNvyypGjy37PzN6fN4kF8AapWdTlF9akqqQ
	kV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJfx/6t/wW++iqfTf7I0
	MF7l6WLk5JAQMJF4tm01cxcjF4eQwFJGidYNj1i7GDmAEtISE7cEQdQIS/y51sUGUdPKJPG8
	7xcLSIJNQF9i2rIGRhBbREBK4uOO7ewgvcwCFRJfryqChIUFPCTOHWwFK2ERUJX4d+MPE4jN
	K2Ar8ez6EUaI+fIS+w+eZYaIC0qcnPkEbDwzULx562zmCYx8s5CkZiFJLWBkWsUoklpanJue
	W2ykV5yYW1yal66XnJ+7iREYyNuO/dyyg3Hlq496hxiZOBgPMUpwMCuJ8IbL3EwV4k1JrKxK
	LcqPLyrNSS0+xGgKdN9EZinR5HxgLOWVxBuaGZgamphZGphamhkrifN6FnQkCgmkJ5akZqem
	FqQWwfQxcXBKNTDVzl7RvZRx0ZSUKd4Nm64X5pQVb/nM1H1A/tZia/PLF51Pak8Teb7mxoPb
	O9SPntHenKVxr13rc19xnZHJ0Xu6Fx6fPa3W4RqucDlSoynDUvz62jjPhMmyoZ3TvSXDQ89q
	/vtkULt1ed+J8yfdd1cUsHRpF8ptMPbg6xO7eb3w34TlfkGpfEKbb5VsjdD7bGe/5dFCCz6u
	BzfYthlJxH6yvVf7++tjv3viTAxL1yl+2CTo9c/jhnJqSvWzM55vU07v5qm6czVl6//dqyf9
	kVv98UTf74i8OdN3zTxv5/+RS9/h9Mz4w1I1CbYWLxk7JMNMJ+2wDunJrCv++UtcUGXm4UMl
	1e5fN5i3tB87rPFIiaU4I9FQi7moOBEAaPAYZe0CAAA=
X-CMS-MailID: 20240226154254eucas1p2bedde2c58f147809f83b23d455af9289
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240226154254eucas1p2bedde2c58f147809f83b23d455af9289
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240226154254eucas1p2bedde2c58f147809f83b23d455af9289
References: <CGME20240226154254eucas1p2bedde2c58f147809f83b23d455af9289@eucas1p2.samsung.com>

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

Fixes: 5a5586112b929 ("net: stmmac: support FPE link partner hand-shaking procedure")
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


