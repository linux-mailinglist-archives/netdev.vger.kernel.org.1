Return-Path: <netdev+bounces-204700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C44AFBD37
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 23:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDE08166FA1
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 21:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1C523D282;
	Mon,  7 Jul 2025 21:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="OxpJpK37"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4B121D3FB
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 21:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751922496; cv=none; b=tieEx5V8JPPm3rw2s63NLH6L/zTLSXe+V9I8bZMAHq5aIIq43ga6N8dxscHghajqRfjE8tkzw7MSk3X6TjMhLg2L+cNNLrjf8cCHzATwsNClzmUV9HS7+J1ViV6vCW9MNB8UA2FU7TnDKhMbYuBMYWzph7QgAV7iiv8WhlB+fXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751922496; c=relaxed/simple;
	bh=6xrkdtB+FXjKoaxAnl6nNrfKBkCNQfXPJJbZigmyVrA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NZ+oHaIxRgsQ4AL7o0p9ani68sW+bwXi+uwF/1QLUrIUGimkje/aljcvxh0KbJGmJx20n1uG+gRqxhWWPzwCpw/n6rdv72LF3iiYGySn6HHSDVrduAUDXCnZ7QvPOp3SgiKZK/k9fo30XJFrDc+37GkLcjFiubVvuGXCqmKEfZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=OxpJpK37; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4a43afb04a7so26247501cf.0
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 14:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1751922493; x=1752527293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rzeov6sECCVZXzDOULDDRWXGvWvm8tYV84pd2voljaw=;
        b=OxpJpK37HnucAr86BGrQIGu4/7kpL+z5Km8zqkHZI0ioX8d5KBM0nASDsqWFCAn2S1
         IpBGDduyY1mSzwAcSMQVtiVNSJM4G2ax8k7AlhdkiMnfWdpr3y+ikd69uPBgndEOOLJR
         oeDoSIH+KMpD8vyhK5nDdMmRVqRTG3qhwlARSMbMUUpFR3F9979CvA3nHTvCdalHvwdR
         bOaZPvtmJfpLs2SjvRoDIQE12XEXGoI71fIcaKgIR0DA6J7CJkFItVLq8hqPYIiPPaw4
         NWqkkYuBmb/Bpww1UpX1MMP4RG9TVqTgAhjeTrEQaGyU6bd4Hl2SVHZTdkYbVU+8IMYc
         vdLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751922493; x=1752527293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rzeov6sECCVZXzDOULDDRWXGvWvm8tYV84pd2voljaw=;
        b=BjGtQpRRh3RZCHNBPp2/nj5ic0SyqM/m0QtFj0ESdZKfxXkEIbPDDFGVkN9SVRGDrK
         mf3fXDJWGCi6J6zuxYD6zvyEPMJyRcP9mWzsLBWkH5zgY0SBX3dl3ZmFzeIy/jb8efYB
         r/mBjj+C7ccGZuy30THxFQiieQrXXWAY1rrWIsCFq9SRRhhnCYXCMVXpRE7Eik3YDaVD
         dgzMAm8fL8LBNNK0cAd2/4i4i0kyv8sKl5oeYnrNA+Vk12ItMc3fmt3zu/UICzqiyPpq
         KsZf7qHnNpTTYmZFvmbfHmmEbvPfTfAIGC+qzzo+SHJhnErTJ7IHXsqMbsGl0QCdB3MR
         IsUw==
X-Gm-Message-State: AOJu0Yw38uDITJIWkUuT3BQZS/5IXALTL3gikeI68h8J3jXlh25esvOF
	1J2TEhvJn9Gs1y9NHeYdYxkcheLdU8y2HZ0s2RsEzyfecpHv9IMNODSXXde7suph8w==
X-Gm-Gg: ASbGncsn3prQpFF5lnWjN3mHCQhN+Af8lKpZWGyb8C2sqBrqtOGYMIH1IQMoVefKN1X
	QNUYy5t8YvpOHiK3C8lvh/TeE7OZGwKgwDSngiSAF7lk49wESfWDm5cIRCCLlWTHAo13kYRVbEr
	j9QBv0G6LCedaf80mskhNuBLL9mR96RmsLKLwzu3XjbiNmxDfGDLDr/KsKdqbhaQWiGFK2CK+sk
	ow8Yy1oYdsrevjxGTgD7Hc3fYaJZy6KzaODR/uo/UGxe0q99t9nS7idJ1k7WNsHf3qdDE6DeobB
	+NDfbOFPirHccSUtqodD9S+t8hKU/1Ng0CDI8tfNyumhv4Q7QfiAcmdAmUW38NSsVAItIE+DW4+
	4adluAiX2
X-Google-Smtp-Source: AGHT+IE6EIS5Jeq4macBX+CiXgphFNGfZP08mmSFm+IJ1s5QhtPMNvbRh1nGONkEJQPSM4Gn+2LPZA==
X-Received: by 2002:a05:622a:59cf:b0:4a4:4202:e77e with SMTP id d75a77b69052e-4a9985ff983mr214048711cf.6.1751922493281;
        Mon, 07 Jul 2025 14:08:13 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:7f1:e2c1:ff57:26e6:7741:19c:69c5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a994a8dfd5sm69567451cf.66.2025.07.07.14.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 14:08:12 -0700 (PDT)
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
Subject: [PATCH net v2] net/sched: Abort __tc_modify_qdisc if parent class does not exist
Date: Mon,  7 Jul 2025 18:08:01 -0300
Message-ID: <20250707210801.372995-1-victor@mojatatu.com>
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
Reviewed-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
v1 -> v2: 
- Simplified qdisc_leaf error handling logic in __tc_get_qdisc (Jakub)
- Added Cong's reviewed-by
---
 net/sched/sch_api.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index d8a33486c511..241e86cec9c5 100644
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
 
@@ -1490,7 +1495,7 @@ static int __tc_get_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 					NL_SET_ERR_MSG(extack, "Failed to find qdisc with specified classid");
 					return -ENOENT;
 				}
-				q = qdisc_leaf(p, clid);
+				q = qdisc_leaf(p, clid, extack);
 			} else if (dev_ingress_queue(dev)) {
 				q = rtnl_dereference(dev_ingress_queue(dev)->qdisc_sleeping);
 			}
@@ -1501,6 +1506,8 @@ static int __tc_get_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 			NL_SET_ERR_MSG(extack, "Cannot find specified qdisc on specified device");
 			return -ENOENT;
 		}
+		if (IS_ERR(q))
+			return PTR_ERR(q);
 
 		if (tcm->tcm_handle && q->handle != tcm->tcm_handle) {
 			NL_SET_ERR_MSG(extack, "Invalid handle");
@@ -1602,7 +1609,9 @@ static int __tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
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


