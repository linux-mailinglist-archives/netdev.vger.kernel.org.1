Return-Path: <netdev+bounces-124593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C776D96A17C
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 17:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BAAEB21BFF
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 15:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21727155A47;
	Tue,  3 Sep 2024 15:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="kAoCGPzV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F86646BF
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 15:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725375658; cv=none; b=hX2b8yyTuTJPwkQhZz+z+efb0ahru5U41Q2WePvJmDZ1PM8rrNTWkSQhioP3wTOSeZ3r44aQSzW5GjYHqL7yGLv9rgBNHUfhKwHIcNtiG1SRvPXRZswtXSHsA1lG09vMUwpMPQvAgaISXHKg3m62iN6YRfWBiz70Gd+jcqKxI6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725375658; c=relaxed/simple;
	bh=9NZf6r19SXSR1f8T56UguvEHsLMsWYSmNBiLHUiUJP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HpbMJUF8c6evU1kjEhpYQyTiiOeE0dfD8MXKAgYU6MSYvN0VXCtNwSK33QKW742PMRHDs5ShW3BIW+c8f4XZ3hCyBfHOOiP2Jt6GdLlkXioijvqyej0u1hfspsnb/fFMokqNcCyI19GyO0QeX2GtyjPqKF3WO7OZGy999vJFAHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=kAoCGPzV; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c26852aff1so1815857a12.3
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 08:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1725375654; x=1725980454; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p+njFo7EVESa7CXOGlHhoswjsRjKBHov7OFHjW76uHs=;
        b=kAoCGPzVWUR9dG6v5fA4KBYj2izH9PFDfbAN6BOXP9cXkpKdKqa24Px9fFxczP7GyD
         S9vpV9UGJyOJ/1KvZ5fk8ftFJC5UjT1lVhhFiA4QdSrfzIWnTHQWt+Deia8Ik8t1s6io
         Q4xFIr/X7+eriKwB8l/IVK1hD4wzGNq60TBQJwHlWF2Ty3QgYUcg2emej9L2yOTHengY
         D5vs2RUAcaly4rn9XfADVwXMoWLA9xdcC+UJcHiZq5CCW1e2R72VrKpTk/BCu7NKzTeZ
         6jEG07k6UEYsA6HPYaNOXQ3AaEJe00czg4T74yiCQurnv6WU56iWzqcJDeTsCw3ODxlo
         2BMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725375654; x=1725980454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+njFo7EVESa7CXOGlHhoswjsRjKBHov7OFHjW76uHs=;
        b=uHBSxyiuu8rIUiElQ8B1BgPhAvyiR5SqY+Mr2wABAk1n+yvPCi5ssXBbuC8OT2itMC
         ZMeplxsz5ZYMAQQPbTT3nE6aDFl11XHGuzgxTMUo8HJCk4pxNAEH0TJdUOH9bmXkROTw
         YYWNO4UrHQPacb7OU9gYqg07LpQgGZnSAvjcbgJPKbAHOnavkwDc80Z/7tndHZazEVQf
         txgMBiBYgCrq9eoL++U+zP37dV0ScDDS1zgcKeP517fypELPd0xEkCh6/UEj7ZdbgRSX
         aDGF49NEFFPU1kIAdh/oUTdhz6lYS2Y6Sh5T1qFnMKnrqKG9lE9GiwF7QvhgQKx5o6Sj
         Usqw==
X-Gm-Message-State: AOJu0YxBbgQVgB62FZWd07Cj4uOJanl5ouetNy8QQIEoyxzreofnVgdc
	gMTXObMPQlkg/10TyesAcEdxX6YpsiGf3J+JnMNhn7BbIYwxCEgEhM2Updo5O9s=
X-Google-Smtp-Source: AGHT+IFrlrPpJBGY6j9ctDdtg1tx1gdIOpoYhhMMVIDy16Yi99PcuwGIXG+tuDLcWCpp87lQkWpwIg==
X-Received: by 2002:a05:6402:360b:b0:5c2:6090:4047 with SMTP id 4fb4d7f45d1cf-5c2609041c7mr4103380a12.8.1725375653570;
        Tue, 03 Sep 2024 08:00:53 -0700 (PDT)
Received: from localhost (78-80-104-44.customers.tmcz.cz. [78.80.104.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226ccff4bsm6611726a12.70.2024.09.03.08.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 08:00:52 -0700 (PDT)
Date: Tue, 3 Sep 2024 17:00:51 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH 4/4] octeontx2-pf: Export common APIs
Message-ID: <Ztcko0xVsTwSJBVw@nanopsycho.orion>
References: <20240903124048.14235-1-gakula@marvell.com>
 <20240903124048.14235-5-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903124048.14235-5-gakula@marvell.com>

Tue, Sep 03, 2024 at 02:40:48PM CEST, gakula@marvell.com wrote:
>Export mbox, hw resources and interrupt configuration functions.
>So, that they can be used later by the RVU representor driver.
>  
>Signed-off-by: Geetha sowjanya <gakula@marvell.com>
>---
> .../marvell/octeontx2/nic/otx2_common.c       |  2 +
> .../marvell/octeontx2/nic/otx2_common.h       | 11 +++++
> .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 40 +++++++++++++------
> .../marvell/octeontx2/nic/otx2_txrx.c         | 17 +++++---
> .../marvell/octeontx2/nic/otx2_txrx.h         |  3 +-
> .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  6 +--
> 6 files changed, 56 insertions(+), 23 deletions(-)
>
>diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
>index 34e76cfd941b..e38b3eea11f3 100644
>--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
>+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
>@@ -246,6 +246,7 @@ int otx2_hw_set_mtu(struct otx2_nic *pfvf, int mtu)
> 	mutex_unlock(&pfvf->mbox.lock);
> 	return err;
> }
>+EXPORT_SYMBOL(otx2_hw_set_mtu);
> 
> int otx2_config_pause_frm(struct otx2_nic *pfvf)
> {
>@@ -1782,6 +1783,7 @@ void otx2_free_cints(struct otx2_nic *pfvf, int n)
> 		free_irq(vector, &qset->napi[qidx]);
> 	}
> }
>+EXPORT_SYMBOL(otx2_free_cints);
> 
> void otx2_set_cints_affinity(struct otx2_nic *pfvf)
> {
>diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
>index b36b87dae2cb..327254e578d5 100644
>--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
>+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
>@@ -1000,6 +1000,17 @@ int otx2_aura_init(struct otx2_nic *pfvf, int aura_id,
> int otx2_init_rsrc(struct pci_dev *pdev, struct otx2_nic *pf);
> void otx2_free_queue_mem(struct otx2_qset *qset);
> int otx2_alloc_queue_mem(struct otx2_nic *pf);
>+int otx2_init_hw_resources(struct otx2_nic *pfvf);
>+void otx2_free_hw_resources(struct otx2_nic *pf);
>+int otx2_wq_init(struct otx2_nic *pf);
>+int otx2_check_pf_usable(struct otx2_nic *pf);
>+int otx2_pfaf_mbox_init(struct otx2_nic *pf);
>+int otx2_register_mbox_intr(struct otx2_nic *pf, bool probe_af);
>+int otx2_realloc_msix_vectors(struct otx2_nic *pf);
>+void otx2_pfaf_mbox_destroy(struct otx2_nic *pf);
>+void otx2_disable_mbox_intr(struct otx2_nic *pf);
>+void otx2_disable_napi(struct otx2_nic *pf);
>+irqreturn_t otx2_cq_intr_handler(int irq, void *cq_irq);
> 
> /* RSS configuration APIs*/
> int otx2_rss_init(struct otx2_nic *pfvf);
>diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
>index 5bb6db5a3a73..b4fa2c12721d 100644
>--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
>+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
>@@ -1008,7 +1008,7 @@ static irqreturn_t otx2_pfaf_mbox_intr_handler(int irq, void *pf_irq)
> 	return IRQ_HANDLED;
> }
> 
>-static void otx2_disable_mbox_intr(struct otx2_nic *pf)
>+void otx2_disable_mbox_intr(struct otx2_nic *pf)
> {
> 	int vector = pci_irq_vector(pf->pdev, RVU_PF_INT_VEC_AFPF_MBOX);
> 
>@@ -1016,8 +1016,9 @@ static void otx2_disable_mbox_intr(struct otx2_nic *pf)
> 	otx2_write64(pf, RVU_PF_INT_ENA_W1C, BIT_ULL(0));
> 	free_irq(vector, pf);
> }
>+EXPORT_SYMBOL(otx2_disable_mbox_intr);
> 
>-static int otx2_register_mbox_intr(struct otx2_nic *pf, bool probe_af)
>+int otx2_register_mbox_intr(struct otx2_nic *pf, bool probe_af)
> {
> 	struct otx2_hw *hw = &pf->hw;
> 	struct msg_req *req;
>@@ -1060,8 +1061,9 @@ static int otx2_register_mbox_intr(struct otx2_nic *pf, bool probe_af)
> 
> 	return 0;
> }
>+EXPORT_SYMBOL(otx2_register_mbox_intr);
> 
>-static void otx2_pfaf_mbox_destroy(struct otx2_nic *pf)
>+void otx2_pfaf_mbox_destroy(struct otx2_nic *pf)
> {
> 	struct mbox *mbox = &pf->mbox;
> 
>@@ -1076,8 +1078,9 @@ static void otx2_pfaf_mbox_destroy(struct otx2_nic *pf)
> 	otx2_mbox_destroy(&mbox->mbox);
> 	otx2_mbox_destroy(&mbox->mbox_up);
> }
>+EXPORT_SYMBOL(otx2_pfaf_mbox_destroy);
> 
>-static int otx2_pfaf_mbox_init(struct otx2_nic *pf)
>+int otx2_pfaf_mbox_init(struct otx2_nic *pf)
> {
> 	struct mbox *mbox = &pf->mbox;
> 	void __iomem *hwbase;
>@@ -1124,6 +1127,7 @@ static int otx2_pfaf_mbox_init(struct otx2_nic *pf)
> 	otx2_pfaf_mbox_destroy(pf);
> 	return err;
> }
>+EXPORT_SYMBOL(otx2_pfaf_mbox_init);
> 
> static int otx2_cgx_config_linkevents(struct otx2_nic *pf, bool enable)
> {
>@@ -1379,7 +1383,7 @@ static irqreturn_t otx2_q_intr_handler(int irq, void *data)
> 	return IRQ_HANDLED;
> }
> 
>-static irqreturn_t otx2_cq_intr_handler(int irq, void *cq_irq)
>+irqreturn_t otx2_cq_intr_handler(int irq, void *cq_irq)
> {
> 	struct otx2_cq_poll *cq_poll = (struct otx2_cq_poll *)cq_irq;
> 	struct otx2_nic *pf = (struct otx2_nic *)cq_poll->dev;
>@@ -1398,20 +1402,25 @@ static irqreturn_t otx2_cq_intr_handler(int irq, void *cq_irq)
> 
> 	return IRQ_HANDLED;
> }
>+EXPORT_SYMBOL(otx2_cq_intr_handler);
> 
>-static void otx2_disable_napi(struct otx2_nic *pf)
>+void otx2_disable_napi(struct otx2_nic *pf)
> {
> 	struct otx2_qset *qset = &pf->qset;
> 	struct otx2_cq_poll *cq_poll;
>+	struct work_struct *work;
> 	int qidx;
> 
> 	for (qidx = 0; qidx < pf->hw.cint_cnt; qidx++) {
> 		cq_poll = &qset->napi[qidx];
>-		cancel_work_sync(&cq_poll->dim.work);
>+		work = &cq_poll->dim.work;
>+		if (work->func)
>+			cancel_work_sync(work);
> 		napi_disable(&cq_poll->napi);
> 		netif_napi_del(&cq_poll->napi);
> 	}
> }
>+EXPORT_SYMBOL(otx2_disable_napi);
> 
> static void otx2_free_cq_res(struct otx2_nic *pf)
> {
>@@ -1477,7 +1486,7 @@ static int otx2_get_rbuf_size(struct otx2_nic *pf, int mtu)
> 	return ALIGN(rbuf_size, 2048);
> }
> 
>-static int otx2_init_hw_resources(struct otx2_nic *pf)
>+int otx2_init_hw_resources(struct otx2_nic *pf)
> {
> 	struct nix_lf_free_req *free_req;
> 	struct mbox *mbox = &pf->mbox;
>@@ -1601,8 +1610,9 @@ static int otx2_init_hw_resources(struct otx2_nic *pf)
> 	mutex_unlock(&mbox->lock);
> 	return err;
> }
>+EXPORT_SYMBOL(otx2_init_hw_resources);
> 
>-static void otx2_free_hw_resources(struct otx2_nic *pf)
>+void otx2_free_hw_resources(struct otx2_nic *pf)
> {
> 	struct otx2_qset *qset = &pf->qset;
> 	struct nix_lf_free_req *free_req;
>@@ -1688,6 +1698,7 @@ static void otx2_free_hw_resources(struct otx2_nic *pf)
> 	}
> 	mutex_unlock(&mbox->lock);
> }
>+EXPORT_SYMBOL(otx2_free_hw_resources);
> 
> static bool otx2_promisc_use_mce_list(struct otx2_nic *pfvf)
> {
>@@ -1781,6 +1792,7 @@ void otx2_free_queue_mem(struct otx2_qset *qset)
> 	kfree(qset->napi);
> }
> EXPORT_SYMBOL(otx2_free_queue_mem);
>+
> int otx2_alloc_queue_mem(struct otx2_nic *pf)
> {
> 	struct otx2_qset *qset = &pf->qset;
>@@ -2103,7 +2115,7 @@ static netdev_tx_t otx2_xmit(struct sk_buff *skb, struct net_device *netdev)
> 	sq = &pf->qset.sq[sq_idx];
> 	txq = netdev_get_tx_queue(netdev, qidx);
> 
>-	if (!otx2_sq_append_skb(netdev, sq, skb, qidx)) {
>+	if (!otx2_sq_append_skb(pf, txq, sq, skb, qidx)) {
> 		netif_tx_stop_queue(txq);
> 
> 		/* Check again, incase SQBs got freed up */
>@@ -2808,7 +2820,7 @@ static const struct net_device_ops otx2_netdev_ops = {
> 	.ndo_set_vf_trust	= otx2_ndo_set_vf_trust,
> };
> 
>-static int otx2_wq_init(struct otx2_nic *pf)
>+int otx2_wq_init(struct otx2_nic *pf)
> {
> 	pf->otx2_wq = create_singlethread_workqueue("otx2_wq");
> 	if (!pf->otx2_wq)
>@@ -2819,7 +2831,7 @@ static int otx2_wq_init(struct otx2_nic *pf)
> 	return 0;
> }
> 
>-static int otx2_check_pf_usable(struct otx2_nic *nic)
>+int otx2_check_pf_usable(struct otx2_nic *nic)
> {
> 	u64 rev;
> 
>@@ -2836,8 +2848,9 @@ static int otx2_check_pf_usable(struct otx2_nic *nic)
> 	}
> 	return 0;
> }
>+EXPORT_SYMBOL(otx2_check_pf_usable);
> 
>-static int otx2_realloc_msix_vectors(struct otx2_nic *pf)
>+int otx2_realloc_msix_vectors(struct otx2_nic *pf)
> {
> 	struct otx2_hw *hw = &pf->hw;
> 	int num_vec, err;
>@@ -2859,6 +2872,7 @@ static int otx2_realloc_msix_vectors(struct otx2_nic *pf)
> 
> 	return otx2_register_mbox_intr(pf, false);
> }
>+EXPORT_SYMBOL(otx2_realloc_msix_vectors);
> 
> static int otx2_sriov_vfcfg_init(struct otx2_nic *pf)
> {
>diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
>index 3eb85949677a..fbd9fe98259f 100644
>--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
>+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
>@@ -131,6 +131,7 @@ static void otx2_xdp_snd_pkt_handler(struct otx2_nic *pfvf,
> }
> 
> static void otx2_snd_pkt_handler(struct otx2_nic *pfvf,
>+				 struct net_device *ndev,
> 				 struct otx2_cq_queue *cq,
> 				 struct otx2_snd_queue *sq,
> 				 struct nix_cqe_tx_s *cqe,
>@@ -145,7 +146,7 @@ static void otx2_snd_pkt_handler(struct otx2_nic *pfvf,
> 
> 	if (unlikely(snd_comp->status) && netif_msg_tx_err(pfvf))
> 		net_err_ratelimited("%s: TX%d: Error in send CQ status:%x\n",
>-				    pfvf->netdev->name, cq->cint_idx,
>+				    ndev->name, cq->cint_idx,
> 				    snd_comp->status);
> 
> 	sg = &sq->sg[snd_comp->sqe_id];
>@@ -453,6 +454,7 @@ static int otx2_tx_napi_handler(struct otx2_nic *pfvf,
> 	int tx_pkts = 0, tx_bytes = 0, qidx;
> 	struct otx2_snd_queue *sq;
> 	struct nix_cqe_tx_s *cqe;
>+	struct net_device *ndev;
> 	int processed_cqe = 0;
> 
> 	if (cq->pend_cqe >= budget)
>@@ -464,6 +466,7 @@ static int otx2_tx_napi_handler(struct otx2_nic *pfvf,
> process_cqe:
> 	qidx = cq->cq_idx - pfvf->hw.rx_queues;
> 	sq = &pfvf->qset.sq[qidx];
>+	ndev = pfvf->netdev;
> 
> 	while (likely(processed_cqe < budget) && cq->pend_cqe) {
> 		cqe = (struct nix_cqe_tx_s *)otx2_get_next_cqe(cq);
>@@ -478,7 +481,8 @@ static int otx2_tx_napi_handler(struct otx2_nic *pfvf,
> 		if (cq->cq_type == CQ_XDP)
> 			otx2_xdp_snd_pkt_handler(pfvf, sq, cqe);
> 		else
>-			otx2_snd_pkt_handler(pfvf, cq, &pfvf->qset.sq[qidx],
>+			otx2_snd_pkt_handler(pfvf, ndev, cq,
>+					     &pfvf->qset.sq[qidx],
> 					     cqe, budget, &tx_pkts, &tx_bytes);
> 
> 		cqe->hdr.cqe_type = NIX_XQE_TYPE_INVALID;
>@@ -505,7 +509,7 @@ static int otx2_tx_napi_handler(struct otx2_nic *pfvf,
> 		/* Check if queue was stopped earlier due to ring full */
> 		smp_mb();
> 		if (netif_tx_queue_stopped(txq) &&
>-		    netif_carrier_ok(pfvf->netdev))
>+		    netif_carrier_ok(ndev))
> 			netif_tx_wake_queue(txq);


I don't understand the this change you do in otx2_tx_napi_handler() and
otx2_snd_pkt_handler(). What are you trying to achieve?
Also, it is unrelated to the rest of the patch (export functions)


> 	}
> 	return 0;
>@@ -594,6 +598,7 @@ int otx2_napi_handler(struct napi_struct *napi, int budget)
> 	}
> 	return workdone;
> }
>+EXPORT_SYMBOL(otx2_napi_handler);
> 
> void otx2_sqe_flush(void *dev, struct otx2_snd_queue *sq,
> 		    int size, int qidx)
>@@ -1141,13 +1146,13 @@ static void otx2_set_txtstamp(struct otx2_nic *pfvf, struct sk_buff *skb,
> 	}
> }
> 
>-bool otx2_sq_append_skb(struct net_device *netdev, struct otx2_snd_queue *sq,
>+bool otx2_sq_append_skb(void *dev, struct netdev_queue *txq,

1) This looks like unrelated to the rest of the patch (export functions)
2) Why void *? Avoid that please. Just have arg
struct otx2_nic *pfvf
no?



>+			struct otx2_snd_queue *sq,
> 			struct sk_buff *skb, u16 qidx)
> {
>-	struct netdev_queue *txq = netdev_get_tx_queue(netdev, qidx);
>-	struct otx2_nic *pfvf = netdev_priv(netdev);
> 	int offset, num_segs, free_desc;
> 	struct nix_sqe_hdr_s *sqe_hdr;
>+	struct otx2_nic *pfvf = dev;
> 
> 	/* Check if there is enough room between producer
> 	 * and consumer index.
>diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
>index 3f1d2655ff77..e1db5f961877 100644
>--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
>+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
>@@ -167,7 +167,8 @@ static inline u64 otx2_iova_to_phys(void *iommu_domain, dma_addr_t dma_addr)
> }
> 
> int otx2_napi_handler(struct napi_struct *napi, int budget);
>-bool otx2_sq_append_skb(struct net_device *netdev, struct otx2_snd_queue *sq,
>+bool otx2_sq_append_skb(void *dev, struct netdev_queue *txq,
>+			struct otx2_snd_queue *sq,
> 			struct sk_buff *skb, u16 qidx);
> void cn10k_sqe_flush(void *dev, struct otx2_snd_queue *sq,
> 		     int size, int qidx);
>diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
>index 79a8acac6283..0486fca8b573 100644
>--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
>+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
>@@ -395,7 +395,7 @@ static netdev_tx_t otx2vf_xmit(struct sk_buff *skb, struct net_device *netdev)
> 	sq = &vf->qset.sq[qidx];
> 	txq = netdev_get_tx_queue(netdev, qidx);
> 
>-	if (!otx2_sq_append_skb(netdev, sq, skb, qidx)) {
>+	if (!otx2_sq_append_skb(vf, txq, sq, skb, qidx)) {
> 		netif_tx_stop_queue(txq);
> 
> 		/* Check again, incase SQBs got freed up */
>@@ -500,7 +500,7 @@ static const struct net_device_ops otx2vf_netdev_ops = {
> 	.ndo_setup_tc = otx2_setup_tc,
> };
> 
>-static int otx2_wq_init(struct otx2_nic *vf)
>+static int otx2_vf_wq_init(struct otx2_nic *vf)
> {
> 	vf->otx2_wq = create_singlethread_workqueue("otx2vf_wq");
> 	if (!vf->otx2_wq)
>@@ -689,7 +689,7 @@ static int otx2vf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> 		goto err_ptp_destroy;
> 	}
> 
>-	err = otx2_wq_init(vf);
>+	err = otx2_vf_wq_init(vf);
> 	if (err)
> 		goto err_unreg_netdev;
> 
>-- 
>2.25.1
>

