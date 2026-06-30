Return-Path: <netdev+bounces-302978-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RnXzKlpcQ2oXXQoAu9opvQ
	(envelope-from <netdev+bounces-302978-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 08:04:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A26676E0913
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 08:04:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=windriver.com header.s=PPS06212021 header.b=ToljrfLg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302978-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-302978-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=windriver.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A5556300B538
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 06:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEAF29A9FE;
	Tue, 30 Jun 2026 06:03:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87002325491;
	Tue, 30 Jun 2026 06:03:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782799431; cv=none; b=Qqt6q2SX63HBri4UARisqOp/5mmMHMEAQIcFLosKazBq52Je0RB/rqg0ojGoXxc3cjrJCC3OZPCfDWWM/wIe1q90l/pVfBpwTpKVHhNuH6UbvTfeh0rv7ArI6Y1h5Ib27f446LcIBAm+pBbwC34xwccF6LA8QIKj8aiz72VV57U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782799431; c=relaxed/simple;
	bh=Qimp2i4uAqaTa85hotHc2wuYOBeOfP1LoES2EjGOHzE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CO+orVEkcDEQP5Bl75DpkjbEmT6Qb/yg++DyP7b/XXcJEupiXOIsGnWUu1VR7cEmZ4aQ9Ir1fbB0DNz+KTNy9DfTNDJxSEBs8nBNBycsfzQyyDgr4vaGAC1s3Znc42aP573ciAzW0OD+VLVrhnCd0LfNN+HKonsHjuZCEUOEnS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=ToljrfLg; arc=none smtp.client-ip=205.220.166.238
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U5ghHE338419;
	Mon, 29 Jun 2026 23:03:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=oEJHvixGy
	3TiSGx8/Vgl6aY/23h640aaxfycDEpLw3Y=; b=ToljrfLgiOlIPMwhUy6di3qXD
	EuUraBdqVMCEE5wqCYlST3cF/wHJUI8brwfZEfnQTeJ5GRKfiZPM9D2OMu9MoFJY
	BrZyXAA8XWk7Z43hV1v+/n0fBEDgheG5cuAzyc7ukRqnBxpKLHXpJljYacv3pCgf
	U3egRytQmMrPjDu9HLyDiMZWpdq6fH9hoiIx1qDqtHoxHfUH13Ut4YidBEeIwhWN
	gSS6vJePdA/hESR290w4hMDDZDqzTiGnLq8QXxJhjMSC3Pt2M6FUqkp48vn3+KdX
	mplvGDnnI6GzDlPQg3tm2rpeqyIL/CjrnbOaACljVWz7qBOVpMczOlcxiP5ow==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4f2e1gu72t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 29 Jun 2026 23:03:15 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Mon, 29 Jun 2026 23:03:14 -0700
Received: from pek-yzhou-d3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Mon, 29 Jun 2026 23:03:12 -0700
From: Yun Zhou <yun.zhou@windriver.com>
To: <marcin.s.wojtas@gmail.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yun.zhou@windriver.com>
Subject: [PATCH v6] net: mvneta_bm: add suspend/resume support to prevent crash after resume
Date: Tue, 30 Jun 2026 14:03:11 +0800
Message-ID: <20260630060311.4072140-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: WnJXZ1vj9tZy3lEV2LHq0k2eG9ZOTco6
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA0OCBTYWx0ZWRfX81Yn1MfpzoYe
 IQeoOpmO9PTWFcQ9UTnSmJ/NXUHHkOLLrlJtwK968TDD2LAklplaZha5p7YuAZOxlwkxWElBK2+
 JxibWULxW04hYYj1PEFwj5iXABfs/YGxuWcTyIVazlkXf4qut61f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA0OCBTYWx0ZWRfXxwNnzd/Zb0nu
 35miitvpwkLbbKax4Glp2sO/n+pAT2cW/KzflgyMMWCznMfQT76eUtQQv0tMnYYP23CSU62RNDp
 pQ2R07ju7H9bgR4jt+vDBol40qENJxEL61drHGCvcXkY/iYdibpKmdYA/HsX2bQJNYeVTGbhOMf
 4DY9H47vtMMl/p6feiE2mxFA2LN64lMBpU9Lk27Y4CPpbbYnmk3FWh1WKymLjR+S7MBoEBA98K5
 xYL8TblHMJyZKXijwWYOOwCdIDzPMfym0eguP4tvVEZJF8Bo0zCdKKl00wNsSyiRG03tmekWFk1
 SCsBWhZ3Z5406s+b1n2RkdsLdRgrdWV9aPuESbNcvEPuKw5eHq1HQ0op7H7CPccs+KQn5tpK3e5
 F/HTdsxxNLzj8sZTwnjTGt3ZvuLEAaBXV26b6ZVIMoc0F9Fg605C7hgEHZ4TfCyDYvJMq4sfhcb
 J6rMfxUdcAr/5h6g7FA==
X-Proofpoint-GUID: WnJXZ1vj9tZy3lEV2LHq0k2eG9ZOTco6
X-Authority-Analysis: v=2.4 cv=GsByPE1C c=1 sm=1 tr=0 ts=6a435c23 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=iKiJcTA2PjBS6x5JeXcw:22 a=t7CeM3EgAAAA:8 a=llSl7IMiYTbgZXsqiVMA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300048
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302978-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:marcin.s.wojtas@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yun.zhou@windriver.com,m:marcinswojtas@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[windriver.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,windriver.com:dkim,windriver.com:email,windriver.com:mid,windriver.com:from_mime];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A26676E0913

The mvneta driver uses the hardware Buffer Manager (BM) for RX buffer
allocation. During suspend, mvneta disables its clock, causing BM to
lose all buffer address state. On resume, mvneta_bm_port_init() re-
attaches the BM pool to the NIC, but BM hardware returns stale/garbage
buffer addresses. When NAPI poll processes these buffers, DMA cache
sync hits an invalid virtual address causing a kernel panic:

 Unable to handle kernel paging request at virtual address b0000080
 PC is at v7_dma_inv_range
 Call trace:
  v7_dma_inv_range from arch_sync_dma_for_cpu+0x94/0x158
  arch_sync_dma_for_cpu from __dma_sync_single_for_cpu+0xc4/0x15c
  __dma_sync_single_for_cpu from mvneta_rx_swbm+0x6c8/0xf48
  mvneta_rx_swbm from mvneta_poll+0x6fc/0x70c
  mvneta_poll from __napi_poll.constprop.0+0x2c/0x1e0
  __napi_poll.constprop.0 from net_rx_action+0x160/0x2c4
  net_rx_action from handle_softirqs+0xd8/0x2b8
  handle_softirqs from run_ksoftirqd+0x30/0x94
  run_ksoftirqd from smpboot_thread_fn+0x100/0x204
  smpboot_thread_fn from kthread+0xf4/0x110
  kthread from ret_from_fork+0x14/0x28

Fix by adding suspend/resume callbacks to the BM driver:

- suspend: drain all buffers (with DMA unmapping), free the BPPE
  regions, and reset pool state to FREE before stopping BM and gating
  the clock.

- resume: enable the clock, reinitialize BM defaults, and restore pool
  read/write pointers and size registers. Pool allocation and buffer
  refill are handled by mvneta_resume() through the normal
  mvneta_bm_port_init() path, which sees pools as FREE and performs
  full initialization identical to probe.

Add a device_link (DL_FLAG_AUTOREMOVE_CONSUMER) in mvneta_probe to
guarantee BM resumes before mvneta and suspends after mvneta. If the
link cannot be created, fall back to SW buffer management to avoid a
potential crash on resume due to unordered PM transitions.

Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
---
v6:
  - Add mutex_destroy() before setting type = FREE in suspend, pairing
    with mutex_init() in mvneta_bm_pool_use() on resume. This avoids
    re-initializing an active lockdep class.
  - NULL-out bm_pool->virt_addr in mvneta_bm_pool_create() error paths
    to fix a pre-existing dangling pointer that could cause double-free
    in suspend.

v5:
  - Call mvneta_bm_pool_disable() per pool before dma_free_coherent()
    in suspend, matching mvneta_bm_pool_destroy() ordering. This also
    ensures ENABLE_MASK is cleared before BM START on resume.
  - Guard dma_free_coherent() with if (bm_pool->virt_addr) to defend
    against a partially-failed mvneta_bm_pool_create() leaving a stale
    pointer.

v4:
  - On device_link_add() failure, fall back to SW buffer management
    (destroy pools, put BM reference, clear bm_priv) instead of merely
    emitting a warning. Without the link, suspend/resume ordering is
    not guaranteed and the original crash can still occur.

v3:
  - Restore per-pool POOL_SIZE_REG, POOL_READ_PTR_REG, and
    POOL_WRITE_PTR_REG in resume, since clock gating loses all BM
    register state.
  - Check device_link_add() return value and emit dev_warn on failure.
  - Replace SIMPLE_DEV_PM_OPS (deprecated) with
    DEFINE_SIMPLE_DEV_PM_OPS and pm_sleep_ptr(), removing the
    #ifdef CONFIG_PM_SLEEP guard.
  - Add dev_warn in suspend if not all buffers could be freed.

v2:
  - Drain buffers via mvneta_bm_bufs_free() in suspend instead of only
    stopping BM and gating the clock. This ensures proper DMA unmapping
    and avoids buffer leaks.
  - Free the BPPE DMA-coherent region in suspend so that resume takes
    the full probe-time initialization path (alloc + fill), eliminating
    the need to modify mvneta_bm_pool_create().
  - Reset pool type to MVNETA_BM_FREE in suspend so mvneta_bm_pool_use()
    correctly re-creates and refills pools on resume.
  - Check clk_prepare_enable() return value in resume.
  - Add device_link between mvneta (consumer) and mvneta_bm (supplier)
    to guarantee correct suspend/resume ordering.

 drivers/net/ethernet/marvell/mvneta.c    | 18 ++++++
 drivers/net/ethernet/marvell/mvneta_bm.c | 72 ++++++++++++++++++++++++
 2 files changed, 90 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 744d6585a949..543e566425c1 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -5678,6 +5678,24 @@ static int mvneta_probe(struct platform_device *pdev)
 					 "use SW buffer management\n");
 				mvneta_bm_put(pp->bm_priv);
 				pp->bm_priv = NULL;
+			} else if (!device_link_add(&pdev->dev,
+						    &pp->bm_priv->pdev->dev,
+						    DL_FLAG_AUTOREMOVE_CONSUMER)) {
+				/*
+				 * Link guarantees BM resumes before mvneta.
+				 * Without it, BM may not be ready when
+				 * mvneta_bm_port_init() runs on resume,
+				 * causing stale buffer addresses and a crash.
+				 * Fall back to SW management to be safe.
+				 */
+				dev_warn(&pdev->dev,
+					 "failed to link to BM, use SW buffer management\n");
+				mvneta_bm_pool_destroy(pp->bm_priv,
+						       pp->pool_long, 1 << pp->id);
+				mvneta_bm_pool_destroy(pp->bm_priv,
+						       pp->pool_short, 1 << pp->id);
+				mvneta_bm_put(pp->bm_priv);
+				pp->bm_priv = NULL;
 			}
 		}
 		/* Set RX packet offset correction for platforms, whose
diff --git a/drivers/net/ethernet/marvell/mvneta_bm.c b/drivers/net/ethernet/marvell/mvneta_bm.c
index 6bb380494919..e0c693c0a910 100644
--- a/drivers/net/ethernet/marvell/mvneta_bm.c
+++ b/drivers/net/ethernet/marvell/mvneta_bm.c
@@ -129,6 +129,7 @@ static int mvneta_bm_pool_create(struct mvneta_bm *priv,
 	if (!IS_ALIGNED((u32)bm_pool->virt_addr, MVNETA_BM_POOL_PTR_ALIGN)) {
 		dma_free_coherent(&pdev->dev, size_bytes, bm_pool->virt_addr,
 				  bm_pool->phys_addr);
+		bm_pool->virt_addr = NULL;
 		dev_err(&pdev->dev, "BM pool %d is not %d bytes aligned\n",
 			bm_pool->id, MVNETA_BM_POOL_PTR_ALIGN);
 		return -ENOMEM;
@@ -139,6 +140,7 @@ static int mvneta_bm_pool_create(struct mvneta_bm *priv,
 	if (err < 0) {
 		dma_free_coherent(&pdev->dev, size_bytes, bm_pool->virt_addr,
 				  bm_pool->phys_addr);
+		bm_pool->virt_addr = NULL;
 		return err;
 	}
 
@@ -477,6 +479,75 @@ static void mvneta_bm_remove(struct platform_device *pdev)
 	clk_disable_unprepare(priv->clk);
 }
 
+static int mvneta_bm_suspend(struct device *dev)
+{
+	struct mvneta_bm *priv = dev_get_drvdata(dev);
+	int i;
+
+	/* Drain buffers and free pool resources while BM is still clocked */
+	for (i = 0; i < MVNETA_BM_POOLS_NUM; i++) {
+		struct mvneta_bm_pool *bm_pool = &priv->bm_pools[i];
+		int size_bytes;
+
+		if (bm_pool->type == MVNETA_BM_FREE)
+			continue;
+
+		mvneta_bm_bufs_free(priv, bm_pool, bm_pool->port_map);
+		if (bm_pool->hwbm_pool.buf_num)
+			dev_warn(&priv->pdev->dev,
+				 "pool %d: %d buffers not freed\n",
+				 bm_pool->id, bm_pool->hwbm_pool.buf_num);
+
+		mvneta_bm_pool_disable(priv, bm_pool->id);
+
+		if (bm_pool->virt_addr) {
+			size_bytes = sizeof(u32) * bm_pool->hwbm_pool.size;
+			dma_free_coherent(&priv->pdev->dev, size_bytes,
+					  bm_pool->virt_addr,
+					  bm_pool->phys_addr);
+			bm_pool->virt_addr = NULL;
+		}
+		/*
+		 * Safe to destroy: device_link guarantees all mvneta ports
+		 * have already suspended, so no hwbm_pool_add() can be in
+		 * progress holding buf_lock.  Pairs with mutex_init() in
+		 * mvneta_bm_pool_use() on resume.
+		 */
+		mutex_destroy(&bm_pool->hwbm_pool.buf_lock);
+		bm_pool->type = MVNETA_BM_FREE;
+	}
+
+	mvneta_bm_write(priv, MVNETA_BM_COMMAND_REG, MVNETA_BM_STOP_MASK);
+	clk_disable_unprepare(priv->clk);
+	return 0;
+}
+
+static int mvneta_bm_resume(struct device *dev)
+{
+	struct mvneta_bm *priv = dev_get_drvdata(dev);
+	int i, err;
+
+	err = clk_prepare_enable(priv->clk);
+	if (err)
+		return err;
+
+	/* Reinitialize BM hardware; pools are refilled by mvneta_resume() */
+	mvneta_bm_default_set(priv);
+
+	/* Restore pool registers lost during clock gating */
+	for (i = 0; i < MVNETA_BM_POOLS_NUM; i++) {
+		mvneta_bm_write(priv, MVNETA_BM_POOL_READ_PTR_REG(i), 0);
+		mvneta_bm_write(priv, MVNETA_BM_POOL_WRITE_PTR_REG(i), 0);
+		mvneta_bm_write(priv, MVNETA_BM_POOL_SIZE_REG(i),
+				priv->bm_pools[i].hwbm_pool.size);
+	}
+
+	mvneta_bm_write(priv, MVNETA_BM_COMMAND_REG, MVNETA_BM_START_MASK);
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(mvneta_bm_pm_ops, mvneta_bm_suspend, mvneta_bm_resume);
+
 static const struct of_device_id mvneta_bm_match[] = {
 	{ .compatible = "marvell,armada-380-neta-bm" },
 	{ }
@@ -489,6 +560,7 @@ static struct platform_driver mvneta_bm_driver = {
 	.driver = {
 		.name = MVNETA_BM_DRIVER_NAME,
 		.of_match_table = mvneta_bm_match,
+		.pm = pm_sleep_ptr(&mvneta_bm_pm_ops),
 	},
 };
 
-- 
2.43.0


