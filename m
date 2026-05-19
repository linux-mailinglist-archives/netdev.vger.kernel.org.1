Return-Path: <netdev+bounces-289483-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Av/K553DGqihwUAu9opvQ
	(envelope-from <netdev+bounces-289483-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 16:45:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EA4580C64
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 16:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 088B73004618
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94740327C00;
	Tue, 19 May 2026 14:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="q8taEtfj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DjXhvUzq"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CD33264EB;
	Tue, 19 May 2026 14:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779201132; cv=none; b=YU2PiKCs5YGiHRQa9knC9UIobvyp6CF8HO1q3eGaK7TTl9DRT9dEmhPAJsvKZuHY+ck7HBtya9Oh5zihaIaxz+Os3E1JXhbuHfHqtSliEYidtErp+K456j7/Jm06ItVnSKQqk3thnp08wq3KR32mWSKq//m1ntNIKaxIfdeU260=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779201132; c=relaxed/simple;
	bh=EDZm87HB9wFy0ZnPR+iKkIWaEkEWZHT6UwMzQ7t7+ZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4/M0Mi+CmoKDs05SrB0WmJt3Yiz1y/GI0KGRj+UuiyYQlnHX+sDsJ1ip6vliWZcAlhXB7LTBm1MI4ni5vD6WyWblU3NmlYAbyLTV/cul2dc6xEWJBxFfoEDxAhsrwHg9+8QHxAExtTiGewPRYy6Iw+L5QBIFKDHz2mHt2oTAvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=q8taEtfj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DjXhvUzq; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 48BBFEC010D;
	Tue, 19 May 2026 10:32:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 19 May 2026 10:32:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1779201128; x=
	1779287528; bh=HL5bqItaGufBm3VrudXIILPHtr/6PDyA/V2SB1E5lFM=; b=q
	8taEtfjXD3PPm8Mrrys2M0wnX3A+S9Vvm/ykj8nOVFj0z7DjHKTMikCX9twG/ltX
	kZ25xElDyB7Fd8AOGfa8wGau4GhDy7JMEOY+SiIVQB3IC9kTWxl7RNXxUPV/wcxR
	2cdlCB+n/Fmw3bVNP4VX/UYJZhAwWERx/+VtFJfS8NdKI3lpq8zpMVAyLSubWVZw
	HDVuFT8XIIIuDIotphKjZErMme57tHjOqygzufYZNevr7MIcWvxC+B6tIsz97XJe
	f3w+aLr1ktfarlC9fYnUpZQgLP97mEUpCqFAzYE4rRtSbsnkf4EyRPvAdQMrF3dP
	d+QT7I5lrQEQGD+rG2U6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779201128; x=1779287528; bh=HL5bqItaGufBm3VrudXIILPHtr/6PDyA/V2
	SB1E5lFM=; b=DjXhvUzqUdyiFnDl+dJy8LTDzATOOmp2PZKmMiKbE+JMKTMG0dd
	+OBzLkS51HnYpkOr1o6q4yLwizqwg1jnSG8UGCS896/nCX8ELjw55ejKfwegJR7T
	592jsig3INRZeDkpDWnFfTjLR+23iAOMw6dt15ZgTLW8tvX2iKKrmk6OOShDnOzv
	12uK+7eYUv7ZS4jcN9WPVEMdOkZHkRORR/cXRNG0pxd+gLsdN8niXlkRh8671s9m
	zcbxy0iWSpwtjBELEvjTGuCjHCmIoSAIbnIrNEI9NWuXAdRJAnu8oSQVa/798/JI
	sdnH0toTHOh+EkCai94xDDzD0MjL98OSlsA==
X-ME-Sender: <xms:Z3QMamYt6kauArOBT_2Prek18w0F7QYwGInYaSajb2cwUEbdo9DSng>
    <xme:Z3QMauWtE_ITPUM68ihGwwcbqg7_qA5Z6p1mFLFyy3ckINrS_Pa9l3qyWTgSC5zjQ
    xfapIXjO_HdX2Q8s7JG9TsxU9NQGvA3b1mr9RPMuyL2vth0NxedUQ>
X-ME-Received: <xmr:Z3QMalP4OCe_WLO3298byb_K4dLn-Jy2aZFvZ8CghOi-nlwKuJ1XJMJsQEahu7x13DUCadCYusUmgc0RMatBFBI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedvtddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeelpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehmihgthhgrvghlrdgsohhmmhgrrhhithhose
    hgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnthhonhhiohesohhpvghnvhhpnhdrnhgv
    thdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpth
    htohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgr
    iigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohep
    nhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Z3QMaoYDgtqR5Hg4FvcVzNIXpYSSpHxOhxy0a5ODAkvuPaXQ6kT2bg>
    <xmx:Z3QMak_gFBWysSQW1uwtqv9VAfPawprXkzUjhWGVUkGnzQq2seNB0Q>
    <xmx:Z3QMapRiCn6HczLJXbIZi0kBA00wZy5g9GW1BlWw7OIw8bmRnGV_5Q>
    <xmx:Z3QMaucpE6t4yNdHWazhsDrIhqHnW4ss_DW0XmVErapOalBHAjOOaw>
    <xmx:aHQMai7dPb_VxcOSj3ziH_j-rySCfvzDpVCgLjsdU4TPxPH0wSMbfR8j>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 10:32:07 -0400 (EDT)
Date: Tue, 19 May 2026 16:32:05 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: ovpn: refuse TCP socket layering with an active
 ULP
Message-ID: <agx0ZRfgc7WhuJtI@krikkit>
References: <20260517155645.3882533-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260517155645.3882533-1-michael.bommarito@gmail.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289483-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[queasysnail.net:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,messagingengine.com:dkim]
X-Rspamd-Queue-Id: B3EA4580C64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-05-17, 11:56:45 -0400, Michael Bommarito wrote:
> ovpn's TCP transport replaces sk_prot, sk_data_ready, sk_write_space
> and sk_socket->ops by direct field writes when a peer is attached, and
> restores them by direct field writes when the peer is detached. That
> layering scheme is not compatible with a TCP ULP (e.g. kTLS) being
> installed on the same socket: ULP setup also captures the current
> sk_prot as its lower layer and replaces sk_prot with its own. The two
> schemes are not aware of each other and can be combined in either
> order on the same fd.

It looks like we should make ovpn-tcp a ULP (without requesting
userspace to do the setsockopt, since we messed that up a year ago. I
thought I had suggested that at some point, but maybe not). That's
what it is anyway, and layering ovpn on top of (or underneath) ktls or
espintcp makes no sense. It would save us the messy restore hacks in
this patch.

mptcp calls tcp_set_ulp() from the setup, maybe ovpn can also do
that. detach() may be an issue.


[...]
> @@ -583,6 +610,26 @@ static void ovpn_tcp_close(struct sock *sk, long timeout)
>  	sock = rcu_dereference_sk_user_data(sk);
>  	if (!sock || !sock->peer || !ovpn_peer_hold(sock->peer)) {
>  		rcu_read_unlock();
> +		/* No (or no-longer-attached) ovpn state on this socket.
> +		 * That happens when ovpn_tcp_socket_detach() already ran
> +		 * and cleared sk_user_data, but the caller chain still
> +		 * dispatches ->close() on ovpn_tcp_prot. The two cases
> +		 * that exhibit this are:
> +		 *   - a TCP ULP layered on top of ovpn whose close hook
> +		 *     chains via the captured ctx->sk_proto (which is
> +		 *     &ovpn_tcp_prot) after detach has run;
> +		 *   - the close-vs-detach race window where sk_user_data
> +		 *     has been cleared but sk_prot has not yet been
> +		 *     restored.
> +		 * In both cases the TCP layer still owes the peer a
> +		 * graceful close, so chain to the base TCP close.
> +		 */

This is a whole commit message, not a code comment.

> +#if IS_ENABLED(CONFIG_IPV6)
> +		if (sk->sk_family == AF_INET6)
> +			tcpv6_prot.close(sk, timeout);
> +		else
> +#endif
> +			tcp_prot.close(sk, timeout);

Isn't that a separate problem? (detach racing with close)
Or it only appears after the other changes because you removed
clearing the CBs?

-- 
Sabrina

