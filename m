Return-Path: <netdev+bounces-106557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB71916CFA
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 17:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4DAB1F2A522
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 15:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2482D173325;
	Tue, 25 Jun 2024 15:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FiAwZzw6"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7319416DEB3
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 15:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719329127; cv=none; b=HOIRxdE1HCO/OD/uvHH8NUfOwoMpL6zKsVdmpjrBngWuPFCDH2Hn21p4YecxreDxvLRYVsFVSSvJbRtAgFaKGTtqaWCo8/AqZeQaX7yNr1ffSZqtZAFSMqiV7qkSCRpOTTtYynQSZQX4zpj6bqtYXQqNQ69vIAiyM8AP+DeSqrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719329127; c=relaxed/simple;
	bh=S1ZN2YsmhMIHBODx8GUBJZUTMGcylwKsaX5J/TwATv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BalnFC8AiCgMSfwxD8sgNhQz5X5OAI7KIlRU66o8djz/MqZ632rCGvpVedZ+Lb7JwOGJe+vsVBh1gMmdikB00QknsZeQ+SYTSajbNv4UH0vZjlwGK4X7mPsFmX25f2scpb+HF9+7NWFkqDZb7mUG2IrpKhQnAwUcWfFdVgL+r0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FiAwZzw6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1UQg/EmuREzP7C5y+v27cZZm4G+gXLLXTFClnv+eXBo=; b=FiAwZzw6f6FlQHmmCG+iXQWAK6
	AlrRaMfmgSXTOG8FEuuNhcCoTyqNNj70LIF03LYYf2T/bomRKzbfkCKRSENlpKlN9eql+xuwa4QuD
	h49OY4e01N8nEAeSNL16s7cza1EBVRn5CfRs4F/Do/rlx0cGvg3SihrLiy/Uz7WqasFQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sM82m-000xMa-JR; Tue, 25 Jun 2024 17:25:16 +0200
Date: Tue, 25 Jun 2024 17:25:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>,
	kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com
Subject: Re: [net-next PATCH v2 11/15] eth: fbnic: Add link detection
Message-ID: <6971f7ce-8514-4da5-afc9-764c0da289c0@lunn.ch>
References: <171932574765.3072535.12103787411698322191.stgit@ahduyck-xeon-server.home.arpa>
 <171932617837.3072535.9872136934270317593.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171932617837.3072535.9872136934270317593.stgit@ahduyck-xeon-server.home.arpa>

> +	/* Tri-state value indicating state of link.
> +	 *  0 - Up
> +	 *  1 - Down
> +	 *  2 - Event - Requires checking as link state may have changed
> +	 */
> +	s8 link_state;

Maybe add an enum?

> +static irqreturn_t fbnic_mac_msix_intr(int __always_unused irq, void *data)
> +{
> +	struct fbnic_dev *fbd = data;
> +	struct fbnic_net *fbn;
> +
> +	if (!fbd->mac->get_link_event(fbd)) {
> +		fbnic_wr32(fbd, FBNIC_INTR_MASK_CLEAR(0),
> +			   1u << FBNIC_MAC_MSIX_ENTRY);
> +		return IRQ_HANDLED;
> +	}
> +
> +	fbd->link_state = FBNIC_LINK_EVENT;
> +	fbn = netdev_priv(fbd->netdev);
> +
> +	phylink_mac_change(fbn->phylink, fbd->link_state == FBNIC_LINK_UP);

Can fbd->link_state == FBNIC_LINK_UP given that you have just done:
    fbd->link_state = FBNIC_LINK_EVENT ? 

> +static u32 __fbnic_mac_config_asic(struct fbnic_dev *fbd)
> +{
> +	/* Enable MAC Promiscuous mode and Tx padding */
> +	u32 command_config = FBNIC_MAC_COMMAND_CONFIG_TX_PAD_EN |
> +			     FBNIC_MAC_COMMAND_CONFIG_PROMISC_EN;
> +	struct fbnic_net *fbn = netdev_priv(fbd->netdev);
> +	u32 rxb_pause_ctrl;
> +
> +	/* Set class 0 Quanta and refresh */
> +	wr32(fbd, FBNIC_MAC_CL01_PAUSE_QUANTA, 0xffff);
> +	wr32(fbd, FBNIC_MAC_CL01_QUANTA_THRESH, 0x7fff);
> +
> +	/* Enable generation of pause frames if enabled */
> +	rxb_pause_ctrl = rd32(fbd, FBNIC_RXB_PAUSE_DROP_CTRL);
> +	rxb_pause_ctrl &= ~FBNIC_RXB_PAUSE_DROP_CTRL_PAUSE_ENABLE;
> +	if (!fbn->tx_pause)
> +		command_config |= FBNIC_MAC_COMMAND_CONFIG_TX_PAUSE_DIS;
> +	else
> +		rxb_pause_ctrl |=
> +			FIELD_PREP(FBNIC_RXB_PAUSE_DROP_CTRL_PAUSE_ENABLE,
> +				   FBNIC_PAUSE_EN_MASK);
> +	wr32(fbd, FBNIC_RXB_PAUSE_DROP_CTRL, rxb_pause_ctrl);
> +
> +	if (!fbn->rx_pause)
> +		command_config |= FBNIC_MAC_COMMAND_CONFIG_RX_PAUSE_DIS;

Everybody gets pause wrong. To try to combat that it has mostly been
moved into phylink. When phylink calls your mac_config() callback it
passes const struct phylink_link_state *state. Within state is the
pause member. That tells you how to configure the hardware. phylink
will then deal with the differences between forced pause configuration
and negotiated pause configuration, etc. Your current mac_config() is
empty...

	Andrew


