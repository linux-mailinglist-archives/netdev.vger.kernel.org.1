Return-Path: <netdev+bounces-192021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F82ABE4A8
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 22:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82CDC3AFDFD
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 20:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9701288C35;
	Tue, 20 May 2025 20:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiG/pXXj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529A6286D79;
	Tue, 20 May 2025 20:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747772450; cv=none; b=qTt1qkUSE8BCLSXBhnbXdFQJTtAI3fTnnqmn78SNXq6JeHZRnzzAl2ucsIrbF+Vi31UWFp9i5Qamzdcl9TwIT2SwEx2zmoRom3OzZIA2zsiznw835zNo5FcHlTHTdE7gBxL7ObRVDi15Bp9RQT/QHzHHdJ6C0Z5MDT1GMc51bgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747772450; c=relaxed/simple;
	bh=cZ+4U9kgatmoeCSsgij4EoatV0fM1sck7jQtvddR508=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tWCOfJFALOhaMGwnnIvIhDAV9Mz/xewiqRg8HVTPN32brcIFwJLp2/cywOE7FG2PAZbQYlNZX7CfNbilktc5ssgJy5VpRBCgOV9dNDE1rpxDaDe9NgidEKwzCX1ofamU3YBodg5ELJ9M6TS2uk7FcB7uryCb4xh9iDeqpsvmJgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZiG/pXXj; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-231e331baceso44921655ad.0;
        Tue, 20 May 2025 13:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747772448; x=1748377248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TKfpG0z72c+FzPNEz+Be4a0vT+/uMfpo+ezumBqOcCY=;
        b=ZiG/pXXj+Kl9yn3u/LF8wlQAj3PyAZXOaTrNZtSFVzHfodUbqzmxewcSHTKhGiUSTC
         8/mNAtAxrFGcuY9SKmjMtDnxzolIYwBi4Sdet0vGHBAb6Ttj+Y3aNTYY0yuQKiwE6/Ng
         lgOwviaTzC9shdaN0tD+DXTxrqGUBXi+plsEvO/3hs470UwYdxxQ5aU+FlshX48PjG1N
         osDLJSok6ny5WTrqiaVAfraOST1Pp7IkoR0o2JFopVixR0KovaQAyhBGArMR24iKev6I
         BQ8PCVLqfTDQ1Ub+4O6livK2CI/Kiiaz7946daXlBTiEicB7oJBnM8nE/k5oYgGzswnq
         rMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747772448; x=1748377248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TKfpG0z72c+FzPNEz+Be4a0vT+/uMfpo+ezumBqOcCY=;
        b=dHLtWFFQsJQ/8PgtotxFMp+vfH7Jz8zOf9fxmO2v59bvsmalTLwIcNe8mV/2xpXzgk
         TelTN7lFp8OLgfUq16ueDyAMGssqtbK0VDXeEJDl3YAkFYLgT/1Xk2Av2xhJ5qHGpcu/
         1Sb6s1ObLvJbD6gOna80AQ7uG/Nqya7YgLwfDfMNmYdb3hoX/LxT3YXaX9NFH5/n5RQb
         V1YwIgwWRUky3r0ClZ311HIOkp1GCAVS6XDM8QOjr08uR9nzM5rbtVctFbLvsSM8j+0N
         Bh245/N4avfy3surcaOS9RP3MrkTDpwXPsCooIZ+mKk1u//hMASEE6YczPNzOd+y/CAS
         ENPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVe5Rl+b+ZJbb+GcgekHe8+JVM7Ycip6XmyL+SOth/BM0Vo5W6hyDoWYhvwDRGa/UsoNUDaIwY0fcu7Jes=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNfH69j/E7qglEO7tkKCsYTajojhCrkNxDV26CWWfNqv04Wwwt
	tF661thbB8E2f5bgiUBxkzjAuumOLbr2f84FtknERdB211wX/ySkh4ZqJFkd
X-Gm-Gg: ASbGnct9mbP7WI8Z0KUZSmzrGqlqT52gifqXEK5oc6/QdVcTf6LLa6A/eWofthP5yrf
	nJMTsIEMiIl9m1GWP5KsLc1hsuUzZKaTzbrDd8eayOTsEnyCfx4ypLF8TfOwYi2PoPPhZ4dbv/I
	naCTUI8/kldGjNx1EigKM6Sh7WgrHQeYHlN4JWm9RKn6Ftro/9jopiGjpZOd0qoxlFWkUFmj0fR
	jJyP6CfQnEoyoDFRsOGtBt0Ar2wsQ4T/GW+BfIFkT9nHwcVJo2C7c1bR5i8oa8GfjcLUbYf/p2p
	UBBdguphyBuN45HFU6Tte0R0HdDlE+643cAp6bwb+F7Q+t53vneZq0zBdRoiOmXCunX8Mbh3WBl
	cxBeIwBxu+Nnu
X-Google-Smtp-Source: AGHT+IEPd4NXgZVBHc2xGeFDUKqvlOteo5oD3ZWsA74QUPNrv0GAiRl08iSNIstGUUy5HKdZqaFkMA==
X-Received: by 2002:a17:902:f691:b0:220:e63c:5b13 with SMTP id d9443c01a7336-231d45aba50mr270363665ad.46.1747772448068;
        Tue, 20 May 2025 13:20:48 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-232044a0a23sm62082755ad.112.2025.05.20.13.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 13:20:47 -0700 (PDT)
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
Subject: [PATCH net] af_packet: move notifier's packet_dev_mc out of rcu critical section
Date: Tue, 20 May 2025 13:20:46 -0700
Message-ID: <20250520202046.2620300-1-stfomichev@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calling `PACKET_ADD_MEMBERSHIP` on an ops-locked device can trigger
the `NETDEV_UNREGISTER` notifier, which may require disabling promiscuous
and/or allmulti mode. Both of these operations require acquiring the netdev
instance lock. Move the call to `packet_dev_mc` outside of the RCU critical
section.

Closes: https://syzkaller.appspot.com/bug?extid=b191b5ccad8d7a986286
Reported-by: syzbot+b191b5ccad8d7a986286@syzkaller.appspotmail.com
Fixes: ad7c7b2172c3 ("net: hold netdev instance lock during sysfs operations")
Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
---
 net/packet/af_packet.c | 20 +++++++++++++++-----
 net/packet/internal.h  |  1 +
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index d4dba06297c3..5a6132816b2e 100644
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
@@ -4233,9 +4233,11 @@ static int packet_getsockopt(struct socket *sock, int level, int optname,
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
@@ -4244,7 +4246,8 @@ static int packet_notifier(struct notifier_block *this,
 		switch (msg) {
 		case NETDEV_UNREGISTER:
 			if (po->mclist)
-				packet_dev_mclist_delete(dev, &po->mclist);
+				packet_dev_mclist_delete(dev, &po->mclist,
+							 &mclist);
 			fallthrough;
 
 		case NETDEV_DOWN:
@@ -4277,6 +4280,13 @@ static int packet_notifier(struct notifier_block *this,
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


