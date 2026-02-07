Return-Path: <netdev+bounces-257745-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJeIGfjfhmmFRgQAu9opvQ
	(envelope-from <netdev+bounces-257745-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 07:47:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B36F3105181
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 07:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92137301A737
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 06:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC8F2E5B1B;
	Sat,  7 Feb 2026 06:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpCgepgz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097D6239099
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 06:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770446834; cv=none; b=cupIhbdbJi+GKpjMndHGsSw656ft97I3i65DbEzsPorsPhHa5UA4Kla7mFMy/SvcrX9sFufjJAw9cfi/Jhetaa0VDiRkFmU/eizJlp24AV5EZXGmMNus84rLrwTJDF21EWoJSLkP1jh9vGrPnV59S1Int5CVrs2g1api2ePEwbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770446834; c=relaxed/simple;
	bh=2G6hV+wVZg6o//MYI5fkbIvZjfnqpl+ixHuzDnkOF/M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=jpUHHLFL3sdfsDyUl8q9azNaVkpVMqjZHWnNwFv+SBuPelop5iMCYnazkDTmBglXMeVAeDMed7olO2kEb/FrUa56bpkiIBqJDU+bVHZGFSASsoKOr8vKz7626guwYcuOCJI0zzRDT+XFXgqJ8/Fsn5Ic7YQAUY4T58fMLDJqXVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpCgepgz; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b8837152db5so403008666b.0
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 22:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770446832; x=1771051632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ttpBhaYPGwPNPTXRachj9WVFxsA4zzdO/ofWQNu6xMY=;
        b=TpCgepgzzb0Kb3Sp9fu7bumoSsPXZfw7xOlq4AZ7la0O7VMkl2ZIGgd7EZ0030J47N
         jCVLqTS8+2p/dFGIk5KILQU1cBfGwN2HzKbUAdPl68yPVGxUYl6rv2v4pWGkCx1q1jKp
         2lqy6/1+MG1pUbRJB6dPsu1eQppor/cP5YR+bywoR5cCmFdVPojjNOtJAD37OMmHd0AM
         nFLjY1NGYMhb81Y0QLjBIalL9+Gdmba5g/GGDz9vLZl100EPMerUBpnObqwRSPdAmnX/
         HWNncCW0n1RbAyYo9Jc1kM8jbvf0ubEmOxY0whxGJgUX+VIPrzu3RIP+9kRe6IAAi7s/
         xzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770446832; x=1771051632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ttpBhaYPGwPNPTXRachj9WVFxsA4zzdO/ofWQNu6xMY=;
        b=AC0/fxWdEFNJ4kZgIpCf4Ttq0AyMmmgWng/6ux8G28u/etbOt1fhRK62y+CGmCUQB4
         HInOF5qlXmaqum578GdPkHnngEewolKIj00mdZyDoITVNLq9hOm2y8lNDjrvc1qJBwFm
         JVkJeAwNAmX0VzF8mSeICsg9VJaAOFWCoNVUXchjbztDgC1KZeOtggaZPG1KzUiViK/F
         XUfPpmx+au0BqfNGwHMgcJDa9S5Aas18rVinCI/LKtx0e8U0/OF4UkEJ21oOJvgTpHR/
         h0HM2axF9pTxpNIVg1DUxmSyF4G5yJUuELX1qEzu4A7DSliR2fcKnPAQcWBJl4rBVwXZ
         VUcA==
X-Forwarded-Encrypted: i=1; AJvYcCW80wBLx+wO4hcFsJ+FQgwT7r6RuPdXP/c078bzA8OYffFNGYs0uXskJSG0Hh1TAE22vBvti8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+8wempEqJxIW1xCDGso31/BVefgYjznWKHrcJuiW7U2pNmrup
	+Nllv6s9qqi2w71XmvxZhD5GJZrjBg0ScukUErgWxXZ5HDa8TaDTfiCV
X-Gm-Gg: AZuq6aJRKKe6Bk9NIF/Ce4pYOkF4WGQ/9wDPwqMX+hgpvbelstMlMRLDAzQcNAX9LDG
	f8pQyzAhB7Jh9WsmaBvpf5+XutRAszYaUHJbMhegImWBGIijKo6/cUZUCTmj7Uo+oZp5aZ0Yi04
	vWnE4KDuFx9N/xH54bluDfKIEay2kR/i1JfYXzSsQcDwvStCNRSasXUh3VDelp2QuOdQ/N4tokX
	H51fSNa/jcPIETrKP05y+aveAF/qYDVfoeOH2fMV6qv5fmSegn4C+OkrzgI0N47mO+T29XfZt7Z
	DpzkQnF7wRV+TwUC+cGNBj03U6Iari/LXPMU2pwfz6wCcAP8emeQ1NEXc0isg809JACmU0yuEVY
	R3OjBT6JWZfZk/C8Nxyc5OtSUeRG4Ickjp+ri7OhG2Ep/0Ee2NWfpyK3GEQVtqv5GaeG5O5E=
X-Received: by 2002:a17:907:2d8e:b0:b88:5bd7:63b3 with SMTP id a640c23a62f3a-b8edf1a9b51mr279203966b.19.1770446832197;
        Fri, 06 Feb 2026 22:47:12 -0800 (PST)
Received: from gmail.com ([2a09:bac1:5500::3e3:36])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8eda7e6577sm145405466b.30.2026.02.06.22.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 22:47:10 -0800 (PST)
From: Qingfang Deng <dqfext@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-ppp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] ppp: don't byte-swap at run time
Date: Sat,  7 Feb 2026 14:47:04 +0800
Message-ID: <20260207064705.208612-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257745-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B36F3105181
X-Rspamd-Action: no action

Currently, the code loads the protocol number from a skb and converts it
to host-endian for comparison. This requires runtime byte swapping on
little-endian architectures.

Optimize this by comparing the protocol number directly to
constant-folded big-endian values. This reduces code size, and slightly
improves performance in the fastpath. ppp_ioctl() still takes a
host-endian int, so keep the old function for it.

bloat-o-meter analysis on a x86_64 build:
add/remove: 0/0 grow/shrink: 0/6 up/down: 0/-131 (-131)
Function                                     old     new   delta
ppp_receive_nonmp_frame                     2002    2000      -2
ppp_input                                    641     639      -2
npindex_to_proto                              24      12     -12
npindex_to_ethertype                          24      12     -12
ppp_start_xmit                               375     344     -31
__ppp_xmit_process                          1881    1809     -72
Total: Before=22998, After=22867, chg -0.57%

Signed-off-by: Qingfang Deng <dqfext@gmail.com>
---
 drivers/net/ppp/ppp_generic.c | 109 ++++++++++++++++++++--------------
 1 file changed, 65 insertions(+), 44 deletions(-)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index f8814d7be6f1..eca9cd6f3a87 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -239,7 +239,7 @@ struct ppp_net {
 };
 
 /* Get the PPP protocol number from a skb */
-#define PPP_PROTO(skb)	get_unaligned_be16((skb)->data)
+#define PPP_PROTO(skb)	get_unaligned((__be16 *)(skb)->data)
 
 /* We limit the length of ppp->file.rq to this (arbitrary) value */
 #define PPP_MAX_RQLEN	32
@@ -312,7 +312,26 @@ static inline struct ppp_net *ppp_pernet(struct net *net)
 }
 
 /* Translates a PPP protocol number to a NP index (NP == network protocol) */
-static inline int proto_to_npindex(int proto)
+static __always_inline int proto_to_npindex(__be16 proto)
+{
+	switch (proto) {
+	case htons(PPP_IP):
+		return NP_IP;
+	case htons(PPP_IPV6):
+		return NP_IPV6;
+	case htons(PPP_IPX):
+		return NP_IPX;
+	case htons(PPP_AT):
+		return NP_AT;
+	case htons(PPP_MPLS_UC):
+		return NP_MPLS_UC;
+	case htons(PPP_MPLS_MC):
+		return NP_MPLS_MC;
+	}
+	return -EINVAL;
+}
+
+static __always_inline int proto_to_npindex_user(int proto)
 {
 	switch (proto) {
 	case PPP_IP:
@@ -332,44 +351,44 @@ static inline int proto_to_npindex(int proto)
 }
 
 /* Translates an NP index into a PPP protocol number */
-static const int npindex_to_proto[NUM_NP] = {
-	PPP_IP,
-	PPP_IPV6,
-	PPP_IPX,
-	PPP_AT,
-	PPP_MPLS_UC,
-	PPP_MPLS_MC,
+static const __be16 npindex_to_proto[NUM_NP] = {
+	htons(PPP_IP),
+	htons(PPP_IPV6),
+	htons(PPP_IPX),
+	htons(PPP_AT),
+	htons(PPP_MPLS_UC),
+	htons(PPP_MPLS_MC),
 };
 
 /* Translates an ethertype into an NP index */
-static inline int ethertype_to_npindex(int ethertype)
+static inline int ethertype_to_npindex(__be16 ethertype)
 {
 	switch (ethertype) {
-	case ETH_P_IP:
+	case htons(ETH_P_IP):
 		return NP_IP;
-	case ETH_P_IPV6:
+	case htons(ETH_P_IPV6):
 		return NP_IPV6;
-	case ETH_P_IPX:
+	case htons(ETH_P_IPX):
 		return NP_IPX;
-	case ETH_P_PPPTALK:
-	case ETH_P_ATALK:
+	case htons(ETH_P_PPPTALK):
+	case htons(ETH_P_ATALK):
 		return NP_AT;
-	case ETH_P_MPLS_UC:
+	case htons(ETH_P_MPLS_UC):
 		return NP_MPLS_UC;
-	case ETH_P_MPLS_MC:
+	case htons(ETH_P_MPLS_MC):
 		return NP_MPLS_MC;
 	}
 	return -1;
 }
 
 /* Translates an NP index into an ethertype */
-static const int npindex_to_ethertype[NUM_NP] = {
-	ETH_P_IP,
-	ETH_P_IPV6,
-	ETH_P_IPX,
-	ETH_P_PPPTALK,
-	ETH_P_MPLS_UC,
-	ETH_P_MPLS_MC,
+static const __be16 npindex_to_ethertype[NUM_NP] = {
+	htons(ETH_P_IP),
+	htons(ETH_P_IPV6),
+	htons(ETH_P_IPX),
+	htons(ETH_P_PPPTALK),
+	htons(ETH_P_MPLS_UC),
+	htons(ETH_P_MPLS_MC),
 };
 
 /*
@@ -504,7 +523,7 @@ static bool ppp_check_packet(struct sk_buff *skb, size_t count)
 	/* LCP packets must include LCP header which 4 bytes long:
 	 * 1-byte code, 1-byte identifier, and 2-byte length.
 	 */
-	return get_unaligned_be16(skb->data) != PPP_LCP ||
+	return PPP_PROTO(skb) != htons(PPP_LCP) ||
 		count >= PPP_PROTO_LEN + PPP_LCP_HDRLEN;
 }
 
@@ -914,7 +933,7 @@ static long ppp_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case PPPIOCSNPMODE:
 		if (copy_from_user(&npi, argp, sizeof(npi)))
 			break;
-		err = proto_to_npindex(npi.protocol);
+		err = proto_to_npindex_user(npi.protocol);
 		if (err < 0)
 			break;
 		i = err;
@@ -1451,10 +1470,10 @@ static netdev_tx_t
 ppp_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct ppp *ppp = netdev_priv(dev);
-	int npi, proto;
-	unsigned char *pp;
+	__be16 *pp, proto;
+	int npi;
 
-	npi = ethertype_to_npindex(ntohs(skb->protocol));
+	npi = ethertype_to_npindex(skb->protocol);
 	if (npi < 0)
 		goto outf;
 
@@ -1478,7 +1497,7 @@ ppp_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	pp = skb_push(skb, 2);
 	proto = npindex_to_proto[npi];
-	put_unaligned_be16(proto, pp);
+	put_unaligned(proto, pp);
 
 	skb_scrub_packet(skb, !net_eq(ppp->ppp_net, dev_net(dev)));
 	ppp_xmit_process(ppp, skb);
@@ -1764,14 +1783,14 @@ pad_compress_skb(struct ppp *ppp, struct sk_buff *skb)
 static void
 ppp_send_frame(struct ppp *ppp, struct sk_buff *skb)
 {
-	int proto = PPP_PROTO(skb);
+	__be16 proto = PPP_PROTO(skb);
 	struct sk_buff *new_skb;
 	int len;
 	unsigned char *cp;
 
 	skb->dev = ppp->dev;
 
-	if (proto < 0x8000) {
+	if (!(proto & htons(0x8000))) {
 #ifdef CONFIG_PPP_FILTER
 		/* check if the packet passes the pass and active filters.
 		 * See comment for PPP_FILTER_OUTBOUND_TAG above.
@@ -2324,7 +2343,7 @@ ppp_input(struct ppp_channel *chan, struct sk_buff *skb)
 {
 	struct channel *pch = chan->ppp;
 	struct ppp *ppp;
-	int proto;
+	__be16 proto;
 
 	if (!pch) {
 		kfree_skb(skb);
@@ -2347,7 +2366,8 @@ ppp_input(struct ppp_channel *chan, struct sk_buff *skb)
 	}
 
 	proto = PPP_PROTO(skb);
-	if (!ppp || proto >= 0xc000 || proto == PPP_CCPFRAG) {
+	if (!ppp || (proto & htons(0xc000)) == htons(0xc000) ||
+	    proto == htons(PPP_CCPFRAG)) {
 		/* put it on the channel queue */
 		skb_queue_tail(&pch->file.rq, skb);
 		/* drop old frames if queue too long */
@@ -2399,7 +2419,7 @@ ppp_receive_frame(struct ppp *ppp, struct sk_buff *skb, struct channel *pch)
 		skb_checksum_complete_unset(skb);
 #ifdef CONFIG_PPP_MULTILINK
 		/* XXX do channel-level decompression here */
-		if (PPP_PROTO(skb) == PPP_MP)
+		if (PPP_PROTO(skb) == htons(PPP_MP))
 			ppp_receive_mp_frame(ppp, skb, pch);
 		else
 #endif /* CONFIG_PPP_MULTILINK */
@@ -2422,7 +2442,8 @@ static void
 ppp_receive_nonmp_frame(struct ppp *ppp, struct sk_buff *skb)
 {
 	struct sk_buff *ns;
-	int proto, len, npi;
+	int len, npi;
+	__be16 proto;
 
 	/*
 	 * Decompress the frame, if compressed.
@@ -2441,7 +2462,7 @@ ppp_receive_nonmp_frame(struct ppp *ppp, struct sk_buff *skb)
 	 */
 	proto = PPP_PROTO(skb);
 	switch (proto) {
-	case PPP_VJC_COMP:
+	case htons(PPP_VJC_COMP):
 		/* decompress VJ compressed packets */
 		if (!ppp->vj || (ppp->flags & SC_REJ_COMP_TCP))
 			goto err;
@@ -2473,10 +2494,10 @@ ppp_receive_nonmp_frame(struct ppp *ppp, struct sk_buff *skb)
 			skb_put(skb, len - skb->len);
 		else if (len < skb->len)
 			skb_trim(skb, len);
-		proto = PPP_IP;
+		proto = htons(PPP_IP);
 		break;
 
-	case PPP_VJC_UNCOMP:
+	case htons(PPP_VJC_UNCOMP):
 		if (!ppp->vj || (ppp->flags & SC_REJ_COMP_TCP))
 			goto err;
 
@@ -2490,10 +2511,10 @@ ppp_receive_nonmp_frame(struct ppp *ppp, struct sk_buff *skb)
 			netdev_err(ppp->dev, "PPP: VJ uncompressed error\n");
 			goto err;
 		}
-		proto = PPP_IP;
+		proto = htons(PPP_IP);
 		break;
 
-	case PPP_CCP:
+	case htons(PPP_CCP):
 		ppp_ccp_peek(ppp, skb, 1);
 		break;
 	}
@@ -2546,7 +2567,7 @@ ppp_receive_nonmp_frame(struct ppp *ppp, struct sk_buff *skb)
 			/* chop off protocol */
 			skb_pull_rcsum(skb, 2);
 			skb->dev = ppp->dev;
-			skb->protocol = htons(npindex_to_ethertype[npi]);
+			skb->protocol = npindex_to_ethertype[npi];
 			skb_reset_mac_header(skb);
 			skb_scrub_packet(skb, !net_eq(ppp->ppp_net,
 						      dev_net(ppp->dev)));
@@ -2563,7 +2584,7 @@ ppp_receive_nonmp_frame(struct ppp *ppp, struct sk_buff *skb)
 static struct sk_buff *
 ppp_decompress_frame(struct ppp *ppp, struct sk_buff *skb)
 {
-	int proto = PPP_PROTO(skb);
+	__be16 proto = PPP_PROTO(skb);
 	struct sk_buff *ns;
 	int len;
 
@@ -2573,7 +2594,7 @@ ppp_decompress_frame(struct ppp *ppp, struct sk_buff *skb)
 	if (!pskb_may_pull(skb, skb->len))
 		goto err;
 
-	if (proto == PPP_COMP) {
+	if (proto == htons(PPP_COMP)) {
 		int obuff_size;
 
 		switch(ppp->rcomp->compress_proto) {
-- 
2.43.0


