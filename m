Return-Path: <netdev+bounces-298816-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cDMMGD6WLGqMTQQAu9opvQ
	(envelope-from <netdev+bounces-298816-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 01:29:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B1567D0CC
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 01:29:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Yo/Fo2+a";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298816-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298816-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85B3631D28CE
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 23:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057683783AA;
	Fri, 12 Jun 2026 23:29:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C7B3093CB;
	Fri, 12 Jun 2026 23:28:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781306939; cv=none; b=f/bHY2bll9ah5nQ0Rv77WBPO3RdwDnSPL29JwE9RP4Exooz4ISM72mhsZqx2LeGwvIwUzMpAYdqRCh8KrwKGZyqXDeuT81+cH3g/Hy9vfJE/Ps9eeOI8CB86HXiY4IftbCH1eOR2JqUqD/YtiogFtvyDiXMIZAuVr2A7fbdXwhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781306939; c=relaxed/simple;
	bh=KP5KEUfkmSlOrjD8MwnmQ1Pda6CPldKPeuRF6xe4Mvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h52u4oYTA4hTq0Lq2djDbPhi/A61ytABUdXcEdHVM5w9NX7wH7U0Xns8Df89Ap8/RwBCjnV3IrvnN0vD26hD4DkA8uGMbxuwgC+8iBDvaICDBm9eyHdTj7xr+lwq+OOpka+0r8VghOKuPJzKa9NjzS1SDjhSJh+yQMAXX0RyuKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yo/Fo2+a; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547231F000E9;
	Fri, 12 Jun 2026 23:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781306938;
	bh=xvNnSCHTOuKKya/tbZEIhMajyQ+r6TbMiXQ66GrWtq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yo/Fo2+awN+UcMvBisLCZpYVhpKFKPHtuZezbbF0iRqzR85jXto7yle+otJnpUz+/
	 Mc98j30FPme+g26xU9S0s0swUrNIABaiTCc8xjoZbq5y2zhxUAnaT/Pbt2pKsHO8rI
	 clBHGec3BL1a2i/5RNt0cXyLqRMfPuwzwl12qxF9bLoDRJJSDG9MN5ZFoTPYNYAhCY
	 D8l1WCyTZVDuiSsmhIZ1OUwCe4TTJmgr1dcxsflKu+aBPHfvOEvncKR+SNaY6PTLeH
	 vnjl7G8UTtH+iSUIALdcIL3THk1BiDwh/E3Kp0CfQ342XUAL+raCtF+dw1oCBRV1Mz
	 JBxTLNir3qfyQ==
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
	linux-kernel@vger.kernel.org,
	syzbot+fa2f5b1fb06147be5e16@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] flow_dissector: fix uninit-value in __skb_flow_dissect() for ETH_ADDRS
Date: Fri, 12 Jun 2026 16:28:56 -0700
Message-ID: <20260612232856.2693184-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609023752.1245848-1-yun.zhou@windriver.com>
References: <20260609023752.1245848-1-yun.zhou@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298816-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yun.zhou@windriver.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:qingfang.deng@linux.dev,m:jiri@resnulli.us,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:syzbot+fa2f5b1fb06147be5e16@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev,fa2f5b1fb06147be5e16];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B1B1567D0CC

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
flow_dissector: fix uninit-value in __skb_flow_dissect() for ETH_ADDRS
    
This commit attempts to fix an uninitialized value read in __skb_flow_dissect()
for ETH_ADDRS. It checks the packet length before parsing the MAC addresses
to prevent issues on headerless L3 devices.

Reported-by: syzbot+fa2f5b1fb06147be5e16@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fa2f5b1fb06147be5e16
Fixes: 67a900cc0436 ("flow_dissector: introduce support for Ethernet addresses")

> diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
> index 2a98f5fa74eb0..1e6a2c04698ca 100644
> --- a/net/core/flow_dissector.c
> +++ b/net/core/flow_dissector.c

[ ... ]

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
> +		if (skb_mac_header_was_set(skb) &&
> +		    skb_tail_pointer(skb) - skb_mac_header(skb) >= sizeof(*key_eth_addrs))

[Severity: High]
Does this logic bypass the bounds check if the MAC header points past the tail?

The pointer subtraction yields a signed value, which is then compared against
sizeof(*key_eth_addrs), an unsigned size_t. If an SKB is modified such that
skb->mac_header points past skb->tail, the subtraction results in a negative
value. Due to C integer promotion rules, this promotes to a massive unsigned
value, bypassing the length check.

Would it be safer to use pointer addition instead, such as:
skb_mac_header(skb) + sizeof(*key_eth_addrs) <= skb_tail_pointer(skb)?

[Severity: High]
The commit message mentions fixing this by checking skb->dev->hard_header_len,
but it appears this check is missing from the implemented code.

For L3 devices like TUN, mac_header typically points to the start of the L3
payload, like the IPv4 header. Since most IP packets are larger than 12 bytes,
this length condition will evaluate to true without checking the hardware
header length.

Will this cause the flow dissector to incorrectly copy the first 12 bytes of
the IP header into the Ethernet addresses key?

> +			memcpy(key_eth_addrs, eth_hdr(skb), sizeof(*key_eth_addrs));
> +		else
> +			memset(key_eth_addrs, 0, sizeof(*key_eth_addrs));
>  	}
>  
>  	if (dissector_uses_key(flow_dissector,
-- 
pw-bot: cr

