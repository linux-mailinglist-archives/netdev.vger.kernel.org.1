Return-Path: <netdev+bounces-260179-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KC1oHwywnGmYJwQAu9opvQ
	(envelope-from <netdev+bounces-260179-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 20:52:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE35817C8BE
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 20:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F577302DE69
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E96374739;
	Mon, 23 Feb 2026 19:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tq4hbcA2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D7B22A4EE;
	Mon, 23 Feb 2026 19:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771876359; cv=none; b=WhLB9xqWSTH09wpjpeVfqS2anAODJG80bSOw8Yi1KDAt7hfZ9GTw5J2SGgG90vHg8zAg3UNTR4gWeSRWPnHUjPykfA74zgB1JgavBU+t38eHfhHc+zCdOUJ1aeGjahArEa2D291ag+Utj/SWisQc5SRHW5h/hwaR2HtdG/TmuJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771876359; c=relaxed/simple;
	bh=nEibsgVY9kLkV51cfwrA1pMH4grETfEAGpFuW4gCFqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDxouOi/1iKpIrJztKvQtVTU4vqmZGndIG4qzFYGLOmE4k9crG3PUgLVyM8UqKyIeDkXJPnv7nkF7mP1vGbkIER75ODwlZOr9rsYZi5R5UZbCED4SYWZWtQiAkhnNNkak77GMQwVpK/CsqW+u3fJ+R8d3PlaEQncIK19c3j3Sjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tq4hbcA2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=i6QExtrIIu4JEoq9aGYX1BgW3iwk2fN56r8A3eI3PLo=; b=tq4hbcA2VuSPiRLG1nwhVwnJcT
	3z1q56G/N9yrkjvgbYterKeKlPIYnLfpS5OBudGwEi2wSJjmZql87dWrgbZMoeF7U5GbG48dc3/Tc
	6ViXB2IARiVs418NVleeKXtYOD1wYHxElX1fBPZJbfhQHFI6nyS6ah8937MFNibdhr9o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vubyo-008VUo-5k; Mon, 23 Feb 2026 20:52:30 +0100
Date: Mon, 23 Feb 2026 20:52:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com, vikas.gupta@broadcom.com,
	Rahul Gupta <rahul-rg.gupta@broadcom.com>,
	Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
Subject: Re: [PATCH net-next 5/7] bng_en: add initial support for ethtool
 stats display
Message-ID: <14ac2695-7046-4d67-8b00-6deeb27da73f@lunn.ch>
References: <20260223163641.755200-1-bhargava.marreddy@broadcom.com>
 <20260223163641.755200-6-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223163641.755200-6-bhargava.marreddy@broadcom.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260179-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: EE35817C8BE
X-Rspamd-Action: no action

> +	BNGE_RX_STATS_ENTRY(rx_64b_frames),
> +	BNGE_RX_STATS_ENTRY(rx_65b_127b_frames),
> +	BNGE_RX_STATS_ENTRY(rx_128b_255b_frames),
> +	BNGE_RX_STATS_ENTRY(rx_256b_511b_frames),
> +	BNGE_RX_STATS_ENTRY(rx_512b_1023b_frames),
> +	BNGE_RX_STATS_ENTRY(rx_1024b_1518b_frames),
> +	BNGE_RX_STATS_ENTRY(rx_good_vlan_frames),
> +	BNGE_RX_STATS_ENTRY(rx_1519b_2047b_frames),
> +	BNGE_RX_STATS_ENTRY(rx_2048b_4095b_frames),
> +	BNGE_RX_STATS_ENTRY(rx_4096b_9216b_frames),
> +	BNGE_RX_STATS_ENTRY(rx_9217b_16383b_frames),

> +	BNGE_TX_STATS_ENTRY(tx_64b_frames),
> +	BNGE_TX_STATS_ENTRY(tx_65b_127b_frames),
> +	BNGE_TX_STATS_ENTRY(tx_128b_255b_frames),
> +	BNGE_TX_STATS_ENTRY(tx_256b_511b_frames),
> +	BNGE_TX_STATS_ENTRY(tx_512b_1023b_frames),
> +	BNGE_TX_STATS_ENTRY(tx_1024b_1518b_frames),
> +	BNGE_TX_STATS_ENTRY(tx_good_vlan_frames),
> +	BNGE_TX_STATS_ENTRY(tx_1519b_2047b_frames),
> +	BNGE_TX_STATS_ENTRY(tx_2048b_4095b_frames),
> +	BNGE_TX_STATS_ENTRY(tx_4096b_9216b_frames),
> +	BNGE_TX_STATS_ENTRY(tx_9217b_16383b_frames),

These look like rmon stats, which should be returned by the ethtool
.get_rmon_stats call. Please take a look at the documentation of

 * @get_eth_phy_stats: Query some of the IEEE 802.3 PHY statistics.
 * @get_eth_mac_stats: Query some of the IEEE 802.3 MAC statistics.
 * @get_eth_ctrl_stats: Query some of the IEEE 802.3 MAC Ctrl statistics.

and see if you should be using these as well.

	Andrew

