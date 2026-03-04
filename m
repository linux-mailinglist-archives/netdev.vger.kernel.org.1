Return-Path: <netdev+bounces-263722-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAMPHN0HqGnSnQAAu9opvQ
	(envelope-from <netdev+bounces-263722-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:22:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEACF1FE3E5
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1202F3167C01
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 10:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E163A2568;
	Wed,  4 Mar 2026 10:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Uf8MQ8nz"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBF33A2556
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 10:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772619555; cv=none; b=Ix+YPVw4wGY2B+8JJhkVwEqxukJAGzNdbJyY4lFftrpGLmr7QUbFsSejbqzER3vdeA5qVweCJqv9ck8hlgZY53xa35dWdV0+ZoYqVBDLe0ZFWmxvOdSjfjcfpZSeVGDnY+n/wwbwopvJJmbxpd8FLEJx3THfEI3ALk1bMoQbwMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772619555; c=relaxed/simple;
	bh=+D9hGGb7Qn/3/uQS7RBlcHYfb3DuR7BIpn8pe59zs20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iWi8PBqIDnpoKmf/u0JdLjBVYgncuGo5coZ+LwsbMGmvGGTfiLnZfuw+a5Mcefi08BwMwvUA5hW6kpgl9rIJFDPTR2Iw/L7cRPWfVD2WYlYTUqf/FGmSBLjIZJtARuIA2pZKpq9ID+0OSt6RYplQ9X3O7ubAxod7j0U19g/iBmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Uf8MQ8nz; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0A8834E4253A;
	Wed,  4 Mar 2026 10:19:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CE5A95FF5C;
	Wed,  4 Mar 2026 10:19:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2AC481036978E;
	Wed,  4 Mar 2026 11:19:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772619551; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=afZUg15/66F8PJs3dkWQkpkg3CFYc4OE3l/LqeYFHwM=;
	b=Uf8MQ8nzp2F+3phPRg/Za1a+GZRoEtZPSOKh7YxRtBMAaFC8ZkvN8/iihWqlNvflZ8wYhf
	aaij7SiIyr6T5s/8tfsTzOSdumlAzcRj17bpE71HvXXtXxVz84rkR1Bths88kW7s8NhKsn
	kLpIa6Cm0ycQTZPByuFer1DujGi3cA9yF37X1Ohw+I0y7a/WIbGoWku7e2bAUV+du1Ph7j
	Fr0CJM5vF0bO0OmRjh2LoK4NTYj2r5TzacC61Y25hNb6SdQT/q/QQLIUhF3GdCfz7X6Fv6
	Q52e8Y33NEyBtE6EbV09TfjlfyAvp2ByuUQfklcZ/YXuND1Y9h+9eibxQ53djA==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Wed, 04 Mar 2026 11:18:57 +0100
Subject: [PATCH net-next v6 6/9] net: dsa: microchip: Add KSZ8463 tail tag
 handling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-ksz8463-ptp-v6-6-3f4c47954c71@bootlin.com>
References: <20260304-ksz8463-ptp-v6-0-3f4c47954c71@bootlin.com>
In-Reply-To: <20260304-ksz8463-ptp-v6-0-3f4c47954c71@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, Simon Horman <horms@kernel.org>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: BEACF1FE3E5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263722-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

KSZ8463 uses the KSZ9893 DSA TAG driver. However, the KSZ8463 doesn't
use the tail tag to convey timestamps to the host as KSZ9893 does. It
uses the reserved fields in the PTP header instead.

Add a KSZ8463-specifig DSA_TAG driver to handle KSZ8463 timestamps.
There is no information in the tail tag to distinguish PTP packets from
others so use the ptp_classify_raw() helper to find the PTP packets and
extract the timestamp from their PTP headers.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_common.c |  5 ++-
 include/net/dsa.h                      |  2 ++
 net/dsa/tag_ksz.c                      | 62 ++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 3e533a0251358ddf210b3836d534a3837f7a3321..9ebdeef07833a278fc419ba21ac3fdb4fbec604f 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3584,8 +3584,10 @@ static enum dsa_tag_protocol ksz_get_tag_protocol(struct dsa_switch *ds,
 	if (ksz_is_ksz87xx(dev) || ksz_is_8895_family(dev))
 		proto = DSA_TAG_PROTO_KSZ8795;
 
+	if (dev->chip_id == KSZ8463_CHIP_ID)
+		proto = DSA_TAG_PROTO_KSZ8463;
+
 	if (dev->chip_id == KSZ88X3_CHIP_ID ||
-	    dev->chip_id == KSZ8463_CHIP_ID ||
 	    dev->chip_id == KSZ8563_CHIP_ID ||
 	    dev->chip_id == KSZ9893_CHIP_ID ||
 	    dev->chip_id == KSZ9563_CHIP_ID)
@@ -3613,6 +3615,7 @@ static int ksz_connect_tag_protocol(struct dsa_switch *ds,
 	switch (proto) {
 	case DSA_TAG_PROTO_KSZ8795:
 		return 0;
+	case DSA_TAG_PROTO_KSZ8463:
 	case DSA_TAG_PROTO_KSZ9893:
 	case DSA_TAG_PROTO_KSZ9477:
 	case DSA_TAG_PROTO_LAN937X:
diff --git a/include/net/dsa.h b/include/net/dsa.h
index 6c17446f3dcc29682e07a70362bae8d8fa6233b0..e854cde8b400c2f47e5c474460e914e1abbf8984 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -58,6 +58,7 @@ struct tc_action;
 #define DSA_TAG_PROTO_YT921X_VALUE		30
 #define DSA_TAG_PROTO_MXL_GSW1XX_VALUE		31
 #define DSA_TAG_PROTO_MXL862_VALUE		32
+#define DSA_TAG_PROTO_KSZ8463_VALUE		33
 
 enum dsa_tag_protocol {
 	DSA_TAG_PROTO_NONE		= DSA_TAG_PROTO_NONE_VALUE,
@@ -93,6 +94,7 @@ enum dsa_tag_protocol {
 	DSA_TAG_PROTO_YT921X		= DSA_TAG_PROTO_YT921X_VALUE,
 	DSA_TAG_PROTO_MXL_GSW1XX	= DSA_TAG_PROTO_MXL_GSW1XX_VALUE,
 	DSA_TAG_PROTO_MXL862		= DSA_TAG_PROTO_MXL862_VALUE,
+	DSA_TAG_PROTO_KSZ8463		= DSA_TAG_PROTO_KSZ8463_VALUE,
 };
 
 struct dsa_switch;
diff --git a/net/dsa/tag_ksz.c b/net/dsa/tag_ksz.c
index 6ec9bcb324a953d988ef665a177566159e27027f..bdd0e63b2b468c78b92d231b90a09a8f853e261c 100644
--- a/net/dsa/tag_ksz.c
+++ b/net/dsa/tag_ksz.c
@@ -12,6 +12,7 @@
 
 #include "tag.h"
 
+#define KSZ8463_NAME "ksz8463"
 #define KSZ8795_NAME "ksz8795"
 #define KSZ9477_NAME "ksz9477"
 #define KSZ9893_NAME "ksz9893"
@@ -382,6 +383,66 @@ static const struct dsa_device_ops ksz9893_netdev_ops = {
 DSA_TAG_DRIVER(ksz9893_netdev_ops);
 MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_KSZ9893, KSZ9893_NAME);
 
+#define KSZ8463_TAIL_TAG_PRIO		GENMASK(4, 3)
+#define KSZ8463_TAIL_TAG_EG_PORT_M	GENMASK(2, 0)
+
+static struct sk_buff *ksz8463_xmit(struct sk_buff *skb,
+				    struct net_device *dev)
+{
+	u16 queue_mapping = skb_get_queue_mapping(skb);
+	u8 prio = netdev_txq_to_tc(dev, queue_mapping);
+
+	return ksz_common_xmit(skb, dev, false,
+			       FIELD_PREP(KSZ8463_TAIL_TAG_PRIO, prio),
+			       0);
+}
+
+static struct sk_buff *ksz8463_rcv(struct sk_buff *skb, struct net_device *dev)
+{
+	unsigned int len = KSZ_EGRESS_TAG_LEN;
+	struct ptp_header *ptp_hdr;
+	unsigned int ptp_class;
+	unsigned int port;
+	ktime_t ts;
+	u8 *tag;
+
+	if (skb_linearize(skb))
+		return NULL;
+
+	/* Tag decoding */
+	tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
+	port = tag[0] & KSZ8463_TAIL_TAG_EG_PORT_M;
+
+	__skb_push(skb, ETH_HLEN);
+	ptp_class = ptp_classify_raw(skb);
+	__skb_pull(skb, ETH_HLEN);
+	if (ptp_class == PTP_CLASS_NONE)
+		goto common_rcv;
+
+	ptp_hdr = ptp_parse_header(skb, ptp_class);
+	if (ptp_hdr) {
+		ts = ksz_decode_tstamp(get_unaligned_be32(&ptp_hdr->reserved2));
+		KSZ_SKB_CB(skb)->tstamp = ts;
+		ptp_hdr->reserved2 = 0;
+	}
+
+common_rcv:
+	return ksz_common_rcv(skb, dev, port, len);
+}
+
+static const struct dsa_device_ops ksz8463_netdev_ops = {
+	.name	= KSZ8463_NAME,
+	.proto	= DSA_TAG_PROTO_KSZ8463,
+	.xmit	= ksz8463_xmit,
+	.rcv	= ksz8463_rcv,
+	.connect = ksz_connect,
+	.disconnect = ksz_disconnect,
+	.needed_tailroom = KSZ_INGRESS_TAG_LEN,
+};
+
+DSA_TAG_DRIVER(ksz8463_netdev_ops);
+MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_KSZ8463, KSZ8463_NAME);
+
 /* For xmit, 2/6 bytes are added before FCS.
  * ---------------------------------------------------------------------------
  * DA(6bytes)|SA(6bytes)|....|Data(nbytes)|ts(4bytes)|tag0(1byte)|tag1(1byte)|
@@ -452,6 +513,7 @@ DSA_TAG_DRIVER(lan937x_netdev_ops);
 MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_LAN937X, LAN937X_NAME);
 
 static struct dsa_tag_driver *dsa_tag_driver_array[] = {
+	&DSA_TAG_DRIVER_NAME(ksz8463_netdev_ops),
 	&DSA_TAG_DRIVER_NAME(ksz8795_netdev_ops),
 	&DSA_TAG_DRIVER_NAME(ksz9477_netdev_ops),
 	&DSA_TAG_DRIVER_NAME(ksz9893_netdev_ops),

-- 
2.53.0


