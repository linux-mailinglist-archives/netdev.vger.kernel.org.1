Return-Path: <netdev+bounces-298903-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 27hwNQ/cLGp3XAQAu9opvQ
	(envelope-from <netdev+bounces-298903-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 06:26:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3507F67DABC
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 06:26:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=N+sFa2fk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298903-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298903-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB039318AA92
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 04:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEFE33F59B;
	Sat, 13 Jun 2026 04:26:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351272D7DEF
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 04:26:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781324784; cv=none; b=fG/cbPWIuGDKyeWM6ZHUO7eldpQQwQCyMcB2rJUslHVBSNnouwHATJM9hNnGZHRSSi1uHtgC32u1LuZgqIzQOVIE9dIroMnDOqnoZz8VZtG0R6dziQqX5lmCgcZ+UpeF+8mzO3lDOJJ34Mhc7TW2caEnaJfSeyVOz6PVrUYC4M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781324784; c=relaxed/simple;
	bh=xYvnBoU24LowK9XsuA1dWBRvMVViHxPRA9DkZeY0a+A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UfCJbfV0/X3OgjAhQ0L/7mWvksWi1h+fFDL0I8JTZvuihLcPBf21HAWn25egeowzx9IuxLJcbKSVCtJNYniTDUt29fSIHzImXpBWvwRFKJKXX8yX4gNwVAn/Q+eObxs5f5J67NKH0efPYvFji+X+vwSa/SP1/mcKI+IQaMynYsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N+sFa2fk; arc=none smtp.client-ip=209.85.160.201
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-5195827a23eso3703971cf.3
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 21:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781324781; x=1781929581; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6l2xGU+3qIFZEhz6OluRSAKcM6KzJn808ttYDsC9+QQ=;
        b=N+sFa2fkbGf9QmHpMmDGIr7Vpu8TbgqzCWJmut9Noc0/CO5USHoncHqmOZ4YBMWjGz
         GJHVQFCd27Z/31CcWKsx49BoM8/u8wrICVmZSHYlaEeBZ5zX3QulAGzG29l4ZuUNOI/N
         DAkOOJrKGNanO3xJq1LWFXizuaLkbY8NYqI1ULa5HQRuXv3ZZeE4gY3f4iozxUp5/p0A
         WoW1eL4bG+ktwK2pVI0ctalLS4+ZHxip4UW6XRf3ZmaVEkyO5kh0rm4XdRCoLiPzbDjC
         sda8Bg8JIlErnI8TApH+Q/VSL9N5Gf9ipYP8mFLugz0T1bZkI6OvaOSD/qiBfG4ljIU2
         UN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781324781; x=1781929581;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6l2xGU+3qIFZEhz6OluRSAKcM6KzJn808ttYDsC9+QQ=;
        b=m4pemjG5uPPc4O3pozsYIT1YJUpw/Mriczv+SLo1ZCYrZWv/ccRlJnU4JzG7cTrDOt
         os4fopdyfoQfFONo1NaELzb9ljG5pupvVG6/gWuLKDo/jRSX2ypOCoeJ5zMPY5HiRUwU
         GZvnQSrwDtPcjD3kVj94hpJXdPNzOQAieIIV0nMfPSfe/TW6HlRJwNVwgCZjPo0h4VfP
         /AcT6LmKy1HEI0USHb0w+hzhxsX0l3YSMiV7bY4SGUcgx7TK0xS8133/q02mu8oIDtyw
         ckNdKZAR7BcKaZ2pzyOfE9OvPJR9RrNVkkehZOYXIX5nP6f0JlYLRe/IsAdcr1W9eJy+
         OC6Q==
X-Forwarded-Encrypted: i=1; AFNElJ9Fa8GpxuuYZQ7YKbO3VIbCoIhC/gMI/HKKbq94RVu5M+ZTJ2lwq1L3xpX5/zQ2qQbo3uL5Bxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHMIUbrAIwyp0RF1c7wIVVaX5mkx6w0igdKGrPK39kPtTSS0qZ
	dq67eJXckRpKCI3C74B093O+7qYAOT7L1BW0wFNqjrErpstyjs39Knuk0Rfl1BD2oEX+sTBIo+a
	oImPr4FPwztrR+Q==
X-Received: from qtc12.prod.google.com ([2002:a05:622a:8e0c:b0:517:29b8:33b3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5e08:0:b0:517:6a26:43b with SMTP id d75a77b69052e-51953553d89mr38847661cf.44.1781324780985;
 Fri, 12 Jun 2026 21:26:20 -0700 (PDT)
Date: Sat, 13 Jun 2026 04:26:19 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613042619.1108126-1-edumazet@google.com>
Subject: [PATCH] nbd: Reclassify sockets to avoid lockdep circular dependency
From: Eric Dumazet <edumazet@google.com>
To: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org, 
	nbd@other.debian.org, Eric Dumazet <eric.dumazet@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, syzbot+607cdcf978b3e79da878@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298903-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:josef@toxicpanda.com,m:axboe@kernel.dk,m:linux-kernel@vger.kernel.org,m:linux-block@vger.kernel.org,m:nbd@other.debian.org,m:eric.dumazet@gmail.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:edumazet@google.com,m:syzbot+607cdcf978b3e79da878@syzkaller.appspotmail.com,m:ericdumazet@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,other.debian.org,gmail.com,kernel.org,redhat.com,google.com,syzkaller.appspotmail.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,607cdcf978b3e79da878];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3507F67DABC

syzbot reported a possible circular locking dependency in udp_sendmsg()
where fs_reclaim can be triggered while holding sk_lock, and fs_reclaim
can eventually depend on another sk_lock (e.g., if NBD is used for swap
or writeback and NBD uses TLS/TCP which acquires sk_lock).

Since the UDP socket and the NBD TCP/TLS socket are different, this is a
false positive. Fix this by reclassifying NBD sockets to a separate lock
class when they are added to the NBD device.

This is similar to what nvme-tcp and other network block devices do.

Fixes: ffa1e7ada456 ("block: Make request_queue lockdep splats show up earlier")
Reported-by: syzbot+607cdcf978b3e79da878@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6a2cdafe.428ffe26.258b27.0161.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/block/nbd.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index fe63f3c55d0d960a1a4bbb2c60738cbbece10719..0e2180e910c4eaaa58556a0c75c1b9c3fdc1930d 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1238,6 +1238,42 @@ static struct socket *nbd_get_socket(struct nbd_device *nbd, unsigned long fd,
 	return sock;
 }
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+static struct lock_class_key nbd_key[3];
+static struct lock_class_key nbd_slock_key[3];
+
+static void nbd_reclassify_socket(struct socket *sock)
+{
+	struct sock *sk = sock->sk;
+
+	if (WARN_ON_ONCE(!sock_allow_reclassification(sk)))
+		return;
+
+	switch (sk->sk_family) {
+	case AF_INET:
+		sock_lock_init_class_and_name(sk, "slock-AF_INET-NBD",
+					      &nbd_slock_key[0],
+					      "sk_lock-AF_INET-NBD",
+					      &nbd_key[0]);
+		break;
+	case AF_INET6:
+		sock_lock_init_class_and_name(sk, "slock-AF_INET6-NBD",
+					      &nbd_slock_key[1],
+					      "sk_lock-AF_INET6-NBD",
+					      &nbd_key[1]);
+		break;
+	case AF_UNIX:
+		sock_lock_init_class_and_name(sk, "slock-AF_UNIX-NBD",
+					      &nbd_slock_key[2],
+					      "sk_lock-AF_UNIX-NBD",
+					      &nbd_key[2]);
+		break;
+	}
+}
+#else
+static inline void nbd_reclassify_socket(struct socket *sock) {}
+#endif
+
 static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 			  bool netlink)
 {
@@ -1254,6 +1290,7 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 	sock = nbd_get_socket(nbd, arg, &err);
 	if (!sock)
 		return err;
+	nbd_reclassify_socket(sock);
 
 	/*
 	 * We need to make sure we don't get any errant requests while we're
-- 
2.54.0.1136.gdb2ca164c4-goog


