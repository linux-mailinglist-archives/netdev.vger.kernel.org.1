Return-Path: <netdev+bounces-299638-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B3RoK/p+MGpJTwUAu9opvQ
	(envelope-from <netdev+bounces-299638-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 00:38:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2C468A69C
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 00:38:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="mNh9cGY/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299638-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299638-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4ADDD302BFF2
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 22:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC853BB9F3;
	Mon, 15 Jun 2026 22:33:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05433BB116
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 22:33:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781562812; cv=none; b=Tp7tnAImObjF7spSiqKINCzXRUsOFo3ctAkBpGEQo+HGV/ieMaJdV9g66rZZBvdmPLE86E8UmFvocVkovefKckNXn8tFGKylHQxj+ZLYy3jOVb4KJ9VkUvpF6uwDXj+un1A9Y0XRy5W26573mkFEo7ZppDpukHl0J+xkyOrZFRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781562812; c=relaxed/simple;
	bh=YLz2A5iYqplxY8DklW7mIKsm+JW3y8cuMjvFy4l1ByE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eWU5b09TTBPAxAP2ejD7qa2gEjerRA8xnaLKgaSnR+MT9vydLhebnT8+QtWSF0BTigfPb6MjRfzkVTRCeQy/qfKzXzpIdPrNCZabRjvslAitNjrz5w5V+HmGyx79QVjYW533MPhH7Hmk26Nmwwzm5IdaxOM/FdA0lUPci1htWhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNh9cGY/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473CB1F000E9;
	Mon, 15 Jun 2026 22:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781562809;
	bh=mstl9fULBbjVCjCzZLG02EPgRR7jdIEc7vGO9ngHatc=;
	h=From:Date:Subject:To:Cc;
	b=mNh9cGY/9+1K6ihdOUtIPC5G+7ExSTVNOlAfNv1pvqmVjcnqizIyTL+7RQiNBdsXo
	 +k1X9h7Rr4souGGZ4rG/4cAC7CrR4rcMe3T3qM6PU7g/JM49EzFcDGDhci4CDUtMYh
	 PSVLqHe0QowoeQ0PPFA8V4XrksSzvhzit5E0A6stgOltr01fJmLsJ4U6aUcbBJ89N+
	 Kuao7keiZBMdtNG7aYVpFGtX5qyYxXoMwXDrJrHI794+A63wFFr7UJkN6eqO5Ay1Yg
	 m5KTJKfh9bnWhz3/YOPUwsdYu9sSkiNswrraCV6pSN2BG+XFRgfN5LT2QUX57tD3AL
	 QOALeYyGwFBIg==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 16 Jun 2026 00:33:00 +0200
Subject: [PATCH net] net: dsa: Fix skb ownership in taggers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-dsa-fix-free-skb-v1-1-fd30b35dcf66@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMwQrCMBBEf6XM2YVtDqH6K+KhSae6ClGyVYTSf
 zfq8c3w3gpnNToO3YrKl7ndS4N+1yFfxnKm2NQYQUPU2EeZfJTZ3jJXUvyWJCUNQ+ZeBw1o2qO
 y/b/kEYULTv/Rn+nKvHxj2LYPb6b5BnkAAAA=
X-Change-ID: 20260616-dsa-fix-free-skb-bb028ce90802
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Jonas Gorski <jonas.gorski@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, 
 Kurt Kanzenbach <kurt@linutronix.de>, 
 Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 "Chester A. Unal" <chester.a.unal@arinc9.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>, 
 George McCollister <george.mccollister@gmail.com>, 
 David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Sashiko AI Review <sashiko-bot@kernel.org>, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:florian.fainelli@broadcom.com,m:jonas.gorski@gmail.com,m:hauke@hauke-m.de,m:kurt@linutronix.de,m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:chester.a.unal@arinc9.com,m:daniel@makrotopia.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:wei.fang@nxp.com,m:xiaoning.wang@nxp.com,m:clement.leger@bootlin.com,m:george.mccollister@gmail.com,m:mmyangfl@gmail.com,m:netdev@vger.kernel.org,m:sashiko-bot@kernel.org,m:linusw@kernel.org,m:jonasgorski@gmail.com,m:matthiasbgg@gmail.com,m:georgemccollister@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,broadcom.com,hauke-m.de,linutronix.de,microchip.com,arinc9.com,makrotopia.org,collabora.com,nxp.com,bootlin.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-299638-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B2C468A69C

The tag_8021q.c tagger calls vlan_insert_tag() in dsa_8021q_xmit().
vlan_insert_tag() will consume the skb with kfree_skb() on failure
and return NULL.

When NULL is returned as error code to ->xmit() in dsa_user_xmit()
it will free the same skb again leading to a double-free.

The idea of dsa_user_xmit() and dsa_switch_rcv() dropping the skb
they held before the call to ->xmit() and ->rcv() is conceptually
wrong: the pattern elsewhere in the networking code is that consumers
drop their skb:s on failure.

Modify the ->xmit() and ->rcv() call sites to not drop the SKB if
the taggers return NULL from any of these calls. Move those drops into
the taggers so every callback error path that retains ownership consumes
the skb before returning NULL.

Keep the existing helper ownership rules: VLAN insertion helpers already
free on failure (this is the case in tag_8021q.c), while deferred
transmit paths either transfer the skb reference to worker context or
hold a worker reference with skb_get() and drop the caller's reference.

For SJA1105 meta RX, transfer the buffered stampable skb under the meta
lock and return NULL while the skb is waiting for its meta frame: the
skb is not dropped in this case.

Reported-by: Sashiko AI Review <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/20260610153952.1685895-1-kuba@kernel.org/
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Assisted-by: Codex:gpt-5-5
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 net/dsa/tag.c               |  4 +---
 net/dsa/tag_ar9331.c        | 10 ++++++++--
 net/dsa/tag_brcm.c          | 46 ++++++++++++++++++++++++++++++++-------------
 net/dsa/tag_dsa.c           | 15 ++++++++++++---
 net/dsa/tag_gswip.c         |  8 ++++++--
 net/dsa/tag_hellcreek.c     |  9 +++++++--
 net/dsa/tag_ksz.c           | 44 ++++++++++++++++++++++++++++++-------------
 net/dsa/tag_lan9303.c       |  2 ++
 net/dsa/tag_mtk.c           |  8 ++++++--
 net/dsa/tag_mxl-gsw1xx.c    |  3 +++
 net/dsa/tag_mxl862xx.c      |  3 +++
 net/dsa/tag_netc.c          | 15 ++++++++++++---
 net/dsa/tag_ocelot.c        |  4 +++-
 net/dsa/tag_ocelot_8021q.c  | 20 +++++++++++++-------
 net/dsa/tag_qca.c           | 14 +++++++++++---
 net/dsa/tag_rtl4_a.c        | 10 ++++++++--
 net/dsa/tag_rtl8_4.c        | 24 +++++++++++++++++------
 net/dsa/tag_rzn1_a5psw.c    | 10 ++++++++--
 net/dsa/tag_sja1105.c       | 42 ++++++++++++++++++++++++++---------------
 net/dsa/tag_trailer.c       | 16 ++++++++++++----
 net/dsa/tag_vsc73xx_8021q.c |  1 +
 net/dsa/tag_xrs700x.c       | 12 +++++++++---
 net/dsa/tag_yt921x.c        |  7 ++++++-
 net/dsa/user.c              |  7 +++----
 24 files changed, 243 insertions(+), 91 deletions(-)

diff --git a/net/dsa/tag.c b/net/dsa/tag.c
index 79ad105902d9..cfc8f5a0cbd9 100644
--- a/net/dsa/tag.c
+++ b/net/dsa/tag.c
@@ -84,10 +84,8 @@ static int dsa_switch_rcv(struct sk_buff *skb, struct net_device *dev,
 		nskb = cpu_dp->rcv(skb, dev);
 	}
 
-	if (!nskb) {
-		kfree_skb(skb);
+	if (!nskb)
 		return 0;
-	}
 
 	skb = nskb;
 	skb_push(skb, ETH_HLEN);
diff --git a/net/dsa/tag_ar9331.c b/net/dsa/tag_ar9331.c
index cbb588ca73aa..2e2388143b02 100644
--- a/net/dsa/tag_ar9331.c
+++ b/net/dsa/tag_ar9331.c
@@ -51,8 +51,10 @@ static struct sk_buff *ar9331_tag_rcv(struct sk_buff *skb,
 	u8 ver, port;
 	u16 hdr;
 
-	if (unlikely(!pskb_may_pull(skb, AR9331_HDR_LEN)))
+	if (unlikely(!pskb_may_pull(skb, AR9331_HDR_LEN))) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	hdr = le16_to_cpu(*(__le16 *)skb_mac_header(skb));
 
@@ -60,12 +62,14 @@ static struct sk_buff *ar9331_tag_rcv(struct sk_buff *skb,
 	if (unlikely(ver != AR9331_HDR_VERSION)) {
 		netdev_warn_once(ndev, "%s:%i wrong header version 0x%2x\n",
 				 __func__, __LINE__, hdr);
+		kfree_skb(skb);
 		return NULL;
 	}
 
 	if (unlikely(hdr & AR9331_HDR_FROM_CPU)) {
 		netdev_warn_once(ndev, "%s:%i packet should not be from cpu 0x%2x\n",
 				 __func__, __LINE__, hdr);
+		kfree_skb(skb);
 		return NULL;
 	}
 
@@ -75,8 +79,10 @@ static struct sk_buff *ar9331_tag_rcv(struct sk_buff *skb,
 	port = FIELD_GET(AR9331_HDR_PORT_NUM_MASK, hdr);
 
 	skb->dev = dsa_conduit_find_user(ndev, 0, port);
-	if (!skb->dev)
+	if (!skb->dev) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	return skb;
 }
diff --git a/net/dsa/tag_brcm.c b/net/dsa/tag_brcm.c
index cf9420439054..23f032b76190 100644
--- a/net/dsa/tag_brcm.c
+++ b/net/dsa/tag_brcm.c
@@ -102,10 +102,12 @@ static struct sk_buff *brcm_tag_xmit_ll(struct sk_buff *skb,
 	 * (including FCS and tag) because the length verification is done after
 	 * the Broadcom tag is stripped off the ingress packet.
 	 *
-	 * Let dsa_user_xmit() free the SKB
+	 * Free the SKB on error.
 	 */
-	if (__skb_put_padto(skb, ETH_ZLEN + BRCM_TAG_LEN, false))
+	if (__skb_put_padto(skb, ETH_ZLEN + BRCM_TAG_LEN, false)) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	skb_push(skb, BRCM_TAG_LEN);
 
@@ -151,27 +153,35 @@ static struct sk_buff *brcm_tag_rcv_ll(struct sk_buff *skb,
 	int source_port;
 	u8 *brcm_tag;
 
-	if (unlikely(!pskb_may_pull(skb, BRCM_TAG_LEN)))
+	if (unlikely(!pskb_may_pull(skb, BRCM_TAG_LEN))) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	brcm_tag = skb->data - offset;
 
 	/* The opcode should never be different than 0b000 */
-	if (unlikely((brcm_tag[0] >> BRCM_OPCODE_SHIFT) & BRCM_OPCODE_MASK))
+	if (unlikely((brcm_tag[0] >> BRCM_OPCODE_SHIFT) & BRCM_OPCODE_MASK)) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	/* We should never see a reserved reason code without knowing how to
 	 * handle it
 	 */
-	if (unlikely(brcm_tag[2] & BRCM_EG_RC_RSVD))
+	if (unlikely(brcm_tag[2] & BRCM_EG_RC_RSVD)) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	/* Locate which port this is coming from */
 	source_port = brcm_tag[3] & BRCM_EG_PID_MASK;
 
 	skb->dev = dsa_conduit_find_user(dev, 0, source_port);
-	if (!skb->dev)
+	if (!skb->dev) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	/* Remove Broadcom tag and update checksum */
 	skb_pull_rcsum(skb, BRCM_TAG_LEN);
@@ -228,8 +238,10 @@ static struct sk_buff *brcm_leg_tag_rcv(struct sk_buff *skb,
 	__be16 *proto;
 	u8 *brcm_tag;
 
-	if (unlikely(!pskb_may_pull(skb, BRCM_LEG_TAG_LEN + VLAN_HLEN)))
+	if (unlikely(!pskb_may_pull(skb, BRCM_LEG_TAG_LEN + VLAN_HLEN))) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	brcm_tag = dsa_etype_header_pos_rx(skb);
 	proto = (__be16 *)(brcm_tag + BRCM_LEG_TAG_LEN);
@@ -237,8 +249,10 @@ static struct sk_buff *brcm_leg_tag_rcv(struct sk_buff *skb,
 	source_port = brcm_tag[5] & BRCM_LEG_PORT_ID;
 
 	skb->dev = dsa_conduit_find_user(dev, 0, source_port);
-	if (!skb->dev)
+	if (!skb->dev) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	/* The internal switch in BCM63XX SoCs always tags on egress on the CPU
 	 * port. We use VID 0 internally for untagged traffic, so strip the tag
@@ -274,10 +288,12 @@ static struct sk_buff *brcm_leg_tag_xmit(struct sk_buff *skb,
 	 * (including FCS and tag) because the length verification is done after
 	 * the Broadcom tag is stripped off the ingress packet.
 	 *
-	 * Let dsa_user_xmit() free the SKB
+	 * Free the SKB on error.
 	 */
-	if (__skb_put_padto(skb, ETH_ZLEN + BRCM_LEG_TAG_LEN, false))
+	if (__skb_put_padto(skb, ETH_ZLEN + BRCM_LEG_TAG_LEN, false)) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	skb_push(skb, BRCM_LEG_TAG_LEN);
 
@@ -326,10 +342,12 @@ static struct sk_buff *brcm_leg_fcs_tag_xmit(struct sk_buff *skb,
 	 * and tag) because the length verification is done after the Broadcom
 	 * tag is stripped off the ingress packet.
 	 *
-	 * Let dsa_user_xmit() free the SKB.
+	 * Free the SKB on error.
 	 */
-	if (__skb_put_padto(skb, ETH_ZLEN + BRCM_LEG_TAG_LEN, false))
+	if (__skb_put_padto(skb, ETH_ZLEN + BRCM_LEG_TAG_LEN, false)) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	fcs_len = skb->len;
 	fcs_val = cpu_to_le32(crc32_le(~0, skb->data, fcs_len) ^ ~0);
@@ -351,8 +369,10 @@ static struct sk_buff *brcm_leg_fcs_tag_xmit(struct sk_buff *skb,
 	brcm_tag[5] = dp->index & BRCM_LEG_PORT_ID;
 
 	/* Original FCS value */
-	if (__skb_pad(skb, ETH_FCS_LEN, false))
+	if (__skb_pad(skb, ETH_FCS_LEN, false)) {
+		kfree_skb(skb);
 		return NULL;
+	}
 	skb_put_data(skb, &fcs_val, ETH_FCS_LEN);
 
 	return skb;
diff --git a/net/dsa/tag_dsa.c b/net/dsa/tag_dsa.c
index 2a2c4fb61a65..d5ffee35fbb5 100644
--- a/net/dsa/tag_dsa.c
+++ b/net/dsa/tag_dsa.c
@@ -224,6 +224,7 @@ static struct sk_buff *dsa_rcv_ll(struct sk_buff *skb, struct net_device *dev,
 			/* Remote management is not implemented yet,
 			 * drop.
 			 */
+			kfree_skb(skb);
 			return NULL;
 		case DSA_CODE_ARP_MIRROR:
 		case DSA_CODE_POLICY_MIRROR:
@@ -244,12 +245,14 @@ static struct sk_buff *dsa_rcv_ll(struct sk_buff *skb, struct net_device *dev,
 			/* Reserved code, this could be anything. Drop
 			 * seems like the safest option.
 			 */
+			kfree_skb(skb);
 			return NULL;
 		}
 
 		break;
 
 	default:
+		kfree_skb(skb);
 		return NULL;
 	}
 
@@ -271,8 +274,10 @@ static struct sk_buff *dsa_rcv_ll(struct sk_buff *skb, struct net_device *dev,
 						 source_port);
 	}
 
-	if (!skb->dev)
+	if (!skb->dev) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	/* When using LAG offload, skb->dev is not a DSA user interface,
 	 * so we cannot call dsa_default_offload_fwd_mark and we need to
@@ -335,8 +340,10 @@ static struct sk_buff *dsa_xmit(struct sk_buff *skb, struct net_device *dev)
 
 static struct sk_buff *dsa_rcv(struct sk_buff *skb, struct net_device *dev)
 {
-	if (unlikely(!pskb_may_pull(skb, DSA_HLEN)))
+	if (unlikely(!pskb_may_pull(skb, DSA_HLEN))) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	return dsa_rcv_ll(skb, dev, 0);
 }
@@ -375,8 +382,10 @@ static struct sk_buff *edsa_xmit(struct sk_buff *skb, struct net_device *dev)
 
 static struct sk_buff *edsa_rcv(struct sk_buff *skb, struct net_device *dev)
 {
-	if (unlikely(!pskb_may_pull(skb, EDSA_HLEN)))
+	if (unlikely(!pskb_may_pull(skb, EDSA_HLEN))) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	skb_pull_rcsum(skb, EDSA_HLEN - DSA_HLEN);
 
diff --git a/net/dsa/tag_gswip.c b/net/dsa/tag_gswip.c
index 5fa436121087..5c407d448c9f 100644
--- a/net/dsa/tag_gswip.c
+++ b/net/dsa/tag_gswip.c
@@ -80,16 +80,20 @@ static struct sk_buff *gswip_tag_rcv(struct sk_buff *skb,
 	int port;
 	u8 *gswip_tag;
 
-	if (unlikely(!pskb_may_pull(skb, GSWIP_RX_HEADER_LEN)))
+	if (unlikely(!pskb_may_pull(skb, GSWIP_RX_HEADER_LEN))) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	gswip_tag = skb->data - ETH_HLEN;
 
 	/* Get source port information */
 	port = (gswip_tag[7] & GSWIP_RX_SPPID_MASK) >> GSWIP_RX_SPPID_SHIFT;
 	skb->dev = dsa_conduit_find_user(dev, 0, port);
-	if (!skb->dev)
+	if (!skb->dev) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	/* remove GSWIP tag */
 	skb_pull_rcsum(skb, GSWIP_RX_HEADER_LEN);
diff --git a/net/dsa/tag_hellcreek.c b/net/dsa/tag_hellcreek.c
index 544ab15685a2..dd9f328f3182 100644
--- a/net/dsa/tag_hellcreek.c
+++ b/net/dsa/tag_hellcreek.c
@@ -27,8 +27,10 @@ static struct sk_buff *hellcreek_xmit(struct sk_buff *skb,
 	 * checksums after the switch strips the tag.
 	 */
 	if (skb->ip_summed == CHECKSUM_PARTIAL &&
-	    skb_checksum_help(skb))
+	    skb_checksum_help(skb)) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	/* Tag encoding */
 	tag  = skb_put(skb, HELLCREEK_TAG_LEN);
@@ -47,11 +49,14 @@ static struct sk_buff *hellcreek_rcv(struct sk_buff *skb,
 	skb->dev = dsa_conduit_find_user(dev, 0, port);
 	if (!skb->dev) {
 		netdev_warn_once(dev, "Failed to get source port: %d\n", port);
+		kfree_skb(skb);
 		return NULL;
 	}
 
-	if (pskb_trim_rcsum(skb, skb->len - HELLCREEK_TAG_LEN))
+	if (pskb_trim_rcsum(skb, skb->len - HELLCREEK_TAG_LEN)) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	dsa_default_offload_fwd_mark(skb);
 
diff --git a/net/dsa/tag_ksz.c b/net/dsa/tag_ksz.c
index d2475c3bbb7d..67fa89f102e0 100644
--- a/net/dsa/tag_ksz.c
+++ b/net/dsa/tag_ksz.c
@@ -88,11 +88,15 @@ static struct sk_buff *ksz_common_rcv(struct sk_buff *skb,
 				      unsigned int port, unsigned int len)
 {
 	skb->dev = dsa_conduit_find_user(dev, 0, port);
-	if (!skb->dev)
+	if (!skb->dev) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
-	if (pskb_trim_rcsum(skb, skb->len - len))
+	if (pskb_trim_rcsum(skb, skb->len - len)) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	dsa_default_offload_fwd_mark(skb);
 
@@ -123,8 +127,10 @@ static struct sk_buff *ksz8795_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct ethhdr *hdr;
 	u8 *tag;
 
-	if (skb->ip_summed == CHECKSUM_PARTIAL && skb_checksum_help(skb))
+	if (skb->ip_summed == CHECKSUM_PARTIAL && skb_checksum_help(skb)) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	/* Tag encoding */
 	tag = skb_put(skb, KSZ_INGRESS_TAG_LEN);
@@ -141,8 +147,10 @@ static struct sk_buff *ksz8795_rcv(struct sk_buff *skb, struct net_device *dev)
 {
 	u8 *tag;
 
-	if (skb_linearize(skb))
+	if (skb_linearize(skb)) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
 
@@ -255,22 +263,24 @@ static struct sk_buff *ksz_defer_xmit(struct dsa_port *dp, struct sk_buff *skb)
 	xmit_work_fn = tagger_data->xmit_work_fn;
 	xmit_worker = priv->xmit_worker;
 
-	if (!xmit_work_fn || !xmit_worker)
+	if (!xmit_work_fn || !xmit_worker) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	xmit_work = kzalloc_obj(*xmit_work, GFP_ATOMIC);
-	if (!xmit_work)
+	if (!xmit_work) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	kthread_init_work(&xmit_work->work, xmit_work_fn);
-	/* Increase refcount so the kfree_skb in dsa_user_xmit
-	 * won't really free the packet.
-	 */
 	xmit_work->dp = dp;
 	xmit_work->skb = skb_get(skb);
 
 	kthread_queue_work(xmit_worker, &xmit_work->work);
 
+	kfree_skb(skb);
 	return NULL;
 }
 
@@ -284,8 +294,10 @@ static struct sk_buff *ksz9477_xmit(struct sk_buff *skb,
 	__be16 *tag;
 	u16 val;
 
-	if (skb->ip_summed == CHECKSUM_PARTIAL && skb_checksum_help(skb))
+	if (skb->ip_summed == CHECKSUM_PARTIAL && skb_checksum_help(skb)) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	/* Tag encoding */
 	ksz_xmit_timestamp(dp, skb);
@@ -310,8 +322,10 @@ static struct sk_buff *ksz9477_rcv(struct sk_buff *skb, struct net_device *dev)
 	unsigned int port;
 	u8 *tag;
 
-	if (skb_linearize(skb))
+	if (skb_linearize(skb)) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	/* Tag decoding */
 	tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
@@ -352,8 +366,10 @@ static struct sk_buff *ksz9893_xmit(struct sk_buff *skb,
 	struct ethhdr *hdr;
 	u8 *tag;
 
-	if (skb->ip_summed == CHECKSUM_PARTIAL && skb_checksum_help(skb))
+	if (skb->ip_summed == CHECKSUM_PARTIAL && skb_checksum_help(skb)) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	/* Tag encoding */
 	ksz_xmit_timestamp(dp, skb);
@@ -418,8 +434,10 @@ static struct sk_buff *lan937x_xmit(struct sk_buff *skb,
 	__be16 *tag;
 	u16 val;
 
-	if (skb->ip_summed == CHECKSUM_PARTIAL && skb_checksum_help(skb))
+	if (skb->ip_summed == CHECKSUM_PARTIAL && skb_checksum_help(skb)) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	ksz_xmit_timestamp(dp, skb);
 
diff --git a/net/dsa/tag_lan9303.c b/net/dsa/tag_lan9303.c
index 258e5d7dc5ef..d1194696499a 100644
--- a/net/dsa/tag_lan9303.c
+++ b/net/dsa/tag_lan9303.c
@@ -85,6 +85,7 @@ static struct sk_buff *lan9303_rcv(struct sk_buff *skb, struct net_device *dev)
 	if (unlikely(!pskb_may_pull(skb, LAN9303_TAG_LEN))) {
 		dev_warn_ratelimited(&dev->dev,
 				     "Dropping packet, cannot pull\n");
+		kfree_skb(skb);
 		return NULL;
 	}
 
@@ -102,6 +103,7 @@ static struct sk_buff *lan9303_rcv(struct sk_buff *skb, struct net_device *dev)
 	skb->dev = dsa_conduit_find_user(dev, 0, source_port);
 	if (!skb->dev) {
 		dev_warn_ratelimited(&dev->dev, "Dropping packet due to invalid source port\n");
+		kfree_skb(skb);
 		return NULL;
 	}
 
diff --git a/net/dsa/tag_mtk.c b/net/dsa/tag_mtk.c
index dea3eecaf093..c7dc7731675e 100644
--- a/net/dsa/tag_mtk.c
+++ b/net/dsa/tag_mtk.c
@@ -72,8 +72,10 @@ static struct sk_buff *mtk_tag_rcv(struct sk_buff *skb, struct net_device *dev)
 	int port;
 	__be16 *phdr;
 
-	if (unlikely(!pskb_may_pull(skb, MTK_HDR_LEN)))
+	if (unlikely(!pskb_may_pull(skb, MTK_HDR_LEN))) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	phdr = dsa_etype_header_pos_rx(skb);
 	hdr = ntohs(*phdr);
@@ -87,8 +89,10 @@ static struct sk_buff *mtk_tag_rcv(struct sk_buff *skb, struct net_device *dev)
 	port = (hdr & MTK_HDR_RECV_SOURCE_PORT_MASK);
 
 	skb->dev = dsa_conduit_find_user(dev, 0, port);
-	if (!skb->dev)
+	if (!skb->dev) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	dsa_default_offload_fwd_mark(skb);
 
diff --git a/net/dsa/tag_mxl-gsw1xx.c b/net/dsa/tag_mxl-gsw1xx.c
index 60f7c445e656..4b1b6ef94196 100644
--- a/net/dsa/tag_mxl-gsw1xx.c
+++ b/net/dsa/tag_mxl-gsw1xx.c
@@ -73,6 +73,7 @@ static struct sk_buff *gsw1xx_tag_rcv(struct sk_buff *skb,
 
 	if (unlikely(!pskb_may_pull(skb, GSW1XX_HEADER_LEN))) {
 		dev_warn_ratelimited(&dev->dev, "Dropping packet, cannot pull SKB\n");
+		kfree_skb(skb);
 		return NULL;
 	}
 
@@ -81,6 +82,7 @@ static struct sk_buff *gsw1xx_tag_rcv(struct sk_buff *skb,
 	if (unlikely(ntohs(gsw1xx_tag[0]) != ETH_P_MXLGSW)) {
 		dev_warn_ratelimited(&dev->dev, "Dropping packet due to invalid special tag\n");
 		dev_warn_ratelimited(&dev->dev, "Tag: %8ph\n", gsw1xx_tag);
+		kfree_skb(skb);
 		return NULL;
 	}
 
@@ -90,6 +92,7 @@ static struct sk_buff *gsw1xx_tag_rcv(struct sk_buff *skb,
 	if (!skb->dev) {
 		dev_warn_ratelimited(&dev->dev, "Dropping packet due to invalid source port\n");
 		dev_warn_ratelimited(&dev->dev, "Tag: %8ph\n", gsw1xx_tag);
+		kfree_skb(skb);
 		return NULL;
 	}
 
diff --git a/net/dsa/tag_mxl862xx.c b/net/dsa/tag_mxl862xx.c
index 8daefeb8d49d..87b80ddf0946 100644
--- a/net/dsa/tag_mxl862xx.c
+++ b/net/dsa/tag_mxl862xx.c
@@ -64,6 +64,7 @@ static struct sk_buff *mxl862_tag_rcv(struct sk_buff *skb,
 
 	if (unlikely(!pskb_may_pull(skb, MXL862_HEADER_LEN))) {
 		dev_warn_ratelimited(&dev->dev, "Cannot pull SKB, packet dropped\n");
+		kfree_skb(skb);
 		return NULL;
 	}
 
@@ -73,6 +74,7 @@ static struct sk_buff *mxl862_tag_rcv(struct sk_buff *skb,
 		dev_warn_ratelimited(&dev->dev,
 				     "Invalid special tag marker, packet dropped, tag: %8ph\n",
 				     mxl862_tag);
+		kfree_skb(skb);
 		return NULL;
 	}
 
@@ -83,6 +85,7 @@ static struct sk_buff *mxl862_tag_rcv(struct sk_buff *skb,
 		dev_warn_ratelimited(&dev->dev,
 				     "Invalid source port, packet dropped, tag: %8ph\n",
 				     mxl862_tag);
+		kfree_skb(skb);
 		return NULL;
 	}
 
diff --git a/net/dsa/tag_netc.c b/net/dsa/tag_netc.c
index ccedfe3a80b6..b1bc67e28866 100644
--- a/net/dsa/tag_netc.c
+++ b/net/dsa/tag_netc.c
@@ -130,14 +130,17 @@ static struct sk_buff *netc_rcv(struct sk_buff *skb,
 	int tag_len, sw_id, port;
 	int type, subtype;
 
-	if (unlikely(!pskb_may_pull(skb, NETC_TAG_MAX_LEN)))
+	if (unlikely(!pskb_may_pull(skb, NETC_TAG_MAX_LEN))) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	tag_cmn = dsa_etype_header_pos_rx(skb);
 	if (ntohs(tag_cmn->tpid) != ETH_P_NXP_NETC) {
 		dev_warn_ratelimited(&ndev->dev, "Unknown TPID 0x%04x\n",
 				     ntohs(tag_cmn->tpid));
 
+		kfree_skb(skb);
 		return NULL;
 	}
 
@@ -150,13 +153,16 @@ static struct sk_buff *netc_rcv(struct sk_buff *skb,
 		dev_warn_ratelimited(&ndev->dev,
 				     "VEPA switch ID is not supported yet\n");
 
+		kfree_skb(skb);
 		return NULL;
 	}
 
 	port = FIELD_GET(NETC_TAG_PORT, tag_cmn->switch_port);
 	skb->dev = dsa_conduit_find_user(ndev, sw_id, port);
-	if (!skb->dev)
+	if (!skb->dev) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	type = FIELD_GET(NETC_TAG_TYPE, tag_cmn->type);
 	subtype = FIELD_GET(NETC_TAG_SUBTYPE, tag_cmn->type);
@@ -164,11 +170,14 @@ static struct sk_buff *netc_rcv(struct sk_buff *skb,
 		dsa_default_offload_fwd_mark(skb);
 	} else if (type == NETC_TAG_TO_HOST) {
 		/* Currently only subtype0 supported */
-		if (subtype != NETC_TAG_TH_SUBTYPE0)
+		if (subtype != NETC_TAG_TH_SUBTYPE0) {
+			kfree_skb(skb);
 			return NULL;
+		}
 	} else {
 		dev_warn_ratelimited(&ndev->dev,
 				     "Unexpected  tag type %d\n", type);
+		kfree_skb(skb);
 		return NULL;
 	}
 
diff --git a/net/dsa/tag_ocelot.c b/net/dsa/tag_ocelot.c
index 3405def79c2d..d208c7322cd6 100644
--- a/net/dsa/tag_ocelot.c
+++ b/net/dsa/tag_ocelot.c
@@ -107,14 +107,16 @@ static struct sk_buff *ocelot_rcv(struct sk_buff *skb,
 	ocelot_xfh_get_rew_val(extraction, &rew_val);
 
 	skb->dev = dsa_conduit_find_user(netdev, 0, src_port);
-	if (!skb->dev)
+	if (!skb->dev) {
 		/* The switch will reflect back some frames sent through
 		 * sockets opened on the bare DSA conduit. These will come back
 		 * with src_port equal to the index of the CPU port, for which
 		 * there is no user registered. So don't print any error
 		 * message here (ignore and drop those frames).
 		 */
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	dsa_default_offload_fwd_mark(skb);
 	skb->priority = qos_class;
diff --git a/net/dsa/tag_ocelot_8021q.c b/net/dsa/tag_ocelot_8021q.c
index e89d9254e90a..f50f1cd83f16 100644
--- a/net/dsa/tag_ocelot_8021q.c
+++ b/net/dsa/tag_ocelot_8021q.c
@@ -33,30 +33,34 @@ static struct sk_buff *ocelot_defer_xmit(struct dsa_port *dp,
 	xmit_work_fn = data->xmit_work_fn;
 	xmit_worker = priv->xmit_worker;
 
-	if (!xmit_work_fn || !xmit_worker)
+	if (!xmit_work_fn || !xmit_worker) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	/* PTP over IP packets need UDP checksumming. We may have inherited
 	 * NETIF_F_HW_CSUM from the DSA conduit, but these packets are not sent
 	 * through the DSA conduit, so calculate the checksum here.
 	 */
-	if (skb->ip_summed == CHECKSUM_PARTIAL && skb_checksum_help(skb))
+	if (skb->ip_summed == CHECKSUM_PARTIAL && skb_checksum_help(skb)) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	xmit_work = kzalloc_obj(*xmit_work, GFP_ATOMIC);
-	if (!xmit_work)
+	if (!xmit_work) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	/* Calls felix_port_deferred_xmit in felix.c */
 	kthread_init_work(&xmit_work->work, xmit_work_fn);
-	/* Increase refcount so the kfree_skb in dsa_user_xmit
-	 * won't really free the packet.
-	 */
 	xmit_work->dp = dp;
 	xmit_work->skb = skb_get(skb);
 
 	kthread_queue_work(xmit_worker, &xmit_work->work);
 
+	kfree_skb(skb);
 	return NULL;
 }
 
@@ -84,8 +88,10 @@ static struct sk_buff *ocelot_rcv(struct sk_buff *skb,
 	dsa_8021q_rcv(skb, &src_port, &switch_id, NULL, NULL);
 
 	skb->dev = dsa_conduit_find_user(netdev, switch_id, src_port);
-	if (!skb->dev)
+	if (!skb->dev) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	dsa_default_offload_fwd_mark(skb);
 
diff --git a/net/dsa/tag_qca.c b/net/dsa/tag_qca.c
index 9e3b429e8b36..510792fbfa92 100644
--- a/net/dsa/tag_qca.c
+++ b/net/dsa/tag_qca.c
@@ -46,16 +46,20 @@ static struct sk_buff *qca_tag_rcv(struct sk_buff *skb, struct net_device *dev)
 
 	tagger_data = ds->tagger_data;
 
-	if (unlikely(!pskb_may_pull(skb, QCA_HDR_LEN)))
+	if (unlikely(!pskb_may_pull(skb, QCA_HDR_LEN))) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	phdr = dsa_etype_header_pos_rx(skb);
 	hdr = ntohs(*phdr);
 
 	/* Make sure the version is correct */
 	ver = FIELD_GET(QCA_HDR_RECV_VERSION, hdr);
-	if (unlikely(ver != QCA_HDR_VERSION))
+	if (unlikely(ver != QCA_HDR_VERSION)) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	/* Get pk type */
 	pk_type = FIELD_GET(QCA_HDR_RECV_TYPE, hdr);
@@ -64,6 +68,7 @@ static struct sk_buff *qca_tag_rcv(struct sk_buff *skb, struct net_device *dev)
 	if (pk_type == QCA_HDR_RECV_TYPE_RW_REG_ACK) {
 		if (likely(tagger_data->rw_reg_ack_handler))
 			tagger_data->rw_reg_ack_handler(ds, skb);
+		kfree_skb(skb);
 		return NULL;
 	}
 
@@ -71,6 +76,7 @@ static struct sk_buff *qca_tag_rcv(struct sk_buff *skb, struct net_device *dev)
 	if (pk_type == QCA_HDR_RECV_TYPE_MIB) {
 		if (likely(tagger_data->mib_autocast_handler))
 			tagger_data->mib_autocast_handler(ds, skb);
+		kfree_skb(skb);
 		return NULL;
 	}
 
@@ -78,8 +84,10 @@ static struct sk_buff *qca_tag_rcv(struct sk_buff *skb, struct net_device *dev)
 	port = FIELD_GET(QCA_HDR_RECV_SOURCE_PORT, hdr);
 
 	skb->dev = dsa_conduit_find_user(dev, 0, port);
-	if (!skb->dev)
+	if (!skb->dev) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	/* Remove QCA tag and recalculate checksum */
 	skb_pull_rcsum(skb, QCA_HDR_LEN);
diff --git a/net/dsa/tag_rtl4_a.c b/net/dsa/tag_rtl4_a.c
index 3cc63eacfa03..9805c56025de 100644
--- a/net/dsa/tag_rtl4_a.c
+++ b/net/dsa/tag_rtl4_a.c
@@ -41,8 +41,10 @@ static struct sk_buff *rtl4a_tag_xmit(struct sk_buff *skb,
 	u16 out;
 
 	/* Pad out to at least 60 bytes */
-	if (unlikely(__skb_put_padto(skb, ETH_ZLEN, false)))
+	if (unlikely(__skb_put_padto(skb, ETH_ZLEN, false))) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	netdev_dbg(dev, "add realtek tag to package to port %d\n",
 		   dp->index);
@@ -75,8 +77,10 @@ static struct sk_buff *rtl4a_tag_rcv(struct sk_buff *skb,
 	u8 prot;
 	u8 port;
 
-	if (unlikely(!pskb_may_pull(skb, RTL4_A_HDR_LEN)))
+	if (unlikely(!pskb_may_pull(skb, RTL4_A_HDR_LEN))) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	tag = dsa_etype_header_pos_rx(skb);
 	p = (__be16 *)tag;
@@ -92,6 +96,7 @@ static struct sk_buff *rtl4a_tag_rcv(struct sk_buff *skb,
 	prot = (protport >> RTL4_A_PROTOCOL_SHIFT) & 0x0f;
 	if (prot != RTL4_A_PROTOCOL_RTL8366RB) {
 		netdev_err(dev, "unknown realtek protocol 0x%01x\n", prot);
+		kfree_skb(skb);
 		return NULL;
 	}
 	port = protport & 0xff;
@@ -99,6 +104,7 @@ static struct sk_buff *rtl4a_tag_rcv(struct sk_buff *skb,
 	skb->dev = dsa_conduit_find_user(dev, 0, port);
 	if (!skb->dev) {
 		netdev_dbg(dev, "could not find user for port %d\n", port);
+		kfree_skb(skb);
 		return NULL;
 	}
 
diff --git a/net/dsa/tag_rtl8_4.c b/net/dsa/tag_rtl8_4.c
index 852c6b88079a..4da3beebef75 100644
--- a/net/dsa/tag_rtl8_4.c
+++ b/net/dsa/tag_rtl8_4.c
@@ -143,8 +143,10 @@ static struct sk_buff *rtl8_4t_tag_xmit(struct sk_buff *skb,
 	/* Calculate the checksum here if not done yet as trailing tags will
 	 * break either software or hardware based checksum
 	 */
-	if (skb->ip_summed == CHECKSUM_PARTIAL && skb_checksum_help(skb))
+	if (skb->ip_summed == CHECKSUM_PARTIAL && skb_checksum_help(skb)) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	rtl8_4_write_tag(skb, dev, skb_put(skb, RTL8_4_TAG_LEN));
 
@@ -201,11 +203,15 @@ static int rtl8_4_read_tag(struct sk_buff *skb, struct net_device *dev,
 static struct sk_buff *rtl8_4_tag_rcv(struct sk_buff *skb,
 				      struct net_device *dev)
 {
-	if (unlikely(!pskb_may_pull(skb, RTL8_4_TAG_LEN)))
+	if (unlikely(!pskb_may_pull(skb, RTL8_4_TAG_LEN))) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
-	if (unlikely(rtl8_4_read_tag(skb, dev, dsa_etype_header_pos_rx(skb))))
+	if (unlikely(rtl8_4_read_tag(skb, dev, dsa_etype_header_pos_rx(skb)))) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	/* Remove tag and recalculate checksum */
 	skb_pull_rcsum(skb, RTL8_4_TAG_LEN);
@@ -218,14 +224,20 @@ static struct sk_buff *rtl8_4_tag_rcv(struct sk_buff *skb,
 static struct sk_buff *rtl8_4t_tag_rcv(struct sk_buff *skb,
 				       struct net_device *dev)
 {
-	if (skb_linearize(skb))
+	if (skb_linearize(skb)) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
-	if (unlikely(rtl8_4_read_tag(skb, dev, skb_tail_pointer(skb) - RTL8_4_TAG_LEN)))
+	if (unlikely(rtl8_4_read_tag(skb, dev, skb_tail_pointer(skb) - RTL8_4_TAG_LEN))) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
-	if (pskb_trim_rcsum(skb, skb->len - RTL8_4_TAG_LEN))
+	if (pskb_trim_rcsum(skb, skb->len - RTL8_4_TAG_LEN)) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	return skb;
 }
diff --git a/net/dsa/tag_rzn1_a5psw.c b/net/dsa/tag_rzn1_a5psw.c
index 10994b3470f6..f66f52f5d2a5 100644
--- a/net/dsa/tag_rzn1_a5psw.c
+++ b/net/dsa/tag_rzn1_a5psw.c
@@ -48,8 +48,10 @@ static struct sk_buff *a5psw_tag_xmit(struct sk_buff *skb, struct net_device *de
 	 * least 60 bytes otherwise they will be discarded when they enter the
 	 * switch port logic.
 	 */
-	if (__skb_put_padto(skb, ETH_ZLEN, false))
+	if (__skb_put_padto(skb, ETH_ZLEN, false)) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	/* provide 'A5PSW_TAG_LEN' bytes additional space */
 	skb_push(skb, A5PSW_TAG_LEN);
@@ -77,6 +79,7 @@ static struct sk_buff *a5psw_tag_rcv(struct sk_buff *skb,
 	if (unlikely(!pskb_may_pull(skb, A5PSW_TAG_LEN))) {
 		dev_warn_ratelimited(&dev->dev,
 				     "Dropping packet, cannot pull\n");
+		kfree_skb(skb);
 		return NULL;
 	}
 
@@ -84,14 +87,17 @@ static struct sk_buff *a5psw_tag_rcv(struct sk_buff *skb,
 
 	if (tag->ctrl_tag != htons(ETH_P_DSA_A5PSW)) {
 		dev_warn_ratelimited(&dev->dev, "Dropping packet due to invalid TAG marker\n");
+		kfree_skb(skb);
 		return NULL;
 	}
 
 	port = FIELD_GET(A5PSW_CTRL_DATA_PORT, ntohs(tag->ctrl_data));
 
 	skb->dev = dsa_conduit_find_user(dev, 0, port);
-	if (!skb->dev)
+	if (!skb->dev) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	skb_pull_rcsum(skb, A5PSW_TAG_LEN);
 	dsa_strip_etype_header(skb, A5PSW_TAG_LEN);
diff --git a/net/dsa/tag_sja1105.c b/net/dsa/tag_sja1105.c
index de6d4ce8668b..bfe1f746f55b 100644
--- a/net/dsa/tag_sja1105.c
+++ b/net/dsa/tag_sja1105.c
@@ -149,19 +149,20 @@ static struct sk_buff *sja1105_defer_xmit(struct dsa_port *dp,
 	xmit_work_fn = tagger_data->xmit_work_fn;
 	xmit_worker = priv->xmit_worker;
 
-	if (!xmit_work_fn || !xmit_worker)
+	if (!xmit_work_fn || !xmit_worker) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	xmit_work = kzalloc_obj(*xmit_work, GFP_ATOMIC);
-	if (!xmit_work)
+	if (!xmit_work) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	kthread_init_work(&xmit_work->work, xmit_work_fn);
-	/* Increase refcount so the kfree_skb in dsa_user_xmit
-	 * won't really free the packet.
-	 */
 	xmit_work->dp = dp;
-	xmit_work->skb = skb_get(skb);
+	xmit_work->skb = skb;
 
 	kthread_queue_work(xmit_worker, &xmit_work->work);
 
@@ -401,10 +402,7 @@ static struct sk_buff
 			kfree_skb(priv->stampable_skb);
 		}
 
-		/* Hold a reference to avoid dsa_switch_rcv
-		 * from freeing the skb.
-		 */
-		priv->stampable_skb = skb_get(skb);
+		priv->stampable_skb = skb;
 		spin_unlock(&priv->meta_lock);
 
 		/* Tell DSA we got nothing */
@@ -436,6 +434,7 @@ static struct sk_buff
 			dev_err_ratelimited(ds->dev,
 					    "Unexpected meta frame\n");
 			spin_unlock(&priv->meta_lock);
+			kfree_skb(skb);
 			return NULL;
 		}
 
@@ -443,6 +442,7 @@ static struct sk_buff
 			dev_err_ratelimited(ds->dev,
 					    "Meta frame on wrong port\n");
 			spin_unlock(&priv->meta_lock);
+			kfree_skb(skb);
 			return NULL;
 		}
 
@@ -501,18 +501,21 @@ static struct sk_buff *sja1105_rcv(struct sk_buff *skb,
 	/* Normal data plane traffic and link-local frames are tagged with
 	 * a tag_8021q VLAN which we have to strip
 	 */
-	if (sja1105_skb_has_tag_8021q(skb))
+	if (sja1105_skb_has_tag_8021q(skb)) {
 		dsa_8021q_rcv(skb, &source_port, &switch_id, &vbid, &vid);
-	else if (source_port == -1 && switch_id == -1)
+	} else if (source_port == -1 && switch_id == -1) {
 		/* Packets with no source information have no chance of
 		 * getting accepted, drop them straight away.
 		 */
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	skb->dev = dsa_tag_8021q_find_user(netdev, source_port, switch_id,
 					   vid, vbid);
 	if (!skb->dev) {
 		netdev_warn(netdev, "Couldn't decode source port\n");
+		kfree_skb(skb);
 		return NULL;
 	}
 
@@ -539,12 +542,15 @@ static struct sk_buff *sja1110_rcv_meta(struct sk_buff *skb, u16 rx_header)
 	if (!ds) {
 		net_err_ratelimited("%s: cannot find switch id %d\n",
 				    conduit->name, switch_id);
+		kfree_skb(skb);
 		return NULL;
 	}
 
 	tagger_data = sja1105_tagger_data(ds);
-	if (!tagger_data->meta_tstamp_handler)
+	if (!tagger_data->meta_tstamp_handler) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	for (i = 0; i <= n_ts; i++) {
 		u8 ts_id, source_port, dir;
@@ -562,6 +568,7 @@ static struct sk_buff *sja1110_rcv_meta(struct sk_buff *skb, u16 rx_header)
 	}
 
 	/* Discard the meta frame, we've consumed the timestamps it contained */
+	kfree_skb(skb);
 	return NULL;
 }
 
@@ -572,8 +579,10 @@ static struct sk_buff *sja1110_rcv_inband_control_extension(struct sk_buff *skb,
 {
 	u16 rx_header;
 
-	if (unlikely(!pskb_may_pull(skb, SJA1110_HEADER_LEN)))
+	if (unlikely(!pskb_may_pull(skb, SJA1110_HEADER_LEN))) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	/* skb->data points to skb_mac_header(skb) + ETH_HLEN, which is exactly
 	 * what we need because the caller has checked the EtherType (which is
@@ -609,8 +618,10 @@ static struct sk_buff *sja1110_rcv_inband_control_extension(struct sk_buff *skb,
 		 * padding and trailer we need to account for the fact that
 		 * skb->data points to skb_mac_header(skb) + ETH_HLEN.
 		 */
-		if (pskb_trim_rcsum(skb, start_of_padding - ETH_HLEN))
+		if (pskb_trim_rcsum(skb, start_of_padding - ETH_HLEN)) {
+			kfree_skb(skb);
 			return NULL;
+		}
 	/* Trap-to-host frame, no timestamp trailer */
 	} else {
 		*source_port = SJA1110_RX_HEADER_SRC_PORT(rx_header);
@@ -653,6 +664,7 @@ static struct sk_buff *sja1110_rcv(struct sk_buff *skb,
 
 	if (!skb->dev) {
 		netdev_warn(netdev, "Couldn't decode source port\n");
+		kfree_skb(skb);
 		return NULL;
 	}
 
diff --git a/net/dsa/tag_trailer.c b/net/dsa/tag_trailer.c
index 4dce24cfe6a7..49c802c10ca6 100644
--- a/net/dsa/tag_trailer.c
+++ b/net/dsa/tag_trailer.c
@@ -30,22 +30,30 @@ static struct sk_buff *trailer_rcv(struct sk_buff *skb, struct net_device *dev)
 	u8 *trailer;
 	int source_port;
 
-	if (skb_linearize(skb))
+	if (skb_linearize(skb)) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	trailer = skb_tail_pointer(skb) - 4;
 	if (trailer[0] != 0x80 || (trailer[1] & 0xf8) != 0x00 ||
-	    (trailer[2] & 0xef) != 0x00 || trailer[3] != 0x00)
+	    (trailer[2] & 0xef) != 0x00 || trailer[3] != 0x00) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	source_port = trailer[1] & 7;
 
 	skb->dev = dsa_conduit_find_user(dev, 0, source_port);
-	if (!skb->dev)
+	if (!skb->dev) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
-	if (pskb_trim_rcsum(skb, skb->len - 4))
+	if (pskb_trim_rcsum(skb, skb->len - 4)) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	return skb;
 }
diff --git a/net/dsa/tag_vsc73xx_8021q.c b/net/dsa/tag_vsc73xx_8021q.c
index af121a9aff7f..f4736a1a7a0f 100644
--- a/net/dsa/tag_vsc73xx_8021q.c
+++ b/net/dsa/tag_vsc73xx_8021q.c
@@ -44,6 +44,7 @@ vsc73xx_rcv(struct sk_buff *skb, struct net_device *netdev)
 	if (!skb->dev) {
 		dev_warn_ratelimited(&netdev->dev,
 				     "Couldn't decode source port\n");
+		kfree_skb(skb);
 		return NULL;
 	}
 
diff --git a/net/dsa/tag_xrs700x.c b/net/dsa/tag_xrs700x.c
index a05219f702c6..bb268020ee86 100644
--- a/net/dsa/tag_xrs700x.c
+++ b/net/dsa/tag_xrs700x.c
@@ -30,15 +30,21 @@ static struct sk_buff *xrs700x_rcv(struct sk_buff *skb, struct net_device *dev)
 
 	source_port = ffs((int)trailer[0]) - 1;
 
-	if (source_port < 0)
+	if (source_port < 0) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	skb->dev = dsa_conduit_find_user(dev, 0, source_port);
-	if (!skb->dev)
+	if (!skb->dev) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
-	if (pskb_trim_rcsum(skb, skb->len - 1))
+	if (pskb_trim_rcsum(skb, skb->len - 1)) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	/* Frame is forwarded by hardware, don't forward in software. */
 	dsa_default_offload_fwd_mark(skb);
diff --git a/net/dsa/tag_yt921x.c b/net/dsa/tag_yt921x.c
index f3ced99b1c85..294784ab6694 100644
--- a/net/dsa/tag_yt921x.c
+++ b/net/dsa/tag_yt921x.c
@@ -87,8 +87,10 @@ yt921x_tag_rcv(struct sk_buff *skb, struct net_device *netdev)
 	__be16 *tag;
 	u16 rx;
 
-	if (unlikely(!pskb_may_pull(skb, YT921X_TAG_LEN)))
+	if (unlikely(!pskb_may_pull(skb, YT921X_TAG_LEN))) {
+		kfree_skb(skb);
 		return NULL;
+	}
 
 	tag = dsa_etype_header_pos_rx(skb);
 
@@ -96,6 +98,7 @@ yt921x_tag_rcv(struct sk_buff *skb, struct net_device *netdev)
 		dev_warn_ratelimited(&netdev->dev,
 				     "Unexpected EtherType 0x%04x\n",
 				     ntohs(tag[0]));
+		kfree_skb(skb);
 		return NULL;
 	}
 
@@ -104,6 +107,7 @@ yt921x_tag_rcv(struct sk_buff *skb, struct net_device *netdev)
 	if (unlikely((rx & YT921X_TAG_PORT_EN) == 0)) {
 		dev_warn_ratelimited(&netdev->dev,
 				     "Unexpected rx tag 0x%04x\n", rx);
+		kfree_skb(skb);
 		return NULL;
 	}
 
@@ -112,6 +116,7 @@ yt921x_tag_rcv(struct sk_buff *skb, struct net_device *netdev)
 	if (unlikely(!skb->dev)) {
 		dev_warn_ratelimited(&netdev->dev,
 				     "Couldn't decode source port %u\n", port);
+		kfree_skb(skb);
 		return NULL;
 	}
 
diff --git a/net/dsa/user.c b/net/dsa/user.c
index 8704c1a3a5b7..072fa76972cc 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -935,13 +935,12 @@ static netdev_tx_t dsa_user_xmit(struct sk_buff *skb, struct net_device *dev)
 		eth_skb_pad(skb);
 
 	/* Transmit function may have to reallocate the original SKB,
-	 * in which case it must have freed it. Only free it here on error.
+	 * in which case it must have freed it. Taggers will drop the
+	 * passed skb on error.
 	 */
 	nskb = p->xmit(skb, dev);
-	if (!nskb) {
-		kfree_skb(skb);
+	if (!nskb)
 		return NETDEV_TX_OK;
-	}
 
 	return dsa_enqueue_skb(nskb, dev);
 }

---
base-commit: f34c6b3a3c3d98f34918e1d2ea846a5acccac6d1
change-id: 20260616-dsa-fix-free-skb-bb028ce90802

Best regards,
--  
Linus Walleij <linusw@kernel.org>


