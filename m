Return-Path: <netdev+bounces-305147-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8nXqD+7xS2rsdQEAu9opvQ
	(envelope-from <netdev+bounces-305147-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 20:20:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D3D7146C1
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 20:20:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=Z88u61+a;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305147-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305147-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7976315A9CF
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 16:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6644314AE;
	Mon,  6 Jul 2026 16:35:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89F3430318
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 16:35:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783355721; cv=none; b=efYHlLpz+0x05NMdrnS1WYwHSep4g0ANRYsnErA1bMVv7znkid5blbIqpjY2T1hlmKQkL6QsvUdynV3SlscXbDxM1bd3nEkYjE7XBD0Khne+m5DGgXz/Q7NxRMtZWxjJaoW+ri751SJcrdjhAajLMp9Nf0ImkqdhyC48+S5av2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783355721; c=relaxed/simple;
	bh=lTT3EdAjCHgqfhji5x45jFrswWLrKP7Q/xR5KirOdQQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PWP9nKwYeUKGx/upw6Q8DWPmNitkfEA98RrqzTQ3MmRVb6vdrGs8xPXGXbL5YdA+euYJ74g0cs0/e7Wap2V3SELoFeLU857RWF/t3VuNB6a8tNs/uLUwrT3brZHrnmyliSEn/x0XvfMMPImCABjHlr8PEB925O4SKWu3JZ4OqVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z88u61+a; arc=none smtp.client-ip=209.85.219.73
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8f0c46bfb6dso57193936d6.1
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 09:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783355718; x=1783960518; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JiKVxFhdlU9cbi5aFLNmMdozLxk9HbOYj0zb8MjUoc4=;
        b=Z88u61+aCBp3TF1wunHdVwO227TcftjoJhunX/uir8jE6mWeQZNhaACRtt40a3XoL3
         NYBLHdp3SNbKQKy8xQ9h3kU8qJNZxwmxCvH8+fCnmTQFDI7v3jt4wXqCWpB4iQKikFi5
         lUSEwBHZPgU6klSahzXQz8GU3BYe9cNwaqi4w4GvwfnNTClXxUJk94wH7j+y+LPFdyvs
         iFpcllVNQlnbsKosvbWhZjsXs6cjzjI+We2d3cca1L21IDxwRDZJZw/a5DNUBh8wDqSN
         AWafOxk/mcr4crPrQsq+8CzDs5xXN5Vk9BwZVfImkObK8u/BqEqujqN+Y8dkzd2xooQa
         nmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783355719; x=1783960519;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JiKVxFhdlU9cbi5aFLNmMdozLxk9HbOYj0zb8MjUoc4=;
        b=fs3TYgU/mUZ534rMzr3ePmo7Jnfv+jaZeIyrtC5Y+EJvxc9ab/+lSMdpCcV3ttRGeu
         EZmZjRkmOAa0lz6u21AU5BQmtpep8WCPQc7aEENcUVZquHqZqiznd3oac5gMKU+lzp7c
         kLiLT9yUtp4AeCbCDwBvH+63pXNd/OlSnPZ0elBMaWUK4lZGg1uOkSPrYgy7+yalm1tO
         rWyMRFguEtiXDhlafcxSsuGXnfF3wlX8AapFmhNazBV+WyOR9Feqv84SQymtjxmoenv1
         ZL6sHSETAnO8XzDzQLN4kJHtxn9R198il++rYOk49f6kBIvzu2O8VSaUkJ/LYins/JiS
         3wAg==
X-Forwarded-Encrypted: i=1; AHgh+Rr2+bVSCIQte4YQ0YpYa9vPCjPOXQjkMc349ofJFXK9MvYAtalPacRPgncsQ8Bih/39o1ps3jA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq3PnRYFZhWS3ZEJkLlzBkfAOh99pfaB/QKRmVq+OYPYAmYO96
	TM0h79ZWqVdJV9mqYD+PtHdE0S7qUA8qdRSnBcNstZN5w/V+EMqZsVcTUkvx1aHQxcIRplOSxps
	yt2I7vt5CVhOyUQ==
X-Received: from qvnr10.prod.google.com ([2002:a0c:f80a:0:b0:8dc:18c1:5c77])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:4002:b0:8ee:fd0c:5d96 with SMTP id 6a1803df08f44-8fcb1aeda0cmr17366926d6.7.1783355718356;
 Mon, 06 Jul 2026 09:35:18 -0700 (PDT)
Date: Mon,  6 Jul 2026 16:35:17 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260706163517.2415530-1-edumazet@google.com>
Subject: [PATCH v2 net-next] tun: no longer rely on RTNL in tun_fill_info()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305147-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:willemb@google.com,m:andrew@lunn.ch,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,google.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 96D3D7146C1

Update tun_fill_info() to read device configuration fields (flags, owner,
group, numqueues, numdisabled) locklessly using READ_ONCE().

Annotate all writes to these fields in the control paths with WRITE_ONCE()
to prevent data races, as these fields can be modified concurrently via
ioctls (TUNSETPERSIST, TUNSETOWNER, TUNSETGROUP, TUNSETIFF) or queue
attaching/detaching.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
v2: addressed Kuniyuki and sashiko feedback.
v1: https://lore.kernel.org/netdev/20260701125112.3652880-1-edumazet@google.com/

 drivers/net/tun.c      | 60 ++++++++++++++++++++++--------------------
 drivers/net/tun_vnet.h |  8 +++---
 2 files changed, 36 insertions(+), 32 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index ffbe6f13fb1fa2333227a6b085806c82a362c0a4..9e2761887896955a243649b75d35a3e2a4c67529 100644
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
+		WRITE_ONCE(tun->flags, (tun->flags & ~TUN_FEATURES) |
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
diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
index fa5cab9d3e55c5a6e70afe4c76582c8affe0b73c..f4c652b1fa44d82ae23243857809619bfb5290d2 100644
--- a/drivers/net/tun_vnet.h
+++ b/drivers/net/tun_vnet.h
@@ -40,9 +40,9 @@ static inline long tun_set_vnet_be(unsigned int *flags, int __user *argp)
 		return -EFAULT;
 
 	if (be)
-		*flags |= TUN_VNET_BE;
+		WRITE_ONCE(*flags, *flags | TUN_VNET_BE);
 	else
-		*flags &= ~TUN_VNET_BE;
+		WRITE_ONCE(*flags, *flags & ~TUN_VNET_BE);
 
 	return 0;
 }
@@ -93,9 +93,9 @@ static inline long tun_vnet_ioctl(int *vnet_hdr_sz, unsigned int *flags,
 		if (get_user(s, sp))
 			return -EFAULT;
 		if (s)
-			*flags |= TUN_VNET_LE;
+			WRITE_ONCE(*flags, *flags | TUN_VNET_LE);
 		else
-			*flags &= ~TUN_VNET_LE;
+			WRITE_ONCE(*flags, *flags & ~TUN_VNET_LE);
 		return 0;
 
 	case TUNGETVNETBE:
-- 
2.55.0.795.g602f6c329a-goog


