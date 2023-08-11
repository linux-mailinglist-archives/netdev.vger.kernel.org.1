Return-Path: <netdev+bounces-26712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96237778A46
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 11:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B17571C210AB
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 09:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562C0569E;
	Fri, 11 Aug 2023 09:46:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A5A5690
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 09:46:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490D2C433C8;
	Fri, 11 Aug 2023 09:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691747179;
	bh=/2QlZ6PsfJe7EidL4ceSoEkagagHhTjHN35hKeIyqOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GeQvJ1b4EMtvCJ1/iRkzlEHgUbJEp/uu4pYbBBxd9UK9UrTtET6zc5wfnQMFjmuZX
	 HA8Qwjd9+0+zy3f3yhFaDvEXRNxn9l5Xx1Zrq8z+xgIdAM6xJZxZZGej9A4ijMmNaa
	 /cebKc7HoySCCTXjE+qmbKGHyuEho7ZTmcwrnpgBMPV6Kk4aQ1zUTUc8TCCFG6k20P
	 k8pCAQgjXG6VxSDArqiXOJy/b9Qu/azaX2OUKygIyBjgQnZrQK1lm0kXEaggw57c0s
	 3xRXMEC7I33km8651SFdF6jezuwoKN31E4wfX1rRjsYxRc1Bm2Tk9lvcEtm2gJmYxq
	 Zqa5fYgjG3n6w==
Date: Fri, 11 Aug 2023 11:46:14 +0200
From: Simon Horman <horms@kernel.org>
To: Roger Quadros <rogerq@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, vladimir.oltean@nxp.com, s-vadapalli@ti.com,
	srk@ti.com, vigneshr@ti.com, p-varis@ti.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: ethernet: ti: am65-cpsw-qos: Add Frame
 Preemption MAC Merge support
Message-ID: <ZNYDZkjuFjF7n3VV@vergenet.net>
References: <20230810152538.138718-1-rogerq@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230810152538.138718-1-rogerq@kernel.org>

On Thu, Aug 10, 2023 at 06:25:38PM +0300, Roger Quadros wrote:
> Add driver support for viewing / changing the MAC Merge sublayer
> parameters and seeing the verification state machine's current state
> via ethtool.
> 
> As hardware does not support interrupt notification for verification
> events we resort to polling on link up. On link up we try a couple of
> times for verification success and if unsuccessful then give up.
> 
> The Frame Preemption feature is described in the Technical Reference
> Manual [1] in section:
> 	12.3.1.4.6.7 Intersperced Express Traffic (IET – P802.3br/D2.0)
> 
> Due to Silicon Errata i2208 [2] we set limit min IET fragment size to 124.
> 
> [1] AM62x TRM - https://www.ti.com/lit/ug/spruiv7a/spruiv7a.pdf
> [2] AM62x Silicon Errata - https://www.ti.com/lit/er/sprz487c/sprz487c.pdf
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>

Hi Roger,

some minor feedback from my side.

...

> +static int am65_cpsw_get_mm(struct net_device *ndev, struct ethtool_mm_state *state)
> +{
> +	struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
> +	u32 port_ctrl, cmn_ctrl, iet_ctrl, iet_status, verify_cnt;
> +	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
> +	struct am65_cpsw_ndev_priv *priv = netdev_priv(ndev);
> +	u32 add_frag_size;
> +
> +	mutex_lock(&priv->mm_lock);
> +
> +	iet_ctrl = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
> +	cmn_ctrl = readl(common->cpsw_base + AM65_CPSW_REG_CTL);

cmn_ctrl appears to be set but not used.
Is this intentional?

> +	port_ctrl = readl(port->port_base + AM65_CPSW_PN_REG_CTL);
> +
> +	state->tx_enabled = !!(iet_ctrl & AM65_CPSW_PN_IET_MAC_PENABLE);
> +	state->pmac_enabled = !!(port_ctrl & AM65_CPSW_PN_CTL_IET_PORT_EN);
> +
> +	iet_status = readl(port->port_base + AM65_CPSW_PN_REG_IET_STATUS);
> +
> +	if (iet_ctrl & AM65_CPSW_PN_IET_MAC_DISABLEVERIFY)
> +		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
> +	else if (iet_status & AM65_CPSW_PN_MAC_VERIFIED)
> +		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED;
> +	else if (iet_status & AM65_CPSW_PN_MAC_VERIFY_FAIL)
> +		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_FAILED;
> +	else
> +		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_UNKNOWN;
> +
> +	add_frag_size = AM65_CPSW_PN_IET_MAC_GET_ADDFRAGSIZE(iet_ctrl);
> +	state->tx_min_frag_size = ethtool_mm_frag_size_add_to_min(add_frag_size);
> +
> +	/* Errata i2208: RX min fragment size cannot be less than 124 */
> +	state->rx_min_frag_size = 124;
> +
> +	/* FPE active if common tx_enabled and verification success or disabled (forced) */
> +	state->tx_active = state->tx_enabled &&
> +			   (state->verify_status == ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED ||
> +			    state->verify_status == ETHTOOL_MM_VERIFY_STATUS_DISABLED);
> +	state->verify_enabled = !(iet_ctrl & AM65_CPSW_PN_IET_MAC_DISABLEVERIFY);
> +
> +	verify_cnt = AM65_CPSW_PN_MAC_GET_VERIFY_CNT(readl(port->port_base +
> +							   AM65_CPSW_PN_REG_IET_VERIFY));

Likewise, verify_cnt appears to be set but not used.

> +	state->verify_time = port->qos.iet.verify_time_ms;
> +	state->max_verify_time = am65_cpsw_iet_get_verify_timeout_ms(AM65_CPSW_PN_MAC_VERIFY_CNT_MASK,
> +								     port);
> +	mutex_unlock(&priv->mm_lock);
> +
> +	return 0;
> +}

...

> +void am65_cpsw_iet_change_preemptible_tcs(struct am65_cpsw_port *port, u8 preemptible_tcs)

nit: should this function be static?

> +{
> +	port->qos.iet.preemptible_tcs = preemptible_tcs;
> +	am65_cpsw_iet_commit_preemptible_tcs(port);
> +}
> +
> +void am65_cpsw_iet_link_state_update(struct net_device *ndev)

Ditto

> +{
> +	struct am65_cpsw_ndev_priv *priv = am65_ndev_to_priv(ndev);
> +	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
> +
> +	mutex_lock(&priv->mm_lock);
> +	am65_cpsw_iet_commit_preemptible_tcs(port);
> +	mutex_unlock(&priv->mm_lock);
> +}

...

