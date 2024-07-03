Return-Path: <netdev+bounces-108808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6908B925A60
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 12:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AD201C25B75
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 10:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1E71940B9;
	Wed,  3 Jul 2024 10:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="NvdtjtZK"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763FC1891C9;
	Wed,  3 Jul 2024 10:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003650; cv=none; b=hqKYo1SPXJl1AYKNIk/Hywa7jDRZtYhUrgG8Pj3tW1hV/zAFdF2vuxgVZGBdAM1R05IRqA2o0mewoS1VHzJXqMC5TPTdB6pMXi2DSMPg0ml5oB/YVzcmA6rTMS8igq15HDiVH3MQqfoHLgQjkqoKtluUz8fwmMnYGeKuLwEHScg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003650; c=relaxed/simple;
	bh=eVWz8H35R1+86cFCHTm7aSOzSApYcjZvVM0yxa/5MhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pqm3MBrR/FAAenLIAoA6bKh2dHzQsM6k9OUpZXZpHo9F75DWBMArl6MkK7jXodX4SztlItB6syLLmp3havdZUfQhu+7nGM8iQhzxvIaGNYHTbqTe3kMp7xuU9fRbgzfYQMKYKdTVeThYAKe4Wn8rSBhKAuNsa3rwBuj6POzbwtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=NvdtjtZK; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1720003636;
	bh=eVWz8H35R1+86cFCHTm7aSOzSApYcjZvVM0yxa/5MhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NvdtjtZK7fhL8cN6J0Q2yLHdYo1PkaBL49Pc7R7dAxcNJ7ZvejrJNuZ7yFkrLvSCM
	 Yv9tZajn+kJ7H8TRCsth/6q8nsm4zmLq44agLod91GlGJgaDuHvBuuU5YgfafzzixS
	 KCY+1h5fov8jXpQow9cdwFIgYA9IlE3B9Ls6B2TjX8zUwbBYmDabCXb9+I3pU3sMRe
	 eODTl+GtHJaF2n3Fo/jKFjWRq5upmGdm7Xc/0MO2FcRjeSR4uaLBEqO4ZbpTlwE1br
	 cG99ceGMf+eB+E325mN1RDALQ5OsvmwVez+UAvpD/ZhcwwyY9NcvNRpHtLuCtXcikK
	 bAHoXeHSxZwkQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 346D76008D;
	Wed,  3 Jul 2024 10:47:16 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 6D6F7204415; Wed, 03 Jul 2024 10:46:08 +0000 (UTC)
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
Subject: [PATCH net-next 2/9] net/sched: cls_flower: prepare fl_{set,dump}_key_flags() for ENC_FLAGS
Date: Wed,  3 Jul 2024 10:45:51 +0000
Message-ID: <20240703104600.455125-3-ast@fiberby.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703104600.455125-1-ast@fiberby.net>
References: <20240703104600.455125-1-ast@fiberby.net>
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
index eef570c577ac..6a5cecfd9561 100644
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


