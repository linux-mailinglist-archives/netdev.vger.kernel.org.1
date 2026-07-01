Return-Path: <netdev+bounces-303643-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H1UOIGcVRWrH6goAu9opvQ
	(envelope-from <netdev+bounces-303643-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 15:25:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D886EE13A
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 15:25:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="Al/056my";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303643-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-303643-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E8021302B541
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 12:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7586481242;
	Wed,  1 Jul 2026 12:51:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB95441020
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 12:51:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782910277; cv=none; b=fFA10XElNo3jCjoL87pVMzICYcgef2SlWSnb7IdqlTuRoAHvKinNfPbW47WopbynG6P9g+ug0/xTgXwaUkWNB8ftWYKVqcQ/hpQFi5RuY2/5zFpRJxhjezrFw8H3jS4y0ygvY8SShvtmmW49N/YaRQ91ZCvEyjHmd+9yu11uOu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782910277; c=relaxed/simple;
	bh=PENB+CoBg7mSObGy0+iQEGvtVADHoZjqLWA1D9TdOgg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sbUnnIW6xW/v9Wo1XgQnllrwkZIxXf4ifleGO2qLmcG8d2b/GDzmPoSfeDvpT2vl08r0AIHQ6IR3A6+kHHFOLn7DU6JaWz0gpF3e7SK1asJXlQ5oTQfr3+ZO4Q8WW9uL+hH1IvWPsQ0nPpU+y4QG8U67X+BpyDNdudBXhLNawoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Al/056my; arc=none smtp.client-ip=209.85.160.202
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-51a8db414c7so8344331cf.0
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 05:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782910275; x=1783515075; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RAdHoc06kNUcL6i6T2Fy+ea+CKxasL1CrBm+tvJBzC4=;
        b=Al/056my/tppkxfGFPALnvaT7m6B4LolWAazQYDwhkt9eEvN4DAnySNTpF1eEEFdgM
         L84XXZzkMi1QiN5dZlhT1d64IAWjVqAfvZjp2oPueqfrMocP/EEsD0InvDN2vJBQ+rFs
         H2L81xzdnWRszzybt3VittsQ8y5HmhzTE2di8xa37S2ktzV4ASSRW18G4RT1mxx2f3tn
         WdDfooE8aerKuXTG7IylPhShb+ApqD7hQyjfR6/iOY0ZY4Q4Et1aaP6edXbMepsQo4D+
         tZ3DQAuJh1H5hH7RfJvvFhPVNyDmr+iSpuptirxwBSkvd6hf4LXr7M4rA/YDuvwYbTRL
         y+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782910275; x=1783515075;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RAdHoc06kNUcL6i6T2Fy+ea+CKxasL1CrBm+tvJBzC4=;
        b=XEr04atmlCgs91NZcz4cp2rYju//e1U5vnI4Ps49tVE28FaD4DRup9xjF/AO3EDj7f
         nZkHrXz5bb1kRwVD6IONZ5IYtdzD0QzyWi9TYegH12SErdmZysqVKFivNL1TmsEt7zoR
         vFJLx9yXQT8qK6tP7q8o4HOoS0p5W9LpoVj3nmODROnPu+GQ7pbhq2ka0160fKPLe945
         BR30DrpFTXiD+5tVr4HSLrUUDqw3mSZn4gqt/w9BxRMmCnyVl6I+9R+QuFWQJ7eol6ra
         qg23EKBPkUm2SNx+mLbgv+6TikAh41UvfBUd6Uk2HlkxHKwAtAiHXT3wbFRkdO4+GMFL
         Ao4g==
X-Forwarded-Encrypted: i=1; AFNElJ/9IYBfmjaqLihBxtK6m5GslLP3oFhxNqwru6N0hfDgbHzNbGmdf4XB64zxeLEOLPZ5Ve9dNXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZAmezLp3V8lAOT7SX5tQjvM8HEJ8Cxefrnd2hN46d9kg3b7NW
	RWTjY6I71n19ItnAmqI1dCRO+bZN53TcFHAVsPXUFBSdJ6Xr/+I3Ojd+vPup3Sck6LuRdVQnnJ4
	ZjTcEGS8mgpjD0A==
X-Received: from qvbgg11.prod.google.com ([2002:a05:6214:252b:b0:8b1:f2c0:cb0b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:d4:b0:519:b5ef:7fdd with SMTP id d75a77b69052e-51c26a2c1ccmr20677191cf.6.1782910275022;
 Wed, 01 Jul 2026 05:51:15 -0700 (PDT)
Date: Wed,  1 Jul 2026 12:51:12 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701125112.3652880-1-edumazet@google.com>
Subject: [PATCH net-next] tun: no longer rely on RTNL in tun_fill_info()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303643-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:andrew@lunn.ch,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,lunn.ch,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 97D886EE13A

Update tun_fill_info() to read device configuration fields (flags, owner,
group, numqueues, numdisabled) locklessly using READ_ONCE().

Annotate all writes to these fields in the control paths with WRITE_ONCE()
to prevent data races, as these fields can be modified concurrently via
ioctls (TUNSETPERSIST, TUNSETOWNER, TUNSETGROUP, TUNSETIFF) or queue
attaching/detaching.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/tun.c | 64 +++++++++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 30 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index ffbe6f13fb1fa2333227a6b085806c82a362c0a4..fc8ad6a35708825006f7d199a8f220f30e43df9e 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -532,7 +532,7 @@ static void tun_disable_queue(struct tun_struct *tun, struct tun_file *tfile)
 {
 	tfile->detached = tun;
 	list_add_tail(&tfile->next, &tun->disabled);
-	++tun->numdisabled;
+	WRITE_ONCE(tun->numdisabled, tun->numdisabled + 1);
 }
 
 static struct tun_struct *tun_enable_queue(struct tun_file *tfile)
@@ -541,7 +541,7 @@ static struct tun_struct *tun_enable_queue(struct tun_file *tfile)
 
 	tfile->detached = NULL;
 	list_del_init(&tfile->next);
-	--tun->numdisabled;
+	WRITE_ONCE(tun->numdisabled, tun->numdisabled - 1);
 	return tun;
 }
 
@@ -600,7 +600,7 @@ static void __tun_detach(struct tun_file *tfile, bool clean)
 		rcu_assign_pointer(tun->tfiles[tun->numqueues - 1],
 				   NULL);
 
-		--tun->numqueues;
+		WRITE_ONCE(tun->numqueues, tun->numqueues - 1);
 		if (clean) {
 			RCU_INIT_POINTER(tfile->tun, NULL);
 			sock_put(&tfile->sk);
@@ -663,7 +663,7 @@ static void tun_detach_all(struct net_device *dev)
 		tfile->socket.sk->sk_shutdown = RCV_SHUTDOWN;
 		tfile->socket.sk->sk_data_ready(tfile->socket.sk);
 		RCU_INIT_POINTER(tfile->tun, NULL);
-		--tun->numqueues;
+		WRITE_ONCE(tun->numqueues, tun->numqueues - 1);
 	}
 	list_for_each_entry(tfile, &tun->disabled, next) {
 		tfile->socket.sk->sk_shutdown = RCV_SHUTDOWN;
@@ -786,7 +786,7 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
 	if (publish_tun)
 		rcu_assign_pointer(tfile->tun, tun);
 	rcu_assign_pointer(tun->tfiles[tun->numqueues], tfile);
-	tun->numqueues++;
+	WRITE_ONCE(tun->numqueues, tun->numqueues + 1);
 	tun_set_real_num_queues(tun);
 out:
 	return err;
@@ -943,8 +943,8 @@ static int tun_net_init(struct net_device *dev)
 			       NETIF_F_HW_VLAN_STAG_TX);
 	dev->lltx = true;
 
-	tun->flags = (tun->flags & ~TUN_FEATURES) |
-		      (ifr->ifr_flags & TUN_FEATURES);
+	WRITE_ONCE(tun->flags, (tun->flags & ~TUN_FEATURES) |
+			       (ifr->ifr_flags & TUN_FEATURES));
 
 	INIT_LIST_HEAD(&tun->disabled);
 	err = tun_attach(tun, tun->file, false, ifr->ifr_flags & IFF_NAPI,
@@ -2370,32 +2370,36 @@ static size_t tun_get_size(const struct net_device *dev)
 
 static int tun_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
-	struct tun_struct *tun = netdev_priv(dev);
+	const struct tun_struct *tun = netdev_priv(dev);
+	unsigned int flags = READ_ONCE(tun->flags);
+	kuid_t owner = READ_ONCE(tun->owner);
+	kgid_t group = READ_ONCE(tun->group);
 
-	if (nla_put_u8(skb, IFLA_TUN_TYPE, tun->flags & TUN_TYPE_MASK))
+	if (nla_put_u8(skb, IFLA_TUN_TYPE, flags & TUN_TYPE_MASK))
 		goto nla_put_failure;
-	if (uid_valid(tun->owner) &&
+	if (uid_valid(owner) &&
 	    nla_put_u32(skb, IFLA_TUN_OWNER,
-			from_kuid_munged(current_user_ns(), tun->owner)))
+			from_kuid_munged(current_user_ns(), owner)))
 		goto nla_put_failure;
-	if (gid_valid(tun->group) &&
+	if (gid_valid(group) &&
 	    nla_put_u32(skb, IFLA_TUN_GROUP,
-			from_kgid_munged(current_user_ns(), tun->group)))
+			from_kgid_munged(current_user_ns(), group)))
 		goto nla_put_failure;
-	if (nla_put_u8(skb, IFLA_TUN_PI, !(tun->flags & IFF_NO_PI)))
+	if (nla_put_u8(skb, IFLA_TUN_PI, !(flags & IFF_NO_PI)))
 		goto nla_put_failure;
-	if (nla_put_u8(skb, IFLA_TUN_VNET_HDR, !!(tun->flags & IFF_VNET_HDR)))
+	if (nla_put_u8(skb, IFLA_TUN_VNET_HDR, !!(flags & IFF_VNET_HDR)))
 		goto nla_put_failure;
-	if (nla_put_u8(skb, IFLA_TUN_PERSIST, !!(tun->flags & IFF_PERSIST)))
+	if (nla_put_u8(skb, IFLA_TUN_PERSIST, !!(flags & IFF_PERSIST)))
 		goto nla_put_failure;
 	if (nla_put_u8(skb, IFLA_TUN_MULTI_QUEUE,
-		       !!(tun->flags & IFF_MULTI_QUEUE)))
+		       !!(flags & IFF_MULTI_QUEUE)))
 		goto nla_put_failure;
-	if (tun->flags & IFF_MULTI_QUEUE) {
-		if (nla_put_u32(skb, IFLA_TUN_NUM_QUEUES, tun->numqueues))
+	if (flags & IFF_MULTI_QUEUE) {
+		if (nla_put_u32(skb, IFLA_TUN_NUM_QUEUES,
+				READ_ONCE(tun->numqueues)))
 			goto nla_put_failure;
 		if (nla_put_u32(skb, IFLA_TUN_NUM_DISABLED_QUEUES,
-				tun->numdisabled))
+				READ_ONCE(tun->numdisabled)))
 			goto nla_put_failure;
 	}
 
@@ -2814,8 +2818,8 @@ static int tun_set_iff(struct net *net, struct file *file, struct ifreq *ifr)
 			return 0;
 		}
 
-		tun->flags = (tun->flags & ~TUN_FEATURES) |
-			      (ifr->ifr_flags & TUN_FEATURES);
+		WRITE_ONCE(tun->flags, (READ_ONCE(tun->flags) & ~TUN_FEATURES) |
+				       (ifr->ifr_flags & TUN_FEATURES));
 
 		netdev_state_change(dev);
 	} else {
@@ -3213,13 +3217,13 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		/* Disable/Enable persist mode. Keep an extra reference to the
 		 * module to prevent the module being unprobed.
 		 */
-		if (arg && !(tun->flags & IFF_PERSIST)) {
-			tun->flags |= IFF_PERSIST;
+		if (arg && !(READ_ONCE(tun->flags) & IFF_PERSIST)) {
+			WRITE_ONCE(tun->flags, READ_ONCE(tun->flags) | IFF_PERSIST);
 			__module_get(THIS_MODULE);
 			do_notify = true;
 		}
-		if (!arg && (tun->flags & IFF_PERSIST)) {
-			tun->flags &= ~IFF_PERSIST;
+		if (!arg && (READ_ONCE(tun->flags) & IFF_PERSIST)) {
+			WRITE_ONCE(tun->flags, READ_ONCE(tun->flags) & ~IFF_PERSIST);
 			module_put(THIS_MODULE);
 			do_notify = true;
 		}
@@ -3235,10 +3239,10 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 			ret = -EINVAL;
 			break;
 		}
-		tun->owner = owner;
+		WRITE_ONCE(tun->owner, owner);
 		do_notify = true;
 		netif_info(tun, drv, tun->dev, "owner set to %u\n",
-			   from_kuid(&init_user_ns, tun->owner));
+			   from_kuid(&init_user_ns, owner));
 		break;
 
 	case TUNSETGROUP:
@@ -3248,10 +3252,10 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 			ret = -EINVAL;
 			break;
 		}
-		tun->group = group;
+		WRITE_ONCE(tun->group, group);
 		do_notify = true;
 		netif_info(tun, drv, tun->dev, "group set to %u\n",
-			   from_kgid(&init_user_ns, tun->group));
+			   from_kgid(&init_user_ns, group));
 		break;
 
 	case TUNSETLINK:
-- 
2.55.0.rc0.799.gd6f94ed593-goog


