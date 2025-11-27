Return-Path: <netdev+bounces-242350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E30C8F8C4
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 17:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 72F744E24D6
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 16:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8DE337B95;
	Thu, 27 Nov 2025 16:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="R/NYpJEX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3942D9EDA
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 16:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764262187; cv=none; b=hFZ2uHzsAKjzJxjLZH3qHu3q9vl6fwyZ0Efat47b199jtgz9Uqxedjj5RTlduceob4duhzfUem0fStRnukgKppikp/Y2rK+f46ZrW4TKzBlRgy6DGTnvUi6Qogb75jN8W3oV2KAW5R+MOmUctCUx4Hb8ihVgzZuR8Cx9LCcbGYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764262187; c=relaxed/simple;
	bh=IRB7jhFJ+nm9chdiiiuWId0/J0t+bUSWlG0QPdTikOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AcCmZSHl/mhNcBr5Vz91pgaC/JEj95nh0r5CTG56Bj6j/ANou/w2nVfRB91kk6kihZWnq5cwchbaWLDtOgYyQ1il2138q254UJ6ZcyGSfExb1xLjbC02yt7g+tYz1htVa+20u4JGgmXyUuvHz/ouLj4bRxXohji6b7cpS6R6uN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=R/NYpJEX; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-9371f6f2813so307422241.0
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 08:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1764262184; x=1764866984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OqwUNfhCz1Ixhh0KZbFL5nwNvMDKQsr6VzLrfCwdRmA=;
        b=R/NYpJEX8rn59dsn30WiISSgZPJjVIp+PtwOUO+Yz1erroKdPfoIXsKFQglyC9DA9M
         k1ZoYNwpDxewNwS6Ipq69kM/CQ7WiSvq9cXAW3xg8OT/AOUBvGBffOhwXFWbCy78rs9G
         xVXdvxQG/C8DDreGhQVnfHerjXr/88agmrQa65w7XMJR3N+R5t1J36xmogcbU9xUd8bf
         mEQCF/baYMk4RLTjdOzoY+MQU4F40D2nttwCtbY8OiGBNVWvwecCjmWGw93gVgBACoIv
         mqlB0UseKr9ovdxHxP9WgzQJfcnZIP9Tiw11Lufe9ZeKKSRjaurjJxg6R5tl3EYQCaqi
         /3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764262184; x=1764866984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqwUNfhCz1Ixhh0KZbFL5nwNvMDKQsr6VzLrfCwdRmA=;
        b=bRyAc2C6S1UBcgELXRlwg/mMkGMz8Km1TJoVUrwXm8OnPLyxz/fxlcV9MBlMsx66UR
         TvONgY+QW18LYc3iMKSeL/dGrdDDti6759+NGLZNyf7uKPRYt7oMUhh31uwo0aR0sfn2
         fTGAUyAj4R3isMnqsPmOwV3ZQOXVj1lQqsfA446r2RRJ6jcN8Zfa+oS4i3J7CGgkrWl4
         bvhzxM5Q1sUaT/2FXTbMVrRcmn1+Nrwa7E0WtJGWVbVHzjr6NYZ9fNrL9ypQkGu9tv/C
         QAQiTqSocfVqXT+OJb2Nw5y3J23xG4E7rSrrLCcwOYAhEfsZOyZy061cGtLqFoNkBckA
         Bc4w==
X-Gm-Message-State: AOJu0YxlRmUKg3lOGnDB9g+eAQdr3JXqZixKVdsn4NqY9FAaGDKbGnx8
	J4TV+gF4Gt+KgTve+jdV3ohlCa0ui/5qa8/md3zifQAwMOY/oQoSIn3MPRgdLSDefg==
X-Gm-Gg: ASbGnctqespV8fFBgIy9DW7Yt7fUx82Qji97jULtvElW43L5jX9DRXASuajuQnFscPU
	f7nVUA/IDIpuCXTYn55mslIMceTLGJj7TYpHQCUqfpOtVIEBh2DGjm/AwUeSZBHAjSCa9+qOkdo
	rxNxJfixQe4e23oO8vJHMDDlmHPWv+P9hdzy7PNp6JrCh16NtCV5kNGSSM1+xwm/zYlWCjwLrJ9
	9OHTq6njxEGWhVllWqsxAXkS5Ot0fnwPsDf5Wlk5/HeToj0k6h7ZyTRn90O4L3dE3EFdi5H29vK
	0DcxT13OEzYoGqYxmFQ3L3HDw3AiNbSGq2oHBJNEOGdFMcrxggM9VlW74yrqmCjF2yiRdxEqaX5
	bOEfQKh9icxV3Z5KSzJWRaOwEHLW11WfS9pfBpdOXWvhAahEgTiimmnJaCHxuDRPrgEaxBG4=
X-Google-Smtp-Source: AGHT+IGhxCv7A3ioj8Y4csckyiphqNjRupv2lLJ6t5r67rAsJMVMu5WCbJ7qXExey+PVeF2t8KT5DA==
X-Received: by 2002:a67:e709:0:b0:5dd:c3ec:b67 with SMTP id ada2fe7eead31-5e1de1ed4d7mr8208347137.17.1764262184464;
        Thu, 27 Nov 2025 08:49:44 -0800 (PST)
Received: from exu-caveira ([2804:14d:5c54:4efb::1c9d])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5e24d91798csm675260137.3.2025.11.27.08.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 08:49:43 -0800 (PST)
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
Subject: [RFC PATCH net-next v3] net/sched: Introduce qdisc quirk_chk op
Date: Thu, 27 Nov 2025 13:49:35 -0300
Message-ID: <20251127164935.572746-1-victor@mojatatu.com>
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
Its purpose here is to validate whether the user is attempting to add
nested netem duplicates in the same qdisc tree branch which will be
forbidden.

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
v2 -> v3:
- Restrict netem duplicate nested on the same qdisc tree branch instead of
  the whole tree
- Use qdisc_lookup to iterate through qdisc ancestors
- Check whether opt is NULL directly in netem_quirk_chk

Link to v2:
https://lore.kernel.org/netdev/20251125224604.872351-1-victor@mojatatu.com/

v1 -> v2:
- Simplify process of getting root qdisc in netem_quirk_chk
- Use parent's major directly instead of looking up parent qdisc in
  netem_quirk_chk
- Call parse_attrs in netem_quirk_chk to avoid issue caught by syzbot

Link to v1:
https://lore.kernel.org/netdev/20251124223749.503979-1-victor@mojatatu.com/
---
 include/net/sch_generic.h |  3 +++
 net/sched/sch_api.c       | 13 ++++++++++
 net/sched/sch_netem.c     | 54 ++++++++++++++++++++++-----------------
 3 files changed, 46 insertions(+), 24 deletions(-)

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
index f56b18c8aebf..73190d8ca792 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -316,6 +316,7 @@ struct Qdisc *qdisc_lookup(struct net_device *dev, u32 handle)
 out:
 	return q;
 }
+EXPORT_SYMBOL_GPL(qdisc_lookup);
 
 struct Qdisc *qdisc_lookup_rcu(struct net_device *dev, u32 handle)
 {
@@ -1315,6 +1316,12 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
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
@@ -1378,6 +1385,12 @@ static int qdisc_change(struct Qdisc *sch, struct nlattr **tca,
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
index eafc316ae319..6ddc9250ca88 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -975,36 +975,46 @@ static int parse_attr(struct nlattr *tb[], int maxtype, struct nlattr *nla,
 
 static const struct Qdisc_class_ops netem_class_ops;
 
-static int check_netem_in_tree(struct Qdisc *sch, bool duplicates,
-			       struct netlink_ext_ack *extack)
+static int netem_quirk_chk(struct Qdisc *sch, struct nlattr *opt,
+			   struct netlink_ext_ack *extack)
 {
-	struct Qdisc *root, *q;
-	unsigned int i;
+	struct tc_netem_qopt *qopt;
+	bool duplicates;
+	struct Qdisc *q;
+	u32 parentid;
+
+	if (!opt)
+		return -EINVAL;
 
-	root = qdisc_root_sleeping(sch);
+	qopt = nla_data(opt);
+	duplicates = qopt->duplicate;
 
-	if (sch != root && root->ops->cl_ops == &netem_class_ops) {
-		if (duplicates ||
-		    ((struct netem_sched_data *)qdisc_priv(root))->duplicate)
-			goto err;
-	}
+	if (duplicates) {
+		q = sch;
+		while ((parentid = q->parent)) {
+			if (parentid == TC_H_ROOT)
+				break;
 
-	if (!qdisc_dev(root))
-		return 0;
+			if (q->flags & TCQ_F_NOPARENT)
+				break;
 
-	hash_for_each(qdisc_dev(root)->qdisc_hash, i, q, hash) {
-		if (sch != q && q->ops->cl_ops == &netem_class_ops) {
-			if (duplicates ||
-			    ((struct netem_sched_data *)qdisc_priv(q))->duplicate)
-				goto err;
+			q = qdisc_lookup(qdisc_dev(q), TC_H_MAJ(parentid));
+			if (!q)
+				break;
+
+			if (q->ops->cl_ops == &netem_class_ops) {
+				struct netem_sched_data *priv = qdisc_priv(q);
+
+				if (priv->duplicate)
+					goto err;
+			}
 		}
 	}
 
 	return 0;
 
 err:
-	NL_SET_ERR_MSG(extack,
-		       "netem: cannot mix duplicating netems with other netems in tree");
+	NL_SET_ERR_MSG_MOD(extack, "cannot have nested netem duplicates");
 	return -EINVAL;
 }
 
@@ -1066,11 +1076,6 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
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
@@ -1352,6 +1357,7 @@ static struct Qdisc_ops netem_qdisc_ops __read_mostly = {
 	.destroy	=	netem_destroy,
 	.change		=	netem_change,
 	.dump		=	netem_dump,
+	.quirk_chk	=	netem_quirk_chk,
 	.owner		=	THIS_MODULE,
 };
 MODULE_ALIAS_NET_SCH("netem");
-- 
2.51.0


