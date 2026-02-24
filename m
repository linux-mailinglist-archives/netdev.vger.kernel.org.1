Return-Path: <netdev+bounces-260264-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHsUHxXsnGnqMAQAu9opvQ
	(envelope-from <netdev+bounces-260264-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 01:08:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3504180239
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 01:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAC10304C056
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 00:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF9F288D2;
	Tue, 24 Feb 2026 00:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+jGxPVu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58057288AD
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 00:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771891724; cv=none; b=ApsrPlpMXgyfnsgrz2abhDOQws1F2QBa6BIG3MXYiDPPvV/aGiiO8gjmLQ4sRNt4Ho20oKuRSLIWb+eecjnvb3NPKDYdTbnOCRQ0LKFjBvjhnXnyeI7PN9HAMChzVn7EXSwK4BRAJ2J083R1UDO6ogrZgBm79OKaHZyQq74UEb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771891724; c=relaxed/simple;
	bh=X+dD3Zd4BKRK6kL2365WEU6XRvxLSGbOCCn8RgFzyTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IrMLMz7NcZAo/VfD5U0rbsq+HFcuz7DhNfTzyiw4I2cNll8Gg5oGzfrvLU75Gax8hMrz6iw5sXaeA8X6dSTITq+VsyPdScjqArgIm4jERg0+DLJXp7dF16y8kQwbXzN1eyfqKyGVTH/ojOSrCmxGgYWWiOo+OXCF2qZD4B0nIjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+jGxPVu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB24C116C6;
	Tue, 24 Feb 2026 00:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771891723;
	bh=X+dD3Zd4BKRK6kL2365WEU6XRvxLSGbOCCn8RgFzyTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I+jGxPVuXrKWFUOi+JgcirOBI6W0Amal5bGhV+5qq0sDCQbgyXPLDZB4clcWXfclG
	 eKaIeULDasyBVSAjwQ7CmHMImCPMWybYlnMFL13Jt7jRqAkQZgZkJY6EcdrHRbMnxJ
	 0wlZcl5/wlV1qIer6xdULZkTWVqrRXuOzFngn7FLK4g9qIyuKGz5mjvvY1YaJImU6B
	 XRTRc3X3zvnC5XF+6HoZMwraiN5R6HrCYhsN2P4MlxMAqIUVg3VpqA4N1qGHk2i6Ar
	 e2xBy0mHynEsWizj0TE/JnTK+nJUy+21v8/JLdT4rJ7bfEhK8DpfyNKbhkiE0yP1Dp
	 QwPF1n3KAA7Sw==
From: Jakub Kicinski <kuba@kernel.org>
To: pvalerio@redhat.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	claudiu.beznea@tuxon.dev,
	nicolas.ferre@microchip.com,
	edumazet@google.com,
	pabeni@redhat.com,
	theo.lebrun@bootlin.com,
	netdev@vger.kernel.org,
	lorenzo@kernel.org,
	andrew+netdev@lunn.ch
Subject: Re: [net-next,v2,1/8] net: macb: move Rx buffers alloc from link up to open
Date: Mon, 23 Feb 2026 16:08:32 -0800
Message-ID: <20260224000841.140390-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223182632.1681809-2-pvalerio@redhat.com>
References: <20260223182632.1681809-2-pvalerio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260264-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: D3504180239
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: macb: move Rx buffers alloc from link up to open

This commit moves Rx buffer allocation to macb_open() to enable early
error propagation, adding a fail_early parameter to control whether ring
initialization fails fast or continues on error.

> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
> index 87414a2ddf6e..2cb65ec37d44 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -1180,7 +1180,7 @@ struct macb_queue;
>  struct macb_or_gem_ops {
>  	int	(*mog_alloc_rx_buffers)(struct macb *bp);
>  	void	(*mog_free_rx_buffers)(struct macb *bp);
> -	void	(*mog_init_rings)(struct macb *bp);
> +	int	(*mog_init_rings)(struct macb *bp, bool fail_early);
>  	int	(*mog_rx)(struct macb_queue *queue, struct napi_struct *napi,
>  			  int budget);
>  };

[ ... ]

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 43cd013bb70e..8cc16f2b4024 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c

[ ... ]

> @@ -2544,8 +2547,6 @@ static int macb_alloc_consistent(struct macb *bp)
>  		if (!queue->tx_skb)
>  			goto out_err;
>  	}
> -	if (bp->macbgem_ops.mog_alloc_rx_buffers(bp))
> -		goto out_err;
>
>  	/* Required for tie off descriptor for PM cases */
>  	if (!(bp->caps & MACB_CAPS_QUEUE_DISABLE)) {
> @@ -2557,6 +2558,11 @@ static int macb_alloc_consistent(struct macb *bp)
>  			goto out_err;
>  	}
>
> +	if (bp->macbgem_ops.mog_alloc_rx_buffers(bp))
> +		goto out_err;
> +	if (bp->macbgem_ops.mog_init_rings(bp, true))
> +		goto out_err;
> +
>  	return 0;
>
>  out_err:

[ ... ]

> @@ -2951,7 +2971,7 @@ static int macb_open(struct net_device *dev)
>  		goto pm_exit;
>  	}
>
> -	bp->macbgem_ops.mog_init_rings(bp);
> +	bp->macbgem_ops.mog_init_rings(bp, true);
>  	macb_init_buffers(bp);
>
>  	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {

Is mog_init_rings() being called twice in the macb_open() path? Looking at
the code flow:

macb_open()
  macb_alloc_consistent() at line 2967
    mog_init_rings(bp, true) at line 2563
  mog_init_rings(bp, true) at line 2974

The first call inside macb_alloc_consistent() initializes the rings and
checks the return value. The second call in macb_open() appears to be
redundant: by the time macb_open() reaches line 2974, gem_init_rings() has
already refilled all Rx slots via the earlier call.

When gem_init_rings() runs the second time, CIRC_SPACE returns 0 because
all slots are filled, so gem_rx_refill() effectively does nothing. The
second call reinitializes head/tail pointers that are already set and runs
a no-op refill.

Should this second call be removed to avoid the redundancy?

Additionally, the return value from the second mog_init_rings(bp, true)
call is silently discarded. The stated purpose of this patch is to "fail
early and loudly rather than init the device with Rx mostly broken," but
this call site doesn't check for errors while the call in
macb_alloc_consistent() does.

If the second call is intentional, should its return value be checked?

This was noted in the v2 review by Théo Lebrun (Jan 8, 2026) who pointed
out that commit 99537d5c476c relocated mog_init_rings() from
macb_mac_link_up() to macb_open(), making this second call redundant. Paolo
acknowledged this with "will do" but the duplicate call remains.
-- 
pw-bot: cr

