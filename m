Return-Path: <netdev+bounces-288812-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ySsOu9sCmrN1AQAu9opvQ
	(envelope-from <netdev+bounces-288812-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 03:35:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1875A564D43
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 03:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86463300DDF2
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 01:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B812E23EAB0;
	Mon, 18 May 2026 01:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mcZuP8dz"
X-Original-To: netdev@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BCE1F03DE
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 01:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779068140; cv=none; b=X0YfUTxFNkp35Iyh9TwN3rQb0ivQnacz4VRfoAMhOUPCij7pXaXyd1fI7Fxxr0ev9wYUED59WSb1z+s/OMpAiLmuOD2ZGBa51WN5Ie7HBn3c3wz6673od8dyUeedBIKzisDV1c5LuHWzj+d2dhNzyitqkng715eCoSNveCiEZsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779068140; c=relaxed/simple;
	bh=Yf23nRmS1PkYqoqJ9ZrO9q8meN9xXHITD7viI0IXQq4=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=RfaHpWCd131QuyXWuDWhoHlhJCnQCC/arJfsJO9ziJUWN1ENsOLR6GIbG0BatkqJKZm9Yxl7CciELRao7vksDLRtET0qz52txAMRvBv0bMQRiG3SjmeI3+GxVnWePw4X1df2mKvNt2l6p/JY+lbPAGI0Z0+f1H6IN5vZ0LLnJcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mcZuP8dz; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779068134; h=Message-ID:Subject:Date:From:To;
	bh=18cT/QxZAk8+zDBhq7EJ4zFdC9chL2t3J0jaoNMj40A=;
	b=mcZuP8dzyxB2/h9Q3vWKOCjxVt+pbsWP3Bd8QP3BGJkTdk/kapu8XJlUdhyQsrB9cxLQFMMY5Lv+o91Yckq3b1WssGfcmiZv8YmBYO0qG8ecc4q7XWpPC5u8KTGT5GzzLcf9KIU3xsE/sRbEJ9aB5IisoWY+8xcgwr/18KTwuCU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X32fT3U_1779068131;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X32fT3U_1779068131 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 18 May 2026 09:35:32 +0800
Message-ID: <1779067446.142016-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v43 4/8] eea: create/destroy rx,tx queues for netdevice open and stop
Date: Mon, 18 May 2026 09:24:06 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Wen Gu <guwen@linux.alibaba.com>,
 Philo Lu <lulie@linux.alibaba.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Dong Yibo <dong100@mucse.com>,
 Mingyu Wang <25181214217@stu.xidian.edu.cn>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Dust Li <dust.li@linux.alibaba.com>,
 netdev@vger.kernel.org
References: <20260514095138.80680-1-xuanzhuo@linux.alibaba.com>
 <20260514095138.80680-5-xuanzhuo@linux.alibaba.com>
 <1779067114.669575-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1779067114.669575-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 1875A564D43
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.alibaba.com,linux.dev,mucse.com,stu.xidian.edu.cn,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288812-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.alibaba.com:mid,linux.alibaba.com:dkim,alibaba.com:email]
X-Rspamd-Action: no action

On Mon, 18 May 2026 09:18:34 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.c b/drivers/net/ethernet/alibaba/eea/eea_net.c
> > index bb8a49f8c6df..cfb18a07e296 100644
> > --- a/drivers/net/ethernet/alibaba/eea/eea_net.c
> > +++ b/drivers/net/ethernet/alibaba/eea/eea_net.c
> [ ... ]
> > +/* resources: ring, buffers, irq */
> > +int eea_reset_hw_resources(struct eea_net *enet, struct eea_net_init_ctx *ctx)
> > +{
> > +	struct eea_net_init_ctx ctx_old = {0};
> > +	int err, error;
> > +
> > +	if (!netif_running(enet->netdev) || !enet->started) {
> > +		enet->cfg = ctx->cfg;
> > +		return 0;
> > +	}
> > +
> > +	err = eea_alloc_rxtx_q_mem(ctx);
> > +	if (err) {
> > +		netdev_warn(enet->netdev,
> > +			    "eea reset: alloc q failed. stop reset. err %d\n",
> > +			    err);
> > +		return err;
> > +	}
> > +
> > +	eea_stop_rxtx(enet->netdev);
> > +	eea_hw_unactive_ring(enet);
> > +
> > +	eea_unbind_q_and_cfg(enet, &ctx_old);
> > +	eea_bind_q_and_cfg(enet, ctx);
> > +
> > +	err = eea_update_queues(enet);
> > +	if (err) {
> > +		netdev_err(enet->netdev,
> > +			   "eea reset: set real num queues failed. err %d\n",
> > +			   err);
> > +		goto err_bind_old;
> > +	}
> > +
> > +	err = eea_hw_active_ring(enet);
> > +	if (err) {
> > +		netdev_err(enet->netdev, "eea reset: active new ring. err %d\n",
> > +			   err);
> > +		eea_unbind_q_and_cfg(enet, ctx);
> > +		goto err_free_q;
> > +	}
> On the eea_hw_active_ring() failure branch above, can the netdev be
> left with mismatched cached state?
> The sequence executed by then is:
>     eea_unbind_q_and_cfg(enet, &ctx_old);   /* saves OLD cfg into ctx_old */
>     eea_bind_q_and_cfg(enet, ctx);          /* enet->cfg = ctx->cfg (NEW) */
>     err = eea_update_queues(enet);          /* sets real_num_{rx,tx}_queues
>                                                to NEW values, succeeded */
>     err = eea_hw_active_ring(enet);         /* failed */
>     eea_unbind_q_and_cfg(enet, ctx);
>     goto err_free_q;
> err_free_q then sets enet->started = false but never restores
> enet->cfg or netdev->real_num_{rx,tx}_queues to the old values, and
> eea_unbind_q_and_cfg() only nulls enet->rx / enet->tx without
> reverting cfg.
> Looking at eea_unbind_q_and_cfg():
>     ctx->cfg = enet->cfg;
>     ctx->rx = enet->rx;
>     ctx->tx = enet->tx;
>     enet->rx = NULL;
>     enet->tx = NULL;
> If the user later calls ndo_open, eea_netdev_open() reads enet->cfg
> which still holds the NEW values that the device just rejected. Was
> a rollback to ctx_old intended on this path as well, similar to the
> err_bind_old branch?

All configurations that reach this point are additive in nature. The failure to
apply them to the hardware does not imply that the configuration itself is
invalid; rather, it is typically due to hardware issues or memory allocation
failures. Therefore, we retain the configuration with the expectation that it
may be successfully applied upon the next attempt.

> [ ... ]
> > +static void eea_net_ha_reset_remove(struct eea_net *enet,
> > +				    struct eea_device *edev)
> > +{
> [ ... ]
> > diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.h b/drivers/net/ethernet/alibaba/eea/eea_net.h
> > index fa0eec8af21b..9639f0c5c618 100644
> > --- a/drivers/net/ethernet/alibaba/eea/eea_net.h
> > +++ b/drivers/net/ethernet/alibaba/eea/eea_net.h
> [ ... ]
> > +/* rx apis */
> > +void enet_rx_stop(struct eea_net_rx *rx);
> > +void enet_rx_start(struct eea_net_rx *rx);
> Every other symbol in this driver uses the eea_ prefix, but
> enet_rx_start / enet_rx_stop use enet_. Was the inconsistency
> intentional, or should these be renamed to eea_rx_start /
> eea_rx_stop for consistency with the rest of the eea_ namespace?

The enet prefix indicates that this code is not part of the PCI or adminq layers,
but is specifically used for eea netdev handling.


> > +
> > +void eea_free_rx(struct eea_net_rx *rx, struct eea_net_cfg *cfg);
> > +struct eea_net_rx *eea_alloc_rx(struct eea_net_init_ctx *ctx, u32 idx);
> [ ... ]
> > diff --git a/drivers/net/ethernet/alibaba/eea/eea_pci.c b/drivers/net/ethernet/alibaba/eea/eea_pci.c
> > index bef0ebd6bb20..9872e360dd5d 100644
> > --- a/drivers/net/ethernet/alibaba/eea/eea_pci.c
> > +++ b/drivers/net/ethernet/alibaba/eea/eea_pci.c
> [ ... ]
> > +static void eea_ha_handle_reset(struct eea_pci_device *ep_dev)
> > +{
> [ ... ]
> > +	if (reset & EEA_PCI_CAP_RESET_FLAG) {
> > +		dev_warn(&ep_dev->pci_dev->dev, "recv device reset request.\n");
> > +
> > +		pci_dev = ep_dev->pci_dev;
> > +
> > +		/* The pci remove callback may hold this lock. If the
> > +		 * pci remove callback is called, then we can ignore the
> > +		 * ha interrupt.
> > +		 */
> > +		if (mutex_trylock(&edev->ha_lock)) {
> Is the mutex_trylock() with a silent-skip fallback below the right
> pattern here?
> > +			if (edev->status != EEA_PCI_STATUS_DONE) {
> > +				dev_err(&ep_dev->pci_dev->dev, "ha: reset device: pci status is %d. skip it.\n",
> > +					edev->status);
> > +
> > +				mutex_unlock(&edev->ha_lock);
> > +				return;
> > +			}
> > +
> > +			__eea_pci_remove(pci_dev, false);
> > +			err = __eea_pci_probe(pci_dev, ep_dev, false);
> > +			if (err)
> [ ... ]
> > +			mutex_unlock(&edev->ha_lock);
> > +		} else {
> > +			/* Device removal is in progress, so return directly. */
> > +			dev_warn(&ep_dev->pci_dev->dev,
> > +				 "ha device reset: trylock failed.\n");
> > +		}
> > +		return;
> > +	}
> When the trylock fails, the work simply logs a warning and returns
> without rescheduling. The networking subsystem guidance lists this
> specific pattern (trylock with fallback to skip the work entirely) as
> a likely bug, with the narrow exception of work items that retry via
> schedule_work() on failure.
> The trylock also fails for any holder of ha_lock, not only pci
> remove, so a HA reset request that arrives during any concurrent
> holder is dropped silently and the device is left without recovery.
> Would it be more appropriate to either reschedule the work via
> schedule_work() on trylock failure, or to redesign the locking so
> that the remove path coordinates with the worker via cancel/flush
> rather than a shared mutex that the worker must avoid?


If the system has already entered the PCI remove path, the HA work is no longer
necessary, so returning directly after mutex_trylock failure is correct
behavior. Furthermore, our design guarantees that an HA interrupt will not be
triggered again until the current one is fully processed. If the hardware were
to encounter such a demand (i.e., multiple concurrent HA requests), our design
strategy is to let the hardware stop functioning entirely rather than attempting
to recover again.


> [ ... ]
> > +static int eea_pci_ha_init(struct eea_device *edev, struct pci_dev *pci_dev,
> > +			   bool pci_probe)
> > +{
> [ ... ]
> > diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.c b/drivers/net/ethernet/alibaba/eea/eea_net.c
> > +static int eea_net_reprobe(struct eea_device *edev)
> > +{
> > +	struct eea_net *enet = edev->enet;
> > +	int err = 0;
> > +
> > +	enet->edev = edev;
> > +
> > +	if (!enet->adminq.ring) {
> > +		err = eea_create_adminq(enet, edev->rx_num + edev->tx_num);
> > +		if (err)
> > +			return err;
> > +	}
> > +
> > +	err = eea_alloc_irq_blks(enet);
> > +	if (err)
> > +		goto err_destroy_aq;
> > +
> > +	rtnl_lock();
> > +
> > +	enet->link_err = 0;
> > +	if (edev->ha_reset_netdev_running &&
> > +	    netif_running(edev->enet->netdev)) {
> > +		err = eea_netdev_open(enet->netdev);
> On the HA reprobe path, can edev->rx_num change relative to the
> value used at original probe?

This won't happen. According to our hardware design specification, the device
parameters (including rx_num and tx_num) are guaranteed to remain constant
throughout the entire HA reset process. Therefore, we don't need to perform an
explicit validation check for these values during eea_net_reprobe().



