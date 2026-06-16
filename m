Return-Path: <netdev+bounces-299678-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eQd2CQCZMGqAUwUAu9opvQ
	(envelope-from <netdev+bounces-299678-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 02:29:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F3B68AF01
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 02:29:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nrosp5ex;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299678-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299678-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E98E305F582
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 00:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887FA1FE47B;
	Tue, 16 Jun 2026 00:28:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B88524E4C6;
	Tue, 16 Jun 2026 00:28:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781569733; cv=none; b=M9GWZOwoNQ7k69m044Z5iaaPLoP+tJ+hQC7IZFBrRV/allkXS/3TCWX+sZUREry9N3ZkUxo0O2nhfncTqsZJHFcN8j8UCQpfOZDQ2hFfpEE6YcXFZe+Yqyv//DNr2yZDIeywEJ9hukB5cyQklWRFw1/QVCkX1RjL1hJW2ft7aUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781569733; c=relaxed/simple;
	bh=KPtHxrDcyIwv2ORYz/+gnngulB6FkX6nsdmLmFmefMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AS2GTsXmH7AS6QGOvFOiZ8OK0kRoutvmzmz3kRJW7MMa0ttVf2O/eihwyexeuwnc6jPqkXQgD77tkJTuJBLrY9xNdGHIIPyRLe/eVOAkI+T6znREp9UiWviZ6AWem7eUzuHbbFCv/V1cxq6xz5k/aNVKeVM0ipBUtJ0Vv1ID8oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrosp5ex; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D96E1F000E9;
	Tue, 16 Jun 2026 00:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781569731;
	bh=fDHAdwUV01GxCSxY6I/kO2Xfc6AMmaOEU+dZIiXqh3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nrosp5exo+qTuhMLQ/taTNcJCTLGIvgIkl1Egtj9+aCvWc9U33Tyu5ctHSBcLuKvS
	 XiJ3oAurRrXL6BCz/JBGStA16SBXTzohJe7ANNtgwN90mD+gMk99k1+vgLy7hBR6iN
	 e3TLsWQ4wwTCsSJW9jxwe/5+ceNlIlXVr0Bo9f9kj1uOhUyhqGs8h9VdQheDJIJHIe
	 7Ana7OmluB4X7Q6CSg33JVFv0w9moOjVQ571IJH54cAtCDvJ0DaNp9pBqIGPhosZvM
	 LmJLtHmVWgFJwxqVtRqc3D7XbbJsOZGk5ce4l7Ywyl0KQHoA0H+6bWRWvBafTjeTuP
	 jQsAr1mFCRwIg==
From: Jakub Kicinski <kuba@kernel.org>
To: yun.zhou@windriver.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	qingfang.deng@linux.dev,
	jiri@resnulli.us,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] flow_dissector: fix uninit-value in __skb_flow_dissect() for ETH_ADDRS
Date: Mon, 15 Jun 2026 17:28:50 -0700
Message-ID: <20260616002850.1096747-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260613113154.2550286-1-yun.zhou@windriver.com>
References: <20260613113154.2550286-1-yun.zhou@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:yun.zhou@windriver.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:qingfang.deng@linux.dev,m:jiri@resnulli.us,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-299678-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 70F3B68AF01

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
flow_dissector: fix uninit-value in __skb_flow_dissect() for ETH_ADDRS

This patch addresses a KMSAN report by gating the read of eth_hdr(skb)
in __skb_flow_dissect() on skb->dev->hard_header_len being at least the
size of the ETH_ADDRS dissector key, zeroing the key otherwise. The
goal is to avoid reading uninitialized memory when a TUN device in
IFF_TUN (L3) mode passes a packet without a link-layer header to a
flower filter on a shared block.

Closes: https://syzkaller.appspot.com/bug?extid=fa2f5b1fb06147be5e16

> diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
> index 2a98f5fa74eb..de6ca9beee03 100644
> --- a/net/core/flow_dissector.c
> +++ b/net/core/flow_dissector.c
> @@ -1173,13 +1173,20 @@ bool __skb_flow_dissect(const struct net *net,
>  
>  	if (dissector_uses_key(flow_dissector,
>  			       FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
> -		struct ethhdr *eth = eth_hdr(skb);
>  		struct flow_dissector_key_eth_addrs *key_eth_addrs;
>  
>  		key_eth_addrs = skb_flow_dissector_target(flow_dissector,
>  							  FLOW_DISSECTOR_KEY_ETH_ADDRS,
>  							  target_container);
> -		memcpy(key_eth_addrs, eth, sizeof(*key_eth_addrs));
> +		/* TC filter blocks can be shared across devices with
> +		 * different header lengths, so we cannot validate this
> +		 * when the filter is installed -- check at dissect time.
> +		 */
> +		if (skb->dev &&
> +		    skb->dev->hard_header_len >= sizeof(*key_eth_addrs))
> +			memcpy(key_eth_addrs, eth_hdr(skb), sizeof(*key_eth_addrs));

[Medium]
Is hard_header_len the right predicate to gate this read on?

The dissector key is ETH_ALEN+ETH_ALEN, so the gate accepts any device
with hard_header_len >= 12. IPoIB sets hard_header_len = IPOIB_HARD_LEN
with dev->type = ARPHRD_INFINIBAND, and ARPHRD_FDDI uses 21 bytes.
Wouldn't packets on those link types pass this check and have the first
12 bytes of a non-Ethernet L2 header copied into key_eth_addrs as if
they were the destination and source MAC addresses?

Would a check on dev->type == ARPHRD_ETHER (or dev->addr_len == ETH_ALEN)
be more appropriate, so that only true Ethernet framing is read into
the key?

[Medium]
Does this gate behave correctly across act_mirred?

act_mirred reassigns skb->dev to the mirror/redirect target before the
target device's classifier path runs. Consider a packet originally
framed on an Ethernet device, with a valid mac_header in the linear
region, redirected to a headerless device such as TUN IFF_TUN that
shares a TC block with the source. The key_eth_addrs would now be
zeroed via the else branch even though the original Ethernet header
is still present in the skb. Is that intended for shared blocks?

[Medium]
Does this still leave a path where eth_hdr(skb) reads past the buffer?

eth_hdr(skb) expands to skb->head + skb->mac_header. When mac_header is
the unset sentinel (typeof(skb->mac_header))~0U set by skb allocation
or by skb_unset_mac_header(), the dereference resolves to skb->head +
0xFFFF, well past skb_end_pointer(skb). The new gate only inspects
skb->dev->hard_header_len, which is independent of skb->mac_header, so
any skb delivered to the dissector with mac_header unset on a device
whose hard_header_len >= 12 would still read out-of-bounds bytes into
key_eth_addrs.

Would skb_mac_header_was_set(skb) plus a bounds check that the 12 bytes
lie within [skb->head, skb_tail_pointer(skb)) be a more direct match
for the property the commit message describes:

    This assumes the skb has a valid Ethernet header at mac_header,
    which is not always the case.

> +		else
> +			memset(key_eth_addrs, 0, sizeof(*key_eth_addrs));

[Low]
The commit message says:

    If the device does not have a link-layer header large enough to
    contain the Ethernet addresses, zero the key so the filter will
    not match.

Is that wording accurate for all filter shapes?

__fl_lookup() uses key_eth_addrs as part of the rhashtable lookup key.
A flower filter installed to match src_mac 00:00:00:00:00:00 and
dst_mac 00:00:00:00:00:00 (for example a catch-all on a shared block)
would, after this change, deterministically match every packet on a
headerless device, where previously the random skb memory made such a
filter effectively never match there.

Could the commit message note this corner case, or could a sentinel
value that cannot collide with a legal user-supplied key be used
instead of all zeros?

>  	}
>  
>  	if (dissector_uses_key(flow_dissector,
-- 
pw-bot: cr

