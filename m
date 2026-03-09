Return-Path: <netdev+bounces-265415-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kI5nBtuKrmmzFwIAu9opvQ
	(envelope-from <netdev+bounces-265415-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 09:54:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B65C235B65
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 09:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F00583016531
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 08:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D579734C145;
	Mon,  9 Mar 2026 08:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QVvimQWI"
X-Original-To: netdev@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A404337699
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 08:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773046446; cv=none; b=E7WJq8i66xMty1PqGM+fZgaJQfs9rBPkF0m1ys2gmC0kYecZYp7C/jpuZ1pbiYWGnOdN4jSxFI7R7jBa98WoasYsdIYwl12hq76khPakpCgqHGGNG3WM8kb5lBy06RJsdpmcIaNP41jigCdr/fWa0l2CflWzOCAEbAWndHvqBfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773046446; c=relaxed/simple;
	bh=i3Nj8E6UhszizDSji7rHIC6TRykAvIZZfmr1L25nTaw=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=bvDN5pVb5lcZy7OnWvq0+ogiWurN6BQyihNfxSguDxyxGb8k6vwa8Z4AxRmDPEm+1/B4W1odIOcc6c2Ow0Y9/qJXjAQ1VZMKTcHmbUaNjdgb8Yu1K2MktoQjeTm490hqz3tJ+aQfCbjkSRdj+/iAv2PNwnRvP8Ph+UWdvNkuPkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QVvimQWI; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773046438; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=TQxb7UjyfUxsjLc75wBpFZ+fKGVnvyZuh+h9VIYi2iA=;
	b=QVvimQWIalKaxNyb6Stgl1JbX99wLITcOTOF9CQPAn0f1P8flr7dhm2+os9ZTWC+UBnXpDQ5Vc/EF5qtrCihJO180p4lVVi+gfFPhk22p7QMjF6BQfkHrMt/LQ4onkp0O6gMmxg/jrSmiayTzjE8IVStT14Asbwr+ddHkbFHfEw=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X-WqvjC_1773046437 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 09 Mar 2026 16:53:57 +0800
Message-ID: <1773046268.140821-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v28 4/8] eea: create/destroy rx,tx queues for netdevice open and stop
Date: Mon, 9 Mar 2026 16:51:08 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Wen Gu <guwen@linux.alibaba.com>,
 Philo Lu <lulie@linux.alibaba.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Dong Yibo <dong100@mucse.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>,
 Dust Li <dust.li@linux.alibaba.com>,
 netdev@vger.kernel.org
References: <20260302024604.25354-1-xuanzhuo@linux.alibaba.com>
 <20260302024604.25354-5-xuanzhuo@linux.alibaba.com>
 <e6c3b053-75d7-46b5-9fd0-ac6de498456f@redhat.com>
In-Reply-To: <e6c3b053-75d7-46b5-9fd0-ac6de498456f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 6B65C235B65
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MISSING_MIME_VERSION(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265415-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,linux.alibaba.com,linux.dev,mucse.com,gmail.com,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, 5 Mar 2026 11:16:32 +0100, Paolo Abeni <pabeni@redhat.com> wrote:
> On 3/2/26 3:46 AM, Xuan Zhuo wrote:
> > Add basic driver framework for the Alibaba Elastic Ethernet Adapter(EEA=
).
> >
> > This commit introduces the implementation for the netdevice open and
> > stop.
> >
> > Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
> > Reviewed-by: Philo Lu <lulie@linux.alibaba.com>
> > Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/ethernet/alibaba/eea/Makefile  |   4 +-
> >  drivers/net/ethernet/alibaba/eea/eea_net.c | 530 ++++++++++++++++++++-
> >  drivers/net/ethernet/alibaba/eea/eea_net.h |  45 ++
> >  drivers/net/ethernet/alibaba/eea/eea_pci.c | 182 ++++++-
> >  drivers/net/ethernet/alibaba/eea/eea_pci.h |  13 +
> >  drivers/net/ethernet/alibaba/eea/eea_rx.c  | 254 ++++++++++
> >  drivers/net/ethernet/alibaba/eea/eea_tx.c  | 104 ++++
> >  7 files changed, 1127 insertions(+), 5 deletions(-)
> >  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_rx.c
> >  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_tx.c
> >
> > diff --git a/drivers/net/ethernet/alibaba/eea/Makefile b/drivers/net/et=
hernet/alibaba/eea/Makefile
> > index 91f318e8e046..fa34a005fa01 100644
> > --- a/drivers/net/ethernet/alibaba/eea/Makefile
> > +++ b/drivers/net/ethernet/alibaba/eea/Makefile
> > @@ -3,4 +3,6 @@ obj-$(CONFIG_EEA) +=3D eea.o
> >  eea-y :=3D eea_ring.o \
> >  	eea_net.o \
> >  	eea_pci.o \
> > -	eea_adminq.o
> > +	eea_adminq.o \
> > +	eea_tx.o \
> > +	eea_rx.o
> > diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.c b/drivers/net/e=
thernet/alibaba/eea/eea_net.c
> > index 31cb9ca5b408..2ebf0053d05e 100644
> > --- a/drivers/net/ethernet/alibaba/eea/eea_net.c
> > +++ b/drivers/net/ethernet/alibaba/eea/eea_net.c
> > @@ -18,6 +18,453 @@
> >
> >  #define EEA_SPLIT_HDR_SIZE 128
> >
> > +static irqreturn_t eea_irq_handler(int irq, void *data)
> > +{
> > +	struct eea_irq_blk *blk =3D data;
> > +
> > +	napi_schedule_irqoff(&blk->napi);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static void eea_free_irq_blk(struct eea_net *enet)
> > +{
> > +	struct eea_irq_blk *blk;
> > +	u32 num;
> > +	int i;
> > +
> > +	if (!enet->irq_blks)
> > +		return;
> > +
> > +	num =3D enet->edev->rx_num;
> > +
> > +	for (i =3D 0; i < num; i++) {
> > +		blk =3D &enet->irq_blks[i];
> > +
> > +		if (blk->ready)
> > +			eea_pci_free_irq(blk);
> > +
> > +		blk->ready =3D false;
> > +	}
> > +
> > +	kvfree(enet->irq_blks);
> > +	enet->irq_blks =3D NULL;
> > +}
> > +
> > +static int eea_alloc_irq_blks(struct eea_net *enet, u32 num)
> > +{
> > +	struct eea_device *edev =3D enet->edev;
> > +	struct eea_irq_blk *blk, *irq_blks;
> > +	int i, err;
> > +
> > +	irq_blks =3D kvcalloc(num, sizeof(*blk), GFP_KERNEL);
> > +	if (!irq_blks)
> > +		return -ENOMEM;
> > +
> > +	enet->irq_blks =3D irq_blks;
> > +
> > +	for (i =3D 0; i < num; i++) {
> > +		blk =3D &irq_blks[i];
> > +		blk->idx =3D i;
> > +
> > +		/* vec 0 is for error notify. */
> > +		blk->msix_vec =3D i + 1;
> > +
> > +		err =3D eea_pci_request_irq(edev, blk, eea_irq_handler);
> > +		if (err)
> > +			goto err_free_irq_blk;
> > +
> > +		blk->ready =3D true;
> > +	}
> > +
> > +	return 0;
> > +
> > +err_free_irq_blk:
> > +	eea_free_irq_blk(enet);
> > +	return err;
> > +}
> > +
> > +static int eea_update_queues(struct eea_net *enet)
> > +{
> > +	return netif_set_real_num_queues(enet->netdev, enet->cfg.tx_ring_num,
> > +					 enet->cfg.rx_ring_num);
> > +}
> > +
> > +void eea_init_ctx(struct eea_net *enet, struct eea_net_init_ctx *ctx)
> > +{
> > +	memset(ctx, 0, sizeof(*ctx));
> > +
> > +	ctx->netdev =3D enet->netdev;
> > +	ctx->edev =3D enet->edev;
> > +	ctx->cfg =3D enet->cfg;
> > +}
> > +
> > +static void eea_bind_q_and_cfg(struct eea_net *enet,
> > +			       struct eea_net_init_ctx *ctx)
> > +{
> > +	struct eea_irq_blk *blk;
> > +	struct eea_net_rx *rx;
> > +	struct eea_net_tx *tx;
> > +	int i;
> > +
> > +	enet->cfg =3D ctx->cfg;
> > +	enet->rx =3D ctx->rx;
> > +	enet->tx =3D ctx->tx;
> > +
> > +	for (i =3D 0; i < ctx->cfg.rx_ring_num; i++) {
> > +		blk =3D &enet->irq_blks[i];
> > +
> > +		rx =3D ctx->rx[i];
> > +		tx =3D &ctx->tx[i];
> > +
> > +		rx->enet =3D enet;
> > +		rx->napi =3D &blk->napi;
> > +		rx->ering->msix_vec =3D blk->msix_vec;
> > +
> > +		tx->enet =3D enet;
> > +		tx->ering->msix_vec =3D blk->msix_vec;
> > +
> > +		blk->rx =3D rx;
> > +	}
> > +}
> > +
> > +static void eea_unbind_q_and_cfg(struct eea_net *enet,
> > +				 struct eea_net_init_ctx *ctx)
> > +{
> > +	struct eea_irq_blk *blk;
> > +	struct eea_net_rx *rx;
> > +	int i;
> > +
> > +	ctx->cfg =3D enet->cfg;
> > +	ctx->rx =3D enet->rx;
> > +	ctx->tx =3D enet->tx;
> > +
> > +	enet->rx =3D NULL;
> > +	enet->tx =3D NULL;
> > +
> > +	for (i =3D 0; i < ctx->cfg.rx_ring_num; i++) {
> > +		blk =3D &enet->irq_blks[i];
> > +
> > +		rx =3D ctx->rx[i];
> > +
> > +		rx->napi =3D NULL;
> > +
> > +		blk->rx =3D NULL;
> > +	}
> > +}
> > +
> > +static void eea_free_rxtx_q_mem(struct eea_net_init_ctx *ctx)
> > +{
> > +	struct eea_net_rx *rx;
> > +	struct eea_net_tx *tx;
> > +	int i;
> > +
> > +	for (i =3D 0; i < ctx->cfg.rx_ring_num; i++) {
> > +		rx =3D ctx->rx[i];
> > +		tx =3D &ctx->tx[i];
> > +
> > +		eea_free_rx(rx, &ctx->cfg);
> > +		eea_free_tx(tx, &ctx->cfg);
> > +	}
> > +
> > +	kvfree(ctx->rx);
> > +	kvfree(ctx->tx);
> > +}
> > +
> > +/* alloc tx/rx: struct, ring, meta, pp, napi */
> > +static int eea_alloc_rxtx_q_mem(struct eea_net_init_ctx *ctx)
> > +{
> > +	struct eea_net_rx *rx;
> > +	struct eea_net_tx *tx;
> > +	int err, i;
> > +
> > +	ctx->tx =3D kvcalloc(ctx->cfg.tx_ring_num, sizeof(*ctx->tx), GFP_KERN=
EL);
> > +	if (!ctx->tx)
> > +		return -ENOMEM;
> > +
> > +	ctx->rx =3D kvcalloc(ctx->cfg.rx_ring_num, sizeof(*ctx->rx), GFP_KERN=
EL);
> > +	if (!ctx->rx)
> > +		goto err_free_tx;
> > +
> > +	ctx->cfg.rx_sq_desc_size =3D sizeof(struct eea_rx_desc);
> > +	ctx->cfg.rx_cq_desc_size =3D sizeof(struct eea_rx_cdesc);
> > +	ctx->cfg.tx_sq_desc_size =3D sizeof(struct eea_tx_desc);
> > +	ctx->cfg.tx_cq_desc_size =3D sizeof(struct eea_tx_cdesc);
> > +
> > +	ctx->cfg.tx_cq_desc_size /=3D 2;
> > +
> > +	if (!ctx->cfg.split_hdr)
> > +		ctx->cfg.rx_sq_desc_size /=3D 2;
> > +
> > +	for (i =3D 0; i < ctx->cfg.rx_ring_num; i++) {
> > +		rx =3D eea_alloc_rx(ctx, i);
> > +		if (!rx)
> > +			goto err_free;
> > +
> > +		ctx->rx[i] =3D rx;
> > +
> > +		tx =3D ctx->tx + i;
> > +		err =3D eea_alloc_tx(ctx, tx, i);
> > +		if (err)
> > +			goto err_free;
> > +	}
> > +
> > +	return 0;
> > +
> > +err_free:
> > +	for (i =3D 0; i < ctx->cfg.rx_ring_num; i++) {
> > +		rx =3D ctx->rx[i];
> > +		tx =3D ctx->tx + i;
> > +
> > +		eea_free_rx(rx, &ctx->cfg);
> > +		eea_free_tx(tx, &ctx->cfg);
> > +	}
> > +
> > +	kvfree(ctx->rx);
> > +
> > +err_free_tx:
> > +	kvfree(ctx->tx);
> > +	return -ENOMEM;
> > +}
> > +
> > +static int eea_hw_active_ring(struct eea_net *enet)
> > +{
> > +	return eea_adminq_create_q(enet, /* qidx =3D */ 0,
> > +				   enet->cfg.rx_ring_num +
> > +				   enet->cfg.tx_ring_num, 0);
> > +}
> > +
> > +static int eea_hw_unactive_ring(struct eea_net *enet)
> > +{
> > +	int err;
> > +
> > +	err =3D eea_adminq_destroy_all_q(enet);
> > +	if (err)
> > +		netdev_warn(enet->netdev, "unactive rxtx ring failed.\n");
> > +
> > +	return err;
> > +}
> > +
> > +/* stop rx napi, stop tx queue. */
> > +static void eea_stop_rxtx(struct net_device *netdev)
> > +{
> > +	struct eea_net *enet =3D netdev_priv(netdev);
> > +	int i;
> > +
> > +	netif_tx_disable(netdev);
> > +
> > +	for (i =3D 0; i < enet->cfg.rx_ring_num; i++)
> > +		enet_rx_stop(enet->rx[i]);
> > +
> > +	netif_carrier_off(netdev);
> > +}
> > +
> > +static void eea_start_rxtx(struct eea_net *enet)
> > +{
> > +	int i;
> > +
> > +	for (i =3D 0; i < enet->cfg.rx_ring_num; i++)
> > +		enet_rx_start(enet->rx[i]);
> > +
> > +	netif_tx_start_all_queues(enet->netdev);
> > +	netif_carrier_on(enet->netdev);
> > +
> > +	enet->started =3D true;
> > +}
> > +
> > +static int eea_netdev_stop(struct net_device *netdev)
> > +{
> > +	struct eea_net *enet =3D netdev_priv(netdev);
> > +	struct eea_net_init_ctx ctx;
> > +
> > +	/* This function can be called during device anomaly recovery. To
> > +	 * prevent duplicate stop operations, the `started` flag is introduced
> > +	 * for checking.
> > +	 */
> > +
> > +	if (!enet->started) {
> > +		netdev_warn(netdev, "eea netdev stop: but dev is not started.\n");
> > +		return 0;
> > +	}
> > +
> > +	eea_stop_rxtx(netdev);
> > +	eea_hw_unactive_ring(enet);
> > +	eea_unbind_q_and_cfg(enet, &ctx);
> > +	eea_free_rxtx_q_mem(&ctx);
> > +
> > +	enet->started =3D false;
> > +
> > +	return 0;
> > +}
> > +
> > +static int eea_netdev_open(struct net_device *netdev)
> > +{
> > +	struct eea_net *enet =3D netdev_priv(netdev);
> > +	struct eea_net_init_ctx ctx;
> > +	int err;
> > +
> > +	if (enet->link_err) {
> > +		netdev_err(netdev, "netdev open err, because link error: %d\n",
> > +			   enet->link_err);
> > +		return -EBUSY;
> > +	}
> > +
> > +	eea_init_ctx(enet, &ctx);
> > +
> > +	err =3D eea_alloc_rxtx_q_mem(&ctx);
> > +	if (err)
> > +		goto err_done;
> > +
> > +	eea_bind_q_and_cfg(enet, &ctx);
> > +
> > +	err =3D eea_update_queues(enet);
> > +	if (err)
> > +		goto err_free_q;
> > +
> > +	err =3D eea_hw_active_ring(enet);
> > +	if (err)
> > +		goto err_free_q;
> > +
> > +	eea_start_rxtx(enet);
> > +
> > +	return 0;
> > +
> > +err_free_q:
> > +	eea_unbind_q_and_cfg(enet, &ctx);
> > +	eea_free_rxtx_q_mem(&ctx);
> > +
> > +err_done:
> > +	return err;
> > +}
> > +
> > +/* resources: ring, buffers, irq */
> > +int eea_reset_hw_resources(struct eea_net *enet, struct eea_net_init_c=
tx *ctx)
> > +{
> > +	struct eea_net_init_ctx ctx_old =3D {0};
> > +	int err, error;
> > +
> > +	if (!netif_running(enet->netdev) || !enet->started) {
> > +		enet->cfg =3D ctx->cfg;
> > +		return 0;
> > +	}
> > +
> > +	err =3D eea_alloc_rxtx_q_mem(ctx);
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
> > +	err =3D eea_update_queues(enet);
> > +	if (err) {
> > +		netdev_err(enet->netdev,
> > +			   "eea reset: set real num queues failed. err %d\n",
> > +			   err);
> > +		goto err_bind_old;
> > +	}
> > +
> > +	err =3D eea_hw_active_ring(enet);
>
> AFAICS the need for admins queue destroy and recreation on cfg change is
> what prevents a safe configuration swap (together with irq allocation,
> see below). Could you instead keep the admin queue always alive i.e.
> with maximum number of erings configured, and just enable/them as needded?
>
> If not, please document explicitly the constraint in the commit message.

Generally, during I/O queue reconstruction, the admin queue is not rebuilt.
However, in HA scenarios=E2=80=94which represent a special case=E2=80=94
the DPU notifies the driver to request re-initialization. In this specific
situation, the admin queue will also be rebuilt.

>
> [...]
> > @@ -140,14 +591,65 @@ static struct eea_net *eea_netdev_alloc(struct ee=
a_device *edev, u32 pairs)
> >  	enet->edev =3D edev;
> >  	edev->enet =3D enet;
> >
> > +	err =3D eea_alloc_irq_blks(enet, pairs);
> > +	if (err) {
>
> I'm likely lost, but AFAICS eea_alloc_irq_blks() is invoked only here,
> and allocates edev->rx_num interrupts. rx_num is the number of RX
> channel at device probe time.
>
> set_channels can later change such value, i.e. increasing it. But I
> don't see other irqs allocated.


No, set_channels just change enet.cfg.rx_num, edev->rx_num is readonly.

Thanks.

>
> Also the irq handler takes a direct pointer to the napi struct, as
> opposed to Jakub's suggestion of using a ptr to a p
>
> > +		dev_err(edev->dma_dev,
> > +			"eea_alloc_irq_blks failed with pairs %d\n", pairs);
> > +		free_netdev(netdev);
> > +		return NULL;
> > +	}
> > +
> >  	return enet;
> >  }
> >
> > +static void eea_update_ts_off(struct eea_device *edev, struct eea_net =
*enet)
> > +{
> > +	u64 ts;
> > +
> > +	ts =3D eea_pci_device_ts(edev);
> > +
> > +	enet->hw_ts_offset =3D ktime_get_real() - ts;
> > +}
> > +
> > +static int eea_net_reprobe(struct eea_device *edev)
> > +{
> > +	struct eea_net *enet =3D edev->enet;
> > +	int err =3D 0;
> > +
> > +	enet->edev =3D edev;
> > +
> > +	if (!enet->adminq.ring) {
> > +		err =3D eea_create_adminq(enet, edev->rx_num + edev->tx_num);
> > +		if (err)
> > +			return err;
> > +	}
> > +
> > +	err =3D eea_alloc_irq_blks(enet, edev->rx_num);
> > +	if (err) {
> > +		eea_destroy_adminq(enet);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	eea_update_ts_off(edev, enet);
> > +
> > +	if (edev->ha_reset_netdev_running) {
> > +		rtnl_lock();
> > +		enet->link_err =3D 0;
> > +		err =3D eea_netdev_open(enet->netdev);
> > +		rtnl_unlock();
> > +	}
> > +
> > +	return err;
> > +}
> > +
> >  int eea_net_probe(struct eea_device *edev)
> >  {
> >  	struct eea_net *enet;
> >  	int err =3D -ENOMEM;
> >
> > +	if (edev->ha_reset)
> > +		return eea_net_reprobe(edev);
> > +
> >  	enet =3D eea_netdev_alloc(edev, edev->rx_num);
> >  	if (!enet)
> >  		return -ENOMEM;
> > @@ -168,6 +670,7 @@ int eea_net_probe(struct eea_device *edev)
> >  	if (err)
> >  		goto err_reset_dev;
> >
> > +	eea_update_ts_off(edev, enet);
> >  	netif_carrier_off(enet->netdev);
> >
> >  	netdev_dbg(enet->netdev, "eea probe success.\n");
> > @@ -179,10 +682,29 @@ int eea_net_probe(struct eea_device *edev)
> >  	eea_destroy_adminq(enet);
> >
> >  err_free_netdev:
> > +	eea_free_irq_blk(enet);
> >  	free_netdev(enet->netdev);
> >  	return err;
> >  }
> >
> > +static void eea_net_ha_reset_remove(struct eea_net *enet,
> > +				    struct eea_device *edev,
> > +				    struct net_device *netdev)
> > +{
> > +	rtnl_lock();
> > +	edev->ha_reset_netdev_running =3D false;
> > +	if (netif_running(enet->netdev)) {
> > +		eea_netdev_stop(enet->netdev);
> > +		enet->link_err =3D EEA_LINK_ERR_HA_RESET_DEV;
> > +		edev->ha_reset_netdev_running =3D true;
> > +	}
> > +	rtnl_unlock();
> > +
> > +	eea_device_reset(edev);
> > +	eea_destroy_adminq(enet);
> > +	eea_free_irq_blk(enet);
> > +}
> > +
> >  void eea_net_remove(struct eea_device *edev)
> >  {
> >  	struct net_device *netdev;
> > @@ -191,12 +713,16 @@ void eea_net_remove(struct eea_device *edev)
> >  	enet =3D edev->enet;
> >  	netdev =3D enet->netdev;
> >
> > +	if (edev->ha_reset) {
> > +		eea_net_ha_reset_remove(enet, edev, netdev);
> > +		return;
> > +	}
> > +
> >  	unregister_netdev(netdev);
> > -	netdev_dbg(enet->netdev, "eea removed.\n");
> >
> >  	eea_device_reset(edev);
> > -
> >  	eea_destroy_adminq(enet);
> > +	eea_free_irq_blk(enet);
> >
> >  	free_netdev(netdev);
> >  }
> > diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.h b/drivers/net/e=
thernet/alibaba/eea/eea_net.h
> > index ab487bc88af2..0398e781dfdb 100644
> > --- a/drivers/net/ethernet/alibaba/eea/eea_net.h
> > +++ b/drivers/net/ethernet/alibaba/eea/eea_net.h
> > @@ -18,6 +18,8 @@
> >  #define EEA_VER_MINOR		0
> >  #define EEA_VER_SUB_MINOR	0
> >
> > +struct eea_tx_meta;
> > +
> >  struct eea_net_tx {
> >  	struct eea_net *enet;
> >
> > @@ -101,6 +103,18 @@ struct eea_net_cfg {
> >  	u8 tx_cq_desc_size;
> >
> >  	u32 split_hdr;
> > +
> > +	struct hwtstamp_config ts_cfg;
> > +};
> > +
> > +struct eea_net_init_ctx {
> > +	struct eea_net_cfg cfg;
> > +
> > +	struct eea_net_tx *tx;
> > +	struct eea_net_rx **rx;
> > +
> > +	struct net_device *netdev;
> > +	struct eea_device *edev;
> >  };
> >
> >  enum {
> > @@ -109,6 +123,17 @@ enum {
> >  	EEA_LINK_ERR_LINK_DOWN,
> >  };
> >
> > +struct eea_irq_blk {
> > +	struct napi_struct napi;
> > +	u16 msix_vec;
> > +	bool ready;
> > +	struct eea_net_rx *rx;
> > +	char irq_name[32];
> > +	int irq;
> > +	int idx;
> > +
> > +};
> > +
> >  struct eea_net {
> >  	struct eea_device *edev;
> >  	struct net_device *netdev;
> > @@ -121,6 +146,8 @@ struct eea_net {
> >  	struct eea_net_cfg cfg;
> >  	struct eea_net_cfg cfg_hw;
> >
> > +	struct eea_irq_blk *irq_blks;
> > +
> >  	u32 link_err;
> >
> >  	bool started;
> > @@ -134,4 +161,22 @@ struct eea_net {
> >  int eea_net_probe(struct eea_device *edev);
> >  void eea_net_remove(struct eea_device *edev);
> >
> > +int eea_reset_hw_resources(struct eea_net *enet, struct eea_net_init_c=
tx *ctx);
> > +void eea_init_ctx(struct eea_net *enet, struct eea_net_init_ctx *ctx);
> > +int eea_queues_check_and_reset(struct eea_device *edev);
> > +
> > +/* rx apis */
> > +void enet_rx_stop(struct eea_net_rx *rx);
> > +void enet_rx_start(struct eea_net_rx *rx);
> > +
> > +void eea_free_rx(struct eea_net_rx *rx, struct eea_net_cfg *cfg);
> > +struct eea_net_rx *eea_alloc_rx(struct eea_net_init_ctx *ctx, u32 idx);
> > +
> > +/* tx apis */
> > +int eea_poll_tx(struct eea_net_tx *tx, int budget);
> > +netdev_tx_t eea_tx_xmit(struct sk_buff *skb, struct net_device *netdev=
);
> > +
> > +void eea_free_tx(struct eea_net_tx *tx, struct eea_net_cfg *cfg);
> > +int eea_alloc_tx(struct eea_net_init_ctx *ctx, struct eea_net_tx *tx, =
u32 idx);
> > +
> >  #endif
> > diff --git a/drivers/net/ethernet/alibaba/eea/eea_pci.c b/drivers/net/e=
thernet/alibaba/eea/eea_pci.c
> > index 97efac753cfb..e42b0298eebb 100644
> > --- a/drivers/net/ethernet/alibaba/eea/eea_pci.c
> > +++ b/drivers/net/ethernet/alibaba/eea/eea_pci.c
> > @@ -13,6 +13,9 @@
> >
> >  #define EEA_PCI_DB_OFFSET 4096
> >
> > +#define EEA_PCI_CAP_RESET_DEVICE 0xFA
> > +#define EEA_PCI_CAP_RESET_FLAG BIT(1)
> > +
> >  struct eea_pci_cfg {
> >  	__le32 reserve0;
> >  	__le32 reserve1;
> > @@ -51,6 +54,7 @@ struct eea_pci_device {
> >  	void __iomem *reg;
> >  	void __iomem *db_base;
> >
> > +	struct work_struct ha_handle_work;
> >  	char ha_irq_name[32];
> >  	u8 reset_pos;
> >  };
> > @@ -67,6 +71,11 @@ struct eea_pci_device {
> >  #define cfg_read32(reg, item) ioread32(cfg_pointer(reg, item))
> >  #define cfg_readq(reg, item) readq(cfg_pointer(reg, item))
> >
> > +/* Due to circular references, we have to add function definitions her=
e. */
> > +static int __eea_pci_probe(struct pci_dev *pci_dev,
> > +			   struct eea_pci_device *ep_dev);
> > +static void __eea_pci_remove(struct pci_dev *pci_dev, bool flush_ha_wo=
rk);
> > +
> >  const char *eea_pci_name(struct eea_device *edev)
> >  {
> >  	return pci_name(edev->ep_dev->pci_dev);
> > @@ -250,6 +259,150 @@ void eea_pci_active_aq(struct eea_ring *ering, in=
t msix_vec)
> >  				    cfg_read32(ep_dev->reg, aq_db_off));
> >  }
> >
> > +void eea_pci_free_irq(struct eea_irq_blk *blk)
> > +{
> > +	irq_update_affinity_hint(blk->irq, NULL);
> > +	free_irq(blk->irq, blk);
> > +}
> > +
> > +int eea_pci_request_irq(struct eea_device *edev, struct eea_irq_blk *b=
lk,
> > +			irqreturn_t (*callback)(int irq, void *data))
> > +{
> > +	struct eea_pci_device *ep_dev =3D edev->ep_dev;
> > +	int irq;
> > +
> > +	snprintf(blk->irq_name, sizeof(blk->irq_name), "eea-q%d@%s", blk->idx,
> > +		 pci_name(ep_dev->pci_dev));
> > +
> > +	irq =3D pci_irq_vector(ep_dev->pci_dev, blk->msix_vec);
> > +
> > +	blk->irq =3D irq;
> > +
> > +	return request_irq(irq, callback, IRQF_NO_AUTOEN, blk->irq_name, blk);
> > +}
> > +
> > +static void eea_ha_handle_reset(struct eea_pci_device *ep_dev)
> > +{
> > +	struct eea_device *edev;
> > +	struct pci_dev *pci_dev;
> > +	u16 reset;
> > +	int err;
> > +
> > +	if (!ep_dev->reset_pos) {
> > +		eea_queues_check_and_reset(&ep_dev->edev);
> > +		return;
> > +	}
> > +
> > +	edev =3D &ep_dev->edev;
> > +
> > +	pci_read_config_word(ep_dev->pci_dev, ep_dev->reset_pos, &reset);
> > +
> > +	/* clear bit */
> > +	pci_write_config_word(ep_dev->pci_dev, ep_dev->reset_pos, 0xFFFF);
> > +
> > +	if (reset & EEA_PCI_CAP_RESET_FLAG) {
> > +		dev_warn(&ep_dev->pci_dev->dev, "recv device reset request.\n");
> > +
> > +		pci_dev =3D ep_dev->pci_dev;
> > +
> > +		/* The pci remove callback may hold this lock. If the
> > +		 * pci remove callback is called, then we can ignore the
> > +		 * ha interrupt.
> > +		 */
> > +		if (mutex_trylock(&edev->ha_lock)) {
> > +			edev->ha_reset =3D true;
> > +
> > +			__eea_pci_remove(pci_dev, false);
> > +			err =3D __eea_pci_probe(pci_dev, ep_dev);
> > +			if (err)
> > +				dev_err(&ep_dev->pci_dev->dev,
> > +					"ha: re-setup failed.\n");
>
> AI still notes:
> ---
> What happens if __eea_pci_probe() fails during HA reset recovery? Jakub
> Kicinski's AI review in v25 noted that when probe fails after remove
> succeeded, the device is left in a removed state with no error beyond this
> single dev_err() message.
>
> The function returns 1 (from the implicit flow) indicating success, even
> though reprobe failed and the device is now non-functional. Should this
> check
> for errors and at minimum log the failure state more prominently?
>
> Reference:
> https://lore.kernel.org/netdev/20260204040054.1698677-2-kuba@kernel.org/
> ---
>

