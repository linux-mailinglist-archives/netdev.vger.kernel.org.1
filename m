Return-Path: <netdev+bounces-108567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E53E92456B
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 19:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1CC11F21B73
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 17:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840711BE222;
	Tue,  2 Jul 2024 17:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="qFDimd5V"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E122F14293
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 17:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719940922; cv=none; b=KIpcPn7zLDpk7GI3SA5eLInQOi0nbmC93XSRamYLXRbDyyw/aBCWg7+vKG+RsptWBcKpt8FZjkFsRtggIOmXk6kXIOVEAlvTk+ut/cMyyNVfer5bu5TTUHrv+Khi0f6klHTRYxF4NaDfVGBvrnEAl1jad7pY63iQXfgotheWoug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719940922; c=relaxed/simple;
	bh=eAUWr/HTcVSbIbiUT7G0jq4GogHiFWNNcuj0j7KTBP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMJhAXRZNj1V2ySl2PaNuEzBk/zBotH16JHrpMMYWKaownOGAt48vztmj37MY/jvWY8BJyv2eDsKqwU7pvAiCe7BPPF1RufkzrKoE7ViXnnYgbmPhzuoq4fMKEQJETJu4IphGL8MTAo2h9SWB+R5XjMDk8uJCt5p030lbIxFNHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=qFDimd5V; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JdqKrt1GLBL2/f9eRQWJJDiL3nOBPyWrg01czFu4/iI=; b=qFDimd5Vzh95ikyQ2WPBXl8Ytn
	+3F1Fghn9JBco7dsoRUM/KOmiq/+NTYHuXbK37pF5iCIlpxQOASWFwzzE+z3EMvyM5UIqRfPtWQBk
	LPlnj3h+mQLGNv2DKhWn4gBemO5U3IDz0PhSwY95PEtYur5R1p0wqqZZGaWSPSXgan6kNUyoN6gN4
	c9TePb6Fki/NNQG8eD9A+2icUuQpWAnmvnXcijeLc2zbSO4OvMqgj4N0A8g6dS/IuJR58zUeTsswj
	O19HVzalNFV8KUtGT96KhQsRSg87ZTaxklUTHriu9zlkuEU0RIRG1SLe9ZX5TkxkKVwrxN4kEWkbt
	0zMEnQPA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42108)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sOhCP-0004LR-0z;
	Tue, 02 Jul 2024 18:21:49 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sOhCQ-00026G-Nr; Tue, 02 Jul 2024 18:21:50 +0100
Date: Tue, 2 Jul 2024 18:21:50 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	kernel-team@meta.com
Subject: Re: [net-next PATCH v3 11/15] eth: fbnic: Add link detection
Message-ID: <ZoQ3LlZZ47AJ5fnL@shell.armlinux.org.uk>
References: <171993231020.3697648.2741754761742678186.stgit@ahduyck-xeon-server.home.arpa>
 <171993242260.3697648.17293962511485193331.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171993242260.3697648.17293962511485193331.stgit@ahduyck-xeon-server.home.arpa>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Thanks for the patch - this is a review mainly from the phylink
perspective.

On Tue, Jul 02, 2024 at 08:00:22AM -0700, Alexander Duyck wrote:
> +static irqreturn_t fbnic_pcs_msix_intr(int __always_unused irq, void *data)
> +{
> +	struct fbnic_dev *fbd = data;
> +	struct fbnic_net *fbn;
> +	bool link_up;
> +
> +	if (!fbd->mac->pcs_get_link_event(fbd)) {
> +		fbnic_wr32(fbd, FBNIC_INTR_MASK_CLEAR(0),
> +			   1u << FBNIC_PCS_MSIX_ENTRY);
> +		return IRQ_HANDLED;
> +	}
> +
> +	link_up = fbd->link_state == FBNIC_LINK_UP;
> +
> +	fbd->link_state = FBNIC_LINK_EVENT;
> +	fbn = netdev_priv(fbd->netdev);
> +
> +	phylink_pcs_change(&fbn->phylink_pcs, link_up);

fbd->link_state seems to be set to FBNIC_LINK_UP when the
mac_link_up(), more specifically fbnic_mac_link_up_asic() gets called.
No, never report back to phylink what phylink asked the MAC/PCS to do!

If you don't know what happened to the link here, then report that the
link went down - in other words, always pass "false" to
phylink_pcs_change() which ensures that phylink will never miss a
link-down event (because it will assume that the link went down.)

I think you could even do:

	struct fbnic_dev *fbd = data;
	struct fbnic_net *fbn;
	int status;

	status = fbd->mac->pcs_get_link_event(fbd);
	if (status == 0) {
		fbnic_wr32(fbd, FBNIC_INTR_MASK_CLEAR(0),
			   1u << FBNIC_PCS_MSIX_ENTRY);
	} else {
		fbn = netdiev_priv(fbd->netdev);

		phylink_pcs_change(&fbn->phylink_pcs, status > 0);
	}

	return IRQ_HANDLED;


> +/**
> + * fbnic_mac_enable - Configure the MAC to enable it to advertise link
> + * @fbd: Pointer to device to initialize
> + *
> + * This function provides basic bringup for the CMAC and sets the link
> + * state to FBNIC_LINK_EVENT which tells the link state check that the
> + * current state is unknown and that interrupts must be enabled after the
> + * check is completed.
> + *
> + * Return: non-zero on failure.
> + **/
> +int fbnic_mac_enable(struct fbnic_dev *fbd)
> +{
> +	struct fbnic_net *fbn = netdev_priv(fbd->netdev);
> +	u32 vector = fbd->pcs_msix_vector;
> +	int err;
> +
> +	/* Request the IRQ for MAC link vector.
> +	 * Map MAC cause to it, and unmask it
> +	 */
> +	err = request_irq(vector, &fbnic_pcs_msix_intr, 0,
> +			  fbd->netdev->name, fbd);
> +	if (err)
> +		return err;
> +
> +	fbnic_wr32(fbd, FBNIC_INTR_MSIX_CTRL(FBNIC_INTR_MSIX_CTRL_PCS_IDX),
> +		   FBNIC_PCS_MSIX_ENTRY | FBNIC_INTR_MSIX_CTRL_ENABLE);
> +
> +	phylink_start(fbn->phylink);
> +
> +	fbnic_wr32(fbd, FBNIC_INTR_SET(0), 1u << FBNIC_PCS_MSIX_ENTRY);

If this is enabling the interrupt, ideally that should be before
phylink_start().

> +void fbnic_mac_disable(struct fbnic_dev *fbd)
> +{
> +	struct fbnic_net *fbn = netdev_priv(fbd->netdev);
> +
> +	/* Nothing to do if link is already disabled */
> +	if (fbd->link_state == FBNIC_LINK_DISABLED)
> +		return;
> +
> +	phylink_stop(fbn->phylink);

Why is this conditional? If you've called phylink_start(), and the
network interface is being taken down administratively, then
phylink_stop() needs to be called no matter what. If the link was
up at that point, phylink will call your mac_link_down() as part
of that. Moreover, the networking layers guarantee that .ndo_stop
won't be called unless .ndo_open has been successfully called.

> +static int fbnic_pcs_get_link_event_asic(struct fbnic_dev *fbd)
> +{
> +	u32 pcs_intr_mask = rd32(fbd, FBNIC_SIG_PCS_INTR_STS);
> +
> +	if (pcs_intr_mask & FBNIC_SIG_PCS_INTR_LINK_DOWN)
> +		return -1;
> +
> +	return (pcs_intr_mask & FBNIC_SIG_PCS_INTR_LINK_UP) ? 1 : 0;
> +}

I think an enum/#define of some symbolic names would be useful both
here and in the interrupt handler so we have something descriptive
instead of -1, 0, 1.

> +static bool fbnic_pcs_get_link_asic(struct fbnic_dev *fbd)
> +{
> +	int link_direction;
> +	bool link;
> +
> +	/* If disabled do not update link_state nor change settings */
> +	if (fbd->link_state == FBNIC_LINK_DISABLED)
> +		return false;

If phylink_stop() has been called (one of the places you set
link_state to FBNIC_LINK_DISABLED) then phylink will force the link
down and will disregard state read from the .pcs_get_state() method.

The other place is when fbnic_pcs_disable_asic() has been called,
which I think is hooked into the .pcs_disable method. Well, if
phylink has called the .pcs_disable method, then it is disconnecting
from this PCS, and won't be calling .pcs_get_state anyway.

So all in all, I think this check is unnecessary and should be removed.

> +
> +	/* In an interrupt driven setup we can just skip the check if
> +	 * the link is up as the interrupt should toggle it to the EVENT
> +	 * state if the link has changed state at any time since the last
> +	 * check.
> +	 */
> +	if (fbd->link_state == FBNIC_LINK_UP)
> +		return true;

Again, don't feed back to phylink what phylink asked you to do!

> +
> +	link_direction = fbnic_pcs_get_link_event_asic(fbd);
> +
> +	/* Clear interrupt state due to recent changes. */
> +	wr32(fbd, FBNIC_SIG_PCS_INTR_STS,
> +	     FBNIC_SIG_PCS_INTR_LINK_DOWN | FBNIC_SIG_PCS_INTR_LINK_UP);
> +
> +	/* If link bounced down clear the PCS_STS bit related to link */
> +	if (link_direction < 0) {
> +		wr32(fbd, FBNIC_SIG_PCS_OUT0, FBNIC_SIG_PCS_OUT0_LINK |
> +					 FBNIC_SIG_PCS_OUT0_BLOCK_LOCK |
> +					 FBNIC_SIG_PCS_OUT0_AMPS_LOCK);
> +		wr32(fbd, FBNIC_SIG_PCS_OUT1, FBNIC_SIG_PCS_OUT1_FCFEC_LOCK);
> +	}

If the link "bounces" down, then phylink needs to know - but that
would be covered if, when you receive an interrupt, you always
call phylink_pcs_change(..., false). Still, phylink can deal with
latched-low clear-on-read link statuses. I think you want to read
the link status, and if it's indicating link-failed, then clear
the latched link-failed state.

> +
> +	link = fbnic_mac_get_pcs_link_status(fbd);
> +
> +	if (link_direction)
> +		wr32(fbd, FBNIC_SIG_PCS_INTR_MASK,
> +		     link ?  ~FBNIC_SIG_PCS_INTR_LINK_DOWN :
> +			     ~FBNIC_SIG_PCS_INTR_LINK_UP);

Why do you need to change the interrupt mask? Can't you just leave
both enabled and let the hardware tell you when something changes?

> +static int fbnic_pcs_enable_asic(struct fbnic_dev *fbd)
> +{
> +	/* Mask and clear the PCS interrupt, will be enabled by link handler */
> +	wr32(fbd, FBNIC_SIG_PCS_INTR_MASK, ~0);
> +	wr32(fbd, FBNIC_SIG_PCS_INTR_STS, ~0);
> +
> +	/* Pull in settings from FW */
> +	fbnic_pcs_get_fw_settings(fbd);
> +
> +	/* Flush any stale link status info */
> +	wr32(fbd, FBNIC_SIG_PCS_OUT0, FBNIC_SIG_PCS_OUT0_LINK |
> +				 FBNIC_SIG_PCS_OUT0_BLOCK_LOCK |
> +				 FBNIC_SIG_PCS_OUT0_AMPS_LOCK);

If the link went down, it's better to allow phylink to see that.

> +static void fbnic_mac_link_down_asic(struct fbnic_dev *fbd)
> +{
> +	u32 cmd_cfg, mac_ctrl;
> +
> +	if (fbd->link_state == FBNIC_LINK_DOWN)
> +		return;

You shouldn't need this.

> +static void fbnic_mac_link_up_asic(struct fbnic_dev *fbd)
> +{
> +	u32 cmd_cfg, mac_ctrl;
> +
> +	if (fbd->link_state == FBNIC_LINK_UP)
> +		return;

You shouldn't need this.

> +/* Treat the FEC bits as a bitmask laid out as follows:
> + * Bit 0: RS Enabled
> + * Bit 1: BASER(Firecode) Enabled
> + * Bit 2: Autoneg FEC
> + */
> +enum {
> +	FBNIC_FEC_OFF		= 0,
> +	FBNIC_FEC_RS		= 1,
> +	FBNIC_FEC_BASER		= 2,
> +	FBNIC_FEC_AUTO		= 4,
> +};
> +
> +#define FBNIC_FEC_MODE_MASK	(FBNIC_FEC_AUTO - 1)
> +
> +/* Treat the link modes as a set of moldulation/lanes bitmask:

Spelling: modulation

> @@ -22,9 +23,19 @@ struct fbnic_net {
>  
>  	u16 num_napi;
>  
> +	struct phylink *phylink;
> +	struct phylink_config phylink_config;
> +	struct phylink_pcs phylink_pcs;
> +
> +	u8 tx_pause;
> +	u8 rx_pause;

If you passed these flags into your .link_up method, then you don't need
to store them.

> +	u8 fec;
> +	u8 link_mode;

I think "link_mode" can be entirely removed.

> +static void
> +fbnic_phylink_pcs_get_state(struct phylink_pcs *pcs,
> +			    struct phylink_link_state *state)
> +{
> +	struct fbnic_net *fbn = fbnic_pcs_to_net(pcs);
> +	struct fbnic_dev *fbd = fbn->fbd;
> +
> +	/* For now we use hard-coded defaults and FW config to determine
> +	 * the current values. In future patches we will add support for
> +	 * reconfiguring these values and changing link settings.
> +	 */
> +	switch (fbd->fw_cap.link_speed) {
> +	case FBNIC_FW_LINK_SPEED_25R1:
> +		state->speed = SPEED_25000;
> +		break;
> +	case FBNIC_FW_LINK_SPEED_50R2:
> +		state->speed = SPEED_50000;
> +		break;
> +	case FBNIC_FW_LINK_SPEED_100R2:
> +		state->speed = SPEED_100000;
> +		break;
> +	default:
> +		state->speed = SPEED_UNKNOWN;
> +		break;
> +	}
> +
> +	state->pause |= MLO_PAUSE_RX;
> +	state->duplex = DUPLEX_FULL;
> +	state->interface = PHY_INTERFACE_MODE_XLGMII;

Please don't set state->interface, and please read the documentation
for this method:

 * Read the current inband link state from the MAC PCS, reporting the
 * current speed in @state->speed, duplex mode in @state->duplex, pause
 * mode in @state->pause using the %MLO_PAUSE_RX and %MLO_PAUSE_TX bits,
 * negotiation completion state in @state->an_complete, and link up state
 * in @state->link. If possible, @state->lp_advertising should also be
 * populated.

Note that it doesn't say that state->interface should be set (it
shouldn't.)

> +int fbnic_phylink_init(struct net_device *netdev)
> +{
> +	struct fbnic_net *fbn = netdev_priv(netdev);
> +	struct phylink *phylink;
> +
> +	fbn->phylink_pcs.ops = &fbnic_phylink_pcs_ops;

Please also set phylink_pcs.pcs_neg_mode = true (required for modern
drivers), especially as you call the argument "neg_mode" in your
pcs_config function.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

