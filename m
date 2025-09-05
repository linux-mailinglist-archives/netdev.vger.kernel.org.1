Return-Path: <netdev+bounces-220282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB910B45286
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 11:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 600921C85D3D
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 09:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EA630AD14;
	Fri,  5 Sep 2025 09:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PqTYduvE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01F9308F1D
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 09:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063121; cv=none; b=fUFGIlI1lCUxCRTZE/CSPJXe0E5hlcAAEQ0R7rnJp26HIyuP16M9cp6rxi/LvYk1Z70xhQgWv7T3K2L++NmIuDXUQxvGPpjhTv9k7mU7PSzOkxJIr8Cg4DNBU7V/378SN7qQzFGowcSllUC1ax+gSiUIRk3rdj/D0l6Mia9VUTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063121; c=relaxed/simple;
	bh=Eg4vUz0AEB2ThcG9sDbzBoDB58WwT1OV2/v2U7m7WbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cjF5t0ojs4Hx0d/xd0DDogm9BS2SmkOlTvXeZELRQAff9wznrY57yjNPjPSPW1d1A+87iHzpgIUGFmvOFLXKX/gW/l/6Qt7etsFuDIj+l9kWw0mZ3/nf7uq3hq80gjwS8kowYb+unnN6LsdEXKh8dbz5LC/ynSAwP82DtQ/eGfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PqTYduvE; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso1709487f8f.3
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 02:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063116; x=1757667916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xE89YPIL59Df61LriY9rimmOpYAGqRHRHwVw8wDJUrA=;
        b=PqTYduvEPSE3VdDgnPfUKKSvmYGYhKpom2cxIltT5L05vPDUED4FyCKAwEcv54bL6Z
         wJVx6vFVCpUWmWmecCtwGuBKQi+YF6lK8xPLOv3rAVPLXrTVxPiG4hG3McdEIVvdHdoM
         wOdSJcJ/FZlPM7jRsSmt/gUVHJ4bAk8fNV2hQHQGt2SFPRLsQBn1vNVSyXcK8TBi9JEW
         Ugva28EAPnfTA4QkhUI4JOabsSA/dLN/EKPQwcuULh8tnWoe7AHT/gsawTCdqt9mwpO3
         EjqJ1BX204+XdR7Oz7KL/yl4MqxijhB3w3LP6F0iYYwZ3CcHWFVb18TORHCLqxR4KDO/
         QJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063116; x=1757667916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xE89YPIL59Df61LriY9rimmOpYAGqRHRHwVw8wDJUrA=;
        b=QpB2I1aNBzhVRDX4yk+GItS5T+ti3y2544poSg8ZC0ToAfHEGGNUdgskACZxh4UKQh
         hKfOenELx1K50gKK2JS+I3bwR4u1Ok+kffV1xJiXyCOeKgsRw9uztookCF108vkDGhKO
         QtHyKSXZ6r0t5QK1TVXmbbIAjbC3RiP5LmCKbcTAXP9pkQFj7YjwqmqtQjiMCnFkqk5U
         Z1nod42CZ3yxlEMFhU1giALx6nxMZURvV4/AuUgzM6TGRmcWxVFxltgtk8YPUmrekXw7
         6+Hmt3YSTGCOlsEu8rPZpXlS7SVypmwLCjbdakyOuLSeTmw2uLtBK7yUss40+OBgSKfB
         zfzg==
X-Forwarded-Encrypted: i=1; AJvYcCVSC2vzyZC9zIRMdVBDDPfob3k84BaW6193h+FfsLKV6PvQH6GTX70HNAwG6PtMZ9mNxMQ0958=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZnr7s8et2XvL/nK9Kg3U7Wdb2vpY6D3XlGi77PCOfllmIctSi
	DjHsmkh6rW/VvzJGw2fUjXAgipHXF5NMnx5xbj9gJ5L0GRNLnAxx54Vx4z6cn2WqRsI=
X-Gm-Gg: ASbGncuTa51THYHGyOl4J72kAwGb4knVcZAyjBfT/59f4hCcSZaGkWHsYSJbTIubqTl
	K82djNRdDOpYPrmHzt1L6/1+aFHPV8rSUmgKLUil8MVbsmJXy0pRgFuoUucVgWCapCk2ygh606/
	JBjW+EgoTFk7v2I4IR8to+FrNlAow+pbUmSMn1SgyOOfbUzjvX2RUYr43JsayXs4V2C+30CDBAP
	L6Fs7XmFEEUbADIducgMKT2azNre0F/IPiRV35f2YhtUvXVi8sRRvW0YuYtUpn/X4jo5XM+Fybz
	R/nA24flphb8BDUbwBLl9qLEY39Pyt8hy4Qv+dceVPYtD3DrH8nQXf091AaL3J9JOxM4lpBieAb
	oIAWlS88bkRl4OvQ0+u/NxUpmuKy9WdL+8QPhCwIYYGAKQ6g=
X-Google-Smtp-Source: AGHT+IFeAJHgY/j+Fez17CQfHLYhf0FQG7BF961z8l1+YAbJSr7p5+xWCv2D/EY5UKln3h660s1nqg==
X-Received: by 2002:a05:6000:288a:b0:3e3:5166:e098 with SMTP id ffacd0b85a97d-3e35166e4e7mr1043659f8f.17.1757063115711;
        Fri, 05 Sep 2025 02:05:15 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd07480d5sm34118215e9.8.2025.09.05.02.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:05:15 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 3/3] net: WQ_PERCPU added to alloc_workqueue users
Date: Fri,  5 Sep 2025 11:05:05 +0200
Message-ID: <20250905090505.104882-4-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905090505.104882-1-marco.crivellari@suse.com>
References: <20250905090505.104882-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistentcy cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This patch adds a new WQ_PERCPU flag at the network subsystem, to explicitly
request the use of the per-CPU behavior. Both flags coexist for one release
cycle to allow callers to transition their calls.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

All existing users have been updated accordingly.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/net/can/spi/hi311x.c                             | 3 ++-
 drivers/net/can/spi/mcp251x.c                            | 3 ++-
 drivers/net/ethernet/cavium/liquidio/lio_core.c          | 2 +-
 drivers/net/ethernet/cavium/liquidio/lio_main.c          | 8 +++++---
 drivers/net/ethernet/cavium/liquidio/lio_vf_main.c       | 3 ++-
 drivers/net/ethernet/cavium/liquidio/request_manager.c   | 2 +-
 drivers/net/ethernet/cavium/liquidio/response_manager.c  | 3 ++-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c         | 2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c  | 3 ++-
 drivers/net/ethernet/intel/fm10k/fm10k_main.c            | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c              | 2 +-
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c          | 2 +-
 drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c   | 2 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c      | 2 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c      | 2 +-
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c | 3 ++-
 drivers/net/ethernet/marvell/prestera/prestera_main.c    | 2 +-
 drivers/net/ethernet/marvell/prestera/prestera_pci.c     | 2 +-
 drivers/net/ethernet/mellanox/mlxsw/core.c               | 4 ++--
 drivers/net/ethernet/netronome/nfp/nfp_main.c            | 2 +-
 drivers/net/ethernet/qlogic/qed/qed_main.c               | 3 ++-
 drivers/net/ethernet/wiznet/w5100.c                      | 2 +-
 drivers/net/fjes/fjes_main.c                             | 5 +++--
 drivers/net/wireguard/device.c                           | 6 ++++--
 drivers/net/wireless/ath/ath6kl/usb.c                    | 2 +-
 drivers/net/wireless/marvell/libertas/if_sdio.c          | 3 ++-
 drivers/net/wireless/marvell/libertas/if_spi.c           | 3 ++-
 drivers/net/wireless/marvell/libertas_tf/main.c          | 2 +-
 drivers/net/wireless/quantenna/qtnfmac/core.c            | 3 ++-
 drivers/net/wireless/realtek/rtlwifi/base.c              | 2 +-
 drivers/net/wireless/realtek/rtw88/usb.c                 | 3 ++-
 drivers/net/wireless/silabs/wfx/main.c                   | 2 +-
 drivers/net/wireless/st/cw1200/bh.c                      | 4 ++--
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c               | 3 ++-
 drivers/net/wwan/wwan_hwsim.c                            | 2 +-
 net/ceph/messenger.c                                     | 3 ++-
 net/core/sock_diag.c                                     | 2 +-
 net/rds/ib_rdma.c                                        | 3 ++-
 net/rxrpc/rxperf.c                                       | 2 +-
 net/smc/af_smc.c                                         | 6 +++---
 net/smc/smc_core.c                                       | 2 +-
 net/tls/tls_device.c                                     | 2 +-
 net/vmw_vsock/virtio_transport.c                         | 2 +-
 net/vmw_vsock/vsock_loopback.c                           | 2 +-
 44 files changed, 71 insertions(+), 52 deletions(-)

diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
index 09ae218315d7..96f23311b4ee 100644
--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -770,7 +770,8 @@ static int hi3110_open(struct net_device *net)
 		goto out_close;
 	}
 
-	priv->wq = alloc_workqueue("hi3110_wq", WQ_FREEZABLE | WQ_MEM_RECLAIM,
+	priv->wq = alloc_workqueue("hi3110_wq",
+				   WQ_FREEZABLE | WQ_MEM_RECLAIM | WQ_PERCPU,
 				   0);
 	if (!priv->wq) {
 		ret = -ENOMEM;
diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index ec5c64006a16..ec8c9193c4e4 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -1365,7 +1365,8 @@ static int mcp251x_can_probe(struct spi_device *spi)
 	if (ret)
 		goto out_clk;
 
-	priv->wq = alloc_workqueue("mcp251x_wq", WQ_FREEZABLE | WQ_MEM_RECLAIM,
+	priv->wq = alloc_workqueue("mcp251x_wq",
+				   WQ_FREEZABLE | WQ_MEM_RECLAIM | WQ_PERCPU,
 				   0);
 	if (!priv->wq) {
 		ret = -ENOMEM;
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_core.c b/drivers/net/ethernet/cavium/liquidio/lio_core.c
index 674c54831875..215dac201b4a 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_core.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_core.c
@@ -472,7 +472,7 @@ int setup_rx_oom_poll_fn(struct net_device *netdev)
 		q_no = lio->linfo.rxpciq[q].s.q_no;
 		wq = &lio->rxq_status_wq[q_no];
 		wq->wq = alloc_workqueue("rxq-oom-status",
-					 WQ_MEM_RECLAIM, 0);
+					 WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 		if (!wq->wq) {
 			dev_err(&oct->pci_dev->dev, "unable to create cavium rxq oom status wq\n");
 			return -ENOMEM;
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index 1d79f6eaa41f..8e2fcec26ea1 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -526,7 +526,8 @@ static inline int setup_link_status_change_wq(struct net_device *netdev)
 	struct octeon_device *oct = lio->oct_dev;
 
 	lio->link_status_wq.wq = alloc_workqueue("link-status",
-						 WQ_MEM_RECLAIM, 0);
+						 WQ_MEM_RECLAIM | WQ_PERCPU,
+						 0);
 	if (!lio->link_status_wq.wq) {
 		dev_err(&oct->pci_dev->dev, "unable to create cavium link status wq\n");
 		return -1;
@@ -659,7 +660,8 @@ static inline int setup_sync_octeon_time_wq(struct net_device *netdev)
 	struct octeon_device *oct = lio->oct_dev;
 
 	lio->sync_octeon_time_wq.wq =
-		alloc_workqueue("update-octeon-time", WQ_MEM_RECLAIM, 0);
+		alloc_workqueue("update-octeon-time",
+				WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 	if (!lio->sync_octeon_time_wq.wq) {
 		dev_err(&oct->pci_dev->dev, "Unable to create wq to update octeon time\n");
 		return -1;
@@ -1734,7 +1736,7 @@ static inline int setup_tx_poll_fn(struct net_device *netdev)
 	struct octeon_device *oct = lio->oct_dev;
 
 	lio->txq_status_wq.wq = alloc_workqueue("txq-status",
-						WQ_MEM_RECLAIM, 0);
+						WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 	if (!lio->txq_status_wq.wq) {
 		dev_err(&oct->pci_dev->dev, "unable to create cavium txq status wq\n");
 		return -1;
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
index 62c2eadc33e3..3230dff5ba05 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
@@ -304,7 +304,8 @@ static int setup_link_status_change_wq(struct net_device *netdev)
 	struct octeon_device *oct = lio->oct_dev;
 
 	lio->link_status_wq.wq = alloc_workqueue("link-status",
-						 WQ_MEM_RECLAIM, 0);
+						 WQ_MEM_RECLAIM | WQ_PERCPU,
+						 0);
 	if (!lio->link_status_wq.wq) {
 		dev_err(&oct->pci_dev->dev, "unable to create cavium link status wq\n");
 		return -1;
diff --git a/drivers/net/ethernet/cavium/liquidio/request_manager.c b/drivers/net/ethernet/cavium/liquidio/request_manager.c
index de8a6ce86ad7..8b8e9953c4ee 100644
--- a/drivers/net/ethernet/cavium/liquidio/request_manager.c
+++ b/drivers/net/ethernet/cavium/liquidio/request_manager.c
@@ -132,7 +132,7 @@ int octeon_init_instr_queue(struct octeon_device *oct,
 	oct->fn_list.setup_iq_regs(oct, iq_no);
 
 	oct->check_db_wq[iq_no].wq = alloc_workqueue("check_iq_db",
-						     WQ_MEM_RECLAIM,
+						     WQ_MEM_RECLAIM | WQ_PERCPU,
 						     0);
 	if (!oct->check_db_wq[iq_no].wq) {
 		vfree(iq->request_list);
diff --git a/drivers/net/ethernet/cavium/liquidio/response_manager.c b/drivers/net/ethernet/cavium/liquidio/response_manager.c
index 861050966e18..de1a8335b545 100644
--- a/drivers/net/ethernet/cavium/liquidio/response_manager.c
+++ b/drivers/net/ethernet/cavium/liquidio/response_manager.c
@@ -39,7 +39,8 @@ int octeon_setup_response_list(struct octeon_device *oct)
 	}
 	spin_lock_init(&oct->cmd_resp_wqlock);
 
-	oct->dma_comp_wq.wq = alloc_workqueue("dma-comp", WQ_MEM_RECLAIM, 0);
+	oct->dma_comp_wq.wq = alloc_workqueue("dma-comp",
+					      WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 	if (!oct->dma_comp_wq.wq) {
 		dev_err(&oct->pci_dev->dev, "failed to create wq thread\n");
 		return -ENOMEM;
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 29886a8ba73f..c689993a3cb0 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -4844,7 +4844,7 @@ static int dpaa2_eth_probe(struct fsl_mc_device *dpni_dev)
 	priv->tx_tstamp_type = HWTSTAMP_TX_OFF;
 	priv->rx_tstamp = false;
 
-	priv->dpaa2_ptp_wq = alloc_workqueue("dpaa2_ptp_wq", 0, 0);
+	priv->dpaa2_ptp_wq = alloc_workqueue("dpaa2_ptp_wq", WQ_PERCPU, 0);
 	if (!priv->dpaa2_ptp_wq) {
 		err = -ENOMEM;
 		goto err_wq_alloc;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 3e28a08934ab..b3c06bb3d6be 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -12906,7 +12906,8 @@ static int __init hclge_init(void)
 {
 	pr_info("%s is initializing\n", HCLGE_NAME);
 
-	hclge_wq = alloc_workqueue("%s", WQ_UNBOUND, 0, HCLGE_NAME);
+	hclge_wq = alloc_workqueue("%s", WQ_UNBOUND, 0,
+				   HCLGE_NAME);
 	if (!hclge_wq) {
 		pr_err("%s: failed to create workqueue\n", HCLGE_NAME);
 		return -ENOMEM;
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index 142f07ca8bc0..b8c15b837fda 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -37,7 +37,7 @@ static int __init fm10k_init_module(void)
 	pr_info("%s\n", fm10k_copyright);
 
 	/* create driver workqueue */
-	fm10k_workqueue = alloc_workqueue("%s", WQ_MEM_RECLAIM, 0,
+	fm10k_workqueue = alloc_workqueue("%s", WQ_MEM_RECLAIM | WQ_PERCPU, 0,
 					  fm10k_driver_name);
 	if (!fm10k_workqueue)
 		return -ENOMEM;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 120d68654e3f..73d9416803f7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -16690,7 +16690,7 @@ static int __init i40e_init_module(void)
 	 * since we need to be able to guarantee forward progress even under
 	 * memory pressure.
 	 */
-	i40e_wq = alloc_workqueue("%s", 0, 0, i40e_driver_name);
+	i40e_wq = alloc_workqueue("%s", WQ_PERCPU, 0, i40e_driver_name);
 	if (!i40e_wq) {
 		pr_err("%s: Failed to create workqueue\n", i40e_driver_name);
 		return -ENOMEM;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 0b27a695008b..524ff869a91b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -1955,7 +1955,7 @@ static int cgx_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	/* init wq for processing linkup requests */
 	INIT_WORK(&cgx->cgx_cmd_work, cgx_lmac_linkup_work);
-	cgx->cgx_cmd_workq = alloc_workqueue("cgx_cmd_workq", 0, 0);
+	cgx->cgx_cmd_workq = alloc_workqueue("cgx_cmd_workq", WQ_PERCPU, 0);
 	if (!cgx->cgx_cmd_workq) {
 		dev_err(dev, "alloc workqueue failed for cgx cmd");
 		err = -ENOMEM;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c b/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
index 655dd4726d36..2b0cf25ba517 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
@@ -911,7 +911,7 @@ int rvu_mcs_init(struct rvu *rvu)
 	/* Initialize the wq for handling mcs interrupts */
 	INIT_LIST_HEAD(&rvu->mcs_intrq_head);
 	INIT_WORK(&rvu->mcs_intr_work, mcs_intr_handler_task);
-	rvu->mcs_intr_wq = alloc_workqueue("mcs_intr_wq", 0, 0);
+	rvu->mcs_intr_wq = alloc_workqueue("mcs_intr_wq", WQ_PERCPU, 0);
 	if (!rvu->mcs_intr_wq) {
 		dev_err(rvu->dev, "mcs alloc workqueue failed\n");
 		return -ENOMEM;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index 992fa0b82e8d..ddae82ee8ccc 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -313,7 +313,7 @@ static int cgx_lmac_event_handler_init(struct rvu *rvu)
 	spin_lock_init(&rvu->cgx_evq_lock);
 	INIT_LIST_HEAD(&rvu->cgx_evq_head);
 	INIT_WORK(&rvu->cgx_evh_work, cgx_evhandler_task);
-	rvu->cgx_evh_wq = alloc_workqueue("rvu_evh_wq", 0, 0);
+	rvu->cgx_evh_wq = alloc_workqueue("rvu_evh_wq", WQ_PERCPU, 0);
 	if (!rvu->cgx_evh_wq) {
 		dev_err(rvu->dev, "alloc workqueue failed");
 		return -ENOMEM;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
index 052ae5923e3a..258557978ab2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
@@ -375,7 +375,7 @@ int rvu_rep_install_mcam_rules(struct rvu *rvu)
 	spin_lock_init(&rvu->rep_evtq_lock);
 	INIT_LIST_HEAD(&rvu->rep_evtq_head);
 	INIT_WORK(&rvu->rep_evt_work, rvu_rep_wq_handler);
-	rvu->rep_evt_wq = alloc_workqueue("rep_evt_wq", 0, 0);
+	rvu->rep_evt_wq = alloc_workqueue("rep_evt_wq", WQ_PERCPU, 0);
 	if (!rvu->rep_evt_wq) {
 		dev_err(rvu->dev, "REP workqueue allocation failed\n");
 		return -ENOMEM;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
index fc59e50bafce..0fdc12b345be 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
@@ -798,7 +798,8 @@ int cn10k_ipsec_init(struct net_device *netdev)
 	pf->ipsec.sa_size = sa_size;
 
 	INIT_WORK(&pf->ipsec.sa_work, cn10k_ipsec_sa_wq_handler);
-	pf->ipsec.sa_workq = alloc_workqueue("cn10k_ipsec_sa_workq", 0, 0);
+	pf->ipsec.sa_workq = alloc_workqueue("cn10k_ipsec_sa_workq",
+					     WQ_PERCPU, 0);
 	if (!pf->ipsec.sa_workq) {
 		netdev_err(pf->netdev, "SA alloc workqueue failed\n");
 		return -ENOMEM;
diff --git a/drivers/net/ethernet/marvell/prestera/prestera_main.c b/drivers/net/ethernet/marvell/prestera/prestera_main.c
index 71ffb55d1fc4..65e7ef033bde 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_main.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_main.c
@@ -1500,7 +1500,7 @@ EXPORT_SYMBOL(prestera_device_unregister);
 
 static int __init prestera_module_init(void)
 {
-	prestera_wq = alloc_workqueue("prestera", 0, 0);
+	prestera_wq = alloc_workqueue("prestera", WQ_PERCPU, 0);
 	if (!prestera_wq)
 		return -ENOMEM;
 
diff --git a/drivers/net/ethernet/marvell/prestera/prestera_pci.c b/drivers/net/ethernet/marvell/prestera/prestera_pci.c
index 35857dc19542..982a477ebb7f 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_pci.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_pci.c
@@ -898,7 +898,7 @@ static int prestera_pci_probe(struct pci_dev *pdev,
 
 	dev_info(fw->dev.dev, "Prestera FW is ready\n");
 
-	fw->wq = alloc_workqueue("prestera_fw_wq", WQ_HIGHPRI, 1);
+	fw->wq = alloc_workqueue("prestera_fw_wq", WQ_HIGHPRI | WQ_PERCPU, 1);
 	if (!fw->wq) {
 		err = -ENOMEM;
 		goto err_wq_alloc;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.c b/drivers/net/ethernet/mellanox/mlxsw/core.c
index 2bb2b77351bd..8a5d47a846c6 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.c
@@ -886,7 +886,7 @@ static int mlxsw_emad_init(struct mlxsw_core *mlxsw_core)
 	if (!(mlxsw_core->bus->features & MLXSW_BUS_F_TXRX))
 		return 0;
 
-	emad_wq = alloc_workqueue("mlxsw_core_emad", 0, 0);
+	emad_wq = alloc_workqueue("mlxsw_core_emad", WQ_PERCPU, 0);
 	if (!emad_wq)
 		return -ENOMEM;
 	mlxsw_core->emad_wq = emad_wq;
@@ -3381,7 +3381,7 @@ static int __init mlxsw_core_module_init(void)
 	if (err)
 		return err;
 
-	mlxsw_wq = alloc_workqueue(mlxsw_core_driver_name, 0, 0);
+	mlxsw_wq = alloc_workqueue(mlxsw_core_driver_name, WQ_PERCPU, 0);
 	if (!mlxsw_wq) {
 		err = -ENOMEM;
 		goto err_alloc_workqueue;
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_main.c b/drivers/net/ethernet/netronome/nfp/nfp_main.c
index 71301dbd8fb5..48390b2fd44d 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_main.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_main.c
@@ -797,7 +797,7 @@ static int nfp_pci_probe(struct pci_dev *pdev,
 	pf->pdev = pdev;
 	pf->dev_info = dev_info;
 
-	pf->wq = alloc_workqueue("nfp-%s", 0, 2, pci_name(pdev));
+	pf->wq = alloc_workqueue("nfp-%s", WQ_PERCPU, 2, pci_name(pdev));
 	if (!pf->wq) {
 		err = -ENOMEM;
 		goto err_pci_priv_unset;
diff --git a/drivers/net/ethernet/qlogic/qed/qed_main.c b/drivers/net/ethernet/qlogic/qed/qed_main.c
index 886061d7351a..d4685ad4b169 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_main.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_main.c
@@ -1214,7 +1214,8 @@ static int qed_slowpath_wq_start(struct qed_dev *cdev)
 		hwfn = &cdev->hwfns[i];
 
 		hwfn->slowpath_wq = alloc_workqueue("slowpath-%02x:%02x.%02x",
-					 0, 0, cdev->pdev->bus->number,
+					 WQ_PERCPU, 0,
+					 cdev->pdev->bus->number,
 					 PCI_SLOT(cdev->pdev->devfn),
 					 hwfn->abs_pf_id);
 
diff --git a/drivers/net/ethernet/wiznet/w5100.c b/drivers/net/ethernet/wiznet/w5100.c
index b77f096eaf99..c5424d882135 100644
--- a/drivers/net/ethernet/wiznet/w5100.c
+++ b/drivers/net/ethernet/wiznet/w5100.c
@@ -1142,7 +1142,7 @@ int w5100_probe(struct device *dev, const struct w5100_ops *ops,
 	if (err < 0)
 		goto err_register;
 
-	priv->xfer_wq = alloc_workqueue("%s", WQ_MEM_RECLAIM, 0,
+	priv->xfer_wq = alloc_workqueue("%s", WQ_MEM_RECLAIM | WQ_PERCPU, 0,
 					netdev_name(ndev));
 	if (!priv->xfer_wq) {
 		err = -ENOMEM;
diff --git a/drivers/net/fjes/fjes_main.c b/drivers/net/fjes/fjes_main.c
index 4a4ed2ccf72f..b63965d9a1ba 100644
--- a/drivers/net/fjes/fjes_main.c
+++ b/drivers/net/fjes/fjes_main.c
@@ -1364,14 +1364,15 @@ static int fjes_probe(struct platform_device *plat_dev)
 	adapter->force_reset = false;
 	adapter->open_guard = false;
 
-	adapter->txrx_wq = alloc_workqueue(DRV_NAME "/txrx", WQ_MEM_RECLAIM, 0);
+	adapter->txrx_wq = alloc_workqueue(DRV_NAME "/txrx",
+					   WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 	if (unlikely(!adapter->txrx_wq)) {
 		err = -ENOMEM;
 		goto err_free_netdev;
 	}
 
 	adapter->control_wq = alloc_workqueue(DRV_NAME "/control",
-					      WQ_MEM_RECLAIM, 0);
+					      WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 	if (unlikely(!adapter->control_wq)) {
 		err = -ENOMEM;
 		goto err_free_txrx_wq;
diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
index 3ffeeba5dccf..f6cc68e433ee 100644
--- a/drivers/net/wireguard/device.c
+++ b/drivers/net/wireguard/device.c
@@ -333,7 +333,8 @@ static int wg_newlink(struct net_device *dev,
 		goto err_free_peer_hashtable;
 
 	wg->handshake_receive_wq = alloc_workqueue("wg-kex-%s",
-			WQ_CPU_INTENSIVE | WQ_FREEZABLE, 0, dev->name);
+			WQ_CPU_INTENSIVE | WQ_FREEZABLE | WQ_PERCPU, 0,
+			dev->name);
 	if (!wg->handshake_receive_wq)
 		goto err_free_index_hashtable;
 
@@ -343,7 +344,8 @@ static int wg_newlink(struct net_device *dev,
 		goto err_destroy_handshake_receive;
 
 	wg->packet_crypt_wq = alloc_workqueue("wg-crypt-%s",
-			WQ_CPU_INTENSIVE | WQ_MEM_RECLAIM, 0, dev->name);
+			WQ_CPU_INTENSIVE | WQ_MEM_RECLAIM | WQ_PERCPU, 0,
+			dev->name);
 	if (!wg->packet_crypt_wq)
 		goto err_destroy_handshake_send;
 
diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless/ath/ath6kl/usb.c
index 5220809841a6..e281bfe40fa7 100644
--- a/drivers/net/wireless/ath/ath6kl/usb.c
+++ b/drivers/net/wireless/ath/ath6kl/usb.c
@@ -637,7 +637,7 @@ static struct ath6kl_usb *ath6kl_usb_create(struct usb_interface *interface)
 	ar_usb = kzalloc(sizeof(struct ath6kl_usb), GFP_KERNEL);
 	if (ar_usb == NULL)
 		return NULL;
-	ar_usb->wq = alloc_workqueue("ath6kl_wq", 0, 0);
+	ar_usb->wq = alloc_workqueue("ath6kl_wq", WQ_PERCPU, 0);
 	if (!ar_usb->wq) {
 		kfree(ar_usb);
 		return NULL;
diff --git a/drivers/net/wireless/marvell/libertas/if_sdio.c b/drivers/net/wireless/marvell/libertas/if_sdio.c
index 524034699972..1e29e80cad61 100644
--- a/drivers/net/wireless/marvell/libertas/if_sdio.c
+++ b/drivers/net/wireless/marvell/libertas/if_sdio.c
@@ -1181,7 +1181,8 @@ static int if_sdio_probe(struct sdio_func *func,
 	spin_lock_init(&card->lock);
 	INIT_LIST_HEAD(&card->packets);
 
-	card->workqueue = alloc_workqueue("libertas_sdio", WQ_MEM_RECLAIM, 0);
+	card->workqueue = alloc_workqueue("libertas_sdio",
+					  WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 	if (unlikely(!card->workqueue)) {
 		ret = -ENOMEM;
 		goto err_queue;
diff --git a/drivers/net/wireless/marvell/libertas/if_spi.c b/drivers/net/wireless/marvell/libertas/if_spi.c
index b722a6587fd3..699bae8971f8 100644
--- a/drivers/net/wireless/marvell/libertas/if_spi.c
+++ b/drivers/net/wireless/marvell/libertas/if_spi.c
@@ -1153,7 +1153,8 @@ static int if_spi_probe(struct spi_device *spi)
 	priv->fw_ready = 1;
 
 	/* Initialize interrupt handling stuff. */
-	card->workqueue = alloc_workqueue("libertas_spi", WQ_MEM_RECLAIM, 0);
+	card->workqueue = alloc_workqueue("libertas_spi",
+					  WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 	if (!card->workqueue) {
 		err = -ENOMEM;
 		goto remove_card;
diff --git a/drivers/net/wireless/marvell/libertas_tf/main.c b/drivers/net/wireless/marvell/libertas_tf/main.c
index a57a11be57d8..1fc4b8c6e079 100644
--- a/drivers/net/wireless/marvell/libertas_tf/main.c
+++ b/drivers/net/wireless/marvell/libertas_tf/main.c
@@ -708,7 +708,7 @@ EXPORT_SYMBOL_GPL(lbtf_bcn_sent);
 static int __init lbtf_init_module(void)
 {
 	lbtf_deb_enter(LBTF_DEB_MAIN);
-	lbtf_wq = alloc_workqueue("libertastf", WQ_MEM_RECLAIM, 0);
+	lbtf_wq = alloc_workqueue("libertastf", WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 	if (lbtf_wq == NULL) {
 		printk(KERN_ERR "libertastf: couldn't create workqueue\n");
 		return -ENOMEM;
diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.c b/drivers/net/wireless/quantenna/qtnfmac/core.c
index 825b05dd3271..38af6cdc2843 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.c
@@ -714,7 +714,8 @@ int qtnf_core_attach(struct qtnf_bus *bus)
 		goto error;
 	}
 
-	bus->hprio_workqueue = alloc_workqueue("QTNF_HPRI", WQ_HIGHPRI, 0);
+	bus->hprio_workqueue = alloc_workqueue("QTNF_HPRI",
+					       WQ_HIGHPRI | WQ_PERCPU, 0);
 	if (!bus->hprio_workqueue) {
 		pr_err("failed to alloc high prio workqueue\n");
 		ret = -ENOMEM;
diff --git a/drivers/net/wireless/realtek/rtlwifi/base.c b/drivers/net/wireless/realtek/rtlwifi/base.c
index 6189edc1d8d7..30d295f65602 100644
--- a/drivers/net/wireless/realtek/rtlwifi/base.c
+++ b/drivers/net/wireless/realtek/rtlwifi/base.c
@@ -445,7 +445,7 @@ static int _rtl_init_deferred_work(struct ieee80211_hw *hw)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct workqueue_struct *wq;
 
-	wq = alloc_workqueue("%s", 0, 0, rtlpriv->cfg->name);
+	wq = alloc_workqueue("%s", WQ_PERCPU, 0, rtlpriv->cfg->name);
 	if (!wq)
 		return -ENOMEM;
 
diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index c8092fa0d9f1..8338bfa0522e 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -909,7 +909,8 @@ static int rtw_usb_init_rx(struct rtw_dev *rtwdev)
 	struct sk_buff *rx_skb;
 	int i;
 
-	rtwusb->rxwq = alloc_workqueue("rtw88_usb: rx wq", WQ_BH, 0);
+	rtwusb->rxwq = alloc_workqueue("rtw88_usb: rx wq", WQ_BH | WQ_PERCPU,
+				       0);
 	if (!rtwusb->rxwq) {
 		rtw_err(rtwdev, "failed to create RX work queue\n");
 		return -ENOMEM;
diff --git a/drivers/net/wireless/silabs/wfx/main.c b/drivers/net/wireless/silabs/wfx/main.c
index a61128debbad..dda36e41eed1 100644
--- a/drivers/net/wireless/silabs/wfx/main.c
+++ b/drivers/net/wireless/silabs/wfx/main.c
@@ -364,7 +364,7 @@ int wfx_probe(struct wfx_dev *wdev)
 	wdev->pdata.gpio_wakeup = NULL;
 	wdev->poll_irq = true;
 
-	wdev->bh_wq = alloc_workqueue("wfx_bh_wq", WQ_HIGHPRI, 0);
+	wdev->bh_wq = alloc_workqueue("wfx_bh_wq", WQ_HIGHPRI | WQ_PERCPU, 0);
 	if (!wdev->bh_wq)
 		return -ENOMEM;
 
diff --git a/drivers/net/wireless/st/cw1200/bh.c b/drivers/net/wireless/st/cw1200/bh.c
index 3b4ded2ac801..3f07f4e1deee 100644
--- a/drivers/net/wireless/st/cw1200/bh.c
+++ b/drivers/net/wireless/st/cw1200/bh.c
@@ -54,8 +54,8 @@ int cw1200_register_bh(struct cw1200_common *priv)
 	int err = 0;
 	/* Realtime workqueue */
 	priv->bh_workqueue = alloc_workqueue("cw1200_bh",
-				WQ_MEM_RECLAIM | WQ_HIGHPRI
-				| WQ_CPU_INTENSIVE, 1);
+				WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_CPU_INTENSIVE | WQ_PERCPU,
+				1);
 
 	if (!priv->bh_workqueue)
 		return -ENOMEM;
diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
index 6a7a26085fc7..2310493203d3 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
+++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
@@ -1085,7 +1085,8 @@ static void t7xx_dpmaif_bat_release_work(struct work_struct *work)
 int t7xx_dpmaif_bat_rel_wq_alloc(struct dpmaif_ctrl *dpmaif_ctrl)
 {
 	dpmaif_ctrl->bat_release_wq = alloc_workqueue("dpmaif_bat_release_work_queue",
-						      WQ_MEM_RECLAIM, 1);
+						      WQ_MEM_RECLAIM | WQ_PERCPU,
+						      1);
 	if (!dpmaif_ctrl->bat_release_wq)
 		return -ENOMEM;
 
diff --git a/drivers/net/wwan/wwan_hwsim.c b/drivers/net/wwan/wwan_hwsim.c
index b02befd1b6fb..733688cd4607 100644
--- a/drivers/net/wwan/wwan_hwsim.c
+++ b/drivers/net/wwan/wwan_hwsim.c
@@ -509,7 +509,7 @@ static int __init wwan_hwsim_init(void)
 	if (wwan_hwsim_devsnum < 0 || wwan_hwsim_devsnum > 128)
 		return -EINVAL;
 
-	wwan_wq = alloc_workqueue("wwan_wq", 0, 0);
+	wwan_wq = alloc_workqueue("wwan_wq", WQ_PERCPU, 0);
 	if (!wwan_wq)
 		return -ENOMEM;
 
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index d1b5705dc0c6..183c1e0b405a 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -252,7 +252,8 @@ int __init ceph_msgr_init(void)
 	 * The number of active work items is limited by the number of
 	 * connections, so leave @max_active at default.
 	 */
-	ceph_msgr_wq = alloc_workqueue("ceph-msgr", WQ_MEM_RECLAIM, 0);
+	ceph_msgr_wq = alloc_workqueue("ceph-msgr",
+				       WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 	if (ceph_msgr_wq)
 		return 0;
 
diff --git a/net/core/sock_diag.c b/net/core/sock_diag.c
index a08eed9b9142..dcd7e8c02169 100644
--- a/net/core/sock_diag.c
+++ b/net/core/sock_diag.c
@@ -350,7 +350,7 @@ static struct pernet_operations diag_net_ops = {
 
 static int __init sock_diag_init(void)
 {
-	broadcast_wq = alloc_workqueue("sock_diag_events", 0, 0);
+	broadcast_wq = alloc_workqueue("sock_diag_events", WQ_PERCPU, 0);
 	BUG_ON(!broadcast_wq);
 	return register_pernet_subsys(&diag_net_ops);
 }
diff --git a/net/rds/ib_rdma.c b/net/rds/ib_rdma.c
index d1cfceeff133..6585164c7059 100644
--- a/net/rds/ib_rdma.c
+++ b/net/rds/ib_rdma.c
@@ -672,7 +672,8 @@ struct rds_ib_mr_pool *rds_ib_create_mr_pool(struct rds_ib_device *rds_ibdev,
 
 int rds_ib_mr_init(void)
 {
-	rds_ib_mr_wq = alloc_workqueue("rds_mr_flushd", WQ_MEM_RECLAIM, 0);
+	rds_ib_mr_wq = alloc_workqueue("rds_mr_flushd",
+				       WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 	if (!rds_ib_mr_wq)
 		return -ENOMEM;
 	return 0;
diff --git a/net/rxrpc/rxperf.c b/net/rxrpc/rxperf.c
index e848a4777b8c..a92a2b05c19a 100644
--- a/net/rxrpc/rxperf.c
+++ b/net/rxrpc/rxperf.c
@@ -584,7 +584,7 @@ static int __init rxperf_init(void)
 
 	pr_info("Server registering\n");
 
-	rxperf_workqueue = alloc_workqueue("rxperf", 0, 0);
+	rxperf_workqueue = alloc_workqueue("rxperf", WQ_PERCPU, 0);
 	if (!rxperf_workqueue)
 		goto error_workqueue;
 
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 3e6cb35baf25..f69d5657438b 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -3518,15 +3518,15 @@ static int __init smc_init(void)
 
 	rc = -ENOMEM;
 
-	smc_tcp_ls_wq = alloc_workqueue("smc_tcp_ls_wq", 0, 0);
+	smc_tcp_ls_wq = alloc_workqueue("smc_tcp_ls_wq", WQ_PERCPU, 0);
 	if (!smc_tcp_ls_wq)
 		goto out_pnet;
 
-	smc_hs_wq = alloc_workqueue("smc_hs_wq", 0, 0);
+	smc_hs_wq = alloc_workqueue("smc_hs_wq", WQ_PERCPU, 0);
 	if (!smc_hs_wq)
 		goto out_alloc_tcp_ls_wq;
 
-	smc_close_wq = alloc_workqueue("smc_close_wq", 0, 0);
+	smc_close_wq = alloc_workqueue("smc_close_wq", WQ_PERCPU, 0);
 	if (!smc_close_wq)
 		goto out_alloc_hs_wq;
 
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index ab870109f916..9d9a703e884e 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -896,7 +896,7 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
 		rc = SMC_CLC_DECL_MEM;
 		goto ism_put_vlan;
 	}
-	lgr->tx_wq = alloc_workqueue("smc_tx_wq-%*phN", 0, 0,
+	lgr->tx_wq = alloc_workqueue("smc_tx_wq-%*phN", WQ_PERCPU, 0,
 				     SMC_LGR_ID_SIZE, &lgr->id);
 	if (!lgr->tx_wq) {
 		rc = -ENOMEM;
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index f672a62a9a52..939466316761 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -1410,7 +1410,7 @@ int __init tls_device_init(void)
 	if (!dummy_page)
 		return -ENOMEM;
 
-	destruct_wq = alloc_workqueue("ktls_device_destruct", 0, 0);
+	destruct_wq = alloc_workqueue("ktls_device_destruct", WQ_PERCPU, 0);
 	if (!destruct_wq) {
 		err = -ENOMEM;
 		goto err_free_dummy;
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index f0e48e6911fc..b3e960108e6b 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -916,7 +916,7 @@ static int __init virtio_vsock_init(void)
 {
 	int ret;
 
-	virtio_vsock_workqueue = alloc_workqueue("virtio_vsock", 0, 0);
+	virtio_vsock_workqueue = alloc_workqueue("virtio_vsock", WQ_PERCPU, 0);
 	if (!virtio_vsock_workqueue)
 		return -ENOMEM;
 
diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
index 6e78927a598e..bc2ff918b315 100644
--- a/net/vmw_vsock/vsock_loopback.c
+++ b/net/vmw_vsock/vsock_loopback.c
@@ -139,7 +139,7 @@ static int __init vsock_loopback_init(void)
 	struct vsock_loopback *vsock = &the_vsock_loopback;
 	int ret;
 
-	vsock->workqueue = alloc_workqueue("vsock-loopback", 0, 0);
+	vsock->workqueue = alloc_workqueue("vsock-loopback", WQ_PERCPU, 0);
 	if (!vsock->workqueue)
 		return -ENOMEM;
 
-- 
2.51.0


