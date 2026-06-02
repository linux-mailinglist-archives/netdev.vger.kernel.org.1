Return-Path: <netdev+bounces-293974-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YA1uGiZCHmraiAkAu9opvQ
	(envelope-from <netdev+bounces-293974-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:38:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE89062755A
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51905300D461
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 02:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC246360EEA;
	Tue,  2 Jun 2026 02:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2jDhL/w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F9435DA5B
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 02:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780367646; cv=none; b=s4hy9p3SEwfyLJ2HI1NBQ9TPcMo0dpFlJYglMHy6R61mw0CK0u6vZidRLt0Rxf9/8NJ2OVNHGqfVeiA9ucZY3aG7J+Xh/Mo8pkb20xutOBwnWLi8hdGl7Q8lIpyjPc0nXzZD5Jvbom5ODR6h/8XFz3kQuZwwPijW07w24Rzpe3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780367646; c=relaxed/simple;
	bh=myDyHWhokietFp5wHPvTtx8LenWMH4unrt+YuoJ9tgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HAF3A2csB1URZ5Dj/KHhzmXBMEsoAtMSE0gJ8v3tnhdD3g5BHW164zdUzSZZ6CehMR0N5/oDjlXfURM9PFUW6/ZDAkgOBm7O3qchO4pv50kNVWMrz3MPFlwwm7gjOY7LQgYQbEo+yGbWO4CtllcY9H+3fT25vkQMANPxKl6lkpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2jDhL/w; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8FA1F00893;
	Tue,  2 Jun 2026 02:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780367645;
	bh=W2YMM5LLD+YtSgsmJnX6bmHUQjeYvJISkGJE26jLOsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n2jDhL/wO/yrYEuU3lG0cO7iQR/OfeDiggNj2it9uoiTnKtjohh/fDWCHp+SzYSLP
	 yPl+2GFq7qskxK2xtqUTBWTVB/xTEpUH5/j0k8QKYyAcV+8S0UiMZDQWZZlpPArLCf
	 EIK6xWaTWgkYrBHG3QNLVxzGBtzc/fNUzfBl3FlsjBATk4z8EbRtoSJVRTtO75J7/K
	 DPNFa7PcswZM1rkIs6M47NHf2Ss3OgAg8B2+RjSunq7Iqm0YC07Peti48R9kTwxCNZ
	 ncfpMnedINuKGrVbvB9fr/lIcUUMFraikQgDnrjPC/OJEn+CT/08qQH10l89ZqdBGB
	 t+6BqMTRQ+FrQ==
From: Jakub Kicinski <kuba@kernel.org>
To: kuniyu@google.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	dsahern@kernel.org,
	stephen@networkplumber.org,
	kuni1840@gmail.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH v4 net-next 5/5] geneve: Introduce IFLA_GENEVE_LOCAL and IFLA_GENEVE_LOCAL6.
Date: Mon,  1 Jun 2026 19:34:02 -0700
Message-ID: <20260602023402.1647750-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528005658.1756248-6-kuniyu@google.com>
References: <20260528005658.1756248-6-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,networkplumber.org,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-293974-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: DE89062755A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
geneve: Introduce IFLA_GENEVE_LOCAL and IFLA_GENEVE_LOCAL6.

This patch adds IFLA_GENEVE_LOCAL and IFLA_GENEVE_LOCAL6 attributes so a
GENEVE device's underlying UDP socket can be bound to a specific local
IPv4 or IPv6 address rather than the wildcard, and updates lookup paths
and xmit paths accordingly.

> diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
> index 3a62d132a8c4..c5372b33a305 100644
> --- a/drivers/net/geneve.c
> +++ b/drivers/net/geneve.c

[ ... ]

> @@ -1972,6 +2043,55 @@ static int geneve_nl2info(struct nlattr *tb[], struct nlattr *data[],
>  #endif
>  	}
>  
> +	if (data[IFLA_GENEVE_LOCAL]) {
> +		if (changelink) {
> +			attrtype = IFLA_GENEVE_LOCAL;
> +			goto change_notsup;
> +		}
> +
> +		info->key.u.ipv4.src = nla_get_in_addr(data[IFLA_GENEVE_LOCAL]);
> +
> +		if (ipv4_is_multicast(info->key.u.ipv4.src)) {
> +			NL_SET_ERR_MSG_ATTR(extack, data[IFLA_GENEVE_LOCAL],
> +					    "Local IPv4 address cannot be Multicast");
> +			return -EINVAL;
> +		}
> +
> +		cfg->dualstack = false;
> +	}
> +
> +	if (data[IFLA_GENEVE_LOCAL6]) {
> +#if IS_ENABLED(CONFIG_IPV6)
> +		int addr_type;
> +
> +		if (changelink) {
> +			attrtype = IFLA_GENEVE_LOCAL6;
> +			goto change_notsup;
> +		}

[Medium]
Should the changelink rejection here mirror the IFLA_GENEVE_REMOTE
behavior in this same function? IFLA_GENEVE_REMOTE only fails the
changelink when the family changes:

	if (data[IFLA_GENEVE_REMOTE]) {
		if (changelink && (ip_tunnel_info_af(info) == AF_INET6)) {
			attrtype = IFLA_GENEVE_REMOTE;
			goto change_notsup;
		}

whereas IFLA_GENEVE_LOCAL and IFLA_GENEVE_LOCAL6 fail unconditionally
whenever the attribute is present, even when the value matches the
existing configuration.

Combined with the geneve_fill_info() change below, would this break the
common dump-then-changelink round trip used by some management tools on
pre-existing devices, returning -EOPNOTSUPP even though LOCAL was never
explicitly configured?

[ ... ]

> @@ -2320,6 +2441,20 @@ static int geneve_fill_info(struct sk_buff *skb, const struct net_device *dev)
>  #endif
>  	}
>  
> +	if (!geneve->cfg.dualstack) {
> +		if (ip_tunnel_info_af(info) == AF_INET) {
> +			if (nla_put_in_addr(skb, IFLA_GENEVE_LOCAL,
> +					    info->key.u.ipv4.src))
> +				goto nla_put_failure;
> +#if IS_ENABLED(CONFIG_IPV6)
> +		} else {
> +			if (nla_put_in6_addr(skb, IFLA_GENEVE_LOCAL6,
> +					     &info->key.u.ipv6.src))
> +				goto nla_put_failure;
> +#endif
> +		}
> +	}
> +

[Medium]
Does this emit IFLA_GENEVE_LOCAL or IFLA_GENEVE_LOCAL6 on every
non-collect_md device, including legacy devices created without any
local address?

cfg->dualstack is only set true for collect_md devices, so for any
device where the user never specified a local address, info->key.u.ipv4.src
is 0 (or info->key.u.ipv6.src is ::) but the attribute is still emitted.
This would change the visible output of ip -d link show and netlink
dumps for existing GENEVE devices, adding a synthetic local 0.0.0.0 or
local :: that was not present before.

Would gating this on a non-zero source address (or tracking whether the
user explicitly set LOCAL) avoid the dump-output change for unaffected
devices?

The commit message describes the new behavior on devices that set
LOCAL/LOCAL6 but does not mention that fill_info now emits these
attributes for every previously-created non-collect_md device, nor that
changelink will reject any presence of LOCAL/LOCAL6 even when the value
is unchanged. Could the commit message call out these compatibility
implications?

