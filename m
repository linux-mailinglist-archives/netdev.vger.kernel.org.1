Return-Path: <netdev+bounces-32810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 898DF79A7C4
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 14:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95531C208EE
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 12:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D92EC8F8;
	Mon, 11 Sep 2023 12:01:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808B6E550
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 12:01:09 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id D296DCEB
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 05:01:07 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-uiqJIlB3N3-lBQCaTQUkBg-1; Mon, 11 Sep 2023 08:00:35 -0400
X-MC-Unique: uiqJIlB3N3-lBQCaTQUkBg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 423408279AB;
	Mon, 11 Sep 2023 12:00:34 +0000 (UTC)
Received: from hog (unknown [10.39.192.47])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 827F940C2009;
	Mon, 11 Sep 2023 12:00:32 +0000 (UTC)
Date: Mon, 11 Sep 2023 14:00:31 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com,
	sebastian.tobuschat@nxp.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next v3 4/6] net: phy: nxp-c45-tja11xx: add MACsec
 support
Message-ID: <ZP8BXxD0WZtdJ913@hog>
References: <20230906160134.311993-1-radu-nicolae.pirea@oss.nxp.com>
 <20230906160134.311993-5-radu-nicolae.pirea@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230906160134.311993-5-radu-nicolae.pirea@oss.nxp.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
	RCVD_IN_VALIDITY_RPBL,RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-09-06, 19:01:32 +0300, Radu Pirea (NXP OSS) wrote:
> Changes in v3:
> - removed struct nxp_c45_rx_sc
> - replaced struct nxp_c45_tx_sa with struct nxp_c45_sa
> - reworked the implementation around struct nxp_c45_sa
> - various renamings
> - tried to better group the functions by SA type/SC type
> - no key is stored in the driver
> - TX SAs limited to 2 insted of 4(no key in the driver consequence)
> - used sci_to_cpu where in various functions
> - improved debug information
> - nxp_c45_secy_valid function reworked
> - merged TX/RX SA set key functions
> - merged TX/RX SA set pn functions
> - tried to stick to tx_sa/rx_sa/rx_sc/tx_sc function naming. 
> - nxp_c45_macsec_config_init will return an error if a write fails.
> - MACSEC_TXSC_CFG_SCI renamed to MACSEC_TXSC_CFG_SCB
> - return -ENOSPC if no SC/SA available in the hardware
> - phydev->macsec_ops allocated using devm_kzalloc

nit: not macsec_ops


[...]
> +static void nxp_c45_set_sci(struct phy_device *phydev, u16 sci_base_addr,
> +			    sci_t sci)
> +{
> +	u64 lsci = sci_to_cpu(sci);
> +
> +	nxp_c45_macsec_write(phydev, sci_base_addr, lsci >> 32);
> +	nxp_c45_macsec_write(phydev, sci_base_addr + 4, lsci);
> +}
> +
> +static bool nxp_c45_sci_valid(sci_t sci, bool scb)
> +{
> +	u16 port = sci_to_cpu(sci);
> +
> +	if (scb && port != 0)
> +		return false;
> +	if (!scb && port != 1)
> +		return false;

For non-SCB (ie normal case), only port 1 is allowed? That doesn't
seem to match what nxp_c45_rx_sc_valid was doing in v2, but it is also
called from nxp_c45_mdo_add_rxsc..

> +
> +	return true;
> +}
> +

[...]
> +static void nxp_c45_tx_sa_next(struct nxp_c45_secy *phy_secy,
> +			       struct nxp_c45_sa *next_sa, u8 encoding_sa)
> +{
> +	struct nxp_c45_sa *sa;
> +
> +	sa = nxp_c45_find_sa(&phy_secy->sa_list, TX_SA, encoding_sa);
> +	if (!IS_ERR(sa)) {
> +		memcpy(next_sa, sa, sizeof(*sa));
> +	} else {
> +		next_sa->is_key_a = true;
> +		next_sa->an = encoding_sa;
> +	}
> +}

What is this doing? Why are you filling a fake SA struct when none is
currently configured?



> +static int nxp_c45_mdo_upd_txsa(struct macsec_context *ctx)
> +{
> +	struct macsec_tx_sa *tx_sa = ctx->sa.tx_sa;
> +	struct phy_device *phydev = ctx->phydev;
> +	struct nxp_c45_phy *priv = phydev->priv;
> +	struct nxp_c45_secy *phy_secy;
> +	u8 an = ctx->sa.assoc_num;
> +	struct nxp_c45_sa *sa;
> +
> +	phydev_dbg(phydev, "update TX SA %u %s to TX SC %016llx\n",
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
> +	nxp_c45_sa_set_pn(phydev, sa, tx_sa->next_pn, 0);

The macsec core doesn't increment its PN when we're offloading. If
userspace didn't pass a new PN, aren't we resetting the HW's PN back
to its initial value here? That would cause replay protection to fail,
and the PN reuse would break GCM.

Could you check by inspecting the sequence numbers sent by the device
before and after this:

    ip macsec set macsec0 tx sa 0 on


And same for nxp_c45_mdo_upd_rxsa -> nxp_c45_sa_set_pn. Testing would
require enabling replay protection and making the PN go backward on
the TX side.

> +	nxp_c45_tx_sa_update(phydev, sa, ctx->secy->tx_sc.encoding_sa,
> +			     tx_sa->active);
> +	return 0;
> +}

-- 
Sabrina


