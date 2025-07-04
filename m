Return-Path: <netdev+bounces-204208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64290AF9863
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 18:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 044DC3AE7F9
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 16:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0061487F4;
	Fri,  4 Jul 2025 16:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="x3vO6xNB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2AC2F8C24
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 16:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751646873; cv=none; b=Ri8n8HrPDR2HJ3tbA+79G0GNJ0Sp93l7xsbt7wKso/cLasZ3SUl+8M/AWadCx0Ntqazu76ZsDtcWZeNV0vvW7okasbKmIfZaSlaAUlYpLlVfAd/LYkKBnvCX7IVDG60PL+JLn7Befc5GB7HjZTgQoxsPbPrO6E/oofTk0nTe9Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751646873; c=relaxed/simple;
	bh=cuPdVkBoY6p7zv1SxFjxW9Vddg6Jkal0yBAWlj7p7LQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RoE9aKvlmQ9090Jf7uEd5RInq6QgeiZepOc0Qx9naHJWpvWEHPh08BpkddVev0GInB0YLGFkVkNdoGEVK1g5Z/28FyXGstua+2VKSTI6yCbQzWE4Qm/v41K16Mo86vgcCRXJWiocqCGh+j8t3PAAIgGyAI0zxhbsBdA3L+P2sdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=x3vO6xNB; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6fb0eb0f0fbso13841046d6.1
        for <netdev@vger.kernel.org>; Fri, 04 Jul 2025 09:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1751646870; x=1752251670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vfniQYlY/BAKjTZ9NM3mUMPCJmrSKx06uaj6d17X2ec=;
        b=x3vO6xNBwo+I33jwtbPw+720OihyxPbXXZK7faTkg8CDAvT7PYsBMiGRxOAXGg9g7m
         cs5OGjX3RoccBRqpHqPA0x+PlBG96MM6NPPdoI454Wyxjha4QqGtZcxA1iKQa5JrWdXU
         aLIp0kWxwNGtpsvg3onQK9/QOI5ogWWy+Xx6zdC68eKJgt5sm2zOMoDgNLBkHUXJU/5i
         quDyS7BX8GR0j22eiEVMKC/W0xrzJUKFP0dN8bs9mbo7iok4PJfobkZNrsqQfpmjuaD6
         EFNNnhh7DgxrUU7vmV+Lvlqdo/+2Vck1TLRFCKdZJmPqnp7vUwrrKih16wtRWHF+/S+Z
         BbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751646870; x=1752251670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vfniQYlY/BAKjTZ9NM3mUMPCJmrSKx06uaj6d17X2ec=;
        b=DaTp5ZBnuDfAvQ3EyL72wMoJuXnOdhbdmV6bNutd77PbZQLo6vOYteRn+0KjLXsoQA
         FNCDifwB0ywqMDJNxu1pTN4x/pgWHXOR944ORufOZ7S0c7vqv0tsTztgBQXK19f8Ana5
         UA6cJSPMXyeYUrtPlBCbGhavOAYStszQ8XgweMQMT93jE89wMSTdd8WMIIHefJM3BaiK
         +1C0OuXeIAtQ+PzK6ntWQg/y3IHqFx3h9w6HVywxXkxuZWvK09ZbX/kND8T7aVSTGFSU
         XEfbpLCT6mVgBFhoU8BrxjQMMRDrJOhre1U3dAGzlgtlZPNj4zP1gbbvtenvIH0ELKEw
         61VA==
X-Gm-Message-State: AOJu0YyFY7/9jOir+rcMzy8rgPcaSLDifa0ZNmnXtLb8B/Q9okFumLwM
	Jwyd55RlK9BypYq7gLqv83l0ECRdI6kLa2zRFcNbf5PtLp/KtkM3BltSWRqlcelzVw==
X-Gm-Gg: ASbGncv74kzLTzP0TIC4Gopxug1WW4Ktc+uLkO3eC/Fk4JNQ7vTPGCRS6qARpudomV3
	r6SMHFJD1SKaNk8xVgX/RTvcX0KQIb/O5V42mQaocHG8TypTiABYlrN24PDDln4rwcOPwrlK0hQ
	LnK1bFcaB2IY0JqTbMAp5ig2cyiHTMBBNCZ4wSsvbMnS13S7TCx2tcCFWE6FvRcwt2eQmc0WGQZ
	0ZQZJQIEYl3pYIcIgv28lYP3QCnMiQKV2VSAiY0uL2LxwuIhEAVj6HK8cp6Y5AiL4gbFNl9toaF
	pWW5xcgfPSVJdHSrRtO0Y77r1q6prIKcpfvlIq7Ro5jVXsAvLRERuUJJLHeY9mFQt+PCmpLlFsV
	/KcWk1acCCJ4D6o4s+WY=
X-Google-Smtp-Source: AGHT+IGKSB4TthDaOW6p6j7hl4zxNJzUYf5tRuF659U6eVSf2vOeK34PifVmHrM8C1ckzeybp6UywA==
X-Received: by 2002:a05:6214:6108:b0:700:c45d:f88c with SMTP id 6a1803df08f44-702c4e20e78mr46248796d6.6.1751646870005;
        Fri, 04 Jul 2025 09:34:30 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:7f1:e2c1:ca4a:289:b941:38b9:cf01])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4d5ac60sm14841396d6.97.2025.07.04.09.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 09:34:29 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	pctammela@mojatatu.com,
	syzbot+d8b58d7b0ad89a678a16@syzkaller.appspotmail.com,
	syzbot+5eccb463fa89309d8bdc@syzkaller.appspotmail.com,
	syzbot+1261670bbdefc5485a06@syzkaller.appspotmail.com,
	syzbot+4dadc5aecf80324d5a51@syzkaller.appspotmail.com,
	syzbot+15b96fc3aac35468fe77@syzkaller.appspotmail.com
Subject: [PATCH net] net/sched: Abort __tc_modify_qdisc if parent class does not exist
Date: Fri,  4 Jul 2025 13:34:22 -0300
Message-ID: <20250704163422.160424-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lion's patch [1] revealed an ancient bug in the qdisc API.
Whenever a user creates/modifies a qdisc specifying as a parent another
qdisc, the qdisc API will, during grafting, detect that the user is
not trying to attach to a class and reject. However grafting is
performed after qdisc_create (and thus the qdiscs' init callback) is
executed. In qdiscs that eventually call qdisc_tree_reduce_backlog
during init or change (such as fq, hhf, choke, etc), an issue
arises. For example, executing the following commands:

sudo tc qdisc add dev lo root handle a: htb default 2
sudo tc qdisc add dev lo parent a: handle beef fq

Qdiscs such as fq, hhf, choke, etc unconditionally invoke
qdisc_tree_reduce_backlog() in their control path init() or change() which
then causes a failure to find the child class; however, that does not stop
the unconditional invocation of the assumed child qdisc's qlen_notify with
a null class. All these qdiscs make the assumption that class is non-null.

The solution is ensure that qdisc_leaf() which looks up the parent
class, and is invoked prior to qdisc_create(), should return failure on
not finding the class.
In this patch, we leverage qdisc_leaf to return ERR_PTRs whenever the
parentid doesn't correspond to a class, so that we can detect it
earlier on and abort before qdisc_create is called.

[1] https://lore.kernel.org/netdev/d912cbd7-193b-4269-9857-525bee8bbb6a@gmail.com/

Fixes: 5e50da01d0ce ("[NET_SCHED]: Fix endless loops (part 2): "simple" qdiscs")
Reported-by: syzbot+d8b58d7b0ad89a678a16@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/68663c93.a70a0220.5d25f.0857.GAE@google.com/
Reported-by: syzbot+5eccb463fa89309d8bdc@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/68663c94.a70a0220.5d25f.0858.GAE@google.com/
Reported-by: syzbot+1261670bbdefc5485a06@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/686764a5.a00a0220.c7b3.0013.GAE@google.com/
Reported-by: syzbot+15b96fc3aac35468fe77@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/686764a5.a00a0220.c7b3.0014.GAE@google.com/
Reported-by: syzbot+4dadc5aecf80324d5a51@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/68679e81.a70a0220.29cf51.0016.GAE@google.com/
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 net/sched/sch_api.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index d8a33486c511..659ab1c38518 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -336,17 +336,22 @@ struct Qdisc *qdisc_lookup_rcu(struct net_device *dev, u32 handle)
 	return q;
 }
 
-static struct Qdisc *qdisc_leaf(struct Qdisc *p, u32 classid)
+static struct Qdisc *qdisc_leaf(struct Qdisc *p, u32 classid,
+				struct netlink_ext_ack *extack)
 {
 	unsigned long cl;
 	const struct Qdisc_class_ops *cops = p->ops->cl_ops;
 
-	if (cops == NULL)
-		return NULL;
+	if (cops == NULL) {
+		NL_SET_ERR_MSG(extack, "Parent qdisc is not classful");
+		return ERR_PTR(-EOPNOTSUPP);
+	}
 	cl = cops->find(p, classid);
 
-	if (cl == 0)
-		return NULL;
+	if (cl == 0) {
+		NL_SET_ERR_MSG(extack, "Specified class not found");
+		return ERR_PTR(-ENOENT);
+	}
 	return cops->leaf(p, cl);
 }
 
@@ -1490,16 +1495,20 @@ static int __tc_get_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 					NL_SET_ERR_MSG(extack, "Failed to find qdisc with specified classid");
 					return -ENOENT;
 				}
-				q = qdisc_leaf(p, clid);
+				q = qdisc_leaf(p, clid, extack);
 			} else if (dev_ingress_queue(dev)) {
 				q = rtnl_dereference(dev_ingress_queue(dev)->qdisc_sleeping);
 			}
 		} else {
 			q = rtnl_dereference(dev->qdisc);
 		}
-		if (!q) {
-			NL_SET_ERR_MSG(extack, "Cannot find specified qdisc on specified device");
-			return -ENOENT;
+		if (IS_ERR_OR_NULL(q)) {
+			if (!q) {
+				NL_SET_ERR_MSG(extack,
+					       "Cannot find specified qdisc on specified device");
+				return -ENOENT;
+			}
+			return PTR_ERR(q);
 		}
 
 		if (tcm->tcm_handle && q->handle != tcm->tcm_handle) {
@@ -1602,7 +1611,9 @@ static int __tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 					NL_SET_ERR_MSG(extack, "Failed to find specified qdisc");
 					return -ENOENT;
 				}
-				q = qdisc_leaf(p, clid);
+				q = qdisc_leaf(p, clid, extack);
+				if (IS_ERR(q))
+					return PTR_ERR(q);
 			} else if (dev_ingress_queue_create(dev)) {
 				q = rtnl_dereference(dev_ingress_queue(dev)->qdisc_sleeping);
 			}
-- 
2.34.1


