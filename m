Return-Path: <netdev+bounces-102764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A91C09047DC
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 01:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C214C1C22D7D
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 23:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68A1157A61;
	Tue, 11 Jun 2024 23:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="cXhXVGdh"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E243F156F26;
	Tue, 11 Jun 2024 23:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718150069; cv=none; b=KiiKkedSRGXQexlK093QDBVIbaMEm9ermCR67TEau7QhqAhIAQ0tuSYi3ySwHBSKRibOJ/azs3UOH8d4Gf/rRoPN7rPQ8r1acRp3XcHAgiEA/6cYMXMe/8yVcI3G2DM9EgcmDLoJYgPbrPsBQicTm5kOCg0sjkFvUgOLinu3Ey0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718150069; c=relaxed/simple;
	bh=zATe/2n/zWdwcgm2mIZEJ9zy1kGHBOn2WYZ49kih8ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NLYti073XduFqBViSd2NWUK5EFFb92kChOXpQtikENbu9XpS50QAnCwnutL4gdAwf5KjsA/oW22zkSv/WluqFVSiTJP94AIzclp8OZyspsuKQj0lW64wX9zvb1ESmJeySR4SynmSvAWGClnRm9RqYDJUBlXQVCI3x6npDI41tRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=cXhXVGdh; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1718150060;
	bh=zATe/2n/zWdwcgm2mIZEJ9zy1kGHBOn2WYZ49kih8ms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cXhXVGdhYaLiGkQqorl0NYe68qgmF+N05ooKZjvjIfQkX6NvHJWjT/tPlH/luVj+Z
	 XZ6RxTYuKNVXnlwZnjntVSt5mEjSa2B4iLmXlQVJCt4jq+b/vdqMzDDtwpdpzvPzMH
	 II+ptZOJ/9iBJReV9gcsNFhxo7ZznwRBcGVk+lb4xZkwb9cNoTEhjPZeFXGSloTupY
	 DkyrE3Czfo1AEkMp6m3bNj05YcsTNIX7pQ5/JP4x60ZC20F9Z/sskLPx4pkMw4Lq47
	 KGYxWsvMc+7ja63NmIerdf8b9IwHnL7WNj64WhDVruLq20JojswFc1kEfXwyIHlZmt
	 WOqGSldHmd41A==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 505DE6009C;
	Tue, 11 Jun 2024 23:54:17 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 665A9202C29; Tue, 11 Jun 2024 23:54:00 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: Davide Caratti <dcaratti@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 2/9] net/sched: cls_flower: prepare fl_{set,dump}_key_flags() for ENC_FLAGS
Date: Tue, 11 Jun 2024 23:53:35 +0000
Message-ID: <20240611235355.177667-3-ast@fiberby.net>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611235355.177667-1-ast@fiberby.net>
References: <20240611235355.177667-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Prepare fl_set_key_flags/fl_dump_key_flags() for use with
TCA_FLOWER_KEY_ENC_FLAGS{,_MASK}.

This patch adds an encap argument, similar to fl_set_key_ip/
fl_dump_key_ip(), and determine the flower keys based on the
encap argument, and use them in the rest of the two functions.

Since these functions are so far, only called with encap set false,
then there is no functional change.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 net/sched/cls_flower.c | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index eef570c577ac7..6a5cecfd95619 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -1166,19 +1166,28 @@ static void fl_set_key_flag(u32 flower_key, u32 flower_mask,
 	}
 }
 
-static int fl_set_key_flags(struct nlattr **tb, u32 *flags_key,
+static int fl_set_key_flags(struct nlattr **tb, bool encap, u32 *flags_key,
 			    u32 *flags_mask, struct netlink_ext_ack *extack)
 {
+	int fl_key, fl_mask;
 	u32 key, mask;
 
+	if (encap) {
+		fl_key = TCA_FLOWER_KEY_ENC_FLAGS;
+		fl_mask = TCA_FLOWER_KEY_ENC_FLAGS_MASK;
+	} else {
+		fl_key = TCA_FLOWER_KEY_FLAGS;
+		fl_mask = TCA_FLOWER_KEY_FLAGS_MASK;
+	}
+
 	/* mask is mandatory for flags */
-	if (!tb[TCA_FLOWER_KEY_FLAGS_MASK]) {
+	if (NL_REQ_ATTR_CHECK(extack, NULL, tb, fl_mask)) {
 		NL_SET_ERR_MSG(extack, "Missing flags mask");
 		return -EINVAL;
 	}
 
-	key = be32_to_cpu(nla_get_be32(tb[TCA_FLOWER_KEY_FLAGS]));
-	mask = be32_to_cpu(nla_get_be32(tb[TCA_FLOWER_KEY_FLAGS_MASK]));
+	key = be32_to_cpu(nla_get_be32(tb[fl_key]));
+	mask = be32_to_cpu(nla_get_be32(tb[fl_mask]));
 
 	*flags_key  = 0;
 	*flags_mask = 0;
@@ -2086,7 +2095,7 @@ static int fl_set_key(struct net *net, struct nlattr **tb,
 		return ret;
 
 	if (tb[TCA_FLOWER_KEY_FLAGS]) {
-		ret = fl_set_key_flags(tb, &key->control.flags,
+		ret = fl_set_key_flags(tb, false, &key->control.flags,
 				       &mask->control.flags, extack);
 		if (ret)
 			return ret;
@@ -3084,12 +3093,22 @@ static void fl_get_key_flag(u32 dissector_key, u32 dissector_mask,
 	}
 }
 
-static int fl_dump_key_flags(struct sk_buff *skb, u32 flags_key, u32 flags_mask)
+static int fl_dump_key_flags(struct sk_buff *skb, bool encap,
+			     u32 flags_key, u32 flags_mask)
 {
-	u32 key, mask;
+	int fl_key, fl_mask;
 	__be32 _key, _mask;
+	u32 key, mask;
 	int err;
 
+	if (encap) {
+		fl_key = TCA_FLOWER_KEY_ENC_FLAGS;
+		fl_mask = TCA_FLOWER_KEY_ENC_FLAGS_MASK;
+	} else {
+		fl_key = TCA_FLOWER_KEY_FLAGS;
+		fl_mask = TCA_FLOWER_KEY_FLAGS_MASK;
+	}
+
 	if (!memchr_inv(&flags_mask, 0, sizeof(flags_mask)))
 		return 0;
 
@@ -3105,11 +3124,11 @@ static int fl_dump_key_flags(struct sk_buff *skb, u32 flags_key, u32 flags_mask)
 	_key = cpu_to_be32(key);
 	_mask = cpu_to_be32(mask);
 
-	err = nla_put(skb, TCA_FLOWER_KEY_FLAGS, 4, &_key);
+	err = nla_put(skb, fl_key, 4, &_key);
 	if (err)
 		return err;
 
-	return nla_put(skb, TCA_FLOWER_KEY_FLAGS_MASK, 4, &_mask);
+	return nla_put(skb, fl_mask, 4, &_mask);
 }
 
 static int fl_dump_key_geneve_opt(struct sk_buff *skb,
@@ -3632,7 +3651,8 @@ static int fl_dump_key(struct sk_buff *skb, struct net *net,
 	if (fl_dump_key_ct(skb, &key->ct, &mask->ct))
 		goto nla_put_failure;
 
-	if (fl_dump_key_flags(skb, key->control.flags, mask->control.flags))
+	if (fl_dump_key_flags(skb, false, key->control.flags,
+			      mask->control.flags))
 		goto nla_put_failure;
 
 	if (fl_dump_key_val(skb, &key->hash.hash, TCA_FLOWER_KEY_HASH,
-- 
2.45.1


