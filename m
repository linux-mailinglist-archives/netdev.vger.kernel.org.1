Return-Path: <netdev+bounces-306690-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q14VFV9TUWppCQMAu9opvQ
	(envelope-from <netdev+bounces-306690-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 22:17:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DD48273E0B6
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 22:17:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="c5Ri/o4F";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306690-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306690-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE7613014C64
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 20:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C7E384238;
	Fri, 10 Jul 2026 20:17:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE75E44998C
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 20:17:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783714647; cv=none; b=q3reLys1KBj7Rul00SvDt7vlzt0JJfixRmnmi1AgWVrg9fcb/0sehRzAvjhuKV279pfT280ZZ98fBHaUCGJTgSdGhLBXtqFJFc0/dNdbgfwkg3c2NWUMGLjf16Q1FksNAaXnvopEOPu0lfxoWfLV18G4Xd8vERS1/rmKhdrtQuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783714647; c=relaxed/simple;
	bh=1WJtOKhF6UDkj4WFyAFClNJ8eoY0cFBd6HiAfZMZNOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iluRv/1XuvyleUOhviw5Gdou+WGSgOoKYk4jjSBn/j1tBnEWGj6ymq9m/j48OYF2RLd+6xrTQnBmAYURry0XE/VEXTFFHFztaFQ8r9K6tMy8pQJD9k5O9ekkslmaYRMB/LK7gbNrc2sDyDLAyzE+NPhic8MIRg39M8Qi2YvzO1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5Ri/o4F; arc=none smtp.client-ip=209.85.221.52
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-472326ca506so1049790f8f.2
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 13:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783714643; x=1784319443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VPZxlfa4Ktt0t/jyLkjMhd8w3yrqTEInPayeLWsP3ks=;
        b=c5Ri/o4FyYBo79aQtEls7pO1Okym7osC1zJ7eYOT/eMIQ8eyVArBC7JOf4bq0gurrR
         9R1JQrd/Pn13H6XPCJMapqQkARNstZeFXD1YMJ+7LtBApWPJ5Zk8526FOO6aafXimk5s
         amNaVR9+y1Vv7dbB1M8Kl6xHr8OoaDW+5DxTcx09eOd6ARbxY2P6xH9nf/M7btPeOKHs
         jS3qntl3BlHFne/fVR0oyIiv8cYiuOwb8SojMqL+YOPmii3/dIdPdt+LOFvKxXl/YSb3
         zLLCcsoaNdMl9OQilRyJW433GE0qrwjb3Z32OtjBpdk9K545Lpn/oddb98owx4c6IhJ0
         r8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783714643; x=1784319443;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VPZxlfa4Ktt0t/jyLkjMhd8w3yrqTEInPayeLWsP3ks=;
        b=gViGUmfJAoUwiEx6babwK5ZcXF2vaA4ebPsmWE89mrTMOkDO9H7KD9Vp+qyM1BUaqU
         i92dcS84yqc9552RBVulQCtHInLCQoSjcC1wGlWhqIcG3bnHnDr6u7679eOJbjODQCf5
         Cp/RNqxEeu5Dgb/IlTEm1L4ZElsyc5kWpb+vQe/yonxKNWxFO6wFeF8ICXvvIAxtkYB7
         c7cf/K5Ii1kLEWeq3wixoh9KxAle+MmBXSfXK8Jb8pjJ11ob+btGWYuffA+EOmD3PqK/
         F0RH6QxMvXC9r3vrhhm5rL9uC579wUxP3z517AfopgLPp/LhFkqKvY7HP2LSxskPG0L1
         FVEA==
X-Forwarded-Encrypted: i=1; AHgh+Rp7f74Pe4oIriq+ex+8s0u3YnXtNJfv27J7xWVYH0lvJAsCkqQ/5Dr4ntpxEiTpkQwyHgj/uQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4NBt5FDBT5ydVNIOJCEIGSEv0B3IhI1PI8dhPydaLWFoM46Jf
	tZvrUcwiVG0RS1K+ynU90JY/ZyGZyCEyp4NbI41+o/IpRGFHfOh6tGto
X-Gm-Gg: AfdE7cm1oWP5qxxjDPS/K61T65f4QhOW5E2ZMQcB8bfkvQos8ERR/rkEu4ftHCXZchy
	uf4N+V5Av1or4odsLEyPc5Kaar4opfsErAK89iVFJkCuRLtF5Wnr28m0ilNKjE8br+KNM5WCwIc
	UyBLh31gVpA2PtzMdurmBLJEoT+7UG0KAQxl5Q/bmIyroUK2J4uTOoyHvNRsmfMpojxY1hd5loZ
	a3Xnd/xYoKt0CooA50QzT8D7Hh8DSOnnaX6Krl8ehVYTtPq1rQZD8bP4dea/oQ436tlXFr5UQ+J
	nbsqHJ6f3dtR55UCcIZaNgupWWtTGz1BXqzFIXQsfhdgT71MRiN0/ZU1mewxw4lElZZ2R4cT0XK
	7ie+OyKFji6kq+Eqj2QR5EjhGDepWvQTQ7jyCg3m2URHmaO4xoG9PbwAtvtfuNGPt3epW3lqhSj
	Vlf0OyYK2U4q2m9JFA4hswx2XrinTYGejLaEjTgkY+SW4+i9TAFYWSAzhNuXtbadzvWaiP7aO3T
	UKk
X-Received: by 2002:a05:6000:40dd:b0:476:82f4:4dcc with SMTP id ffacd0b85a97d-47f2dcf42a1mr210963f8f.33.1783714642985;
        Fri, 10 Jul 2026 13:17:22 -0700 (PDT)
Received: from localhost.localdomain (host86-153-201-25.range86-153.btcentralplus.com. [86.153.201.25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d780csm62731555f8f.11.2026.07.10.13.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 13:17:22 -0700 (PDT)
Date: Fri, 10 Jul 2026 21:17:20 +0100
From: Nnamdi Onyeyiri <nnamdio@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, john.fastabend@gmail.com, 
	jakub@cloudflare.com, jiayuan.chen@linux.dev, edumazet@google.com, 
	ncardwell@google.com, kuniyu@google.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org
Subject: Re: [BUG] bpf, sockmap: spurious wakeup by tcp_msg_wait_data()
 causing unexpected EAGAIN in recvfrom()
Message-ID: <alFRK66z45eDNZA7@localhost.localdomain>
References: <ak_rR-Skd8Mvn4mH@localhost.localdomain>
 <20260709185526.E4DAB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709185526.E4DAB1F000E9@smtp.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306690-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,cloudflare.com,linux.dev,google.com,davemloft.net,kernel.org,redhat.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[nnamdio@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:edumazet@google.com,m:ncardwell@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nnamdio@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DD48273E0B6

Hi,

The updated patch below addresses the issues raised by sashiko-bot.  The closed
socket and signal handling code was added to tcp_bpf_recvmsg(), and the fix was
updated to work for sockets with SO_RCVTIMEO set.

Please let me know if any more changes are required, or if the patch would need
to be submitted some other way, I'm happy to adjust as necessary.

Thanks!

----8<----
From 20a1275aa5ecb927ff049971454b62682356ef0e Mon Sep 17 00:00:00 2001
From: Nnamdi Onyeyiri <nnamdio@gmail.com>
Date: Fri, 10 Jul 2026 20:47:36 +0100
Subject: [PATCH v2 1/1] bpf, sockmap: handle spurious tcp_msg_wait_data()
 wakeup

recvfrom()/recv() are documented as only returning EAGAIN for blocking sockets
when they have a receive timeout configured.  however, adding a blocking
ipv4 tcp socket without a receive timeout to a sockmap will cause EAGAIN errors
sporadically.  a socket with a receive timeout may return EAGAIN before the
timeout expires.

this happens when tcp_msg_wait_data() wakes spuriously (returning 0) in which
case, if there is no timeout, or the timeout has not yet expired, we loop
again instead of returning.

Signed-off-by: Nnamdi Onyeyiri <nnamdio@gmail.com>
---
 net/ipv4/tcp_bpf.c | 55 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index cc0bd73f36b6..e3109edb9621 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -179,7 +179,7 @@ EXPORT_SYMBOL_GPL(tcp_bpf_sendmsg_redir);
 
 #ifdef CONFIG_BPF_SYSCALL
 static int tcp_msg_wait_data(struct sock *sk, struct sk_psock *psock,
-			     long timeo)
+			     long *timeo)
 {
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
 	int ret = 0;
@@ -187,12 +187,12 @@ static int tcp_msg_wait_data(struct sock *sk, struct sk_psock *psock,
 	if (sk->sk_shutdown & RCV_SHUTDOWN)
 		return 1;
 
-	if (!timeo)
+	if (!(*timeo))
 		return ret;
 
 	add_wait_queue(sk_sleep(sk), &wait);
 	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
-	ret = sk_wait_event(sk, &timeo,
+	ret = sk_wait_event(sk, timeo,
 			    !list_empty(&psock->ingress_msg) ||
 			    !skb_queue_empty_lockless(&sk->sk_receive_queue), &wait);
 	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
@@ -229,6 +229,7 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 	int copied_from_self = 0;
 	int copied = 0;
 	u32 seq;
+	long timeo;
 
 	if (unlikely(flags & MSG_ERRQUEUE))
 		return inet_recv_error(sk, msg, len);
@@ -262,6 +263,8 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 		}
 	}
 
+	timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
+
 msg_bytes_ready:
 	copied = __sk_msg_recvmsg(sk, psock, msg, len, flags, &copied_from_self);
 	/* The typical case for EFAULT is the socket was gracefully
@@ -280,7 +283,6 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 	}
 	seq += copied_from_self;
 	if (!copied) {
-		long timeo;
 		int data;
 
 		if (sock_flag(sk, SOCK_DONE))
@@ -299,7 +301,6 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 			goto out;
 		}
 
-		timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
 		if (!timeo) {
 			copied = -EAGAIN;
 			goto out;
@@ -310,13 +311,15 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 			goto out;
 		}
 
-		data = tcp_msg_wait_data(sk, psock, timeo);
+		data = tcp_msg_wait_data(sk, psock, &timeo);
 		if (data < 0) {
 			copied = data;
 			goto unlock;
 		}
 		if (data && !sk_psock_queue_empty(psock))
 			goto msg_bytes_ready;
+		if (!data && timeo > 0)
+			goto msg_bytes_ready;
 		copied = -EAGAIN;
 	}
 out:
@@ -355,6 +358,7 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 {
 	struct sk_psock *psock;
 	int copied, ret;
+	long timeo;
 
 	if (unlikely(flags & MSG_ERRQUEUE))
 		return inet_recv_error(sk, msg, len);
@@ -371,14 +375,45 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		return tcp_recvmsg(sk, msg, len, flags);
 	}
 	lock_sock(sk);
+
+	timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
+
 msg_bytes_ready:
 	copied = sk_msg_recvmsg(sk, psock, msg, len, flags);
 	if (!copied) {
-		long timeo;
 		int data;
 
-		timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
-		data = tcp_msg_wait_data(sk, psock, timeo);
+		if (sock_flag(sk, SOCK_DONE)) {
+			ret = 0;
+			goto unlock;
+		}
+
+		if (sk->sk_err) {
+			ret = sock_error(sk);
+			goto unlock;
+		}
+
+		if (sk->sk_shutdown & RCV_SHUTDOWN) {
+			ret = 0;
+			goto unlock;
+		}
+
+		if (sk->sk_state == TCP_CLOSE) {
+			ret = -ENOTCONN;
+			goto unlock;
+		}
+
+		if (!timeo) {
+			ret = -EAGAIN;
+			goto unlock;
+		}
+
+		if (signal_pending(current)) {
+			ret = sock_intr_errno(timeo);
+			goto unlock;
+		}
+
+		data = tcp_msg_wait_data(sk, psock, &timeo);
 		if (data < 0) {
 			ret = data;
 			goto unlock;
@@ -390,6 +425,8 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			sk_psock_put(sk, psock);
 			return tcp_recvmsg(sk, msg, len, flags);
 		}
+		if (!data && timeo > 0)
+			goto msg_bytes_ready;
 		copied = -EAGAIN;
 	}
 	ret = copied;
-- 
2.52.0


