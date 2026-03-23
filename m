Return-Path: <netdev+bounces-270381-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPsDAKDjwGkbOQQAu9opvQ
	(envelope-from <netdev+bounces-270381-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 07:54:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE352ED305
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 07:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F39B43009FBA
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 06:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18FB3431E3;
	Mon, 23 Mar 2026 06:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jst/vtTd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679C01DE8BB
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 06:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774248860; cv=none; b=OsPHGJS5LQOSSzvLrsZTvJZ4az8WaPdVfj/EkSzzhZXLEK+57lYReYXQx4ppjfN4fZUjHK+iG8aB28Ol8t2sSTwnAwXHQv+b+T2DIf0AG72TpRnYZvlVLDWFSQR3ysyPd2+PUQSi6c890zz2l2QZdZ26rQxmxVRlz4wlPvGLnw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774248860; c=relaxed/simple;
	bh=jUkjNPYqJLTavOP8HwPcJvQWxObAVEQ91c874l+CLQw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DFzFeBQBrQI+ID0qowZCM2Q43YPIDFfHs05fl6T5ZSIzcO+TIJK09t5U1N1Xwlsz9UzYwQ/e6sH8KkqBuSQj5URC1V6F68pgURSNj4eMOxmQFiB8qEYrdK/fJxoH2mzCjUhMnWXxlLJsHSZwqPdPgM7abZkPdBm1tO84Xnad5Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jst/vtTd; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82a8afb2d0aso2204778b3a.1
        for <netdev@vger.kernel.org>; Sun, 22 Mar 2026 23:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774248859; x=1774853659; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mao9DUlBnmujuW3A+CUh4bfJbpHQEdFcui9ik7MVEWE=;
        b=jst/vtTdY5L29Vby97r24om9OUsDFMVK9IY2wiNif9r9dkWsvqKwoF/ppT0BCP4HVR
         n8C27mP4NA1g7MMEWInX+6u/fo2DVaHusahMw0djB8G7DMH4uKx/WImQL3p4UJRAanmz
         ILYaw44WN+w0mlZp6F9NQMZM1kai1SRXE/tgam9k9/GYcpXCJJ7NaNMxwVWGC8kHzakH
         +ZQJKKopITRoCr1frqId34sC0UrX3KdgniyZSlLyqZ1M40Vu+JpPPbcJbybkrcbhMkaW
         GU43nBg1dY/Q/dOMbxa7uINBoBWgSgaKbhIhW1N6w+yrPBiRgAISDwxKfVheHRJbg3tl
         pmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774248859; x=1774853659;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mao9DUlBnmujuW3A+CUh4bfJbpHQEdFcui9ik7MVEWE=;
        b=MNBuPuEB7pxFTlMR9t8SG5uDzrp7IwWT5pqGK5iOFhB1+p8ER3QgYJMJSEEZamxXrI
         QQ3YN37e9O3JCBDWkbqTVsbnjSepnXCrYvOm4mk71bR7TzFQR+g2iepHG34c3gpkZ4SK
         nTzeM8tE3OGIeK4GqO836vdpK1nHcHDCG8rD5Cipz4Ny3qB4B3Pdhj+qdV1q/+BfCZDa
         xAp50ozce94MkPrQbHnj+6UKJIhLtasDzbMreq1FiJ5bj1IrES7/rL6OAyn1+go5Cozu
         vwmbtVHMXUZmg+XqMDXfQC/psKUGY2OHZhy+1PUqGIPACjZXCWZAjD6r0mxhAnEZBsx6
         +ZNA==
X-Forwarded-Encrypted: i=1; AJvYcCWQzWFeJpdnGJNAylMZGrGQJHwhnanDWOND2qTki56VK9b8b3KRt6ti1hsFJDAAH5OqLGNCIHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQA9s5pYAeyc3g4HKPHNeiqm06YVjwVL8ghaI5i0D313CBdhT5
	ycCIWzO3wGl6bnuok04QoiZK20awhFogs9PoxXbR0m4jNhbiiAEoqY1+K8tsldDIqEF8drD9Ob9
	jM0oxZg==
X-Received: from pfbho9.prod.google.com ([2002:a05:6a00:8809:b0:829:a228:6330])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4290:b0:81f:4675:c2a9
 with SMTP id d2e1a72fcca58-82a8bf743eemr10439812b3a.0.1774248858592; Sun, 22
 Mar 2026 23:54:18 -0700 (PDT)
Date: Mon, 23 Mar 2026 06:54:05 +0000
In-Reply-To: <258f99ac-bd34-4d14-8271-1266b9aba6f8@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <258f99ac-bd34-4d14-8271-1266b9aba6f8@redhat.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260323065417.710353-1-kuniyu@google.com>
Subject: Re: [PATCH net v1] net/ipv6: mcast: fix circular locking dependency
 in __ipv6_dev_mc_inc()
From: Kuniyuki Iwashima <kuniyu@google.com>
To: pabeni@redhat.com
Cc: ap420073@gmail.com, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, horms@kernel.org, jiayuan.chen@linux.dev, 
	jiayuan.chen@shopee.com, josef@toxicpanda.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, nbd@other.debian.org, netdev@vger.kernel.org, 
	syzbot+afbcf622635e98bf40d2@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,kernel.org,google.com,linux.dev,shopee.com,toxicpanda.com,vger.kernel.org,other.debian.org,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-270381-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev,afbcf622635e98bf40d2];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4EE352ED305
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Paolo Abeni <pabeni@redhat.com>
Date: Thu, 19 Mar 2026 13:44:00 +0100
> Adding Josef.
> 
> On 3/19/26 4:26 AM, Jakub Kicinski wrote:
> > On Thu, 19 Mar 2026 11:04:24 +0800 Jiayuan Chen wrote:
> >>>> Split mca_alloc() into mca_alloc() + mca_init(): mca_alloc() does the
> >>>> GFP_KERNEL allocation before mc_lock, mca_init() initializes under
> >>>> mc_lock. If the address already exists, the pre-allocated memory is
> >>>> simply freed. Also move inet6_ifmcaddr_notify() outside mc_lock since
> >>>> it also does GFP_KERNEL allocation.  
> >>> Moving the allocation seems fine, but also having to move the
> >>> notification, potentially letting the notification go out of order
> >>> makes me wonder if we aren't better off adding helpers for taking this
> >>> lock which also call memalloc_noio_{save,restore} ?  
> >> Yeah, using memalloc_noio helpers is simpler. I checked and there
> >> are about 18 places taking mc_lock, so having a common mc_lock()/mc_unlock()
> >> wrapper that does the noio save/restore covers them all (if necessary).
> >>
> >> The only thing that feels a bit odd is using memalloc_noio in the networking
> >> subsystem. It makes sense in block/fs to protect itself from recursion.
> > 
> > Totally agree that it feels a bit odd that we have to worry about IO,
> > but unless we can figure out a way to prevent nbd sockets from getting
> > here all our solutions are dealing with noio in networking code :(
> > IMHO it's better to acknowledge this with the explicit memalloc_noio 
> > so future developers don't break things again with a mis-placed
> > allocation.
> 
> I think a problem here is that the nbd socket is still exposed to
> user-space, while in use by the block device.

Right, and this also prevents us from changing lockdep keys
(due to lock_sock_fast()).


> I fear that the more
> syzkaller will learn new tricks, the more we will have to had strange
> noio all around the networking code.

I agree.  We have 100+ unpublished reports for this variant, and
I started looking into them last week.


> 
> I *think* we could prevent this kind of races with something alike the
> following:
> - nbd sets a DOIO sk flag on the sockets it uses.
> - the socket layer prevents socketopts()/ioctl() entirely on DOIO sk

NBD sets sk->sk_allocation, so if we use it around, there should
be no real race, but still lockdep would not be happy.

The problem is sendmsg() and shutdown() invoked from NBD (recmsg()
is okay which is not under tx_lock), and my idea is to implemnt the
trylock variant for lock_sock() and use it for TCP. ( AF_UNIX does
not have the race because it does not use lock_sock() in sendmsg()
and shutdown() )

sendmsg() will be retried with -ERESTARTSYS where needed thanks to
was_interrupted().  While sendmsg() for disconnect and shutdown()
could be missed, but probably not a big deal (the peer will get
RST when it send something) ?

If this looks good, I'll send a formal patch.

---8<---
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index fe63f3c55d0d..9003baf52be8 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -45,6 +45,8 @@
 #include <linux/nbd.h>
 #include <linux/nbd-netlink.h>
 #include <net/genetlink.h>
+#include <net/tcp.h>
+#include <net/inet_common.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/nbd.h>
@@ -302,6 +304,19 @@ static int nbd_disconnected(struct nbd_config *config)
 		test_bit(NBD_RT_DISCONNECT_REQUESTED, &config->runtime_flags);
 }
 
+static void nbd_sock_shutdown(struct sock *sk)
+{
+	if (sk_is_stream_unix(sk)) {
+		kernel_sock_shutdown(sk->sk_socket, SHUT_RDWR);
+		return;
+	}
+
+	if (lock_sock_try(sk)) {
+		inet_shutdown_locked(sk->sk_socket, SHUT_RDWR);
+		release_sock(sk);
+	}
+}
+
 static void nbd_mark_nsock_dead(struct nbd_device *nbd, struct nbd_sock *nsock,
 				int notify)
 {
@@ -315,7 +330,8 @@ static void nbd_mark_nsock_dead(struct nbd_device *nbd, struct nbd_sock *nsock,
 		}
 	}
 	if (!nsock->dead) {
-		kernel_sock_shutdown(nsock->sock, SHUT_RDWR);
+		nbd_sock_shutdown(nsock->sock->sk);
+
 		if (atomic_dec_return(&nbd->config->live_connections) == 0) {
 			if (test_and_clear_bit(NBD_RT_DISCONNECT_REQUESTED,
 					       &nbd->config->runtime_flags)) {
@@ -548,6 +564,22 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req)
 	return BLK_EH_DONE;
 }
 
+static int nbd_sock_sendmsg(struct socket *sock, struct msghdr *msg)
+{
+	struct sock *sk = sock->sk;
+	int err = -ERESTARTSYS;
+
+	if (sk_is_stream_unix(sk))
+		return sock_sendmsg(sock, msg);
+
+	if (lock_sock_try(sk)) {
+		err = tcp_sendmsg_locked(sk, msg, msg_data_left(msg));
+		release_sock(sk);
+	}
+
+	return err;
+}
+
 static int __sock_xmit(struct nbd_device *nbd, struct socket *sock, int send,
 		       struct iov_iter *iter, int msg_flags, int *sent)
 {
@@ -573,7 +605,7 @@ static int __sock_xmit(struct nbd_device *nbd, struct socket *sock, int send,
 			msg.msg_flags = msg_flags | MSG_NOSIGNAL;
 
 			if (send)
-				result = sock_sendmsg(sock, &msg);
+				result = nbd_sock_sendmsg(sock, &msg);
 			else
 				result = sock_recvmsg(sock, &msg, msg.msg_flags);
 
@@ -1228,6 +1260,13 @@ static struct socket *nbd_get_socket(struct nbd_device *nbd, unsigned long fd,
 		return NULL;
 	}
 
+	if (READ_ONCE(sock->sk->sk_state) != TCP_ESTABLISHED) {
+		dev_err(disk_to_dev(nbd->disk), "Unsupported socket: not connected yet.\n");
+		*err = -ENOTCONN;
+		sockfd_put(sock);
+		return NULL;
+	}
+
 	if (sock->ops->shutdown == sock_no_shutdown) {
 		dev_err(disk_to_dev(nbd->disk), "Unsupported socket: shutdown callout must be supported.\n");
 		*err = -EINVAL;
diff --git a/include/net/inet_common.h b/include/net/inet_common.h
index 5dd2bf24449e..c085c39573c9 100644
--- a/include/net/inet_common.h
+++ b/include/net/inet_common.h
@@ -38,6 +38,7 @@ void inet_splice_eof(struct socket *sock);
 int inet_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 		 int flags);
 int inet_shutdown(struct socket *sock, int how);
+int inet_shutdown_locked(struct socket *sock, int how);
 int inet_listen(struct socket *sock, int backlog);
 int __inet_listen_sk(struct sock *sk, int backlog);
 void inet_sock_destruct(struct sock *sk);
diff --git a/include/net/sock.h b/include/net/sock.h
index 6c9a83016e95..203a60661fce 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1710,6 +1710,24 @@ static inline void lock_sock(struct sock *sk)
 }
 
 void __lock_sock(struct sock *sk);
+
+static inline bool lock_sock_try(struct sock *sk)
+{
+	if (!spin_trylock_bh(&sk->sk_lock.slock))
+		return false;
+
+	if (sk->sk_lock.owned) {
+		spin_unlock_bh(&sk->sk_lock.slock);
+		return false;
+	}
+
+	sk->sk_lock.owned = 1;
+	spin_unlock_bh(&sk->sk_lock.slock);
+
+	mutex_acquire(&sk->sk_lock.dep_map, 0, 1, _RET_IP_);
+	return true;
+}
+
 void __release_sock(struct sock *sk);
 void release_sock(struct sock *sk);
 
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 8036e76aa1e4..bde8ddcc28f0 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -896,21 +896,11 @@ int inet_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 }
 EXPORT_SYMBOL(inet_recvmsg);
 
-int inet_shutdown(struct socket *sock, int how)
+static int __inet_shutdown(struct socket *sock, int how)
 {
 	struct sock *sk = sock->sk;
 	int err = 0;
 
-	/* This should really check to make sure
-	 * the socket is a TCP socket. (WHY AC...)
-	 */
-	how++; /* maps 0->1 has the advantage of making bit 1 rcvs and
-		       1->2 bit 2 snds.
-		       2->3 */
-	if ((how & ~SHUTDOWN_MASK) || !how)	/* MAXINT->0 */
-		return -EINVAL;
-
-	lock_sock(sk);
 	if (sock->state == SS_CONNECTING) {
 		if ((1 << sk->sk_state) &
 		    (TCPF_SYN_SENT | TCPF_SYN_RECV | TCPF_CLOSE))
@@ -947,11 +937,45 @@ int inet_shutdown(struct socket *sock, int how)
 
 	/* Wake up anyone sleeping in poll. */
 	sk->sk_state_change(sk);
+
+	return err;
+}
+
+int inet_shutdown(struct socket *sock, int how)
+{
+	struct sock *sk = sock->sk;
+	int err;
+
+	/* maps 0->1 has the advantage of making bit 1 rcvs and
+	 *      1->2 bit 2 snds.
+	 *      2->3
+	 */
+	how++;
+
+	if ((how & ~SHUTDOWN_MASK) || !how)
+		return -EINVAL;
+
+	lock_sock(sk);
+	err = __inet_shutdown(sock, how);
 	release_sock(sk);
+
 	return err;
 }
 EXPORT_SYMBOL(inet_shutdown);
 
+int inet_shutdown_locked(struct socket *sock, int how)
+{
+	sock_owned_by_me(sock->sk);
+
+	how++;
+
+	if ((how & ~SHUTDOWN_MASK) || !how)
+		return -EINVAL;
+
+	return __inet_shutdown(sock, how);
+}
+EXPORT_SYMBOL_GPL(inet_shutdown_locked);
+
 /*
  *	ioctl() calls you can issue on an INET socket. Most of these are
  *	device configuration and stuff and very rarely used. Some ioctls
---8<---

