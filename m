Return-Path: <netdev+bounces-157975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0033A0FF93
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 04:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5F3C3A59F2
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 03:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA2B230279;
	Tue, 14 Jan 2025 03:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdxFD+L2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7507E24024E;
	Tue, 14 Jan 2025 03:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736825813; cv=none; b=tCk+6oCSo7Lxw1RQto+QkceW80p6zKkaUDI3L4VcPMtllSG32+sl2pxZOC9sX+b//17la0Ig3WYjdbKOtuyuh1DYE0vjF2ukq9WZeQnPZHS8zWPoK2XKi4IlmfeFeM6i7wt6GVu+f2j/gQRGltb4qL9l1+A+IomlNhkTVjw7Jpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736825813; c=relaxed/simple;
	bh=4qdP3cgBGyskS82WWQ8M3enm+es99peUyXTL1zCJlPM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PWJRuA0IeY+1DAxUe2X4upuogjQWuchB9+fHCAVOP8qKg8xDmT+EYd8nx54tJO2CkJNvm7eeEJFiFggKBiOG2zwbqYa3rqOp/d9vyXt3zIEpnLE93gjMfe00zcSY4EVru4rLel4uMNj85G2qWDO/mY/0eg2dHoWL5Y0WnldbkHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdxFD+L2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78ACC4CEE1;
	Tue, 14 Jan 2025 03:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736825812;
	bh=4qdP3cgBGyskS82WWQ8M3enm+es99peUyXTL1zCJlPM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RdxFD+L2TwL7/YscB1yS+FmHFnt6gkVkjT9h8WXlKsvBTAYepaj+o6kl8jEvg16rF
	 SKg6xiMqk+0/yes9LhiHlfP3yKZRFsRv2KHBeY20nfnC2etqORJ74NJkmz014kSI0E
	 hCxXa5gtD1x3JkE1Yqh4ctJtU0nJ95/P268SvF9I/Zh1RcaSujwJXvTsuOjTrVsuFw
	 v9hR5mGwnFixDDfATT91HrOsrSR7DH02aYH+hpFsBcrayT2NjMRmTt1+A+aBZMNlKG
	 Iuy8L+3ENGxNVuGxa8i3MZQWf1X250/1OV90aMZBQwPS4iTqV+lfIALy7fVrukVKax
	 TaAueWhPJSW1A==
Date: Mon, 13 Jan 2025 19:36:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
 <thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
 <konguyen@redhat.com>, <horms@kernel.org>, <einstein.xue@synaxg.com>,
 Veerasenareddy Burru <vburru@marvell.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>
Subject: Re: [PATCH net v6 1/4] octeon_ep: update tx/rx stats locally for
 persistence
Message-ID: <20250113193650.1b3d6f55@kernel.org>
In-Reply-To: <20250110122730.2551863-2-srasheed@marvell.com>
References: <20250110122730.2551863-1-srasheed@marvell.com>
	<20250110122730.2551863-2-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Jan 2025 04:27:27 -0800 Shinas Rasheed wrote:
> @@ -991,33 +991,30 @@ static netdev_tx_t octep_start_xmit(struct sk_buff *skb,
>  static void octep_get_stats64(struct net_device *netdev,
>  			      struct rtnl_link_stats64 *stats)
>  {
> -	u64 tx_packets, tx_bytes, rx_packets, rx_bytes;
>  	struct octep_device *oct = netdev_priv(netdev);
>  	int q;
>  
> +	oct->iface_tx_stats.pkts = 0;
> +	oct->iface_tx_stats.octs = 0;
> +	oct->iface_rx_stats.pkts = 0;
> +	oct->iface_rx_stats.octets = 0;
> +	for (q = 0; q < oct->num_ioq_stats; q++) {
> +		oct->iface_tx_stats.pkts += oct->stats_iq[q].instr_completed;
> +		oct->iface_tx_stats.octs += oct->stats_iq[q].bytes_sent;
> +		oct->iface_rx_stats.pkts += oct->stats_oq[q].packets;
> +		oct->iface_rx_stats.octets += oct->stats_oq[q].bytes;
> +	}

The new approach is much better, but you can't use oct->iface_* as
intermediate storage. There is no exclusive locking on this function,
multiple processes can be executing this function in parallel.
Overwriting each others updates to oct->iface_tx_stats etc.
-- 
pw-bot: cr

