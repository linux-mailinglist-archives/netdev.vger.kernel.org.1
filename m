Return-Path: <netdev+bounces-244479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A63CB89F6
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 11:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1EC3E30115AA
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 10:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F9B314A67;
	Fri, 12 Dec 2025 10:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="cXfUbfUM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4533168F2
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 10:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765535398; cv=none; b=l0MGaFSljPINt/vPpD3ugRc0fbYWLBLago89JAhN5blkEt0qe8cbue/OTN1ZBK5m/CUTwK5g4xXydgjQPtb8rCkTLofVEd1la1rYOlmO4dwgEZ8tWvqlcsO7hbqnAvwf/7L2ApqFIM8sTxNot02MbF9ZJ8a1iRDZ1TGK76vg/js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765535398; c=relaxed/simple;
	bh=btbqvPGFse/taUiYClETwKgL9QrmsUUJmU/97AwopB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FGVH1UkyfYU3kYWyfscM3J1XGwTI29XqJ+V98/ZjXQdzfi6dfY99qjWJzXlxPX8x+6KdBh4R8ZKBbUJSynR9JFiEyscI7UJ2fzScctGYYA5KrZ/CqreOK7LsBLWuKzDhV1ASCwO8d1jUmCysNe0VULDy3LtGX/EO28Csm03kaDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=cXfUbfUM; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so8178105e9.0
        for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 02:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1765535394; x=1766140194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6tFE0a1pHgT0unxzOi6yQRChV8EFDCDkCPGE+hNyUTU=;
        b=cXfUbfUMgTFUnup7NsqNbA0g1zvoMQ0XC3pNGp4KQHbVyRwdqYLgnU0YChax3jFLHk
         kd9QyUkDG0Hg6MeFwMJv8t3MfD4IkuLcsul2WBDPFPwYCdqylTJ5Xiuw4Lr1bG/VKf2r
         7c7BqjxCHWiiidtKKCoXUWH1DC0oXg4TjMbUN0H+kyvsou3MX/8ZXgfwJx2Dql6Ut0mJ
         p3NgK5hsak1pHdpfPIuJWxbwOUrcPMmyDd2mpxeZ5+lxj+cYLkD0ytRRLQgRY9b6L5SK
         sqxJhnxjUZfzUUoNYO/tH6OH6i4gNyMjRb/nwGDYV8dAFamgKlUjuFvDsUjUcxECCwTD
         aD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765535394; x=1766140194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6tFE0a1pHgT0unxzOi6yQRChV8EFDCDkCPGE+hNyUTU=;
        b=L2uG4SQbS5cAQuQDSaqRhgJVAKQLCn9Mj+u8rPzX++r2QbaHjaHOJqWhdMats0CTt9
         r0LR11ts8xUBXoyVlX4W0LQv6OvDnatFS5J2VQH1oW7oxitnSSPEinkpkyBbOBJA9Afq
         fef+XyCPsrqqSuhFMxt26jefDndNpwSjW8zO5ei7CH1jDCPbeLWUuu1YJo/eSN9Jffpq
         4Hc8rZkvbm7Tg0gFk8R3BwFHTK7RDY9cq0KYXum2/wNfpsn5JRdjzwTM3O8iMYlG/bPd
         d3MLQYEDj7g/u0Rt29csoCVepv45M/7brUguTVC8mufuvruJRNMY1IpUggZRN9Y5N6zp
         beMQ==
X-Gm-Message-State: AOJu0YxgOH2jnAJBSyNUduJo6PaL5HBNub8p8X3tSn7HBuibLCbNP757
	fDXd1lB93mFMXY2X3PCC8fcQWswPzy2KBD9cNkWdsI7dmWmAgUfHqIPhuN6EjRCXYB6oNHi3mrf
	GbvDo
X-Gm-Gg: AY/fxX42QbFz4THZ8M4O7Z47zrhYwoNdq1x4K2S2ztqyyyigdy9CCEBsTATs+P9JTNu
	AeupQfXKeyotwJz3kyzKP6byv2+f2YCWSjHplI7V9STwVNOqUhyaiFLvSy/pj7jyRISyrSQchAH
	cEdP4uEpEvKVFlwjQVU4FHMA7sR3Si9YoU46gxEcskiY64REQqd7bujVZO5zgpUgXZCYns3bi1X
	pAwuZujLopYPdAXue1g81C/eP38IXmtuLpN0iSPWmNiMdyHRFjKdtmMxF8rHAHojthuG5XfkbiH
	XdTLX1LMrK7K/opU13vcx+Yzm0OJQvBCVpRRoNHNKOnquDuDL+ADkbvmeq4FXwMk4N5uzIjxidY
	KpDsiYKtXzcJ7N4mrzF21QR3w0BYXQLM+jm4oGJiB5XcOdpubyI0muYRjbdTJQ48N37ogxtVAgW
	F9gQ==
X-Google-Smtp-Source: AGHT+IE22uoCLDBuRYBWBxPuOxfjJ/s/N02cbjGaLd2SRwZ4tJ/TD+mGnwYlEC7795mvkbTuTgHkmA==
X-Received: by 2002:a05:600c:8115:b0:477:8b77:155f with SMTP id 5b1f17b1804b1-47a8f8a80eemr14822045e9.8.1765535394360;
        Fri, 12 Dec 2025 02:29:54 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8a665e3sm11423088f8f.6.2025.12.12.02.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 02:29:53 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	dharanitharan725@gmail.com
Subject: [PATCH net] team: fix check for port enabled in team_queue_override_port_prio_changed()
Date: Fri, 12 Dec 2025 11:29:53 +0100
Message-ID: <20251212102953.167287-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

There has been a syzkaller bug reported recently with the following
trace:

list_del corruption, ffff888058bea080->prev is LIST_POISON2 (dead000000000122)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:59!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 3 UID: 0 PID: 21246 Comm: syz.0.2928 Not tainted syzkaller #0 PREEMPT(full)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__list_del_entry_valid_or_report+0x13e/0x200 lib/list_debug.c:59
Code: 48 c7 c7 e0 71 f0 8b e8 30 08 ef fc 90 0f 0b 48 89 ef e8 a5 02 55 fd 48 89 ea 48 89 de 48 c7 c7 40 72 f0 8b e8 13 08 ef fc 90 <0f> 0b 48 89 ef e8 88 02 55 fd 48 89 ea 48 b8 00 00 00 00 00 fc ff
RSP: 0018:ffffc9000d49f370 EFLAGS: 00010286
RAX: 000000000000004e RBX: ffff888058bea080 RCX: ffffc9002817d000
RDX: 0000000000000000 RSI: ffffffff819becc6 RDI: 0000000000000005
RBP: dead000000000122 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: ffff888039e9c230
R13: ffff888058bea088 R14: ffff888058bea080 R15: ffff888055461480
FS:  00007fbbcfe6f6c0(0000) GS:ffff8880d6d0a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c3afcb0 CR3: 00000000382c7000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 __list_del_entry_valid include/linux/list.h:132 [inline]
 __list_del_entry include/linux/list.h:223 [inline]
 list_del_rcu include/linux/rculist.h:178 [inline]
 __team_queue_override_port_del drivers/net/team/team_core.c:826 [inline]
 __team_queue_override_port_del drivers/net/team/team_core.c:821 [inline]
 team_queue_override_port_prio_changed drivers/net/team/team_core.c:883 [inline]
 team_priority_option_set+0x171/0x2f0 drivers/net/team/team_core.c:1534
 team_option_set drivers/net/team/team_core.c:376 [inline]
 team_nl_options_set_doit+0x8ae/0xe60 drivers/net/team/team_core.c:2653
 genl_family_rcv_msg_doit+0x209/0x2f0 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x55c/0x800 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2552
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x5aa/0x870 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x8c8/0xdd0 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0xa98/0xc70 net/socket.c:2630
 ___sys_sendmsg+0x134/0x1d0 net/socket.c:2684
 __sys_sendmsg+0x16d/0x220 net/socket.c:2716
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The problem is in this flow:
1) Port is enabled, queue_id != 0, in qom_list
2) Port gets disabled
        -> team_port_disable()
        -> team_queue_override_port_del()
        -> del (removed from list)
3) Port is disabled, queue_id != 0, not in any list
4) Priority changes
        -> team_queue_override_port_prio_changed()
        -> checks: port disabled && queue_id != 0
        -> calls del - hits the BUG as it is removed already

To fix this, change the check in team_queue_override_port_prio_changed()
so it returns early if port is not enabled.

Reported-by: syzbot+422806e5f4cce722a71f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=422806e5f4cce722a71f
Fixes: 6c31ff366c11 ("team: remove synchronize_rcu() called during queue override change")
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/team/team_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 4d5c9ae8f221..c08a5c1bd6e4 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -878,7 +878,7 @@ static void __team_queue_override_enabled_check(struct team *team)
 static void team_queue_override_port_prio_changed(struct team *team,
 						  struct team_port *port)
 {
-	if (!port->queue_id || team_port_enabled(port))
+	if (!port->queue_id || !team_port_enabled(port))
 		return;
 	__team_queue_override_port_del(team, port);
 	__team_queue_override_port_add(team, port);
-- 
2.51.1


