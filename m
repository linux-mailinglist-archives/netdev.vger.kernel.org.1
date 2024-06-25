Return-Path: <netdev+bounces-106588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E334916ED3
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 19:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12C5F28DAF7
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 17:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECD4175558;
	Tue, 25 Jun 2024 17:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vhWiaT87"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991C017623C
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 17:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719335124; cv=none; b=a3TzmU5B8aoi0BTpeQdI62IsuScDDbLESXIFWFrvf8DS4jnDE+P90d9m5vgsnNx+j38omF1CyOrgVjzyS293I3XV9NwYWWVGCinKhA3ScCQwWEHkGei34qPiORmLpgX8JjUgPyfN57nsltG2TsgrtOhgrhW372dpVaR2fhP7RRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719335124; c=relaxed/simple;
	bh=i7uS2ju7P8va+Bn6H3zFKP1/+FTgVsRTCebrVb+DrfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBrsFjZCCd7/yrPfcRHgQAFMUlF568TMPOSjdUISYjFcuqPQykcKn/eMtE7HjuM/3NvA7z8VxS9+ezShp8wMoW6ugHlevPl/fTunc4n6I9E5BLoXQHeq7RNk5MkBtPRSnlAjzyacq3f+Tvy5Ta7nKRezA1vytJ2oax6gzwKJaqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vhWiaT87; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=aEVkaWrfOVMXMGdc2tFMwWLdulSaZ0Yodok50df4koo=; b=vh
	WiaT87P2wDVJw0lM68v28cXTawyPSdY1poUwsFHtgf/58cTPnTM6wJ/eCK4ZEVkbqv4HsoXEF+oZE
	Gn8XCU0x/PVoLdOk2PkgoT1wOZzU+QBithT8Gdj4JJ4szLEYy2n9H6mmK2P+U/Rq3TJSRukZwaC6y
	kWC0JPaLxThADno=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sM9ba-000xpK-Ab; Tue, 25 Jun 2024 19:05:18 +0200
Date: Tue, 25 Jun 2024 19:05:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>,
	kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com
Subject: Re: [net-next PATCH v2 11/15] eth: fbnic: Add link detection
Message-ID: <2f59be00-5585-487a-9b1a-f5abdf4665c1@lunn.ch>
References: <171932574765.3072535.12103787411698322191.stgit@ahduyck-xeon-server.home.arpa>
 <171932617837.3072535.9872136934270317593.stgit@ahduyck-xeon-server.home.arpa>
 <6971f7ce-8514-4da5-afc9-764c0da289c0@lunn.ch>
 <CAKgT0UfTAk=tNejVLSFth6aSeUhHYSmAErc84mQojXtT9n2GDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKgT0UfTAk=tNejVLSFth6aSeUhHYSmAErc84mQojXtT9n2GDg@mail.gmail.com>

On Tue, Jun 25, 2024 at 09:29:01AM -0700, Alexander Duyck wrote:
> On Tue, Jun 25, 2024 at 8:25 AM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > +     /* Tri-state value indicating state of link.
> > > +      *  0 - Up
> > > +      *  1 - Down
> > > +      *  2 - Event - Requires checking as link state may have changed
> > > +      */
> > > +     s8 link_state;
> >
> > Maybe add an enum?
> 
> Doesn't that default to a 32b size? The general thought was to just
> keep this small since it only needs to be a few bits.

I think you can do

enum __packed link_state_states {
	LINK_UP,
	LINK_DOWN,
	LINK_SIDEWAYS,
};

and it then should be a single byte. There appears to be one instance
of this already in the kernel:

drivers/accel/qaic/qaic.h:enum __packed dev_states {

> > > +static u32 __fbnic_mac_config_asic(struct fbnic_dev *fbd)
> > > +{
> > > +     /* Enable MAC Promiscuous mode and Tx padding */
> > > +     u32 command_config = FBNIC_MAC_COMMAND_CONFIG_TX_PAD_EN |
> > > +                          FBNIC_MAC_COMMAND_CONFIG_PROMISC_EN;
> > > +     struct fbnic_net *fbn = netdev_priv(fbd->netdev);
> > > +     u32 rxb_pause_ctrl;
> > > +
> > > +     /* Set class 0 Quanta and refresh */
> > > +     wr32(fbd, FBNIC_MAC_CL01_PAUSE_QUANTA, 0xffff);
> > > +     wr32(fbd, FBNIC_MAC_CL01_QUANTA_THRESH, 0x7fff);
> > > +
> > > +     /* Enable generation of pause frames if enabled */
> > > +     rxb_pause_ctrl = rd32(fbd, FBNIC_RXB_PAUSE_DROP_CTRL);
> > > +     rxb_pause_ctrl &= ~FBNIC_RXB_PAUSE_DROP_CTRL_PAUSE_ENABLE;
> > > +     if (!fbn->tx_pause)
> > > +             command_config |= FBNIC_MAC_COMMAND_CONFIG_TX_PAUSE_DIS;
> > > +     else
> > > +             rxb_pause_ctrl |=
> > > +                     FIELD_PREP(FBNIC_RXB_PAUSE_DROP_CTRL_PAUSE_ENABLE,
> > > +                                FBNIC_PAUSE_EN_MASK);
> > > +     wr32(fbd, FBNIC_RXB_PAUSE_DROP_CTRL, rxb_pause_ctrl);
> > > +
> > > +     if (!fbn->rx_pause)
> > > +             command_config |= FBNIC_MAC_COMMAND_CONFIG_RX_PAUSE_DIS;
> >
> > Everybody gets pause wrong. To try to combat that it has mostly been
> > moved into phylink. When phylink calls your mac_config() callback it
> > passes const struct phylink_link_state *state. Within state is the
> > pause member. That tells you how to configure the hardware. phylink
> > will then deal with the differences between forced pause configuration
> > and negotiated pause configuration, etc. Your current mac_config() is
> > empty...
> >
> >         Andrew
> 
> So the pause setup for now is stored in fbn->[tr]x_pause. So if we
> were to configure it via the mac_config call and then likely call into
> this function. We end up having to reuse it in a few spots to avoid
> having to read/modify the MAC register and instead just set the data
> based on our stored config. Although I think we might be able to pare
> this down as the command_config is the only piece we really need to
> carry. The rest of this setup is essentially just a pause config which
> could be done once instead of on every link up/down transition. I will
> look at splitting this up.

Humm, actually, i got that wrong, sorry.

/**
 * mac_link_up() - allow the link to come up
 * @config: a pointer to a &struct phylink_config.
 * @phy: any attached phy
 * @mode: link autonegotiation mode
 * @interface: link &typedef phy_interface_t mode
 * @speed: link speed
 * @duplex: link duplex
 * @tx_pause: link transmit pause enablement status
 * @rx_pause: link receive pause enablement status
 *
 * Configure the MAC for an established link.
 *
 * @speed, @duplex, @tx_pause and @rx_pause indicate the finalised link
 * settings, and should be used to configure the MAC block appropriately
 * where these settings are not automatically conveyed from the PCS block,
 * or if in-band negotiation (as defined by phylink_autoneg_inband(@mode))
 * is disabled.
 *
 * Note that when 802.3z in-band negotiation is in use, it is possible
 * that the user wishes to override the pause settings, and this should
 * be allowed when considering the implementation of this method.
 *
 * If in-band negotiation mode is disabled, allow the link to come up. If
 * @phy is non-%NULL, configure Energy Efficient Ethernet by calling
 * phy_init_eee() and perform appropriate MAC configuration for EEE.
 * Interface type selection must be done in mac_config().
 */
void mac_link_up(struct phylink_config *config, struct phy_device *phy,
		 unsigned int mode, phy_interface_t interface,
		 int speed, int duplex, bool tx_pause, bool rx_pause);

In your case, your pcs_config() should pass the pause settings which
is should advertise:

/**
 * pcs_config() - Configure the PCS mode and advertisement
 * @pcs: a pointer to a &struct phylink_pcs.
 * @neg_mode: link negotiation mode (see below)
 * @interface: interface mode to be used
 * @advertising: adertisement ethtool link mode mask
 * @permit_pause_to_mac: permit forwarding pause resolution to MAC
 *
 * Configure the PCS for the operating mode, the interface mode, and set
 * the advertisement mask. @permit_pause_to_mac indicates whether the
 * hardware may forward the pause mode resolution to the MAC.
 *
 * When operating in %MLO_AN_INBAND, inband should always be enabled,
 * otherwise inband should be disabled.
 *
 * For SGMII, there is no advertisement from the MAC side, the PCS should
 * be programmed to acknowledge the inband word from the PHY.
 *
 * For 1000BASE-X, the advertisement should be programmed into the PCS.
 *
 * For most 10GBASE-R, there is no advertisement.
 *
 * The %neg_mode argument should be tested via the phylink_mode_*() family of
 * functions, or for PCS that set pcs->neg_mode true, should be tested
 * against the PHYLINK_PCS_NEG_* definitions.
 */
int pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
	       phy_interface_t interface, const unsigned long *advertising,
	       bool permit_pause_to_mac);

and when the PCS has negotiated the link, you get the result with:

/**
 * pcs_get_state() - Read the current inband link state from the hardware
 * @pcs: a pointer to a &struct phylink_pcs.
 * @state: a pointer to a &struct phylink_link_state.
 *
 * Read the current inband link state from the MAC PCS, reporting the
 * current speed in @state->speed, duplex mode in @state->duplex, pause
 * mode in @state->pause using the %MLO_PAUSE_RX and %MLO_PAUSE_TX bits,
 * negotiation completion state in @state->an_complete, and link up state
 * in @state->link. If possible, @state->lp_advertising should also be
 * populated.
 */
void pcs_get_state(struct phylink_pcs *pcs,
		   struct phylink_link_state *state);

If however pause autoneg is off, and pause is being forced, the values
from pcs_get_state() are ignored, and mac_link_up() will give you the
forced values.

Once you have a fuller phylink implementation, you should Cc: Russell
King.

       Andrew

