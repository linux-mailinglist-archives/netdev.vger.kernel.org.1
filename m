Return-Path: <netdev+bounces-281966-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBilMNjc8GlOagEAu9opvQ
	(envelope-from <netdev+bounces-281966-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 18:14:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AB4488A00
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 18:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB1BE30ABC0F
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540D23FA5C2;
	Tue, 28 Apr 2026 16:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJFrWn3x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4C53F7882
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 16:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777392326; cv=none; b=Q+rCaDXJMD/wOgjxdljkDtAzBlIv80kqsoAPE1Xpfj2PVo640qmNG+rJn1mUhF40I5T//BkPpbUUFbnmDF+JtwKaPoI+Jr5fFvh953I0Je6Ea2Kyp1fMiHpALJnQMresj0qKaxqzEUQHy5ioOujkpKASjU+sip4rG3AX8IMQqEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777392326; c=relaxed/simple;
	bh=sRgHeoju0yR/lZkhLcbuhp5TVpmpek5d9QIQzW2bxF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qVez5PU8jRmmns79P82PgGVQ8PuNyx8ZQeFF5ZJbq+kydQ0nNukUScxIDZfoi90Ux3kPrauR/ggdvHgXBAF6+jgZ+w/+Fklw3FsOY3z959AiaFhShsQBRkea44vRM1ZVOXZKwcneTwNIbv2POjlM5QnCSkSAVU5W4Cij7BjKipU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJFrWn3x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA74C2BCAF;
	Tue, 28 Apr 2026 16:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777392325;
	bh=sRgHeoju0yR/lZkhLcbuhp5TVpmpek5d9QIQzW2bxF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iJFrWn3xplR6LyZniF4BtsNKk93ivgBxZNziby48q3BxeJe3+OFAtT2lMRZwJwi8x
	 sv3742orTZEdZKcMIRBEFH4KlTZq+BDLxyz/OE3Hil9Hhjg3+EUXoRG84DIjGxEnZq
	 c+12lZLEQFvo107/dr+g14HAJ6wsF403An2NzMUtgi8DuwlRwSkpcQMIGJ0DqeckQ+
	 tD7ndRSvHqZ7I7iF7vVaVGzqMmJkq94/TkwUWSA/NvkVmcQHv9kkqf5Yu6FW6NQ06c
	 2zJ11cdq9ovtx30xs+64Lj7qJ1AXOW8kNK+7Q1OGYzaj9q95GwUWiZdITkvjEWduXW
	 9Nlc+gkFqtFtg==
From: Simon Horman <horms@kernel.org>
To: bestswngs@gmail.com
Cc: 'Simon Horman' <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemb@google.com,
	martin.varghese@nokia.com,
	netdev@vger.kernel.org,
	xmei5@asu.edu
Subject: Re: [PATCH net] bareudp: fix NULL pointer dereference in bareudp_fill_metadata_dst()
Date: Tue, 28 Apr 2026 17:04:46 +0100
Message-ID: <20260428160445.1336649-2-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260426165350.1663137-2-bestswngs@gmail.com>
References: <20260426165350.1663137-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 37AB4488A00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281966-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
bareudp: fix NULL pointer dereference in bareudp_fill_metadata_dst()

This commit fixes a NULL pointer dereference in bareudp_fill_metadata_dst()
by adding a check for the socket in the IPv6 path. If the device is down
and the socket is NULL, it now returns -ESHUTDOWN.

> Add a NULL check returning -ESHUTDOWN, consistent with the xmit paths
> in the same driver.

Does the IPv4 path also need to be updated to remain consistent?

While the IPv4 path lookup doesn't use the socket pointer directly, if the
socket is NULL (meaning the device is down), shouldn't the IPv4 path also
return -ESHUTDOWN instead of successfully performing a route lookup?

> diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
> index 0df3208783ad..da5866ba0699 100644
> --- a/drivers/net/bareudp.c
> +++ b/drivers/net/bareudp.c
> @@ -529,6 +529,9 @@ static int bareudp_fill_metadata_dst(struct net_device *dev,

Is it possible for an IPv6 tunnel key to be incorrectly processed as IPv4
earlier in this function?

Looking at the preceding condition in this function:

    if (!ipv6_mod_enabled() || ip_tunnel_info_af(info) == AF_INET) {
        struct rtable *rt;
        ...
        info->key.u.ipv4.src = saddr;
    }

If the IPv6 module is disabled at runtime, but an IPv6 tunnel key is provided
(e.g., via OVS or TC), the code falls back to the IPv4 branch.

Since key->u.ipv4.dst aliases exactly with bytes 4-7 of key->u.ipv6.src due
to the union layout in struct ip_tunnel_key, could this result in an invalid
IPv4 route lookup using portions of the IPv6 source address?

Would it be safer to explicitly reject IPv6 tunnel keys when the IPv6 module
is disabled?

>  		struct in6_addr saddr;
>  		struct socket *sock = rcu_dereference(bareudp->sock);
>  
> +		if (!sock)
> +			return -ESHUTDOWN;
> +
>  		dst = udp_tunnel6_dst_lookup(skb, dev, bareudp->net, sock,
>  					     0, &saddr, &info->key,
>  					     sport, bareudp->port, info->key.tos,

