Return-Path: <netdev+bounces-210997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA32B1613F
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 15:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 614711890DEF
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 13:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B15170A2B;
	Wed, 30 Jul 2025 13:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OsMyF18B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B708A172BB9
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 13:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753881463; cv=none; b=D3uIIaybrpQiRZj6kcMzxdnBzPsLbAJfPIU0r8XGY+j6xhH8xmC2Vb/XWqJ6Z74rjmEBGHhn6FV7yxOX0uFW2YoeX3VNIoE4Zbsij6tbPKRVMqpScdPlJ1UD6u2RvU476VJ4CXvErHhE80EoJKOo9kUCww+FFt7Y+Z45uyYnQzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753881463; c=relaxed/simple;
	bh=wQV51C2Ib2mpJndbb6jmRVEky7r53Y8+vIDYD2N93es=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dT/Zwts6Q+n3olKumPtHSjhGi6JgeaL8WDToKDhEcaw8cltEq4OvEYG5D2F0PsSMcN3nLWstenlDdcL9Q4IBlC/xPBqx9I0AWcfPH4uU68oPJzhl8bH3x0o5/cIVKyIWRdBwVUbXbo/Vgfmbg0Xa6Z7dwcmwt5yBYQgErJD8gIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OsMyF18B; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-707453b0307so60365366d6.3
        for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 06:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753881460; x=1754486260; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2ZJgGJWQFeclQw2uoRHesjGOwX1lqWpTyzoKd2zAekY=;
        b=OsMyF18BO0vf3nOVASswfO5OkxPa4u9K8F1sPsgWBs8mR6twi+VDrfHbVRPkWPmTFX
         +PIf/Q71C42uCT+rpyxzMUSPJGBCkd0Q3B5wyl0OjHLyU5933Q3Ht6mmSzmdWxCtxIyb
         PdNt7dHzW3+iJWmbuOoOtdUW77ibVTdTTQLQeiQQMVs8fWgvPOdAaTsS1ag3f1EZFAdh
         r6DOc8dX0RVS2it+3/xo8KsR1Xvpfd7lBQt2JhEuN7nHrMrL6NXUaHNCO5SnMfDCQFP9
         RyLz/Jz1k4x6ndeYWxqqGjxsi/4ZupjF7v/zUZt8mN9AGJUqb6g59KPuLqMzckZUmQ3n
         Skng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753881460; x=1754486260;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2ZJgGJWQFeclQw2uoRHesjGOwX1lqWpTyzoKd2zAekY=;
        b=PZGTZAEjmZn0rDw9ZlqxnUJ8Ei6+P+/BfZZdRHR6+xw5NEHKNdQDXWr5MeTZViYT4V
         22CN4PdYMK8zJyz/ICAI1IBvEdlA58pH+NOCuvlW83tvoziFkGv0BNPSOu4UMDzgEvrE
         fKMnHjhQESHxGvc/ut3IiU2d7NWrbizTmvIOzyBLBR8AOpzMmivoskkVdpHNR79LeMBG
         MIlLHYfYcJr9ugG5sf/QF7xdsg7KBMp3EclYMCvbKTL10KDtYDRIqGnLOHJHZfMbz//b
         q4M+cCxGsQEIqspE/ZRFxu3MEWzrpZ1BBx5ky/Qn5eXz/xm/24xLRaJuTD0QJ5wPLqjL
         B11A==
X-Forwarded-Encrypted: i=1; AJvYcCUZJtD9qDTO7FbYZt+YFQ0JEZXAE5LT0HgH4TeWR1V2oOZJeU1GvNXMrXRsLrQ1Y21hSHEO830=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSI7IoMOyqA9BUGxNIelb1KKP2mQF2DWOPxnIBGhs6Z7h9hbJo
	kgoccitCz9e1vmLPDIPr89BvK5X0tPwYgk/UsebVnqDDOjA46cTpQQcElvaYA6IhqPvBYzqlYeN
	OYgLcRS/4oXPTaA==
X-Google-Smtp-Source: AGHT+IGOCBp8/tEEgbLplTinmZ3fumFDewMGJumvdHnr+/W4EklHcimHcrSwWX2SqQhV6dfvZwiF9VDrEgtfZg==
X-Received: from qvblb13.prod.google.com ([2002:a05:6214:318d:b0:707:3161:5d79])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:401a:b0:707:5671:c95e with SMTP id 6a1803df08f44-70767113d4emr46967526d6.27.1753881460258;
 Wed, 30 Jul 2025 06:17:40 -0700 (PDT)
Date: Wed, 30 Jul 2025 13:17:38 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250730131738.3385939-1-edumazet@google.com>
Subject: [PATCH net] ipv6: reject malicious packets in ipv6_gso_segment()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+af43e647fd835acc02df@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot was able to craft a packet with very long IPv6 extension headers
leading to an overflow of skb->transport_header.

This 16bit field has a limited range.

Add skb_reset_transport_header_careful() helper and use it
from ipv6_gso_segment()

WARNING: CPU: 0 PID: 5871 at ./include/linux/skbuff.h:3032 skb_reset_transport_header include/linux/skbuff.h:3032 [inline]
WARNING: CPU: 0 PID: 5871 at ./include/linux/skbuff.h:3032 ipv6_gso_segment+0x15e2/0x21e0 net/ipv6/ip6_offload.c:151
Modules linked in:
CPU: 0 UID: 0 PID: 5871 Comm: syz-executor211 Not tainted 6.16.0-rc6-syzkaller-g7abc678e3084 #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
 RIP: 0010:skb_reset_transport_header include/linux/skbuff.h:3032 [inline]
 RIP: 0010:ipv6_gso_segment+0x15e2/0x21e0 net/ipv6/ip6_offload.c:151
Call Trace:
 <TASK>
  skb_mac_gso_segment+0x31c/0x640 net/core/gso.c:53
  nsh_gso_segment+0x54a/0xe10 net/nsh/nsh.c:110
  skb_mac_gso_segment+0x31c/0x640 net/core/gso.c:53
  __skb_gso_segment+0x342/0x510 net/core/gso.c:124
  skb_gso_segment include/net/gso.h:83 [inline]
  validate_xmit_skb+0x857/0x11b0 net/core/dev.c:3950
  validate_xmit_skb_list+0x84/0x120 net/core/dev.c:4000
  sch_direct_xmit+0xd3/0x4b0 net/sched/sch_generic.c:329
  __dev_xmit_skb net/core/dev.c:4102 [inline]
  __dev_queue_xmit+0x17b6/0x3a70 net/core/dev.c:4679

Fixes: d1da932ed4ec ("ipv6: Separate ipv6 offload support")
Reported-by: syzbot+af43e647fd835acc02df@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/688a1a05.050a0220.5d226.0008.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/skbuff.h | 23 +++++++++++++++++++++++
 net/ipv6/ip6_offload.c |  4 +++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index b8b06e71b73ea3fb5210239f585f4ba714395fd7..14b923ddb6dfcc3c031a7c9e4cb5fc4171424616 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3033,6 +3033,29 @@ static inline void skb_reset_transport_header(struct sk_buff *skb)
 	skb->transport_header = offset;
 }
 
+/**
+ * skb_reset_transport_header_careful - conditionally reset transport header
+ * @skb: buffer to alter
+ *
+ * Hardened version of skb_reset_transport_header().
+ *
+ * Returns: true if the operation was a success.
+ */
+static inline bool __must_check
+skb_reset_transport_header_careful(struct sk_buff *skb)
+{
+	long offset = skb->data - skb->head;
+
+	if (unlikely(offset != (typeof(skb->transport_header))offset))
+		return false;
+
+	if (unlikely(offset == (typeof(skb->transport_header))~0U))
+		return false;
+
+	skb->transport_header = offset;
+	return true;
+}
+
 static inline void skb_set_transport_header(struct sk_buff *skb,
 					    const int offset)
 {
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index 9822163428b028d6dbf3f48abe4674bd6c581725..fce91183797a60fcbf271c73e086aeb0aa9d40c6 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -148,7 +148,9 @@ static struct sk_buff *ipv6_gso_segment(struct sk_buff *skb,
 
 	ops = rcu_dereference(inet6_offloads[proto]);
 	if (likely(ops && ops->callbacks.gso_segment)) {
-		skb_reset_transport_header(skb);
+		if (!skb_reset_transport_header_careful(skb))
+			goto out;
+
 		segs = ops->callbacks.gso_segment(skb, features);
 		if (!segs)
 			skb->network_header = skb_mac_header(skb) + nhoff - skb->head;
-- 
2.50.1.552.g942d659e1b-goog


