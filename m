Return-Path: <netdev+bounces-110361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A1A92C1C2
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 19:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C6AB1C2340A
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 17:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B791BF330;
	Tue,  9 Jul 2024 16:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="XjcMPV4o"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7991D1BF320;
	Tue,  9 Jul 2024 16:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720543122; cv=none; b=iL0+K/dO8MugqPPFlHnlMyv8DHG+kqr6HCPLtg/tRhInlBM49WihiLy4hpl3yM2v0Cdtb3ZXhiPagvgTXtz+hQYkDTEOUUG4KyQUctYfUY2wxe34mwYrs6RJAGOoly9EeCyc0YnGCLI9EsoW6XMVINN+JkPvKl2BvMEafHyF4fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720543122; c=relaxed/simple;
	bh=hc4cV+xJKLe9gUryam5x32eujRILky1DfHOfzcfSoco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nK2X2YsdEPM8hbIjcUCDdOQ4ZUvPhyi1dPsFUhWVDIUhu4j6JeF/c/SGtJVKeAG8NEevExjgteJxccutS1dyBNeKqotGPwnql+56QJ6RFS0wqChkcj8k1kKE50hh43PZUqikoekBEdtebfOH3J89B22Q16q/a5nTwJGTAseYCME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=XjcMPV4o; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1720543112;
	bh=hc4cV+xJKLe9gUryam5x32eujRILky1DfHOfzcfSoco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XjcMPV4o5f9d/wISII727ZNIXMgdOg8uJjj3PUTzaZOLH7irXgpD3S/Uh6Kr4bSfH
	 Ox8IBVBcn0BAO8zQXALU0A0COQzIy+TmIx0CnJ1+6FKSXQskR3Mpvdl+6E1Wh/YAaf
	 eZFmWCm+FbPt4TTXKbnmPOqqVYShMOgw5dVD49Mb0VwhUP4dvDz9QDiarcN7V3kkDA
	 R+OIio7nyGsoBvvmyxWOjFn+8OsnVyz3NXMbtHE2BDGSGIjY+xs3e1JPZ/p+axgVX2
	 yd3jGm4XBiZlW/pdg85hlD0wn3wiLWYph+vGI7w0orjgbMMKHRCqXNku0zYe7J+2zj
	 zPcUs0dMyU1Gw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 0476260085;
	Tue,  9 Jul 2024 16:38:32 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 7CAE220484E; Tue, 09 Jul 2024 16:38:26 +0000 (UTC)
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
Subject: [PATCH net-next v3 03/10] net/sched: cls_flower: prepare fl_{set,dump}_key_flags() for ENC_FLAGS
Date: Tue,  9 Jul 2024 16:38:17 +0000
Message-ID: <20240709163825.1210046-4-ast@fiberby.net>
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

Prepare fl_set_key_flags/fl_dump_key_flags() for use with
TCA_FLOWER_KEY_ENC_FLAGS{,_MASK}.

This patch adds an encap argument, similar to fl_set_key_ip/
fl_dump_key_ip(), and determine the flower keys based on the
encap argument, and use them in the rest of the two functions.

Since these functions are so far, only called with encap set false,
then there is no functional change.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
Tested-by: Davide Caratti <dcaratti@redhat.com>
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
2.45.2


