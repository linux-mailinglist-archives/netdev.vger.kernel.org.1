Return-Path: <netdev+bounces-272995-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id pNi5HuyDyWndygUAu9opvQ
	(envelope-from <netdev+bounces-272995-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 21:56:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDAB353D8D
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 21:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31F7C300F521
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 19:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921123002B9;
	Sun, 29 Mar 2026 19:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJdVJwML"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFB9155C97;
	Sun, 29 Mar 2026 19:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774814185; cv=none; b=EB3uisfUYFLm6oOjxD6lNmZmJZN1L8yoEt6Q4WWENyb2k1tqQ75O3CrY2xd+7s44WeJ814kYqSXdwl7E1+pVB4ckf7FKxE2LTS0wnYH1HnIJLyXkjaJBUZD8YMTHPn6BXTgtADAicPq9NUqQGOfR/ypjKEC25SjEP8gFkwhN5vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774814185; c=relaxed/simple;
	bh=6df/9HqXaLPvCXTs2hnwKIFnBWYffqp/9E2nAERKl24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j32huWdVp7yVWJqVdv4BY0zSXQJKiFkvpDa5KmM2lORQeNBC7ca6nmDGX0/FVYeBP6KmwnidQSjn7ablcQ17mf4oQesu5+YlfwQQkvAmvD3k01iBfF/0GP+qjwBtmW+Fic/t7at6Cp2F34bgRd0s7ANhzoQAzDvKelFPokTmhag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJdVJwML; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A82C116C6;
	Sun, 29 Mar 2026 19:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774814185;
	bh=6df/9HqXaLPvCXTs2hnwKIFnBWYffqp/9E2nAERKl24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PJdVJwMLqnwibNDlWIdm77WKXlgFGjv3gJbMMBvtG257zxmICCa/QOA0TDQXoPhKS
	 MSb4OTHZleo49zwoM8AWSd8qsSw2I9iBwz5Ye1PK3VyhcdxJay8RfR1pORyYfPBlio
	 iefXZse0CdK51whNETvK0mI+j4tWp7VH+WttQkNQmNJRPqxLWxgieKMzUUtU0jchHu
	 /1V6TolVAeM284Zzm7tCZuieRpUBmAsb2UvCiE6tnqN7HX60Ldg3WfnElUjQmzZAgZ
	 Mij7fImAx0soe9RvrlT2j0d2iPNb5+pstK5Y5ogLr9ueUMM5Ek5MYBgpc/0sSIFVCa
	 OCaAU+9+75l0A==
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
Subject: Re: [PATCH net-next v2 1/9] net: dsa: add tag driver for LAN9645X
Date: Sun, 29 Mar 2026 12:56:20 -0700
Message-ID: <20260329195620.2789042-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324-dsa_lan9645x_switch_driver_base-v2-1-f7504e3b0681@microchip.com>
References: <20260324-dsa_lan9645x_switch_driver_base-v2-1-f7504e3b0681@microchip.com>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,armlinux.org.uk,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-272995-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BEDAB353D8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: dsa: add tag driver for LAN9645X

Add a tag driver for LAN9645x switches using a front port as the CPU port
(NPI port). The driver configures a long prefix for extraction and no
prefix for injection to handle the internal frame header (IFH).

> diff --git a/net/dsa/tag_lan9645x.c b/net/dsa/tag_lan9645x.c
> new file mode 100644
> index 000000000000..9130fb0d61be
> --- /dev/null
> +++ b/net/dsa/tag_lan9645x.c

[ ... ]

> +static void lan9645x_xmit_get_vlan_info(struct sk_buff *skb,
> +					struct net_device *br,
> +					u32 *vlan_tci, u32 *tag_type)
> +{
> +	struct vlan_ethhdr *hdr;
> +	u16 proto, tci;
> +
> +	if (!br || !br_vlan_enabled(br)) {
> +		*vlan_tci = 0;
> +		*tag_type = LAN9645X_IFH_TAG_TYPE_C;
> +		return;
> +	}
> +
> +	hdr = (struct vlan_ethhdr *)skb_mac_header(skb);
> +	br_vlan_get_proto(br, &proto);
> +
> +	if (ntohs(hdr->h_vlan_proto) == proto) {
> +		vlan_remove_tag(skb, &tci);

Is it possible for a maliciously crafted packet (e.g., via AF_PACKET) to have a
length of 14 bytes with h_vlan_proto set to ETH_P_8021Q?

If so, vlan_remove_tag() would read vhdr->h_vlan_TCI at offset 14, causing an
out-of-bounds read.

Furthermore, if the packet contains fragments and the VLAN header is not in the
linear data area, vlan_remove_tag() could corrupt the SKB when shifting the MAC
header.

Would it be safer to use skb_vlan_untag() instead?

> +		*vlan_tci = tci;
> +	} else {
> +		rcu_read_lock();
> +		br_vlan_get_pvid_rcu(br, &tci);
> +		rcu_read_unlock();
> +		*vlan_tci = tci;
> +	}
> +
> +	*tag_type = (proto != ETH_P_8021Q) ? LAN9645X_IFH_TAG_TYPE_S :
> +					     LAN9645X_IFH_TAG_TYPE_C;
> +}

[ ... ]

> +static struct sk_buff *lan9645x_rcv(struct sk_buff *skb,
> +				    struct net_device *ndev)
> +{
> +	u32 src_port, qos_class, vlan_tci, tag_type, popcnt, etype_ofs;
> +	u8 *orig_skb_data = skb->data;
> +	struct dsa_port *dp;
> +	u32 ifh_gap_len = 0;
> +	u16 vlan_tpid;
> +	u8 *ifh;
> +
> +	/* DSA master already consumed DMAC,SMAC,ETYPE from long prefix. Go back
> +	 * to beginning of frame.
> +	 */
> +	skb_push(skb, ETH_HLEN);
> +	/* IFH starts after our long prefix */
> +	ifh = skb_pull(skb, LAN9645X_LONG_PREFIX_LEN);

Could skb_pull() return NULL here if skb->len is less than 16 bytes?

If it returns NULL, the blind dereference of ifh in the subsequent
lan9645x_ifh_get() calls would cause a NULL pointer dereference.

Additionally, is the 44-byte tag (16-byte prefix + 28-byte IFH) guaranteed to
be in the linear data buffer (skb->data)?

Without calling pskb_may_pull(skb, LAN9645X_TOTAL_TAG_LEN) first, accessing it
via the ifh pointer might result in out-of-bounds reads if the packet payload
is in paged fragments.

> +
> +	popcnt = lan9645x_ifh_get(ifh, IFH_POP_CNT, IFH_POP_CNT_SZ);
> +	etype_ofs = lan9645x_ifh_get(ifh, IFH_ETYPE_OFS, IFH_ETYPE_OFS_SZ);
> +	src_port = lan9645x_ifh_get(ifh, IFH_SRCPORT, IFH_SRCPORT_SZ);
-- 
pw-bot: cr

