Return-Path: <netdev+bounces-258342-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDxnNCHPjGnbtQAAu9opvQ
	(envelope-from <netdev+bounces-258342-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 19:49:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79874126EDF
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 19:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDA353018097
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 18:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F62352C5F;
	Wed, 11 Feb 2026 18:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4mIg6u9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8E433F8C2
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 18:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770835736; cv=none; b=M6bfHq0ftaEXxIyQvNezZlODBJh5+JPj5DbTN71touCVupeG1SamFpUZo2akaDMgzpR8kU4SVJrnWBuf3PyFttEeBVObT0S5NvAbrXrlTc/w0i4mePhBShGrUpdkpF1IAeQO/X0lVMgmdDV7Ltyqcc5UFPcNeFqsM5BKJSpUYTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770835736; c=relaxed/simple;
	bh=64wP/MM5aS1KZwEtPUURBoztSsWJq7sZ8lz29bEnzbg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q76LBMMVYidmytjgGjsLQqZJuLFEpuBUquaw8SE3QfD6SL/I9JnrwwSwVRFrgA+54gw2KTScUANy6QlSp/Xw/dd0c95mJdd0rp89NlSrrPPMQX1KBCn5zm1WGFiVCHvBShvqxzsc+96crMN3E3xfbG7ujpQ8ICoPMJJIklMBv/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4mIg6u9; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-45c9f47e1e8so2406106b6e.0
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 10:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770835733; x=1771440533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+j1rSO6NXTG8aA4FojBq5FRy5AxHZkP/gu9Rybi+aRI=;
        b=j4mIg6u9wJldM8MKKgBWQDo+Ira7dNhwGNOcbii668kfxJFP6jVmIb9uJbYbNqTB7N
         5wDDgg5QOrl0Mga+CmXfxnkbKmzqy97jshAGDLbvzNz2BwpwsYB8oLWfU+hV8ZquTClu
         39Lin/Z57EU7gBhQ6sPj5SV3XqynznXZv6MdN5fag27kKAIJRbHYvcrCJFSKwWs1+Z2M
         /d/5fTCplqfXCeYzXja1/aWCLbNZ6DP+4iJ/hZuBaFQVyl3ZqAKqBMhdoyqrNlA2szCZ
         zHzI5NmOoWL/RH2E4GERtDXoDy6cLY41iQrZmJMSZ8qhqDA2vZMzPRg07IJK/nsak3Bk
         mnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770835733; x=1771440533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+j1rSO6NXTG8aA4FojBq5FRy5AxHZkP/gu9Rybi+aRI=;
        b=CS3bGK3ikIjpnb5ftNVmIRkkWHBzOC9hY9nf1c+/VkT6y4X7FF/u4D+y0gJvJ+uE5i
         Mu7/a2q+U+0r1W2uuM7y4I7CiMzgV1f+6fqnUucQmHZvqmCuo025A6jByChRfKyzmj05
         0SVcONVLDiG89I9wundT3Do3gvbzPldAvh0cSSJGLnLI7PcOasc+ylB0RKZiFqpPLAJO
         iB/7FH6RpZRGOzK1pgBEl9ecTUfPz9fZWF7LB4c04ieJQ35aI2exRrIkWNwfHg1XKZJn
         aRq7lhAYjb+gC2ogJZpgbmZ5sJc7amaNU95dqGy8G5v+g1njIv1kqVJlc4uFda4pulNe
         V33Q==
X-Gm-Message-State: AOJu0YxS2RIJXN+eURLV+NGNBHdP1uwUqIM1pxVSbsi7HP0/gZnvh3Yz
	MDVwnse/WKGE1VLvkk7UEg4+MIXf8rvWyt2zneR9crK56FTbAmiL7bXI2vcKnw==
X-Gm-Gg: AZuq6aJZ0rbG+3C0mzKpkVDYbl3J5icNtfu1YFvpZ49g8uQvIGgO47xIrjRywUz0fpN
	RsC0XPbvnhYgqHDovlNACmSEYorT6AF/ekSXiNxObeHtX5IM1m8oZWMu1W+TEAu8Fj+k0LCbgZ9
	aQVblS8e1aNOgqOO0Ohp1nFEQ2H7TgZghzgHxHhcIJSc9EPzp+jOsoIOpfRAmW+8wZhXf8YWCM6
	OHQ723JHIjfZMRkDyQ+lddvq25iJJH4v2sHLAHm37B9CJqRIeEZKvESJpbLudpcx3Rynn+is2nW
	fwv1eUTRBWSk9wpbZs0naaOa9I6MhFB2SS14QVcW3xhCuUl8c/Pm/QUcbBVoIDQdgvvjwTuplKT
	ib9kYnA9g/KLAyvr9tldsgLBNIqhuEvlqZUMKM1p7eXHlyxItDvDhT8bsUnsgXb0Ac8xS0NvQTS
	LxnzjitRS1sbkGQStlRvK+K/cDmmFk13zh3N9o5E8T8zK5JZs9pMPF0Q2wmOmSmN9Iz4F64Tju
X-Received: by 2002:a05:6808:1a2a:b0:45e:f8af:e2f with SMTP id 5614622812f47-4637b6797ebmr185578b6e.15.1770835733090;
        Wed, 11 Feb 2026 10:48:53 -0800 (PST)
Received: from ubuntu-BQM5.tailafa00.ts.net (cs244-84-dhcp.cs.colorado.edu. [128.138.244.84])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4636ae92b6dsm1439719b6e.4.2026.02.11.10.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 10:48:51 -0800 (PST)
From: Ruitong Liu <cnitlrt@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Ruitong Liu <cnitlrt@gmail.com>,
	stable@vger.kernel.org,
	Shuyuan Liu <L0x1c3r@gmail.com>
Subject: [PATCH] net/sched: act_skbedit: fix divide-by-zero in tcf_skbedit_hash()
Date: Thu, 12 Feb 2026 02:48:48 +0800
Message-Id: <20260211184848.731894-1-cnitlrt@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-258342-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cnitlrt@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 79874126EDF
X-Rspamd-Action: no action

mapping_mod is computed as:

  mapping_mod = queue_mapping_max - queue_mapping + 1;

mapping_mod is stored as u16, so the calculation can overflow when
queue_mapping=0 and queue_mapping_max=0xffff. In this case the value
wraps to 0, leading to a divide-by-zero in tcf_skbedit_hash():

  queue_mapping += skb_get_hash(skb) % params->mapping_mod;

Fix it by using a wider type for mapping_mod and performing the
calculation in u32, preventing overflow to zero.

Fixes: 38a6f0865796 ("net: sched: support hash selecting tx queue")
Cc: stable@vger.kernel.org # 6.12+
Reported-by: Ruitong Liu <cnitlrt@gmail.com>
Reported-by: Shuyuan Liu <L0x1c3r@gmail.com>
Signed-off-by: Ruitong Liu <cnitlrt@gmail.com>
---
 include/net/tc_act/tc_skbedit.h |  2 +-
 net/sched/act_skbedit.c         | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/net/tc_act/tc_skbedit.h b/include/net/tc_act/tc_skbedit.h
index 31b2cd0bebb5..1353bcb15ac7 100644
--- a/include/net/tc_act/tc_skbedit.h
+++ b/include/net/tc_act/tc_skbedit.h
@@ -18,7 +18,7 @@ struct tcf_skbedit_params {
 	u32 mark;
 	u32 mask;
 	u16 queue_mapping;
-	u16 mapping_mod;
+	u32 mapping_mod;
 	u16 ptype;
 	struct rcu_head rcu;
 };
diff --git a/net/sched/act_skbedit.c b/net/sched/act_skbedit.c
index 8c1d1554f657..52f6ea6436b9 100644
--- a/net/sched/act_skbedit.c
+++ b/net/sched/act_skbedit.c
@@ -26,7 +26,7 @@ static struct tc_action_ops act_skbedit_ops;
 static u16 tcf_skbedit_hash(struct tcf_skbedit_params *params,
 			    struct sk_buff *skb)
 {
-	u16 queue_mapping = params->queue_mapping;
+	u32 queue_mapping = params->queue_mapping;
 
 	if (params->flags & SKBEDIT_F_TXQ_SKBHASH) {
 		u32 hash = skb_get_hash(skb);
@@ -34,7 +34,7 @@ static u16 tcf_skbedit_hash(struct tcf_skbedit_params *params,
 		queue_mapping += hash % params->mapping_mod;
 	}
 
-	return netdev_cap_txqueue(skb->dev, queue_mapping);
+	return netdev_cap_txqueue(skb->dev, (u16)queue_mapping);
 }
 
 TC_INDIRECT_SCOPE int tcf_skbedit_act(struct sk_buff *skb,
@@ -126,7 +126,7 @@ static int tcf_skbedit_init(struct net *net, struct nlattr *nla,
 	struct tcf_skbedit *d;
 	u32 flags = 0, *priority = NULL, *mark = NULL, *mask = NULL;
 	u16 *queue_mapping = NULL, *ptype = NULL;
-	u16 mapping_mod = 1;
+	u32 mapping_mod = 1;
 	bool exists = false;
 	int ret = 0, err;
 	u32 index;
@@ -193,7 +193,7 @@ static int tcf_skbedit_init(struct net *net, struct nlattr *nla,
 				return -EINVAL;
 			}
 
-			mapping_mod = *queue_mapping_max - *queue_mapping + 1;
+			mapping_mod = (u32)(*queue_mapping_max) - (u32)(*queue_mapping) + 1;
 			flags |= SKBEDIT_F_TXQ_SKBHASH;
 		}
 		if (*pure_flags & SKBEDIT_F_INHERITDSFIELD)
@@ -319,7 +319,7 @@ static int tcf_skbedit_dump(struct sk_buff *skb, struct tc_action *a,
 		pure_flags |= SKBEDIT_F_INHERITDSFIELD;
 	if (params->flags & SKBEDIT_F_TXQ_SKBHASH) {
 		if (nla_put_u16(skb, TCA_SKBEDIT_QUEUE_MAPPING_MAX,
-				params->queue_mapping + params->mapping_mod - 1))
+				(u16)(params->queue_mapping + params->mapping_mod - 1)))
 			goto nla_put_failure;
 
 		pure_flags |= SKBEDIT_F_TXQ_SKBHASH;
-- 
2.34.1


