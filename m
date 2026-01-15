Return-Path: <netdev+bounces-250063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9578BD237B6
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 10:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 171A8303668F
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 09:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3E633ADA4;
	Thu, 15 Jan 2026 09:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UU+Xl//T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90E435B14A
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 09:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768468910; cv=none; b=ZCWCfVess0zMEaggmt2EwWXr6OzY/FfSyHYMxplg9NyTSkXLo2J/J997RvfZjFneAPNDfLHdLqMN4Pe8nJU97lzbu8jOm9/HzN81DFgPNV7lmV9dFvDKplBMJt4Jgzyjo7OrPLSSXGdNI8l42GukS9EIfll1KgDwWnEzhv+imxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768468910; c=relaxed/simple;
	bh=pKQeXmb8P0JoBYl8E2gLsMOmrImeBE+rvqkcGUhf6aQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VISop9JrA4CTZ7QV3c0o3oP7fKZqianUB4YrEFyNsDaY8JeovVBcUJwAJP/EU8VrOu9I63u7aP4M2RujNSDSQVR97SlpIR3EdVOB5VzQFrcKd/cVM7C9TbjZUsotH22v2GmuqA7pqHilI5F4n1BmE1vHV8dGU2v3XltDxk6jvqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UU+Xl//T; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8c538971a16so185465685a.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 01:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768468901; x=1769073701; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/tbSzTURd8o+feNydr+JfVPOONCqjyd/DDdv81WitAo=;
        b=UU+Xl//TScBdSrk9UywZwec4l8Qi+m8OpONqeDPRqDn3XuYJVv2v5RghXwmMJrFosP
         s18oNpVuJp07SDK4CG5ipBoRfMQVd6DPKki3Oeh1wtwZjYCchhNL/Xe4PawQds7P6Pxo
         mOzIOxdxyvOT3YU0+JrdzE5MpmaQQzGdUtgknWBGBwoBhqWiLm4kWogsBJnQ/+7aO7Es
         DDMKW5HHjK+K7AxML3g6j7gg1zSyVoEj42WEjRpZhOIs0jarZTRSvaz2RKmr7jt95L36
         TYZOsYciImYM6NoEeK9qmxbsLMNo+2skbrMzK02o3hsCiDHJJBTbFf3mI3PSinE743e+
         sNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768468901; x=1769073701;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/tbSzTURd8o+feNydr+JfVPOONCqjyd/DDdv81WitAo=;
        b=KWTSChUatbTG2n//RGsbdClY/GQPcsh4cqB32zlHeX6AVOH+mrKSfQ5GXAKoIl9wh5
         3IuGC1MkItdCyIazlrtuukoabWfdBDiySVjXqDcFR+fbE9Sx8Ko/S+L8ezQ7YrATaBQZ
         i0b2zx3+GjMlsm26bYpV6laxC4SIIKwNQXIX0McedxfL/dygKyUF+RdUE+anFTeKqefM
         bcZqbnuTrJU3CSFrHDAlbohtzYBWDJomFo3PV8aQVLJ1C9W4MZrlceVQwH6UCBS7DMjA
         OWuNgqhPcr1uq9ChZBunnjKYXLh+tmGD55yBotJlUqk3j2qFxMH7+6Lkm31i/+Y0fyTm
         AfzA==
X-Forwarded-Encrypted: i=1; AJvYcCVCAl43+lFfq9AwEyUwcU7QZA7rIK4Gzvy8fy1Uxva1Tp8m9dSDRTIAVhkLXVQXbt7I9NTc3vo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMYszkzVr1PAveQxJi1qzg6zD9A/2mbP8L5KG2pTGdRokBRPZA
	SaB50HU5UCiB2TxQHhnfox0n3jMCzZ2R77H+5fXZjyBriVlAB/Ncp4/3o+wyrL9tsv/ZXDfqfgw
	5qoGHF1w9X42RAg==
X-Received: from qkp13.prod.google.com ([2002:a05:620a:40d:b0:8bb:38a9:e9d0])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4543:b0:8b2:d26f:14b0 with SMTP id af79cd13be357-8c52fb05548mr728132085a.3.1768468900776;
 Thu, 15 Jan 2026 01:21:40 -0800 (PST)
Date: Thu, 15 Jan 2026 09:21:39 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260115092139.3066180-1-edumazet@google.com>
Subject: [PATCH net] l2tp: avoid one data-race in l2tp_tunnel_del_work()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+7312e82745f7fa2526db@syzkaller.appspotmail.com, 
	James Chapman <jchapman@katalix.com>
Content-Type: text/plain; charset="UTF-8"

We should read sk->sk_socket only when dealing with kernel sockets.

syzbot reported the following data-race:

BUG: KCSAN: data-race in l2tp_tunnel_del_work / sk_common_release

write to 0xffff88811c182b20 of 8 bytes by task 5365 on cpu 0:
  sk_set_socket include/net/sock.h:2092 [inline]
  sock_orphan include/net/sock.h:2118 [inline]
  sk_common_release+0xae/0x230 net/core/sock.c:4003
  udp_lib_close+0x15/0x20 include/net/udp.h:325
  inet_release+0xce/0xf0 net/ipv4/af_inet.c:437
  __sock_release net/socket.c:662 [inline]
  sock_close+0x6b/0x150 net/socket.c:1455
  __fput+0x29b/0x650 fs/file_table.c:468
  ____fput+0x1c/0x30 fs/file_table.c:496
  task_work_run+0x131/0x1a0 kernel/task_work.c:233
  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
  __exit_to_user_mode_loop kernel/entry/common.c:44 [inline]
  exit_to_user_mode_loop+0x1fe/0x740 kernel/entry/common.c:75
  __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
  syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
  syscall_exit_to_user_mode_work include/linux/entry-common.h:159 [inline]
  syscall_exit_to_user_mode include/linux/entry-common.h:194 [inline]
  do_syscall_64+0x1e1/0x2b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff88811c182b20 of 8 bytes by task 827 on cpu 1:
  l2tp_tunnel_del_work+0x2f/0x1a0 net/l2tp/l2tp_core.c:1418
  process_one_work kernel/workqueue.c:3257 [inline]
  process_scheduled_works+0x4ce/0x9d0 kernel/workqueue.c:3340
  worker_thread+0x582/0x770 kernel/workqueue.c:3421
  kthread+0x489/0x510 kernel/kthread.c:463
  ret_from_fork+0x149/0x290 arch/x86/kernel/process.c:158
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

value changed: 0xffff88811b818000 -> 0x0000000000000000

Fixes: d00fa9adc528 ("l2tp: fix races with tunnel socket close")
Reported-by: syzbot+7312e82745f7fa2526db@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6968b029.050a0220.58bed.0016.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: James Chapman <jchapman@katalix.com>
---
 net/l2tp/l2tp_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 687c1366a4d0f4afb5ba2800e8faff3cb9c5437b..3eed63d8c9cdcb10cad0eb260dcddc4ac4272634 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1414,8 +1414,6 @@ static void l2tp_tunnel_del_work(struct work_struct *work)
 {
 	struct l2tp_tunnel *tunnel = container_of(work, struct l2tp_tunnel,
 						  del_work);
-	struct sock *sk = tunnel->sock;
-	struct socket *sock = sk->sk_socket;
 
 	l2tp_tunnel_closeall(tunnel);
 
@@ -1423,6 +1421,8 @@ static void l2tp_tunnel_del_work(struct work_struct *work)
 	 * the sk API to release it here.
 	 */
 	if (tunnel->fd < 0) {
+		struct socket *sock = tunnel->sock->sk_socket;
+
 		if (sock) {
 			kernel_sock_shutdown(sock, SHUT_RDWR);
 			sock_release(sock);
-- 
2.52.0.457.g6b5491de43-goog


