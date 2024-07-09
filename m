Return-Path: <netdev+bounces-110371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C4292C1D8
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 19:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D52961F22647
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 17:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6E61C6888;
	Tue,  9 Jul 2024 16:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="j1WnFZGb"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184051C0DCB;
	Tue,  9 Jul 2024 16:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720543127; cv=none; b=I5IHojPpd8W9rrZ/LRESeKX/HHYqTnoGxKYDeGpCsO6TzmnWFJy+AD0hvXAqu1NePeSrZNSKJqspU+mcLYLpvGtA4wuO/AzG0MuMQowR2hxOqfWCfbyViIR3REPf+Sw02n0ya91HzSbyt1Ip/t9RWtnwwsxDl6GsVKxWk+NmjW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720543127; c=relaxed/simple;
	bh=QK7RBLq1BnjxwzsWCcQg3CmYib4tNp/7csuynX6VBN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gyWl17N4Fpnk7wX/IoS4qw+biSwLNrEd1VUqZFc5BwdveFHxmsFC7K5qMzUcYLRqLpfLKzjiSzcEgSuFPRZh3pja3wmQB8zEYsoReDjfzusdJW1aOqmhCCZmwlsu1WNZPQedtjYkB4AGkwc0DYuPE9MIRYYM9EbPilSAfKu3/ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=j1WnFZGb; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1720543114;
	bh=QK7RBLq1BnjxwzsWCcQg3CmYib4tNp/7csuynX6VBN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j1WnFZGb15Zct1IZCqRpXTC8HG0v/Eh64Lg9O8Tg1BLepk3xsKMD2ExQQE38sTARB
	 oR/A01dKF9phwmldNIo/sBKgpEOKi4kEea4HQv/FE29irckKdZvQXaBcWOvkVUBvSw
	 6vahBvXLkTXKYIMyfsDcsu/CYrFROINOQFpx3tZp+jGsn5ng3BTgwqK1V/G6yyYuvy
	 g6+/egZYpSQjyHAIM8w6+E3qF5kVyywZnYEj0I3tN1xz6cAZsqJZHdQf7fwuovzYe6
	 mypNlUJbyWfTGrdL/wbOCxKIDwbUw70M+3KCZnzxst8Ss3FJsrKEfpH64Jdj9j8Kls
	 7Fz2HzC+se3zQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 106E76008D;
	Tue,  9 Jul 2024 16:38:32 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 341DC204A30; Tue, 09 Jul 2024 16:38:27 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Davide Caratti <dcaratti@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Florian Westphal <fw@strlen.de>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 08/10] net/sched: cls_flower: rework TCA_FLOWER_KEY_ENC_FLAGS usage
Date: Tue,  9 Jul 2024 16:38:22 +0000
Message-ID: <20240709163825.1210046-9-ast@fiberby.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709163825.1210046-1-ast@fiberby.net>
References: <20240709163825.1210046-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch changes how TCA_FLOWER_KEY_ENC_FLAGS is used, so that
it is used with TCA_FLOWER_KEY_FLAGS_* flags, in the same way as
TCA_FLOWER_KEY_FLAGS is currently used.

Where TCA_FLOWER_KEY_FLAGS uses {key,mask}->control.flags, then
TCA_FLOWER_KEY_ENC_FLAGS now uses {key,mask}->enc_control.flags,
therefore {key,mask}->enc_flags is now unused.

As the generic fl_set_key_flags/fl_dump_key_flags() is used with
encap set to true, then fl_{set,dump}_key_enc_flags() is removed.

This breaks unreleased userspace API (net-next since 2024-06-04).

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
Tested-by: Davide Caratti <dcaratti@redhat.com>
---
 include/uapi/linux/pkt_cls.h |  4 +--
 net/sched/cls_flower.c       | 56 +++++++++---------------------------
 2 files changed, 15 insertions(+), 45 deletions(-)

diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
index 3dc4388e944cb..d36d9cdf0c008 100644
--- a/include/uapi/linux/pkt_cls.h
+++ b/include/uapi/linux/pkt_cls.h
@@ -554,8 +554,8 @@ enum {
 	TCA_FLOWER_KEY_SPI,		/* be32 */
 	TCA_FLOWER_KEY_SPI_MASK,	/* be32 */
 
-	TCA_FLOWER_KEY_ENC_FLAGS,	/* u32 */
-	TCA_FLOWER_KEY_ENC_FLAGS_MASK,	/* u32 */
+	TCA_FLOWER_KEY_ENC_FLAGS,	/* be32 */
+	TCA_FLOWER_KEY_ENC_FLAGS_MASK,	/* be32 */
 
 	__TCA_FLOWER_MAX,
 };
diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index 2a440f11fe1fa..e2239ab013555 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -45,11 +45,11 @@
 		(TCA_FLOWER_KEY_FLAGS_IS_FRAGMENT | \
 		TCA_FLOWER_KEY_FLAGS_FRAG_IS_FIRST)
 
-#define TUNNEL_FLAGS_PRESENT (\
-	_BITUL(IP_TUNNEL_CSUM_BIT) |		\
-	_BITUL(IP_TUNNEL_DONT_FRAGMENT_BIT) |	\
-	_BITUL(IP_TUNNEL_OAM_BIT) |		\
-	_BITUL(IP_TUNNEL_CRIT_OPT_BIT))
+#define TCA_FLOWER_KEY_ENC_FLAGS_POLICY_MASK \
+		(TCA_FLOWER_KEY_FLAGS_TUNNEL_CSUM | \
+		TCA_FLOWER_KEY_FLAGS_TUNNEL_DONT_FRAGMENT | \
+		TCA_FLOWER_KEY_FLAGS_TUNNEL_OAM | \
+		TCA_FLOWER_KEY_FLAGS_TUNNEL_CRIT_OPT)
 
 struct fl_flow_key {
 	struct flow_dissector_key_meta meta;
@@ -745,10 +745,10 @@ static const struct nla_policy fl_policy[TCA_FLOWER_MAX + 1] = {
 	[TCA_FLOWER_KEY_SPI_MASK]	= { .type = NLA_U32 },
 	[TCA_FLOWER_L2_MISS]		= NLA_POLICY_MAX(NLA_U8, 1),
 	[TCA_FLOWER_KEY_CFM]		= { .type = NLA_NESTED },
-	[TCA_FLOWER_KEY_ENC_FLAGS]	= NLA_POLICY_MASK(NLA_U32,
-							  TUNNEL_FLAGS_PRESENT),
-	[TCA_FLOWER_KEY_ENC_FLAGS_MASK]	= NLA_POLICY_MASK(NLA_U32,
-							  TUNNEL_FLAGS_PRESENT),
+	[TCA_FLOWER_KEY_ENC_FLAGS]	= NLA_POLICY_MASK(NLA_BE32,
+							  TCA_FLOWER_KEY_ENC_FLAGS_POLICY_MASK),
+	[TCA_FLOWER_KEY_ENC_FLAGS_MASK]	= NLA_POLICY_MASK(NLA_BE32,
+							  TCA_FLOWER_KEY_ENC_FLAGS_POLICY_MASK),
 };
 
 static const struct nla_policy
@@ -1866,21 +1866,6 @@ static int fl_set_key_cfm(struct nlattr **tb,
 	return 0;
 }
 
-static int fl_set_key_enc_flags(struct nlattr **tb, u32 *flags_key,
-				u32 *flags_mask, struct netlink_ext_ack *extack)
-{
-	/* mask is mandatory for flags */
-	if (NL_REQ_ATTR_CHECK(extack, NULL, tb, TCA_FLOWER_KEY_ENC_FLAGS_MASK)) {
-		NL_SET_ERR_MSG(extack, "missing enc_flags mask");
-		return -EINVAL;
-	}
-
-	*flags_key = nla_get_u32(tb[TCA_FLOWER_KEY_ENC_FLAGS]);
-	*flags_mask = nla_get_u32(tb[TCA_FLOWER_KEY_ENC_FLAGS_MASK]);
-
-	return 0;
-}
-
 static int fl_set_key(struct net *net, struct nlattr **tb,
 		      struct fl_flow_key *key, struct fl_flow_key *mask,
 		      struct netlink_ext_ack *extack)
@@ -2123,8 +2108,8 @@ static int fl_set_key(struct net *net, struct nlattr **tb,
 	}
 
 	if (tb[TCA_FLOWER_KEY_ENC_FLAGS])
-		ret = fl_set_key_enc_flags(tb, &key->enc_flags.flags,
-					   &mask->enc_flags.flags, extack);
+		ret = fl_set_key_flags(tb, true, &key->enc_control.flags,
+				       &mask->enc_control.flags, extack);
 
 	return ret;
 }
@@ -3381,22 +3366,6 @@ static int fl_dump_key_cfm(struct sk_buff *skb,
 	return err;
 }
 
-static int fl_dump_key_enc_flags(struct sk_buff *skb,
-				 struct flow_dissector_key_enc_flags *key,
-				 struct flow_dissector_key_enc_flags *mask)
-{
-	if (!memchr_inv(mask, 0, sizeof(*mask)))
-		return 0;
-
-	if (nla_put_u32(skb, TCA_FLOWER_KEY_ENC_FLAGS, key->flags))
-		return -EMSGSIZE;
-
-	if (nla_put_u32(skb, TCA_FLOWER_KEY_ENC_FLAGS_MASK, mask->flags))
-		return -EMSGSIZE;
-
-	return 0;
-}
-
 static int fl_dump_key_options(struct sk_buff *skb, int enc_opt_type,
 			       struct flow_dissector_key_enc_opts *enc_opts)
 {
@@ -3699,7 +3668,8 @@ static int fl_dump_key(struct sk_buff *skb, struct net *net,
 	if (fl_dump_key_cfm(skb, &key->cfm, &mask->cfm))
 		goto nla_put_failure;
 
-	if (fl_dump_key_enc_flags(skb, &key->enc_flags, &mask->enc_flags))
+	if (fl_dump_key_flags(skb, true, key->enc_control.flags,
+			      mask->enc_control.flags))
 		goto nla_put_failure;
 
 	return 0;
-- 
2.45.2


