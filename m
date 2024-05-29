Return-Path: <netdev+bounces-98895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACDB8D319C
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 10:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52C621C24077
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 08:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB5716937F;
	Wed, 29 May 2024 08:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FXoLTWrO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A1215D5A4
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 08:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716971587; cv=none; b=sySXwLlyjq2Au8YC/yTOTeRH4w5Hr80KR2kUbQZI6ZSrE79V7B+0Eh80rnqWB52ODP3wqIoJCcGWyWXJDV1W7QlUu53PwkXRex9NlgfE4rPTbtdjNGNqybMmbU8PWnfFGuQoe6cPHw97ZvTt2irYwgi2oiUEn3k1lVz1qoL66tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716971587; c=relaxed/simple;
	bh=R4qLM+BQn3XxsCPVE4RYDTUL+Z8EQlbXY7xbvSAy3qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fsepAV52nppBXPrnXpJubdOyxUHgWUyFnawW1uknVijQlJOvMxMrOve8w7ljPjKbON9J0DG8FAGoHRkKfqdMju/gIkfrxuTRQjf8MZbPY1nrWsKLuRoRCh7ESMZyGIW8Il0tHo6tCIbd21e7cz2ahVzQyWsU4Euf5E4vWI8g3WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FXoLTWrO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716971585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RfxFF6kUcIbc0941Da6QzZxyTGVMinRI8tUQ/IpNou4=;
	b=FXoLTWrOURF7wGjeKx+fsjmMNdBbrMVy17Yv2CRPEU5eeOa7QIOJ+kjH9N7XEEXQplO0LI
	IVir5qIaEYMYyBK1wFXy7M3AX2McpM0DG4uNslDWZpqIallapN+0YxP5vjTlXtvkXdgQ1X
	s4LY39WTqprpAr+bHSmds6wfuXRtp1c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-SBNMMhFxNWGBxYpuaCuYOA-1; Wed, 29 May 2024 04:33:01 -0400
X-MC-Unique: SBNMMhFxNWGBxYpuaCuYOA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B8331812296;
	Wed, 29 May 2024 08:33:00 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.225.120])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CD3BD200A35C;
	Wed, 29 May 2024 08:32:57 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: dcaratti@redhat.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	i.maximets@ovn.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	kuba@kernel.org,
	lucien.xin@gmail.com,
	marcelo.leitner@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	xiyou.wangcong@gmail.com,
	echaudro@redhat.com
Subject: [PATCH net-next v3 2/2] net/sched: cls_flower: add support for matching tunnel control flags
Date: Wed, 29 May 2024 10:31:58 +0200
Message-ID: <54ae52f99e7141a188529e541e2770b5b72183fc.1716911277.git.dcaratti@redhat.com>
In-Reply-To: <cover.1716911277.git.dcaratti@redhat.com>
References: <cover.1716911277.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

extend cls_flower to match TUNNEL_FLAGS_PRESENT bits in tunnel metadata.

Suggested-by: Ilya Maximets <i.maximets@ovn.org>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 include/uapi/linux/pkt_cls.h |  3 ++
 net/sched/cls_flower.c       | 56 +++++++++++++++++++++++++++++++++++-
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
index 229fc925ec3a..b6d38f5fd7c0 100644
--- a/include/uapi/linux/pkt_cls.h
+++ b/include/uapi/linux/pkt_cls.h
@@ -554,6 +554,9 @@ enum {
 	TCA_FLOWER_KEY_SPI,		/* be32 */
 	TCA_FLOWER_KEY_SPI_MASK,	/* be32 */
 
+	TCA_FLOWER_KEY_ENC_FLAGS,	/* u32 */
+	TCA_FLOWER_KEY_ENC_FLAGS_MASK,	/* u32 */
+
 	__TCA_FLOWER_MAX,
 };
 
diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index fd9a6f20b60b..eef570c577ac 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -41,6 +41,12 @@
 #define TCA_FLOWER_KEY_CT_FLAGS_MASK \
 		(TCA_FLOWER_KEY_CT_FLAGS_MAX - 1)
 
+#define TUNNEL_FLAGS_PRESENT (\
+	_BITUL(IP_TUNNEL_CSUM_BIT) |		\
+	_BITUL(IP_TUNNEL_DONT_FRAGMENT_BIT) |	\
+	_BITUL(IP_TUNNEL_OAM_BIT) |		\
+	_BITUL(IP_TUNNEL_CRIT_OPT_BIT))
+
 struct fl_flow_key {
 	struct flow_dissector_key_meta meta;
 	struct flow_dissector_key_control control;
@@ -75,6 +81,7 @@ struct fl_flow_key {
 	struct flow_dissector_key_l2tpv3 l2tpv3;
 	struct flow_dissector_key_ipsec ipsec;
 	struct flow_dissector_key_cfm cfm;
+	struct flow_dissector_key_enc_flags enc_flags;
 } __aligned(BITS_PER_LONG / 8); /* Ensure that we can do comparisons as longs. */
 
 struct fl_flow_mask_range {
@@ -732,6 +739,10 @@ static const struct nla_policy fl_policy[TCA_FLOWER_MAX + 1] = {
 	[TCA_FLOWER_KEY_SPI_MASK]	= { .type = NLA_U32 },
 	[TCA_FLOWER_L2_MISS]		= NLA_POLICY_MAX(NLA_U8, 1),
 	[TCA_FLOWER_KEY_CFM]		= { .type = NLA_NESTED },
+	[TCA_FLOWER_KEY_ENC_FLAGS]	= NLA_POLICY_MASK(NLA_U32,
+							  TUNNEL_FLAGS_PRESENT),
+	[TCA_FLOWER_KEY_ENC_FLAGS_MASK]	= NLA_POLICY_MASK(NLA_U32,
+							  TUNNEL_FLAGS_PRESENT),
 };
 
 static const struct nla_policy
@@ -1825,6 +1836,21 @@ static int fl_set_key_cfm(struct nlattr **tb,
 	return 0;
 }
 
+static int fl_set_key_enc_flags(struct nlattr **tb, u32 *flags_key,
+				u32 *flags_mask, struct netlink_ext_ack *extack)
+{
+	/* mask is mandatory for flags */
+	if (NL_REQ_ATTR_CHECK(extack, NULL, tb, TCA_FLOWER_KEY_ENC_FLAGS_MASK)) {
+		NL_SET_ERR_MSG(extack, "missing enc_flags mask");
+		return -EINVAL;
+	}
+
+	*flags_key = nla_get_u32(tb[TCA_FLOWER_KEY_ENC_FLAGS]);
+	*flags_mask = nla_get_u32(tb[TCA_FLOWER_KEY_ENC_FLAGS_MASK]);
+
+	return 0;
+}
+
 static int fl_set_key(struct net *net, struct nlattr **tb,
 		      struct fl_flow_key *key, struct fl_flow_key *mask,
 		      struct netlink_ext_ack *extack)
@@ -2059,9 +2085,16 @@ static int fl_set_key(struct net *net, struct nlattr **tb,
 	if (ret)
 		return ret;
 
-	if (tb[TCA_FLOWER_KEY_FLAGS])
+	if (tb[TCA_FLOWER_KEY_FLAGS]) {
 		ret = fl_set_key_flags(tb, &key->control.flags,
 				       &mask->control.flags, extack);
+		if (ret)
+			return ret;
+	}
+
+	if (tb[TCA_FLOWER_KEY_ENC_FLAGS])
+		ret = fl_set_key_enc_flags(tb, &key->enc_flags.flags,
+					   &mask->enc_flags.flags, extack);
 
 	return ret;
 }
@@ -2175,6 +2208,8 @@ static void fl_init_dissector(struct flow_dissector *dissector,
 			     FLOW_DISSECTOR_KEY_IPSEC, ipsec);
 	FL_KEY_SET_IF_MASKED(mask, keys, cnt,
 			     FLOW_DISSECTOR_KEY_CFM, cfm);
+	FL_KEY_SET_IF_MASKED(mask, keys, cnt,
+			     FLOW_DISSECTOR_KEY_ENC_FLAGS, enc_flags);
 
 	skb_flow_dissector_init(dissector, keys, cnt);
 }
@@ -3291,6 +3326,22 @@ static int fl_dump_key_cfm(struct sk_buff *skb,
 	return err;
 }
 
+static int fl_dump_key_enc_flags(struct sk_buff *skb,
+				 struct flow_dissector_key_enc_flags *key,
+				 struct flow_dissector_key_enc_flags *mask)
+{
+	if (!memchr_inv(mask, 0, sizeof(*mask)))
+		return 0;
+
+	if (nla_put_u32(skb, TCA_FLOWER_KEY_ENC_FLAGS, key->flags))
+		return -EMSGSIZE;
+
+	if (nla_put_u32(skb, TCA_FLOWER_KEY_ENC_FLAGS_MASK, mask->flags))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
 static int fl_dump_key_options(struct sk_buff *skb, int enc_opt_type,
 			       struct flow_dissector_key_enc_opts *enc_opts)
 {
@@ -3592,6 +3643,9 @@ static int fl_dump_key(struct sk_buff *skb, struct net *net,
 	if (fl_dump_key_cfm(skb, &key->cfm, &mask->cfm))
 		goto nla_put_failure;
 
+	if (fl_dump_key_enc_flags(skb, &key->enc_flags, &mask->enc_flags))
+		goto nla_put_failure;
+
 	return 0;
 
 nla_put_failure:
-- 
2.44.0


