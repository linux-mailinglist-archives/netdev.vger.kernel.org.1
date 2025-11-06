Return-Path: <netdev+bounces-236266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D98A0C3A7E0
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 12:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A6A2C500545
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 11:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046E72D9EEA;
	Thu,  6 Nov 2025 11:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d9haBjz4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B072E36F4
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 11:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427458; cv=none; b=i8+YXSU1rS8uIFvCv0zkZhQmIym/hoVOkBfpCkTZBPJzLtHY1a1ZHDJVESCq1YRaz0o3EXT2T1j2XiSXQme5d3VpHgSX2oa/Jgc4fM86MzHglk0HhYtEBUe+sixGOA1GIXA2+Vc+upIrbFa61srN+gvFfWL/u55fXj6/cpL59E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427458; c=relaxed/simple;
	bh=tAI8Q2VQOP1M0t9cojCav7iOanc94w70F3EoQQif6F8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hAPMErKPbzZm0cHaXz+umwrAFEoPn9DWJUjq+i/CTwL2JA7VyS1D9SPPxmTCgTvlunyfiMkUEerJgsX1LpFsnTKStSfxhcJT9BmR298tMzZec1dZIZ6sYVco3iIrlrU5kbBFVbuCNU6yeKXBGWDXVrqx+deKg/FYyOxjJHZu9kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d9haBjz4; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-88022ad6eb3so11912876d6.2
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 03:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762427456; x=1763032256; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AJh9nlvIb1NUYusHvALs3oLC3pLWQsHRGhFBXTcThlI=;
        b=d9haBjz40jSYStnv0+W11F4YELt4wzPBM7jkIB54zcS4BgYWhzmRbc8L15ceBHJiud
         qaYkZUvs3VkKJn9i264pOKGWKDk8r0eRLydaryzawkkAsYVfKZ5kkzmUTY/IyKKYZYF3
         r6hcnOodcGkRagG/y/zQ4rfn736HXZoGSwQqk3PIlOHGTgSb0JP1TSVIvKW0nDIyoT2V
         wfh/nAW0TNP6UCgZ1zPTOjeRNrHwzAJd2RfcFiKWaOs/ExlZK/xBnwpIsk4aFe/ZmCM5
         vb4t5tlwWR4F2VfPxwT8xVdxrC/9AZ6WEwFvLb4CJKsu1+jywo4fan0UpD5h6S5ikz/a
         svLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762427456; x=1763032256;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AJh9nlvIb1NUYusHvALs3oLC3pLWQsHRGhFBXTcThlI=;
        b=CYwlXKk2CLgqzFByrRz4u4i+a8Qgwsc1VUNZj+9UzaUyrV5x/a3fNUdJ5B2p7oaK2t
         i28Jwjyhor+j0ubJEewWGL92QXMWKwiLY29XS/o4sTa585Z3AJt39vMbnvBFL0t7WJvc
         4mJimOAEUyFKvcNaHeoswMovUdCJG5R9u+zrRGqeXH7bulyatNV18zdqyE1kijlVFlFc
         5ZPMdPxUGsxorZ/zeS0Q1zF7aXOBnZq1aELbHplj816Mbz0c4afIvf+UlBZbKPEC2MsQ
         knCUlwbqXBvSzHSvwOOxbLXNujvq+hQkWCjSlGz6sEfH8Dhx8NzD5GF0QmMsV5NtzCGx
         41WA==
X-Forwarded-Encrypted: i=1; AJvYcCX0WezhnDPZqbb7hvPuNjB9tnpBdEs0zpqFJYJ/ynKilDly8TH9AEvnJ2YG83Lxt2Y2N0QrwfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI6vl4pOQWXT+sqd+JEHIGvTquXKbikj6iOktopNLTZLp7dzxU
	neOwvgGprpb3jEzeU6NUhOdoCjGUkjEUATPTEVg0safhyd6dJ2PahhTVPj2e2aSSpU5W6NEAuxq
	sRJ5lN6vLajjv1w==
X-Google-Smtp-Source: AGHT+IGVo7/dDVCuJA3dc6A+9VeI8XnelyInDICd+gSfqcJmcsuYAeFhzdnTzqFeRuzFiIyMDc8EqILvXjLSMg==
X-Received: from qvbmu9.prod.google.com ([2002:a05:6214:3289:b0:880:2244:8a90])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5fc9:0:b0:880:4c01:ef16 with SMTP id 6a1803df08f44-8807112a291mr76202786d6.8.1762427456172;
 Thu, 06 Nov 2025 03:10:56 -0800 (PST)
Date: Thu,  6 Nov 2025 11:10:54 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1026.g39e6a42477-goog
Message-ID: <20251106111054.3288127-1-edumazet@google.com>
Subject: [PATCH net] sctp: prevent possible shift-out-of-bounds in sctp_transport_update_rto
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Xin Long <lucien.xin@gmail.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+f8c46c8b2b7f6e076e99@syzkaller.appspotmail.com, 
	Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"

syzbot reported a possible shift-out-of-bounds [1]

Blamed commit added rto_alpha_max and rto_beta_max set to 1000.

It is unclear if some sctp users are setting very large rto_alpha
and/or rto_beta.

In order to prevent user regression, perform the test at run time.

Also add READ_ONCE() annotations as sysctl values can change under us.

[1]

UBSAN: shift-out-of-bounds in net/sctp/transport.c:509:41
shift exponent 64 is too large for 32-bit type 'unsigned int'
CPU: 0 UID: 0 PID: 16704 Comm: syz.2.2320 Not tainted syzkaller #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <TASK>
  __dump_stack lib/dump_stack.c:94 [inline]
  dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
  ubsan_epilogue lib/ubsan.c:233 [inline]
  __ubsan_handle_shift_out_of_bounds+0x27f/0x420 lib/ubsan.c:494
  sctp_transport_update_rto.cold+0x1c/0x34b net/sctp/transport.c:509
  sctp_check_transmitted+0x11c4/0x1c30 net/sctp/outqueue.c:1502
  sctp_outq_sack+0x4ef/0x1b20 net/sctp/outqueue.c:1338
  sctp_cmd_process_sack net/sctp/sm_sideeffect.c:840 [inline]
  sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1372 [inline]

Fixes: b58537a1f562 ("net: sctp: fix permissions for rto_alpha and rto_beta knobs")
Reported-by: syzbot+f8c46c8b2b7f6e076e99@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/690c81ae.050a0220.3d0d33.014e.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
---
 net/sctp/transport.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/sctp/transport.c b/net/sctp/transport.c
index 0d48c61fe6adefc1a9c56ca1b8ab00072825d9e6..0c56d9673cc137e3f1a64311e79bd41db2cb1282 100644
--- a/net/sctp/transport.c
+++ b/net/sctp/transport.c
@@ -486,6 +486,7 @@ void sctp_transport_update_rto(struct sctp_transport *tp, __u32 rtt)
 
 	if (tp->rttvar || tp->srtt) {
 		struct net *net = tp->asoc->base.net;
+		unsigned int rto_beta, rto_alpha;
 		/* 6.3.1 C3) When a new RTT measurement R' is made, set
 		 * RTTVAR <- (1 - RTO.Beta) * RTTVAR + RTO.Beta * |SRTT - R'|
 		 * SRTT <- (1 - RTO.Alpha) * SRTT + RTO.Alpha * R'
@@ -497,10 +498,14 @@ void sctp_transport_update_rto(struct sctp_transport *tp, __u32 rtt)
 		 * For example, assuming the default value of RTO.Alpha of
 		 * 1/8, rto_alpha would be expressed as 3.
 		 */
-		tp->rttvar = tp->rttvar - (tp->rttvar >> net->sctp.rto_beta)
-			+ (((__u32)abs((__s64)tp->srtt - (__s64)rtt)) >> net->sctp.rto_beta);
-		tp->srtt = tp->srtt - (tp->srtt >> net->sctp.rto_alpha)
-			+ (rtt >> net->sctp.rto_alpha);
+		rto_beta = READ_ONCE(net->sctp.rto_beta);
+		if (rto_beta < 32)
+			tp->rttvar = tp->rttvar - (tp->rttvar >> rto_beta)
+				+ (((__u32)abs((__s64)tp->srtt - (__s64)rtt)) >> rto_beta);
+		rto_alpha = READ_ONCE(net->sctp.rto_alpha);
+		if (rto_alpha < 32)
+			tp->srtt = tp->srtt - (tp->srtt >> rto_alpha)
+				+ (rtt >> rto_alpha);
 	} else {
 		/* 6.3.1 C2) When the first RTT measurement R is made, set
 		 * SRTT <- R, RTTVAR <- R/2.
-- 
2.51.2.1026.g39e6a42477-goog


