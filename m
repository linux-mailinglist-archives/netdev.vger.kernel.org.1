Return-Path: <netdev+bounces-160390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD04A1982E
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 19:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9479161F36
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 18:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01294170A11;
	Wed, 22 Jan 2025 18:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lYwnJmo4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4635F1B808
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 18:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737568968; cv=none; b=Dvl9NFIIHB+/MnFlELzk3GZF2xtNUy5E7CNqSZmILr3Rte8w23Md/lKrRVGJcwvwf8jOkY3iEjoIUTjQH/FUBYnRhdFaFlTrexNjnMCORHDdc+Px067RpevfVoj3cbRew12vn7J28DDisxlmu1OMqO7I2Q+Rqpk7ctp7o1kgRJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737568968; c=relaxed/simple;
	bh=rLyAXJgLL/2Ffqw6ML0Y4FFKAvNovEoRKkxltL34v6w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CKVeQQcx1RFcEqixTBKeWZjSt1BGg/cBo2XW319Pq07C95SxqB1zKbOWnWvQfRvoRuTkFi0ktLTYA69/H54bk3EgvbbM6AuEPhmxrWR8ENrcM2UTwJ6rzrbMH0JAjIwTscsp/qvTd9BruVeUVat5tk/zaZ/efGeh+I5cQzim85Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lYwnJmo4; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-468f6f2f57aso574821cf.0
        for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 10:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737568966; x=1738173766; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5KnI9jxAXcR7oywRwA8+76jlpqhg+RydA6gAwJrgLIk=;
        b=lYwnJmo4eI2bbyiSI1u/xJaSe2X1Go+ODIGwJxLnIRriPxtHSVq5b7qiN+BNyCdsBu
         9+JN0dq59YlsHsZp3XyM+YtUKpb04rw55Ra2OJpkhCo27yfCxFl/k+O372zbl5lQAccM
         6z3aVWReFL4OgnlVQGv3O/FhmBDvjT3iro+VJjJIKQo8PLFRY5FzeMWRM+39ahKxnpJQ
         KhWXKmxjk2jmpMcGOEhV5vo+U+vuw0ezqtftBBrAvOoVZ1IZIdY8e5S8jAMGmg7WRRhE
         OuVTwGFAvfU7f75W3SRDSLyBb7GFDziZ9mbnD5JJJjBQFTtmekCkFbvT1G3IDTg8d+sF
         soJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737568966; x=1738173766;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5KnI9jxAXcR7oywRwA8+76jlpqhg+RydA6gAwJrgLIk=;
        b=KTOk7a1ZY1bEfUW+K7xQYPw5v/eycVVVEFLXJcUZL7XI61O+qdUFz2f63Ug4CosHeq
         yx197iorb564Wo6wF1anEAEL35Gx2et04j9rLR0w5G/FEFIwKOI8fCkpd+b0dmHobrw6
         KUgQ+6kvatla6R4uGmN2XY6wYIaaHOKiyV90Wb4BlG0l0XUH9ZErRy9bF3NlB8AIq6+M
         tQlT4gvIFy0WDgYp1LdvSU6c1tZxRxK9uMlvnpwU+Cy2ABZBIu++U/a8skwATrEC/COb
         hKfeIRZklypEu39xnjSW2bTtH5F9qj4O/1PjIJjbstVhsC3doFd1WatekQZe+McDkwi2
         8g2A==
X-Gm-Message-State: AOJu0YwLbYFWGiZI+EkGyh3ddNUhXRALGNcU5WfoUAvd0xmvvZF5JVUp
	jmmtC/DaueCXBzQOq/6vChwFBEtovCc6+j4lMAx+JzfGmhMq9nEauUnebWrP8il5F3PBt2i6a14
	tvJWrnxeHvg==
X-Google-Smtp-Source: AGHT+IF6dKcQlqg2xiUsUHwOzLzUrL6rHfDAPURD12rdPq+w2hhqUJ043iIhFDIekNSuTETP02P8lEgoxc9auw==
X-Received: from qtqf22.prod.google.com ([2002:ac8:4996:0:b0:467:8f83:cafe])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1b92:b0:45d:9357:1cca with SMTP id d75a77b69052e-46e12a554a6mr369943781cf.14.1737568966114;
 Wed, 22 Jan 2025 10:02:46 -0800 (PST)
Date: Wed, 22 Jan 2025 18:02:44 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <20250122180244.1861468-1-edumazet@google.com>
Subject: [PATCH net] net: rose: fix timer races against user threads
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

Rose timers only acquire the socket spinlock, without
checking if the socket is owned by one user thread.

Add a check and rearm the timers if needed.

BUG: KASAN: slab-use-after-free in rose_timer_expiry+0x31d/0x360 net/rose/rose_timer.c:174
Read of size 2 at addr ffff88802f09b82a by task swapper/0/0

CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.13.0-rc5-syzkaller-00172-gd1bf27c4e176 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <IRQ>
  __dump_stack lib/dump_stack.c:94 [inline]
  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
  print_address_description mm/kasan/report.c:378 [inline]
  print_report+0x169/0x550 mm/kasan/report.c:489
  kasan_report+0x143/0x180 mm/kasan/report.c:602
  rose_timer_expiry+0x31d/0x360 net/rose/rose_timer.c:174
  call_timer_fn+0x187/0x650 kernel/time/timer.c:1793
  expire_timers kernel/time/timer.c:1844 [inline]
  __run_timers kernel/time/timer.c:2418 [inline]
  __run_timer_base+0x66a/0x8e0 kernel/time/timer.c:2430
  run_timer_base kernel/time/timer.c:2439 [inline]
  run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2449
  handle_softirqs+0x2d4/0x9b0 kernel/softirq.c:561
  __do_softirq kernel/softirq.c:595 [inline]
  invoke_softirq kernel/softirq.c:435 [inline]
  __irq_exit_rcu+0xf7/0x220 kernel/softirq.c:662
  irq_exit_rcu+0x9/0x30 kernel/softirq.c:678
  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
  sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/rose/rose_timer.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/rose/rose_timer.c b/net/rose/rose_timer.c
index f06ddbed3fed6396b4ea510a29bb9f8025cfb35..1525773e94aa175dd2b73b27314259da0f1dc23 100644
--- a/net/rose/rose_timer.c
+++ b/net/rose/rose_timer.c
@@ -122,6 +122,10 @@ static void rose_heartbeat_expiry(struct timer_list *t)
 	struct rose_sock *rose = rose_sk(sk);
 
 	bh_lock_sock(sk);
+	if (sock_owned_by_user(sk)) {
+		sk_reset_timer(sk, &sk->sk_timer, jiffies + HZ/20);
+		goto out;
+	}
 	switch (rose->state) {
 	case ROSE_STATE_0:
 		/* Magic here: If we listen() and a new link dies before it
@@ -152,6 +156,7 @@ static void rose_heartbeat_expiry(struct timer_list *t)
 	}
 
 	rose_start_heartbeat(sk);
+out:
 	bh_unlock_sock(sk);
 	sock_put(sk);
 }
@@ -162,6 +167,10 @@ static void rose_timer_expiry(struct timer_list *t)
 	struct sock *sk = &rose->sock;
 
 	bh_lock_sock(sk);
+	if (sock_owned_by_user(sk)) {
+		sk_reset_timer(sk, &rose->timer, jiffies + HZ/20);
+		goto out;
+	}
 	switch (rose->state) {
 	case ROSE_STATE_1:	/* T1 */
 	case ROSE_STATE_4:	/* T2 */
@@ -182,6 +191,7 @@ static void rose_timer_expiry(struct timer_list *t)
 		}
 		break;
 	}
+out:
 	bh_unlock_sock(sk);
 	sock_put(sk);
 }
@@ -192,6 +202,10 @@ static void rose_idletimer_expiry(struct timer_list *t)
 	struct sock *sk = &rose->sock;
 
 	bh_lock_sock(sk);
+	if (sock_owned_by_user(sk)) {
+		sk_reset_timer(sk, &rose->idletimer, jiffies + HZ/20);
+		goto out;
+	}
 	rose_clear_queues(sk);
 
 	rose_write_internal(sk, ROSE_CLEAR_REQUEST);
@@ -207,6 +221,7 @@ static void rose_idletimer_expiry(struct timer_list *t)
 		sk->sk_state_change(sk);
 		sock_set_flag(sk, SOCK_DEAD);
 	}
+out:
 	bh_unlock_sock(sk);
 	sock_put(sk);
 }
-- 
2.48.1.262.g85cc9f2d1e-goog


