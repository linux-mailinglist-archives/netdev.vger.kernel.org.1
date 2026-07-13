Return-Path: <netdev+bounces-307041-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EkqoH/WPVGp8nQMAu9opvQ
	(envelope-from <netdev+bounces-307041-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 09:12:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 274FC747E58
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 09:12:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=Y8C0t6Zl;
	dmarc=pass (policy=reject) header.from=bootlin.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307041-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-307041-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8ADED3014774
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 07:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A328A388E69;
	Mon, 13 Jul 2026 07:11:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B5836F8EF
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 07:11:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783926709; cv=none; b=qq/IfgJkm+65DFM4WQ+R1wvJ5I2ectRearZlZszKQSCf3IU3SwVRFxj1hGgw651EyNHTqzDC6hKkKuQxd0W4Q5ddos87ad6bDAOFFCXmmqScH/xdIByZsorv7DYLGVCjHuekWirZricoGl7ICDBIlOqC2oBlgWTDVqrgGQkvMLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783926709; c=relaxed/simple;
	bh=KcRnAacbUb1U1qpPj32Xg0y3dcBts07hc7eNi6V5GcI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Eug3KbcPGwr7EBUT7FopIJ7SV1JqA/OJ/MbtwqL9fS+5028jNfQ+z+hCgV110vQt+GesiN7et/Bs5JiukjvJ/jk6ct2C6Hr2o3crsIQfoa94Oivh52KefEbcCP0Zdh9R/j0KsN0rOhupGTzjvSjijbDp5x7BQJE3Stncd0mDJk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Y8C0t6Zl; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 525BF4E40D81;
	Mon, 13 Jul 2026 07:11:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2850960341;
	Mon, 13 Jul 2026 07:11:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 628C311BD3A1E;
	Mon, 13 Jul 2026 09:11:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783926701; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=DB/AuADM3cKTTPWyDwbhPOvmCpqeymWC83FnlPAt0eM=;
	b=Y8C0t6ZlIDOkOVoIQCUBAi2GUlG5tXhA+pzLuqoyIwnwk3NF5LTPTXt7kli8bLNOyO0q07
	wN/eKoQFtWYSISWCUsqZCyU3+DozT8r7L4hl5hQu7ZgnZZwo4/C7wgrZVunGtAlEuorJsn
	omJmc/39vL8PsxWLiLhR91qOgOKcHcR88KwA9os5aPgcxfWYjrt6wuuve40U4WiWVyYYtY
	KSrvWBlZ76mKsrOyBrb+0agsNc3hOX4yHkAfWgTsv+v7Rd8dP0lysFf6pHtBIkQENLwqUE
	eFDo6WcJtOnRoMjLTFCh9DVDcMeJtgMBfXkpFo+lJxVNus5whuqr+3LyKaTCJw==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Mon, 13 Jul 2026 09:11:26 +0200
Subject: [PATCH net-next v2 07/10] net: dsa: tag_ksz: share code for
 KSZ8795 and KSZ9893 xmit operations
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-ksz-new-ptp-v2-7-7209c05058ef@bootlin.com>
References: <20260713-ksz-new-ptp-v2-0-7209c05058ef@bootlin.com>
In-Reply-To: <20260713-ksz-new-ptp-v2-0-7209c05058ef@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Simon Horman <horms@kernel.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,bootlin.com];
	FORGED_RECIPIENTS(0.00)[m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:horms@kernel.org,m:maxime.chevallier@bootlin.com,m:pascal.eberhard@se.com,m:miquel.raynal@bootlin.com,m:thomas.petazzoni@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bastien.curutchet@bootlin.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-307041-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,bootlin.com:from_mime,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 274FC747E58

KSZ8795 and KSZ9893 have very similar tag handling in the xmit path,
leading to code duplication.

There are only two differences between the two ksz*_xmit():
- the KSZ8795 doesn't handle priorities between frames
- ksz8795_xmit() directly returns the SKB instead of calling
ksz_defer_xmit(). Yet, ksz_defer_xmit() also returns directly the SKB
if no clone is present inside the SKB. Clones are only created by the KSZ
driver when the PTP feature is enabled. Since KSZ8795 doesn't support
PTP, returning the SKB directly or ksz_defer_xmit() is the same.

The upcoming support for the KSZ8463 also requires a similar xmit().

Gather the common code from ksz8795_xmit() and ksz9893_xmit() into a new
ksz_common_xmit() function that takes three input arguments:
- do_tstamp to tell whether ksz_xmit_timestamp() should be called
- prio to give the priority tag (if any)
- override_mask to give the location of the override bit (if any)

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 net/dsa/tag_ksz.c | 73 ++++++++++++++++++++++++++-----------------------------
 1 file changed, 35 insertions(+), 38 deletions(-)

diff --git a/net/dsa/tag_ksz.c b/net/dsa/tag_ksz.c
index f58ce0f0e9e4..f8b40437c5fa 100644
--- a/net/dsa/tag_ksz.c
+++ b/net/dsa/tag_ksz.c
@@ -218,6 +218,37 @@ static struct sk_buff *ksz_defer_xmit(struct dsa_port *dp, struct sk_buff *skb)
 	return NULL;
 }
 
+static struct sk_buff *ksz_common_xmit(struct sk_buff *skb,
+				       struct net_device *dev,
+				       bool do_tstamp,
+				       u8 prio,
+				       u8 override_mask)
+{
+	struct dsa_port *dp = dsa_user_to_port(dev);
+	struct ethhdr *hdr;
+	u8 *tag;
+
+	if (skb->ip_summed == CHECKSUM_PARTIAL && skb_checksum_help(skb)) {
+		kfree_skb(skb);
+		return NULL;
+	}
+
+	/* Tag encoding */
+	if (do_tstamp)
+		ksz_xmit_timestamp(dp, skb);
+
+	tag = skb_put(skb, KSZ_INGRESS_TAG_LEN);
+	hdr = skb_eth_hdr(skb);
+
+	*tag = dsa_xmit_port_mask(skb, dev);
+	*tag |= prio;
+
+	if (is_link_local_ether_addr(hdr->h_dest))
+		*tag |= override_mask;
+
+	return ksz_defer_xmit(dp, skb);
+}
+
 static struct sk_buff *ksz9477_xmit(struct sk_buff *skb,
 				    struct net_device *dev)
 {
@@ -308,23 +339,7 @@ MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_KSZ9477, KSZ9477_NAME);
 
 static struct sk_buff *ksz8795_xmit(struct sk_buff *skb, struct net_device *dev)
 {
-	struct ethhdr *hdr;
-	u8 *tag;
-
-	if (skb->ip_summed == CHECKSUM_PARTIAL && skb_checksum_help(skb)) {
-		kfree_skb(skb);
-		return NULL;
-	}
-
-	/* Tag encoding */
-	tag = skb_put(skb, KSZ_INGRESS_TAG_LEN);
-	hdr = skb_eth_hdr(skb);
-
-	*tag = dsa_xmit_port_mask(skb, dev);
-	if (is_link_local_ether_addr(hdr->h_dest))
-		*tag |= KSZ8795_TAIL_TAG_OVERRIDE;
-
-	return skb;
+	return ksz_common_xmit(skb, dev, false, 0, KSZ8795_TAIL_TAG_OVERRIDE);
 }
 
 static struct sk_buff *ksz8795_rcv(struct sk_buff *skb, struct net_device *dev)
@@ -362,28 +377,10 @@ static struct sk_buff *ksz9893_xmit(struct sk_buff *skb,
 {
 	u16 queue_mapping = skb_get_queue_mapping(skb);
 	u8 prio = netdev_txq_to_tc(dev, queue_mapping);
-	struct dsa_port *dp = dsa_user_to_port(dev);
-	struct ethhdr *hdr;
-	u8 *tag;
-
-	if (skb->ip_summed == CHECKSUM_PARTIAL && skb_checksum_help(skb)) {
-		kfree_skb(skb);
-		return NULL;
-	}
-
-	/* Tag encoding */
-	ksz_xmit_timestamp(dp, skb);
-
-	tag = skb_put(skb, KSZ_INGRESS_TAG_LEN);
-	hdr = skb_eth_hdr(skb);
-
-	*tag = dsa_xmit_port_mask(skb, dev);
-	*tag |= FIELD_PREP(KSZ9893_TAIL_TAG_PRIO, prio);
 
-	if (is_link_local_ether_addr(hdr->h_dest))
-		*tag |= KSZ9893_TAIL_TAG_OVERRIDE;
-
-	return ksz_defer_xmit(dp, skb);
+	return ksz_common_xmit(skb, dev, true,
+			       FIELD_PREP(KSZ9893_TAIL_TAG_PRIO, prio),
+			       KSZ9893_TAIL_TAG_OVERRIDE);
 }
 
 static const struct dsa_device_ops ksz9893_netdev_ops = {

-- 
2.54.0


