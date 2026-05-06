Return-Path: <netdev+bounces-284635-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id HIUVGrmS+mmZPwMAu9opvQ
	(envelope-from <netdev+bounces-284635-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 03:00:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C444D520B
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 03:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46F1E301F997
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 01:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC761F4CB3;
	Wed,  6 May 2026 01:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMViL6P2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8822E1A683F;
	Wed,  6 May 2026 01:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778029237; cv=none; b=JQbZKHpiXcXJpaMyUgiCGvFvDJz1v9oO42h/cdhFz6ZhbhII/JG9WRi5/LdQHZ5LSS80kKKSqB9PDcQTxEEHbM5HCo5ciUiXVLUPBZ+UANWVu2abNKRGM5khZG9LNyfw0YZiPR+FFAhEJD870ykuzxIXW7GLrA+0ZVaBrZ4s8Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778029237; c=relaxed/simple;
	bh=5HENGzZkN4GkNqTCb3WRp2m8uqHpquztXJ3hV0fm0aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IMCNoCDE9hItISBrsIi/t7rp4XiR30KTd1xyXU0RI/5n05FCIXfjiQs7wc2ibuQu/KtCenemlrc37A4/2WhiFWQfkaO/BFXQ3Tzd5petPWXwmIFI48j4+32UBXWwHc5gRHdJvrzpYyVomQPW3FpenzNFDe8m5R55uxYKyjz747k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMViL6P2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC74C2BCB4;
	Wed,  6 May 2026 01:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778029237;
	bh=5HENGzZkN4GkNqTCb3WRp2m8uqHpquztXJ3hV0fm0aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JMViL6P24NIVjuyYPDBUcN71ndJz2VRzZgp+FMAHpWJxQmhJ61iHLv1FhVW2utEoU
	 +dQ+9gODkVE9IbzACxVckg3PkzNiVSARxJB90xkU+nZ1frQCAbY5xf+tvFs0Luy6Wt
	 c2PPHS7O5b+Yhz6RVQkiVS9ApLKaqAFuUnqpzDLQ0qCq5eu3FxUkKFk/iAtkuYoGL4
	 gVt/gG9Axd1X5lynpguWCqBgR0dB9ATzyYKQwBm1a5B4BvXdE4sifDPwl/k1ze8Dm7
	 36qlsXmrCi3UmKf+DpwLNisFWq2uI7FiseGQE71uNNwbTk25ZIlz/LF3qTEVvpZ8jJ
	 c9FsmSfreWJZg==
From: Jakub Kicinski <kuba@kernel.org>
To: antonio@openvpn.net
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	edumazet@google.com,
	sd@queasysnail.net,
	davem@davemloft.net,
	pabeni@redhat.com,
	ralf@mandelbit.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 2/3] ovpn: ensure packet delivery happens with BH disabled
Date: Tue,  5 May 2026 18:00:35 -0700
Message-ID: <20260506010035.1563280-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504230305.2681646-3-antonio@openvpn.net>
References: <20260504230305.2681646-3-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A8C444D520B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-284635-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
ovpn: ensure packet delivery happens with BH disabled

This commit wraps gro_cells_receive() and dev_dstats_rx_add() with
local_bh_disable() and local_bh_enable() in ovpn_netdev_write(). This
prevents deadlocks and per-cpu state corruption when packet delivery occurs
in process context for TCP connections.

> diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
> --- a/drivers/net/ovpn/io.c
> +++ b/drivers/net/ovpn/io.c
> @@ -91,12 +91,18 @@ static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
>  
>  	/* cause packet to be "received" by the interface */
>  	pkt_len = skb->len;
> +	/* we may get here in process context in case of TCP connections,
> +	 * therefore we have to disable BHs to ensure gro_cells_receive()
> +	 * and dev_dstats_rx_add() do not get corrupted or enter deadlock
> +	 */
> +	local_bh_disable();
>  	ret = gro_cells_receive(&peer->ovpn->gro_cells, skb);
>  	if (likely(ret == NET_RX_SUCCESS)) {
>  		/* update RX stats with the size of decrypted packet */
>  		ovpn_peer_stats_increment_rx(&peer->vpn_stats, pkt_len);
>  		dev_dstats_rx_add(peer->ovpn->dev, pkt_len);
>  	}
> +	local_bh_enable();
>  }

This protects the success path, but do the error and drop paths also need
BH protection?

If ovpn_decrypt_post() is called in process context for TCP connections, an
error condition jumps to the drop label:

ovpn_decrypt_post() {
        ...
        if (unlikely(ret < 0))
                goto drop;
        ...
drop:
        if (unlikely(skb))
                dev_dstats_rx_dropped(peer->ovpn->dev);
        ...
}

Since dev_dstats_rx_dropped() updates the same per-CPU dstats structure
without disabling bottom halves, could it still be vulnerable to softirq
preemption and stat corruption?

Additionally, do the TX paths in the TCP implementation have similar issues?
It looks like ovpn_tcp_send_skb() and ovpn_tcp_send_sock_skb() might call
dev_dstats_tx_dropped() without disabling bottom halves.

Similarly, ovpn_tcp_send_sock() uses preempt_disable() around
dev_dstats_tx_add(), which does not prevent softirqs from running upon
return from a hardware interrupt on the same CPU. Does this leave a similar
race window open?
-- 
pw-bot: cr

