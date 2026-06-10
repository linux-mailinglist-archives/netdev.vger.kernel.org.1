Return-Path: <netdev+bounces-297738-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id r8xhKrSGKWrXYgMAu9opvQ
	(envelope-from <netdev+bounces-297738-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:45:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F88566AFA7
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:45:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Wy8TTo9F;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297738-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297738-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AEF813027312
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF41B41360E;
	Wed, 10 Jun 2026 15:39:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F3F3F888F;
	Wed, 10 Jun 2026 15:39:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105996; cv=none; b=oq+DFPd6GnAaST9s9OtnsQInxJdZayk1URAJSMpL4gBYbsCCwOhjEUkDFhHgwabEZjrvHHRru/75zU/86hbbe9//idEI9iMPlhCz8BeRxM7mupPvoi2mbwWlG/hmNHtbXxAel9F0vtELpXjC9dNyVbn73BmL3kLJGZUJ82rqkYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105996; c=relaxed/simple;
	bh=036Z5zkwz7S2BdV6MQPpzklP1px3RmEamUjh4X7FRZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PjIwcGSfTEgE0ORdqKU+Dtnncyi/PpTJilDmoOqKOp7S9pLalT1POdUvwRftlDtcskVxLbQKkUq9qyEZWeVxxllnmAsXBtp2fPv8bo29p5iDc0zQ1p7vJ7bhhvAOVtUKCQw3IZddAw8xSCtEbiXRGY3DnRdqxi1W/EiVxQH25BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wy8TTo9F; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755D31F00893;
	Wed, 10 Jun 2026 15:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781105995;
	bh=UlklpKDQok3SEdaetqgj4mWRClfQRiJamKRruUcVjSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wy8TTo9FmIR8JXVgyJe+m5nYw7LYBo9s1oPqQP66ozVTxYnxA4QPxyUpExbO1gC5C
	 9YPu0w9ndcPkaqj3PkDudePW4xv4cvKMUPRWlFj2HsiBiXVa2Kng2oU9z4ESL9jtzC
	 lLUi39GTkrtJGFn0qc8IrRIWQwrBO/QrEmTIHyXy5ekkhPJKTfGUB1fAm/VzHXE3im
	 w+5aida9lNRWy8QWMMFX3sH96mHMn9nGBxftXYY4sCCo3+RG1O4BGZfKrwQrQ9ET78
	 q0HGpPW3LVFO+vOrpJwf/j6dqJCSzOxylaa4WmFroCzFRcYrf81KAVHkvjBOZ94W5o
	 NhgPHITWuGQ8Q==
From: Jakub Kicinski <kuba@kernel.org>
To: linusw@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	marex@denx.de,
	horms@kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	Woojung.Huh@microchip.com,
	devicetree@vger.kernel.org,
	nb@tipi-net.de
Subject: Re: [PATCH net-next v6 3/5] net: dsa: tag_ks8995: Add the KS8995 tag handling
Date: Wed, 10 Jun 2026 08:39:52 -0700
Message-ID: <20260610153952.1685895-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608-ks8995-to-ksz8-v6-3-d91eb43edcc5@kernel.org>
References: <20260608-ks8995-to-ksz8-v6-3-d91eb43edcc5@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297738-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:kuba@kernel.org,m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:marex@denx.de,m:horms@kernel.org,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:Woojung.Huh@microchip.com,m:devicetree@vger.kernel.org,m:nb@tipi-net.de,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,denx.de,armlinux.org.uk,vger.kernel.org,tipi-net.de];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F88566AFA7

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: dsa: tag_ks8995: Add the KS8995 tag handling

Adds a new DSA tagger for the Micrel/Microchip KS8995XA switch using a
modified 0x8100 ethertype where the lower nybble encodes a port bitmap.
The patch wires the new tagger into the DSA core, Kconfig, Makefile and
MAINTAINERS.

A few questions inline below.

> diff --git a/net/dsa/tag_ks8995.c b/net/dsa/tag_ks8995.c
> new file mode 100644
> index 000000000000..5bdb18271582
> --- /dev/null
> +++ b/net/dsa/tag_ks8995.c
> @@ -0,0 +1,132 @@
[ ... ]
> +static struct sk_buff *ks8995_xmit(struct sk_buff *skb, struct net_device *dev)
> +{
> +	struct vlan_ethhdr *hdr = vlan_eth_hdr(skb);
> +	bool have_hwaccel_tag = false;
> +	u16 tci = 0, portmask;
> +
> +	/* Prepare the special KS8995 tags */
> +	portmask = dsa_xmit_port_mask(skb, dev);
> +
> +	if (skb_vlan_tag_present(skb) && skb->vlan_proto == htons(ETH_P_8021Q)) {
> +		tci = skb_vlan_tag_get(skb);
> +		__vlan_hwaccel_clear_tag(skb);
> +		have_hwaccel_tag = true;
> +	}

[Low]
What is intended to happen if the skb arrives with both a hwaccel VLAN
tag and an in-head 0x8100 tag, or with a hwaccel tag whose vlan_proto
is something other than 0x8100 (for example 0x88a8 service tag)?

In those cases this branch leaves the hwaccel tag alone or only consumes
it conditionally, and the second branch below either inserts a fresh
in-head tag while keeping a pre-existing in-head 0x8100, or modifies the
in-head 0x8100 while a non-8021Q hwaccel tag is still attached. Should
this path either reject such frames or normalise them first?

> +
> +	if (have_hwaccel_tag || hdr->h_vlan_proto != htons(ETH_P_8021Q)) {
> +		skb = vlan_insert_tag(skb, KS8995M_STPID(portmask), tci);
> +		if (!skb)
> +			return NULL;

[High]
Is returning NULL here safe?

include/linux/if_vlan.h documents that vlan_insert_tag() calls
dev_kfree_skb_any(skb) on failure (e.g. when skb_cow_head() fails under
memory pressure) and returns NULL. The caller in net/dsa/user.c does:

    nskb = p->xmit(skb, dev);
    if (!nskb) {
        kfree_skb(skb);
        return NETDEV_TX_OK;
    }

so on the NULL return dsa_user_xmit() runs kfree_skb() on its local
pointer that vlan_insert_tag() has already freed. Doesn't that produce a
use-after-free on skb->users plus a double free?

Should this path swallow the free done by vlan_insert_tag() (e.g. by
returning a sentinel handled by the caller) so dsa_user_xmit() does not
re-free the skb?

> +		hdr = vlan_eth_hdr(skb);
> +		netdev_dbg(dev, "%s: inserted VLAN TAG %04x TCI %04x\n",
> +			   __func__, hdr->h_vlan_proto, hdr->h_vlan_TCI);
> +	} else {
> +		/* VLAN tag already exists in skb head, modify it in place */
> +		hdr = vlan_eth_hdr(skb);
> +		hdr->h_vlan_proto = KS8995M_STPID(portmask);
> +		netdev_dbg(dev, "%s: modified VLAN TAG %04x\n",
> +			   __func__, hdr->h_vlan_proto);
> +	}
> +
> +	return skb;
> +}
> +
> +static struct sk_buff *ks8995_rcv(struct sk_buff *skb, struct net_device *dev)
> +{
> +	int portmask;
> +	u16 etype;
> +
> +	/* We are expecting all received packets to have a mangled VLAN
> +	 * TPID, so drop anything else. Because of the non-standard TPID,
> +	 * don't even bother looking for a tag in the hwaccel area.
> +	 *
> +	 * We have to inspect the ethertype directly because skb->protocol
> +	 * will contain garbage.
> +	 */
> +	etype = ntohs(*(__be16 *)dsa_etype_header_pos_rx(skb));
> +	if ((etype & KS8995M_STPID_STD) != ETH_P_8021Q) {
> +		netdev_dbg(dev, "%s: dropped ethertype 0x%04x\n",
> +			   __func__, etype);
> +		return NULL;
> +	}
> +	netdev_dbg(dev, "%s: received ethertype %04x\n",
> +		   __func__, etype);
> +
> +	/* Move the custom DSA+VLAN tag into the hwaccel area and strip
> +	 * it from the skb head
> +	 */
> +	skb = skb_vlan_untag(skb);
> +	if (!skb) {
> +		netdev_err(dev, "%s: unable to untag skb\n", __func__);
> +		return NULL;
> +	}

[High]
Is the NULL return here compatible with the cpu_dp->rcv contract?

skb_vlan_untag() can take its err_free path (e.g. when the
pskb_may_pull(VLAN_HLEN + sizeof(unsigned short)) inside it fails, or
skb_reorder_vlan_header() fails) which calls kfree_skb(skb) and returns
NULL.

The caller in net/dsa/tag.c is:

    skb = skb_unshare(skb, GFP_ATOMIC);
    ...
    nskb = cpu_dp->rcv(skb, dev);
    ...
    if (!nskb) {
        kfree_skb(skb);
        return 0;
    }

so when ks8995_rcv() returns NULL after skb_vlan_untag() has already
freed its argument, dsa_switch_rcv() ends up calling kfree_skb() on a
freed skb. Wouldn't that be a use-after-free on skb->users plus a
double free?

Other cpu_dp->rcv handlers appear to assume that returning NULL means
the skb was not freed. Should this handler do something equivalent so
the contract still holds?

> +
> +	portmask = FIELD_GET(KS8995M_STPID_PORTMASK, etype);
> +	netdev_dbg(dev, "%s: etype %04x portmask %04x (%d)\n",
> +		   __func__, etype, portmask, ilog2(portmask));
> +	skb->dev = dsa_conduit_find_user(dev, 0, ilog2(portmask));
> +	if (!skb->dev)
> +		return NULL;

[Low, Low]
A literal 0x8100 frame from the wire passes the
(etype & GENMASK(15,4)) != ETH_P_8021Q gate above, in which case
FIELD_GET(GENMASK(3,0), 0x8100) is 0 and ilog2(0) is computed (and also
passed as a netdev_dbg() argument). The frame is only dropped because
dsa_conduit_find_user() happens not to match port -1.

Would an explicit check be clearer:

    portmask = FIELD_GET(KS8995M_STPID_PORTMASK, etype);
    if (!portmask)
        return NULL;

The commit message says "a bit in the last nybble is set for each
target port", suggesting bitmap semantics, but ilog2(portmask) on
ingress only handles a single bit and silently picks the highest set
bit if more than one is set. Would an is_power_of_2(portmask) sanity
check be appropriate here?

> +
> +	/* Preserve the VLAN tag if it contains a non-zero VID which is not
> +	 * identical to 0x001, or PCP, and restore its TPID to the standard
> +	 * value.
> +	 *
> +	 * If this is just an ordinary inbound package the datasheet claims
> +	 * it will "replace null VID with ingress port VID", which means
> +	 * VID set to 1: 0x8101 0001 for port 0 or 0x8102 0001 for port 1.
> +	 * So in the DSA driver we will set the default port VID to 0 so
> +	 * we can properly detect non-VLAN frames.
> +	 */
> +	if (!skb->vlan_tci) {
> +		netdev_dbg(dev, "%s: clear VLAN tag from frame\n", __func__);
> +		__vlan_hwaccel_clear_tag(skb);
> +	} else {
> +		skb->vlan_proto = htons(ETH_P_8021Q);
> +		netdev_dbg(dev, "%s: vlan_tci = 0x%04x VLAN frame\n",
> +			   __func__, skb->vlan_tci);
> +	}

[Low]
The comment says

    Preserve the VLAN tag if it contains a non-zero VID which is not
    identical to 0x001, or PCP

but the code only tests:

    if (!skb->vlan_tci)

That matches VID == 0 and PCP == 0 and DEI == 0 only, so frames with
VID == 1 (the chip's "replace null VID with ingress port VID" default)
fall through into the "preserve as a VLAN frame" branch instead of
being stripped. Should the comment and the code be reconciled, or
should the test also strip VID == 1 frames so the behaviour does not
depend on the switch driver also forcing the default port VID to 0?

> +
> +	dsa_default_offload_fwd_mark(skb);
> +
> +	return skb;
> +}
-- 
pw-bot: cr

