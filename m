Return-Path: <netdev+bounces-44691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D247D93E6
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 11:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C32641F233C5
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 09:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD001642B;
	Fri, 27 Oct 2023 09:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3043816417
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 09:38:24 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF05E5
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 02:38:22 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-rTWMaksWM822x6K3xbt1qA-1; Fri, 27 Oct 2023 05:38:04 -0400
X-MC-Unique: rTWMaksWM822x6K3xbt1qA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 38D63857F8C;
	Fri, 27 Oct 2023 09:38:02 +0000 (UTC)
Received: from hog (unknown [10.39.192.51])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9356240C6F7B;
	Fri, 27 Oct 2023 09:38:00 +0000 (UTC)
Date: Fri, 27 Oct 2023 11:37:59 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew@lunn.ch, hkallweit1@gmail.com,
	linux@armlinux.org.uk, richardcochran@gmail.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	sebastian.tobuschat@oss.nxp.com
Subject: Re: [PATCH net-next v8 5/7] net: phy: nxp-c45-tja11xx: add MACsec
 support
Message-ID: <ZTuE99jyr9gW3O1S@hog>
References: <20231023094327.565297-1-radu-nicolae.pirea@oss.nxp.com>
 <20231023094327.565297-6-radu-nicolae.pirea@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231023094327.565297-6-radu-nicolae.pirea@oss.nxp.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Hi Radu,

Sorry for taking so long to review this again.

2023-10-23, 12:43:25 +0300, Radu Pirea (NXP OSS) wrote:
> +static struct nxp_c45_sa *nxp_c45_sa_alloc(struct list_head *sa_list, void *sa,
> +					   enum nxp_c45_sa_type sa_type, u8 an)
> +{
> +	struct nxp_c45_sa *first = NULL, *pos, *tmp;
> +	int ocurences = 0;

nit: spelling: ocurences -> occurrences


[...]
> +static bool nxp_c45_secy_valid(struct nxp_c45_secy *phy_secy,
> +			       bool can_rx_sc0_impl)
> +{
> +	bool end_station = phy_secy->secy->tx_sc.end_station;
> +	bool send_sci = phy_secy->secy->tx_sc.send_sci;
> +	bool scb = phy_secy->secy->tx_sc.scb;
> +	bool rx_sci_valid, tx_sci_valid;
> +	sci_t sci = phy_secy->secy->sci;
> +
> +	phy_secy->rx_sc0_impl = false;

This should only be updated in case this function returns
true. Otherwise, if this is called from nxp_c45_mdo_upd_secy and the
update is rejected, phy_secy->rx_sc0_impl will have the wrong value.

And maybe a bit nitpicky, a function called "nxp_c45_secy_valid" seems
like it would only validate but not modify its arguments. But then
you'd have to duplicate a few of the tests from this function to
decide if rx_sc0_impl must be set to true or false.

> +
> +	if (send_sci) {
> +		if (end_station || scb)

No need for this check, macsec_validate_attr already prevents this.

> +			return false;
> +		else
> +			return true;
> +	}
> +
> +	if (end_station) {

macsec_validate_attr prevents scb being set in this case. No need for
nxp_c45_sci_valid to consider scb == true, the only validation left to
do is port == 1.

> +		tx_sci_valid = nxp_c45_sci_valid(sci, scb);
> +		if (phy_secy->rx_sc) {
> +			sci = phy_secy->rx_sc->sci;
> +			rx_sci_valid = nxp_c45_sci_valid(sci, scb);
> +		} else {
> +			rx_sci_valid = true;
> +		}
> +
> +		return tx_sci_valid && rx_sci_valid;

A bit simpler IMHO:

	if (!nxp_c45_sci_valid(phy_secy->secy->sci))
		return false;
	if (!phy_secy->rx_sc)
		return true;
	return nxp_c45_sci_valid(phy_secy->rx_sc->sci);

[but doesn't work so nicely if you want to set rx_sc0_impl to false
just before returning]

> +	}
> +
> +	if (scb)
> +		return false;
> +
> +	if (!can_rx_sc0_impl)
> +		return false;
> +
> +	if (phy_secy->secy_id != 0)
> +		return false;
> +
> +	phy_secy->rx_sc0_impl = true;
> +
> +	return true;
> +}

[...]
> +static void nxp_c45_rx_sc_update(struct phy_device *phydev,
> +				 struct nxp_c45_secy *phy_secy)
> +{
> +	struct macsec_rx_sc *rx_sc = phy_secy->rx_sc;
> +	struct nxp_c45_phy *priv = phydev->priv;
> +	u32 cfg = 0;
> +
> +	nxp_c45_macsec_read(phydev, MACSEC_RXSC_CFG, &cfg);
> +	cfg &= ~MACSEC_RXSC_CFG_VF_MASK;
> +	cfg = phy_secy->secy->validate_frames << MACSEC_RXSC_CFG_VF_OFF;
> +
> +	phydev_dbg(phydev, "validate frames %u\n",
> +		   phy_secy->secy->validate_frames);
> +	phydev_dbg(phydev, "replay_protect %s window %u\n",
> +		   phy_secy->secy->replay_protect ? "on" : "off",
> +		   phy_secy->secy->replay_window);
> +	if (phy_secy->secy->replay_protect) {
> +		cfg |= MACSEC_RXSC_CFG_RP;
> +		if (cfg & MACSEC_RXSC_CFG_SCI_EN) {
> +			phydev_dbg(phydev, "RX SC enabled, window will not be updated\n");
> +		} else {
> +			phydev_dbg(phydev, "RX SC disabled, window will be updated\n");
> +			nxp_c45_macsec_write(phydev, MACSEC_RPW,
> +					     phy_secy->secy->replay_window);
> +		}

If a RXSC is already configured, it's not possible to update the
replay window? and this update will silently fail, so userspace tools
will see the new value for replay window even though it's not actually
being enforced?

> +	} else {
> +		cfg &= ~MACSEC_RXSC_CFG_RP;
> +	}


[...]
> +static int nxp_c45_mdo_add_secy(struct macsec_context *ctx)
> +{
[...]
> +	phy_secy = kzalloc(sizeof(*phy_secy), GFP_KERNEL);
> +	if (!phy_secy)
> +		return -ENOMEM;
> +
> +	INIT_LIST_HEAD(&phy_secy->sa_list);
> +	phy_secy->secy = ctx->secy;
> +	phy_secy->secy_id = idx;
> +
> +	/* If the point to point mode should be enabled, we should have only
> +	 * one SecY enabled, respectively the new one.
> +	 */
> +	can_rx_sc0_impl = list_count_nodes(&priv->macsec->secy_list) == 0;
> +	if (!nxp_c45_secy_valid(phy_secy, can_rx_sc0_impl)) {
> +		kfree_sensitive(phy_secy);

kfree is enough here, no keying information has been stored in
phy_secy.

> +		return -EINVAL;
> +	}
> +
> +	nxp_c45_select_secy(phydev, phy_secy->secy_id);
> +	nxp_c45_set_sci(phydev, MACSEC_TXSC_SCI_1H, ctx->secy->sci);
> +	nxp_c45_tx_sc_set_flt(phydev, phy_secy);
> +	nxp_c45_tx_sc_update(phydev, phy_secy);
> +	if (phy_interrupt_is_valid(phydev))
> +		nxp_c45_secy_irq_en(phydev, phy_secy, true);

Can macsec be used reliably in case we skip enabling the IRQ?

> +
> +	set_bit(idx, priv->macsec->tx_sc_bitmap);
> +	list_add_tail(&phy_secy->list, &priv->macsec->secy_list);
> +
> +	return 0;
> +}
> +

[...]
> +static int nxp_c45_mdo_del_rxsc(struct macsec_context *ctx)
> +{
> +	struct phy_device *phydev = ctx->phydev;
> +	struct nxp_c45_phy *priv = phydev->priv;
> +	struct nxp_c45_secy *phy_secy;
> +
> +	phydev_dbg(phydev, "delete RX SC SCI %016llx %s\n",
> +		   sci_to_cpu(ctx->rx_sc->sci),
> +		   ctx->rx_sc->active ? "enabled" : "disabled");
> +
> +	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
> +	if (IS_ERR(phy_secy))
> +		return PTR_ERR(phy_secy);
> +
> +	nxp_c45_select_secy(phydev, phy_secy->secy_id);
> +	nxp_c45_rx_sc_del(phydev, phy_secy);
> +	phy_secy->rx_sc = NULL;

You're not deleting any remaining RXSA here, would that cause a
problem to re-create the same RXSC + RXSA (in nxp_c45_sa_alloc's
loop)?

Something like this:

    ip link add link eth0 type macsec
    ip macsec add macsec0 rx sci 5254001201560001
    ip macsec add macsec0 rx sci 5254001201560001 sa 0 key 00010203040506070001020304050607080910 00010203040506070001020304050607 pn 1 on
    ip macsec del macsec0 rx sci 5254001201560001
    ip macsec add macsec0 rx sci 5254001201560001
    ip macsec add macsec0 rx sci 5254001201560001 sa 0 key 00010203040506070001020304050607080910 00010203040506070001020304050607 pn 1 on


> +
> +	return 0;
> +}

[...]
> +static int nxp_c45_mdo_add_txsa(struct macsec_context *ctx)
> +{
> +	struct macsec_tx_sa *tx_sa = ctx->sa.tx_sa;
> +	struct phy_device *phydev = ctx->phydev;
> +	struct nxp_c45_phy *priv = phydev->priv;
> +	struct nxp_c45_secy *phy_secy;
> +	u8 an = ctx->sa.assoc_num;
> +	struct nxp_c45_sa *sa;
> +
> +	phydev_dbg(phydev, "add TX SA %u %s to TX SC %016llx\n",
> +		   an, ctx->sa.tx_sa->active ? "enabled" : "disabled",
> +		   sci_to_cpu(ctx->secy->sci));
> +
> +	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
> +	if (IS_ERR(phy_secy))
> +		return PTR_ERR(phy_secy);
> +
> +	sa = nxp_c45_sa_alloc(&phy_secy->sa_list, tx_sa, TX_SA, an);
> +	if (IS_ERR(sa))
> +		return PTR_ERR(sa);
> +
> +	nxp_c45_select_secy(phydev, phy_secy->secy_id);
> +	nxp_c45_sa_set_pn(phydev, sa, tx_sa->next_pn, 0);
> +	nxp_c45_sa_set_key(ctx, sa->regs, tx_sa->key.salt.bytes, tx_sa->ssci);
> +	if (ctx->secy->tx_sc.encoding_sa  == sa->an)

nit: extra space to remove

> +		nxp_c45_tx_sa_update(phydev, sa, tx_sa->active);
> +
> +	return 0;
> +}

[...]
> +static int nxp_c45_mdo_del_txsa(struct macsec_context *ctx)
> +{
> +	struct phy_device *phydev = ctx->phydev;
> +	struct nxp_c45_phy *priv = phydev->priv;
> +	struct nxp_c45_secy *phy_secy;
> +	u8 an = ctx->sa.assoc_num;
> +	struct nxp_c45_sa *sa;
> +
> +	phydev_dbg(phydev, "delete TX SA %u %s to TX SC %016llx\n",
> +		   an, ctx->sa.tx_sa->active ? "enabled" : "disabled",
> +		   sci_to_cpu(ctx->secy->sci));
> +
> +	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
> +	if (IS_ERR(phy_secy))
> +		return PTR_ERR(phy_secy);
> +
> +	sa = nxp_c45_find_sa(&phy_secy->sa_list, TX_SA, an);
> +	if (IS_ERR(sa))
> +		return PTR_ERR(sa);
> +
> +	nxp_c45_select_secy(phydev, phy_secy->secy_id);
> +	if (ctx->secy->tx_sc.encoding_sa  == sa->an)

nit: extra space to remove

> +		nxp_c45_tx_sa_update(phydev, sa, false);
> +
> +	nxp_c45_sa_free(sa);
> +
> +	return 0;
> +}

-- 
Sabrina


