Return-Path: <netdev+bounces-97800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9118CD501
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 15:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5248B281F0A
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 13:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588C813B5AF;
	Thu, 23 May 2024 13:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1vNrikzh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85701E520
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 13:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716471954; cv=none; b=cD2TRG6YuPEuHBjWPENDZ83qJ1AVV0825fW++2VibBwnzbBuPevpQ7WmZYUyvavgPP+75GxCA5PTn+z4QgNF7u+TJTozOneBeq6m96CX2/JmaV/KG2pRUubd9kAgXrU1mz1vlc9rl51uiNSdlSG5Hl3FX7NM8Dtii3Xo0YpO9Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716471954; c=relaxed/simple;
	bh=OzqQ7ZtWdDLUZJLHrbKbrWnY/Rdm+uHgPWDk46cJqDU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DUeuftJrF0T0lv8I3XHsrzzlTblgvTo7UQ8D44v2RgWhhonRnMwJNyOjXKMTs/noIP4mvItb0FSgxQUe7ho12vyP0Yhi1s57Ry+GBoOve4xau/Vae8pT+sUk/Xxl3JGMGg3VLf35/6Nq0novUb82eh11FsZysk/bXUVr1W2qvu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1vNrikzh; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-627751b5411so169921537b3.2
        for <netdev@vger.kernel.org>; Thu, 23 May 2024 06:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716471952; x=1717076752; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KxCDAEpMrYECfUC8qI4PiDnyUD/2qCgYje7o/4Qm36g=;
        b=1vNrikzhCYVVaFW9enJPASeas2hTJqfuMXcrhcgMKN4nh6f3Lax3Z+ALh4ydkK6Gb6
         Xa3gky5l9fnlo/PhJ7hQIUAcU0Ynp3in3ubPnvpE56OL/A1TREV092mejpMJPhjM4Uzz
         NwSzdBUlTKxVX0tAxA/Epe0oTyDhhL5n2KejktvY8HjTDI69mxtDt/KVNdkJwf4q28gb
         Q0cyj6NzDa9miSmrI9wWEb8qwa6bv2JMfx7LodwnViz95WjQyZyPiMzf3LutVWiDbWqO
         J+hwY2k9JVWO0CEpw+XWW5i11VYXdOs9iCh/EwRekBAScLRajrD588pZCAm8LNmqQ8M8
         WgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716471952; x=1717076752;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KxCDAEpMrYECfUC8qI4PiDnyUD/2qCgYje7o/4Qm36g=;
        b=wsZw3hEEoaiVN8PfL1QsWq0QD/dvLouMBSEJ9OQaaR46IgFPj03nsoIfjDE44isyeJ
         fQpJ3zk7nRDOEo+R8ML2Rphrct6sAjREblD7mnPqp7e1NTG/Bok8wWkweGQl28apoQN7
         Dm7CWxD0ZXNgzmha/2Gw3+BRPU/qazphZsa0KpD2aOGdLtjNkP8/LbJUOM2vuKQJXY1H
         bRvbeo9rU9Yvd8c3gPwk56FYbTsZUR72KQEo9zdak8KJFm7CXDTdcRzxP1RX4+Zt3Qtw
         cV/r9WYqM2hlyusX9do3+aARVp4GR1oQUQF8DjZ5nv3kJcC8UwDBFzNb1k6eqWDLk+jb
         69kg==
X-Forwarded-Encrypted: i=1; AJvYcCVAd2eOfKR1mg9NlL5sJ2474DMpDm+Z0BMfiajdt7XjEaU54TK2SuZUOWuINCrI1FXCZyv66GogvRu2Bym89lNs4r4gAe6r
X-Gm-Message-State: AOJu0YxQtpvm9T9e+vgl/fXDHeG3fJSuWVKnLEYot2zBuKwfMAJG6sKm
	Fz0H+6uhTYxBoiY70DAmynmcrgUv5r+WLvPJIwIR1o4q6o3dTlmbcl0cO7IJlZSco403dT0hioR
	NnacdIP8pGQ==
X-Google-Smtp-Source: AGHT+IFRzT5/iQMElp6VFjB3KdYwS2zksWgVtXT0GvOp9OpkSThhh/f7YS6/wLQmboVzoHGbU2OgWrgSGdoTIg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:72c:b0:df6:dc61:7877 with SMTP
 id 3f1490d57ef6-df6dc617ec2mr509011276.12.1716471951783; Thu, 23 May 2024
 06:45:51 -0700 (PDT)
Date: Thu, 23 May 2024 13:45:49 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240523134549.160106-1-edumazet@google.com>
Subject: [PATCH net] net/sched: taprio: fix duration_to_length()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>
Content-Type: text/plain; charset="UTF-8"

duration_to_length() is incorrectly using div_u64()
instead of div64_u64().

syzbot reported:

Oops: divide error: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 PID: 15391 Comm: syz-executor.0 Not tainted 6.9.0-syzkaller-08544-g4b377b4868ef #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
 RIP: 0010:div_u64_rem include/linux/math64.h:29 [inline]
 RIP: 0010:div_u64 include/linux/math64.h:130 [inline]
 RIP: 0010:duration_to_length net/sched/sch_taprio.c:259 [inline]
 RIP: 0010:taprio_update_queue_max_sdu+0x287/0x870 net/sched/sch_taprio.c:288
Code: be 08 00 00 00 e8 99 5b 6a f8 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 13 59 6a f8 48 8b 03 89 c1 48 89 e8 31 d2 <48> f7 f1 48 89 c5 48 83 7c 24 50 00 4c 8b 74 24 30 74 47 e8 c1 19
RSP: 0018:ffffc9000506eb38 EFLAGS: 00010246
RAX: 0000000000001f40 RBX: ffff88802f3562e0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff88802f3562e0
RBP: 0000000000001f40 R08: ffff88802f3562e7 R09: 1ffff11005e6ac5c
R10: dffffc0000000000 R11: ffffed1005e6ac5d R12: 00000000ffffffff
R13: dffffc0000000000 R14: ffff88801ef59400 R15: 00000000003f0008
FS:  00007fee340bf6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2c524000 CR3: 0000000024a52000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
  taprio_change+0x2dce/0x42d0 net/sched/sch_taprio.c:1911
  taprio_init+0x9da/0xc80 net/sched/sch_taprio.c:2112
  qdisc_create+0x9d4/0x11a0 net/sched/sch_api.c:1355
  tc_modify_qdisc+0xa26/0x1e40 net/sched/sch_api.c:1777
  rtnetlink_rcv_msg+0x89b/0x10d0 net/core/rtnetlink.c:6595
  netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2564
  netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
  netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
  netlink_sendmsg+0x8e1/0xcb0 net/netlink/af_netlink.c:1905
  sock_sendmsg_nosec net/socket.c:730 [inline]
  __sock_sendmsg+0x221/0x270 net/socket.c:745
  ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
  ___sys_sendmsg net/socket.c:2638 [inline]
  __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fee3327cee9

Fixes: fed87cc6718a ("net/sched: taprio: automatically calculate queueMaxSDU based on TC gate durations")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 net/sched/sch_taprio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 1ab17e8a72605385280fad9b7f656a6771236acc..827fb81fc63a098304bad198fadd4aed55d1fec4 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -256,7 +256,8 @@ static int length_to_duration(struct taprio_sched *q, int len)
 
 static int duration_to_length(struct taprio_sched *q, u64 duration)
 {
-	return div_u64(duration * PSEC_PER_NSEC, atomic64_read(&q->picos_per_byte));
+	return div64_u64(duration * PSEC_PER_NSEC,
+			 atomic64_read(&q->picos_per_byte));
 }
 
 /* Sets sched->max_sdu[] and sched->max_frm_len[] to the minimum between the
-- 
2.45.1.288.g0e0cd299f1-goog


