Return-Path: <netdev+bounces-255321-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJ3LF8tmfWknSAIAu9opvQ
	(envelope-from <netdev+bounces-255321-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 03:19:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A855DC0418
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 03:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA20E303C00F
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 02:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF43E2C0F8E;
	Sat, 31 Jan 2026 02:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqMPrmBn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8999C333453
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 02:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769825950; cv=none; b=jhWG3rszfkKzdrJWIN1+1DxhljSE7glPNtAiwa1+VKkrjXKrVKYFT0BoQv9ZAE0cixqLWhGO5k9IVINyqzy0apSbJOqKzDY2yuoPTVTwTvA8jhhbYo9O51pfdentYscqsDPLBnpYvdwdHDDIYGVopUjMlQp/Y5BrFzlOonsKjOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769825950; c=relaxed/simple;
	bh=TzOfWzliCe0axM6RQiyINNFw11Qb66iXdt5zdFtJKDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TKqapthoZhoZgzIxNRz2Eylxde8jbZfmRHHdysMvGpLtAbTX3nez0c36/5TGBHkw9vjc1yme2M3dn5GEWR/GbIw5E41PnlAAq19pvReu+Ud16I6XhYzQuU4Zyoi+YsW2HA3dbGnLh5fJ16wYUMkISRux4/hnc8QBHOlJjLWjfrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NqMPrmBn; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a79ded11a2so18805285ad.3
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 18:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769825949; x=1770430749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64k7msfv2DdzzY51KUbI/N+/uDxb7L+T9f/o9yyek/4=;
        b=NqMPrmBntm7Q5i35KaLcKbQ15WPo0EeAFZclWSxCE9X1dibV6lBtDC4JzFeD3SAO1b
         fXahes3vYpB7XtFjBxP5KPbA8Hblrw2iVxC0Pw7L7EJzlUw49hslgjUprIsd8FCz2/xd
         CIYZ8RMI6DdDtBdaeUpKct6vtTGqRGUyBdL9xIIjN7n6AdoLrLk9lZSZauPS71/pWSpY
         B1ZorvYYLF4Lr67GjwObTdNEgN5NSyc5Z4PfjREcQUs6XoaLWjraMfUMAA0OEJDKChkw
         QslbuvlPDokBCy2jj8sThoj+Axkt1HwOgja18oNQeNzHbJzgOGYHL47ZNU5LAuWG8KFk
         75rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769825949; x=1770430749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=64k7msfv2DdzzY51KUbI/N+/uDxb7L+T9f/o9yyek/4=;
        b=CMMwmrZlO+Dt6FcWn5QEs2SUIQhx+u/tdLxyQ2XfF1FJw4Lp0Qi+4v2be/jHHRQmJw
         tm+up3/F6OYiTqf59pALjHLOrflqSeaqdnrDeYwFE4VzynUXxIP/8GPJFNy9xnK1Soh0
         +oyB+h2IUWZae7yOeUnv3XH0jc814tRZ7rRkNQBBsFtNVkiccxZIDBhlCm2l9VAzwsZ/
         G1SkOAHMSrAuZiRSlJtraEtn46/A2Qv1UPBfCL2F1DwwW6JWUmNAZlE2gPQw6NJ/JDSQ
         BiK7ADdMM3cZPoxhR226CG8kxHe426IiY8ETlZUWEeM80hguB9ItTMMYHERi4LXRC4/R
         JNLA==
X-Gm-Message-State: AOJu0YwHve9onzpu/J4dvPtQlJlDj5+G3Srtna2EgC4y5bZDRAJfyzPj
	HUOocYCLZwK24NV9Hi+yaCWr5gVEMWdKwIBI95jv5e5AfJ2HPrqMETLgimA0ZQ==
X-Gm-Gg: AZuq6aImLbPa4YEKmhrckz4kj7Q3LSITYvXSFiqw1tU/ynYp2cMJHIAwj7vPKpMPpTG
	mYue70KbvtBTRuoq7KXdNN8aCbi4bl2gDtKTn2QLDD2ltGfLEU14hNQfYGKknLsvo6GztVOw2Ow
	IXcOheD5ScYaqyYQfggRVeOKiv4rBJtf++lOCzCvKvPDt8UM6gXOHzzx4NSo1SfFGzyvg1KXYpq
	uBCBX4YUF82zgvYzUJCeGE9RcAgkfMidgF5niNcqrz1uP+/J3Vsrc6UQOrRwa20ASuu4ROXmFgF
	TlnR6aj0m4vZezx9roz5xNEOjyLodcqvTxjoktNuvl4DEAKAkIdw6ATJFFWUPmLoeFpb1Ax/F9q
	0Sx3oHkqhDIBz8uDFyyfWyzotfJK5XUbvHm5DJcoYzm8tyzw8T5j9aIwQp5by5BJI8SJf8P/tnq
	7Ckl2c2SQclCxzxSjcXv3KLavN5i44XW5COL8=
X-Received: by 2002:a17:903:124d:b0:297:f8d9:aad7 with SMTP id d9443c01a7336-2a8d99399c3mr43555955ad.50.1769825948748;
        Fri, 30 Jan 2026 18:19:08 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2a09:bac1:7680:d30::4:384])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b3eeebcsm83427365ad.10.2026.01.30.18.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 18:19:08 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 1/5] net: dsa: tag_yt921x: clarify priority and code fields
Date: Sat, 31 Jan 2026 10:18:47 +0800
Message-ID: <20260131021854.3405036-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260131021854.3405036-1-mmyangfl@gmail.com>
References: <20260131021854.3405036-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255321-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A855DC0418
X-Rspamd-Action: no action

Packet priority is part of the tag, and the priority and code fields are
used by tx and rx. Make revisions to reflect the facts.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 net/dsa/tag_yt921x.c | 83 ++++++++++++++++++++++++++++----------------
 1 file changed, 53 insertions(+), 30 deletions(-)

diff --git a/net/dsa/tag_yt921x.c b/net/dsa/tag_yt921x.c
index 6bbfd42dc5df..098863d491ff 100644
--- a/net/dsa/tag_yt921x.c
+++ b/net/dsa/tag_yt921x.c
@@ -14,11 +14,14 @@
  *     are conflicts somewhere and/or you want to change it for some reason.
  * Tag:
  *   2: VLAN Tag
- *   2: Rx Port
+ *   2:
  *     15b: Rx Port Valid
  *     14b-11b: Rx Port
- *     10b-0b: Cmd?
- *   2: Tx Port(s)
+ *     10b-8b: Tx/Rx Priority
+ *     7b: Tx/Rx Code Valid
+ *     6b-1b: Tx/Rx Code
+ *     0b: ? (unset)
+ *   2:
  *     15b: Tx Port(s) Valid
  *     10b-0b: Tx Port(s) Mask
  */
@@ -33,18 +36,30 @@
 
 #define YT921X_TAG_PORT_EN		BIT(15)
 #define YT921X_TAG_RX_PORT_M		GENMASK(14, 11)
-#define YT921X_TAG_RX_CMD_M		GENMASK(10, 0)
-#define  YT921X_TAG_RX_CMD(x)			FIELD_PREP(YT921X_TAG_RX_CMD_M, (x))
-#define  YT921X_TAG_RX_CMD_FORWARDED		0x80
-#define  YT921X_TAG_RX_CMD_UNK_UCAST		0xb2
-#define  YT921X_TAG_RX_CMD_UNK_MCAST		0xb4
-#define YT921X_TAG_TX_PORTS		GENMASK(10, 0)
+#define YT921X_TAG_PRIO_M		GENMASK(10, 8)
+#define  YT921X_TAG_PRIO(x)			FIELD_PREP(YT921X_TAG_PRIO_M, (x))
+#define YT921X_TAG_CODE_EN		BIT(7)
+#define YT921X_TAG_CODE_M		GENMASK(6, 1)
+#define  YT921X_TAG_CODE(x)			FIELD_PREP(YT921X_TAG_CODE_M, (x))
+#define YT921X_TAG_TX_PORTS_M		GENMASK(10, 0)
+#define  YT921X_TAG_TX_PORTS(x)			FIELD_PREP(YT921X_TAG_TX_PORTS_M, (x))
+
+/* Incomplete. Some are configurable via RMA_CTRL_CPU_CODE, the meaning of
+ * others remains unknown.
+ */
+enum yt921x_tag_code {
+	YT921X_TAG_CODE_FORWARD = 0,
+	YT921X_TAG_CODE_UNK_UCAST = 0x19,
+	YT921X_TAG_CODE_UNK_MCAST = 0x1a,
+	YT921X_TAG_CODE_PORT_COPY = 0x1b,
+	YT921X_TAG_CODE_FDB_COPY = 0x1c,
+};
 
 static struct sk_buff *
 yt921x_tag_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	__be16 *tag;
-	u16 tx;
+	u16 ctrl;
 
 	skb_push(skb, YT921X_TAG_LEN);
 	dsa_alloc_etype_header(skb, YT921X_TAG_LEN);
@@ -55,9 +70,9 @@ yt921x_tag_xmit(struct sk_buff *skb, struct net_device *netdev)
 	/* VLAN tag unrelated when TX */
 	tag[1] = 0;
 	tag[2] = 0;
-	tx = FIELD_PREP(YT921X_TAG_TX_PORTS, dsa_xmit_port_mask(skb, netdev)) |
-	     YT921X_TAG_PORT_EN;
-	tag[3] = htons(tx);
+	ctrl = YT921X_TAG_TX_PORTS(dsa_xmit_port_mask(skb, netdev)) |
+	       YT921X_TAG_PORT_EN;
+	tag[3] = htons(ctrl);
 
 	return skb;
 }
@@ -67,7 +82,6 @@ yt921x_tag_rcv(struct sk_buff *skb, struct net_device *netdev)
 {
 	unsigned int port;
 	__be16 *tag;
-	u16 cmd;
 	u16 rx;
 
 	if (unlikely(!pskb_may_pull(skb, YT921X_TAG_LEN)))
@@ -98,23 +112,32 @@ yt921x_tag_rcv(struct sk_buff *skb, struct net_device *netdev)
 		return NULL;
 	}
 
-	cmd = FIELD_GET(YT921X_TAG_RX_CMD_M, rx);
-	switch (cmd) {
-	case YT921X_TAG_RX_CMD_FORWARDED:
-		/* Already forwarded by hardware */
-		dsa_default_offload_fwd_mark(skb);
-		break;
-	case YT921X_TAG_RX_CMD_UNK_UCAST:
-	case YT921X_TAG_RX_CMD_UNK_MCAST:
-		/* NOTE: hardware doesn't distinguish between TRAP (copy to CPU
-		 * only) and COPY (forward and copy to CPU). In order to perform
-		 * a soft switch, NEVER use COPY action in the switch driver.
-		 */
-		break;
-	default:
+	if (!(rx & YT921X_TAG_CODE_EN)) {
 		dev_warn_ratelimited(&netdev->dev,
-				     "Unexpected rx cmd 0x%02x\n", cmd);
-		break;
+				     "Tag code not enabled in rx packet\n");
+	} else {
+		u16 code = FIELD_GET(YT921X_TAG_CODE_M, rx);
+
+		switch (code) {
+		case YT921X_TAG_CODE_FORWARD:
+		case YT921X_TAG_CODE_PORT_COPY:
+		case YT921X_TAG_CODE_FDB_COPY:
+			/* Already forwarded by hardware */
+			dsa_default_offload_fwd_mark(skb);
+			break;
+		case YT921X_TAG_CODE_UNK_UCAST:
+		case YT921X_TAG_CODE_UNK_MCAST:
+			/* NOTE: hardware doesn't distinguish between TRAP (copy
+			 * to CPU only) and COPY (forward and copy to CPU). In
+			 * order to perform a soft switch, NEVER use COPY action
+			 * in the switch driver.
+			 */
+			break;
+		default:
+			dev_warn_ratelimited(&netdev->dev,
+					     "Unknown code 0x%02x\n", code);
+			break;
+		}
 	}
 
 	/* Remove YT921x tag and update checksum */
-- 
2.51.0


