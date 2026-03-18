Return-Path: <netdev+bounces-269013-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCdtOnGkumlraAIAu9opvQ
	(envelope-from <netdev+bounces-269013-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 14:11:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6B72BBFA0
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 14:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8159A316F21A
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 13:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB0A3D75B4;
	Wed, 18 Mar 2026 13:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXRPpDo/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85EC3D6467
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 13:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773839241; cv=none; b=LtWAYOsP/l8tVAIMrej6/YCMda1HnAxyPfaYxvO45j/e6WVcGMVDqBNK3lFR/O/+oW7vUiimyNZ7WioCGQRR6Wkk0JqJR/5RK+5KfGRVjtoduLlvs8wVxcqYPYVGotPeAroxBU2sCT5kP0BEZOPvVDZA1mkryywfyiQbMZ/Ou5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773839241; c=relaxed/simple;
	bh=/YLu3y1CSogJTOYaN7dniVTLrC7NplDkc1b++DawAlc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J8l//FMs2PsnlRs9hGWl6bjC6+3T/LqhdKP+oom0M4CB7dmsy8NsZPsB9IHKhbYnz74LPXivHchatonSFKydzcqtdTPHiYVoW1Jc4GFtg9LgDEdrbwRCi6nFXkM+MbKPA8fYfxy00CvJArUh1nuD6ZvzMMsZh2xaN8FjDcCUxl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXRPpDo/; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c741db5d610so483164a12.3
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 06:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773839238; x=1774444038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UlA2lxgENF5EO6jhXnXzDUkGu8a8O+pH6v9wcDNEMhY=;
        b=mXRPpDo/ONY3QlklvAAOpKKRzhXa7zHzzuCKXQUSkOQuccVfGPzvdoNMr2yZOlmxuv
         5qDNxowPCeIRg5Z1a7Br02TwEKybOplOYrFMkyA099KItEFHoEZUgEyp8vBrvz87GBOW
         CY4GquwYzIIusyEg8OXW5BqS6HJcshpMISgwPX5OxfwjHBh7JzE5apwuiBreh5yJ8lmR
         DJlpQvt/7jgizKFJ6lTusTAF4Yk57gre21eIW6AVmDnG9qrAfnFHFAfj5k4Ps4YtQOQ7
         hxj9DGs69K5Iftk/22ZsdyNYmYQlSruSSRb4GcZh7+8zEVRZYb67Ff75wm7iMGo5aKYL
         73/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773839238; x=1774444038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UlA2lxgENF5EO6jhXnXzDUkGu8a8O+pH6v9wcDNEMhY=;
        b=NxlE2W0SdkC6x+Q6j3f1sTpMovl7u/dOlsXxZ79NRovKVEwVfWECYsY1b5JLmn6Q8s
         mu/mPPQdZ2l5uCwQwFLbqZjYZ5v8ua1FjF/Tp9uXi4k7eky80Hwx96AXopVzs3LrvKxH
         loAVZRJa4P49HJLnWEowMbm2jzk8NKh7sSI+xtezQDbSGheLUmStLm7VVCNR3eKcc5uF
         A2EYRmF+Lrobpm2aF7FvsjdZno4ulQpBCgpmUbD4SXSiR6VVau1joIvIbvUzB+zfDUyp
         3e99Q42HeL/piXkTv8LPFNfZ3kQkkut31F6IwzpLAx0jIkkp6zXGdVrnIoFe04L0nd6p
         VpiA==
X-Forwarded-Encrypted: i=1; AJvYcCX9+MZrhjQ3NsQv/ly/oaL2gFMMJAfGnAE6dESP2anNpr0fRzGdSituwHmlVJpcUrgYTcPtnxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaQINQZ58x5h16XfqmAGCzhylLRue4JC1WpV5Ad81WQYvXXos2
	2x70RQg1BV7aZSPPVSHq4oPsOyHXWN8tlvvFqPuaCbiHEPfR/cGrAvsa
X-Gm-Gg: ATEYQzxlhNkU0qDstSYOknT2iG3GXDq460edvlN3P//Pv0Itwxk0+rBseIRBUFc3wI+
	6L26UDoZRkabi1T+M+Ycus828Nhauxoy5aYuTQZDXNvryxVmQODTOc7SGatui1deyNyRluocMoH
	zXMU0CVaLhFGWu38kf2SSlWeo0v4UHEfvTiwFHjw2+g4bltnjWdKdP4XSQZZZZDG0ttP02I3H4T
	bQU0vbwyX1C624Tfp9EAL+GG9Cv2UYCgf8JGzMYE9m2C1oqR+iL2+Pjf22qTSFTEpmYsfXE6lFV
	Zm6yyJ945juLFglVtGzYKyl8r56Kb6nAabXOSfroCCtSHIr43xQUyQFSBrBdnS3jPVOSzkXNy1q
	P/HLAMOazifY7BLAcStNAkYvXMqnOl/9PNDeKV5Gk6Mrs/ZHY5yMAjMw066owGRfl1MXrt8ENdc
	XARQO1nNwB1+dDjLTMbl40yNE8F9FXqubJS548ppC4vH2tqg9QQ68V3eyxVIVTavnUDcGexZx44
	GWvFyg2QVY=
X-Received: by 2002:a17:903:f8c:b0:2b0:52f7:faa1 with SMTP id d9443c01a7336-2b06e44aeb6mr34312335ad.48.1773839237854;
        Wed, 18 Mar 2026 06:07:17 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e604e7bsm38049005ad.63.2026.03.18.06.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 06:07:17 -0700 (PDT)
From: bestswngs@gmail.com
To: security@kernel.org
Cc: edumazet@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xmei5@asu.edu,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net] icmp: fix NULL pointer dereference in icmp_tag_validation()
Date: Wed, 18 Mar 2026 21:06:01 +0800
Message-ID: <20260318130558.1050247-4-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,vger.kernel.org,asu.edu,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269013-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8E6B72BBFA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Weiming Shi <bestswngs@gmail.com>

icmp_tag_validation() unconditionally dereferences the result of
rcu_dereference(inet_protos[proto]) without checking for NULL.
The inet_protos[] array is sparse -- only about 15 of 256 protocol
numbers have registered handlers. When ip_no_pmtu_disc is set to 3
(hardened PMTU mode) and the kernel receives an ICMP Fragmentation
Needed error with a quoted inner IP header containing an unregistered
protocol number, the NULL dereference causes a kernel panic in
softirq context.

 Oops: general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] SMP KASAN NOPTI
 KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
 RIP: 0010:icmp_unreach (net/ipv4/icmp.c:1085 net/ipv4/icmp.c:1143)
 Call Trace:
  <IRQ>
  icmp_rcv (net/ipv4/icmp.c:1527)
  ip_protocol_deliver_rcu (net/ipv4/ip_input.c:207)
  ip_local_deliver_finish (net/ipv4/ip_input.c:242)
  ip_local_deliver (net/ipv4/ip_input.c:262)
  ip_rcv (net/ipv4/ip_input.c:573)
  __netif_receive_skb_one_core (net/core/dev.c:6164)
  process_backlog (net/core/dev.c:6628)
  handle_softirqs (kernel/softirq.c:561)
  </IRQ>

Add a NULL check before accessing icmp_strict_tag_validation. If the
protocol has no registered handler, return false since it cannot
perform strict tag validation.

Fixes: 8ed1dc44d3e9 ("ipv4: introduce hardened ip_no_pmtu_disc mode")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/ipv4/icmp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index a62b4c4033cc..568bd1e95d44 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -1079,10 +1079,12 @@ static void icmp_socket_deliver(struct sk_buff *skb, u32 info)
 
 static bool icmp_tag_validation(int proto)
 {
+	const struct net_protocol *ipprot;
 	bool ok;
 
 	rcu_read_lock();
-	ok = rcu_dereference(inet_protos[proto])->icmp_strict_tag_validation;
+	ipprot = rcu_dereference(inet_protos[proto]);
+	ok = ipprot ? ipprot->icmp_strict_tag_validation : false;
 	rcu_read_unlock();
 	return ok;
 }
-- 
2.43.0


