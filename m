Return-Path: <netdev+bounces-269846-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEz2EXEHvWkO5gIAu9opvQ
	(envelope-from <netdev+bounces-269846-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 09:38:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4059E2D7499
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 09:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 383AC3003494
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 08:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FAC3612F9;
	Fri, 20 Mar 2026 08:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onR4zv/j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F56C35DA7F;
	Fri, 20 Mar 2026 08:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773995884; cv=none; b=S6nZjicf21+wROFZcttsMTsTWe9/+PJW00wC7v3kclog7D8wAwUL9OHAdUXzE193aL1diScONIWaVQAYUaIGemf9RHRNPMSitjgKqQfTiZpbnnLcEmqPn/PP2I/XUw+DdSBDX2VJ2QNBA3SmOfoHmIeb2RRuVOhbEXO5+xSZTw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773995884; c=relaxed/simple;
	bh=2ma3ORZNACZft+/pI7EGr8Q5I+T4PcVGkvNkEW4hRXg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KP2m44gZvBa9pXwEy4nERU+QQpFqhq7DwFWqRwfhHXJbxhUWkQByG7xDzKFOL4Ux7fuM2jow7zF3nkb8SA+47Yc7n3/V6Rkugg3QRcXKOKXnTybpRZUdXI23awvcwFZMD4r2dvkZ7ok64fyZ2qbEznV1Bs/HSrkDV5W2JnEp9EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onR4zv/j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FFC2C4CEF7;
	Fri, 20 Mar 2026 08:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773995883;
	bh=2ma3ORZNACZft+/pI7EGr8Q5I+T4PcVGkvNkEW4hRXg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=onR4zv/jlEkOo72QUmh7HlHNwkkAfBJLaM6sgfT68ojLHLPIewZNNa0bVKZqpNXpP
	 9VSI9opeu57kTsIN0231DCTbM6uHB3eVBdz7ZB64O5v+Tac5ytD//ZZUGGuHnZjxv2
	 Hd87EGRwytNHo1S9p546n1Ode8vfbgWH8DV7L1VxzvcVziZlSR6yd0ky8+3DS7Q3d6
	 q66U4r/DZ+CnGrUMwhrE+izhxZlCmGM54lzbRZyZulhlrnoG740Rvl7ZengNiq4ifE
	 B10FjXRaitvEAzvNa0ha6hk96Y5YFNPAYesITercRG6s0U/toqot/CrAsw0VwPObnZ
	 iS8FcYuPUqgBQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 larysa.zaremba@intel.com, aleksander.lobakin@intel.com, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH v2 net 5/8] xsk: validate MTU against usable frame size
 on bind
In-Reply-To: <20260319175538.479139-6-maciej.fijalkowski@intel.com>
References: <20260319175538.479139-1-maciej.fijalkowski@intel.com>
 <20260319175538.479139-6-maciej.fijalkowski@intel.com>
Date: Fri, 20 Mar 2026 09:38:00 +0100
Message-ID: <87qzpeopzr.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.10 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.56)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-269846-lists,netdev=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.854];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,all.your.base.are.belong.to.us:mid,intel.com:email]
X-Rspamd-Queue-Id: 4059E2D7499
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> AF_XDP bind currently accepts zero-copy pool configurations without
> verifying that the device MTU fits into the usable frame space provided
> by the UMEM chunk.
>
> This becomes a problem since we started to respect tailroom which is
> subtracted from chunk_size (among with headroom). 2k chunk size might
> not provide enough space for standard 1500 MTU, so let us catch such
> settings at bind time.
>
> This prevents creating an already-invalid setup and complements the
> MTU change restriction for devices with an attached XSK pool.
>
> Currently xp_assign_dev_shared() is missing XDP_USE_SG being propagated
> to flags so set it in order to preserve mtu check that is supposed to be
> done only when no multi-buffer setup is in picture.
>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Fixes tag?

This got me thinking; Nothing in the xsk core prevents MTU from being
changes while xsk is runing? Some drivers do! Not for this patch, but
maybe xsk should listen to MTU notifiers?

Seems like we're in a bind-time TOCTOU gap...

> ---
>  net/xdp/xsk_buff_pool.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index 37b7a68b89b3..e9377b05118b 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -157,6 +157,7 @@ static void xp_disable_drv_zc(struct xsk_buff_pool *pool)
>  int xp_assign_dev(struct xsk_buff_pool *pool,
>  		  struct net_device *netdev, u16 queue_id, u16 flags)
>  {
> +	bool mbuf = flags & XDP_USE_SG;
>  	bool force_zc, force_copy;
>  	struct netdev_bpf bpf;
>  	int err = 0;
> @@ -178,7 +179,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
>  	if (err)
>  		return err;
>  
> -	if (flags & XDP_USE_SG)
> +	if (mbuf)
>  		pool->umem->flags |= XDP_UMEM_SG_FLAG;
>  
>  	if (flags & XDP_USE_NEED_WAKEUP)
> @@ -200,10 +201,18 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
>  		goto err_unreg_pool;
>  	}
>  
> -	if (netdev->xdp_zc_max_segs == 1 && (flags & XDP_USE_SG)) {
> +	if (netdev->xdp_zc_max_segs == 1 && mbuf) {
>  		err = -EOPNOTSUPP;
>  		goto err_unreg_pool;
>  	}
> +#define ETH_PAD_LEN (ETH_HLEN + 2 * VLAN_HLEN  + ETH_FCS_LEN)

Yuk! Move this somewhere else.

> +	if (!mbuf) {
> +		if (READ_ONCE(netdev->mtu) +  ETH_PAD_LEN >

I think READ_ONCE sends wrong signal to readers. We're in an
ASSERT_RTNL() region.

> +		    xsk_pool_get_rx_frame_size(pool)) {
> +			err = -EINVAL;
> +			goto err_unreg_pool;
> +		}
> +	}
>  
>  	if (dev_get_min_mp_channel_count(netdev)) {
>  		err = -EBUSY;
> @@ -247,6 +256,9 @@ int xp_assign_dev_shared(struct xsk_buff_pool *pool, struct xdp_sock *umem_xs,
>  	struct xdp_umem *umem = umem_xs->umem;
>  
>  	flags = umem->zc ? XDP_ZEROCOPY : XDP_COPY;
> +	if (umem->flags & XDP_UMEM_SG_FLAG)
> +		flags |= XDP_USE_SG;
> +
>  	if (umem_xs->pool->uses_need_wakeup)
>  		flags |= XDP_USE_NEED_WAKEUP;
>  
> -- 
> 2.43.0

