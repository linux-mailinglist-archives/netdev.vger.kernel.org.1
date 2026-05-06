Return-Path: <netdev+bounces-284971-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFz5Lqh6+2n0bgMAu9opvQ
	(envelope-from <netdev+bounces-284971-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 19:30:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2A64DEDA7
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 19:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0383303A8C0
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 17:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EE84B8DDF;
	Wed,  6 May 2026 17:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y0+XbFPC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E844BC02C
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 17:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778088515; cv=none; b=kUxhTyCCFj1qQXw10rBtzJMXHkz50cNap8v3Z3T0arRSfh4G2aNHdsCAwKhRjGv/8Qv0IRzAvoNIug+OgyxNi8KoDogh8+joqC73gLQjxaW7DV17hAXQV2GV1sxHw3c0cVU8UO8kL0GrZzFTcFpFzSLXIQpjKC2sHNn5PKiuN6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778088515; c=relaxed/simple;
	bh=+JAXBcfFApk6Q1vHjE+qSmpo8KhHDmH9Knu8S6+KEc8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Fgw3LAHW9w9Vwp6c9ISp2+XfYbep7/I7Oj9b0PGbNKrcpDTnEQR1bxfagxPeFtWSM+eLDVsYQp8i7NXL2EDH6+stPHO8Q3P7mjsyBknwrDX959YEX7pgvZScg2clZD5BkN30SoNeHfS7POr32EUOrP8EFGFSjLTV35d3wVAJLoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y0+XbFPC; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c81ed67fcbcso1449694a12.3
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 10:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778088512; x=1778693312; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9kWUktZAxModxM8jEbJ03797Z+amFhbRsI8XzY9spwk=;
        b=Y0+XbFPCzQrgLsjkMGy0ocYFcjC2CGBmkWXC71YA7ceGN8wHRnyMHIR53FT740cTFY
         N+NvJC3RX6P1snMmGCX3tMDLIoyyuhSC4/R3t9gNqvBYhtgsXA58lMAs+laB6/b+w7zt
         f5a1do03CUyNVAdLDIHy4VzkDQbzSJsbRqTZcBtV1tn4cahSEbzVCaILDfjLuP02G66F
         qAyuYsPCz2H5Hj4iQU44UZwov3bsl6c1dMQvhMIvmBAJUOyvlZa7A5Acr7IF9SZn5fQ8
         yKXuzBxK/IGEii/Z54rIHKS7sA95XUjzxnHYL+AA1Razk1JvPn1qxChJY/6RPtJOsEyn
         4kZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778088512; x=1778693312;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9kWUktZAxModxM8jEbJ03797Z+amFhbRsI8XzY9spwk=;
        b=d+fvVbrjSX9MJZnX12Y1M77d8AWNY/FL1LZEWZqlEZEIQEOj4b7+6pJgF/XQQ52sTW
         QYQ6CyLuoSLCKfHvo4BhduY3mb+Te1HAlueokiWNhwWwAIxdk9CpeLuIkVhTDAOFEiu2
         9XyHlQUde2mcoZUKUGIfubqQ0hHgg0+RlRXPpJnjYIR73pG+8JnG9GZR2twPwv9qR02D
         U3qoFw1XjoXhT5gCi1OWCCWRHNj48xbdXa0BhQpjg458DY85IYJkw52rM9BWCqjGkIOK
         FozamxZEM/Tar3E0BI8/Q2BLjk7pFPui2zcSrnO04/IxY4gdPy2c2vFkjtYX1JUhbXu5
         t0PA==
X-Forwarded-Encrypted: i=1; AFNElJ8/pTunbgwj+Fw+pIcHrBGExCVnPozjloDhhwn25Nf7FP6wHFXopZhwyGH+oAmsvlYPRJV1UKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvHo6MaYTXxoBMVN4fxoygfdbSQ/fAPE1bzY8o5Zd5WeWxBcPK
	8BSRFK1V4M4Ef0bT+s9bbAqLYL7wHarbUnsyYkarN8R4wENtqMW2DYQYEtVGoFJc2TUliBW4vr0
	kplyY1A==
X-Received: from pfbim15.prod.google.com ([2002:a05:6a00:8d8f:b0:835:3df8:d72])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:938c:b0:398:bda8:d8cd
 with SMTP id adf61e73a8af0-3aa5a6e9281mr4801432637.7.1778088511969; Wed, 06
 May 2026 10:28:31 -0700 (PDT)
Date: Wed,  6 May 2026 17:28:28 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260506172830.2237574-1-kuniyu@google.com>
Subject: [PATCH v1 net] tcp: Fix out-of-bounds access for twsk in tcp_ao_established_key().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Damiano Melotti <melotti@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 2C2A64DEDA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284971-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,google.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

lockdep_sock_is_held() was added in tcp_ao_established_key()
by the cited commit.

It can be called from tcp_v[46]_timewait_ack() with twsk.

Since it does not have sk->sk_lock, the lockdep annotation
results in out-of-bound access.

  $ pahole -C tcp_timewait_sock vmlinux | grep size
  	/* size: 288, cachelines: 5, members: 8 */
  $ pahole -C sock vmlinux | grep sk_lock
  	socket_lock_t              sk_lock;              /*   440   192 */

Let's not use lockdep_sock_is_held() for TCP_TIME_WAIT.

Fixes: 6b2d11e2d8fc ("net/tcp: Add missing lockdep annotations for TCP-AO hlist traversals")
Reported-by: Damiano Melotti <melotti@google.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/tcp_ao.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index a97cdf3e6af4..e2720233e36b 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -116,7 +116,9 @@ struct tcp_ao_key *tcp_ao_established_key(const struct sock *sk,
 {
 	struct tcp_ao_key *key;
 
-	hlist_for_each_entry_rcu(key, &ao->head, node, lockdep_sock_is_held(sk)) {
+	hlist_for_each_entry_rcu(key, &ao->head, node,
+				 sk->sk_state == TCP_TIME_WAIT ||
+				 lockdep_sock_is_held(sk)) {
 		if ((sndid >= 0 && key->sndid != sndid) ||
 		    (rcvid >= 0 && key->rcvid != rcvid))
 			continue;
-- 
2.54.0.545.g6539524ca2-goog


