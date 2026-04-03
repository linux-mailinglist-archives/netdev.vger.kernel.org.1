Return-Path: <netdev+bounces-274822-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLCMFmoUz2nXsgYAu9opvQ
	(envelope-from <netdev+bounces-274822-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 03:14:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D35A338FE4D
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 03:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2605A30241B1
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 01:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FAF271464;
	Fri,  3 Apr 2026 01:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EaDajJnG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305F5224AF9;
	Fri,  3 Apr 2026 01:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775178749; cv=none; b=lB30EgTtugL7jaJrG4S0nkSepYiB0hNwPmSORn4l/LzVgx30C1tyvh06WwTPUpA+u0uNJHI/qfSaCRzTSerCgO/v+QNJ3E232ducCtDE/UqdrzVKvu8J3LQEGQuuc39XBTyawJgsvGiPOHc2M/4JmtL9PZVsWlNPCeLHFKSwRow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775178749; c=relaxed/simple;
	bh=tgVI8ESKBIFQCUY2ygL+jTE2pS6yd4+CeEVqpP8vaCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UFXAEfnC6FKa+RpuI7DGRx3qyBEHWdc04W4fFPNcR03a2d74m9XxerjUeCa/vTepcvPrTTTnYbJkYPJw5SYHYUPfk3m8xo72tHnIl0xC2vgIoisMJSTeZWQ6DUcUC2e5TxLiL3FFr25+zKhLaJ0iP3CO3zUk3HqYWFpgLhr0aRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EaDajJnG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47078C116C6;
	Fri,  3 Apr 2026 01:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775178748;
	bh=tgVI8ESKBIFQCUY2ygL+jTE2pS6yd4+CeEVqpP8vaCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EaDajJnGxhQ4kknRlCCMgeRdDdq0D7TlMeA2iX8kgkAHlFGApqHHu+Dsx2FspoDK+
	 ibZnS8scvcaS4lrBtKFhQZ31Ga66SP2W83uYilpFkWQBSBhdsdU2B4fT8ej21N109c
	 QeueZ6UCRNzA4scfsdplZlLsOC9X2n4KN5LlaPmgRIdZgyn1JyOay7khaYkxasee6P
	 lbIKeLxzyKvLyloqyVppv5SuSJijvKh4HVknoPugbLfnswTPDj0R3dsZYcf98uxvdY
	 jCAbu5VEu/hoFZF7i7y2NE77+QQ2TM1em3yglIqeIAQbmPsu6NpGditOY6sSp78GIh
	 TxCS7T4iYAMQA==
From: Jakub Kicinski <kuba@kernel.org>
To: lorenzo@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ansuelsmth@gmail.com,
	benjamin.larsson@genexis.eu,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 09/11] net: airoha: Support multiple net_devices for a single FE GDM port
Date: Thu,  2 Apr 2026 18:12:08 -0700
Message-ID: <20260403011208.1784815-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401-airoha-eth-multi-serdes-v2-9-ac427ae4beeb@kernel.org>
References: <20260401-airoha-eth-multi-serdes-v2-9-ac427ae4beeb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-274822-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D35A338FE4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
Subject: net: airoha: Support multiple net_devices for a single FE GDM port

This commit introduces support for multiple net_devices connected to the
same Frame Engine (FE) GDM port via an external hardware arbiter. It
adds logic to parse device tree child nodes and instantiate separate
net_devices for TDM traffic from external SerDes.

> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> index 5e489e8593ba..0780fb8aacfb 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
[ ... ]
> @@ -614,9 +616,8 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
>  		u32 hash, reason, msg1 = le32_to_cpu(desc->msg1);
>  		struct page *page = virt_to_head_page(e->buf);
>  		u32 desc_ctrl = le32_to_cpu(desc->ctrl);
> -		struct airoha_gdm_port *port;
> -		struct net_device *netdev;
> -		int data_len, len, p;
> +		struct airoha_gdm_dev *dev;
> +		int data_len, len;
>  
>  		if (!(desc_ctrl & QDMA_DESC_DONE_MASK))
>  			break;
> @@ -633,12 +634,10 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
>  		if (!len || data_len < len)
>  			goto free_frag;
>  
> -		p = airoha_qdma_get_gdm_port(eth, desc);
> -		if (p < 0 || !eth->ports[p])
> +		dev = airoha_qdma_get_gdm_dev(eth, desc);
> +		if (IS_ERR(dev))
>  			goto free_frag;

If a scattered frame is being processed (q->skb is not NULL) and IS_ERR(dev)
triggers the goto free_frag, the error handler frees the skb:

free_frag:
	if (q->skb) {
		dev_kfree_skb(q->skb);
		q->skb = NULL;
	} else {
		page_pool_put_full_page(q->page_pool, page, true);
	}

Since the current fragment's page is not yet attached to q->skb, does this
skip the else branch and permanently leak the page pool buffer?

[ ... ]
> @@ -1747,9 +1748,7 @@ static int airoha_set_gdm2_loopback(struct airoha_gdm_dev *dev)
>  	airoha_fe_clear(eth, REG_FE_VIP_PORT_EN, BIT(AIROHA_GDM2_IDX));
>  	airoha_fe_clear(eth, REG_FE_IFC_PORT_EN, BIT(AIROHA_GDM2_IDX));
>  
> -	/* XXX: handle XSI_USB_PORT and XSI_PCE1_PORT */
> -	nbq = port->id == AIROHA_GDM3_IDX && airoha_is_7581(eth) ? 4 : 0;
> -	src_port = eth->soc->ops.get_src_port_id(port, nbq);
> +	src_port = eth->soc->ops.get_src_port_id(port, dev->nbq);
>  	if (src_port < 0)
>  		return src_port;

With multiple net_devices instantiated for the same physical GDM port, does
the initialization of sibling devices overwrite shared hardware registers?

For example, when airoha_set_gdm2_loopback() uses src_port to configure
REG_FE_WAN_PORT, it explicitly clears the WAN port routing masks:

	airoha_fe_rmw(eth, REG_FE_WAN_PORT,
		      WAN1_EN_MASK | WAN1_MASK | WAN0_MASK,
		      FIELD_PREP(WAN0_MASK, src_port));

Will the last initialized device clobber the WAN routing configurations and
hardware MAC filters for the others, causing their traffic to be dropped?

[ ... ]
> @@ -1970,7 +1969,8 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
>  	}
>  
>  	fport = airoha_get_fe_port(dev);
> -	msg1 = FIELD_PREP(QDMA_ETH_TXMSG_FPORT_MASK, fport) |
> +	msg1 = FIELD_PREP(QDMA_ETH_TXMSG_NBOQ_MASK, dev->nbq) |
> +	       FIELD_PREP(QDMA_ETH_TXMSG_FPORT_MASK, fport) |
>  	       FIELD_PREP(QDMA_ETH_TXMSG_METER_MASK, 0x7f);
>  
>  	q = &qdma->q_tx[qid];

When multiple net_devices share a single QDMA instance and its TX rings
(qdma->q_tx), a TX queue stall might occur here.

If the shared hardware ring fills up, netif_tx_stop_queue() stops the
transmitting device's queue. Later, when descriptors are freed, the driver
only wakes the queue corresponding to the specific packet that just completed.

If multiple devices' TX queues are stopped, will the other devices' queues
remain stalled unless their specific packets happen to be processed?

[ ... ]
> @@ -2897,10 +2900,11 @@ bool airoha_is_valid_gdm_dev(struct airoha_eth *eth,
>  
>  static int airoha_alloc_gdm_device(struct airoha_eth *eth,
>  				   struct airoha_gdm_port *port,
> -				   struct device_node *np)
> +				   int nbq, struct device_node *np)
>  {
> -	struct airoha_gdm_dev *dev;
>  	struct net_device *netdev;
> +	struct airoha_gdm_dev *dev;
> +	u8 index;
>  	int err;
[ ... ]
> +	/* Allowed nbq for EN7581 on GDM3 port are 4 and 5 for PCIE0
> +	 * and PCIE1 respectively.
> +	 */
> +	index = nbq;
> +	if (airoha_is_7581(eth) && port->id == AIROHA_GDM3_IDX)
> +		index -= 4;
> +
> +	if (index >= ARRAY_SIZE(port->devs) || port->devs[index]) {
> +		dev_err(eth->dev, "invalid nbq id: %d\n", nbq);
> +		return -EINVAL;
> +	}

There are two potential issues regarding the new index logic:

First, does this break probing for older device trees without child nodes?
When falling back to airoha_alloc_gdm_device(..., 0, np) with nbq = 0,
the index -= 4 operation for AIROHA_GDM3_IDX will cause the u8 index to
underflow to 252. The bounds check 252 >= 2 fails, returning -EINVAL.

Second, can an invalid device tree value bypass the bounds check?
The int nbq parameter is directly assigned to the u8 index. If a large value
like reg = <256> is provided, it truncates to 0, passing the index >= 2
check. The un-truncated int nbq is then stored in dev->nbq, potentially
causing out-of-bounds shifts when used in hardware macros.

[ ... ]
> @@ -2986,7 +3004,36 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth,
>  	if (err)
>  		return err;
>  
> -	return airoha_alloc_gdm_device(eth, port, np);
> +	for_each_child_of_node(np, node) {
> +		/* Multiple external serdes connected to the FE GDM port via an
> +		 * external arbiter.
> +		 */
> +		const __be32 *nbq_ptr;
> +
> +		if (!of_device_is_compatible(node, "airoha,eth-port"))
> +			continue;
> +
> +		d++;
> +		if (!of_device_is_available(node))
> +			continue;
> +
> +		nbq_ptr = of_get_property(node, "reg", NULL);
> +		if (!nbq_ptr) {
> +			dev_err(eth->dev, "missing nbq id\n");
> +			err = -EINVAL;
> +			of_node_put(node);
> +			break;
> +		}
> +
> +		err = airoha_alloc_gdm_device(eth, port, be32_to_cpup(nbq_ptr),
> +					      node);
> +		if (err) {
> +			of_node_put(node);
> +			return err;
> +		}
> +	}
> +
> +	return !d ? airoha_alloc_gdm_device(eth, port, 0, np) : 0;
>  }

If nbq_ptr is missing, err = -EINVAL is set and the loop breaks. However,
since the child counter d was already incremented, the final statement
evaluates to 0 (success) because !d is false.

Does this swallow the -EINVAL error and cause a silent failure where the
driver continues probing without initializing the misconfigured GDM devices?

Additionally, the for_each_child_of_node() iterator automatically handles
taking and dropping the reference to node.

When node is passed to airoha_alloc_gdm_device(), it is directly assigned:
netdev->dev.of_node = np;

Since of_node_get() is not called, when the loop iteration finishes and drops
the reference, does this leave the net_device pointing to a freed device
tree node?
-- 
pw-bot: cr

