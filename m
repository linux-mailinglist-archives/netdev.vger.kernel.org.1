Return-Path: <netdev+bounces-307146-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VENVDhDeVGpVgAAAu9opvQ
	(envelope-from <netdev+bounces-307146-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 14:46:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F2174B100
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 14:46:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307146-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-307146-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 802AF3001CF1
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 12:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE87940C5C0;
	Mon, 13 Jul 2026 12:46:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eidolon.nox.tf (eidolon.nox.tf [185.142.180.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063E637AA99
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 12:45:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783946761; cv=none; b=gZMJ9nOlX3bp730lmoIXUQ3CLMgnJHrDoFOIbiIi8kgE955GvBIyU2f25wKo6tpvKBqUPy6nePgUPVgXIJQF1ql3/Q91vCg9tpL49Ts5TAX2dcWL6ClqCQv7i3UivpUNLsqFTkEThmsAHfijCg7f4gAXStarXSa8bTDSL2IWZII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783946761; c=relaxed/simple;
	bh=IvfLqnE4iXjkAtRlqO8A0cDDIAzwj0rdJ+7NQwpBMok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SGiVSNLyipl3mQ1TC1o56jbErnF/dn8E+AaRWLMTmivEKLCTvMdF1ZnX/zmJnOAmxAQ8hqk6X1RPSRkEVQhuqAY1AJootVr+5eohgn9V2ndosQAx4tS6JUL4+muYeQQgPmar3DKo5deYB56/XB1TdZGop28eVjNkRDk1PXUkkjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net; spf=pass smtp.mailfrom=diac24.net; arc=none smtp.client-ip=185.142.180.128
Received: from [2a07:2ec0:2185:8e:f1c9:c246:22b4:8471] (helo=alea)
	by eidolon.nox.tf with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <equinox@diac24.net>)
	id 1wjG2l-00000001VUo-0Xz3;
	Mon, 13 Jul 2026 14:45:55 +0200
Received: from equinox by alea with local (Exim 4.99.2)
	(envelope-from <equinox@diac24.net>)
	id 1wjG2k-00000001wV4-1FGJ;
	Mon, 13 Jul 2026 14:45:54 +0200
From: David 'equinox' Lamparter <equinox@diac24.net>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David 'equinox' Lamparter <equinox@diac24.net>
Subject: [RFC PATCH net-next 1/2] llc: add 802.1AC (jumbo frames) support
Date: Mon, 13 Jul 2026 14:43:38 +0200
Message-ID: <20260713124545.462790-2-equinox@diac24.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713124545.462790-1-equinox@diac24.net>
References: <20260713124545.462790-1-equinox@diac24.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307146-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[diac24.net];
	FORGED_SENDER(0.00)[equinox@diac24.net,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:equinox@diac24.net,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[equinox@diac24.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,diac24.net:from_mime,diac24.net:email,diac24.net:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 72F2174B100

Length values in the ethertype field only go up to 1500 (with 1501 to
1535 undefined).  802.1AC (2016 Cor1-2018) defines 0x8870 to use as
ethertype for LLC frames with a length > 1500.

Easy enough to implement.  Frames 1500 bytes or shorter are explicitly
rejected when received with ethertype 0x8870 since that could be abused
to smuggle packets past filters.  (It could also cause compatibility
issues when mixing in other devices that don't understand that value.)

A kernel self-test is coming up separately.

(background: the IS-IS routing protocol uses LLC/CLNS.  FRRouting
currently uses AF_PACKET ETH_P_ALL sockets for that, which is a bit
overkill.  Using AF_LLC instead was exploratory, but this fell out as a
side effect.  Two AF_PACKET sockets, ETH_P_802_2 + ETH_P_8021AC, is
probably a better option though.)

Signed-off-by: David 'equinox' Lamparter <equinox@diac24.net>
---
 net/llc/llc_core.c   |  7 +++++++
 net/llc/llc_input.c  | 11 +++++++++++
 net/llc/llc_output.c |  6 ++++--
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/net/llc/llc_core.c b/net/llc/llc_core.c
index 5b0f1986bddc..81cd04a8e7e3 100644
--- a/net/llc/llc_core.c
+++ b/net/llc/llc_core.c
@@ -129,14 +129,21 @@ static struct packet_type llc_packet_type __read_mostly = {
 	.func = llc_rcv,
 };
 
+static struct packet_type llc_packet_type_8021ac __read_mostly = {
+	.type = cpu_to_be16(ETH_P_8021AC),
+	.func = llc_rcv,
+};
+
 static int __init llc_init(void)
 {
 	dev_add_pack(&llc_packet_type);
+	dev_add_pack(&llc_packet_type_8021ac);
 	return 0;
 }
 
 static void __exit llc_exit(void)
 {
+	dev_remove_pack(&llc_packet_type_8021ac);
 	dev_remove_pack(&llc_packet_type);
 }
 
diff --git a/net/llc/llc_input.c b/net/llc/llc_input.c
index 8eb3d73c39d1..9409da626b9c 100644
--- a/net/llc/llc_input.c
+++ b/net/llc/llc_input.c
@@ -120,6 +120,11 @@ static inline int llc_fixup_skb(struct sk_buff *skb)
 
 	skb_pull(skb, llc_len);
 	skb_reset_transport_header(skb);
+
+	/* trimming the checksum is not necessary for 802.1AC since the
+	 * frames are required to be larger than 1500 bytes, thus have no
+	 * ethernet padding
+	 */
 	if (skb->protocol == htons(ETH_P_802_2)) {
 		__be16 pdulen;
 		s32 data_size;
@@ -135,6 +140,12 @@ static inline int llc_fixup_skb(struct sk_buff *skb)
 			return 0;
 		if (unlikely(pskb_trim_rcsum(skb, data_size)))
 			return 0;
+	} else if (skb->protocol == htons(ETH_P_8021AC)) {
+		/* don't accept non-jumbo 802.1AC frames, it could be used to
+		 * bypass filters on 802.2.  Minimum 1497 + 1 byte.
+		 */
+		if (!pskb_may_pull(skb, 1497 + 1))
+			return 0;
 	}
 	return 1;
 }
diff --git a/net/llc/llc_output.c b/net/llc/llc_output.c
index 5a6466fc626a..16efe273188f 100644
--- a/net/llc/llc_output.c
+++ b/net/llc/llc_output.c
@@ -26,12 +26,14 @@ int llc_mac_hdr_init(struct sk_buff *skb,
 		     const unsigned char *sa, const unsigned char *da)
 {
 	int rc = -EINVAL;
+	unsigned short proto;
 
 	switch (skb->dev->type) {
 	case ARPHRD_ETHER:
 	case ARPHRD_LOOPBACK:
-		rc = dev_hard_header(skb, skb->dev, ETH_P_802_2, da, sa,
-				     skb->len);
+		proto = skb->len > 1500 ? ETH_P_8021AC : ETH_P_802_2;
+		skb->protocol = htons(proto);
+		rc = dev_hard_header(skb, skb->dev, proto, da, sa, skb->len);
 		if (rc > 0)
 			rc = 0;
 		break;
-- 
2.53.0


