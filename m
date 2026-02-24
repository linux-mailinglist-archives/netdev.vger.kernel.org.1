Return-Path: <netdev+bounces-260267-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEAmAVHsnGnqMAQAu9opvQ
	(envelope-from <netdev+bounces-260267-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 01:09:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5978A180250
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 01:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A316D30E66F8
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 00:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F00C12D21B;
	Tue, 24 Feb 2026 00:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zt8jmBof"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8BA12B143
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 00:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771891742; cv=none; b=qt79jaARJ7MsChPAIbzgO8vdVOBgQWlJ92Eovro8m4l/vYArYKVvzchHNyrnsuYUdHTzzpXss5fdex8eOXYlKgIX91s671cPzdh80QqQdDMy4PlCs+Io5LTlXyqgVyrgy6w7qcND26Z3nV9aJYQaUtdvglHnwRV6zVPDjihxnbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771891742; c=relaxed/simple;
	bh=d1hy2R8TYaDXubxDIB63hxSxy8VR5vA7+wW/yVTdlz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S7aRDS9ny2v2T00blQkLHxA3oZYuCNZz31qUgr52a2BMuTbbk6+hVpzdVAc7A1gXqujC8l57PxupMsi5duBEAgQfQeQM4hoFB/4V6xdzPcuN0k25P1JykHVopbAVuw2ryDYhSQp0uB9k+2SF60Svr6DEZ9YR9E9JGJNkpT14i4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zt8jmBof; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D83AC116C6;
	Tue, 24 Feb 2026 00:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771891741;
	bh=d1hy2R8TYaDXubxDIB63hxSxy8VR5vA7+wW/yVTdlz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zt8jmBofCv9vzqBsRZLWcHK6zsM9XaiO45IJl/fOQ10VgBvkkmq8IJFQkOyXtIESX
	 M71vUfXrlJVKNwa8o/zog5ha4mJgOUCsLUcejNa5Ved31b7/u4L2h1PGQqdR2+EHON
	 1O9DgVd0NzxXG4nJna0YCtxBVkCNceCHYMEAf4T2ixBnGPkuUoVT8m7bLD9fMUHJBi
	 j6ZlThHVXxrlcs0TRAWfqAgJmR7HHZlmI5pBGZrjR0WyAQZz1RAr/2A7tuq1pcNNkh
	 3eRxY4YgTQIjo2j22L9gRqAMXK+HrU4jk56lVc4Tj8EON0yJWdfHsxoLLsgSYiUv2g
	 5afE1A16+ecpQ==
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
Subject: Re: [net-next,v2,7/8] net: macb: make tx path skb agnostic
Date: Mon, 23 Feb 2026 16:09:00 -0800
Message-ID: <20260224000900.140571-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223182632.1681809-8-pvalerio@redhat.com>
References: <20260223182632.1681809-8-pvalerio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260267-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 5978A180250
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: macb: make tx path skb agnostic

This commit renames the skb member of macb_tx_buff to ptr and introduces
macb_tx_buff_type to identify the buffer type. This is preparatory work
for XDP transmit support.

> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
> index 4e3cc0e9ea87..67fef88af2c6 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h

[ ... ]

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index f65f976123fd..50646ee90672 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c

[ ... ]

> @@ -1204,7 +1205,9 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
>  		/* Process all buffers of the current transmitted frame */
>  		for (;; tail++) {
>  			tx_buff = macb_tx_buff(queue, tail);
> -			skb = tx_buff->skb;
> +
> +			if (tx_buff->type == MACB_TYPE_SKB)
> +				skb = tx_buff->ptr;
>
>  			/* First, update TX stats if needed */
>  			if (skb) {

In macb_tx_complete(), the local variable skb is declared without
initialization at the start of the outer for loop. The patch changes the
unconditional assignment to a conditional one based on tx_buff->type.

When tx_buff->type is not MACB_TYPE_SKB, skb remains uninitialized with
whatever garbage value was on the stack. The subsequent "if (skb)" check
will likely evaluate as true on this garbage pointer, causing dereferences
of skb->len, skb->data, and skb_shinfo(skb) on invalid memory.

This could lead to a crash or memory corruption. Should skb be initialized
to NULL at declaration?

Note: While all buffers are MACB_TYPE_SKB in this commit, the commit message
states this is the "last preparatory step for xdp xmit support," suggesting
the next commit will introduce non-SKB buffer types that would trigger this
issue.

