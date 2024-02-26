Return-Path: <netdev+bounces-75027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A2A867C4A
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 17:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D196297688
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 16:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D7212BE95;
	Mon, 26 Feb 2024 16:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UTIkRlQi"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D9312B171
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 16:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708965822; cv=none; b=S/x/yXXnRFkDi+CMo938UXQZdR8Nh1dWnuW9U5m09+MZ5fTETon0cwCbZckDMc0bNYCPBL35qTVvOlqOK4Cs6AC3qD7f5ngbwmMGQaRibu4RlvqR3ixUZOghJrA4fTAyqwlCZ01KzDzItiCH5lb49GFZHdE2JfN4TONAQplLAgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708965822; c=relaxed/simple;
	bh=HEtn68sqr9zLmCu2RMAMQU8Cncg7q4Z4E6gjEIljh40=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=qXOK/lTZHsP91xYOjIQHMHzRyAk/hSioSCSHbserHfXfDqypC/ziArMH+DiMuccUhibgSfVk8XI/i5jdL5XgWXgqEnkyRuADt6vqV6Nej5PoPl0IRr/4KGO4BGG3+5pirI+4Fey5hNxL9UoJfK8QKGPDXg4mIswqNPNa1KgIgws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=UTIkRlQi; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240226164338euoutp01ec468de988dd429341dd79e50686b843~3d1tqPtU11808018080euoutp01F
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 16:43:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240226164338euoutp01ec468de988dd429341dd79e50686b843~3d1tqPtU11808018080euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1708965818;
	bh=qGYlDPzJBs+CgtJCtBo3zXKZiXZzNf5Ck5JO1u004t0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UTIkRlQiCTONhvRXhllmcdHTCj6NdRwa1YmyN/7lSzw88zE3+Df8Rdj9cItIuya24
	 esbVD2dQwNYJayFfg5CXUQd1CzbEQskzSfv9GX2lLL1xsQUyQV5DITraPbD5OL7mbM
	 YMZxx1dRGlGApbummoiwFdA6kjaUCRvuOOT9+aDU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240226164337eucas1p20b9bb76c2bdad0486150f8cbbf43dadd~3d1tiAU6l3058130581eucas1p2T;
	Mon, 26 Feb 2024 16:43:37 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id A3.EE.09539.9BFBCD56; Mon, 26
	Feb 2024 16:43:37 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240226164337eucas1p196a1049cb7e766984910eee2f99bae4e~3d1tDjm8u1761617616eucas1p1f;
	Mon, 26 Feb 2024 16:43:37 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240226164337eusmtrp1692a0c2bd67b488b4cd5f76409c5c907~3d1tDC4I21827518275eusmtrp1T;
	Mon, 26 Feb 2024 16:43:37 +0000 (GMT)
X-AuditID: cbfec7f2-52bff70000002543-e4-65dcbfb9dff4
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id EC.1A.10702.9BFBCD56; Mon, 26
	Feb 2024 16:43:37 +0000 (GMT)
Received: from AMDC4622.eu.corp.samsungelectronics.net (unknown
	[106.120.250.240]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240226164337eusmtip167baef518fd402cc69babd6cf2dd34ea~3d1srPjSx0869008690eusmtip1X;
	Mon, 26 Feb 2024 16:43:37 +0000 (GMT)
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	Jakub Raczynski <j.raczynski@samsung.com>
Subject: [PATCH net v2] stmmac: Clear variable when destroying workqueue
Date: Mon, 26 Feb 2024 17:42:32 +0100
Message-Id: <20240226164231.145848-1-j.raczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Zdy04YvIFlkOl3Z-@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42LZduznOd2d+++kGszcbWHx8+U0Ros1R7cy
	W9xb9I7V4sK2PlaLYwvEHFg9nvZvZffYtKqTzaNvyypGjy37PzN6fN4kF8AaxWWTkpqTWZZa
	pG+XwJXR9WsLS0GHRMWPnZ9YGhgfi3QxcnJICJhInHj6gb2LkYtDSGAFo8TPnTtYIZwvjBJr
	ph9nAqkSEvjMKNG/2hum497Ow0wQRcsZJX7NXwrV0c4kceRgMzNIFZuAvsS0ZQ2MILaIgJTE
	xx3b2UFsZoESiUf//7CC2MICHhLnDraC1bAIqEpcOrUDaCoHB6+ArcSS32EQy+Ql9h88CzaS
	U0BLYlL3cTYQm1dAUOLkzCcsECPlJZq3zmYGuUFCYC2HxPTuH+wQzS4SPcd62SBsYYlXx7dA
	xWUkTk/uYYGw6yUuHjjEBGH3MEqc+2kEYVtL7D1whRXkHmYBTYn1u/Qhwo4Sa9c+ZgEJSwjw
	Sdx4KwhxAp/EpG3TmSHCvBIdbUIQpqpE2w9xiEZpiWk7L0Lt8ZB4NmMu0wRGxVlIfpmF5JdZ
	CGsXMDKvYhRPLS3OTU8tNsxLLdcrTswtLs1L10vOz93ECEwnp/8d/7SDce6rj3qHGJk4GA8x
	SnAwK4nwhsvcTBXiTUmsrEotyo8vKs1JLT7EKM3BoiTOq5oinyokkJ5YkpqdmlqQWgSTZeLg
	lGpgCjG+GZvV3MPxzlXCx9x3sdSpGznqJj+W188qkn4hPfH2+dJJWtot2h4ahfrPY0yM1qVE
	s/+ZwfhSk0kngethyP1Vbop3OjOm5zfdbZ9pc5P1j5iZA+9Mb+7gOltlD8Ovl1u2TWBVX72v
	Zzbnmkfyv586emyxerLCKOVq5TeGULf2Ob+mW94O33B6enCdwj6ua3+4O/f19104f7Zob9gO
	jgSntlbDafMs15R0Mzv29chHbdDRcPmXt2Be5LvszuquuariTxe2+XzdVCOpLcxVPTv1U6Ok
	jmzc0rbdbyrerJrUrtU6/+qXYyerpXN2vtliszi18twn52tmeWfmcZi85DOcqJRb/FmoTWL5
	jetKLMUZiYZazEXFiQCYUKFMlgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsVy+t/xu7o7999JNXg4TcLi58tpjBZrjm5l
	tri36B2rxYVtfawWxxaIObB6PO3fyu6xaVUnm0ffllWMHlv2f2b0+LxJLoA1Ss+mKL+0JFUh
	I7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS+j69cWloIOiYofOz+x
	NDA+Fuli5OSQEDCRuLfzMFMXIxeHkMBSRoljG3YDORxACWmJiVuCIGqEJf5c62KDqGllkjj4
	5h8zSIJNQF9i2rIGRhBbREBK4uOO7ewgvcwCFRJfryqChIUFPCTOHWwFK2ERUJW4dGoH2Hhe
	AVuJJb/DIMbLS+w/eBZsIqeAlsSk7uNsILaQgKbE5r5zrCA2r4CgxMmZT1hAbGag+uats5kn
	MArMQpKahSS1gJFpFaNIamlxbnpusZFecWJucWleul5yfu4mRmDgbzv2c8sOxpWvPuodYmTi
	YDzEKMHBrCTCGy5zM1WINyWxsiq1KD++qDQntfgQoynQ2ROZpUST84Gxl1cSb2hmYGpoYmZp
	YGppZqwkzutZ0JEoJJCeWJKanZpakFoE08fEwSnVwLToUc3Mpg7Bq+XOq0sKvWrbu8Q+v9j8
	2cDuo8lnhs6D5+bPTWv8XmvfJi5/Wy2Ue61lp/0SnzTnT0+UWp85fty0q9N8qYzKxIDbyvum
	S4v7NeaGbTJ8ajW3or1IJ2i9jGLSE7XOBV/0eDYZ95slfk0o096wn1NDvkcmvVS2dOU82eDF
	J4NTlqy7la675Or/tY/D3er25h/yFP1zzc3z0+k4I8XNy0qsDc8ZPZj6NkFJa/qH8CP8e76s
	WL1PfLvxI9NH35sUJCxv8L9qCrmV+ahO7bXKr4v/cp/8mzNn36u3r8+X3bLb9I1v/pVM0+5G
	hs/znwmE2ibclrPY67VloR//kt+dfUvsLWedlk665ajEUpyRaKjFXFScCADhZNTUBQMAAA==
X-CMS-MailID: 20240226164337eucas1p196a1049cb7e766984910eee2f99bae4e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240226164337eucas1p196a1049cb7e766984910eee2f99bae4e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240226164337eucas1p196a1049cb7e766984910eee2f99bae4e
References: <Zdy04YvIFlkOl3Z-@nanopsycho>
	<CGME20240226164337eucas1p196a1049cb7e766984910eee2f99bae4e@eucas1p1.samsung.com>

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

To secure against this possible crash, set workqueue variable to NULL when
destroying workqueue.

Log/backtrace from crash goes as follows:
[88.031977]------------[ cut here ]------------
[88.031985]NETDEV WATCHDOG: eth0 (sxgmac): transmit queue 1 timed out
[88.032017]WARNING: CPU: 0 PID: 0 at net/sched/sch_generic.c:477 dev_watchdog+0x390/0x398
           <Skipping backtrace for watchdog timeout>
[88.032251]---[ end trace e70de432e4d5c2c0 ]---
[88.032282]sxgmac 16d88000.ethernet eth0: Reset adapter.
[88.036359]------------[ cut here ]------------
[88.036519]Call trace:
[88.036523] flush_workqueue+0x3e4/0x430
[88.036528] drain_workqueue+0xc4/0x160
[88.036533] destroy_workqueue+0x40/0x270
[88.036537] stmmac_fpe_stop_wq+0x4c/0x70
[88.036541] stmmac_release+0x278/0x280
[88.036546] __dev_close_many+0xcc/0x158
[88.036551] dev_close_many+0xbc/0x190
[88.036555] dev_close.part.0+0x70/0xc0
[88.036560] dev_close+0x24/0x30
[88.036564] stmmac_service_task+0x110/0x140
[88.036569] process_one_work+0x1d8/0x4a0
[88.036573] worker_thread+0x54/0x408
[88.036578] kthread+0x164/0x170
[88.036583] ret_from_fork+0x10/0x20
[88.036588]---[ end trace e70de432e4d5c2c1 ]---
[88.036597]Unable to handle kernel NULL pointer dereference at virtual address 0000000000000004

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


