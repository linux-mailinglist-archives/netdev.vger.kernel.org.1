Return-Path: <netdev+bounces-178267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACEFA7630B
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 11:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F24441886BBD
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 09:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC461D514E;
	Mon, 31 Mar 2025 09:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NL2Xrj3Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B75C1D9A49
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 09:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743412537; cv=none; b=KLEKwEE/AbX7Ual5Tvs/my75qTB/s/xxPNgNxx/A/M5bJZe2Zy4UOgwIBYVaVBUz8XqFgTSKSEdOM8qLalI7bZLGIsGOCU28wCns0fuzy9tqsB28P3jIOW5UfVVY3T1+SDn1BM5mau9Zfxwvk9/D7W7Vy/KzeMebq3TqMPdZQoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743412537; c=relaxed/simple;
	bh=CQPY5VxiDBEgi4tu6cboxEXWR3tyag6sStDa99YECHc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uWRjZFFcT8BfCziYfLAdXtuqoYE6pq8rcizgNBG1Exyvx26r+iYBXZGJT6BwHL7Z8n6/rrziX06XTUiCWltX9j5rjdyqrwXHPR47XygvaSbr/N6KEX7tdSxEFVA6cRwjTFRTe/I/XWR/w4UztkBWD2Z+M1pPw9ACAtSUt/XQmX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NL2Xrj3Z; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4768656f608so82536151cf.1
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 02:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743412535; x=1744017335; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/blKLNDJU/cGHs2eqtD1mYEr0Fi5V7Cqf09o8toXta0=;
        b=NL2Xrj3ZizPBXNdYHelZx/D+JGNmXblurVtUoNblEZyx9AnS62X3Y2xtNbVW21FUm6
         A4KF+gYoleLVGjGK8Ap9fGaT71X79sX5hd4halCkFoaJvkLRCoF/xbUSky1cpm36AeUn
         oaCBHZa6qN47uHo/9yC0om1n+6UH4td/VmNsYh4xzA3ex/pniAvbuQ3vN2DOdI1F1v0+
         CiU4K8JSkTsN0WWv2PIxQAdrH+hhwIVkYF09sJALtWN99xYcipCaMWNwB3bFzQtKXNo+
         +kqwBnDusgpUlmlgcq+c2Vgcts9JEVDlETQvtYmaEMzE8HYfVn3bKHYSm5Q5RoWk/geg
         d/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743412535; x=1744017335;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/blKLNDJU/cGHs2eqtD1mYEr0Fi5V7Cqf09o8toXta0=;
        b=tdl+uvYZA4aE0+iTPTrRDt2q++8SPfN9Km3kGCkaBq8Fj1VdBeoJ1UhRsi202nfPgj
         K4LBKM0WDNZg+QNuSYFgaC+xYcqtF18JrevatsKyviBXwZyUA3OX6IytPLGAw9SIXitT
         hXq5OtChAxhNW55w3jPo4vGiwVYKnFGKX8yUMbJwsRfiusZb68p5eSF5Tl4KOtYpz11z
         K6B+dT2G/xz/H7CyKOH68frMFcniXFCFffvR0cF60DjCheOii6kELx2DyHwjSzEqBpfG
         HXR7PPDEKesMeFb7misqRP82g28aZnxyLV6E4iotEMu+SV3UKxIUvcghtX6toh1LxrtL
         knhQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0G4yZbEIuwMmWwSJAvCNX9SDjbldDh+BQ8LKUkN8y6dWXscZEvvv3hFLXuc26ke79iiM3F14=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH213z6jizrEDHUfKSyOfsO35MaKVklPYHqo/TfUn1wgnQm+w5
	hBov5vFhYLxsOvZc/Jw++KbG2KhCc5HLD42MyRFsf+46MqSAUcMsbo7PgAf3lsY2txBYhswj58U
	oshMRKyQccw==
X-Google-Smtp-Source: AGHT+IF/o6Mym9D6wCC7EGjjwgYQjDtCvGgs0klInFYc+TJXlmE220Qsevd/WaHBJbRbqtFRMA414e7X9QK13w==
X-Received: from qtbcm24.prod.google.com ([2002:a05:622a:2518:b0:476:98af:20b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:448:b0:477:6c0e:d5b3 with SMTP id d75a77b69052e-477e4ae4075mr101417591cf.6.1743412535184;
 Mon, 31 Mar 2025 02:15:35 -0700 (PDT)
Date: Mon, 31 Mar 2025 09:15:32 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250331091532.224982-1-edumazet@google.com>
Subject: [PATCH net] sctp: add mutual exclusion in proc_sctp_do_udp_port()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+fae49d997eb56fa7c74d@syzkaller.appspotmail.com, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>
Content-Type: text/plain; charset="UTF-8"

We must serialize calls to sctp_udp_sock_stop() and sctp_udp_sock_start()
or risk a crash as syzbot reported:

Oops: general protection fault, probably for non-canonical address 0xdffffc000000000d: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000068-0x000000000000006f]
CPU: 1 UID: 0 PID: 6551 Comm: syz.1.44 Not tainted 6.14.0-syzkaller-g7f2ff7b62617 #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
 RIP: 0010:kernel_sock_shutdown+0x47/0x70 net/socket.c:3653
Call Trace:
 <TASK>
  udp_tunnel_sock_release+0x68/0x80 net/ipv4/udp_tunnel_core.c:181
  sctp_udp_sock_stop+0x71/0x160 net/sctp/protocol.c:930
  proc_sctp_do_udp_port+0x264/0x450 net/sctp/sysctl.c:553
  proc_sys_call_handler+0x3d0/0x5b0 fs/proc/proc_sysctl.c:601
  iter_file_splice_write+0x91c/0x1150 fs/splice.c:738
  do_splice_from fs/splice.c:935 [inline]
  direct_splice_actor+0x18f/0x6c0 fs/splice.c:1158
  splice_direct_to_actor+0x342/0xa30 fs/splice.c:1102
  do_splice_direct_actor fs/splice.c:1201 [inline]
  do_splice_direct+0x174/0x240 fs/splice.c:1227
  do_sendfile+0xafd/0xe50 fs/read_write.c:1368
  __do_sys_sendfile64 fs/read_write.c:1429 [inline]
  __se_sys_sendfile64 fs/read_write.c:1415 [inline]
  __x64_sys_sendfile64+0x1d8/0x220 fs/read_write.c:1415
  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]

Fixes: 046c052b475e ("sctp: enable udp tunneling socks")
Reported-by: syzbot+fae49d997eb56fa7c74d@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/67ea5c01.050a0220.1547ec.012b.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/sysctl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
index 8e1e97be4df79f3245e2bbbeb0a75841abc67f58..ee3eac338a9deef064f273e29bb59b057835d3f1 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -525,6 +525,8 @@ static int proc_sctp_do_auth(const struct ctl_table *ctl, int write,
 	return ret;
 }
 
+static DEFINE_MUTEX(sctp_sysctl_mutex);
+
 static int proc_sctp_do_udp_port(const struct ctl_table *ctl, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos)
 {
@@ -549,6 +551,7 @@ static int proc_sctp_do_udp_port(const struct ctl_table *ctl, int write,
 		if (new_value > max || new_value < min)
 			return -EINVAL;
 
+		mutex_lock(&sctp_sysctl_mutex);
 		net->sctp.udp_port = new_value;
 		sctp_udp_sock_stop(net);
 		if (new_value) {
@@ -561,6 +564,7 @@ static int proc_sctp_do_udp_port(const struct ctl_table *ctl, int write,
 		lock_sock(sk);
 		sctp_sk(sk)->udp_port = htons(net->sctp.udp_port);
 		release_sock(sk);
+		mutex_unlock(&sctp_sysctl_mutex);
 	}
 
 	return ret;
-- 
2.49.0.472.ge94155a9ec-goog


