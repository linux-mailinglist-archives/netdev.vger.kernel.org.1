Return-Path: <netdev+bounces-301711-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JJ/EOcACPGo0iggAu9opvQ
	(envelope-from <netdev+bounces-301711-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 18:16:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B72B6BFEF3
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 18:16:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=zbFrCbjA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301711-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301711-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE776300D14F
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 16:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711C01B78F3;
	Wed, 24 Jun 2026 16:15:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0555A78F3A;
	Wed, 24 Jun 2026 16:15:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782317758; cv=none; b=ULzCzh65FczIBGXRFHvP+8PvweeApremKmvMX4UARHinUSMQBApjDRiAy3+WXeq70mjFJYS77DgF/uy4PW4HXofbNG/QtVXsrGf1c7JEOiu1AItFFHnhvrf8VZX+Pminu/Cv7/hkYjtjuO399Upvl1Yc/qGWlPkWshEkzHCmPEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782317758; c=relaxed/simple;
	bh=evE72iBnepmuEVf7F1JayoufXy9qjWrv9pQTEJJex68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDzLmuXXWlHqs0qrqU2aqDOdK/QhHGl4nWbsLm0vhVegqhRcvTWEXk2KKTBKyvoA0eZq+tJBq6UsROo/2JdLRYAsLYxeRwuI13gcfl2w//j6LbFT827oIAn8I5G4wqVoMxPIpR1pJflpDCee1yhH0R+1TxQupYRnvXgG2XtGAXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zbFrCbjA; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=C/KIgQ42qvKpfhlsSKyF2HuauF1ECg4OdEJw3N/MxDE=; b=zbFrCbjAVWSr9s/Viyahf2Olbs
	oTCo4yIjsXdPR24Ttlmx4kTxQXI8ylSJ9k1iCBYbolL65pl78MI2bF9pydBeML/noASJ4tMOyHWpC
	6aBGrmDevD7vE41CyvPDSgLfC5gUPFIl+HZwR/zpqp+4/fLNW977+zmJbh7JowiPQJlI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wcQGH-00978o-CO; Wed, 24 Jun 2026 18:15:37 +0200
Date: Wed, 24 Jun 2026 18:15:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: jackbb_wu@compal.com
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Wen-Zhi Huang <wen-zhi.huang@mediatek.com>,
	Shi-Wei Yeh <shi-wei.yeh@mediatek.com>,
	Minano Tseng <Minano.tseng@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 3/7] net: wwan: t9xx: Add control DMA interface
Message-ID: <dc007021-9013-47b2-b06a-fe4a50d26722@lunn.ch>
References: <20260624-t9xx_driver_v1-v3-0-73ff03f60c48@compal.com>
 <20260624-t9xx_driver_v1-v3-3-73ff03f60c48@compal.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624-t9xx_driver_v1-v3-3-73ff03f60c48@compal.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301711-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,mediatek.com,collabora.com,lwn.net,linuxfoundation.org,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jackbb_wu@compal.com,m:loic.poulain@oss.qualcomm.com,m:ryazanov.s.a@gmail.com,m:johannes@sipsolutions.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:wen-zhi.huang@mediatek.com,m:shi-wei.yeh@mediatek.com,m:Minano.tseng@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:linux-doc@vger.kernel.org,m:ryazanovsa@gmail.com,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B72B6BFEF3

> diff --git a/drivers/net/wwan/t9xx/pcie/mtk_cldma.c b/drivers/net/wwan/t9xx/pcie/mtk_cldma.c

> +static inline void mtk_cldma_clr_bd_dsc(struct cldma_drv_info *drv_info,
> +					struct bd_dsc *bd_dsc_pool, int nr_bds)

No inline functions in C files. Please let the compiler decide.

> +static int mtk_cldma_reload_rx_skb(struct mtk_md_dev *mdev, struct rxq *rxq,
> +				   struct rx_req *req)
> +{
> +	struct sk_buff *tail = NULL;
> +	struct bd_dsc *bd_dsc;
> +	int nr_bds;
> +	int i, ret;
> +
> +	nr_bds = rxq->nr_bds;
> +
> +	for (i = 0; i < nr_bds; i++) {
> +		bd_dsc = req->bd_dsc_pool + i;
> +		bd_dsc->skb = __dev_alloc_skb(req->frag_size, GFP_KERNEL);
> +		if (!bd_dsc->skb) {
> +			dev_warn((mdev)->dev, "Failed to alloc SKB\n");

You might want to rate limit this, and the other similar messages in
the data path, otherwise it could be a DOS.

> +u32 mtk_cldma_stop_queue(struct cldma_drv_info *drv_info, enum mtk_tx_rx dir, u32 qno)
> +{
> +	u32 val = (qno == ALLQ) ? qno : BIT(qno);
> +	struct cldma_hw_regs *hw_regs;
> +	unsigned int active;
> +	int cnt = 0;
> +	int base;
> +	u32 addr;
> +
> +	hw_regs = drv_info->hw_regs;
> +	base = drv_info->base_addr;
> +
> +	if (dir == DIR_TX)
> +		addr = base + hw_regs->reg_cldma_ul_stop_cmd;
> +	else
> +		addr = base + hw_regs->reg_cldma_so_stop_cmd;
> +
> +	mtk_pci_write32(drv_info->mdev, addr, val);
> +
> +	do {
> +		active = drv_info->drv_ops->cldma_queue_status(drv_info, dir, qno);
> +		if (active == LINK_ERROR_VAL || !active)
> +			break;
> +		usleep_range(WAIT_QUEUE_STOP, 2 * WAIT_QUEUE_STOP);
> +	} while (++cnt < 10);

Please use one of the helpers from iopoll.h. Any loops waiting for an
event to happen should use those macros, since the open code
implementation is often wrong.

> +static int mtk_ctrl_trb_srv_init(struct mtk_ctrl_trans *trans)
> +{
> +	struct srv_que *srv_que;
> +	struct trb_srv *srv;
> +	int i, j;
> +	int ret;
> +
> +	for (i = 0; i < trans->trb_srv_num; i++) {
> +		srv = devm_kzalloc(trans->mdev->dev, sizeof(*srv), GFP_KERNEL);
> +		if (!srv) {
> +			ret = -ENOMEM;
> +			goto err_free_srv;
> +		}
> +
> +		srv->trans = trans;
> +		srv->srv_id = i;
> +		trans->trb_srv[i] = srv;
> +
> +		init_waitqueue_head(&srv->trb_waitq);
> +		for (j = 0; j < NR_CLDMA; j++)
> +			INIT_LIST_HEAD(&srv->srv_q_list[j]);
> +	}
> +
> +	for (i = 0; i < NR_CLDMA; i++)
> +		for (j = 0; j < HW_QUE_NUM; j++) {
> +			if (trans->srv_cfg[i][j] < 0 ||
> +			    trans->srv_cfg[i][j] >= trans->trb_srv_num)
> +				trans->srv_cfg[i][j] = 0;
> +			srv_que = devm_kzalloc(trans->mdev->dev, sizeof(*srv_que), GFP_KERNEL);
> +			if (!srv_que) {
> +				ret = -ENOMEM;
> +				goto err_free_srv_que;
> +			}
> +			srv_que->hif_id = i;
> +			srv_que->qno = j;
> +			list_add_tail(&srv_que->list,
> +				      &trans->trb_srv[trans->srv_cfg[i][j]]->srv_q_list[i]);
> +		}
> +
> +	for (i = 0; i < trans->trb_srv_num; i++) {
> +		trans->trb_srv[i]->trb_thread = kthread_run(mtk_ctrl_trb_thread, trans->trb_srv[i],
> +							    "mtk_trb_srv%d_%s", i,
> +							    trans->mdev->dev_str);
> +		if (IS_ERR(trans->trb_srv[i]->trb_thread)) {
> +			ret = PTR_ERR(trans->trb_srv[i]->trb_thread);
> +			trans->trb_srv[i]->trb_thread = NULL;
> +			goto err_stop_kthread;
> +		}
> +	}
> +
> +	return 0;
> +err_stop_kthread:
> +	while (--i >= 0)
> +		kthread_stop(trans->trb_srv[i]->trb_thread);
> +err_free_srv_que:
> +	for (i = 0; i < trans->trb_srv_num; i++) {
> +		for (j = 0; j < NR_CLDMA; j++) {
> +			struct srv_que *next_srv_que;
> +
> +			list_for_each_entry_safe(srv_que, next_srv_que,
> +						 &trans->trb_srv[i]->srv_q_list[j], list) {
> +				list_del(&srv_que->list);
> +				devm_kfree(trans->mdev->dev, srv_que);

It is unusual to see devm_kfree(). Why is it needed?

> +static unsigned int ctrl_port_chl_mtu;

Is this a global variable? Why is it not part of priv?

> +module_param(ctrl_port_chl_mtu, uint, 0644);
> +MODULE_PARM_DESC(ctrl_port_chl_mtu, "This is used to config the ctrl port mtu!\n");

Ah. No modules parameters please. If this is an MTU, why not use the
normal networking interfaces to set the MTU?

	Andrew

