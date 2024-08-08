Return-Path: <netdev+bounces-116941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAA994C1F8
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 17:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1403A1F2363E
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 15:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323D518FDA2;
	Thu,  8 Aug 2024 15:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="tQWdTW49"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAB418E749
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 15:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723132298; cv=none; b=UqrSknxj8U7z5V07Fpgn12VtIM26hhmet3TFtF1zrSMAFh13iLMvKhCH+ZMD/B1wsmqhwNaP5uaWWVTxbU8UVg91KBtyy5ST9lJTz9jAFuCBYoys3R3QmdJArsjpSXPcymXpuplJIhVooRs0+ZM3JdSme9NlPOAfZ7vmp6klO4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723132298; c=relaxed/simple;
	bh=IltF7IATghJwaQXpVHgEYprU2zZg0XnM92fZvG8KeZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwCGwvpHjLokImJcb1Ac5DW7NR+oVfw8X0cnWDeJOS7pJMp+sRoRnYF1nc2WE6m2oNS55ckSd0dnHakaxU8hJWVoco5/Qm/dDZvuqo1FukllSACcJS1H7w5QJiKslKss2HGZEJPtUBLLRn9nK5+jmbrHknwJA8z9T6eRd9sb/OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=tQWdTW49; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5af6a1afa7bso1326732a12.1
        for <netdev@vger.kernel.org>; Thu, 08 Aug 2024 08:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1723132294; x=1723737094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=llL7APjaPMslsEgAnpwJGRd9iQrJJFrS2hzBip67FIA=;
        b=tQWdTW49WFpZH47eIEUOQftX1JHKDroUl1bFwnNpsHT2FRU7nDg/re0sM86x/XDsTC
         AyjDiiOb4FqlUv9x2zIz8LXzE7UQVqWoY4VHZhpq6vns+Ev30EPa4HswEDwIKo4b6qx2
         R+/Ue2ARbJrZKQnN2SZqZjZ/zOiWt1U/S25d43sPTJh/oacUJjTUrsPoFAW0w9V93KvC
         qroiWzPDhgQqPsfWkYnh1+boCpRy5ZSySCt3Tx0Aph8R4JMSIOHqnz6waJdc2JSu/Nji
         7ixEDuROss7A4NYGEDo7byMQ1K/uQP+br7hgwqZsTOTF+OZtopC8+XeMLzcgMOYoen9g
         asQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723132294; x=1723737094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llL7APjaPMslsEgAnpwJGRd9iQrJJFrS2hzBip67FIA=;
        b=tk0vefDaYKLnKirLCvygXGl4NvN+kif8Zzgle0KyISRA2gZKZIi4UWxyCBBYnvfzI7
         FavsEyJcnA8Gjhj4t4pYM0MEqPB0F6fNmirEI10K/U2aP2DEpwbmAtQCBtM3fbqSGoLE
         SotgKsydQx+9F/C/qzUHBX2w0dAyQYfIcDUKVyMTG0K7ZqLJjz8q6XKJZwwSd/6TUF8W
         mW66xSYDj81iQKxJGCfD2/IPaXBDHOYmK6Fxspfjthu0aiVZVrC0l13NSu1IhVgj5DSb
         kPyrz/36jDwAOff/jdOB3QLXX5KUvoFPufkjB5xqhbf0KuWqhpJUiu9lwtUe9PFvt8Ca
         qbvw==
X-Gm-Message-State: AOJu0YzdqpCUSci0fxYfoYQ/uS7aN8+lcxDcWfwiEvl7GAQe8OwetYo4
	qMsvlnJGU3gB/87dizD/8hgyfFmCcXWURQ3jeCoM4hOJsvcoXmzJVvCwJIHn6wB/xRsuxlisxBv
	L
X-Google-Smtp-Source: AGHT+IEv2In8TqzaJ0SPI4x9KZZDMKkmkeTP9Wekd3wyt3FsyjSp1iEjFi9PRk8LqGsB/9lKjMdIhQ==
X-Received: by 2002:a05:6402:5204:b0:5a2:a808:a2e0 with SMTP id 4fb4d7f45d1cf-5bbb21f4142mr1768639a12.4.1723132293907;
        Thu, 08 Aug 2024 08:51:33 -0700 (PDT)
Received: from localhost ([213.235.133.38])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2c41ec9sm786337a12.42.2024.08.08.08.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 08:51:33 -0700 (PDT)
Date: Thu, 8 Aug 2024 17:51:31 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH v10 03/11] octeontx2-pf: Create representor
 netdev
Message-ID: <ZrTpgw9tmQprbuNk@nanopsycho.orion>
References: <20240805131815.7588-1-gakula@marvell.com>
 <20240805131815.7588-4-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805131815.7588-4-gakula@marvell.com>

Mon, Aug 05, 2024 at 03:18:07PM CEST, gakula@marvell.com wrote:
>Adds initial devlink support to set/get the switchdev mode.
>Representor netdevs are created for each rvu devices when
>the switch mode is set to 'switchdev'. These netdevs are
>be used to control and configure VFs.
>
>Signed-off-by: Geetha sowjanya <gakula@marvell.com>
>Reviewed-by: Simon Horman <horms@kernel.org>
>---
> .../ethernet/marvell/octeontx2.rst            |  85 +++++++++
> .../marvell/octeontx2/nic/otx2_devlink.c      |  49 ++++++
> .../net/ethernet/marvell/octeontx2/nic/rep.c  | 165 ++++++++++++++++++
> .../net/ethernet/marvell/octeontx2/nic/rep.h  |   3 +
> 4 files changed, 302 insertions(+)
>
>diff --git a/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst b/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst
>index 1e196cb9ce25..4eb4e6788ffc 100644
>--- a/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst
>+++ b/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst
>@@ -14,6 +14,7 @@ Contents
> - `Basic packet flow`_
> - `Devlink health reporters`_
> - `Quality of service`_
>+- `RVU representors`_
> 
> Overview
> ========
>@@ -340,3 +341,87 @@ Setup HTB offload
>         # tc class add dev <interface> parent 1: classid 1:2 htb rate 10Gbit prio 2 quantum 188416
> 
>         # tc class add dev <interface> parent 1: classid 1:3 htb rate 10Gbit prio 2 quantum 32768
>+
>+
>+RVU Representors
>+================
>+
>+RVU representor driver adds support for creation of representor devices for
>+RVU PFs' VFs in the system. Representor devices are created when user enables
>+the switchdev mode.
>+Switchdev mode can be enabled either before or after setting up SRIOV numVFs.
>+All representor devices share a single NIXLF but each has a dedicated queue
>+(ie RQ/SQ. RVU PF representor driver registers a separate netdev for each
>+RQ/SQ queue pair.
>+
>+HW doesn't have a in-built switch which can do L2 learning and forward pkts
>+between representee and representor. Hence packet patch between representee
>+and it's representor is achieved by setting up appropriate NPC MCAM filters.
>+Transmit packets matching these filters will be loopbacked through hardware
>+loopback channel/interface (ie instead of sending them out of MAC interface).
>+Which will again match the installed filters and will be forwarded.
>+This way representee => representor and representor => representee packet
>+path is achieved.These rules get installed when representors are created
>+and gets active/deactivate based on the representor/representee interface state.
>+
>+Usage example:
>+
>+ - List of devices on the system before vfs are created::
>+
>+	# devlink dev
>+	pci/0002:02:00.0
>+	pci/0002:1c:00.0
>+
>+- Change device to switchdev mode::
>+	# devlink dev eswitch set pci/0002:1c:00.0 mode switchdev
>+
>+ - List the devices on the system::
>+
>+	# ip link show
>+
>+Sample output::
>+
>+	# ip link show
>+	eth0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000 link/ether 7e:58:2d:b6:97:51 brd ff:ff:ff:ff:ff:ff
>+	r0p1v0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000 link/ether 7e:5a:66:ea:fe:d6 brd ff:ff:ff:ff:ff:ff
>+	r1p1v1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000 link/ether de:29:be:10:9e:bf brd ff:ff:ff:ff:ff:ff
>+	r2p1v2: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000 link/ether 4a:12:c7:a2:66:ad brd ff:ff:ff:ff:ff:ff
>+	r3p1v3: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000 link/ether c2:b8:a8:0e:73:fd brd ff:ff:ff:ff:ff:ff
>+
>+
>+RVU representors can be managed using devlink ports
>+(see :ref:`Documentation/networking/devlink/devlink-port.rst <devlink_port>`) interface.
>+
>+ - Show devlink ports of representors::
>+
>+	# devlink port
>+
>+Sample output::
>+
>+	pci/0002:1c:00.0/0: type eth netdev r0p1v0 flavour pcipf controller 0 pfnum 1 vfnum 0 external false splittable false
>+	pci/0002:1c:00.0/1: type eth netdev r1p1v1 flavour pcivf controller 0 pfnum 1 vfnum 1 external false splittable false
>+	pci/0002:1c:00.0/2: type eth netdev r2p1v2 flavour pcivf controller 0 pfnum 1 vfnum 2 external false splittable false
>+	pci/0002:1c:00.0/3: type eth netdev r3p1v3 flavour pcivf controller 0 pfnum 1 vfnum 3 external false splittable false
>+
>+Function attributes
>+===================
>+
>+The RVU representor support function attributes for representors
>+Port function configuration of the representors are supported through devlink eswitch port.
>+
>+MAC address setup
>+-----------------
>+
>+RVU representor driver support devlink port function attr mechanism to setup MAC
>+address. (refer to Documentation/networking/devlink/devlink-port.rst)
>+
>+ - To setup MAC address for port 2::
>+
>+	# devlink port function set  pci/0002:1c:00.0/2 hw_addr 5c:a1:1b:5e:43:11 state active

Why you pass "state active" here? That is no-op for VFs.


>+
>+
>+To remove the representors from the system. Change the device to legacy mode.
>+
>+ - Change device to legacy mode::
>+
>+	# devlink dev eswitch set pci/0002:1c:00.0 mode legacy
>diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
>index 53f14aa944bd..33ec9a7f7c03 100644
>--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
>+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
>@@ -141,7 +141,56 @@ static const struct devlink_param otx2_dl_params[] = {
> 			     otx2_dl_ucast_flt_cnt_validate),
> };
> 
>+#ifdef CONFIG_RVU_ESWITCH
>+static int otx2_devlink_eswitch_mode_get(struct devlink *devlink, u16 *mode)
>+{
>+	struct otx2_devlink *otx2_dl = devlink_priv(devlink);
>+	struct otx2_nic *pfvf = otx2_dl->pfvf;
>+
>+	if (!otx2_rep_dev(pfvf->pdev))
>+		return -EOPNOTSUPP;
>+
>+	*mode = pfvf->esw_mode;
>+
>+	return 0;
>+}
>+
>+static int otx2_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
>+					 struct netlink_ext_ack *extack)
>+{
>+	struct otx2_devlink *otx2_dl = devlink_priv(devlink);
>+	struct otx2_nic *pfvf = otx2_dl->pfvf;
>+	int ret = 0;
>+
>+	if (!otx2_rep_dev(pfvf->pdev))
>+		return -EOPNOTSUPP;
>+
>+	if (pfvf->esw_mode == mode)
>+		return 0;
>+
>+	switch (mode) {
>+	case DEVLINK_ESWITCH_MODE_LEGACY:
>+		rvu_rep_destroy(pfvf);
>+		break;
>+	case DEVLINK_ESWITCH_MODE_SWITCHDEV:
>+		ret = rvu_rep_create(pfvf, extack);
>+		break;
>+	default:
>+		return -EINVAL;
>+	}
>+
>+	if (!ret)
>+		pfvf->esw_mode = mode;
>+
>+	return ret;
>+}
>+#endif
>+
> static const struct devlink_ops otx2_devlink_ops = {
>+#ifdef CONFIG_RVU_ESWITCH
>+	.eswitch_mode_get = otx2_devlink_eswitch_mode_get,
>+	.eswitch_mode_set = otx2_devlink_eswitch_mode_set,
>+#endif
> };
> 
> int otx2_register_dl(struct otx2_nic *pfvf)
>diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
>index b0a0080e50d7..6ea5b4904a7c 100644
>--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
>+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
>@@ -28,6 +28,164 @@ MODULE_DESCRIPTION(DRV_STRING);
> MODULE_LICENSE("GPL");
> MODULE_DEVICE_TABLE(pci, rvu_rep_id_table);
> 
>+static int rvu_rep_napi_init(struct otx2_nic *priv,
>+			     struct netlink_ext_ack *extack)
>+{
>+	struct otx2_qset *qset = &priv->qset;
>+	struct otx2_cq_poll *cq_poll = NULL;
>+	struct otx2_hw *hw = &priv->hw;
>+	int err = 0, qidx, vec;
>+	char *irq_name;
>+
>+	qset->napi = kcalloc(hw->cint_cnt, sizeof(*cq_poll), GFP_KERNEL);
>+	if (!qset->napi)
>+		return -ENOMEM;
>+
>+	/* Register NAPI handler */
>+	for (qidx = 0; qidx < hw->cint_cnt; qidx++) {
>+		cq_poll = &qset->napi[qidx];
>+		cq_poll->cint_idx = qidx;
>+		cq_poll->cq_ids[CQ_RX] =
>+			(qidx <  hw->rx_queues) ? qidx : CINT_INVALID_CQ;
>+		cq_poll->cq_ids[CQ_TX] = (qidx < hw->tx_queues) ?
>+					  qidx + hw->rx_queues :
>+					  CINT_INVALID_CQ;
>+		cq_poll->cq_ids[CQ_XDP] = CINT_INVALID_CQ;
>+		cq_poll->cq_ids[CQ_QOS] = CINT_INVALID_CQ;
>+
>+		cq_poll->dev = (void *)priv;
>+		netif_napi_add(priv->reps[qidx]->netdev, &cq_poll->napi,
>+			       otx2_napi_handler);
>+		napi_enable(&cq_poll->napi);
>+	}
>+	/* Register CQ IRQ handlers */
>+	vec = hw->nix_msixoff + NIX_LF_CINT_VEC_START;
>+	for (qidx = 0; qidx < hw->cint_cnt; qidx++) {
>+		irq_name = &hw->irq_name[vec * NAME_SIZE];
>+
>+		snprintf(irq_name, NAME_SIZE, "rep%d-rxtx-%d", qidx, qidx);
>+
>+		err = request_irq(pci_irq_vector(priv->pdev, vec),
>+				  otx2_cq_intr_handler, 0, irq_name,
>+				  &qset->napi[qidx]);
>+		if (err) {
>+			NL_SET_ERR_MSG_FMT_MOD(extack,
>+					       "RVU REP IRQ registration failed for CQ%d",
>+					       qidx);
>+			goto err_free_cints;
>+		}
>+		vec++;
>+
>+		/* Enable CQ IRQ */
>+		otx2_write64(priv, NIX_LF_CINTX_INT(qidx), BIT_ULL(0));
>+		otx2_write64(priv, NIX_LF_CINTX_ENA_W1S(qidx), BIT_ULL(0));
>+	}
>+	priv->flags &= ~OTX2_FLAG_INTF_DOWN;
>+	return 0;
>+
>+err_free_cints:
>+	otx2_free_cints(priv, qidx);
>+	otx2_disable_napi(priv);
>+	return err;
>+}
>+
>+static void rvu_rep_free_cq_rsrc(struct otx2_nic *priv)
>+{
>+	struct otx2_qset *qset = &priv->qset;
>+	struct otx2_cq_poll *cq_poll = NULL;
>+	int qidx, vec;
>+
>+	/* Cleanup CQ NAPI and IRQ */
>+	vec = priv->hw.nix_msixoff + NIX_LF_CINT_VEC_START;
>+	for (qidx = 0; qidx < priv->hw.cint_cnt; qidx++) {
>+		/* Disable interrupt */
>+		otx2_write64(priv, NIX_LF_CINTX_ENA_W1C(qidx), BIT_ULL(0));
>+
>+		synchronize_irq(pci_irq_vector(priv->pdev, vec));
>+
>+		cq_poll = &qset->napi[qidx];
>+		napi_synchronize(&cq_poll->napi);
>+		vec++;
>+	}
>+	otx2_free_cints(priv, priv->hw.cint_cnt);
>+	otx2_disable_napi(priv);
>+}
>+
>+void rvu_rep_destroy(struct otx2_nic *priv)
>+{
>+	struct rep_dev *rep;
>+	int rep_id;
>+
>+	priv->flags |= OTX2_FLAG_INTF_DOWN;
>+	rvu_rep_free_cq_rsrc(priv);
>+	for (rep_id = 0; rep_id < priv->rep_cnt; rep_id++) {
>+		rep = priv->reps[rep_id];
>+		unregister_netdev(rep->netdev);
>+		free_netdev(rep->netdev);
>+	}
>+	kfree(priv->reps);
>+}
>+
>+int rvu_rep_create(struct otx2_nic *priv, struct netlink_ext_ack *extack)
>+{
>+	int rep_cnt = priv->rep_cnt;
>+	struct net_device *ndev;
>+	struct rep_dev *rep;
>+	int rep_id, err;
>+	u16 pcifunc;
>+
>+	priv->reps = kcalloc(rep_cnt, sizeof(struct rep_dev *), GFP_KERNEL);
>+	if (!priv->reps)
>+		return -ENOMEM;
>+
>+	for (rep_id = 0; rep_id < rep_cnt; rep_id++) {
>+		ndev = alloc_etherdev(sizeof(*rep));
>+		if (!ndev) {
>+			NL_SET_ERR_MSG_FMT_MOD(extack,
>+					       "PFVF representor:%d creation failed",
>+					       rep_id);
>+			err = -ENOMEM;
>+			goto exit;
>+		}
>+
>+		rep = netdev_priv(ndev);
>+		priv->reps[rep_id] = rep;
>+		rep->mdev = priv;
>+		rep->netdev = ndev;
>+		rep->rep_id = rep_id;
>+
>+		ndev->min_mtu = OTX2_MIN_MTU;
>+		ndev->max_mtu = priv->hw.max_mtu;
>+		pcifunc = priv->rep_pf_map[rep_id];
>+		rep->pcifunc = pcifunc;
>+
>+		snprintf(ndev->name, sizeof(ndev->name), "r%dp%d", rep_id,
>+			 rvu_get_pf(pcifunc));
>+
>+		eth_hw_addr_random(ndev);
>+		err = register_netdev(ndev);

I don't follow. You just create netdevices, no devlink ports. That is
inconsistent with your documentation above.


>+		if (err) {
>+			NL_SET_ERR_MSG_MOD(extack,
>+					   "PFVF reprentator registration failed");
>+			free_netdev(ndev);
>+			goto exit;
>+		}
>+	}
>+	err = rvu_rep_napi_init(priv, extack);
>+	if (err)
>+		goto exit;
>+
>+	return 0;
>+exit:
>+	while (--rep_id >= 0) {
>+		rep = priv->reps[rep_id];
>+		unregister_netdev(rep->netdev);
>+		free_netdev(rep->netdev);
>+	}
>+	kfree(priv->reps);
>+	return err;
>+}
>+
> static void rvu_rep_rsrc_free(struct otx2_nic *priv)
> {
> 	struct otx2_qset *qset = &priv->qset;
>@@ -167,6 +325,10 @@ static int rvu_rep_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> 	if (err)
> 		goto err_detach_rsrc;
> 
>+	err = otx2_register_dl(priv);
>+	if (err)
>+		goto err_detach_rsrc;
>+
> 	return 0;
> 
> err_detach_rsrc:
>@@ -188,6 +350,9 @@ static void rvu_rep_remove(struct pci_dev *pdev)
> {
> 	struct otx2_nic *priv = pci_get_drvdata(pdev);
> 
>+	otx2_unregister_dl(priv);
>+	if (!(priv->flags & OTX2_FLAG_INTF_DOWN))
>+		rvu_rep_destroy(priv);
> 	rvu_rep_rsrc_free(priv);
> 	otx2_detach_resources(&priv->mbox);
> 	if (priv->hw.lmt_info)
>diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.h b/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
>index 565e75628df2..c04874c4d4c6 100644
>--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
>+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
>@@ -28,4 +28,7 @@ static inline bool otx2_rep_dev(struct pci_dev *pdev)
> {
> 	return pdev->device == PCI_DEVID_RVU_REP;
> }
>+
>+int rvu_rep_create(struct otx2_nic *priv, struct netlink_ext_ack *extack);
>+void rvu_rep_destroy(struct otx2_nic *priv);
> #endif /* REP_H */
>-- 
>2.25.1
>
>

