Return-Path: <netdev+bounces-285787-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJojEbbT/Wl2jgAAu9opvQ
	(envelope-from <netdev+bounces-285787-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 14:14:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A274F6335
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 14:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4225930158BF
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 12:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E6A37FF76;
	Fri,  8 May 2026 12:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bfmWwOtd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366AC3D0918
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 12:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778242137; cv=none; b=k7yATO2wdnb9UtQn113uLf9D4m8MjNECsCja5NrPmUBBLzTNVkUUCRH6Fqctvd6sYBsCjRrUEY9jUam4BeEDlEw+ArxPI5SoE6dNVXNhsKxR+c+JCB5bHDUIrw6Ioc5KEvIFemj4g958eSRHbLnbNAD5B3oVeJuoIgbH8E3qMAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778242137; c=relaxed/simple;
	bh=S+AcWVmLoet6g9VZdUwzYxVEGVFSw/VjPbZZzfwKjvg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=iqRicKRKVBkJlo+nzryJtyq7DXMzhKEFsYCjFM6AtT4zlyTJRTTysczwqpFY6wadnZ2LIDyD8cMkLqiPVvZLPq4xwbFEv/m9qsOAhRXnaJsGejv3oBEQfDf3AiNfaeLjO+SV2YBz3rJM1Diz2dOW+SLYLaQcSd7HXXTN535j80o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bfmWwOtd; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-365c5ca76fdso1600174a91.2
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 05:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778242135; x=1778846935; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o1XcD/NkGd3x78OcBs8IiVYHbP5jUQCOzADI2FH/BY4=;
        b=bfmWwOtd0K2vRNyX8z1TXiLWjzAxVmKzvlb1DoGXUgrkJRdrP2tBGU9ryRAmyd0FLF
         CqSbp9lK+OvFiFDKRD1c11Kq2L0xtXtlA+sepyV5+WtrzxAfYtcuvs//WuqeU6AaIiwH
         vvPw4YfeslRV1f7e7td8wneHrCYe0URN3a15wDC+AzeUdEhA+0JL11nSloHLN/gP9tsi
         kLaDXaJNa0ka/DdFur7Dfq1a3xtq5nD5jSOzYd5FFUHbLuQ/J902SjwA549gPPTeU6Ym
         Mb4e9N0tYNd2XX13nboVxALgorpMv4UNgJDupmVr51otOmo/g3X9qv8I8E1SXN5t5cnw
         Wzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778242135; x=1778846935;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o1XcD/NkGd3x78OcBs8IiVYHbP5jUQCOzADI2FH/BY4=;
        b=P6niL+V5WPa0F0utqasAYhNJhdJQ976YW7tkkG3LfHyWEcduZW7R9R5IvvZQf+Qd+V
         DrZlEqZDgb8PjYe2hv+6oWU7S1+bwNwkhvBW0oYfAOfRensE2rzIoESlCmFHYBQdoUGk
         HH5Ixa/NUNGFaqipxSPW9toDbL1VMuDQfq/AXWQPOV13Zh9wYaP9EBI0hln+BgSm7GOR
         jBC+X2bgg9AQOw+DcwkrndftlVrTQI/731PbGCKJdccz+OMmQR3+nBmDktj5+RdFmZoD
         sNpgdaAnjiX3rFDxR++c+GC6FvpeL8QXp9ZU4bqT0kBjOFM5rHCauRRMhw3DVkA5zKGL
         lJUA==
X-Forwarded-Encrypted: i=1; AFNElJ/YWrYUReg4T9zhxiVFWRwYgvWnFuG2zHRX06Ap1K7lSCRKr+9A7lVkSzgk1X1h1BnPMJ8NCiI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8IkHpG+oEnL2pSi3i7S+upvNlpOd1mKUt32O4bkOnLwjiIEQb
	4iQfL7Ej6AYfygTBver7c5OggMsQwCZ1tvxprRpVMZtW08zSO5Rn26ebEgOrNLYe5XlS3GuPyT9
	agqSwbg==
X-Received: from pjqt4.prod.google.com ([2002:a17:90a:ae04:b0:35f:ba7a:947d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2f4e:b0:35f:c46f:2b0
 with SMTP id 98e67ed59e1d1-365ac080c4bmr11271691a91.14.1778242135316; Fri, 08
 May 2026 05:08:55 -0700 (PDT)
Date: Fri,  8 May 2026 12:08:46 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260508120853.4098365-1-kuniyu@google.com>
Subject: [PATCH v2 net] tcp: Fix out-of-bounds access for twsk in tcp_ao_established_key().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Damiano Melotti <melotti@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: B5A274F6335
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285787-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,google.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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
v2: Ensure that TCP_TIME_WAIT does not evade RCU lockdep check
v1: https://lore.kernel.org/netdev/20260506172830.2237574-1-kuniyu@google.com/
---
 net/ipv4/tcp_ao.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index a97cdf3e6af4..0a4b38b315fe 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -116,7 +116,8 @@ struct tcp_ao_key *tcp_ao_established_key(const struct sock *sk,
 {
 	struct tcp_ao_key *key;
 
-	hlist_for_each_entry_rcu(key, &ao->head, node, lockdep_sock_is_held(sk)) {
+	hlist_for_each_entry_rcu(key, &ao->head, node,
+				 sk_fullsock(sk) && lockdep_sock_is_held(sk)) {
 		if ((sndid >= 0 && key->sndid != sndid) ||
 		    (rcvid >= 0 && key->rcvid != rcvid))
 			continue;
-- 
2.54.0.563.g4f69b47b94-goog


