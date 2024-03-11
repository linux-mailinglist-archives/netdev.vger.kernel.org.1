Return-Path: <netdev+bounces-79282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 076C88789AF
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 21:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85B3E1F21FA7
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 20:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01B0ECC;
	Mon, 11 Mar 2024 20:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ffglz4ic"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168265822B
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 20:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710189992; cv=none; b=pFWyAusKAB2ZZX57xbznKwYUNC3fQuHfY/IYZ/ND2gUiRatm9fbS22eMm12i1PMFsemZNBuGWU/6pG8+V7Bt+LSVNMTWCXspuSKQHutfADQijK49ChtjgGbe0bbKpvWzV1A2HGBssQE2XqP7mKmQAdM7PY/vhlCjcceLBv/OtB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710189992; c=relaxed/simple;
	bh=UbWy9e+PNQyeFX3q9kIwqcYW3th6KYxwaNtMihknwQM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bM5m2o26IS3fSI/8buS6A0anJiHviIqWI4uVGpJOT0ApyXlEGcq2U9V3+AaoWRgW8GKSpzgPuCeMkbQ7TCxfZw7+N9+QBGIHp4QBfXzpxSUZXhdJTnRoj7NluDx28R5A/azc2hDE9cYDwlvmaZ8IOz7ZFvm0djl7GAXciTapGCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ffglz4ic; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608e4171382so63635257b3.3
        for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 13:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710189990; x=1710794790; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+jNbJUe4yWHokSfi4dbAcuPI086CnyAV79S6P3F7hFc=;
        b=Ffglz4icMrLHlO3LTJ6daXREvGw6Zhqi1jnpz6XB9wESgfmtFKIZzAgvmh52OLKN2B
         /cePm/aXQWPGq4l95kLwY7DGM/vU00tBhG/TeWRqNj2oL2+zW5NRHL9MgZOYtncDnIe5
         ASzX4T3ehyJ6AHkoHF+MT+a1FBaIbbjqQZpLFPxpB4wy9ruFK1OnaJFxkl3p5pdqIFfs
         WHnWUaRcp9nNnZoeatH+YxyPAQD6ZB+sg8Wkz2/m36DncqnAyqU9QjlLVVrLe1jtbpSa
         gawlZvfsn0gZ18HEgC5l1DeLA4OQyBaOYyKTNMR8ZYR2xZEnvu7FBU2UaHz9kDPQmYvM
         /JTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710189990; x=1710794790;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+jNbJUe4yWHokSfi4dbAcuPI086CnyAV79S6P3F7hFc=;
        b=Z9AwUBuyLbhc49X9sgRHQ7TRHVo/x8Oz0j3hVEErpek1z7wa3VHF2uydUwcz7g2GI0
         7NAto1Rw2ysMRufNDpkXubIdxxoruQf9LnQtoqzw8xQLyy8o/lsVx6gDfp8IoA9TkK6e
         wW+ktpiwKXnYBWNIWpU/dMhXgCosTPSou7pi646T9+y7i7LoPeZvlPktxYsIK3Ql/XPm
         PtNTJrtaLi9Dkm9kns+vSD85wxpBFSwm5pdbeHp1VGR8iId79XLRSTZy5Eej29ANwuoh
         te7an8OAFHrHunzA8jJRkkEpC+xctVZc4vMLvWisXrDZZBCvQdnH9CNmaa1ldCyagycc
         ppCg==
X-Gm-Message-State: AOJu0YyQMbJ7gmFOaUorYbYmlA9eiCRz17vjFnpcZL3DNszqyyGIPoeo
	9BylFXWqF5wV/IAoAlRfWCQi9EcHxkTyWnIBOgbZUzj7QW1O3/OSbOYkOjqJtllKTWV5kun4EbQ
	rPlQnYmqadw==
X-Google-Smtp-Source: AGHT+IE/Q4P5LJUbearA3KGYPodr4ZGyJC25iUcRqRnBvSgxBAWRTAFxA5imay/CvddbF/aNUYgCsnXAJ51xtg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:c742:0:b0:dcc:4785:b51e with SMTP id
 w63-20020a25c742000000b00dcc4785b51emr63126ybe.12.1710189989987; Mon, 11 Mar
 2024 13:46:29 -0700 (PDT)
Date: Mon, 11 Mar 2024 20:46:28 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240311204628.43460-1-edumazet@google.com>
Subject: [PATCH net] net/sched: taprio: proper TCA_TAPRIO_TC_ENTRY_INDEX check
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+a340daa06412d6028918@syzkaller.appspotmail.com, 
	Vladimir Oltean <vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="UTF-8"

taprio_parse_tc_entry() is not correctly checking
TCA_TAPRIO_TC_ENTRY_INDEX attribute:

	int tc; // Signed value

	tc = nla_get_u32(tb[TCA_TAPRIO_TC_ENTRY_INDEX]);
	if (tc >= TC_QOPT_MAX_QUEUE) {
		NL_SET_ERR_MSG_MOD(extack, "TC entry index out of range");
		return -ERANGE;
	}

syzbot reported that it could fed arbitary negative values:

UBSAN: shift-out-of-bounds in net/sched/sch_taprio.c:1722:18
shift exponent -2147418108 is negative
CPU: 0 PID: 5066 Comm: syz-executor367 Not tainted 6.8.0-rc7-syzkaller-00136-gc8a5c731fd12 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Call Trace:
 <TASK>
  __dump_stack lib/dump_stack.c:88 [inline]
  dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
  ubsan_epilogue lib/ubsan.c:217 [inline]
  __ubsan_handle_shift_out_of_bounds+0x3c7/0x420 lib/ubsan.c:386
  taprio_parse_tc_entry net/sched/sch_taprio.c:1722 [inline]
  taprio_parse_tc_entries net/sched/sch_taprio.c:1768 [inline]
  taprio_change+0xb87/0x57d0 net/sched/sch_taprio.c:1877
  taprio_init+0x9da/0xc80 net/sched/sch_taprio.c:2134
  qdisc_create+0x9d4/0x1190 net/sched/sch_api.c:1355
  tc_modify_qdisc+0xa26/0x1e40 net/sched/sch_api.c:1776
  rtnetlink_rcv_msg+0x885/0x1040 net/core/rtnetlink.c:6617
  netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2543
  netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
  netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1367
  netlink_sendmsg+0xa3b/0xd70 net/netlink/af_netlink.c:1908
  sock_sendmsg_nosec net/socket.c:730 [inline]
  __sock_sendmsg+0x221/0x270 net/socket.c:745
  ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
  ___sys_sendmsg net/socket.c:2638 [inline]
  __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f1b2dea3759
Code: 48 83 c4 28 c3 e8 d7 19 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd4de452f8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f1b2def0390 RCX: 00007f1b2dea3759
RDX: 0000000000000000 RSI: 00000000200007c0 RDI: 0000000000000004
RBP: 0000000000000003 R08: 0000555500000000 R09: 0000555500000000
R10: 0000555500000000 R11: 0000000000000246 R12: 00007ffd4de45340
R13: 00007ffd4de45310 R14: 0000000000000001 R15: 00007ffd4de45340

Fixes: a54fc09e4cba ("net/sched: taprio: allow user input of per-tc max SDU")
Reported-and-tested-by: syzbot+a340daa06412d6028918@syzkaller.appspotmail.com
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/sched/sch_taprio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 31a8252bd09c9111090f0147df6deb0ad81577af..ad99409c6325e179319f8ec4053582417a978817 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1008,7 +1008,8 @@ static const struct nla_policy entry_policy[TCA_TAPRIO_SCHED_ENTRY_MAX + 1] = {
 };
 
 static const struct nla_policy taprio_tc_policy[TCA_TAPRIO_TC_ENTRY_MAX + 1] = {
-	[TCA_TAPRIO_TC_ENTRY_INDEX]	   = { .type = NLA_U32 },
+	[TCA_TAPRIO_TC_ENTRY_INDEX]	   = NLA_POLICY_MAX(NLA_U32,
+							    TC_QOPT_MAX_QUEUE),
 	[TCA_TAPRIO_TC_ENTRY_MAX_SDU]	   = { .type = NLA_U32 },
 	[TCA_TAPRIO_TC_ENTRY_FP]	   = NLA_POLICY_RANGE(NLA_U32,
 							      TC_FP_EXPRESS,
-- 
2.44.0.278.ge034bb2e1d-goog


