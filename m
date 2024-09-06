Return-Path: <netdev+bounces-126044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAB196FC0B
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 21:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBDFF1C20D0B
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 19:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76ABF1B85EA;
	Fri,  6 Sep 2024 19:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3sYl142"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486721B85C9
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 19:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725650293; cv=none; b=OD/I32xNk/eSprCx4LaLt7Is2kRtMQnrZ4zZ7bY5u7NWAObZEo2aZzYJ8M1WOpK7pInm7dx28QfSaV2A/1Y3/wEyOabJry5YKCfV3HLgrwwpHw7YO/590PY3yryj40DFaISZHGw+mE6oKQ33BdQSQFVnBCXXR8UdXsbZSq78QNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725650293; c=relaxed/simple;
	bh=NdsUwSJHpotqQosh0ymtJ2U5av6E3nHr820bEPvhlKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azDTLCRPAqzKk9CLmnAiGyI4oCVynfBvnI5cCTQke9v/P9uWKFV4Sf3lLaGVhpobIByxYImJNspKML2kqPSqJg5hSz+xobqJNQMzVS81mbk4r6ibq+G8Tw47y/OWJ75qkB00wsc7rvqXAqCd0+snEQBGVWAKjVHwhkLhZu/pbqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3sYl142; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16353C4CEC4;
	Fri,  6 Sep 2024 19:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725650292;
	bh=NdsUwSJHpotqQosh0ymtJ2U5av6E3nHr820bEPvhlKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W3sYl142PFQLLvo2TetJ1nCc1JRVBJUkkGm0xhVjHslGedy6SM4Do9yo/Zy5MZopl
	 iELx1dZDqDpVqDRncKaTeHxgYUVdJZ/P4VeAS236tN08kF+1gSbhpkpviTP+vVw+li
	 ap9dcb2Syljczr9l5hYFj3nJRUqZgJiv+E/SDKAf3FawlhQ2Fxj/IR37GI70nC7jUJ
	 BRo5nBYMqrQgLkUdNAuIxy1hFHN3pypsbnDgtg72oyM2pjetQH6v/40Cf1MxaFtjQ0
	 G7tNye7vQZJopKX+1EHbDn3WI2+uWOgQh0Zsm62Cjs6aJhVY51IB1sQUcI1XfuyuJf
	 dxTMd/RyqMCHg==
Date: Fri, 6 Sep 2024 20:18:09 +0100
From: Simon Horman <horms@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	ryazanov.s.a@gmail.com, edumazet@google.com, andrew@lunn.ch,
	sd@queasysnail.net
Subject: Re: [PATCH net-next v6 11/25] ovpn: implement basic RX path (UDP)
Message-ID: <20240906191809.GM2097826@kernel.org>
References: <20240827120805.13681-1-antonio@openvpn.net>
 <20240827120805.13681-12-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827120805.13681-12-antonio@openvpn.net>

On Tue, Aug 27, 2024 at 02:07:51PM +0200, Antonio Quartulli wrote:
> Packets received over the socket are forwarded to the user device.
> 
> Implementation is UDP only. TCP will be added by a later patch.
> 
> Note: no decryption/decapsulation exists yet, packets are forwarded as
> they arrive without much processing.
> 
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>

...

> +/**
> + * ovpn_udp_encap_recv - Start processing a received UDP packet.
> + * @sk: socket over which the packet was received
> + * @skb: the received packet
> + *
> + * If the first byte of the payload is DATA_V2, the packet is further processed,
> + * otherwise it is forwarded to the UDP stack for delivery to user space.
> + *
> + * Return:
> + *  0 if skb was consumed or dropped
> + * >0 if skb should be passed up to userspace as UDP (packet not consumed)
> + * <0 if skb should be resubmitted as proto -N (packet not consumed)
> + */
> +static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
> +{
> +	struct ovpn_peer *peer = NULL;
> +	struct ovpn_struct *ovpn;
> +	u32 peer_id;
> +	u8 opcode;
> +
> +	ovpn = ovpn_from_udp_sock(sk);
> +	if (unlikely(!ovpn)) {
> +		net_err_ratelimited("%s: cannot obtain ovpn object from UDP socket\n",
> +				    __func__);
> +		goto drop;

Hi Antonio,

Here ovpn is NULL. But jumping to drop will result in ovpn being dereferenced.

Flagged by Smatch.


> +	}
> +
> +	/* Make sure the first 4 bytes of the skb data buffer after the UDP
> +	 * header are accessible.
> +	 * They are required to fetch the OP code, the key ID and the peer ID.
> +	 */
> +	if (unlikely(!pskb_may_pull(skb, sizeof(struct udphdr) +
> +				    OVPN_OP_SIZE_V2))) {
> +		net_dbg_ratelimited("%s: packet too small\n", __func__);
> +		goto drop;
> +	}
> +
> +	opcode = ovpn_opcode_from_skb(skb, sizeof(struct udphdr));
> +	if (unlikely(opcode != OVPN_DATA_V2)) {
> +		/* DATA_V1 is not supported */
> +		if (opcode == OVPN_DATA_V1)
> +			goto drop;
> +
> +		/* unknown or control packet: let it bubble up to userspace */
> +		return 1;
> +	}
> +
> +	peer_id = ovpn_peer_id_from_skb(skb, sizeof(struct udphdr));
> +	/* some OpenVPN server implementations send data packets with the
> +	 * peer-id set to undef. In this case we skip the peer lookup by peer-id
> +	 * and we try with the transport address
> +	 */
> +	if (peer_id != OVPN_PEER_ID_UNDEF) {
> +		peer = ovpn_peer_get_by_id(ovpn, peer_id);
> +		if (!peer) {
> +			net_err_ratelimited("%s: received data from unknown peer (id: %d)\n",
> +					    __func__, peer_id);
> +			goto drop;
> +		}
> +	}
> +
> +	if (!peer) {
> +		/* data packet with undef peer-id */
> +		peer = ovpn_peer_get_by_transp_addr(ovpn, skb);
> +		if (unlikely(!peer)) {
> +			net_dbg_ratelimited("%s: received data with undef peer-id from unknown source\n",
> +					    __func__);
> +			goto drop;
> +		}
> +	}
> +
> +	/* pop off outer UDP header */
> +	__skb_pull(skb, sizeof(struct udphdr));
> +	ovpn_recv(peer, skb);
> +	return 0;
> +
> +drop:
> +	if (peer)
> +		ovpn_peer_put(peer);
> +	dev_core_stats_rx_dropped_inc(ovpn->dev);
> +	kfree_skb(skb);
> +	return 0;
> +}
> +

...

