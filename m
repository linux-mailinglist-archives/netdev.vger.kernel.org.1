Return-Path: <netdev+bounces-68116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A2A845E05
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 18:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C155EB36EF3
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 16:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27231525B;
	Thu,  1 Feb 2024 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A49GhWC0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE8D2C682
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 16:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706806438; cv=none; b=euGcNSKkN8j0EVz3JlFQJ/AtYzFMnReD7UmaaLG6hg+8g3JgH3bE9hxKKrt0sXyBpI+9fAHaLV9v1lmxEUxVFtLRTNU8olTme8e/muZfCU9a9kz0fis8+COyHpMw6Df4rqxZ8I14B1uRKM2rrE6hjP5dSiT9pANDDlGUipEnxVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706806438; c=relaxed/simple;
	bh=bSlFyFBtX1ZUQ9mEtGa9D7NEp3g56ZuLMBCPZXWszzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ic4+ICSabhLG44Q4WuOYk/ElP4QctZ4UPd5zHMczv9kQjWR0vWAbnNVicefiRfksFuCe8FhU1GKcUNkpQgq4GQbqdr/JAxA3x1fnpfOAceNP3jlhNNzZVBc0ZIa22RsmvV5aR6j8SFgmvItQVuSu5v2NruPzhTye2us2hW5h+gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A49GhWC0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706806435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GhloFOaRG7JAVrALPv9JoqGpGTdloX9rIvcfDTbl+Ks=;
	b=A49GhWC03OjoiGmaQEGRh48B3zDEzQylJNGTN5iRTenG6nruv+j5mxP7/IdtdqjZSjvL0e
	7gYRHZoS3NSvVkp6EYpfkVWgIHUYg/wa/bqHRf+5VrssVdo1y+L2NctU9hcq5v00BHpVKz
	lHHEP+SXsjTvBksDUgpLwNdLbSdlbew=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-g9252Q68O7qs8oPiAKN8_Q-1; Thu, 01 Feb 2024 11:53:50 -0500
X-MC-Unique: g9252Q68O7qs8oPiAKN8_Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 531A585A58E;
	Thu,  1 Feb 2024 16:53:49 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.226.26])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6FAA8492BE4;
	Thu,  1 Feb 2024 16:53:47 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net-next v2 2/2] net/sched: cls_flower: add support for matching tunnel control flags
Date: Thu,  1 Feb 2024 17:51:44 +0100
Message-ID: <e58d5b6d8a091bb4f3beb4ffd43583d37ead4cfa.1706805548.git.dcaratti@redhat.com>
In-Reply-To: <cover.1706805548.git.dcaratti@redhat.com>
References: <cover.1706805548.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

extend cls_flower to match flags belonging to 'TUNNEL_FLAGS_PRESENT' mask
inside skb tunnel metadata.

Suggested-by: Ilya Maximets <i.maximets@ovn.org>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 include/uapi/linux/pkt_cls.h |  3 +++
 net/sched/cls_flower.c       | 50 +++++++++++++++++++++++++++++++++++-
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
index ea277039f89d..e3394f9d06b7 100644
--- a/include/uapi/linux/pkt_cls.h
+++ b/include/uapi/linux/pkt_cls.h
@@ -554,6 +554,9 @@ enum {
 	TCA_FLOWER_KEY_SPI,		/* be32 */
 	TCA_FLOWER_KEY_SPI_MASK,	/* be32 */
 
+	TCA_FLOWER_KEY_ENC_FLAGS,	/* be16 */
+	TCA_FLOWER_KEY_ENC_FLAGS_MASK,	/* be16 */
+
 	__TCA_FLOWER_MAX,
 };
 
diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index efb9d2811b73..8da12256568f 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -74,6 +74,7 @@ struct fl_flow_key {
 	struct flow_dissector_key_l2tpv3 l2tpv3;
 	struct flow_dissector_key_ipsec ipsec;
 	struct flow_dissector_key_cfm cfm;
+	struct flow_dissector_key_enc_flags enc_flags;
 } __aligned(BITS_PER_LONG / 8); /* Ensure that we can do comparisons as longs. */
 
 struct fl_flow_mask_range {
@@ -731,6 +732,10 @@ static const struct nla_policy fl_policy[TCA_FLOWER_MAX + 1] = {
 	[TCA_FLOWER_KEY_SPI_MASK]	= { .type = NLA_U32 },
 	[TCA_FLOWER_L2_MISS]		= NLA_POLICY_MAX(NLA_U8, 1),
 	[TCA_FLOWER_KEY_CFM]		= { .type = NLA_NESTED },
+	[TCA_FLOWER_KEY_ENC_FLAGS]	= NLA_POLICY_MASK(NLA_BE16,
+							  TUNNEL_FLAGS_PRESENT),
+	[TCA_FLOWER_KEY_ENC_FLAGS_MASK]	= NLA_POLICY_MASK(NLA_BE16,
+							  TUNNEL_FLAGS_PRESENT),
 };
 
 static const struct nla_policy
@@ -1748,6 +1753,21 @@ static int fl_set_key_cfm(struct nlattr **tb,
 	return 0;
 }
 
+static int fl_set_key_enc_flags(struct nlattr **tb, __be16 *flags_key,
+				__be16 *flags_mask, struct netlink_ext_ack *extack)
+{
+	/* mask is mandatory for flags */
+	if (NL_REQ_ATTR_CHECK(extack, NULL, tb, TCA_FLOWER_KEY_ENC_FLAGS_MASK)) {
+		NL_SET_ERR_MSG(extack, "missing enc_flags mask");
+		return -EINVAL;
+	}
+
+	*flags_key = nla_get_be16(tb[TCA_FLOWER_KEY_ENC_FLAGS]);
+	*flags_mask = nla_get_be16(tb[TCA_FLOWER_KEY_ENC_FLAGS_MASK]);
+
+	return 0;
+}
+
 static int fl_set_key(struct net *net, struct nlattr **tb,
 		      struct fl_flow_key *key, struct fl_flow_key *mask,
 		      struct netlink_ext_ack *extack)
@@ -1982,9 +2002,16 @@ static int fl_set_key(struct net *net, struct nlattr **tb,
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
@@ -2098,6 +2125,8 @@ static void fl_init_dissector(struct flow_dissector *dissector,
 			     FLOW_DISSECTOR_KEY_IPSEC, ipsec);
 	FL_KEY_SET_IF_MASKED(mask, keys, cnt,
 			     FLOW_DISSECTOR_KEY_CFM, cfm);
+	FL_KEY_SET_IF_MASKED(mask, keys, cnt,
+			     FLOW_DISSECTOR_KEY_ENC_FLAGS, enc_flags);
 
 	skb_flow_dissector_init(dissector, keys, cnt);
 }
@@ -3185,6 +3214,22 @@ static int fl_dump_key_cfm(struct sk_buff *skb,
 	return err;
 }
 
+static int fl_dump_key_enc_flags(struct sk_buff *skb,
+				 struct flow_dissector_key_enc_flags *key,
+				 struct flow_dissector_key_enc_flags *mask)
+{
+	if (!memchr_inv(mask, 0, sizeof(*mask)))
+		return 0;
+
+	if (nla_put_be16(skb, TCA_FLOWER_KEY_ENC_FLAGS, key->flags))
+		return -EMSGSIZE;
+
+	if (nla_put_be16(skb, TCA_FLOWER_KEY_ENC_FLAGS_MASK, mask->flags))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
 static int fl_dump_key_options(struct sk_buff *skb, int enc_opt_type,
 			       struct flow_dissector_key_enc_opts *enc_opts)
 {
@@ -3481,6 +3526,9 @@ static int fl_dump_key(struct sk_buff *skb, struct net *net,
 	if (fl_dump_key_cfm(skb, &key->cfm, &mask->cfm))
 		goto nla_put_failure;
 
+	if (fl_dump_key_enc_flags(skb, &key->enc_flags, &mask->enc_flags))
+		goto nla_put_failure;
+
 	return 0;
 
 nla_put_failure:
-- 
2.43.0


