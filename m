Return-Path: <netdev+bounces-111186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F7D930339
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 04:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46D3B1C2146D
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 02:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CEF168A9;
	Sat, 13 Jul 2024 02:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Du8ojnJ1"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EC4DF53;
	Sat, 13 Jul 2024 02:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720837164; cv=none; b=jhbapvSHWZVuzTs7ZvD9aV/DJg1E15h1Bv+kY+Sh5Rl5cH6SZxc3EEnkzf13mjp3rMjONqIcWTqzT4sDwRNYPDXti6f0jw3/AKu3BaSBmJS5Pk3d/G3o4sLaIKdph8VLgh1vSKIG8z+DhviHVLhMTtwCuAbA+CadpCattgGMP5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720837164; c=relaxed/simple;
	bh=v3mNEqFK0Q6h4padIx+/4n10HpzalQwxOLizi2JEcJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c1oL55/XX5h0cLtK5ft5KGpAWVkXgWPGAhrkh1v2kqWNL0zuXgaIVRAIU9xXgUFamTDAjl1RMIAy6n9pc5lC77hXycKtOhOu6KPEsbp3AUfv27ZyHa+I3k38zGLvWDczailFpFD1tSNUMDr2lToXXm1s1xZ3Ie2o85R+ryejsqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Du8ojnJ1; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1720837158;
	bh=v3mNEqFK0Q6h4padIx+/4n10HpzalQwxOLizi2JEcJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Du8ojnJ1ANsrtJ9EA7xRjipz+FOSt9c8B5BAxZYZx2uOgqWME8ESJGMxol58vOZ0W
	 HV9FGOMFUiDEsfkXZogq8p+Dv4v7wfMt9YmZXkgczGY1/AU2WC+7Y4OpIP2bbzblqj
	 o+moUwWov8UkLD5IFQ6jmLM/0LwpcxqBVXjDQyCV/Rz2vtKYx+F5WJysf8mfhGTHfa
	 xjuSNoi8AJUU6s0nmcz98eGqfoFxx1Fldmgz7Fz07QXD9MYLVjPByQ9NHaaTWyfmYq
	 Drqgc9NoGfPoYsyyvmAWxiaOZ/dgABLqGb9SNuZX047D/cSp19fEb527MFcBE9RyFD
	 FhnmKLHiYehcA==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 46FCF60079;
	Sat, 13 Jul 2024 02:19:17 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 0026E204FDE; Sat, 13 Jul 2024 02:19:12 +0000 (UTC)
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
Subject: [PATCH net-next v4 13/13] net/sched: cls_flower: propagate tca[TCA_OPTIONS] to NL_REQ_ATTR_CHECK
Date: Sat, 13 Jul 2024 02:19:10 +0000
Message-ID: <20240713021911.1631517-14-ast@fiberby.net>
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

NL_REQ_ATTR_CHECK() is used in fl_set_key_flags() to set
extended attributes about the origin of an error, this
patch propagates tca[TCA_OPTIONS] through.

Before this patch:

$ sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/tc.yaml \
	 --do newtfilter --json '{
		"chain": 0, "family": 0, "handle": 4, "ifindex": 22,
		"info": 262152,
		"kind": "flower",
		"options": {
			"flags": 0, "key-enc-flags": 8,
			"key-eth-type": 2048 },
		"parent": 4294967283 }'
Netlink error: Invalid argument
nl_len = 68 (52) nl_flags = 0x300 nl_type = 2
        error: -22
        extack: {'msg': 'Missing flags mask',
                 'miss-type': 111}

After this patch:

[same cmd]
Netlink error: Invalid argument
nl_len = 76 (60) nl_flags = 0x300 nl_type = 2
        error: -22
        extack: {'msg': 'Missing flags mask',
                 'miss-type': 111, 'miss-nest': 56}

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 net/sched/cls_flower.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index 38b2df387c1e1..e280c27cb9f9a 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -1171,8 +1171,9 @@ static void fl_set_key_flag(u32 flower_key, u32 flower_mask,
 	}
 }
 
-static int fl_set_key_flags(struct nlattr **tb, bool encap, u32 *flags_key,
-			    u32 *flags_mask, struct netlink_ext_ack *extack)
+static int fl_set_key_flags(struct nlattr *tca_opts, struct nlattr **tb,
+			    bool encap, u32 *flags_key, u32 *flags_mask,
+			    struct netlink_ext_ack *extack)
 {
 	int fl_key, fl_mask;
 	u32 key, mask;
@@ -1186,7 +1187,7 @@ static int fl_set_key_flags(struct nlattr **tb, bool encap, u32 *flags_key,
 	}
 
 	/* mask is mandatory for flags */
-	if (NL_REQ_ATTR_CHECK(extack, NULL, tb, fl_mask)) {
+	if (NL_REQ_ATTR_CHECK(extack, tca_opts, tb, fl_mask)) {
 		NL_SET_ERR_MSG(extack, "Missing flags mask");
 		return -EINVAL;
 	}
@@ -1865,9 +1866,9 @@ static int fl_set_key_cfm(struct nlattr **tb,
 	return 0;
 }
 
-static int fl_set_key(struct net *net, struct nlattr **tb,
-		      struct fl_flow_key *key, struct fl_flow_key *mask,
-		      struct netlink_ext_ack *extack)
+static int fl_set_key(struct net *net, struct nlattr *tca_opts,
+		      struct nlattr **tb, struct fl_flow_key *key,
+		      struct fl_flow_key *mask, struct netlink_ext_ack *extack)
 {
 	__be16 ethertype;
 	int ret = 0;
@@ -2100,14 +2101,16 @@ static int fl_set_key(struct net *net, struct nlattr **tb,
 		return ret;
 
 	if (tb[TCA_FLOWER_KEY_FLAGS]) {
-		ret = fl_set_key_flags(tb, false, &key->control.flags,
+		ret = fl_set_key_flags(tca_opts, tb, false,
+				       &key->control.flags,
 				       &mask->control.flags, extack);
 		if (ret)
 			return ret;
 	}
 
 	if (tb[TCA_FLOWER_KEY_ENC_FLAGS])
-		ret = fl_set_key_flags(tb, true, &key->enc_control.flags,
+		ret = fl_set_key_flags(tca_opts, tb, true,
+				       &key->enc_control.flags,
 				       &mask->enc_control.flags, extack);
 
 	return ret;
@@ -2358,6 +2361,7 @@ static int fl_change(struct net *net, struct sk_buff *in_skb,
 {
 	struct cls_fl_head *head = fl_head_dereference(tp);
 	bool rtnl_held = !(flags & TCA_ACT_FLAGS_NO_RTNL);
+	struct nlattr *tca_opts = tca[TCA_OPTIONS];
 	struct cls_fl_filter *fold = *arg;
 	bool bound_to_filter = false;
 	struct cls_fl_filter *fnew;
@@ -2366,7 +2370,7 @@ static int fl_change(struct net *net, struct sk_buff *in_skb,
 	bool in_ht;
 	int err;
 
-	if (!tca[TCA_OPTIONS]) {
+	if (!tca_opts) {
 		err = -EINVAL;
 		goto errout_fold;
 	}
@@ -2384,7 +2388,7 @@ static int fl_change(struct net *net, struct sk_buff *in_skb,
 	}
 
 	err = nla_parse_nested_deprecated(tb, TCA_FLOWER_MAX,
-					  tca[TCA_OPTIONS], fl_policy, NULL);
+					  tca_opts, fl_policy, NULL);
 	if (err < 0)
 		goto errout_tb;
 
@@ -2460,7 +2464,7 @@ static int fl_change(struct net *net, struct sk_buff *in_skb,
 		bound_to_filter = true;
 	}
 
-	err = fl_set_key(net, tb, &fnew->key, &mask->key, extack);
+	err = fl_set_key(net, tca_opts, tb, &fnew->key, &mask->key, extack);
 	if (err)
 		goto unbind_filter;
 
@@ -2800,18 +2804,19 @@ static void *fl_tmplt_create(struct net *net, struct tcf_chain *chain,
 			     struct nlattr **tca,
 			     struct netlink_ext_ack *extack)
 {
+	struct nlattr *tca_opts = tca[TCA_OPTIONS];
 	struct fl_flow_tmplt *tmplt;
 	struct nlattr **tb;
 	int err;
 
-	if (!tca[TCA_OPTIONS])
+	if (!tca_opts)
 		return ERR_PTR(-EINVAL);
 
 	tb = kcalloc(TCA_FLOWER_MAX + 1, sizeof(struct nlattr *), GFP_KERNEL);
 	if (!tb)
 		return ERR_PTR(-ENOBUFS);
 	err = nla_parse_nested_deprecated(tb, TCA_FLOWER_MAX,
-					  tca[TCA_OPTIONS], fl_policy, NULL);
+					  tca_opts, fl_policy, NULL);
 	if (err)
 		goto errout_tb;
 
@@ -2821,7 +2826,8 @@ static void *fl_tmplt_create(struct net *net, struct tcf_chain *chain,
 		goto errout_tb;
 	}
 	tmplt->chain = chain;
-	err = fl_set_key(net, tb, &tmplt->dummy_key, &tmplt->mask, extack);
+	err = fl_set_key(net, tca_opts, tb, &tmplt->dummy_key,
+			 &tmplt->mask, extack);
 	if (err)
 		goto errout_tmplt;
 
-- 
2.45.2


