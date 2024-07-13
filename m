Return-Path: <netdev+bounces-111197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D96B93034C
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 04:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDC05280F49
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 02:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030D873501;
	Sat, 13 Jul 2024 02:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="fb5gk2+T"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7F83BBE5;
	Sat, 13 Jul 2024 02:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720837168; cv=none; b=hfYd3YRvn4TAqlQLJnGnThfYtn1fL1FT/DAGPPwdo2WmI6HI9N1sIl9QOIfGP+F5GYXko/R23+OCMwxyLEBr6E5nKBpVk/7HtPqDfEgQajvmbgepxC8OAmDh1k2uBKjQuyD91moLHTG+A+pod3FS3wad+Iqq5xNXbv4A/1XKYRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720837168; c=relaxed/simple;
	bh=O9ltKFpaw07JOwOY7Yb+YIhc3w7Xh+r0G45nYtCCSWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BafC/T8PRMq/FtC4qk5yi2LS0zZBq8WDafGPV7f1wq2JT4H1HsWjGvqN2U9E1BoSjwO/8ApmlFoad2R8aTtb3Mvj6zuQDrUkVpLgfwHP6aJe1OEtmc2zcZWiObBoXGRoZYSCztQ/RjJf4I8BZ8G7seMc3DA0BiusGU/MkSBNET4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=fb5gk2+T; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1720837160;
	bh=O9ltKFpaw07JOwOY7Yb+YIhc3w7Xh+r0G45nYtCCSWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fb5gk2+TxwJENs01xSri8CIH5wkizXIouiQ8qZnuUtUjv6Ot1AoWIhEwhOmGL93ok
	 SkWH3IgGjZ/vNMMM4vZ5JgsWEsTzTiiiHklDmLc4EifCf/Zrkyj+orzZwtF3IVuOXn
	 foqxKZvHx08U9XfERlZegUOA8foDv2zJJuOzgf0lDKR7u89lKonL/r1gWeh9fWFs4Y
	 08u1hznF/ovE5kNxDW/HCPY8o4jRbt7HqrHYj5fV85x/sLDDEllfhe1TJGnjNtu9WA
	 shvXPVPp+tIZiWjLC8u4QE5YCEf/qfwyhgAfQlOS8dly0ZOota0VvwaU0xmMDZg58L
	 V6htT8TN4/dfw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 8A9A26007C;
	Sat, 13 Jul 2024 02:19:17 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 98EB6203283; Sat, 13 Jul 2024 02:19:11 +0000 (UTC)
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
	Donald Hunter <donald.hunter@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 04/13] net/sched: cls_flower: prepare fl_{set,dump}_key_flags() for ENC_FLAGS
Date: Sat, 13 Jul 2024 02:19:01 +0000
Message-ID: <20240713021911.1631517-5-ast@fiberby.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240713021911.1631517-1-ast@fiberby.net>
References: <20240713021911.1631517-1-ast@fiberby.net>
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
Reviewed-by: Davide Caratti <dcaratti@redhat.com>
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


