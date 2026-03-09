Return-Path: <netdev+bounces-265435-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KG4LuuUrmnqGQIAu9opvQ
	(envelope-from <netdev+bounces-265435-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 10:37:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E780236424
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 10:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7E2A83017325
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 09:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2103337BE6D;
	Mon,  9 Mar 2026 09:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKzkLlBn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B527237B03C
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 09:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773048987; cv=none; b=HIGpLYrlgEGzzoCZwX8+D+RN3vOi8z7uNhB3gKqyJuoRjaC3VhVnHf5taWHfseAdA3ZqC6PRMPHWIhjnvuS0osQmuLggCcygsVR99allj4+z0qLM5R2Te27QaxFwDHZNMqnpY8x7xv+VNFETB9gtp9CbYe3JgHZWJtYky7tl0SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773048987; c=relaxed/simple;
	bh=ypmchPzWdWCXurOig2tSNh0Z8PppuUuNea8YyM8AKbE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tP2uE5QnODECmqYT1iUVqv/VAKTRrOSYI/DEHNUIt6bQbi5DZgM8ui47GeutIn2wOldjaENL38ENnkeE8dxcUfeon/cqRtBZF0cjTWpdYVvt+yQsobP6Fk3sJxp2KYtl2nzUmn+7wyddRqAsCXzxTOA712Q5QaSncOjPrGgNEXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKzkLlBn; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-824c9da9928so6446812b3a.3
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 02:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773048984; x=1773653784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qykwMTP7A/5/YRIqOnHVxjHodm+EkvbjSmx3/8PuSRI=;
        b=aKzkLlBnyT/ldcl/l10CQoVeFMIJ42czPRY5AB3hO83TqFanNiwS2i3vVN/Z13yMcu
         6QydQGFR4bqUJBE7Pi0U2SBNE7H1ri6ZnX4kRtLwOEfclytBdxSkInqg88N6x3al1v9j
         +4ylRDIAiSWVfpA5RhcJ+jilv63ohs0Ajty9hW1aapujAZGAixCJxEE7w+zdvxbdsp1+
         IE2uRf7zyfSenp4++D0YSih94BK+NGWdZaRMbZbisFLavjyMQg/B/3v82XTNQhobonAW
         H7i2pDA+7LZT/JiUQT7LnON5r9XpCBIsiyul+CcOHvuS+8v8JdKnxgVFKlYoEs1jXadM
         tbqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773048984; x=1773653784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qykwMTP7A/5/YRIqOnHVxjHodm+EkvbjSmx3/8PuSRI=;
        b=UrvEnePmdvYwUtxr+EdYJKuLvdxquIqtc+/EneCCD1jmf1u+EQC8PULyRKx+JeBPkm
         mXbuorBMzAsmVH1Qmug4x4NilagT3RtAkSu6gs3Ty9AZ2K3H3NaWIMrGW5tPc8lxpELY
         k1k/pv/nO1fu+8s/f2FgPoSksBGWDBzFjhmmTnXxsEg3jigGi3rM7zOnuiv4UbtDnNP0
         woCs+HvbswS+6rj0uef+1t5BWu8rqshftc7SNbQPE8F9d3HSC1XDMQAlQOgneE0Dbfmk
         Zt97wjPhu7lCIFhMEYMjGupL4xahUw/zLfsSFWFoUawGKKeT/CHUzDoYs2NoiC5KVIzE
         uYjA==
X-Forwarded-Encrypted: i=1; AJvYcCVc5PR7/2kD/Q7ZjRva5xeH3LpZSWvb4k2W3XGSLXLFvvvkeDuy5ekAWPpjpLWhxG6KLIGq1TI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa0USu8XmfBm3q1YZ7dkqIFOYyhgVwIgYf0GEdNB6my8yov55O
	XPZZi96ggD0TafR+LfbwL9gknyOF3dz9w70OlVPJ/nzLK0ekwa0uGeyz
X-Gm-Gg: ATEYQzw8zQi1c55AhVZgcF0NagQxWI4cCs98/H0LEdbnUtKZ5eMQT85dy3nXMck5pWs
	Pz55IGnIwv69XUdaOLMpTLLYWPkwQ4WU9fDHJe4CcAsbrX5Hz8TNHu0bUhDNcgFtxehGV8Of/e3
	cExueHMpXbJqeXlOu0VqBvreuYyblx6sBBS49u/2cGfjgQNroJcRj2yPb2S6ixVdV1q99vPFCnj
	Ys0qmosabYQDoavM3R7PoUQJyD0mpCzMTkm4NMnggeiOZ3NEvgTGKva8AmaKum8+qi+rVML1rhF
	GACUmpF3HQqDajx2YjNrr7Kds7eFn4uQt8ycu5IXmCvy6nmourwzpD1S4MFgdSRzLGqHcix3hZn
	IJveGnXxQU0oBPIMi0qjEduXVlgJvGsxsxNIyfuoxHXiKwNTqKrII3LeBpAdFwPEpooUI2Hz9xj
	sEVqkHlzj80guzNWR7rMfi2qVtdLvefomCeyd6hseUa8JtxWrGA3Xthlhb6cJlvTIt0debIE1nB
	Bgajvw=
X-Received: by 2002:a05:6a00:7586:b0:81e:a228:f0c9 with SMTP id d2e1a72fcca58-829a2dbab9fmr7308186b3a.19.1773048984020;
        Mon, 09 Mar 2026 02:36:24 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:cd95:c52c:1e0b:3ab7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48b437fsm9487994b3a.52.2026.03.09.02.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 02:36:23 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kees@kernel.org
Cc: mingo@kernel.org,
	tglx@kernel.org,
	jiayuan.chen@shopee.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+f50072212ab792c86925@syzkaller.appspotmail.com
Subject: [PATCH] atm: lec: fix use-after-free in sock_def_readable()
Date: Mon,  9 Mar 2026 15:06:14 +0530
Message-ID: <20260309093614.502094-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2E780236424
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,shopee.com,vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-265435-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,f50072212ab792c86925];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,appspotmail.com:email]
X-Rspamd-Action: no action

A race condition exists between lec_atm_close() setting priv->lecd = NULL
and concurrent access to priv->lecd in send_to_lecd(), lec_handle_bridge(),
and lec_atm_send(). When the socket is freed via RCU while another thread
is still using it, a use-after-free occurs in sock_def_readable() when
accessing the socket's wait queue.

The root cause is that lec_atm_close() clears priv->lecd without holding
lec_arp_lock, while callers dereference priv->lecd without any protection
against concurrent teardown.

Fix this by:
- Protecting priv->lecd = NULL in lec_atm_close() with lec_arp_lock to
  synchronize with callers that already hold the lock (e.g. lec_arp_resolve)
- Using sock_hold/sock_put in send_to_lecd() to pin the socket while in
  use. This is safe because send_to_lecd() is called under lec_arp_lock
  by lec_arp_resolve(), preventing concurrent NULL assignment of lecd.
- Using lec_arp_lock + sock_hold/sock_put in lec_handle_bridge() and
  lec_atm_send() where the lock is not held by the caller, with proper
  skb cleanup on early exit to avoid memory leaks.

Note: Patch testing via syzbot was attempted but the test VM crashed
due to a QEMU AHCI emulation assertion failure (hw/ide/core.c:934)
unrelated to this fix. The QEMU crash is caused by syzbot's disk I/O
fuzzing triggering a known QEMU NCQ emulation bug, not by this patch.
Compile testing with "make W=1 net/atm/lec.o" passes cleanly.

Reported-by: syzbot+f50072212ab792c86925@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f50072212ab792c86925
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 net/atm/lec.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/net/atm/lec.c b/net/atm/lec.c
index fb93c6e1c329..7e051174a92b 100644
--- a/net/atm/lec.c
+++ b/net/atm/lec.c
@@ -131,6 +131,7 @@ static void lec_handle_bridge(struct sk_buff *skb, struct net_device *dev)
 {
 	char *buff;
 	struct lec_priv *priv;
+	unsigned long flags;
 
 	/*
 	 * Check if this is a BPDU. If so, ask zeppelin to send
@@ -154,10 +155,19 @@ static void lec_handle_bridge(struct sk_buff *skb, struct net_device *dev)
 					/* 0x01 is topology change */
 
 		priv = netdev_priv(dev);
-		atm_force_charge(priv->lecd, skb2->truesize);
+		spin_lock_irqsave(&priv->lec_arp_lock, flags);
+		if (!priv->lecd) {
+			spin_unlock_irqrestore(&priv->lec_arp_lock, flags);
+			kfree_skb(skb2);
+			return;
+		}
 		sk = sk_atm(priv->lecd);
+		sock_hold(sk);
+		spin_unlock_irqrestore(&priv->lec_arp_lock, flags);
+		atm_force_charge(priv->lecd, skb2->truesize);
 		skb_queue_tail(&sk->sk_receive_queue, skb2);
 		sk->sk_data_ready(sk);
+		sock_put(sk);
 	}
 }
 #endif /* IS_ENABLED(CONFIG_BRIDGE) */
@@ -441,7 +451,7 @@ static int lec_atm_send(struct atm_vcc *vcc, struct sk_buff *skb)
 			/* hit from bridge table, send LE_ARP_RESPONSE */
 			struct sk_buff *skb2;
 			struct sock *sk;
-
+			unsigned long flags;
 			pr_debug("%s: entry found, responding to zeppelin\n",
 				 dev->name);
 			skb2 = alloc_skb(sizeof(struct atmlec_msg), GFP_ATOMIC);
@@ -449,10 +459,19 @@ static int lec_atm_send(struct atm_vcc *vcc, struct sk_buff *skb)
 				break;
 			skb2->len = sizeof(struct atmlec_msg);
 			skb_copy_to_linear_data(skb2, mesg, sizeof(*mesg));
-			atm_force_charge(priv->lecd, skb2->truesize);
+			spin_lock_irqsave(&priv->lec_arp_lock, flags);
+			if (!priv->lecd) {
+				spin_unlock_irqrestore(&priv->lec_arp_lock, flags);
+				kfree_skb(skb2);
+				break;
+			}
 			sk = sk_atm(priv->lecd);
+			sock_hold(sk);
+			spin_unlock_irqrestore(&priv->lec_arp_lock, flags);
+			atm_force_charge(priv->lecd, skb2->truesize);
 			skb_queue_tail(&sk->sk_receive_queue, skb2);
 			sk->sk_data_ready(sk);
+			sock_put(sk);
 		}
 	}
 #endif /* IS_ENABLED(CONFIG_BRIDGE) */
@@ -471,8 +490,11 @@ static void lec_atm_close(struct atm_vcc *vcc)
 	struct sk_buff *skb;
 	struct net_device *dev = (struct net_device *)vcc->proto_data;
 	struct lec_priv *priv = netdev_priv(dev);
+	unsigned long flags;
 
+	spin_lock_irqsave(&priv->lec_arp_lock, flags);
 	priv->lecd = NULL;
+	spin_unlock_irqrestore(&priv->lec_arp_lock, flags);
 	/* Do something needful? */
 
 	netif_stop_queue(dev);
@@ -534,6 +556,7 @@ send_to_lecd(struct lec_priv *priv, atmlec_msg_type type,
 
 	atm_force_charge(priv->lecd, skb->truesize);
 	sk = sk_atm(priv->lecd);
+	sock_hold(sk);
 	skb_queue_tail(&sk->sk_receive_queue, skb);
 	sk->sk_data_ready(sk);
 
@@ -543,7 +566,7 @@ send_to_lecd(struct lec_priv *priv, atmlec_msg_type type,
 		skb_queue_tail(&sk->sk_receive_queue, data);
 		sk->sk_data_ready(sk);
 	}
-
+	sock_put(sk);
 	return 0;
 }
 
-- 
2.43.0


