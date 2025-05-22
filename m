Return-Path: <netdev+bounces-192510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D45AC02B5
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 05:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55E224A57F7
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 03:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634A513DDBD;
	Thu, 22 May 2025 03:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fphwMoIx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3B527718;
	Thu, 22 May 2025 03:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747883494; cv=none; b=WLEG83H9YRj7hByMrztxkRjOJhychp8yB24h1vnj7sftquTHDNutTTDatabhU+SM128vzvppOT/EheonIMmBuTz6MyjeEvX/SZMWhufAyBaVj3U0i2GaHk2dlWsiLpEKqZd2zBOZukmc/fRlNy1/XD/YA7Ny6WkH40TS95g78Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747883494; c=relaxed/simple;
	bh=IPYn8fz9zcaLbQa6XS0icpIQHNwzuXngs2jCr56c5a8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z0k8UjTfNT2fXxqF5NrzVtmRtnzodL12esUPzg5UQyR7l5HSlzfKxD7D483OYCUq5z/xfhHqxPEzyrj5GeHKTzys0J6tO0OhkzA6JnjEEytC8+k0qww8+aFi6XjhXFBR3jMH5LDb1PlH2wyZ5Gjvyg6KcPQgDEqQsC2BBpjFKKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fphwMoIx; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-742c2ed0fe1so4796383b3a.1;
        Wed, 21 May 2025 20:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747883490; x=1748488290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w2h1eS/LzljS1IIkostr5pLzZhBsy848oiMCgLs6Xg0=;
        b=fphwMoIx46qjrqKzTUlfF0Wl0/K3dH47qqvnkcDx3lV7VLfwlzdTyseGDSw4lpJzbM
         Uh4cFWiTESP5T1qCUnEQec8QcH6lH/4KLCvOJlJUKLLERVx5z652yK1cRDMzHlx43pya
         I2g/qhbqdpfqUbTOYhO2EWYLt3jlP1ec0G65tK6S88R9zvEPtQxHLnVsjFcBjfjd92Fx
         KG5S+dHtDAbVkufrOTFhLbrDKvgX9Fc7BjXGxGdehpjhpNvfsvQzJtPNn7QBIRChauxG
         UZSBP7RyJRZYticRnDm/A2DC9HCYcfTq7evLzRl2ZhuCgPgQXD8ajplwreOdErjSie8p
         1dCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747883490; x=1748488290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w2h1eS/LzljS1IIkostr5pLzZhBsy848oiMCgLs6Xg0=;
        b=Qtv0J1IW4EpEiMEHmuNeorAs3OP4goGMTTwSMyXQ+hoHZ7yjysN8BbMlj3YUoYC8Ln
         9U5dKD+O0GOUG7G0BtECReXDRZCmq42VM5YTuAK5vW5nLvyQH12kyHMXVMRmy7kHpzQN
         ZF4eoaLprSwrqow6OiMSWks2J/JG7gtgOWJPO0Mdt+hpCokrbMkKvBm8rpF5cujXz0Yc
         C+ff8EHaXTSewnqWjtbMVBXeRU5CGiv/vBMi5Od2h8tHTAx2HQSfWkXHxOnbvPIkEGCL
         i29khUfYK71SwQidxXJ/dLfvpvDCwV4Uu5iPteikXKUQtsoRobs69xGP6vX7QQ3SlRXC
         sH1A==
X-Forwarded-Encrypted: i=1; AJvYcCVfIfWosW01K3QMWSqZqYruJFfu8+NWOeGMPPyw4QUgO9qd+q6Ov5SanNbjMiMDI/wBqRemWw5uX/yVBKc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx3weyRaorl8+z7+elT+lsiM0rsyKS1FaiubzS7aIsHMKstPW5
	AM/bXuv6jJvBx3Fv6k/HQIdxgoC4Vj9pzhgGpME+spMyKqmIIN9TLJhP5bZ5
X-Gm-Gg: ASbGnctCKnBpo7X9KZ2SRjEyLrageuTkvXSpFpna54cBHr2mJDruEVvgMqIbmz4CRFn
	s0qIHTmI6/SZNLyJWdfxgImelujyC6X75t0mvTLGeFy0INMyC9RrH1hgQDWxTGBXhZtlg9AK0KH
	W2xRu71aD5AbujuqDsOodWbsqeFixxBS71MUeuT8mZhmY6bV7alliHhgMqIDYxlI7skv3yDishs
	dRhCwMC01Gr0OyNuHQfQIJ6qEgwC5wvSVIed0PHNLJqb9nVWUlR83NxUu9mDtdTEz6j+3kTR2xF
	7U3hxtsXrKp7W2Gk8DA0Il4k/oe7xczCSaa1YvfheMD64TGmX+X/wyjb+J1Wnoj6R5USmgxHZzU
	ExbU/+PQHd9Va
X-Google-Smtp-Source: AGHT+IGniznh0ts9NxFH5+t9kJd249DOK+nfbCXQCEmCmvkI5lLK6lXs4GEDFzVngyLAHgRCQ3e+Rw==
X-Received: by 2002:a05:6a21:502:b0:203:ca66:e30 with SMTP id adf61e73a8af0-216219edf88mr37148896637.37.1747883490479;
        Wed, 21 May 2025 20:11:30 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-742a97395basm10351194b3a.76.2025.05.21.20.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 20:11:30 -0700 (PDT)
From: Stanislav Fomichev <stfomichev@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	horms@kernel.org,
	stfomichev@gmail.com,
	linux-kernel@vger.kernel.org,
	syzbot+b191b5ccad8d7a986286@syzkaller.appspotmail.com
Subject: [PATCH net v2] af_packet: move notifier's packet_dev_mc out of rcu critical section
Date: Wed, 21 May 2025 20:11:28 -0700
Message-ID: <20250522031129.3247266-1-stfomichev@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzkaller reports the following issue:

 BUG: sleeping function called from invalid context at kernel/locking/mutex.c:578
 __mutex_lock+0x106/0xe80 kernel/locking/mutex.c:746
 team_change_rx_flags+0x38/0x220 drivers/net/team/team_core.c:1781
 dev_change_rx_flags net/core/dev.c:9145 [inline]
 __dev_set_promiscuity+0x3f8/0x590 net/core/dev.c:9189
 netif_set_promiscuity+0x50/0xe0 net/core/dev.c:9201
 dev_set_promiscuity+0x126/0x260 net/core/dev_api.c:286 packet_dev_mc net/packet/af_packet.c:3698 [inline]
 packet_dev_mclist_delete net/packet/af_packet.c:3722 [inline]
 packet_notifier+0x292/0xa60 net/packet/af_packet.c:4247
 notifier_call_chain+0x1b3/0x3e0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2214 [inline]
 call_netdevice_notifiers net/core/dev.c:2228 [inline]
 unregister_netdevice_many_notify+0x15d8/0x2330 net/core/dev.c:11972
 rtnl_delete_link net/core/rtnetlink.c:3522 [inline]
 rtnl_dellink+0x488/0x710 net/core/rtnetlink.c:3564
 rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6955
 netlink_rcv_skb+0x219/0x490 net/netlink/af_netlink.c:2534

Calling `PACKET_ADD_MEMBERSHIP` on an ops-locked device can trigger
the `NETDEV_UNREGISTER` notifier, which may require disabling promiscuous
and/or allmulti mode. Both of these operations require acquiring
the netdev instance lock.

Move the call to `packet_dev_mc` outside of the RCU critical section.
The `mclist` modifications (add, del, flush, unregister) are protected by
the RTNL, not the RCU. The RCU only protects the `sklist` and its
associated `sks`. The delayed operation on the `mclist` entry remains
within the RTNL.

Reported-by: syzbot+b191b5ccad8d7a986286@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b191b5ccad8d7a986286
Fixes: ad7c7b2172c3 ("net: hold netdev instance lock during sysfs operations")
Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
---
v2: revise commit message (Willem & Jakub) and add INIT_LIST_HEAD (Willem)
---
 net/packet/af_packet.c | 21 ++++++++++++++++-----
 net/packet/internal.h  |  1 +
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index d4dba06297c3..20be2c47cf41 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3713,15 +3713,15 @@ static int packet_dev_mc(struct net_device *dev, struct packet_mclist *i,
 }
 
 static void packet_dev_mclist_delete(struct net_device *dev,
-				     struct packet_mclist **mlp)
+				     struct packet_mclist **mlp,
+				     struct list_head *list)
 {
 	struct packet_mclist *ml;
 
 	while ((ml = *mlp) != NULL) {
 		if (ml->ifindex == dev->ifindex) {
-			packet_dev_mc(dev, ml, -1);
+			list_add(&ml->remove_list, list);
 			*mlp = ml->next;
-			kfree(ml);
 		} else
 			mlp = &ml->next;
 	}
@@ -3769,6 +3769,7 @@ static int packet_mc_add(struct sock *sk, struct packet_mreq_max *mreq)
 	memcpy(i->addr, mreq->mr_address, i->alen);
 	memset(i->addr + i->alen, 0, sizeof(i->addr) - i->alen);
 	i->count = 1;
+	INIT_LIST_HEAD(&i->remove_list);
 	i->next = po->mclist;
 	po->mclist = i;
 	err = packet_dev_mc(dev, i, 1);
@@ -4233,9 +4234,11 @@ static int packet_getsockopt(struct socket *sock, int level, int optname,
 static int packet_notifier(struct notifier_block *this,
 			   unsigned long msg, void *ptr)
 {
-	struct sock *sk;
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 	struct net *net = dev_net(dev);
+	struct packet_mclist *ml, *tmp;
+	LIST_HEAD(mclist);
+	struct sock *sk;
 
 	rcu_read_lock();
 	sk_for_each_rcu(sk, &net->packet.sklist) {
@@ -4244,7 +4247,8 @@ static int packet_notifier(struct notifier_block *this,
 		switch (msg) {
 		case NETDEV_UNREGISTER:
 			if (po->mclist)
-				packet_dev_mclist_delete(dev, &po->mclist);
+				packet_dev_mclist_delete(dev, &po->mclist,
+							 &mclist);
 			fallthrough;
 
 		case NETDEV_DOWN:
@@ -4277,6 +4281,13 @@ static int packet_notifier(struct notifier_block *this,
 		}
 	}
 	rcu_read_unlock();
+
+	/* packet_dev_mc might grab instance locks so can't run under rcu */
+	list_for_each_entry_safe(ml, tmp, &mclist, remove_list) {
+		packet_dev_mc(dev, ml, -1);
+		kfree(ml);
+	}
+
 	return NOTIFY_DONE;
 }
 
diff --git a/net/packet/internal.h b/net/packet/internal.h
index d5d70712007a..1e743d0316fd 100644
--- a/net/packet/internal.h
+++ b/net/packet/internal.h
@@ -11,6 +11,7 @@ struct packet_mclist {
 	unsigned short		type;
 	unsigned short		alen;
 	unsigned char		addr[MAX_ADDR_LEN];
+	struct list_head	remove_list;
 };
 
 /* kbdq - kernel block descriptor queue */
-- 
2.49.0


