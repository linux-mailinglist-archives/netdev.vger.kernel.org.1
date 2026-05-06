Return-Path: <netdev+bounces-284652-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id k1YQEVad+mk8QQMAu9opvQ
	(envelope-from <netdev+bounces-284652-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 03:45:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A96E24D5625
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 03:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B8EE3018C0A
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 01:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C878E1A3157;
	Wed,  6 May 2026 01:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPigXP7V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50A69463;
	Wed,  6 May 2026 01:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778031955; cv=none; b=gtc8zuOxfR/kc8oEiY3YUjlV6GyejmXZZdGafcHiC09lZStF2GxB8xOzx/rKEG3yTjj371UoJw9nfcaK6rawsSgris8TxprQDi6PQ3IpV3O2FA/5orTwVg74/mmS5y+q1oP/WH82bUXHjRgB993eVuH0HK4bib876Ff5f7Rsf8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778031955; c=relaxed/simple;
	bh=HcowDaLCPHTbfwY5o6JAlN46GhiTtHscFHLYw9ODrbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GU5KtG0uy+MWr+D/M+ZQ/rXi1RkEfa5yDFJyr7VVrKx7HssPzHIx3BY9tdxH2euB4m04njdpFFUxOc5pyGQL5bL3Jy8+he2Rm1YMh5ZSSrvghBC0TqQiT66YkUb1MqnOxp1XlZMzDIpRLeJkdAoTUb6ZnfP8aDww5B+nlMNZo1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPigXP7V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB2EC2BCB4;
	Wed,  6 May 2026 01:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778031955;
	bh=HcowDaLCPHTbfwY5o6JAlN46GhiTtHscFHLYw9ODrbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TPigXP7Veb0WMItIe4J2VNjLe7lcBIQnNWCLv+Crg9bbgOMlWOcYd9A8d93KezwjA
	 WBw1z5sUHpMBtIkW08cPleP8hkHZHbw9Ki2zPenUw1qsPEZFZO0PTR6PyPyXXm/r1C
	 HufOWerCc+5sT7TLngU/1rc9PmfIHZMziGF7PuhFuICAHGfHt60ELOqpSmTGXmR2Dn
	 ihV1whI/nmbDh/15VAM8NlYwoXq1LlSjZrETK5aL46rQXFXMrJVUvvj6lt4dKvj4w8
	 /fgH/T/LQBqLzDFbXwcg/SVlfwQO5l3pTL+zwLOgT6BhAcr4hkxJTEt75VG+VlUquJ
	 ZVK3ty39cjwmg==
From: Jakub Kicinski <kuba@kernel.org>
To: jensemil.schulzostergaard@microchip.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	UNGLinuxDriver@microchip.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	woojung.huh@microchip.com,
	linux@armlinux.org.uk,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/9] net: dsa: add tag driver for LAN9645X
Date: Tue,  5 May 2026 18:45:52 -0700
Message-ID: <20260506014552.1616551-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430-dsa_lan9645x_switch_driver_base-v4-1-f1b6005fa8b7@microchip.com>
References: <20260430-dsa_lan9645x_switch_driver_base-v4-1-f1b6005fa8b7@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A96E24D5625
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,armlinux.org.uk,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-284652-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: dsa: add tag driver for LAN9645X

Adds a DSA tag driver for Microchip LAN9645x switches operating with a
front port configured as an NPI CPU port. RX uses a 16-byte long prefix
plus a 28-byte internal frame header; TX uses only the IFH.

> diff --git a/net/dsa/tag_lan9645x.c b/net/dsa/tag_lan9645x.c
> new file mode 100644
> index 000000000000..81e7a78e0f81
> --- /dev/null
> +++ b/net/dsa/tag_lan9645x.c

[ ... ]

> +static struct sk_buff *lan9645x_rcv(struct sk_buff *skb,
> +				    struct net_device *ndev)
> +{
> +	u32 src_port, qos_class, vlan_tci, tag_type, popcnt, etype_ofs;
> +	struct dsa_port *dp;
> +	u32 ifh_gap_len = 0;
> +	u16 vlan_tpid;
> +	u8 *ifh;
> +
> +	/* DSA master already consumed DMAC,SMAC,ETYPE from long prefix. Go back
> +	 * to beginning of frame.
> +	 */
> +	skb_push(skb, ETH_HLEN);
> +
> +	if (unlikely(!pskb_may_pull(skb, LAN9645X_TOTAL_TAG_LEN)))
> +		return NULL;
> +
> +	/* IFH starts after our long prefix */
> +	ifh = skb_pull(skb, LAN9645X_LONG_PREFIX_LEN);

[ ... ]

> +	skb_pull(skb, LAN9645X_IFH_LEN);
> +
> +	if (unlikely(!pskb_may_pull(skb, ifh_gap_len + ETH_HLEN)))
> +		return NULL;
> +
> +	skb_pull(skb, ifh_gap_len);
> +	skb_reset_mac_header(skb);
> +	skb_set_network_header(skb, ETH_HLEN);
> +	skb_reset_mac_len(skb);
> +
> +	/* Remove the long prefix + IFH + ifh_gap contribution from
> +	 * skb->csum so the stack sees a checksum consistent with the
> +	 * real Ethernet frame. skb->data currently points at the real
> +	 * MAC header.
> +	 */
> +	skb_postpull_rcsum(skb,
> +			   skb->data - LAN9645X_TOTAL_TAG_LEN - ifh_gap_len,
> +			   LAN9645X_TOTAL_TAG_LEN + ifh_gap_len);

Does this skb_postpull_rcsum() call subtract the wrong region from
skb->csum for CHECKSUM_COMPLETE frames?

By the time lan9645x_rcv() is entered, the conduit's eth_type_trans()
has already pulled the first ETH_HLEN (14) bytes of the long prefix and
adjusted skb->csum accordingly, so skb->csum covers bytes starting at
offset 14 (the remaining 2 bytes of the long prefix plus IFH plus any
gap plus the real frame).

At the point of the skb_postpull_rcsum() call, skb->data points at the
real MAC header, i.e. at offset LAN9645X_TOTAL_TAG_LEN + ifh_gap_len
from the start of the originally-received frame. So
skb->data - LAN9645X_TOTAL_TAG_LEN - ifh_gap_len points at offset 0,
and the subtracted region is [0, LAN9645X_TOTAL_TAG_LEN + ifh_gap_len).

That region includes the first 14 bytes that eth_type_trans() already
removed from skb->csum, and it stops short of the real MAC header which
also needs to be removed. Shouldn't the subtracted region instead start
at what skb->data was on entry to rcv() (i.e. post-eth_type_trans) and
cover LAN9645X_TOTAL_TAG_LEN + ifh_gap_len bytes from there, so that it
matches what skb->csum actually covers?

For reference, tag_ocelot.c (cited in the commit message as the
architectural model) saves start = skb->data at function entry before
any skb_push()/skb_pull() manipulation:

    net/dsa/tag_ocelot.c:ocelot_rcv() {
        ...
        u8 *start = skb->data;
        ...
        skb_push(skb, ETH_HLEN);
        skb_pull(skb, OCELOT_SHORT_PREFIX_LEN);
        ...
    }

and later passes that saved pointer to skb_postpull_rcsum() with the
total tag length, so the subtracted region exactly matches what the
NIC's csum_complete covers.

Would saving skb->data on entry (before the initial skb_push(ETH_HLEN))
and passing that as the start argument, with length
LAN9645X_TOTAL_TAG_LEN + ifh_gap_len, produce the correct result here
as well?

