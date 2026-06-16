Return-Path: <netdev+bounces-299819-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NxhhJIszMWqrdwUAu9opvQ
	(envelope-from <netdev+bounces-299819-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 13:29:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6D668ECA1
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 13:29:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=windriver.com header.s=PPS06212021 header.b="ClQit/Aj";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299819-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299819-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=windriver.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B555A30262CA
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 11:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D14E3B71B1;
	Tue, 16 Jun 2026 11:26:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABE035A3A4;
	Tue, 16 Jun 2026 11:26:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781609180; cv=none; b=IKz/XRVNkf3wrdH636cAPl4J5Wt6Xf/7vyIiKUrsnZ0Xy5fkdz4FF1HASgZCbzpXXOWsX7RQbcsEkEMQCpGnHXWHh6E1GOWRi7XjDyjjQgRMAPIW0z/y5q9ljkUu5DneQx8Kc1yZ1nxVSnxya0lUXF+bbj/jNRc7MOpUoYH8kdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781609180; c=relaxed/simple;
	bh=efx7XWElmJd88p4RMftNsq1OiTGNZLozSKi35RWSy1w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mUkdM047uk5l6ztF/8tcJH2wuqZl2nsXhk7zoYNCvHqIEmNJm0jB6t6oaOlf1D/1gC/ZlPsgrPiRU9vV9/s78pFhoqNkjsak9b4yEU+atVIz9m/bqoP1K1qWVy8DvRQ9yLL1Nh9Ne3hcZsS13A/w1qLShh8RcROFEUXrebTOZbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=ClQit/Aj; arc=none smtp.client-ip=205.220.166.238
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GA9gUI3485412;
	Tue, 16 Jun 2026 04:25:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=OWNTkAmqB
	XhQF0npwnONyVhan8vWqjl3QQ6BqCKD3IM=; b=ClQit/AjYloTczkRPRzdTcE80
	xdXbjlzdLAcK+49tlHIAsefQIuy1MZMnnfgd0thLGHCZ4p0RLhtgWBx/1c9JMI4l
	q9mFIp1sELUTHCEZ67mACN0UdRBCbuul4P2feDOxJCKp1sstwG7bHhV8e74tK1LU
	XSahNv9TnPnZBOHOKp33aP+6LW8FicqR0YSyRQjfT2gmz8ZKbB6v+iVsGM6wwkjJ
	5Ngp4ize2Fu2mjw3NEbTvB/zTvRXDmbumBvjJwbuEXGusajF8B9ZgnJrrEee5J0O
	4mKhE2yMT+f7cJlmTKoGpuxTySOZkjzt0FsQFDJx1uFqQUehVD/YMKYL9XBIg==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4es6qdv5fe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 16 Jun 2026 04:25:43 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 16 Jun 2026 04:25:43 -0700
Received: from pek-yzhou-d3.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 16 Jun 2026 04:25:41 -0700
From: Yun Zhou <yun.zhou@windriver.com>
To: <marcin.s.wojtas@gmail.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yun.zhou@windriver.com>
Subject: [PATCH v3] net: mvneta_bm: add suspend/resume support to prevent crash after resume
Date: Tue, 16 Jun 2026 19:25:40 +0800
Message-ID: <20260616112540.4181231-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=DLq/JSNb c=1 sm=1 tr=0 ts=6a3132b7 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=iKiJcTA2PjBS6x5JeXcw:22 a=t7CeM3EgAAAA:8 a=O8BtC7tisV2pxISLYgAA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: Hb2sP49QmfHfgWh8ZVYC4rPzB1u63ckT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDExNiBTYWx0ZWRfX9/frBmOXV0o/
 JHbcOnaI4fr/XpBTRW412DtUzF2uRSPCPb/pNX7EhHbdksfw7ZEJJ3tCAh17sdzuIjL6Gm8UCic
 YOHxXQJ/AmaWvCssS/k9BkpT16V0rn2HQ96Nwq4aIyAq6eGoHMonj+Jyxty9InWxWG7BjJXdt74
 1b9isTZTsw3jHF8Dpwb+SBe8lPwVtgO6Bd1qJqDuKkj8ya9dgsJYczGGI77iXlV8uyMMJuX5ijL
 zdmwMxSb/dt/na9oWHS3TBvaPUNXPMQeo0EWyeQ1RWKoZVo9l7wc546OoybjdhoOC2evvLyZw3K
 mAcvG4wrYi48mW1Ha/TGr+oXcV0nriCp39bPeqycPbMAFu9X6K7y1d2MnsrTvIVA36wxiFEwmTQ
 6C4SLyKF22OAzlIpLH6kquOEyOubYtsyWOJ9wl77gKu0g2MW8UuAkhOZkPfGmM19uqCdsA/M1G1
 +iFUVbPbr73FCQ/pz5w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDExNiBTYWx0ZWRfX/ozY3MtnS2YJ
 6RwC2nlmjsOl3KhXP3qTMOGmvDm0P607UO8RHNJXxSnxCE1k4AjcdE3TUmxtxM/Z3mNPtsH3Hdi
 DU5aLXPG4QRmaymBNXNm7HFULVtZ06BWTofsRwrDsuV7HFYGeLMy
X-Proofpoint-ORIG-GUID: Hb2sP49QmfHfgWh8ZVYC4rPzB1u63ckT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0
 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160116
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299819-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7B6D668ECA1

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
guarantee BM resumes before mvneta and suspends after mvneta.

Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
---
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

 drivers/net/ethernet/marvell/mvneta.c    |  7 +++
 drivers/net/ethernet/marvell/mvneta_bm.c | 58 ++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 0c061fb0ed07..b4a845f04c05 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -5678,6 +5678,13 @@ static int mvneta_probe(struct platform_device *pdev)
 					 "use SW buffer management\n");
 				mvneta_bm_put(pp->bm_priv);
 				pp->bm_priv = NULL;
+			} else {
+				/* Ensure BM suspends after us, resumes before us */
+				if (!device_link_add(&pdev->dev,
+						     &pp->bm_priv->pdev->dev,
+						     DL_FLAG_AUTOREMOVE_CONSUMER))
+					dev_warn(&pdev->dev,
+						 "failed to create device link to BM\n");
 			}
 		}
 		/* Set RX packet offset correction for platforms, whose
diff --git a/drivers/net/ethernet/marvell/mvneta_bm.c b/drivers/net/ethernet/marvell/mvneta_bm.c
index 6bb380494919..85162a43eaf6 100644
--- a/drivers/net/ethernet/marvell/mvneta_bm.c
+++ b/drivers/net/ethernet/marvell/mvneta_bm.c
@@ -477,6 +477,63 @@ static void mvneta_bm_remove(struct platform_device *pdev)
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
+		size_bytes = sizeof(u32) * bm_pool->hwbm_pool.size;
+		dma_free_coherent(&priv->pdev->dev, size_bytes,
+				  bm_pool->virt_addr, bm_pool->phys_addr);
+		bm_pool->virt_addr = NULL;
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
@@ -489,6 +546,7 @@ static struct platform_driver mvneta_bm_driver = {
 	.driver = {
 		.name = MVNETA_BM_DRIVER_NAME,
 		.of_match_table = mvneta_bm_match,
+		.pm = pm_sleep_ptr(&mvneta_bm_pm_ops),
 	},
 };
 
-- 
2.43.0


