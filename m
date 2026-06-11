Return-Path: <netdev+bounces-298315-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZpBrBOkMK2p91wMAu9opvQ
	(envelope-from <netdev+bounces-298315-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 21:30:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D94BD674BFE
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 21:30:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fastmail.im header.s=fm1 header.b="T XSNgoO";
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=CZfkj+KN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298315-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-298315-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=fastmail.im;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D7F373034290
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 19:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534FA30F7E8;
	Thu, 11 Jun 2026 19:30:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E174B303C87
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 19:30:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781206242; cv=none; b=iPrErtSkM6ku32/ffY5szjzq9iqQqfVXuupUr65CpEaBroKoZtP7K4CFwQjbO3IxHPfbIS6Pp1luDzo4fOQ5d/H47HMWnD/AOyI5KFxVp/MMxjgBlkWdGMnFs3Caizz/rf9bPDupdRacs8TEp+sqybw02bd6OPsyn00fPSzBtxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781206242; c=relaxed/simple;
	bh=8Y41lsTwruYuymBRKx/WwbkfnxDr3A9GADkrE6kXqeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M5YoHGDbiaLkAJ74VFN0R9sHf93lfvplhMXIFWDBKmeG4ANM1iWsqdJKApnX8M926PsE2KIS7FN20BVbxvr+2ZAZz2SEoUprsW6Bqzdttk96Ww29/YCq1fpwwIu6AJfMyRzkJa468JVf3CQbq1umiGsDAJ03WeBOtg7Fni+zgAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=TXSNgoOf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CZfkj+KN; arc=none smtp.client-ip=202.12.124.157
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D7F557A0150;
	Thu, 11 Jun 2026 15:30:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 11 Jun 2026 15:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1781206239; x=
	1781292639; bh=dUIErbGsP3wv8Ie67b7ytj+lAe1TXPPhIZejfGlUUTc=; b=T
	XSNgoOff/WUtxYUTVu4DIxIEGlROyZ+c7iYfyxcHgCGew4C1kytfvg55gFXZlVuZ
	0JYICALHP2qT03uelxlizyeiV2fn/XaJegmO90/Nhg70epAt4pdTwVmOqcUBmcVl
	xM9i/nWolHoFEIOBtxanBuanJ/5gCuCA0JW9hWuPVWmiddT9knEUadgrq4g47XyA
	tLEyeTYKpPcG+z9qim9uU4SnF16xqsX6E+Q84y5RPo4SS8jRkvkqA2lyNM6gUgYr
	aisqRPHCmo2iT8KhdP0SgxXyyjKuqsqdNHQn2LCV/fIotP0QbxasTiKhVVBG3yWE
	pN/oOkZJXnzYF12DYXW0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1781206239; x=1781292639; bh=d
	UIErbGsP3wv8Ie67b7ytj+lAe1TXPPhIZejfGlUUTc=; b=CZfkj+KNXtd3kPCus
	aBwaak0ikMQ28yvlFgx+VJtjbIeULpj2KRf/61LKdgv/hWSp53vu7SylXJ1lfqMk
	rVpH95FhoLYbppu0qmaaE0+/66aBYNxXVfTxtSM5dQgLalkSEJOfvXBwFgGgSLJB
	05UV3szwk9ofulcZhF6+YW7B5JVl+1Tf7sJ/VbN9oG+tgPPNY6JDZI1br2nsKROQ
	hw+W6rYBuGLYtoqgm7+kDhopvoeC/anOdwjdU9FXSqJtcxMznClR7P9JCHCYmHm7
	DVv7TeJFd/96ajO3qZDYx2Bf0O4naryzpsp7g+gP9rAUbZ+rhbzwy9x1va1SciPT
	OR7SA==
X-ME-Sender: <xms:3wwravYQK3S2kM_1CkVp1cDzjyyShmItL_i_7uBVVuDOkV7unJ4Ftg>
    <xme:3wwras564f23lh7-Q6mEgxfhAzfFXMguBp5tgVwur1E16ZxpWJKNBVuSDDT8au1MT
    G-OWIHArlj7byCHCj2pKIvLUSnNvVU8T7aYRefGi4aqoPh-MrD86K8>
X-ME-Received: <xmr:3wwraox5Ov2-HXIrFd4iHWkkwfs_Z7BXIG1c8ELW7kF3-YBY3-XRSL6FRmmIX1s8-xF6Xf3K5DekDInrUGxNNr4>
X-ME-Proxy-Cause: dmFkZTGvWhnto459E53WuY2K00WszEtru7HDBe9li38b6vh8/bBJRMbrw9yrq1z9zlTLVv
    LBBk4D37Ez+bOGhaRM6RtPzYUs6lK503SY/yVf0LYhAVbyUfFxsXpGCIeCMrf9g1X9n/GY
    Uu2ubeWsHayjIPcRCW+i3xYf93GiTgqU1/lHGPi7z72O39ZEBIF+L//vSKvFcpcqHS9OrI
    BqSOgfiD1dBGPyaVkQIRtpcq0S6hBKBaToUICFOsyDZP/UJhFLhuF5trY6Gc8iHKBrJAWF
    K5MdZU74W6mxFvzRF0o3xE03heFCmAxjVXhcKGliDnKBgCpjCT2GCE8kSHwsG86rgHw2dU
    c3IEtMFmj/nrpVSfrYzELCzlyFTOwF4Zm1RJiHWeYWUIPKN6Piasg2NhnCyj0yIvmu40iu
    pVXUp5E2475vAReNWlzon9cHsIW/Ybmr69/WGVpb907q9X0stoL/501cFcNEaNNurjnxYl
    arysiyImFY1JYrtpg+c9qNy9omPUwbnlJ5JCzBhtglfRmThHs1iryZv2OXL4ChxeF8StPe
    2PDt+zv/X7McyVW9HutqGJnkgoyafUMlGdNL8Oe5rkjC+PYl7a9v7dTJVR3qhTNgsTc/8h
    QdA7h4EUCmjSjDzcSAoE8Zr23MozjyWdma7sG6KlA8GEsv4uNHFk8nJcg5oQ
X-ME-Proxy: <xmx:3wwralrUj6EzeerHpGjBDIiEfkqFZfBp1vf1GeftSSt400mF51-Mjw>
    <xmx:3wwrai2E_aFAzNkFk3bx_5668zQVRsjV5msckq9Wa_vU1hbHyfezIQ>
    <xmx:3wwramAzZtmTsyaeqlqP1HAUadLVkznyUtzQMG-X-8Z0uo3c1ouExg>
    <xmx:3wwrarMl2d2fWl4U20cbzE8jOwKDOxhLenO7u9vgr6hfgnQf_Di0zA>
    <xmx:3wwraq1POBvL14FynP3rfy4JYOJO4FRMZbk4QKw13XeHJVyRMEBG2Y2P>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 15:30:38 -0400 (EDT)
From: Alice Mikityanska <alice.kernel@fastmail.im>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>
Subject: [PATCH net-next v7 04/11] net: Enable BIG TCP with partial GSO
Date: Thu, 11 Jun 2026 21:29:48 +0200
Message-ID: <20260611192955.604661-5-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611192955.604661-1-alice.kernel@fastmail.im>
References: <20260611192955.604661-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298315-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	FORGED_SENDER(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_FROM(0.00)[fastmail.im];
	FORGED_RECIPIENTS(0.00)[m:daniel@iogearbox.net,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:lucien.xin@gmail.com,m:willemdebruijn.kernel@gmail.com,m:willemb@google.com,m:dsahern@kernel.org,m:razor@blackwall.org,m:shuah@kernel.org,m:stfomichev@gmail.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:fw@strlen.de,m:netdev@vger.kernel.org,m:alice@isovalent.com,m:lucienxin@gmail.com,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,isovalent.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,messagingengine.com:dkim,fastmail.im:dkim,fastmail.im:mid,fastmail.im:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D94BD674BFE

From: Alice Mikityanska <alice@isovalent.com>

skb_segment is called for partial GSO, when netif_needs_gso returns true
in validate_xmit_skb. Partial GSO is needed, for example, when
segmentation of tunneled traffic is offloaded to a NIC that only
supports inner checksum offload.

Currently, skb_segment clamps the segment length to 65534 bytes, because
gso_size == 65535 is a special value GSO_BY_FRAGS, and we don't want
to accidentally assign mss = 65535, as it would fall into the
GSO_BY_FRAGS check further in the function.

This implementation, however, artificially blocks len > 65534, which is
possible since the introduction of BIG TCP. To allow bigger lengths and
avoid resegmentation of BIG TCP packets, store the gso_by_frags flag in
the beginning and don't use a special value of mss for this purpose
after mss was modified.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/netdevsim/psp.c |  2 +-
 net/core/skbuff.c           | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/netdevsim/psp.c b/drivers/net/netdevsim/psp.c
index d3e36c74be62..6b3532b5e360 100644
--- a/drivers/net/netdevsim/psp.c
+++ b/drivers/net/netdevsim/psp.c
@@ -92,7 +92,7 @@ nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
 		 * provide a valid checksum here, so the skb isn't dropped.
 		 */
 		uh = udp_hdr(skb);
-		udplen = ntohs(uh->len) ?: skb->len - skb_transport_offset(skb);
+		udplen = udp_get_len(skb, uh, skb_transport_offset(skb));
 		csum = skb_checksum(skb, skb_transport_offset(skb),
 				    udplen, 0);
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index c64693fcb2d1..5dcee79df8cf 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4773,6 +4773,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 	struct sk_buff *tail = NULL;
 	struct sk_buff *list_skb = skb_shinfo(head_skb)->frag_list;
 	unsigned int mss = skb_shinfo(head_skb)->gso_size;
+	bool gso_by_frags = mss == GSO_BY_FRAGS;
 	unsigned int doffset = head_skb->data - skb_mac_header(head_skb);
 	unsigned int offset = doffset;
 	unsigned int tnl_hlen = skb_tnl_header_len(head_skb);
@@ -4788,7 +4789,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 	int nfrags, pos;
 
 	if ((skb_shinfo(head_skb)->gso_type & SKB_GSO_DODGY) &&
-	    mss != GSO_BY_FRAGS && mss != skb_headlen(head_skb)) {
+	    !gso_by_frags && mss != skb_headlen(head_skb)) {
 		struct sk_buff *check_skb;
 
 		for (check_skb = list_skb; check_skb; check_skb = check_skb->next) {
@@ -4816,7 +4817,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 	sg = !!(features & NETIF_F_SG);
 	csum = !!can_checksum_protocol(features, proto);
 
-	if (sg && csum && (mss != GSO_BY_FRAGS))  {
+	if (sg && csum && !gso_by_frags)  {
 		if (!(features & NETIF_F_GSO_PARTIAL)) {
 			struct sk_buff *iter;
 			unsigned int frag_len;
@@ -4850,9 +4851,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 		/* GSO partial only requires that we trim off any excess that
 		 * doesn't fit into an MSS sized block, so take care of that
 		 * now.
-		 * Cap len to not accidentally hit GSO_BY_FRAGS.
 		 */
-		partial_segs = min(len, GSO_BY_FRAGS - 1) / mss;
+		partial_segs = len / mss;
 		if (partial_segs > 1)
 			mss *= partial_segs;
 		else
@@ -4876,7 +4876,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 		int hsize;
 		int size;
 
-		if (unlikely(mss == GSO_BY_FRAGS)) {
+		if (unlikely(gso_by_frags)) {
 			len = list_skb->len;
 		} else {
 			len = head_skb->len - offset;
-- 
2.54.0


