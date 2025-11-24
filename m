Return-Path: <netdev+bounces-241327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 195F3C82B26
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 23:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D4394E85E4
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 22:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174B3251793;
	Mon, 24 Nov 2025 22:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="T18hk+tB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADCE17C77
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 22:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764023879; cv=none; b=fEjvTymwPSbyGSMv8Jbf/8Cy3U9IYQi9xvv4795OvZ3Yxe4WMHj49ManEE8pSNnQry/7uGIUtdKui/QSAeXN9OxahZZ0e4tkFrdR1oI62IYUKiiXx2DmBek9nl/oVJZs34mlcFG1K42NQ4/e9F6g91UOshDTYvE1yj2lj1pR4DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764023879; c=relaxed/simple;
	bh=Wbgtizxmlx8vr30aI7v3ij7zfEToerKkY7crapHguIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZTlCGV/MuKCSY5P/+s4HkRtFgFYkLDc6X2gs3f0btHX4oKGylNp+Mdf1l6JxrFNM56nPU4k2EDaI77PVOO+4s51P5T4Mnxb47gQ29eisFmIN9GjXgBtIoKv3PtI5Cj/kRpdIzAmxS2uxm0av6Y3b2BymPo0WEmnzpPXpctdV1uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=T18hk+tB; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-55b2a09ff61so1227423e0c.2
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 14:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1764023876; x=1764628676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GNf2oWUYsYe6ELER76zTEPUGnsE/PDnhgjkM0gvK4v0=;
        b=T18hk+tBHNE/QIAremJoQemqqRIltvhYUGslbxkHu443CYQd1vVc1cfM0MANVcxIic
         2eiFgBMcCRLRqM19EhIpMBoI942kUdH0tvQLX/2yl2DH9kDPwOEJDIGiCQZ4KQu85QFb
         eYmjLLHfaNziziD7IWmM/f6aaBRj4CBUV/oGf3dpEci2Q6qwRXjDF+EiJ2Jcc84Jxlab
         4QDgiHLFuksYxuC6HqMQAPe/VP8zvFsWVC/+1F8fxQN7nPURb5cXG8IGwlhQ/EBdF3Pi
         rz34vwsmxsKdtKLyrL8XLivzuLKZt14Kt8yTc3DcHVM/rsOz8AEbHQ07BS4eEwwHionw
         Qu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764023876; x=1764628676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNf2oWUYsYe6ELER76zTEPUGnsE/PDnhgjkM0gvK4v0=;
        b=IzRbiat835X/aFksn1CKxOFpIt3B4Xcdq1l0pASTNcn3mjIAkoQf/6+McRzfObk3hH
         8UnrUmxHDtLM6e743FwzxSuFh+4eLNAE98ayWk6kr2UzVQtzSuT9byaH709RIXMHxjpp
         f/wbKBe8eki7AvHMw5V90T5NdHQGy2nxrFzIOsRye5dNzg2W6iDZc+TC8xG/QM4oYkgB
         CfiN9fMAtMEXgSfLr95WLyUEEixTGPOW3E+G9+G5qrc7bairYlLTRyPynqhOKXFd9j2x
         9cRcgg9ZXiqJyXYRawTg8QwAmXjlUek1/N5oKE41B2jf04Gfo/wH1PB4V4ShuMKHVPt4
         gLJA==
X-Gm-Message-State: AOJu0YymowC6dLO/QqTJHMUmK6HUmHjV4odbQ79eECMPX6SSX3ZcoqyC
	ntR2aMNSoa0DqLY8QSl5Vd7r+s8cCH9MB3JHUimUn12UaA8nen9IQUtt5llZWuEQ/g==
X-Gm-Gg: ASbGncvnG66mAED8oA/+Y3T3QJGSaskONO4NsO7SxE/TFuLszrJZru+UM5JjlYMqxci
	K6zUBt4XBF4gKksRquLGp+vlle/3YVPjy2A8Hr2/87GhqAM/RWklgwxaNoTFyXl4IGB0b2FVi57
	1JRdZ2Y7j/MpYd+2ev3aFyAllhh3KivRSOAhn55tf4bbQ1bDxM3ZQf3Znu5TdK+ymlYWaWkt/fk
	XM6RgmcWT7rPjgmtEu969n+mgelL7/z/lWssKtmqRSRiNZg1Vj4OF6BXNDeFZysTrt/nxjZY8L0
	Dgg5qcpMAGpkjuh2ZCKrIUkMNk8cUrOKTiEiJ4t8Yu8N8iHGsbKYJrhxOqGkowUZ+rfOtDA16UX
	Gi2jdG5atEkXyktneIz3dVDH6/dxiVsfhjA4TtpLXLWrPQ52KkUbqQb+ZqNRACd6+Y6LRY0A=
X-Google-Smtp-Source: AGHT+IGGNOYQXuVzYmS53qhHPM0bYwZoyM2/Wf6uN5Ok7nrlp37zr5dJgaenDkRYqvUKjt+6y7+feg==
X-Received: by 2002:a05:6122:88a:b0:55b:9c3f:55f with SMTP id 71dfb90a1353d-55b9c3f068cmr2755293e0c.18.1764023875612;
        Mon, 24 Nov 2025 14:37:55 -0800 (PST)
Received: from exu-caveira ([2804:14d:5c54:4efb::2000])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55b7f7a07e1sm6260723e0c.15.2025.11.24.14.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 14:37:55 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	xiyou.wangcong@gmail.com
Cc: netdev@vger.kernel.org
Subject: [RFC PATCH net-next] net/sched: Introduce qdisc quirk_chk op
Date: Mon, 24 Nov 2025 19:37:49 -0300
Message-ID: <20251124223749.503979-1-victor@mojatatu.com>
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
 include/net/sch_generic.h |  3 +++
 net/sched/sch_api.c       | 12 ++++++++++
 net/sched/sch_netem.c     | 47 +++++++++++++++++++++++++++++----------
 3 files changed, 50 insertions(+), 12 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 738cd5b13c62..405a6af22d8e 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -316,6 +316,9 @@ struct Qdisc_ops {
 						     u32 block_index);
 	void			(*egress_block_set)(struct Qdisc *sch,
 						    u32 block_index);
+	int			(*quirk_chk)(struct Qdisc *sch,
+					     struct nlattr *arg,
+					     struct netlink_ext_ack *extack);
 	u32			(*ingress_block_get)(struct Qdisc *sch);
 	u32			(*egress_block_get)(struct Qdisc *sch);
 
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index f56b18c8aebf..18b385d11587 100644
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
+			if (err)
+				return err;
+		}
 		err = sch->ops->change(sch, tca[TCA_OPTIONS], extack);
 		if (err)
 			return err;
diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index eafc316ae319..feed43900e0f 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -975,13 +975,32 @@ static int parse_attr(struct nlattr *tb[], int maxtype, struct nlattr *nla,
 
 static const struct Qdisc_class_ops netem_class_ops;
 
-static int check_netem_in_tree(struct Qdisc *sch, bool duplicates,
-			       struct netlink_ext_ack *extack)
+static struct Qdisc *get_qdisc_root(struct Qdisc *sch)
 {
+	struct net_device *dev;
+
+	dev = sch->dev_queue->dev;
+	if (netif_is_multiqueue(dev))
+		return rtnl_dereference(dev->qdisc);
+
+	return qdisc_root_sleeping(sch);
+}
+
+static int netem_quirk_chk(struct Qdisc *sch, struct nlattr *opt,
+			   struct netlink_ext_ack *extack)
+{
+	struct tc_netem_qopt *qopt;
 	struct Qdisc *root, *q;
+	bool root_is_mq;
+	bool duplicates;
 	unsigned int i;
 
-	root = qdisc_root_sleeping(sch);
+	qopt = nla_data(opt);
+	duplicates = qopt->duplicate;
+
+	root = get_qdisc_root(sch);
+	if (!root)
+		return 0;
 
 	if (sch != root && root->ops->cl_ops == &netem_class_ops) {
 		if (duplicates ||
@@ -992,19 +1011,27 @@ static int check_netem_in_tree(struct Qdisc *sch, bool duplicates,
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
+				struct Qdisc *parent;
+
+				parent = qdisc_lookup(qdisc_dev(q),
+						      TC_H_MAJ(q->parent));
+				if (!root_is_mq || parent != root)
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
 
@@ -1066,11 +1093,6 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
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
@@ -1352,6 +1374,7 @@ static struct Qdisc_ops netem_qdisc_ops __read_mostly = {
 	.destroy	=	netem_destroy,
 	.change		=	netem_change,
 	.dump		=	netem_dump,
+	.quirk_chk	=	netem_quirk_chk,
 	.owner		=	THIS_MODULE,
 };
 MODULE_ALIAS_NET_SCH("netem");
-- 
2.51.0


