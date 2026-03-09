Return-Path: <netdev+bounces-265622-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNXBMxrwrmkWKQIAu9opvQ
	(envelope-from <netdev+bounces-265622-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 17:06:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE9D23C6D8
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 17:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5140A3061538
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 15:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE793E5EC7;
	Mon,  9 Mar 2026 15:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHAbe4aY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7DD3E556F
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 15:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773071962; cv=none; b=LcEKkLmuyj/89MRj125VBXdmcaMjSVnhr9cTntwlXmMM1AlSf1V9BKBqy3mh024TLkUBI1tx02U/6oJ2l7o8ETH2VieHm6g7AL49iSdQBWCYDesM9BxUMYjeeF6EoF6YpUEUAtwo7iC/XBb6WRN2PpuvWr3lXm0xOo+0ElTrlYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773071962; c=relaxed/simple;
	bh=lPqkw/giSEVhhB4XxhbF67RO08+rKdZ8faKS90IIt2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ortusbxCgXtASNf0e9LHJj7ugxLKtIhdi8Kb6kOv3tzA9MdUP09IBt7jLriRVtfYwlsZcJIhgnNXiJqIUDeYESZCgTZIDMb6qzL0mgT0FEc8lFoRjqP3doQA8nJhacUgBbR9lRwibdJ3OC+HuPqIApUYDQi3gPHzxhjlBR1amY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHAbe4aY; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2addb31945aso85491295ad.1
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 08:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773071960; x=1773676760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7PxMDgkvJf2sOnKzb29tD1hrzKH7WJBADnay5nniLmY=;
        b=dHAbe4aYkqRqqtca2dK8qPI9OXgK9jgkFP/Zox285yN9FGxWTZc/0qe5a95oM9av/Q
         Bvfckb54U9e93mxzppwVR1QlSJZ/XRrW38bzMoCXMmfYYg9sHvZ/SWNvNkXItQal4RnT
         YvyHWxwneKlL7i+twMqn2kzpQrQCEoe/2ej3EoFyfGHnHAd1EUfmwEj27pnXuMtg++CM
         VX2hfdctoH4KBE4mYuWC9pwgKYknC5uHPc0EzSuRuAiRtAyw0jrQS0znPS9jgoXHfwl6
         DT+YblALdjacoM23bvM74B7N6iL7Je7D5K/8ylnr09z9WVxrWyKIj6brAO9hBh3EfroE
         HEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773071960; x=1773676760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7PxMDgkvJf2sOnKzb29tD1hrzKH7WJBADnay5nniLmY=;
        b=fpEiL/b1RcCXlbv3nnJ5YdNYPRRRQwK0uoW5FrTkU4dzTH9GaGwGKmLWl5c/Fw61Tv
         iTjXlEbX7oSN3s/v/bfJg368MjP+yB24Js9G2eJNd2oxMZrvSGVUTzNOaX5JmZo7jvem
         LNiV33rdCIdewM3bS1gnspUZJgTegeLaxJ8qsogoJPJP2rmHiwpKaqWRdL4tDTrTga6q
         c3loD8OW1363OxuZpcR9QSx9VH7hWkWUZcvG0UCu6nsi5YHMFzrMhQyKPQKkYyC55aez
         9OwUuFn0DkDgNIrEgettkae1OLwMaT7WTzrkMJQ3FCjjig9+SubFQxiHpkr83lqaO/WQ
         6vvA==
X-Forwarded-Encrypted: i=1; AJvYcCW8LUReR2JAqmRiBLHl5AMw9bXnb0+sHqApYpPQb377atEGQ5d68Rb5o8FQLBx5joSbgMshyMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0DzHlcR+wryGHqsybX9lu2M8yMImVNOMOm8PC9BJxXWOceyPs
	Z+fmb9DDfiEpdtUGAay0uQS4xZa71YtuwnU8Cip28O6r2PAyKFHGaeDV
X-Gm-Gg: ATEYQzxU/W8Jmr2/HppmzJo85XPaDlTDpBKM7rWYxnVE4mG4Y8vt14kmAAj9Tz6UpcA
	RLEojLhcgI/Kv0az3XZT9WAhHQNYqQV1wn0DCHCj5HMrVZyTb0dkpCi9WEFc3LfgMTrlW2RPjDq
	Hg2l+QjCSquEgN/I7AflEtMMbb6NTScLGsuFf2Gca6rK6cxzxi8IbnpVAlE6Hs0xeiR9zvmrUhl
	G7gjTRsAV90hHgoZP/CaqkWvW+eXmdma70EVQB2kDP1FY4rpy0e3jb0dc9bI0+TNvhLrfD3TK5Q
	4NZGQ296UiV1UKPn+oEDKgd7zrXfg1h6rTxTOKGbS5pSIdPnwE5USoN3wl6Puv8W0d3yB4Lcyhg
	aSWgrLOMmSyBHPYQJ94/vRwhi7IJtEbwaa2XMh66Ah4aRVdybi8PY5gkHY/FW/1cOrWzrxdVYOu
	ZkrbVbNAXqnI/HFdDSexFMM4uq0iGenAGLiXpFOJTe7e4sJl1/qeINPuVn1oq1q/ywGctmS7p2o
	5pydzo=
X-Received: by 2002:a17:902:e545:b0:2ae:5c3d:b07d with SMTP id d9443c01a7336-2ae824bd5b7mr114036545ad.57.1773071959398;
        Mon, 09 Mar 2026 08:59:19 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:9c3b:4864:d890:cdd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f74e4fsm122403265ad.58.2026.03.09.08.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 08:59:18 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: mingo@kernel.org,
	tglx@kernel.org,
	jiayuan.chen@shopee.com,
	kees@kernel.org,
	netdev@vger.kernel.org,
	dan.carpenter@linaro.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+f50072212ab792c86925@syzkaller.appspotmail.com
Subject: [PATCH v2] atm: lec: fix use-after-free in sock_def_readable()
Date: Mon,  9 Mar 2026 21:29:08 +0530
Message-ID: <20260309155908.508768-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4AE9D23C6D8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,shopee.com,vger.kernel.org,linaro.org,gmail.com,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-265622-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,f50072212ab792c86925];
	NEURAL_HAM(-0.00)[-0.992];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,syzkaller.appspot.com:url]
X-Rspamd-Action: no action

A race condition exists between lec_atm_close() setting priv->lecd
to NULL and concurrent access to priv->lecd in send_to_lecd(),
lec_handle_bridge(), and lec_atm_send(). When the socket is freed
via RCU while another thread is still using it, a use-after-free
occurs in sock_def_readable() when accessing the socket's wait queue.

The root cause is that lec_atm_close() clears priv->lecd without
any synchronization, while callers dereference priv->lecd without
any protection against concurrent teardown.

Fix this by converting priv->lecd to an RCU-protected pointer:
- Mark priv->lecd as __rcu in lec.h
- Use rcu_assign_pointer() in lec_atm_close() and lecd_attach()
  for safe pointer assignment
- Use rcu_access_pointer() for NULL checks that do not dereference
  the pointer in lec_start_xmit(), lec_push(), send_to_lecd() and
  lecd_attach()
- Use rcu_read_lock/rcu_dereference/rcu_read_unlock in send_to_lecd(),
  lec_handle_bridge() and lec_atm_send() to safely access lecd
- Use rcu_assign_pointer() followed by synchronize_rcu() in
  lec_atm_close() to ensure all readers have completed before
  proceeding. This is safe since lec_atm_close() is called from
  vcc_release() which holds lock_sock(), a sleeping lock.
- Remove the manual sk_receive_queue drain from lec_atm_close()
  since vcc_destroy_socket() already drains it after lec_atm_close()
  returns.

v2: Switch from spinlock + sock_hold/put approach to RCU to properly
    fix the race. The v1 spinlock approach had two issues pointed out
    by Eric Dumazet:
    1. priv->lecd was still accessed directly after releasing the
       lock instead of using a local copy.
    2. The spinlock did not prevent packets being queued after
       lec_atm_close() drains sk_receive_queue since timer and
       workqueue paths bypass netif_stop_queue().

Note: Syzbot patch testing was attempted but the test VM terminated
    unexpectedly with "Connection to localhost closed by remote host",
    likely due to a QEMU AHCI emulation issue unrelated to this fix.
    Compile testing with "make W=1 net/atm/lec.o" passes cleanly.

Reported-by: syzbot+f50072212ab792c86925@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f50072212ab792c86925
Link: https://lore.kernel.org/all/20260309093614.502094-1-kartikey406@gmail.com/T/ [v1]
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 net/atm/lec.c | 70 +++++++++++++++++++++++++++++++++------------------
 net/atm/lec.h |  2 +-
 2 files changed, 46 insertions(+), 26 deletions(-)

diff --git a/net/atm/lec.c b/net/atm/lec.c
index fb93c6e1c329..32adf28663a0 100644
--- a/net/atm/lec.c
+++ b/net/atm/lec.c
@@ -154,10 +154,19 @@ static void lec_handle_bridge(struct sk_buff *skb, struct net_device *dev)
 					/* 0x01 is topology change */
 
 		priv = netdev_priv(dev);
-		atm_force_charge(priv->lecd, skb2->truesize);
-		sk = sk_atm(priv->lecd);
-		skb_queue_tail(&sk->sk_receive_queue, skb2);
-		sk->sk_data_ready(sk);
+		struct atm_vcc *vcc;
+
+		rcu_read_lock();
+		vcc = rcu_dereference(priv->lecd);
+		if (vcc) {
+			atm_force_charge(vcc, skb2->truesize);
+			sk = sk_atm(vcc);
+			skb_queue_tail(&sk->sk_receive_queue, skb2);
+			sk->sk_data_ready(sk);
+		} else {
+			dev_kfree_skb(skb2);
+		}
+		rcu_read_unlock();
 	}
 }
 #endif /* IS_ENABLED(CONFIG_BRIDGE) */
@@ -216,7 +225,7 @@ static netdev_tx_t lec_start_xmit(struct sk_buff *skb,
 	int is_rdesc;
 
 	pr_debug("called\n");
-	if (!priv->lecd) {
+	if (!rcu_access_pointer(priv->lecd)) {
 		pr_info("%s:No lecd attached\n", dev->name);
 		dev->stats.tx_errors++;
 		netif_stop_queue(dev);
@@ -449,10 +459,19 @@ static int lec_atm_send(struct atm_vcc *vcc, struct sk_buff *skb)
 				break;
 			skb2->len = sizeof(struct atmlec_msg);
 			skb_copy_to_linear_data(skb2, mesg, sizeof(*mesg));
-			atm_force_charge(priv->lecd, skb2->truesize);
-			sk = sk_atm(priv->lecd);
-			skb_queue_tail(&sk->sk_receive_queue, skb2);
-			sk->sk_data_ready(sk);
+			struct atm_vcc *vcc;
+
+			rcu_read_lock();
+			vcc = rcu_dereference(priv->lecd);
+			if (vcc) {
+				atm_force_charge(vcc, skb2->truesize);
+				sk = sk_atm(vcc);
+				skb_queue_tail(&sk->sk_receive_queue, skb2);
+				sk->sk_data_ready(sk);
+			} else {
+				dev_kfree_skb(skb2);
+			}
+			rcu_read_unlock();
 		}
 	}
 #endif /* IS_ENABLED(CONFIG_BRIDGE) */
@@ -468,23 +486,16 @@ static int lec_atm_send(struct atm_vcc *vcc, struct sk_buff *skb)
 
 static void lec_atm_close(struct atm_vcc *vcc)
 {
-	struct sk_buff *skb;
 	struct net_device *dev = (struct net_device *)vcc->proto_data;
 	struct lec_priv *priv = netdev_priv(dev);
 
-	priv->lecd = NULL;
+	rcu_assign_pointer(priv->lecd, NULL);
+	synchronize_rcu();
 	/* Do something needful? */
 
 	netif_stop_queue(dev);
 	lec_arp_destroy(priv);
 
-	if (skb_peek(&sk_atm(vcc)->sk_receive_queue))
-		pr_info("%s closing with messages pending\n", dev->name);
-	while ((skb = skb_dequeue(&sk_atm(vcc)->sk_receive_queue))) {
-		atm_return(vcc, skb->truesize);
-		dev_kfree_skb(skb);
-	}
-
 	pr_info("%s: Shut down!\n", dev->name);
 	module_put(THIS_MODULE);
 }
@@ -510,12 +521,14 @@ send_to_lecd(struct lec_priv *priv, atmlec_msg_type type,
 	     const unsigned char *mac_addr, const unsigned char *atm_addr,
 	     struct sk_buff *data)
 {
+	struct atm_vcc *vcc;
 	struct sock *sk;
 	struct sk_buff *skb;
 	struct atmlec_msg *mesg;
 
-	if (!priv || !priv->lecd)
+	if (!priv || !rcu_access_pointer(priv->lecd))
 		return -1;
+
 	skb = alloc_skb(sizeof(struct atmlec_msg), GFP_ATOMIC);
 	if (!skb)
 		return -1;
@@ -532,18 +545,27 @@ send_to_lecd(struct lec_priv *priv, atmlec_msg_type type,
 	if (atm_addr)
 		memcpy(&mesg->content.normal.atm_addr, atm_addr, ATM_ESA_LEN);
 
-	atm_force_charge(priv->lecd, skb->truesize);
-	sk = sk_atm(priv->lecd);
+	rcu_read_lock();
+	vcc = rcu_dereference(priv->lecd);
+	if (!vcc) {
+		rcu_read_unlock();
+		kfree_skb(skb);
+		return -1;
+	}
+
+	atm_force_charge(vcc, skb->truesize);
+	sk = sk_atm(vcc);
 	skb_queue_tail(&sk->sk_receive_queue, skb);
 	sk->sk_data_ready(sk);
 
 	if (data != NULL) {
 		pr_debug("about to send %d bytes of data\n", data->len);
-		atm_force_charge(priv->lecd, data->truesize);
+		atm_force_charge(vcc, data->truesize);
 		skb_queue_tail(&sk->sk_receive_queue, data);
 		sk->sk_data_ready(sk);
 	}
 
+	rcu_read_unlock();
 	return 0;
 }
 
@@ -618,7 +640,7 @@ static void lec_push(struct atm_vcc *vcc, struct sk_buff *skb)
 
 		atm_return(vcc, skb->truesize);
 		if (*(__be16 *) skb->data == htons(priv->lecid) ||
-		    !priv->lecd || !(dev->flags & IFF_UP)) {
+		    !rcu_access_pointer(priv->lecd) || !(dev->flags & IFF_UP)) {
 			/*
 			 * Probably looping back, or if lecd is missing,
 			 * lecd has gone down
@@ -753,12 +775,12 @@ static int lecd_attach(struct atm_vcc *vcc, int arg)
 		priv = netdev_priv(dev_lec[i]);
 	} else {
 		priv = netdev_priv(dev_lec[i]);
-		if (priv->lecd)
+		if (rcu_access_pointer(priv->lecd))
 			return -EADDRINUSE;
 	}
 	lec_arp_init(priv);
 	priv->itfnum = i;	/* LANE2 addition */
-	priv->lecd = vcc;
+	rcu_assign_pointer(priv->lecd, vcc);
 	vcc->dev = &lecatm_dev;
 	vcc_insert_socket(sk_atm(vcc));
 
diff --git a/net/atm/lec.h b/net/atm/lec.h
index be0e2667bd8c..ec85709bf818 100644
--- a/net/atm/lec.h
+++ b/net/atm/lec.h
@@ -91,7 +91,7 @@ struct lec_priv {
 						 */
 	spinlock_t lec_arp_lock;
 	struct atm_vcc *mcast_vcc;		/* Default Multicast Send VCC */
-	struct atm_vcc *lecd;
+	struct atm_vcc __rcu *lecd;
 	struct delayed_work lec_arp_work;	/* C10 */
 	unsigned int maximum_unknown_frame_count;
 						/*
-- 
2.43.0


