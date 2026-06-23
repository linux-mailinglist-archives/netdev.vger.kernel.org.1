Return-Path: <netdev+bounces-301383-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EapfAbCQOmryAAgAu9opvQ
	(envelope-from <netdev+bounces-301383-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 15:57:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B0B6B7AA2
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 15:57:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bynar.io header.s=google header.b=HQVR9AA4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301383-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301383-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bynar.io;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B285930941EE
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 13:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBDB37EFF0;
	Tue, 23 Jun 2026 13:55:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A585637DEB2
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 13:55:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782222910; cv=none; b=HbH7RxJ/V6yGnT7Wwr0n/p/kOsJEsX2E/1GvvVoTeaUOSWLtJHIklFZQE85lTjfbAm5YsZMwy0nQ729rAPi/FssqGfne3tZdB6IeByOY6GWuAPGKQaiAWzjiWXDvL8H+ZYsVcgh9ELFMQB9AAbv/yo8QeAEWkyLl5XweQM/vnGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782222910; c=relaxed/simple;
	bh=qM2dMH49/Ul0x9msAr/GEBJZsleQiGJNrZBlH/mQLuo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JXIEXu9FJGlQIZ2ZJuDGNs84IGKujt0bvwgf648u7A3VBRurQE5MWEPqfyzHVC1zkI1shF5OKacg9hTHIfzswRmw3Vvg15VWO+tZIImWo0i9HHb2gIW4z7s/6k75Rj8VJggApfSS1+e2HL9KhNwvWWu/11CU/rTuiZTb4h3LS3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bynar.io; spf=pass smtp.mailfrom=bynar.io; dkim=pass (2048-bit key) header.d=bynar.io header.i=@bynar.io header.b=HQVR9AA4; arc=none smtp.client-ip=209.85.218.44
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c07ea058c1aso46156166b.2
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 06:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bynar.io; s=google; t=1782222907; x=1782827707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PQBuHD6hzcpoFNovRalWspwnCRbO3HNmQu7ubyUULa4=;
        b=HQVR9AA4peIrv+fknJeq9M1QZUNte72kPXnlUxzx0ODpUf3cGjfWXEgZ7d4uZO2RF8
         LkQESZOvcUpm9mO0xyqdqK91t2KHmaJHgMjydDSXeGv/7XCxKkt1whyiJ/5269mesWh7
         eo/iAvH9ksGdGrFIqrk7VIOtjymBGx0tOk7wCqpZMJpjx+OHA5Mc7Mh7DWwa/U9DOTd7
         W9NZ/yhxDRxS2hnW1rlm+wSYgkcWPPc6AhNHozxFV9j/BFrvsT4u6Ud2T7Zw0uoeF3aO
         NFljifVVSMr4D2P36QArYFt5Sao22SHIkFDZNOUg/gwaSTmoQiz2rNfIxe71lMumRNwS
         huzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782222907; x=1782827707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQBuHD6hzcpoFNovRalWspwnCRbO3HNmQu7ubyUULa4=;
        b=APTPyk9AUhhPtVo1QbeHJOi+P9VYtRTN4dN77rOxVh5fv0IOyWcWjsb+1inOU1Y5wk
         DDeToYC/pnYDAzwxvILPx8dIHyggh4nZb0N5KUBIvYOORfLSkgYCcAUfUMjBh4tKIy1f
         D+5il0ifw4w9u1mLHYM7nfZSa7Z1SwtFLoj2y+S3P8vAuxox/B3PDBpFTAkTownqn2RL
         OiAGrnRPI4X7GRvrbvuty8uVZzo0WamD2QDf+v0gNb/tD1u66rDPAbgN79+GYuo+FEaf
         gdn7bzLmqxs9hNmDSoDbf9RZhaZDwVOQYZr1kTz4v1lQx/fbykz7BvnlqPLfyh3gUqDl
         nmPw==
X-Forwarded-Encrypted: i=1; AFNElJ8s0LaYJyEsAYfbQUJiH1xHU2w2ngHhMA7oxHD3u1Y/ei4dBcVAkNACTDO1NM6FAbIMtWqXxHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPMcbYEMtjqzaBDO9Ft+OYsf4+jKz05kcf3pjoNFTSQEYjVLQZ
	Ss2wu+PQP0kL5iIe/Rf9QvGVx2kqaH2Pt0HXjXSSo8KhSwWn1R4UedHQq1mEZWgkrRtb
X-Gm-Gg: AfdE7ckSpevG84QGJuDR3UKxu0ff3l1GFMWup/Mrevv5X4eJaKuJnU23fSG0rJEBIEB
	zmjt1DASC9d31gylpmwt5r1vqCfMihR4h9TD+hC3BxT5k3HYB7ErbHXK0D8hOZstpbnvc9ZEVmr
	Yv4dYNNTQ9n3a0wjLbaDllvv5LWcfl0/IjgkSFmhGPqH84omLkYfpkGgvrXdTRe4xXqTTfxfy2j
	lhsSIbXKNOPfX8T8JIPCnW9kyIQ5yEqFo/YkPXQch7BjlKn4pjY+i8dvyhyEMQQm0Fd9T8/5X/N
	uygmD/cHEXDTTnUhtS47PYGpRNY45LqR0F3f9XjHBLEErBNQcjXxfpyTINwY67Jt8F3I5wyOaBk
	CReiEqqb9kCX4y3eld/s1lQGmW6wn7s7pk6btLkziWf5HSctrFj2TrtopJmeEUfUQ5qJGBo007g
	7V
X-Received: by 2002:a17:907:d86:b0:c08:dc83:b4f0 with SMTP id a640c23a62f3a-c108cdfb558mr150142766b.9.1782222906643;
        Tue, 23 Jun 2026 06:55:06 -0700 (PDT)
Received: from localhost ([2a06:61c2:d427:0:b321:1c7a:b072:326e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c60ac8284sm538307866b.34.2026.06.23.06.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 06:55:06 -0700 (PDT)
From: Samuel Page <sam@bynar.io>
To: Jon Maloy <jmaloy@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Samuel Page <sam@bynar.io>
Subject: [PATCH net] tipc: fix out-of-bounds read in broadcast Gap ACK blocks
Date: Tue, 23 Jun 2026 15:54:43 +0200
Message-ID: <20260623135443.3662041-1-sam@bynar.io>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[bynar.io,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bynar.io:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301383-lists,netdev=lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[sam@bynar.io,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:tung.quang.nguyen@est.tech,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:sam@bynar.io,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam@bynar.io,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[bynar.io:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,bynar.io:dkim,bynar.io:email,bynar.io:mid,bynar.io:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 39B0B6B7AA2

A broadcast PROTOCOL/STATE_MSG can carry a Gap ACK blocks record in its
data area. tipc_get_gap_ack_blks() only verifies that the record's len
field is self-consistent with its ugack_cnt/bgack_cnt counts
(sz == struct_size(p, gacks, ugack_cnt + bgack_cnt)); it does not check
that the record actually fits in the message data area, msg_data_sz().

The unicast caller tipc_link_proto_rcv() bounds it ("if (glen > dlen)
break;"), but the broadcast caller tipc_bcast_sync_rcv() discards the
returned size, so tipc_link_advance_transmq() copies the record off the
receive skb with an attacker-controlled count:

	this_ga = kmemdup(ga, struct_size(ga, gacks, ga->bgack_cnt),
			  GFP_ATOMIC);

A TIPC neighbour that negotiated TIPC_GAP_ACK_BLOCK triggers it with one
ordinary broadcast STATE_MSG (msg_bc_ack_invalid() clear), sized so its
data area is short, carrying a Gap ACK record with len = 0x400,
bgack_cnt = 0xff and ugack_cnt = 0. len then equals
struct_size(p, gacks, 255), so the consistency check passes and ga is
non-NULL; kmemdup() reads struct_size(ga, gacks, 255) = 1024 bytes out
of the much smaller skb:

  BUG: KASAN: slab-out-of-bounds in kmemdup_noprof+0x48/0x60
  Read of size 1024 at addr ffff0000c7030d38 by task poc864/69
  Call trace:
   kmemdup_noprof+0x48/0x60
   tipc_link_advance_transmq+0x86c/0xb80
   tipc_link_bc_ack_rcv+0x19c/0x1e0
   tipc_bcast_sync_rcv+0x1c4/0x2c4
   tipc_rcv+0x85c/0x1340
   tipc_l2_rcv_msg+0xac/0x104
  The buggy address belongs to the object at ffff0000c7030d00
   which belongs to the cache skbuff_small_head of size 704
  The buggy address is located 56 bytes inside of
   allocated 704-byte region [ffff0000c7030d00, ffff0000c7030fc0)

The copied-out bytes are subsequently consumed as gap/ack values, but
the read is already out of bounds at the kmemdup() regardless of how
they are used.

Apply the same bound the unicast path uses to the broadcast caller: drop
the Gap ACK blocks when the reported size exceeds the message data size.
A NULL ga is already the defined "no Gap ACK blocks" case, so well-formed
state messages are unaffected.

Fixes: d7626b5acff9 ("tipc: introduce Gap ACK blocks for broadcast link")
Cc: stable@vger.kernel.org
Assisted-by: Bynario AI
Signed-off-by: Samuel Page <sam@bynar.io>
---
Before posting I found an earlier thread for what looks like the same (or a
very closely related) issue:

  https://lore.kernel.org/netdev/1316452e465e9a96fce44ec15130a14f3872149f.1775809727.git.caoruide123@gmail.com/
  [PATCH net 1/1] tipc: validate Gap ACK blocks in STATE message

That one added the validation inside tipc_get_gap_ack_blks() and the thread
stalled on whether the extra checks were redundant. This patch instead adds,
on the broadcast caller, only the same bound the unicast path already applies,
and includes the KASAN reproducer that was asked for there. 

 net/tipc/bcast.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/tipc/bcast.c b/net/tipc/bcast.c
index 76a1585d3f6b..61c83bd95755 100644
--- a/net/tipc/bcast.c
+++ b/net/tipc/bcast.c
@@ -502,6 +502,7 @@ int tipc_bcast_sync_rcv(struct net *net, struct tipc_link *l,
 	struct sk_buff_head *inputq = &tipc_bc_base(net)->inputq;
 	struct tipc_gap_ack_blks *ga;
 	struct sk_buff_head xmitq;
+	u16 glen;
 	int rc = 0;
 
 	__skb_queue_head_init(&xmitq);
@@ -510,7 +511,10 @@ int tipc_bcast_sync_rcv(struct net *net, struct tipc_link *l,
 	if (msg_type(hdr) != STATE_MSG) {
 		tipc_link_bc_init_rcv(l, hdr);
 	} else if (!msg_bc_ack_invalid(hdr)) {
-		tipc_get_gap_ack_blks(&ga, l, hdr, false);
+		/* Validate Gap ACK blocks, drop if invalid */
+		glen = tipc_get_gap_ack_blks(&ga, l, hdr, false);
+		if (glen > msg_data_sz(hdr))
+			ga = NULL;
 		if (!sysctl_tipc_bc_retruni)
 			retrq = &xmitq;
 		rc = tipc_link_bc_ack_rcv(l, msg_bcast_ack(hdr),

base-commit: a986fde914d88af47eb78fd29c5d1af7952c3500
-- 
2.54.0


