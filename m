Return-Path: <netdev+bounces-291016-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGkfC4sNEWpJgwYAu9opvQ
	(envelope-from <netdev+bounces-291016-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 04:14:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C585BC822
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 04:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E5F23028B27
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1212F7AD2;
	Sat, 23 May 2026 02:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzcbX4Rr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD9E285CB9
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 02:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779502072; cv=none; b=j7resDixXkKv7LkDINGdhaQzxsT4LK92k6y0B/Hy5sNvJlp1KCm8iQzVvY1GlfbwmJF8Zh1Tc0VETLxs63eGom+3xjze85nVbbY91N8MCQEUKOQawkgorh/+7HFrqNnrsUY5nrT5AECx3a5i6FIWLzXmrESlQDKEOz7pW6NlowY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779502072; c=relaxed/simple;
	bh=KOx53VvPI1rm9CLREBgELBd5RykjVyIpSlCaKfW6PK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CRyAFpwU949jJnOIeQ7fNxhjjUVaiTETlOxjpwCG0yUycBkls9gEx7gGHHHiGunazjbnaUIKvLq4RL5FumVjoS9KL5D+K2QCDOM7KfpZwE6FyvV63ta+ynyvUPn6s8ilYpNwMvBVIgZ/v18ojojYzzO70xovFIWq0kpb/QkKTOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzcbX4Rr; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36936dcf19dso3861933a91.0
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 19:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779502069; x=1780106869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7OX7Hpt14wXrdrPpZUsMfTxbi/kGkkAmLcm25GJbXp8=;
        b=OzcbX4Rr3JQfQusTpix63hA2h7J2bRigbjIq/hpQdurmd+Cy2gE1N6bPtLFYy/LZqp
         g3UOHi+Mi+NUixY1oPViJ0xN5CDRilAeVpwsNLU6nNP5/j3BaUCZqjoQQq5msYQ4vRqk
         Xm5F3jaZa7IO30N0Y8cpUfKa/JW/SpymwLqseKKFm4J2HB67cP/2j8taj2QlaAHqrruR
         gfvtD2IQXOnS9vVJ1yTOjFj/qySvu1WAG5TqROKAP87/BdLvBgUxhBiTNT7J5SU6Wdb/
         AB3s62aZ0Lp6E+RLiKnjZqhfGjVq/qA45MsO9QAmD/11vlJo00/2lUcvFdcMqM6dW/UL
         n8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779502069; x=1780106869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OX7Hpt14wXrdrPpZUsMfTxbi/kGkkAmLcm25GJbXp8=;
        b=tBS/4E5v6bgIYGyO7cwR57eHBIODxsQvckki+zhOZI2Q1Fncky7kF3FoZFeZuehuab
         PBY6chk20KZAkF9J1MRbkBqqARoBc6sIF5QrkbIqlHsRw0GUbYHhX7rswVFQSx2ki163
         TLxaOhs7XrUG2SluOwaKUMu9Tw5EZSuuud6yFFeKbgGOH4C204gzEo1g33r4EDeULCA4
         xHGMNh0NCQoxqMkbcb5jLkxpTJH7yGZqntOPAv1mTbrNtoIXBRwFH2NGBw0GDFJBYQxY
         YwGOjYLnUU44I/zFkhJ9lLwq+LsTAsj8hX7yZ9N4OZthiYbT1LpsuJSS/9k3B53o9oQj
         zwFQ==
X-Gm-Message-State: AOJu0Yytg9TTe5k5PIe5EwBvc2uDla31ztcT8iM3YSg4GQ8FoerayIDV
	xsaGZyVbekNuqyR2r4EBdC1YtLtSqrZYI7jqRA8wGApbhsK2pvIu8jWbi2N8DcvB
X-Gm-Gg: Acq92OEe4L7i0QBSPXG1zQUqErVz5f5xMw8Ezt3KmYwkPMsgksCNjbehNd+ujfz3QI3
	nQFfk1snsqZsxTKRmMjC8OZtf8+4QlH69M+bGJh2ZMytSvLABjtQ7QkoWiP38dajL+HVSracDk6
	adGm8zMy4Z4eLBzfEe0QPq7LF3iBZ8m6avSALNQeuDMl4iIbbi52D1RdVYGzK2G0Kh3vziOMDIG
	56Qy6Fbjlc6zG1AJ2/oUYPHv2OGjUdddF5G+hyEcBF5wpyKRN3h6OXbVSeFqwm2bGsMawKiY99s
	iycQ/JEELQ/FwpsLMckBVNEpvvIRtm+yh4b4H0WSf/mqQVecDM9LNngOLUf4mgzWJPdy6D0Ry1/
	bGQ7kszY9ovlXYP7/CqKMllbcnUBOYkQNiqQhc68SM3G4YHaIGW1QSC0rNKU6jSKka+gUYdeh/4
	hCXKl4+jqpxoDT1ZEC/x1HXrkKFxUOj+oD3aTlBbzD1D/AcoMr7RriMUQeNCE=
X-Received: by 2002:a17:90b:4e84:b0:368:a297:bd3d with SMTP id 98e67ed59e1d1-36a676f0614mr5999326a91.3.1779502068316;
        Fri, 22 May 2026 19:07:48 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:d30::4cf:38])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a678d384fsm1489283a91.4.2026.05.22.19.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 19:07:47 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	hong son Nguyen <hongson.hn@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3] net: dsa: yt921x: Add ACL support
Date: Sat, 23 May 2026 10:07:01 +0800
Message-ID: <20260523020704.503966-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291016-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 45C585BC822
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Enable filtering of incoming traffics. Note that custom filters are yet
to be utilized, and thus not all flow dissectors are implemented.

Tested-by: hong son Nguyen <hongson.hn@gmail.com>
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
v2: https://lore.kernel.org/r/20260520022242.120640-1-mmyangfl@gmail.com
  - v1 was mistakenly sent as v2
v1: https://lore.kernel.org/r/20260514192140.3468543-1-mmyangfl@gmail.com
  - fix issue reported by test robot
 drivers/net/dsa/yt921x.c | 990 ++++++++++++++++++++++++++++++++++++++-
 drivers/net/dsa/yt921x.h | 284 +++++++++++
 2 files changed, 1271 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index 9cc211b90c6c..a5be0f769f94 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -186,6 +186,16 @@ struct yt921x_reg_mdio {
 #define to_yt921x_priv(_ds) container_of_const(_ds, struct yt921x_priv, ds)
 #define to_device(priv) ((priv)->ds.dev)
 
+static u32 ethaddr_hi4_to_u32(const unsigned char *addr)
+{
+	return (addr[0] << 24) | (addr[1] << 16) | (addr[2] << 8) | addr[3];
+}
+
+static u32 ethaddr_lo2_to_u32(const unsigned char *addr)
+{
+	return (addr[4] << 8) | addr[5];
+}
+
 static int yt921x_reg_read(struct yt921x_priv *priv, u32 reg, u32 *valp)
 {
 	WARN_ON(!mutex_is_locked(&priv->reg_lock));
@@ -1457,6 +1467,955 @@ yt921x_dsa_port_setup_tc(struct dsa_switch *ds, int port,
 	}
 }
 
+/* ACL: 48 blocks * 8 entries
+ *
+ * One rule can span multiple entries, but within a block.
+ */
+
+static void
+yt921x_acl_entry_set(struct yt921x_acl_entry *entry, unsigned int offset,
+		     u32 flags, bool set)
+{
+	if (set)
+		entry->key[offset] |= flags;
+	entry->mask[offset] |= flags;
+}
+
+static unsigned int
+yt921x_acl_entries_set_first_frag(struct yt921x_acl_entry *entries,
+				  unsigned int size, bool set)
+{
+	for (unsigned int i = 0; i < size; i++)
+		switch (FIELD_GET(YT921X_ACL_KEYb_TYPE_M, entries[i].key[1])) {
+		case YT921X_ACL_TYPE_IPV6_DA2:
+		case YT921X_ACL_TYPE_IPV6_SA2:
+			yt921x_acl_entry_set(&entries[i], 1,
+					     YT921X_ACL_BINb_IPV6_xA2_FIRST_FRAG,
+					     set);
+			return size;
+		case YT921X_ACL_TYPE_MISC:
+			yt921x_acl_entry_set(&entries[i], 0,
+					     YT921X_ACL_BINa_MISC_FIRST_FRAG,
+					     set);
+			return size;
+		}
+
+	if (size >= YT921X_ACL_ENT_PER_BLK)
+		return 0;
+
+	entries[size] = (typeof(*entries)){};
+	entries[size].key[1] = YT921X_ACL_KEYb_TYPE(YT921X_ACL_TYPE_MISC);
+	yt921x_acl_entry_set(&entries[size], 0,
+			     YT921X_ACL_BINa_MISC_FIRST_FRAG, set);
+
+	return size + 1;
+}
+
+static unsigned int
+yt921x_acl_entries_set_is_fragment(struct yt921x_acl_entry *entries,
+				   unsigned int size, bool set)
+{
+	for (unsigned int i = 0; i < size; i++)
+		switch (FIELD_GET(YT921X_ACL_KEYb_TYPE_M, entries[i].key[1])) {
+		case YT921X_ACL_TYPE_IPV4_DA:
+		case YT921X_ACL_TYPE_IPV4_SA:
+			yt921x_acl_entry_set(&entries[i], 1,
+					     YT921X_ACL_BINb_IPV4_FRAG, set);
+			return size;
+		case YT921X_ACL_TYPE_IPV6_DA3:
+		case YT921X_ACL_TYPE_IPV6_SA3:
+			yt921x_acl_entry_set(&entries[i], 1,
+					     YT921X_ACL_BINb_IPV6_xA3_FRAG,
+					     set);
+			return size;
+		case YT921X_ACL_TYPE_MISC:
+			yt921x_acl_entry_set(&entries[i], 1,
+					     YT921X_ACL_BINb_MISC_FRAG, set);
+			return size;
+		case YT921X_ACL_TYPE_L4:
+			yt921x_acl_entry_set(&entries[i], 1,
+					     YT921X_ACL_BINb_L4_FRAG, set);
+			return size;
+		}
+
+	if (size >= YT921X_ACL_ENT_PER_BLK)
+		return 0;
+
+	entries[size] = (typeof(*entries)){};
+	entries[size].key[1] = YT921X_ACL_KEYb_TYPE(YT921X_ACL_TYPE_MISC);
+	yt921x_acl_entry_set(&entries[size], 1, YT921X_ACL_BINb_MISC_FRAG, set);
+
+	return size + 1;
+}
+
+static unsigned int
+yt921x_acl_entries_set_l3_type(struct yt921x_acl_entry *entries,
+			       unsigned int size, enum yt921x_l3_type type)
+{
+	for (unsigned int i = 0; i < size; i++)
+		switch (FIELD_GET(YT921X_ACL_KEYb_TYPE_M, entries[i].key[1])) {
+		case YT921X_ACL_TYPE_MAC_DA0:
+		case YT921X_ACL_TYPE_MAC_SA0:
+			entries[i].key[1] |= YT921X_ACL_BINb_MAC_xA0_L3_TYPE(type);
+			entries[i].mask[1] |= YT921X_ACL_BINb_MAC_xA0_L3_TYPE_M;
+			return size;
+		case YT921X_ACL_TYPE_MISC:
+			entries[i].key[0] |= YT921X_ACL_BINa_MISC_L3_TYPE(type);
+			entries[i].mask[0] |= YT921X_ACL_BINa_MISC_L3_TYPE_M;
+			return size;
+		}
+
+	if (size >= YT921X_ACL_ENT_PER_BLK)
+		return 0;
+
+	entries[size] = (typeof(*entries)){};
+	entries[size].key[0] = YT921X_ACL_BINa_MISC_L3_TYPE(type);
+	entries[size].key[1] = YT921X_ACL_KEYb_TYPE(YT921X_ACL_TYPE_MISC);
+	entries[size].mask[0] = YT921X_ACL_BINa_MISC_L3_TYPE_M;
+
+	return size + 1;
+}
+
+static unsigned int
+yt921x_acl_entries_set_l4_type(struct yt921x_acl_entry *entries,
+			       unsigned int size, enum yt921x_l4_type type)
+{
+	for (unsigned int i = 0; i < size; i++)
+		switch (FIELD_GET(YT921X_ACL_KEYb_TYPE_M, entries[i].key[1])) {
+		case YT921X_ACL_TYPE_IPV4_DA:
+		case YT921X_ACL_TYPE_IPV4_SA:
+			entries[i].key[1] |= YT921X_ACL_BINb_IPV4_L4_TYPE(type);
+			entries[i].mask[1] |= YT921X_ACL_BINb_IPV4_L4_TYPE_M;
+			return size;
+		case YT921X_ACL_TYPE_IPV6_DA0:
+		case YT921X_ACL_TYPE_IPV6_DA1:
+		case YT921X_ACL_TYPE_IPV6_DA2:
+		case YT921X_ACL_TYPE_IPV6_DA3:
+		case YT921X_ACL_TYPE_IPV6_SA0:
+		case YT921X_ACL_TYPE_IPV6_SA1:
+		case YT921X_ACL_TYPE_IPV6_SA2:
+		case YT921X_ACL_TYPE_IPV6_SA3:
+			entries[i].key[1] |= YT921X_ACL_BINb_IPV6_L4_TYPE(type);
+			entries[i].mask[1] |= YT921X_ACL_BINb_IPV6_L4_TYPE_M;
+			return size;
+		case YT921X_ACL_TYPE_L4:
+			entries[i].key[1] |= YT921X_ACL_BINb_L4_TYPE(type);
+			entries[i].mask[1] |= YT921X_ACL_BINb_L4_TYPE_M;
+			return size;
+		case YT921X_ACL_TYPE_MISC:
+			entries[i].key[1] |= YT921X_ACL_BINb_MISC_L4_TYPE(type);
+			entries[i].mask[1] |= YT921X_ACL_BINb_MISC_L4_TYPE_M;
+			return size;
+		}
+
+	if (size >= YT921X_ACL_ENT_PER_BLK)
+		return 0;
+
+	entries[size] = (typeof(*entries)){};
+	entries[size].key[1] = YT921X_ACL_BINb_MISC_L4_TYPE(type) |
+			       YT921X_ACL_KEYb_TYPE(YT921X_ACL_TYPE_MISC);
+	entries[size].mask[1] = YT921X_ACL_BINb_MISC_L4_TYPE_M;
+
+	return size + 1;
+}
+
+static struct yt921x_acl_entry *
+yt921x_acl_entries_find(struct yt921x_acl_entry *entries, unsigned int *sizep,
+			u32 type)
+{
+	unsigned int size = *sizep;
+
+	for (unsigned int i = 0; i < size; i++)
+		if (FIELD_GET(YT921X_ACL_KEYb_TYPE_M, entries[i].key[1]) ==
+		    type)
+			return &entries[i];
+
+	if (size >= YT921X_ACL_ENT_PER_BLK)
+		return NULL;
+
+	entries[size] = (typeof(*entries)){};
+	entries[size].key[1] = YT921X_ACL_KEYb_TYPE(type);
+
+	(*sizep)++;
+	return &entries[size];
+}
+
+static void
+yt921x_acl_rule_set_ports(struct yt921x_acl_rule *aclrule, u16 ord,
+			  u16 ports_mask)
+{
+	struct yt921x_acl_entry *entries = aclrule->entries;
+
+	for (unsigned int i = 0; i < hweight8(aclrule->mask); i++) {
+		entries[i].key[1] |= YT921X_ACL_KEYb_SPORTS(ports_mask) |
+				     YT921X_ACL_KEYb_ORD(ord);
+	}
+}
+
+struct yt921x_acl_rule_ext {
+	struct yt921x_acl_rule r;
+
+	struct yt921x_marker marker;
+};
+
+static int
+yt921x_acl_rule_ext_parse_flow_entries(struct yt921x_acl_rule_ext *ruleext,
+				       const struct flow_cls_offload *cls)
+{
+	const struct flow_rule *rule = flow_cls_offload_flow_rule(cls);
+	struct yt921x_acl_entry *entries = ruleext->r.entries;
+	struct netlink_ext_ack *extack = cls->common.extack;
+	const struct flow_dissector *dissector;
+	struct yt921x_acl_entry *entry;
+	unsigned int size = 0;
+	bool want_dport;
+	bool want_sport;
+
+	/* Incomplete and probably won't, since it supports custom u32 filters.
+	 * New adapters are welcome.
+	 */
+	dissector = rule->match.dissector;
+	if (dissector->used_keys &
+	    ~(BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_BASIC) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_PORTS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_PORTS_RANGE) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IP) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_TCP))) {
+		NL_SET_ERR_MSG_MOD(extack, "Unsupported keys used");
+		return -EOPNOTSUPP;
+	}
+
+	/* Entries */
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_IPV4_ADDRS)) {
+		struct flow_match_ipv4_addrs match;
+		bool want_dst;
+		bool want_src;
+
+		flow_rule_match_ipv4_addrs(rule, &match);
+
+		want_dst = !!match.mask->dst;
+		want_src = !!match.mask->src;
+
+		if (want_dst) {
+			entry = yt921x_acl_entries_find(entries, &size,
+							YT921X_ACL_TYPE_IPV4_DA);
+			if (!entry)
+				goto err;
+
+			entry->key[0] |= ntohl(match.key->dst);
+			entry->mask[0] |= ntohl(match.mask->dst);
+		}
+		if (want_src) {
+			entry = yt921x_acl_entries_find(entries, &size,
+							YT921X_ACL_TYPE_IPV4_SA);
+			if (!entry)
+				goto err;
+
+			entry->key[0] |= ntohl(match.key->src);
+			entry->mask[0] |= ntohl(match.mask->src);
+		}
+	}
+
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_IPV6_ADDRS)) {
+		struct flow_match_ipv6_addrs match;
+		bool want_dst;
+		bool want_src;
+
+		flow_rule_match_ipv6_addrs(rule, &match);
+
+		want_dst = !!match.mask->dst.s6_addr32[0] ||
+			   !!match.mask->dst.s6_addr32[1] ||
+			   !!match.mask->dst.s6_addr32[2] ||
+			   !!match.mask->dst.s6_addr32[3];
+		want_src = !!match.mask->src.s6_addr32[0] ||
+			   !!match.mask->src.s6_addr32[1] ||
+			   !!match.mask->src.s6_addr32[2] ||
+			   !!match.mask->src.s6_addr32[3];
+
+		if (want_dst)
+			for (unsigned int i = 0; i < 4; i++) {
+				entry = yt921x_acl_entries_find(entries, &size,
+								YT921X_ACL_TYPE_IPV6_DA0 + i);
+				if (!entry)
+					goto err;
+
+				entry->key[0] |= ntohl(match.key->dst.s6_addr32[i]);
+				entry->mask[0] |= ntohl(match.mask->dst.s6_addr32[i]);
+			}
+		if (want_src)
+			for (unsigned int i = 0; i < 4; i++) {
+				entry = yt921x_acl_entries_find(entries, &size,
+								YT921X_ACL_TYPE_IPV6_SA0 + i);
+				if (!entry)
+					goto err;
+
+				entry->key[0] |= ntohl(match.key->src.s6_addr32[i]);
+				entry->mask[0] |= ntohl(match.mask->src.s6_addr32[i]);
+			}
+	}
+
+	want_dport = false;
+	want_sport = false;
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_PORTS)) {
+		struct flow_match_ports match;
+
+		entry = yt921x_acl_entries_find(entries, &size,
+						YT921X_ACL_TYPE_L4);
+		if (!entry)
+			goto err;
+
+		flow_rule_match_ports(rule, &match);
+
+		want_dport = !!match.mask->dst;
+		want_sport = !!match.mask->src;
+
+		entry->key[0] |= (ntohs(match.key->dst) << 16) |
+				 ntohs(match.key->src);
+		entry->mask[0] |= (ntohs(match.mask->dst) << 16) |
+				  ntohs(match.mask->src);
+	}
+
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_PORTS_RANGE)) {
+		struct flow_match_ports_range match;
+
+		entry = yt921x_acl_entries_find(entries, &size,
+						YT921X_ACL_TYPE_L4);
+		if (!entry)
+			goto err;
+
+		flow_rule_match_ports_range(rule, &match);
+
+		if ((want_dport && !!match.mask->tp.dst) ||
+		    (want_sport && !!match.mask->tp.src)) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Ports and ports range are mutually exclusive");
+			return -EINVAL;
+		}
+
+		entry->key[0] |= (ntohs(match.key->tp_min.dst) << 16) |
+				 ntohs(match.key->tp_min.src);
+		if (match.mask->tp.dst)
+			entry->key[1] |= YT921X_ACL_KEYb_L4_DPORT_RANGE_EN;
+		if (match.mask->tp.src)
+			entry->key[1] |= YT921X_ACL_KEYb_L4_SPORT_RANGE_EN;
+		entry->mask[0] |= (ntohs(match.mask->tp_max.dst) << 16) |
+				  ntohs(match.mask->tp_max.src);
+	}
+
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
+		struct flow_match_eth_addrs match;
+		bool want_dst;
+		bool want_src;
+
+		flow_rule_match_eth_addrs(rule, &match);
+
+		want_dst = !is_zero_ether_addr(match.mask->dst);
+		want_src = !is_zero_ether_addr(match.mask->src);
+
+		if (want_dst) {
+			entry = yt921x_acl_entries_find(entries, &size,
+							YT921X_ACL_TYPE_MAC_DA0);
+			if (!entry)
+				goto err;
+
+			entry->key[0] |= ethaddr_hi4_to_u32(match.key->dst);
+			entry->mask[0] |= ethaddr_hi4_to_u32(match.mask->dst);
+		}
+		if (want_src) {
+			entry = yt921x_acl_entries_find(entries, &size,
+							YT921X_ACL_TYPE_MAC_SA0);
+			if (!entry)
+				goto err;
+
+			entry->key[0] |= ethaddr_hi4_to_u32(match.key->src);
+			entry->mask[0] |= ethaddr_hi4_to_u32(match.mask->src);
+		}
+		if (want_src || want_dst) {
+			entry = yt921x_acl_entries_find(entries, &size,
+							YT921X_ACL_TYPE_MAC_DA1_SA1);
+			if (!entry)
+				goto err;
+
+			entry->key[0] |= (ethaddr_lo2_to_u32(match.key->dst) << 16) |
+					 ethaddr_lo2_to_u32(match.key->src);
+			entry->mask[0] |= (ethaddr_lo2_to_u32(match.mask->dst) << 16) |
+					  ethaddr_lo2_to_u32(match.mask->src);
+		}
+	}
+
+	/* Entries + Misc */
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_BASIC)) {
+		struct flow_match_basic match;
+
+		flow_rule_match_basic(rule, &match);
+
+		if (match.mask->n_proto) {
+			enum yt921x_l3_type type = YT921X_L3_TYPE_OTHER;
+
+			if (match.mask->n_proto == htons(~0))
+				switch (match.key->n_proto) {
+				case htons(ETH_P_IP):
+					type = YT921X_L3_TYPE_IPV4;
+					break;
+				case htons(ETH_P_IPV6):
+					type = YT921X_L3_TYPE_IPV6;
+					break;
+				case htons(ETH_P_ARP):
+					type = YT921X_L3_TYPE_ARP;
+					break;
+				case htons(ETH_P_LLDP):
+					type = YT921X_L3_TYPE_LLDP;
+					break;
+				case htons(ETH_P_PAE):
+					type = YT921X_L3_TYPE_PAE;
+					break;
+				case htons(ETH_P_CFM):
+					type = YT921X_L3_TYPE_ERP;
+					break;
+				}
+
+			if (type != YT921X_L3_TYPE_OTHER) {
+				size = yt921x_acl_entries_set_l3_type(entries,
+								      size,
+								      type);
+				if (!size)
+					goto err;
+			} else {
+				entry = yt921x_acl_entries_find(entries, &size,
+								YT921X_ACL_TYPE_ETHERTYPE);
+				if (!entry)
+					goto err;
+
+				entry->key[0] |= ntohs(match.key->n_proto);
+				entry->mask[0] |= ntohs(match.mask->n_proto);
+			}
+		}
+		if (match.mask->ip_proto) {
+			enum yt921x_l4_type type = YT921X_L4_TYPE_OTHER;
+
+			if (match.mask->ip_proto == (u8)~0)
+				switch (match.key->ip_proto) {
+				case IPPROTO_TCP:
+					type = YT921X_L4_TYPE_TCP;
+					break;
+				case IPPROTO_UDP:
+					type = YT921X_L4_TYPE_UDP;
+					break;
+				case IPPROTO_UDPLITE:
+					type = YT921X_L4_TYPE_UDPLITE;
+					break;
+				case IPPROTO_ICMP:
+					type = YT921X_L4_TYPE_ICMP;
+					break;
+				case IPPROTO_IGMP:
+					type = YT921X_L4_TYPE_IGMP;
+					break;
+				}
+
+			if (type != YT921X_L4_TYPE_OTHER) {
+				size = yt921x_acl_entries_set_l4_type(entries,
+								      size,
+								      type);
+				if (!size)
+					goto err;
+			} else {
+				entry = yt921x_acl_entries_find(entries, &size,
+								YT921X_ACL_TYPE_MISC);
+				if (!entry)
+					goto err;
+
+				entry->key[0] |= YT921X_ACL_BINa_MISC_IP_PROTO(match.key->ip_proto);
+				entry->mask[0] |= YT921X_ACL_BINa_MISC_IP_PROTO(match.mask->ip_proto);
+			}
+		}
+	}
+
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_CONTROL)) {
+		u32 supp_flags = FLOW_DIS_IS_FRAGMENT | FLOW_DIS_FIRST_FRAG;
+		struct flow_match_control match;
+
+		flow_rule_match_control(rule, &match);
+		if (!flow_rule_is_supp_control_flags(supp_flags,
+						     match.mask->flags, extack))
+			return -EOPNOTSUPP;
+
+		if (match.mask->flags & FLOW_DIS_FIRST_FRAG) {
+			bool set = match.key->flags & FLOW_DIS_FIRST_FRAG;
+
+			size = yt921x_acl_entries_set_first_frag(entries, size,
+								 set);
+			if (!size)
+				goto err;
+		}
+		if (match.mask->flags & FLOW_DIS_IS_FRAGMENT) {
+			bool set = match.key->flags & FLOW_DIS_IS_FRAGMENT;
+
+			size = yt921x_acl_entries_set_is_fragment(entries, size,
+								  set);
+			if (!size)
+				goto err;
+		}
+	}
+
+	/* Misc only */
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_IP)) {
+		struct flow_match_ip match;
+
+		flow_rule_match_ip(rule, &match);
+		if (match.mask->ttl)
+			return -EOPNOTSUPP;
+
+		if (match.mask->tos) {
+			entry = yt921x_acl_entries_find(entries, &size,
+							YT921X_ACL_TYPE_MISC);
+			if (!entry)
+				goto err;
+
+			entry->key[0] |= YT921X_ACL_BINa_MISC_TOS(match.key->tos);
+			entry->mask[0] |= YT921X_ACL_BINa_MISC_TOS(match.mask->tos);
+		}
+	}
+
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_TCP)) {
+		struct flow_match_tcp match;
+
+		flow_rule_match_tcp(rule, &match);
+
+		if (match.mask->flags) {
+			entry = yt921x_acl_entries_find(entries, &size,
+							YT921X_ACL_TYPE_MISC);
+			if (!entry)
+				goto err;
+
+			entry->key[0] |= YT921X_ACL_BINa_MISC_TCP_FLAGS(ntohs(match.key->flags));
+			entry->mask[0] |= YT921X_ACL_BINa_MISC_TCP_FLAGS(ntohs(match.mask->flags));
+		}
+	}
+
+	if (!size) {
+		NL_SET_ERR_MSG_MOD(extack, "Empty rule generated, this should not happen");
+		return -EOPNOTSUPP;
+	}
+
+	ruleext->r.mask = (1 << size) - 1;
+	return 0;
+
+err:
+	NL_SET_ERR_MSG_MOD(extack, "Rule too complex");
+	return -EOPNOTSUPP;
+}
+
+static int
+yt921x_acl_rule_ext_parse_flow_action(struct yt921x_acl_rule_ext *ruleext,
+				      const struct flow_action *flow_action,
+				      struct netlink_ext_ack *extack,
+				      struct yt921x_priv *priv, int port)
+{
+	const struct flow_action_entry *act;
+	u32 *action = ruleext->r.action;
+	int res;
+	int i;
+
+	memset(action, 0, 3 * sizeof(*action));
+	flow_action_for_each(i, act, flow_action)
+		switch (act->id) {
+		case FLOW_ACTION_POLICE: {
+			const struct flow_action_police *police = &act->police;
+
+			res = yt921x_police_validate(police, flow_action, act,
+						     extack);
+			if (res)
+				return res;
+
+			res = yt921x_marker_tfm_police(&ruleext->marker, police,
+						       0, priv, port, extack);
+			if (res)
+				return res;
+
+			action[0] |= YT921X_ACL_ACTa_METER_EN;
+			break;
+		}
+		case FLOW_ACTION_ACCEPT:
+			action[2] |= YT921X_ACL_ACTc_REDIR_EN |
+				     YT921X_ACL_ACTc_REDIR_FWD;
+			break;
+		case FLOW_ACTION_DROP:
+			action[2] |= YT921X_ACL_ACTc_REDIR_EN |
+				     YT921X_ACL_ACTc_REDIR_STEER;
+			break;
+		case FLOW_ACTION_REDIRECT: {
+			struct dsa_port *to_dp;
+
+			to_dp = dsa_port_from_netdev(act->dev);
+			if (IS_ERR(to_dp)) {
+				NL_SET_ERR_MSG_MOD(extack,
+						   "Destination not a switch port");
+				return -EOPNOTSUPP;
+			}
+
+			action[2] |= YT921X_ACL_ACTc_REDIR_EN |
+				     YT921X_ACL_ACTc_REDIR_STEER |
+				     YT921X_ACL_ACTc_REDIR_DPORTn(to_dp->index);
+			break;
+		}
+		case FLOW_ACTION_TRAP:
+			action[2] |= YT921X_ACL_ACTc_REDIR_EN |
+				     YT921X_ACL_ACTc_REDIR_TRAP;
+			break;
+		case FLOW_ACTION_PRIORITY:
+			if (act->priority >= YT921X_PRIO_NUM) {
+				NL_SET_ERR_MSG_MOD(extack,
+						   "Priority value is too high");
+				return -EOPNOTSUPP;
+			}
+			action[0] |= YT921X_ACL_ACTa_PRIO_EN;
+			action[1] |= YT921X_ACL_ACTb_PRIO(act->priority);
+			break;
+		default:
+			NL_SET_ERR_MSG_MOD(extack, "Action not supported");
+			return -EOPNOTSUPP;
+		}
+
+	return 0;
+}
+
+static int
+yt921x_acl_rule_ext_parse_flow(struct yt921x_acl_rule_ext *ruleext, int port,
+			       const struct flow_cls_offload *cls, bool ingress,
+			       struct yt921x_priv *priv)
+{
+	const struct flow_rule *rule = flow_cls_offload_flow_rule(cls);
+	struct netlink_ext_ack *extack = cls->common.extack;
+	int res;
+
+	if (!ingress || cls->common.chain_index)
+		return -EOPNOTSUPP;
+
+	res = yt921x_acl_rule_ext_parse_flow_action(ruleext, &rule->action,
+						    extack, priv, port);
+	if (res)
+		return res;
+	res = yt921x_acl_rule_ext_parse_flow_entries(ruleext, cls);
+	if (res)
+		return res;
+
+	yt921x_acl_rule_set_ports(&ruleext->r, 0, BIT(port));
+	ruleext->r.tag = cls->cookie;
+	ruleext->r.type = TC_SETUP_CLSFLOWER;
+	return 0;
+}
+
+static unsigned int
+yt921x_acl_find(const struct yt921x_priv *priv, enum tc_setup_type type,
+		unsigned long tag)
+{
+	for (unsigned int blkid = 0; blkid < YT921X_ACL_BLK_NUM; blkid++) {
+		const struct yt921x_acl_blk *aclblk = priv->acl_blks[blkid];
+
+		if (!aclblk)
+			continue;
+
+		for (unsigned int i = 0; i < YT921X_ACL_ENT_PER_BLK; i++)
+			if (aclblk->rules[i] && aclblk->rules[i]->tag == tag &&
+			    aclblk->rules[i]->type == type)
+				return YT921X_ACL_ENT_PER_BLK * blkid + i;
+	}
+
+	return UINT_MAX;
+}
+
+static unsigned int
+yt921x_acl_reserve(struct yt921x_priv *priv, unsigned int entscnt,
+		   struct netlink_ext_ack *extack)
+{
+	int candidates[YT921X_ACL_ENT_PER_BLK];
+	unsigned int acl_used_cnt = 0;
+
+	if (WARN_ON(entscnt > YT921X_ACL_ENT_PER_BLK))
+		return UINT_MAX;
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(candidates); i++)
+		candidates[i] = -1;
+	for (unsigned int i = 0; i < YT921X_ACL_BLK_NUM; i++) {
+		unsigned int blk_used_cnt = hweight8(priv->acl_masks[i]);
+
+		candidates[blk_used_cnt] = i;
+		acl_used_cnt += blk_used_cnt;
+	}
+
+	if (acl_used_cnt >= YT921X_ACL_NUM) {
+		NL_SET_ERR_MSG_MOD(extack, "ACL entry limit reached");
+		return UINT_MAX;
+	}
+	if (acl_used_cnt + entscnt <= YT921X_ACL_NUM)
+		for (unsigned int i = YT921X_ACL_ENT_PER_BLK - entscnt + 1;
+		     i-- > 0;)
+			if (candidates[i] >= 0)
+				return YT921X_ACL_ENT_PER_BLK * candidates[i] +
+				       ffz(priv->acl_masks[candidates[i]]);
+
+	NL_SET_ERR_MSG_MOD(extack,
+			   "ACL entry allocation failed, simplify your rules or remove existing rules");
+	return UINT_MAX;
+}
+
+static int
+yt921x_acl_commit(struct yt921x_priv *priv, unsigned int entid, u8 entsmask)
+{
+	const struct yt921x_acl_rule *aclrule;
+	const struct yt921x_acl_blk *aclblk;
+	unsigned int blkid;
+	unsigned int binid;
+	unsigned long mask;
+	u32 zeros[3] = {};
+	unsigned int i;
+	unsigned int o;
+	u32 ctrl;
+	int res;
+
+	blkid = entid / YT921X_ACL_ENT_PER_BLK;
+	binid = entid % YT921X_ACL_ENT_PER_BLK;
+	aclblk = priv->acl_blks[blkid];
+	aclrule = aclblk->rules[binid];
+
+	/* Open the block */
+	ctrl = YT921X_ACL_BLK_CMD_MODIFY | YT921X_ACL_BLK_CMD_BLKID(blkid);
+	res = yt921x_reg_write(priv, YT921X_ACL_BLK_CMD, ctrl);
+	if (res)
+		return res;
+
+	/* Write keys and masks */
+	ctrl = 0;
+	for (unsigned int i = 0; i < YT921X_ACL_ENT_PER_BLK; i++)
+		ctrl |= YT921X_ACL_BLK_KEEP_KEEPn(i);
+
+	mask = entsmask;
+	i = 0;
+	for_each_set_bit(o, &mask, YT921X_ACL_ENT_PER_BLK) {
+		res = yt921x_reg64_write(priv, YT921X_ACLn_KEYm(blkid, o),
+					 aclrule ? aclrule->entries[i].key :
+					 zeros);
+		if (res)
+			return res;
+
+		res = yt921x_reg64_write(priv, YT921X_ACLn_MASKm(blkid, o),
+					 aclrule ? aclrule->entries[i].mask :
+					 zeros);
+		if (res)
+			return res;
+
+		ctrl &= ~YT921X_ACL_BLK_KEEP_KEEPn(o);
+		i++;
+	}
+
+	res = yt921x_reg_write(priv, YT921X_ACL_BLK_KEEP, ctrl);
+	if (res)
+		return res;
+
+	ctrl = 0;
+	for (unsigned int i = 0; i < YT921X_ACL_ENT_PER_BLK; i++) {
+		const struct yt921x_acl_rule *other = aclblk->rules[i];
+
+		if (!other)
+			continue;
+
+		mask = other->mask;
+		for_each_set_bit(o, &mask, YT921X_ACL_ENT_PER_BLK)
+			ctrl |= YT921X_ACL_ENTRY_ENm(o) |
+				YT921X_ACL_ENTRY_GRPIDm(o, i);
+	}
+	res = yt921x_reg_write(priv, YT921X_ACLn_ENTRY(blkid), ctrl);
+	if (res)
+		return res;
+
+	/* Close the block */
+	ctrl = YT921X_ACL_BLK_CMD_BLKID(blkid);
+	res = yt921x_reg_write(priv, YT921X_ACL_BLK_CMD, ctrl);
+	if (res)
+		return res;
+
+	/* Write actions */
+	res = yt921x_reg96_write(priv, YT921X_ACLn_ACT(entid),
+				 aclrule ? aclrule->action : zeros);
+	if (res)
+		return res;
+
+	return 0;
+}
+
+static int
+yt921x_acl_del(struct yt921x_priv *priv, enum tc_setup_type type,
+	       unsigned long tag)
+{
+	struct device *dev = to_device(priv);
+	struct yt921x_acl_rule *aclrule;
+	struct yt921x_acl_blk *aclblk;
+	unsigned int binid;
+	unsigned int blkid;
+	unsigned int entid;
+	int res;
+
+	entid = yt921x_acl_find(priv, type, tag);
+	if (entid == UINT_MAX)
+		return -ENOENT;
+
+	blkid = entid / YT921X_ACL_ENT_PER_BLK;
+	binid = entid % YT921X_ACL_ENT_PER_BLK;
+	aclblk = priv->acl_blks[blkid];
+	aclrule = aclblk->rules[binid];
+
+	aclblk->rules[binid] = NULL;
+	res = yt921x_acl_commit(priv, entid, aclrule->mask);
+	if (res) {
+		aclblk->rules[binid] = aclrule;
+		return res;
+	}
+
+	if (aclrule->action[0] & YT921X_ACL_ACTa_METER_EN)
+		clear_bit(FIELD_GET(YT921X_ACL_ACTa_METER_ID_M,
+				    aclrule->action[0]),
+			  priv->meters_map);
+	priv->acl_masks[blkid] &= ~aclrule->mask;
+	devm_kfree(dev, aclrule);
+	if (!priv->acl_masks[blkid]) {
+		devm_kfree(dev, aclblk);
+		priv->acl_blks[blkid] = NULL;
+	}
+	return 0;
+}
+
+static int
+yt921x_acl_add(struct yt921x_priv *priv,
+	       const struct yt921x_acl_rule_ext *ruleext,
+	       struct netlink_ext_ack *extack)
+{
+	bool want_meter = ruleext->r.action[0] & YT921X_ACL_ACTa_METER_EN;
+	unsigned int entscnt = hweight8(ruleext->r.mask);
+	struct device *dev = to_device(priv);
+	struct yt921x_acl_rule *aclrule;
+	struct yt921x_acl_blk *aclblk;
+	unsigned int meterid;
+	unsigned long mask;
+	unsigned int binid;
+	unsigned int blkid;
+	unsigned int entid;
+	unsigned int o;
+	int res;
+
+	/* Allocate resources */
+	entid = yt921x_acl_reserve(priv, entscnt, extack);
+	if (entid == UINT_MAX)
+		return -EOPNOTSUPP;
+
+	if (want_meter) {
+		meterid = find_first_zero_bit(priv->meters_map,
+					      YT921X_METER_NUM);
+		if (meterid >= YT921X_METER_NUM) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "No more meters available");
+			return -EOPNOTSUPP;
+		}
+
+		res = yt921x_meter_config(priv, meterid, &ruleext->marker);
+		if (res)
+			return res;
+	}
+
+	/* Prepare acl block ctrlblk */
+	blkid = entid / YT921X_ACL_ENT_PER_BLK;
+	binid = entid % YT921X_ACL_ENT_PER_BLK;
+	aclblk = priv->acl_blks[blkid];
+	if (!aclblk) {
+		aclblk = devm_kzalloc(dev, sizeof(*aclblk), GFP_KERNEL);
+		if (!aclblk)
+			return -ENOMEM;
+		priv->acl_blks[blkid] = aclblk;
+	}
+
+	/* Prepare acl rule ctrlblk */
+	aclrule = devm_kmemdup(dev, &ruleext->r,
+			       offsetof(struct yt921x_acl_rule,
+					entries[entscnt]),
+			       GFP_KERNEL);
+	if (!aclrule) {
+		res = -ENOMEM;
+		goto err;
+	}
+
+	/* Replace the placeholder resource IDs */
+	aclrule->mask = 0;
+	mask = priv->acl_masks[blkid];
+	for_each_clear_bit(o, &mask, YT921X_ACL_ENT_PER_BLK) {
+		aclrule->mask |= BIT(o);
+		entscnt--;
+		if (!entscnt)
+			break;
+	}
+
+	if (want_meter)
+		aclrule->action[0] |= YT921X_ACL_ACTa_METER_ID(meterid);
+
+	/* Write rules */
+	aclblk->rules[binid] = aclrule;
+	res = yt921x_acl_commit(priv, entid, aclrule->mask);
+	if (res) {
+		aclblk->rules[binid] = NULL;
+		devm_kfree(dev, aclrule);
+		goto err;
+	}
+
+	if (want_meter)
+		set_bit(meterid, priv->meters_map);
+	priv->acl_masks[blkid] |= aclrule->mask;
+	return 0;
+
+err:
+	if (!priv->acl_masks[blkid]) {
+		devm_kfree(dev, aclblk);
+		priv->acl_blks[blkid] = NULL;
+	}
+	return res;
+}
+
+static int
+yt921x_dsa_cls_flower_del(struct dsa_switch *ds, int port,
+			  struct flow_cls_offload *cls, bool ingress)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_acl_del(priv, TC_SETUP_CLSFLOWER, cls->cookie);
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
+static int
+yt921x_dsa_cls_flower_add(struct dsa_switch *ds, int port,
+			  struct flow_cls_offload *cls, bool ingress)
+{
+	struct netlink_ext_ack *extack = cls->common.extack;
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_acl_rule_ext ruleext;
+	int res;
+
+	res = yt921x_acl_rule_ext_parse_flow(&ruleext, port, cls, ingress,
+					     priv);
+	if (res)
+		return res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_acl_add(priv, &ruleext, extack);
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
 static int
 yt921x_mirror_del(struct yt921x_priv *priv, int port, bool ingress)
 {
@@ -1747,12 +2706,12 @@ yt921x_fdb_in01(struct yt921x_priv *priv, const unsigned char *addr,
 	u32 ctrl;
 	int res;
 
-	ctrl = (addr[0] << 24) | (addr[1] << 16) | (addr[2] << 8) | addr[3];
+	ctrl = ethaddr_hi4_to_u32(addr);
 	res = yt921x_reg_write(priv, YT921X_FDB_IN0, ctrl);
 	if (res)
 		return res;
 
-	ctrl = ctrl1 | YT921X_FDB_IO1_FID(vid) | (addr[4] << 8) | addr[5];
+	ctrl = ctrl1 | YT921X_FDB_IO1_FID(vid) | ethaddr_lo2_to_u32(addr);
 	return yt921x_reg_write(priv, YT921X_FDB_IN1, ctrl);
 }
 
@@ -3613,6 +4572,24 @@ static int yt921x_chip_setup_tc(struct yt921x_priv *priv)
 	return 0;
 }
 
+static int yt921x_chip_setup_acl(struct yt921x_priv *priv)
+{
+	u32 ctrl;
+	int res;
+
+	ctrl = YT921X_ACL_PERMIT_UNMATCH_PORTS_M;
+	res = yt921x_reg_write(priv, YT921X_ACL_PERMIT_UNMATCH, ctrl);
+	if (res)
+		return res;
+
+	ctrl = YT921X_ACL_PORT_PORTS_M;
+	res = yt921x_reg_write(priv, YT921X_ACL_PORT, ctrl);
+	if (res)
+		return res;
+
+	return 0;
+}
+
 static int __maybe_unused yt921x_chip_setup_qos(struct yt921x_priv *priv)
 {
 	u32 ctrl;
@@ -3659,7 +4636,7 @@ static int yt921x_chip_setup(struct yt921x_priv *priv)
 	u32 ctrl;
 	int res;
 
-	ctrl = YT921X_FUNC_MIB | YT921X_FUNC_METER;
+	ctrl = YT921X_FUNC_MIB | YT921X_FUNC_ACL | YT921X_FUNC_METER;
 	res = yt921x_reg_set_bits(priv, YT921X_FUNC, ctrl);
 	if (res)
 		return res;
@@ -3672,6 +4649,10 @@ static int yt921x_chip_setup(struct yt921x_priv *priv)
 	if (res)
 		return res;
 
+	res = yt921x_chip_setup_acl(priv);
+	if (res)
+		return res;
+
 #if IS_ENABLED(CONFIG_DCB)
 	res = yt921x_chip_setup_qos(priv);
 	if (res)
@@ -3767,6 +4748,9 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
 	.port_policer_del	= yt921x_dsa_port_policer_del,
 	.port_policer_add	= yt921x_dsa_port_policer_add,
 	.port_setup_tc		= yt921x_dsa_port_setup_tc,
+	/* acl */
+	.cls_flower_del		= yt921x_dsa_cls_flower_del,
+	.cls_flower_add		= yt921x_dsa_cls_flower_add,
 	/* hsr */
 	.port_hsr_leave		= dsa_port_simple_hsr_leave,
 	.port_hsr_join		= dsa_port_simple_hsr_join,
diff --git a/drivers/net/dsa/yt921x.h b/drivers/net/dsa/yt921x.h
index 70fa780c337f..ddfa8774931a 100644
--- a/drivers/net/dsa/yt921x.h
+++ b/drivers/net/dsa/yt921x.h
@@ -24,6 +24,7 @@
 #define  YT921X_RST_SW				BIT(1)
 #define YT921X_FUNC			0x80004
 #define  YT921X_FUNC_METER			BIT(4)
+#define  YT921X_FUNC_ACL			BIT(2)
 #define  YT921X_FUNC_MIB			BIT(1)
 #define YT921X_CHIP_ID			0x80008
 #define  YT921X_CHIP_ID_MAJOR			GENMASK(31, 16)
@@ -420,6 +421,10 @@ enum yt921x_app_selector {
 #define  YT921X_CPU_COPY_FORCE_INT_PORT		BIT(2)
 #define  YT921X_CPU_COPY_TO_INT_CPU		BIT(1)
 #define  YT921X_CPU_COPY_TO_EXT_CPU		BIT(0)
+#define YT921X_ACL_PERMIT_UNMATCH	0x1806a0
+#define  YT921X_ACL_PERMIT_UNMATCH_PORTS_M	GENMASK(10, 0)
+#define   YT921X_ACL_PERMIT_UNMATCH_PORTS(x)		FIELD_PREP(YT921X_ACL_PERMIT_UNMATCH_PORTS_M, (x))
+#define  YT921X_ACL_PERMIT_UNMATCH_PORTn(port)	BIT(port)
 #define YT921X_ACT_UNK_UCAST		0x180734
 #define YT921X_ACT_UNK_MCAST		0x180738
 #define  YT921X_ACT_UNK_MCAST_BYPASS_DROP_RMA	BIT(23)
@@ -454,6 +459,249 @@ enum yt921x_app_selector {
 #define  YT921X_VLAN_CTRLa_METER_EN		BIT(5)
 #define  YT921X_VLAN_CTRLa_METER_ID_M		GENMASK(4, 0)
 
+#define YT921X_ACLn_ACT(n)		(0x1c0000 + 0x10 * (n))
+#define  YT921X_ACL_ACTc_STAG_M			GENMASK(26, 25)
+#define   YT921X_ACL_ACTc_STAG(x)			FIELD_PREP(YT921X_ACL_ACTc_STAG_M, (x))
+#define   YT921X_ACL_ACTc_STAG_DONTCARE			YT921X_ACL_ACTc_STAG(0)
+#define   YT921X_ACL_ACTc_STAG_UNTAG			YT921X_ACL_ACTc_STAG(1)
+#define   YT921X_ACL_ACTc_STAG_TAG			YT921X_ACL_ACTc_STAG(2)
+#define   YT921X_ACL_ACTc_STAG_KEEP			YT921X_ACL_ACTc_STAG(3)
+#define  YT921X_ACL_ACTc_CTAG_M			GENMASK(24, 23)
+#define   YT921X_ACL_ACTc_CTAG(x)			FIELD_PREP(YT921X_ACL_ACTc_CTAG_M, (x))
+#define   YT921X_ACL_ACTc_CTAG_DONTCARE			YT921X_ACL_ACTc_CTAG(0)
+#define   YT921X_ACL_ACTc_CTAG_UNTAG			YT921X_ACL_ACTc_CTAG(1)
+#define   YT921X_ACL_ACTc_CTAG_TAG			YT921X_ACL_ACTc_CTAG(2)
+#define   YT921X_ACL_ACTc_CTAG_KEEP			YT921X_ACL_ACTc_CTAG(3)
+#define  YT921X_ACL_ACTc_REDIR_M		GENMASK(22, 21)
+#define   YT921X_ACL_ACTc_REDIR(x)			FIELD_PREP(YT921X_ACL_ACTc_REDIR_M, (x))
+#define   YT921X_ACL_ACTc_REDIR_FWD			YT921X_ACL_ACTc_REDIR(0)
+#define   YT921X_ACL_ACTc_REDIR_COPY			YT921X_ACL_ACTc_REDIR(1)
+#define   YT921X_ACL_ACTc_REDIR_STEER			YT921X_ACL_ACTc_REDIR(2)	/* steer to no port -> drop */
+#define   YT921X_ACL_ACTc_REDIR_TRAP			YT921X_ACL_ACTc_REDIR(3)
+#define  YT921X_ACL_ACTc_REDIR_DPORTS_M		GENMASK(20, 10)
+#define   YT921X_ACL_ACTc_REDIR_DPORTS(x)		FIELD_PREP(YT921X_ACL_ACTc_REDIR_DPORTS_M, (x))
+#define  YT921X_ACL_ACTc_REDIR_DPORTn(port)	BIT((port) + 10)
+#define  YT921X_ACL_ACTc_REDIR_EN		BIT(9)
+#define  YT921X_ACL_ACTc_SDEI			BIT(8)
+#define  YT921X_ACL_ACTc_SDEI_REPLACE		BIT(7)
+#define  YT921X_ACL_ACTc_SPRI_M			GENMASK(6, 4)
+#define   YT921X_ACL_ACTc_SPRI(x)			FIELD_PREP(YT921X_ACL_ACTc_SPRI_M, (x))
+#define  YT921X_ACL_ACTc_SPRI_REPLACE		BIT(3)
+#define  YT921X_ACL_ACTbc_SVID_M		GENMASK_ULL(34, 23)
+#define   YT921X_ACL_ACTbc_SVID(x)			FIELD_PREP(YT921X_ACL_ACTbc_SVID_M, (x))
+#define  YT921X_ACL_ACTb_SVID_REPLACE		BIT(22)
+#define  YT921X_ACL_ACTb_CDEI			BIT(21)
+#define  YT921X_ACL_ACTb_CDEI_REPLACE		BIT(20)
+#define  YT921X_ACL_ACTb_CPRI_M			GENMASK(19, 17)
+#define   YT921X_ACL_ACTb_CPRI(x)			FIELD_PREP(YT921X_ACL_ACTb_CPRI_M, (x))
+#define  YT921X_ACL_ACTb_CPRI_REPLACE		BIT(16)
+#define  YT921X_ACL_ACTb_CVID_M			GENMASK(15, 4)
+#define   YT921X_ACL_ACTb_CVID(x)			FIELD_PREP(YT921X_ACL_ACTb_CVID_M, (x))
+#define  YT921X_ACL_ACTb_CVID_REPLACE		BIT(3)
+#define  YT921X_ACL_ACTb_PRIO_M			GENMASK(2, 0)
+#define   YT921X_ACL_ACTb_PRIO(x)			FIELD_PREP(YT921X_ACL_ACTb_PRIO_M, (x))
+#define  YT921X_ACL_ACTa_PRIO_EN		BIT(31)
+#define  YT921X_ACL_ACTa_COLOR_M		GENMASK(30, 29)
+#define   YT921X_ACL_ACTa_COLOR(x)			FIELD_PREP(YT921X_ACL_ACTa_COLOR_M, (x))
+#define   YT921X_ACL_ACTa_COLOR_GREEN			YT921X_ACL_ACTa_COLOR(0)
+#define   YT921X_ACL_ACTa_COLOR_YELLOW			YT921X_ACL_ACTa_COLOR(1)
+#define   YT921X_ACL_ACTa_COLOR_RED			YT921X_ACL_ACTa_COLOR(2)
+#define  YT921X_ACL_ACTa_COLOR_EN		BIT(28)
+#define  YT921X_ACL_ACTa_DSCP_M			GENMASK(27, 22)
+#define   YT921X_ACL_ACTa_DSCP(x)			FIELD_PREP(YT921X_ACL_ACTa_DSCP_M, (x))
+#define  YT921X_ACL_ACTa_DSCP_REPLACE		BIT(21)
+#define  YT921X_ACL_ACTa_METER_ID_M		GENMASK(20, 15)
+#define   YT921X_ACL_ACTa_METER_ID(x)			FIELD_PREP(YT921X_ACL_ACTa_METER_ID_M, (x))
+#define  YT921X_ACL_ACTa_METER_EN		BIT(14)
+#define  YT921X_ACL_ACTa_MIRROR_EN		BIT(13)
+#define  YT921X_ACL_ACTa_FLOWSTAT_EN		BIT(12)
+#define  YT921X_ACL_ACTa_FLOWSTAT_ID_M		GENMASK(11, 6)
+#define   YT921X_ACL_ACTa_FLOWSTAT_ID(x)		FIELD_PREP(YT921X_ACL_ACTa_FLOWSTAT_ID_M, (x))
+#define  YT921X_ACL_ACTa_GPIO_EN		BIT(5)
+#define  YT921X_ACL_ACTa_GPIO_PIN_M		GENMASK(4, 1)
+#define   YT921X_ACL_ACTa_GPIO_PIN(x)			FIELD_PREP(YT921X_ACL_ACTa_GPIO_PIN_M, (x))
+#define  YT921X_ACL_ACTa_INTR_EN		BIT(0)
+#define YT921X_ACL_BLK_KEEP		0x201000
+#define  YT921X_ACL_BLK_KEEP_GRPIDn_M(bin)	(7 << (4 * (bin) + 1))
+#define   YT921X_ACL_BLK_KEEP_GRPIDn(bin, x)		((x) << (4 * (bin) + 1))
+#define  YT921X_ACL_BLK_KEEP_KEEPn(bin)		BIT(4 * (bin))
+#define YT921X_ACL_PORT			0x202000
+#define  YT921X_ACL_PORT_PORTS_M		GENMASK(10, 0)
+#define   YT921X_ACL_PORT_PORTS(x)			FIELD_PREP(YT921X_ACL_PORT_PORTS_M, (x))
+#define  YT921X_ACL_PORT_PORTn(port)		BIT(port)
+#define YT921X_ACL_BLK_CMD		0x202004
+#define  YT921X_ACL_BLK_CMD_BLKID_M		GENMASK(6, 1)
+#define   YT921X_ACL_BLK_CMD_BLKID(x)			FIELD_PREP(YT921X_ACL_BLK_CMD_BLKID_M, (x))
+#define  YT921X_ACL_BLK_CMD_MODIFY		BIT(0)
+#define YT921X_ACLn_ENTRY(blk)		(0x203000 + 4 * (blk))
+#define  YT921X_ACL_ENTRY_GRPIDm_M(bin)		(7 << (4 * (bin) + 1))
+#define   YT921X_ACL_ENTRY_GRPIDm(bin, x)		((x) << (4 * (bin) + 1))
+#define  YT921X_ACL_ENTRY_ENm(bin)		BIT(4 * (bin))
+#define YT921X_ACLn_KEYm(blk, bin)	(0x204000 + 0x200 * (bin) + 8 * (blk))
+#define  YT921X_ACL_KEYb_ORD_M			GENMASK(29, 21)
+#define   YT921X_ACL_KEYb_ORD(x)			FIELD_PREP(YT921X_ACL_KEYb_ORD_M, (x))
+#define  YT921X_ACL_KEYb_SPORTS_M		GENMASK(20, 10)
+#define   YT921X_ACL_KEYb_SPORTS(x)			FIELD_PREP(YT921X_ACL_KEYb_SPORTS_M, (x))
+#define  YT921X_ACL_KEYb_SPORTn(port)		BIT((port) + 10)
+#define  YT921X_ACL_KEYb_REVERSE		BIT(9)	/* reverse match */
+#define  YT921X_ACL_KEYb_TYPE_M			GENMASK(8, 4)
+#define   YT921X_ACL_KEYb_TYPE(x)			FIELD_PREP(YT921X_ACL_KEYb_TYPE_M, (x))
+/* KEY_* fields need no masks */
+#define YT921X_ACLn_MASKm(blk, bin)	(0x205000 + 0x200 * (bin) + 8 * (blk))
+
+enum yt921x_acl_type {
+	YT921X_ACL_TYPE_NA,
+	YT921X_ACL_TYPE_MAC_DA0,
+	YT921X_ACL_TYPE_MAC_SA0,
+	YT921X_ACL_TYPE_MAC_DA1_SA1,
+	YT921X_ACL_TYPE_VLAN,
+	YT921X_ACL_TYPE_VTAG,
+	YT921X_ACL_TYPE_IPV4_DA,
+	YT921X_ACL_TYPE_IPV4_SA,
+	YT921X_ACL_TYPE_IPV6_DA0,
+	YT921X_ACL_TYPE_IPV6_DA1,
+	YT921X_ACL_TYPE_IPV6_DA2,
+	YT921X_ACL_TYPE_IPV6_DA3,
+	YT921X_ACL_TYPE_IPV6_SA0,
+	YT921X_ACL_TYPE_IPV6_SA1,
+	YT921X_ACL_TYPE_IPV6_SA2,
+	YT921X_ACL_TYPE_IPV6_SA3,
+	YT921X_ACL_TYPE_MISC,
+	YT921X_ACL_TYPE_L4,
+	YT921X_ACL_TYPE_UDF0,
+	YT921X_ACL_TYPE_UDF1,
+	YT921X_ACL_TYPE_UDF2,
+	YT921X_ACL_TYPE_UDF3,
+	YT921X_ACL_TYPE_UDF4,
+	YT921X_ACL_TYPE_UDF5,
+	YT921X_ACL_TYPE_UDF6,
+	YT921X_ACL_TYPE_UDF7,
+	YT921X_ACL_TYPE_ETHERTYPE,
+	YT921X_ACL_TYPE_NUM
+};
+
+/* Range: turn KEY:MASK into MIN:MAX */
+
+#define  YT921X_ACL_BINb_MAC_xA0_L3_TYPE_M	GENMASK(3, 0)
+#define   YT921X_ACL_BINb_MAC_xA0_L3_TYPE(x)		FIELD_PREP(YT921X_ACL_BINb_MAC_xA0_L3_TYPE_M, (x))
+#define  YT921X_ACL_BINa_MAC_xA0_MAC_xA0_M	GENMASK(31, 0)
+
+#define  YT921X_ACL_BINb_MAC_DA1_SA1_L2_TYPE_M	GENMASK(2, 0)
+#define   YT921X_ACL_BINb_MAC_DA1_SA1_L2_TYPE(x)	FIELD_PREP(YT921X_ACL_BINb_MAC_DA1_SA1_L2_TYPE_M, (x))
+#define  YT921X_ACL_BINa_MAC_DA1_SA1_MAC_DA1_M	GENMASK(31, 16)
+#define  YT921X_ACL_BINa_MAC_DA1_SA1_MAC_SA1_M	GENMASK(15, 0)
+
+#define  YT921X_ACL_KEYb_VLAN_SVID_RANGE_EN	BIT(31)
+#define  YT921X_ACL_KEYb_VLAN_CVID_RANGE_EN	BIT(30)
+#define  YT921X_ACL_BINb_VLAN_CDEI		BIT(3)
+#define  YT921X_ACL_BINb_VLAN_CPRI_M		GENMASK(2, 0)
+#define   YT921X_ACL_BINb_VLAN_CPRI(x)			FIELD_PREP(YT921X_ACL_BINb_VLAN_CPRI_M, (x))
+#define  YT921X_ACL_BINa_VLAN_CTAG_FMT_M	GENMASK(31, 30)
+#define   YT921X_ACL_BINa_VLAN_CTAG_FMT(x)		FIELD_PREP(YT921X_ACL_BINa_VLAN_CTAG_FMT_M, (x))
+#define  YT921X_ACL_BINa_VLAN_SDEI		BIT(29)
+#define  YT921X_ACL_BINa_VLAN_SPRI_M		GENMASK(28, 26)
+#define   YT921X_ACL_BINa_VLAN_SPRI(x)			FIELD_PREP(YT921X_ACL_BINa_VLAN_SPRI_M, (x))
+#define  YT921X_ACL_BINa_VLAN_STAG_FMT_M	GENMASK(25, 24)
+#define   YT921X_ACL_BINa_VLAN_STAG_FMT(x)		FIELD_PREP(YT921X_ACL_BINa_VLAN_STAG_FMT_M, (x))
+#define  YT921X_ACL_BINa_VLAN_SVID_M		GENMASK(23, 12)
+#define   YT921X_ACL_BINa_VLAN_SVID(x)			FIELD_PREP(YT921X_ACL_BINa_VLAN_SVID_M, (x))
+#define  YT921X_ACL_BINa_VLAN_CVID_M		GENMASK(11, 0)
+#define   YT921X_ACL_BINa_VLAN_CVID(x)			FIELD_PREP(YT921X_ACL_BINa_VLAN_CVID_M, (x))
+
+#define  YT921X_ACL_KEYb_VTAG_SVID_RANGE_EN	BIT(31)
+#define  YT921X_ACL_KEYb_VTAG_CVID_RANGE_EN	BIT(30)
+#define  YT921X_ACL_BINa_VTAG_CDEI		BIT(31)
+#define  YT921X_ACL_BINa_VTAG_CPRI_M		GENMASK(30, 28)
+#define   YT921X_ACL_BINa_VTAG_CPRI(x)			FIELD_PREP(YT921X_ACL_BINa_VTAG_CPRI_M, (x))
+#define  YT921X_ACL_BINa_VTAG_SDEI		BIT(27)
+#define  YT921X_ACL_BINa_VTAG_SPRI_M		GENMASK(26, 24)
+#define   YT921X_ACL_BINa_VTAG_SPRI(x)			FIELD_PREP(YT921X_ACL_BINa_VTAG_SPRI_M, (x))
+#define  YT921X_ACL_BINa_VTAG_SVID_M		GENMASK(23, 12)
+#define   YT921X_ACL_BINa_VTAG_SVID(x)			FIELD_PREP(YT921X_ACL_BINa_VTAG_SVID_M, (x))
+#define  YT921X_ACL_BINa_VTAG_CVID_M		GENMASK(11, 0)
+#define   YT921X_ACL_BINa_VTAG_CVID(x)			FIELD_PREP(YT921X_ACL_BINa_VTAG_CVID_M, (x))
+
+#define  YT921X_ACL_KEYb_IPV4_ADDR_RANGE_EN	BIT(30)
+#define  YT921X_ACL_BINb_IPV4_FRAG		BIT(3)
+#define  YT921X_ACL_BINb_IPV4_L4_TYPE_M		GENMASK(2, 0)
+#define   YT921X_ACL_BINb_IPV4_L4_TYPE(x)		FIELD_PREP(YT921X_ACL_BINb_IPV4_L4_TYPE_M, (x))
+#define  YT921X_ACL_BINa_IPV4_ADDR_M		GENMASK(31, 0)
+
+#define  YT921X_ACL_BINb_IPV6_L4_TYPE_M		GENMASK(2, 0)
+#define   YT921X_ACL_BINb_IPV6_L4_TYPE(x)		FIELD_PREP(YT921X_ACL_BINb_IPV6_L4_TYPE_M, (x))
+#define  YT921X_ACL_BINa_IPV6_ADDRx_M		GENMASK(31, 0)
+
+#define  YT921X_ACL_BINb_IPV6_xA1_IP_OPTION	BIT(3)
+
+#define  YT921X_ACL_BINb_IPV6_xA2_FIRST_FRAG	BIT(3)
+
+#define  YT921X_ACL_KEYb_IPV6_xA3_ADDR_RANGE_EN	BIT(30)
+#define  YT921X_ACL_BINb_IPV6_xA3_FRAG		BIT(3)
+
+#define  YT921X_ACL_BINb_MISC_FRAG		BIT(3)
+#define  YT921X_ACL_BINb_MISC_L4_TYPE_M		GENMASK(2, 0)
+#define   YT921X_ACL_BINb_MISC_L4_TYPE(x)		FIELD_PREP(YT921X_ACL_BINb_MISC_L4_TYPE_M, (x))
+#define  YT921X_ACL_BINa_MISC_PPPOE_FLAG	BIT(30)
+#define  YT921X_ACL_BINa_MISC_FIRST_FRAG	BIT(29)
+#define  YT921X_ACL_BINa_MISC_IP_OPTION		BIT(28)
+#define  YT921X_ACL_BINa_MISC_TCP_FLAGS_M	GENMASK(27, 20)
+#define   YT921X_ACL_BINa_MISC_TCP_FLAGS(x)		FIELD_PREP(YT921X_ACL_BINa_MISC_TCP_FLAGS_M, (x))
+#define  YT921X_ACL_BINa_MISC_IP_PROTO_M	GENMASK(19, 12)
+#define   YT921X_ACL_BINa_MISC_IP_PROTO(x)		FIELD_PREP(YT921X_ACL_BINa_MISC_IP_PROTO_M, (x))
+#define  YT921X_ACL_BINa_MISC_TOS_M		GENMASK(11, 4)
+#define   YT921X_ACL_BINa_MISC_TOS(x)			FIELD_PREP(YT921X_ACL_BINa_MISC_TOS_M, (x))
+#define  YT921X_ACL_BINa_MISC_L3_TYPE_M		GENMASK(3, 0)
+#define   YT921X_ACL_BINa_MISC_L3_TYPE(x)		FIELD_PREP(YT921X_ACL_BINa_MISC_L3_TYPE_M, (x))
+
+#define  YT921X_ACL_KEYb_L4_DPORT_RANGE_EN	BIT(31)
+#define  YT921X_ACL_KEYb_L4_SPORT_RANGE_EN	BIT(30)
+#define  YT921X_ACL_BINb_L4_FRAG		BIT(3)
+#define  YT921X_ACL_BINb_L4_TYPE_M		GENMASK(2, 0)
+#define   YT921X_ACL_BINb_L4_TYPE(x)			FIELD_PREP(YT921X_ACL_BINb_L4_TYPE_M, (x))
+#define  YT921X_ACL_BINa_L4_DPORT_M		GENMASK(31, 16)
+#define  YT921X_ACL_BINa_L4_SPORT_M		GENMASK(15, 0)
+
+#define  YT921X_ACL_BINb_UDF_IS_IGMP		BIT(0)
+#define  YT921X_ACL_BINa_UDF_UDF0_M		GENMASK(31, 16)
+#define   YT921X_ACL_BINa_UDF_UDF0(x)			FIELD_PREP(YT921X_ACL_BINa_UDF_UDF0_M, (x))
+#define  YT921X_ACL_BINa_UDF_UDF1_M		GENMASK(15, 0)
+#define   YT921X_ACL_BINa_UDF_UDF1(x)			FIELD_PREP(YT921X_ACL_BINa_UDF_UDF1_M, (x))
+
+#define  YT921X_ACL_KEYb_ETHERTYPE_ETHERTYPE_RANGE_EN	BIT(30)
+#define  YT921X_ACL_BINb_ETHERTYPE_L4_TYPE_M	GENMASK(2, 0)
+#define   YT921X_ACL_BINb_ETHERTYPE_L4_TYPE(x)		FIELD_PREP(YT921X_ACL_BINb_ETHERTYPE_L4_TYPE_M, (x))
+#define  YT921X_ACL_BINa_ETHERTYPE_ETHERTYPE_M	GENMASK(15, 0)
+#define   YT921X_ACL_BINa_ETHERTYPE_ETHERTYPE(x)	FIELD_PREP(YT921X_ACL_BINa_ETHERTYPE_ETHERTYPE_M, (x))
+
+enum yt921x_l2_type {
+	YT921X_L2_TYPE_ETH,
+	YT921X_L2_TYPE_ETHV2,
+	YT921X_L2_TYPE_ETHSAP,
+	YT921X_L2_TYPE_ETHSNAP,
+};
+
+enum yt921x_l3_type {
+	YT921X_L3_TYPE_OTHER,
+	YT921X_L3_TYPE_IPV4,
+	YT921X_L3_TYPE_IPV6,
+	YT921X_L3_TYPE_ARP,
+	YT921X_L3_TYPE_LLDP,
+	YT921X_L3_TYPE_PAE,
+	YT921X_L3_TYPE_ERP,
+	YT921X_L3_TYPE_SLOW_PROTOCOL,
+};
+
+enum yt921x_l4_type {
+	YT921X_L4_TYPE_OTHER,
+	YT921X_L4_TYPE_TCP,
+	YT921X_L4_TYPE_UDP,
+	YT921X_L4_TYPE_UDPLITE,
+	YT921X_L4_TYPE_ICMP,
+	YT921X_L4_TYPE_IGMP,
+	YT921X_L4_TYPE_MLD,
+	YT921X_L4_TYPE_ND,
+};
+
 #define YT921X_TPID_IGRn(x)		(0x210000 + 4 * (x))	/* [0, 3] */
 #define  YT921X_TPID_IGR_TPID_M			GENMASK(15, 0)
 #define YT921X_PORTn_IGR_TPID(port)	(0x210010 + 4 * (port))
@@ -470,6 +718,14 @@ enum yt921x_app_selector {
 #define  YT921X_LAG_HASH_MAC_SA			BIT(2)
 #define  YT921X_LAG_HASH_MAC_DA			BIT(1)
 #define  YT921X_LAG_HASH_SRC_PORT		BIT(0)
+#define YT921X_UDFn_CTRL(x)		(0x210094 + 4 * (x))
+#define  YT921X_UDF_CTRL_UDF_TYPE_M		GENMASK(8, 7)
+#define   YT921X_UDF_CTRL_UDF_TYPE(x)			FIELD_PREP(YT921X_UDF_CTRL_UDF_TYPE_M, (x))
+#define   YT921X_UDF_CTRL_UDF_TYPE_ETH			YT921X_UDF_CTRL_UDF_TYPE(0)
+#define   YT921X_UDF_CTRL_UDF_TYPE_L3			YT921X_UDF_CTRL_UDF_TYPE(1)
+#define   YT921X_UDF_CTRL_UDF_TYPE_L4			YT921X_UDF_CTRL_UDF_TYPE(2)
+#define  YT921X_UDF_CTRL_UDF_OFFSET_M		GENMASK(6, 0)
+#define   YT921X_UDF_CTRL_UDF_OFFSET(x)			FIELD_PREP(YT921X_UDF_CTRL_UDF_OFFSET_M, (x))
 
 #define YT921X_PORTn_RATE(port)		(0x220000 + 4 * (port))
 #define  YT921X_PORT_RATE_GAP_VALUE		GENMASK(4, 0)	/* default 20 */
@@ -589,6 +845,11 @@ enum yt921x_fdb_entry_status {
 
 #define YT921X_TAG_LEN	8
 
+#define YT921X_ACL_BLK_NUM	48
+#define YT921X_ACL_ENT_PER_BLK	8
+#define YT921X_ACL_NUM		(YT921X_ACL_BLK_NUM * YT921X_ACL_ENT_PER_BLK)
+#define YT921X_UDF_NUM		8
+
 /* 8 internal + 2 external + 1 mcu */
 #define YT921X_PORT_NUM			11
 
@@ -647,6 +908,24 @@ struct yt921x_mib {
 	u64 tx_oam;
 };
 
+struct yt921x_acl_entry {
+	u32 key[2];
+	u32 mask[2];
+};
+
+struct yt921x_acl_rule {
+	unsigned long tag;
+	enum tc_setup_type type;
+
+	u32 action[3];
+	u8 mask;
+	struct yt921x_acl_entry entries[YT921X_ACL_ENT_PER_BLK];
+};
+
+struct yt921x_acl_blk {
+	struct yt921x_acl_rule *rules[YT921X_ACL_ENT_PER_BLK];
+};
+
 struct yt921x_port {
 	unsigned char index;
 
@@ -686,6 +965,11 @@ struct yt921x_priv {
 	struct yt921x_port ports[YT921X_PORT_NUM];
 
 	u16 eee_ports_mask;
+
+	DECLARE_BITMAP(meters_map, YT921X_METER_NUM);
+
+	u8 acl_masks[YT921X_ACL_BLK_NUM];
+	struct yt921x_acl_blk *acl_blks[YT921X_ACL_BLK_NUM];
 };
 
 #endif
-- 
2.53.0


