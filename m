Return-Path: <netdev+bounces-194535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D453ACA056
	for <lists+netdev@lfdr.de>; Sun,  1 Jun 2025 21:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D3FB160BA4
	for <lists+netdev@lfdr.de>; Sun,  1 Jun 2025 19:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03586198851;
	Sun,  1 Jun 2025 19:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pkHSvybP"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5AD13FEE
	for <netdev@vger.kernel.org>; Sun,  1 Jun 2025 19:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748807557; cv=none; b=EiUaiqqg1Qqhy2MqpQVY5dT+3nl2rZZNWR3XK5GqEi+2v8B6z7amvtkgwBRxQCL/oeEV8Qq279VPRZxUfdfIR4iGApFwnC8/PF97elxcuaMywIahjQDlhMWiKa/Q3iAYaWW4PFA7YNKNC9ASCMY1OgDKlqCWn80h2sEDu9f3tjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748807557; c=relaxed/simple;
	bh=oeZffWej7uBzGxRdf85KqdmFMzwzhzLnvKOHhjijXLk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jMdbGSxdnl7HK2em76GRVNvwGCGK+WRl1mz08Eie0A5j3pLOUo1eAFZe5ud/XLnbiNVdNhkhx5tmdqBy5QPsFpJBcjluJEL6dn6yoSu7irBctCyUtcujyjujr7WwayGw7B1KSyiJHtHUwlc2v1K7IMsfN+1ZnCq9k11O+ntNEZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pkHSvybP; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 551JiUVI011161;
	Sun, 1 Jun 2025 19:52:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=qEKIXmE3n4wNgjzuslRqyNxchqbsd
	n8lxizG3t16VYk=; b=pkHSvybP3NEsbvIoHcL3yAhnUpIUun9vnQmYvY8bG77UC
	48r1TOB9VmDuFWz94Zmbh5T0f2fn7RdvQtxFGbSUfSqNGmMOodBEldIhFZLuACra
	oHhFqTIo5aEK7az/OMIA9GafU46jKSWqxYn1FclgeFV4CXSGdpSs5h5f3S/JwrLJ
	+rhGcfyvSODpL3JkxzTwIcahpBHuXi5dxwsGOAoqOU2PKvGkx9hMO+mEi6aEUJ76
	r6YAKLSUF78mExU/8rTkdJVd8Dbu8voRg0W/IIYnWeLOBtBPFs/0Gc09mSnJhXoE
	bsUIRl54sHwNjbGSWxxZq235bUxuvZyjZyENyhu5g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ystesey7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 01 Jun 2025 19:52:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 551F1JZX033856;
	Sun, 1 Jun 2025 19:52:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7785wc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 01 Jun 2025 19:52:26 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 551JqQ05033387;
	Sun, 1 Jun 2025 19:52:26 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 46yr7785w1-1;
	Sun, 01 Jun 2025 19:52:26 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: almasrymina@google.com, bcf@google.com, joshwash@google.com,
        willemb@google.com, pkaligineedi@google.com, pabeni@redhat.com,
        kuba@kernel.org, jeroendb@google.com, hramamurthy@google.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com
Subject: [QUERY] gve: gve_tx_free_rings_dqo() uses num_xdp_queues instead of num_xdp_rings
Date: Sun,  1 Jun 2025 12:52:19 -0700
Message-ID: <20250601195223.3388860-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-01_09,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506010173
X-Proofpoint-ORIG-GUID: y7yO4vyRJhRHsBJyLiGAf-zqBOyxUt1k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAxMDE3MyBTYWx0ZWRfX6nSXISUEOqFv qXmYPfgzdK3LBeAVxIQ3dL/izVm9LRgUFDTozi9Nrt3/FLajPZrFx/VuOCiaqOvg9XGpkHG4ggK AOt1euivjUOC5ZLI2xLVmgVWSxBzg2RCpww9juINRdW3JEbnB7sRIH3mPnS/+I1u1akMdx44Rt7
 FdtWDD8kFx6DZED5fBdrHAcbAlgRw0abQ1Dhy6SmzfFK10KnPk+H9/GFNJIh8mG7OYFNE6Vuglx SvghDNWA58rPYSjQ6hL/YV8y7Locboeo2+xH3llg05dl9oSXtwDWhZ9pABpP9PjsibT0HugfeE1 GaCHphc4STxS8k2QZ5+WIekQmamLqvAxzvcNE3wjpePggnFG9bvn0WtFJQHChfyENdOc6k2riLT
 ylEVxj5FDeNwmOkhv7W23U7V8CLe/klhEMcRyxzZnF8ca9qOJyYHShRVnbJqMEgEhcMyk9y4
X-Proofpoint-GUID: y7yO4vyRJhRHsBJyLiGAf-zqBOyxUt1k
X-Authority-Analysis: v=2.4 cv=XpX6OUF9 c=1 sm=1 tr=0 ts=683caf7b b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6IFa9wvqVegA:10 a=km9IWPHy17gZmuLWPvQA:9 cc=ntf awl=host:13207

Hi,

In the function gve_tx_free_rings_dqo(), the number of TX rings to be
freed is currently calculated using:
for (i = 0; i < cfg->qcfg->num_queues + cfg->qcfg->num_xdp_queues; i++)

However, during allocation in gve_tx_alloc_rings_dqo(), the value
cfg->num_xdp_rings is used to determine how many XDP TX rings to
allocate. Although this value is set externally (typically from
cfg->qcfg->num_xdp_queues), the important point is that
cfg->num_xdp_rings is the actual count used during allocation.

Later, in gve_queues_start(), this same field (cfg->num_xdp_rings)
is used to populate priv->tx_cfg.num_xdp_queues.

Shouldn't gve_tx_free_rings_dqo() also use cfg->num_xdp_rings instead
of cfg->qcfg->num_xdp_queues, for consistency and correctness? Using
the same value throughout ensures that cleanup matches the actual
number of allocated rings, helping to avoid mismatches and potential
memory leaks.

This change would improve both clarity and correctness in the
resource management logic.

A proposed fix would be:
---
 drivers/net/ethernet/google/gve/gve_tx_dqo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index 9d705d94b065..e7ee4fa7089c 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -424,7 +424,7 @@ void gve_tx_free_rings_dqo(struct gve_priv *priv,
 	if (!tx)
 		return;
 
-	for (i = 0; i < cfg->qcfg->num_queues + cfg->qcfg->num_xdp_queues; i++)
+	for (i = 0; i < cfg->qcfg->num_queues + cfg->qcfg->num_xdp_rings; i++)
 		gve_tx_free_ring_dqo(priv, &tx[i], cfg);
 
 	kvfree(tx);
-- 
2.47.1


