Return-Path: <netdev+bounces-276761-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jiJcApX21mlUKQgAu9opvQ
	(envelope-from <netdev+bounces-276761-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 02:45:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDFA3C5156
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 02:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80A7B30078D9
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 00:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D89C2741B6;
	Thu,  9 Apr 2026 00:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMAMHib3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCBD26B2AD
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 00:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775695505; cv=none; b=o42Hf+Z4IojnvQVXc66P2LoBXtSgIW4FuwlEf70p1xQcFLhwWkekphh3DZz/Ouw4H4hPq/Mrypq/bc+MapWR3hwydQppdCi6dnXdxT6zKg65FTzgJYUc6spIMhqK7w0Yzad0y+2EaOsqnm0QwGKFzu+nRne0NImxTKz5jLwsHEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775695505; c=relaxed/simple;
	bh=yKPYnKdH6B2V81W24pAJpsyTt+fFkWrquiwbGfT6igE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GIXiX2KZ+6puYmZazmHSfs+2c1jQ5We/1WcIURkg5EkeclnpreLXmZ5/MmPg6I7CrhCMD+ePna0TFYiQn5K3yzol9T5hFbCA0HCSLKt3DIlAYEaWx2ftlvCi+ivEX1OHhrTPan954bxDf4E2rcKBE+2Vo2wlauPAao+f5xMc5oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMAMHib3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7781C19421;
	Thu,  9 Apr 2026 00:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775695505;
	bh=yKPYnKdH6B2V81W24pAJpsyTt+fFkWrquiwbGfT6igE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hMAMHib3bR4GWd9vMtRvPlmGJZmi1vzYPXO8sa7qzqs9ZxnCx7gaZVqftnQTbllZn
	 6cFlCVWSIaYW5NEn+YWcEwL1fcg85Ye7lK6ByD+th7IfRm+Ap8r/PP8JaF7T7wCyJ3
	 SUk56fPyMEu7QXxe69UPAaaE5zpvc5k0Sgitx8KYo+SoYdZC8bXQGyAdZ5JIX2H6Yb
	 +z9MU8X/8v/cjXNMaM/pAWKx6bgtFBhRPHafUA9EzZZRL2cCzWilXH1c8iEtQY3V29
	 4rByjybIrhD/afsXGg/iSgIys8Y2UuvI7ykZ67qX7MjpUChsFVEGq5V+M1czy5N7WI
	 aRCpSBK/6UDCw==
Date: Wed, 8 Apr 2026 17:45:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next 1/2] i40e: implement basic per-queue stats
Message-ID: <20260408174504.17210f78@kernel.org>
In-Reply-To: <0815f1eb4b60faa653ea703e420395b724d05216.1775648513.git.pabeni@redhat.com>
References: <cover.1775648513.git.pabeni@redhat.com>
	<0815f1eb4b60faa653ea703e420395b724d05216.1775648513.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276761-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[lists.osuosl.org,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4CDFA3C5156
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed,  8 Apr 2026 13:43:45 +0200 Paolo Abeni wrote:
> +static void i40e_get_queue_stats_tx(struct net_device *dev, int idx,
> +				    struct netdev_queue_stats_tx *tx)
> +{
> +	struct i40e_netdev_priv *np = netdev_priv(dev);
> +	struct i40e_vsi *vsi = np->vsi;
> +	struct i40e_ring *tx_ring;
> +
> +	rcu_read_lock();
> +	tx_ring = READ_ONCE(vsi->tx_rings[idx]);
> +	if (!tx_ring)
> +		goto out;
> +
> +	i40e_zero_tx_ring_stats(tx);
> +	i40e_add_tx_ring_stats(tx_ring, tx);
> +
> +	if (i40e_enabled_xdp_vsi(vsi)) {
> +		tx_ring = READ_ONCE(vsi->xdp_rings[idx]);
> +		if (tx_ring)
> +			i40e_add_tx_ring_stats(tx_ring, tx);

If XDP Tx happens on dedicated queues it should be added to base,
not to the stats of the "stack" queue. This is in anticipation of
XDP being its own queue type one day, we'll then isolate those
out of base. Ripping the out of TX could cause regressions.

> +	}
> +
> +out:
> +	rcu_read_unlock();
> +}
> +
> +static void i40e_get_base_stats(struct net_device *dev,
> +				struct netdev_queue_stats_rx *rx,
> +				struct netdev_queue_stats_tx *tx)
> +{
> +	struct i40e_netdev_priv *np = netdev_priv(dev);
> +	struct i40e_vsi *vsi = np->vsi;
> +
> +	tx->bytes = vsi->tx_bytes;
> +	tx->packets = vsi->tx_packets;
> +	tx->wake = vsi->tx_restart_base;
> +	tx->stop = vsi->tx_stopped_base;
> +	tx->hw_drops = vsi->tx_busy_base;
> +
> +	rx->bytes = vsi->rx_bytes;
> +	rx->packets = vsi->rx_packets;
> +}

