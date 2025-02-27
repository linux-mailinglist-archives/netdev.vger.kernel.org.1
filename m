Return-Path: <netdev+bounces-170146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8092A477C7
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 09:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 196907A238C
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 08:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628A2224B00;
	Thu, 27 Feb 2025 08:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HFMXg7KE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F910227BB0
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 08:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740644806; cv=none; b=U/YYCh62iSR+dj4/lbsUWx/C/e2S1HFIV/PjLGCK9Nc4ABaQpXFoM26LJV7p26X5e+IIo0QcyKfk/M0SpzmU2exO5JWNCLg/wHjy7f8B6iP4bZWBjMPcv/YcMXldxq4Sn8gdzKipjw1fVR9tw5cT1VJMaTRFXbQrs1F3Z5yaV/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740644806; c=relaxed/simple;
	bh=ZZyK9ncSxNgsnbzI7SD9hbjZFCsRdpCAkGV/QkBoqro=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sjGtL+Ko+rmB0dE0ayXe8L3/5OUbPUNsC1PuNgD7S4pI7fFZLypdrOfbGlN5W0zz+CVWSyKvNesPrXe39OxOFdtKtNYKlfhyXvNNLM8NjKds3r7OVcZFwIXHD2cYyv8KQkHgLarf0CCKkP0FcJRg2G+MuQ736xW6YhzSSonYSgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HFMXg7KE; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-471fefffdf8so15522721cf.1
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 00:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740644803; x=1741249603; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CnCz9bZaDtojywmY++Db5h0SeQnR9YeJbEckiNZpwvQ=;
        b=HFMXg7KEKCeIOzS58aghBqwe27AVPa1O3yf0zlCaC+z2DxjUAG28vGQeWp3rvUjzaT
         ARRBYWqMgse1tRRIQITVk10kG3tlnUy/Z/O95Korh89PvuTzl9g+WKvMV/yuLOYK3CnR
         3J91nk0CxdWSnWNOkYmZpejgP6yaUahIvtgdM9L74VvIwdr8t26kHKOITHAZiAX2sQf0
         6kFHr3faS5wFZO0J6aQGgFaGZNMa8m+CLyoIeXgnzhASU0BQJfcCt/fdS9eXi2IcY/C8
         Nu9anRBenX9m+pePdU7EXvzS2ekzWgkjsiCpI22Rg3PFbAnHlq/ZCkE8KGREofQ88Pax
         ND5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740644803; x=1741249603;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CnCz9bZaDtojywmY++Db5h0SeQnR9YeJbEckiNZpwvQ=;
        b=R0sQtOIfeScHFhPJYkkGmTIoSw5Uj0095pA+o6SjoeoxmyA3XBi6cn8aQ4tAqnEAkv
         WwUiLpmqUuMZusZ5SqZdyx9scw8j8xMe5zkz3U6jD9EsyaTKV1BanslHpx44ksXjrL88
         wWoUak7pZKrJ8lVicwla3UA+YJUJ35RfelMTNI2rYkpUY1Q4v+fA5maDfmjKiWev2fT/
         D9mM9OCBIRN00uHHTOVYLoy3/J5Rw27p4hbubvOAJ4NesYuomMEsCl/QJ8GjXth4R+c5
         It1/GqcHRcgSfCMF+Q3cjXRf925szAZ+QhgxXXQ8fzaIL0rtnNxyfJ5TgLtPqZwZewA1
         lang==
X-Forwarded-Encrypted: i=1; AJvYcCWNg18+KcUXwgOeFvdyI6zLajUbzv+k8PTNhXODfPCDRwtPrVaME5zfJd5e+LCrexsg4EpvDkE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfgu+EbERy8TdJXOdlpXrjglcbDJD09wJUyqd8+9zK+slEb5CX
	4LnfOWphIzZRkQ5EBV6JP2x8+on62H/KmN2YviTp/2d3dOR+6fBLuNdOlXXBzMrx852hNOMg/P9
	bAaBFbHcJ9g==
X-Google-Smtp-Source: AGHT+IF7uwE9hbQFPmddpf8vHA2TWa4wQ1uCK+q66X3+8VYcjcExDqziHo1k3pkUOuCOezQWqh7m55OWofO8FA==
X-Received: from qtbcg3.prod.google.com ([2002:a05:622a:4083:b0:471:f2b1:9a61])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5910:0:b0:472:4ed:40ec with SMTP id d75a77b69052e-472228abafamr319715951cf.8.1740644803514;
 Thu, 27 Feb 2025 00:26:43 -0800 (PST)
Date: Thu, 27 Feb 2025 08:26:42 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250227082642.2461118-1-edumazet@google.com>
Subject: [PATCH net] llc: do not use skb_get() before dev_queue_xmit()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+da65c993ae113742a25f@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot is able to crash hosts [1], using llc and devices
not supporting IFF_TX_SKB_SHARING.

In this case, e1000 driver calls eth_skb_pad(), while
the skb is shared.

Simply replace skb_get() by skb_clone() in net/llc/llc_s_ac.c

Note that e1000 driver might have an issue with pktgen,
because it does not clear IFF_TX_SKB_SHARING, this is an
orthogonal change.

We need to audit other skb_get() uses in net/llc.

[1]

kernel BUG at net/core/skbuff.c:2178 !
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 16371 Comm: syz.2.2764 Not tainted 6.14.0-rc4-syzkaller-00052-gac9c34d1e45a #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
 RIP: 0010:pskb_expand_head+0x6ce/0x1240 net/core/skbuff.c:2178
Call Trace:
 <TASK>
  __skb_pad+0x18a/0x610 net/core/skbuff.c:2466
  __skb_put_padto include/linux/skbuff.h:3843 [inline]
  skb_put_padto include/linux/skbuff.h:3862 [inline]
  eth_skb_pad include/linux/etherdevice.h:656 [inline]
  e1000_xmit_frame+0x2d99/0x5800 drivers/net/ethernet/intel/e1000/e1000_main.c:3128
  __netdev_start_xmit include/linux/netdevice.h:5151 [inline]
  netdev_start_xmit include/linux/netdevice.h:5160 [inline]
  xmit_one net/core/dev.c:3806 [inline]
  dev_hard_start_xmit+0x9a/0x7b0 net/core/dev.c:3822
  sch_direct_xmit+0x1ae/0xc30 net/sched/sch_generic.c:343
  __dev_xmit_skb net/core/dev.c:4045 [inline]
  __dev_queue_xmit+0x13d4/0x43e0 net/core/dev.c:4621
  dev_queue_xmit include/linux/netdevice.h:3313 [inline]
  llc_sap_action_send_test_c+0x268/0x320 net/llc/llc_s_ac.c:144
  llc_exec_sap_trans_actions net/llc/llc_sap.c:153 [inline]
  llc_sap_next_state net/llc/llc_sap.c:182 [inline]
  llc_sap_state_process+0x239/0x510 net/llc/llc_sap.c:209
  llc_ui_sendmsg+0xd0d/0x14e0 net/llc/af_llc.c:993
  sock_sendmsg_nosec net/socket.c:718 [inline]

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+da65c993ae113742a25f@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/67c020c0.050a0220.222324.0011.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/llc/llc_s_ac.c | 49 +++++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/net/llc/llc_s_ac.c b/net/llc/llc_s_ac.c
index 06fb8e6944b06aecad73739bc9337e551cf73a90..7a0cae9a8111488979ce1c22bcc7ed86ccee5269 100644
--- a/net/llc/llc_s_ac.c
+++ b/net/llc/llc_s_ac.c
@@ -24,7 +24,7 @@
 #include <net/llc_s_ac.h>
 #include <net/llc_s_ev.h>
 #include <net/llc_sap.h>
-
+#include <net/sock.h>
 
 /**
  *	llc_sap_action_unitdata_ind - forward UI PDU to network layer
@@ -40,6 +40,26 @@ int llc_sap_action_unitdata_ind(struct llc_sap *sap, struct sk_buff *skb)
 	return 0;
 }
 
+static int llc_prepare_and_xmit(struct sk_buff *skb)
+{
+	struct llc_sap_state_ev *ev = llc_sap_ev(skb);
+	struct sk_buff *nskb;
+	int rc;
+
+	rc = llc_mac_hdr_init(skb, ev->saddr.mac, ev->daddr.mac);
+	if (rc)
+		return rc;
+
+	nskb = skb_clone(skb, GFP_ATOMIC);
+	if (!nskb)
+		return -ENOMEM;
+
+	if (skb->sk)
+		skb_set_owner_w(nskb, skb->sk);
+
+	return dev_queue_xmit(nskb);
+}
+
 /**
  *	llc_sap_action_send_ui - sends UI PDU resp to UNITDATA REQ to MAC layer
  *	@sap: SAP
@@ -52,17 +72,12 @@ int llc_sap_action_unitdata_ind(struct llc_sap *sap, struct sk_buff *skb)
 int llc_sap_action_send_ui(struct llc_sap *sap, struct sk_buff *skb)
 {
 	struct llc_sap_state_ev *ev = llc_sap_ev(skb);
-	int rc;
 
 	llc_pdu_header_init(skb, LLC_PDU_TYPE_U, ev->saddr.lsap,
 			    ev->daddr.lsap, LLC_PDU_CMD);
 	llc_pdu_init_as_ui_cmd(skb);
-	rc = llc_mac_hdr_init(skb, ev->saddr.mac, ev->daddr.mac);
-	if (likely(!rc)) {
-		skb_get(skb);
-		rc = dev_queue_xmit(skb);
-	}
-	return rc;
+
+	return llc_prepare_and_xmit(skb);
 }
 
 /**
@@ -77,17 +92,12 @@ int llc_sap_action_send_ui(struct llc_sap *sap, struct sk_buff *skb)
 int llc_sap_action_send_xid_c(struct llc_sap *sap, struct sk_buff *skb)
 {
 	struct llc_sap_state_ev *ev = llc_sap_ev(skb);
-	int rc;
 
 	llc_pdu_header_init(skb, LLC_PDU_TYPE_U_XID, ev->saddr.lsap,
 			    ev->daddr.lsap, LLC_PDU_CMD);
 	llc_pdu_init_as_xid_cmd(skb, LLC_XID_NULL_CLASS_2, 0);
-	rc = llc_mac_hdr_init(skb, ev->saddr.mac, ev->daddr.mac);
-	if (likely(!rc)) {
-		skb_get(skb);
-		rc = dev_queue_xmit(skb);
-	}
-	return rc;
+
+	return llc_prepare_and_xmit(skb);
 }
 
 /**
@@ -133,17 +143,12 @@ int llc_sap_action_send_xid_r(struct llc_sap *sap, struct sk_buff *skb)
 int llc_sap_action_send_test_c(struct llc_sap *sap, struct sk_buff *skb)
 {
 	struct llc_sap_state_ev *ev = llc_sap_ev(skb);
-	int rc;
 
 	llc_pdu_header_init(skb, LLC_PDU_TYPE_U, ev->saddr.lsap,
 			    ev->daddr.lsap, LLC_PDU_CMD);
 	llc_pdu_init_as_test_cmd(skb);
-	rc = llc_mac_hdr_init(skb, ev->saddr.mac, ev->daddr.mac);
-	if (likely(!rc)) {
-		skb_get(skb);
-		rc = dev_queue_xmit(skb);
-	}
-	return rc;
+
+	return llc_prepare_and_xmit(skb);
 }
 
 int llc_sap_action_send_test_r(struct llc_sap *sap, struct sk_buff *skb)
-- 
2.48.1.658.g4767266eb4-goog


