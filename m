Return-Path: <netdev+bounces-170976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C70FA4AE86
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 01:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 383063B3D89
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 00:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBBEB65C;
	Sun,  2 Mar 2025 00:09:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B155CB8
	for <netdev@vger.kernel.org>; Sun,  2 Mar 2025 00:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740874150; cv=none; b=IpruNAADJGzYSrn9aNFADHtflegBIXtyjAAdML4VCLHVDpE9L+bEmKQ7LU1JSKHw1CVQw1SolqHkshys+iU9jVfSEeieTv6p16MoymAYeha5rvX4/WKv2kBpJq2gFlEJ0E1QZx8Nc2/fQgi5+QVyrPHUnOvsim0EnGwLRNNdBgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740874150; c=relaxed/simple;
	bh=I00jnRADJwEFRtPPZ05mGOmoPjaqTXXcdORafRmXjzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uZ31Hb3Jw72VrzPyt3VNepDWrV2tP+MIwYziKp6bDu6bAGrzg93U8qPEsdnkkEVV+s+bUPjKowjiu99S8xGmCOkzwdAyuAcMidDEV33ikDdDo/ujcevZva8SeeSgxOz5LWDxoUJ5tNvGGTLSpx02G5Edfw3efYSFkqDwV6zk60M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-223378e2b0dso47640225ad.0
        for <netdev@vger.kernel.org>; Sat, 01 Mar 2025 16:09:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740874146; x=1741478946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YisYUWQwiE9d1CTG46cFpCnxDOBUhRBjUXGAAGmeKpU=;
        b=lR4xBb2EKP4Jf1rgAuM+N1l7KGiEfHSdBwr8D93zJBtExHrcSxtvnSVBx/E/wkcI94
         iGevtj9FWYR8qFPBjWhTJos8NWQiBSwArBejt8h0GnDib57wAft5qcACwv4P2otddtnD
         G+2m72GagarRmHv13Q+bd7X2hZUBZXkTtDxuv+S6afvjRqbAQ6p9+AQ0fXgbY/W9U81l
         TaZgXe8Z3K7B2B5cds49qDiWfOgy7SJq6tIC/EKbGNfj/KBCMtaHUSD+A9rUhAE0ORyP
         pEYobS1Hk3TsCi8RadbyW0sEclkPoVQZffk7pYkbklY1CmWR7BQ9MLqNU8nTztiMTb9X
         RTKw==
X-Gm-Message-State: AOJu0Yxa1zy/jKU2zih+7ZTrXHETb7I8t6VE0buhkpXCdcyy5ils78vL
	IJ3gjLgs1NGMydkxg4p6GNx/tykCigfF2TiC5ySalZlG95pseUJ2+i5A
X-Gm-Gg: ASbGncvxRergHBtM8vwYJf+NNVgsq0ypF7gScrKyDxapHU7+fsndUGpkkJRzofbiAW7
	q7d0NTVtPYaipMqtGnRrgpEQYaI83CR+1y64ZvMJhGOHSbS17vITT9Y057VPWmxySy7DNTIiUmz
	O4H48+4knxDd0c5niCnG/+xB9S9hwzPZ1FsI6e7yLT8iK+I61WTbrJLt1ng1A0LZP/ygoEytsTv
	L2yWqQjgeMEec+M5YNzF9KtT7C0xUMCImnFktysfsAWh5XWNgQyfhWtPbsgqnHyrnflagg+fdYB
	qtZ1VPo+DcKzueefvh4iJBD6gGWQcd2b6KKZUYXcdoc5
X-Google-Smtp-Source: AGHT+IFLQu8JEHQMWZMhHF21PSiNdO+mtOnE08YE61UWMgqryJpyty43dyqQ4//+g9aCcHrkIRBXIQ==
X-Received: by 2002:a05:6a20:6a1b:b0:1ee:e20f:f14e with SMTP id adf61e73a8af0-1f2f4e89b5dmr12612518637.38.1740874146430;
        Sat, 01 Mar 2025 16:09:06 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7349fd03d95sm6093353b3a.0.2025.03.01.16.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 16:09:06 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v10 03/14] net: sched: wrap doit/dumpit methods
Date: Sat,  1 Mar 2025 16:08:50 -0800
Message-ID: <20250302000901.2729164-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250302000901.2729164-1-sdf@fomichev.me>
References: <20250302000901.2729164-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for grabbing netdev instance lock around qdisc
operations, introduce tc_xxx wrappers that lookup netdev
and call respective __tc_xxx helper to do the actual work.
No functional changes.

Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: Saeed Mahameed <saeed@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/sched/sch_api.c | 190 ++++++++++++++++++++++++++++----------------
 1 file changed, 122 insertions(+), 68 deletions(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index e3e91cf867eb..e0be3af4daa9 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1505,27 +1505,18 @@ const struct nla_policy rtm_tca_policy[TCA_MAX + 1] = {
  * Delete/get qdisc.
  */
 
-static int tc_get_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
-			struct netlink_ext_ack *extack)
+static int __tc_get_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
+			  struct netlink_ext_ack *extack,
+			  struct net_device *dev,
+			  struct nlattr *tca[TCA_MAX + 1],
+			  struct tcmsg *tcm)
 {
 	struct net *net = sock_net(skb->sk);
-	struct tcmsg *tcm = nlmsg_data(n);
-	struct nlattr *tca[TCA_MAX + 1];
-	struct net_device *dev;
-	u32 clid;
 	struct Qdisc *q = NULL;
 	struct Qdisc *p = NULL;
+	u32 clid;
 	int err;
 
-	err = nlmsg_parse_deprecated(n, sizeof(*tcm), tca, TCA_MAX,
-				     rtm_tca_policy, extack);
-	if (err < 0)
-		return err;
-
-	dev = __dev_get_by_index(net, tcm->tcm_ifindex);
-	if (!dev)
-		return -ENODEV;
-
 	clid = tcm->tcm_parent;
 	if (clid) {
 		if (clid != TC_H_ROOT) {
@@ -1582,6 +1573,27 @@ static int tc_get_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 	return 0;
 }
 
+static int tc_get_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
+			struct netlink_ext_ack *extack)
+{
+	struct net *net = sock_net(skb->sk);
+	struct tcmsg *tcm = nlmsg_data(n);
+	struct nlattr *tca[TCA_MAX + 1];
+	struct net_device *dev;
+	int err;
+
+	err = nlmsg_parse_deprecated(n, sizeof(*tcm), tca, TCA_MAX,
+				     rtm_tca_policy, extack);
+	if (err < 0)
+		return err;
+
+	dev = __dev_get_by_index(net, tcm->tcm_ifindex);
+	if (!dev)
+		return -ENODEV;
+
+	return __tc_get_qdisc(skb, n, extack, dev, tca, tcm);
+}
+
 static bool req_create_or_replace(struct nlmsghdr *n)
 {
 	return (n->nlmsg_flags & NLM_F_CREATE &&
@@ -1601,35 +1613,19 @@ static bool req_change(struct nlmsghdr *n)
 		!(n->nlmsg_flags & NLM_F_EXCL));
 }
 
-/*
- * Create/change qdisc.
- */
-static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
-			   struct netlink_ext_ack *extack)
+static int __tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
+			     struct netlink_ext_ack *extack,
+			     struct net_device *dev,
+			     struct nlattr *tca[TCA_MAX + 1],
+			     struct tcmsg *tcm,
+			     bool *replay)
 {
-	struct net *net = sock_net(skb->sk);
-	struct tcmsg *tcm;
-	struct nlattr *tca[TCA_MAX + 1];
-	struct net_device *dev;
+	struct Qdisc *q = NULL;
+	struct Qdisc *p = NULL;
 	u32 clid;
-	struct Qdisc *q, *p;
 	int err;
 
-replay:
-	/* Reinit, just in case something touches this. */
-	err = nlmsg_parse_deprecated(n, sizeof(*tcm), tca, TCA_MAX,
-				     rtm_tca_policy, extack);
-	if (err < 0)
-		return err;
-
-	tcm = nlmsg_data(n);
 	clid = tcm->tcm_parent;
-	q = p = NULL;
-
-	dev = __dev_get_by_index(net, tcm->tcm_ifindex);
-	if (!dev)
-		return -ENODEV;
-
 
 	if (clid) {
 		if (clid != TC_H_ROOT) {
@@ -1755,7 +1751,7 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 	}
 	err = qdisc_change(q, tca, extack);
 	if (err == 0)
-		qdisc_notify(net, skb, n, clid, NULL, q, extack);
+		qdisc_notify(sock_net(skb->sk), skb, n, clid, NULL, q, extack);
 	return err;
 
 create_n_graft:
@@ -1788,8 +1784,10 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 				 tca, &err, extack);
 	}
 	if (q == NULL) {
-		if (err == -EAGAIN)
-			goto replay;
+		if (err == -EAGAIN) {
+			*replay = true;
+			return 0;
+		}
 		return err;
 	}
 
@@ -1804,6 +1802,38 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 	return 0;
 }
 
+/*
+ * Create/change qdisc.
+ */
+static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
+			   struct netlink_ext_ack *extack)
+{
+	struct net *net = sock_net(skb->sk);
+	struct tcmsg *tcm = nlmsg_data(n);
+	struct nlattr *tca[TCA_MAX + 1];
+	struct net_device *dev;
+	bool replay;
+	int err;
+
+replay:
+	/* Reinit, just in case something touches this. */
+	err = nlmsg_parse_deprecated(n, sizeof(*tcm), tca, TCA_MAX,
+				     rtm_tca_policy, extack);
+	if (err < 0)
+		return err;
+
+	dev = __dev_get_by_index(net, tcm->tcm_ifindex);
+	if (!dev)
+		return -ENODEV;
+
+	replay = false;
+	err = __tc_modify_qdisc(skb, n, extack, dev, tca, tcm, &replay);
+	if (replay)
+		goto replay;
+
+	return err;
+}
+
 static int tc_dump_qdisc_root(struct Qdisc *root, struct sk_buff *skb,
 			      struct netlink_callback *cb,
 			      int *q_idx_p, int s_q_idx, bool recur,
@@ -2135,15 +2165,15 @@ static void tc_bind_tclass(struct Qdisc *q, u32 portid, u32 clid,
 
 #endif
 
-static int tc_ctl_tclass(struct sk_buff *skb, struct nlmsghdr *n,
-			 struct netlink_ext_ack *extack)
+static int __tc_ctl_tclass(struct sk_buff *skb, struct nlmsghdr *n,
+			   struct netlink_ext_ack *extack,
+			   struct net_device *dev,
+			   struct nlattr *tca[TCA_MAX + 1],
+			   struct tcmsg *tcm)
 {
 	struct net *net = sock_net(skb->sk);
-	struct tcmsg *tcm = nlmsg_data(n);
-	struct nlattr *tca[TCA_MAX + 1];
-	struct net_device *dev;
-	struct Qdisc *q = NULL;
 	const struct Qdisc_class_ops *cops;
+	struct Qdisc *q = NULL;
 	unsigned long cl = 0;
 	unsigned long new_cl;
 	u32 portid;
@@ -2151,15 +2181,6 @@ static int tc_ctl_tclass(struct sk_buff *skb, struct nlmsghdr *n,
 	u32 qid;
 	int err;
 
-	err = nlmsg_parse_deprecated(n, sizeof(*tcm), tca, TCA_MAX,
-				     rtm_tca_policy, extack);
-	if (err < 0)
-		return err;
-
-	dev = __dev_get_by_index(net, tcm->tcm_ifindex);
-	if (!dev)
-		return -ENODEV;
-
 	/*
 	   parent == TC_H_UNSPEC - unspecified parent.
 	   parent == TC_H_ROOT   - class is root, which has no parent.
@@ -2268,6 +2289,27 @@ static int tc_ctl_tclass(struct sk_buff *skb, struct nlmsghdr *n,
 	return err;
 }
 
+static int tc_ctl_tclass(struct sk_buff *skb, struct nlmsghdr *n,
+			 struct netlink_ext_ack *extack)
+{
+	struct net *net = sock_net(skb->sk);
+	struct tcmsg *tcm = nlmsg_data(n);
+	struct nlattr *tca[TCA_MAX + 1];
+	struct net_device *dev;
+	int err;
+
+	err = nlmsg_parse_deprecated(n, sizeof(*tcm), tca, TCA_MAX,
+				     rtm_tca_policy, extack);
+	if (err < 0)
+		return err;
+
+	dev = __dev_get_by_index(net, tcm->tcm_ifindex);
+	if (!dev)
+		return -ENODEV;
+
+	return __tc_ctl_tclass(skb, n, extack, dev, tca, tcm);
+}
+
 struct qdisc_dump_args {
 	struct qdisc_walker	w;
 	struct sk_buff		*skb;
@@ -2344,20 +2386,12 @@ static int tc_dump_tclass_root(struct Qdisc *root, struct sk_buff *skb,
 	return 0;
 }
 
-static int tc_dump_tclass(struct sk_buff *skb, struct netlink_callback *cb)
+static int __tc_dump_tclass(struct sk_buff *skb, struct netlink_callback *cb,
+			    struct tcmsg *tcm, struct net_device *dev)
 {
-	struct tcmsg *tcm = nlmsg_data(cb->nlh);
-	struct net *net = sock_net(skb->sk);
 	struct netdev_queue *dev_queue;
-	struct net_device *dev;
 	int t, s_t;
 
-	if (nlmsg_len(cb->nlh) < sizeof(*tcm))
-		return 0;
-	dev = dev_get_by_index(net, tcm->tcm_ifindex);
-	if (!dev)
-		return 0;
-
 	s_t = cb->args[0];
 	t = 0;
 
@@ -2374,10 +2408,30 @@ static int tc_dump_tclass(struct sk_buff *skb, struct netlink_callback *cb)
 done:
 	cb->args[0] = t;
 
-	dev_put(dev);
 	return skb->len;
 }
 
+static int tc_dump_tclass(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	struct tcmsg *tcm = nlmsg_data(cb->nlh);
+	struct net *net = sock_net(skb->sk);
+	struct net_device *dev;
+	int err;
+
+	if (nlmsg_len(cb->nlh) < sizeof(*tcm))
+		return 0;
+
+	dev = dev_get_by_index(net, tcm->tcm_ifindex);
+	if (!dev)
+		return 0;
+
+	err = __tc_dump_tclass(skb, cb, tcm, dev);
+
+	dev_put(dev);
+
+	return err;
+}
+
 #ifdef CONFIG_PROC_FS
 static int psched_show(struct seq_file *seq, void *v)
 {
-- 
2.48.1


