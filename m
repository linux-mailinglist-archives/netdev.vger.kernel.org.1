Return-Path: <netdev+bounces-241693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8ECDC87644
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 23:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF4D43AFF04
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 22:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6F8289811;
	Tue, 25 Nov 2025 22:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="QfxVt/BL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380571EFF80
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 22:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764110775; cv=none; b=dxcUf99LXu6NxM4hvM365ind2Pc+N25xdWNe2FIBqGEyKHyJnz+do5cMZ6V9cBtPS/jkBEUAnPH+CJQaxBOCku0FGCTSBbNgW/ISvAPTYtyPwWPXtMdb1dZA4hzbrgIt0cjNMb7GPGjb4cFGmRihabIdhouqLJ1QUMlciVJr1Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764110775; c=relaxed/simple;
	bh=4q/Oaq7hZrKCHENYRAJ4vYJj43JAPNuh9ebxCXFWCf0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DwdFtkjDAkIAfXJ2+WDYa32Cvl6FxDTK4LfeEfDwJ5mcFlnAmNgsUo7vTFpPyjiz+0iDbrTgsuYfgivbngTy5/2OvoU4vfZMXqMkPAVcL7rFlRVDrWh5TvLy+FJVYA6aWhkyXMkZZVl0iRfjHmQLryh3xQgCF2WYez2M5RktwNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=QfxVt/BL; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-55b09d690dcso2078333e0c.1
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 14:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1764110772; x=1764715572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J9X+mu0bZtmEignMBCmf1REa2vZ3EmBWt7hqWgUdVTA=;
        b=QfxVt/BLDMyliGab5QwMy8LzzjWlisH6Or3aWKyLJi6TWhsrtDHwiKZsadYM8hyUAR
         9jMbxGQ9EZ4PlZqn3HBZwh2YflvYwsFkuAiDssKV8SIrioN71Lr46xi346ra9PFxOfub
         crKz2WTQee4w2ECKUclQjxVRm9ovnDNdq1tWwNN1UqGPZ3hKUj1ZiKtuVheA3lMXP7xS
         60kO2dvijNHBsNZiYPY2BkCCi45DD7A8L/xXzT0qVsiY1l41MTE/x4vQWLEjQr769Ziv
         mJMAqRDil0Ipmd1llG+JBGgYblTISZNdBFIuicwa4l8ZhYBghZA+lr+x5MIyy+44GXZf
         kMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764110772; x=1764715572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9X+mu0bZtmEignMBCmf1REa2vZ3EmBWt7hqWgUdVTA=;
        b=b4Tckjs3gQmpzq014kHBDr+dw7LzeMvBUjEDamFtxanYP08kc2J/eZUQcEnV6Hxm2D
         dFqpzCysQGS18/jhTVIlRRg9flrzW9rQEOgnddWdQLA17zUs0S84JVGNaLEJOehOraME
         43DqUdm3FHDO2/1FJU52pfUEFwyCfOTrizBbGUIjNOfnUELWUgFV0ZC6SQ7A/yFjvDDa
         sC0/OnvGRpqkZM7gtswiHj15nWGHL7ScPCAVWBGm+80g3iL05erbnT7qoIFjkiJtvkuO
         oYY8nVcHBw1afJgZcbEUpmvwq1UvD3F8RR/dRHo8oMv0gYeRvtWSYOGGyOa326mLH846
         Rpgw==
X-Gm-Message-State: AOJu0Yw+NQAU2yCDwGIVSrVmOzZrZppEG6uc0yTmXhTxi7rkHW4snQdO
	LN210DgHQBKl2yDR8geuqfc3jeaQ5vnvtiD8yfF573dTuJuLOR/n9aks03QeVhx+hw==
X-Gm-Gg: ASbGnct9qcH4ZCA2QKMhd6v/ahQK+W5khFxDkJc8MRWGzSqpOu0kLBKE9/BDr5LsZUs
	eYDEYxFxqVq1uu+njvlsTI5fNBvgkiiJFQXXAfQeAOHwgM1HWCTDV/9B3/QzX08rlpcAUp8KXtO
	tZH7tQRKLqz07rtKeWGva1gKS7yK4AZkgYEuN8e1EbQGPypT8kEMuwMI9Xunkp5ZLmIupjLcKcw
	MOSOEcv7vDOrqFKBqLVkof6ZkBXkkZ7U6kgnxO25y2qynwYvf2DL/hC5cChYZxNCsvpGuNsIHH/
	/TmxSHDljvOy/my8sDhxFPGyRgmu0pR0fTJLpDAdK+QONB9S5b+QQeAtbd5b6N/ardsK11bsWpZ
	9kFgc3NSMQZ2XBTkjjrajNdxeMeYR/mFXLhZaqBK3fxU0S9+4i9ooRKldrtLE6Fp2CPCjZEQ=
X-Google-Smtp-Source: AGHT+IFx2nZMXXUkhaUfdZGdJYWmOKHkqsDdbP1Rj2gbbKq+9blbhJO0wgLUGynIdDFTvBczrmm/7A==
X-Received: by 2002:a05:6122:30d1:b0:55b:1ac6:6c70 with SMTP id 71dfb90a1353d-55cd761fa00mr1504493e0c.2.1764110771957;
        Tue, 25 Nov 2025 14:46:11 -0800 (PST)
Received: from exu-caveira ([2804:14d:5c54:4efb::2000])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55b7f602229sm7620042e0c.1.2025.11.25.14.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 14:46:11 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	horms@kernel.org,
	stephen@networkplumber.org
Cc: netdev@vger.kernel.org
Subject: [RFC PATCH net-next v2] net/sched: Introduce qdisc quirk_chk op
Date: Tue, 25 Nov 2025 19:46:04 -0300
Message-ID: <20251125224604.872351-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a pattern of bugs that end up creating UAFs or null ptr derefs.
The majority of these bugs follow the formula below:
a) create a nonsense hierarchy of qdiscs which has no practical value,
b) start sending packets
Optional c) netlink cmds to change hierarchy some more; It's more fun if
you can get packets stuck - the formula in this case includes non
work-conserving qdiscs somewhere in the hierarchy
Optional d dependent on c) send more packets
e) profit

Current init/change qdisc APIs are localised to validate only within the
constraint of a single qdisc. So catching #a or #c is a challenge. Our
policy, when said bugs are presented, is to "make it work" by modifying
generally used data structures and code, but these come at the expense of
adding special checks for corner cases which are nonsensical to begin with.

The goal of this patchset is to create an equivalent to PCI quirks, which
will catch nonsensical hierarchies in #a and #c and reject such a config.

With that in mind, we are proposing the addition of a new qdisc op
(quirk_chk). We introduce, as a first example, the quirk_chk op to netem.
Its purpose here is to validate whether the user is attempting to add 2
netem duplicates in the same qdisc tree which will be forbidden unless
the root qdisc is multiqueue.

Here is an example that should now work:

DEV="eth0"
NUM_QUEUES=4
DUPLICATE_PERCENT="5%"

tc qdisc del dev $DEV root > /dev/null 2>&1
tc qdisc add dev $DEV root handle 1: mq

for i in $(seq 1 $NUM_QUEUES); do
    HANDLE_ID=$((i * 10))
    PARENT_ID="1:$i"
    tc qdisc add dev $DEV parent $PARENT_ID handle \
        ${HANDLE_ID}: netem duplicate $DUPLICATE_PERCENT
done

Suggested-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
v1 -> v2:
- Simplify process of getting root qdisc in netem_quirk_chk
- Use parent's major directly instead of looking up parent qdisc in
  netem_quirk_chk
- Call parse_attrs in netem_quirk_chk to avoid issue caught by syzbot

Link to v1:
https://lore.kernel.org/netdev/20251124223749.503979-1-victor@mojatatu.com/
---
 include/net/sch_generic.h |  3 +++
 net/sched/sch_api.c       | 12 ++++++++++++
 net/sched/sch_netem.c     | 40 +++++++++++++++++++++++++++------------
 3 files changed, 43 insertions(+), 12 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 94966692ccdf..60450372c5d5 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -313,6 +313,9 @@ struct Qdisc_ops {
 						     u32 block_index);
 	void			(*egress_block_set)(struct Qdisc *sch,
 						    u32 block_index);
+	int			(*quirk_chk)(struct Qdisc *sch,
+					     struct nlattr *arg,
+					     struct netlink_ext_ack *extack);
 	u32			(*ingress_block_get)(struct Qdisc *sch);
 	u32			(*egress_block_get)(struct Qdisc *sch);
 
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index f56b18c8aebf..a850df437691 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1315,6 +1315,12 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 		rcu_assign_pointer(sch->stab, stab);
 	}
 
+	if (ops->quirk_chk) {
+		err = ops->quirk_chk(sch, tca[TCA_OPTIONS], extack);
+		if (err != 0)
+			goto err_out3;
+	}
+
 	if (ops->init) {
 		err = ops->init(sch, tca[TCA_OPTIONS], extack);
 		if (err != 0)
@@ -1378,6 +1384,12 @@ static int qdisc_change(struct Qdisc *sch, struct nlattr **tca,
 			NL_SET_ERR_MSG(extack, "Change of blocks is not supported");
 			return -EOPNOTSUPP;
 		}
+		if (sch->ops->quirk_chk) {
+			err = sch->ops->quirk_chk(sch, tca[TCA_OPTIONS],
+						  extack);
+			if (err != 0)
+				return err;
+		}
 		err = sch->ops->change(sch, tca[TCA_OPTIONS], extack);
 		if (err)
 			return err;
diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index eafc316ae319..ceece2ae37bc 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -975,13 +975,27 @@ static int parse_attr(struct nlattr *tb[], int maxtype, struct nlattr *nla,
 
 static const struct Qdisc_class_ops netem_class_ops;
 
-static int check_netem_in_tree(struct Qdisc *sch, bool duplicates,
-			       struct netlink_ext_ack *extack)
+static int netem_quirk_chk(struct Qdisc *sch, struct nlattr *opt,
+			   struct netlink_ext_ack *extack)
 {
+	struct nlattr *tb[TCA_NETEM_MAX + 1];
+	struct tc_netem_qopt *qopt;
 	struct Qdisc *root, *q;
+	struct net_device *dev;
+	bool root_is_mq;
+	bool duplicates;
 	unsigned int i;
+	int ret;
+
+	ret = parse_attr(tb, TCA_NETEM_MAX, opt, netem_policy, sizeof(*qopt));
+	if (ret < 0)
+		return ret;
 
-	root = qdisc_root_sleeping(sch);
+	qopt = nla_data(opt);
+	duplicates = qopt->duplicate;
+
+	dev = sch->dev_queue->dev;
+	root = rtnl_dereference(dev->qdisc);
 
 	if (sch != root && root->ops->cl_ops == &netem_class_ops) {
 		if (duplicates ||
@@ -992,19 +1006,25 @@ static int check_netem_in_tree(struct Qdisc *sch, bool duplicates,
 	if (!qdisc_dev(root))
 		return 0;
 
+	root_is_mq = root->flags & TCQ_F_MQROOT;
+
 	hash_for_each(qdisc_dev(root)->qdisc_hash, i, q, hash) {
 		if (sch != q && q->ops->cl_ops == &netem_class_ops) {
 			if (duplicates ||
-			    ((struct netem_sched_data *)qdisc_priv(q))->duplicate)
-				goto err;
+			    ((struct netem_sched_data *)qdisc_priv(q))->duplicate) {
+				if (!root_is_mq ||
+				    TC_H_MAJ(q->parent) != root->handle ||
+				    TC_H_MAJ(q->parent) != TC_H_MAJ(sch->parent))
+					goto err;
+			}
 		}
 	}
 
 	return 0;
 
 err:
-	NL_SET_ERR_MSG(extack,
-		       "netem: cannot mix duplicating netems with other netems in tree");
+	NL_SET_ERR_MSG_MOD(extack,
+			   "cannot mix duplicating netems with other netems in tree unless root is multiqueue");
 	return -EINVAL;
 }
 
@@ -1066,11 +1086,6 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	q->gap = qopt->gap;
 	q->counter = 0;
 	q->loss = qopt->loss;
-
-	ret = check_netem_in_tree(sch, qopt->duplicate, extack);
-	if (ret)
-		goto unlock;
-
 	q->duplicate = qopt->duplicate;
 
 	/* for compatibility with earlier versions.
@@ -1352,6 +1367,7 @@ static struct Qdisc_ops netem_qdisc_ops __read_mostly = {
 	.destroy	=	netem_destroy,
 	.change		=	netem_change,
 	.dump		=	netem_dump,
+	.quirk_chk	=	netem_quirk_chk,
 	.owner		=	THIS_MODULE,
 };
 MODULE_ALIAS_NET_SCH("netem");
-- 
2.51.0


