Return-Path: <netdev+bounces-260957-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id DupwF1r9nmlAYgQAu9opvQ
	(envelope-from <netdev+bounces-260957-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:47:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C983B19856E
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D233309C009
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 13:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA543921FF;
	Wed, 25 Feb 2026 13:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MT5q0vOB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7CD12CDBE
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 13:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772026827; cv=none; b=cIBK1Rn3xy63LZYEr/REqwHzjmKBwQPlTOj9A8Py1nRsFL/7PnF1dyTodmr9t4BoKTs4dzrncD0ccUPAh8kQsS3eEo57HFMPDNOIM4CsCugh6pSCoXHnvQ04bES7VDvZqg5ZutMG3wNE7mJMcY9BD4hO/YetsaI2O07KqHNPJ30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772026827; c=relaxed/simple;
	bh=ecEGC6MFMS46M2t9zR8kWI64P5awG+imqruj6KcesBw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GZzARLoz4uWOsXvBSVwq8m+j+FjM0Ue61oYBPd/QVox/ktlQBpBDphowkjzVPgu5mY6F6QcJL0IgXREPZ8seVGdjZEsyaNqVaVmg8SPtCTBNJf9HXbQz5zta6gh7MaC1tIbrHM8ZY14zEmoADgMcNPUVykpV4lDXqADjFoluFgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MT5q0vOB; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8cb403842b6so5945017485a.1
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 05:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772026825; x=1772631625; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3X8B6tai/0+3qGWD0vTMyQpt0HwsElpKCU0bHmTBIgg=;
        b=MT5q0vOBi13B9e7j50KY9uUb1clI5dyLozB8v8DwKYCC/kMaf9sJNy7AEcRdTC+dvb
         DMj2R6Qarz2IyLN5gFB9XaYXep8E/yzIIaEIUIehKr9mhIoMhS1NhgorU05rJ4GiZe5/
         3OHEdMMQx1m7WlakNwgqlQ58FpCQH3dn9S4TlrDYsWbOUzPqIyZ2ReZybUnox41CUZ4T
         HMsomiGumhlPeQviXqhO4qUxwpUfbArGLCRz8sI6l3Dj0BUywmwKAR4JnlZ7IscTzabn
         Vn8dutmmIYLo7ZPeuDUcWMFtdmz/eZ+/qqdZOf9LNfV1aKe6MaYLC7BCgxQMPReWBx0v
         zjZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772026825; x=1772631625;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3X8B6tai/0+3qGWD0vTMyQpt0HwsElpKCU0bHmTBIgg=;
        b=czWqpTP0X6HRsb68LRK0IaEmbdHRSIKTeXu2Sc+gM168pHmT3CFZcJ2mhnZMYchO9A
         SvBv/YHq04NHUt42ju3EhEehBPrQJ8fh2a42g8B+mAIeG1lKsCPASrZ9ppx74/mL2crQ
         rhwVFIRoDoP0kDdeP5hw3Yecdp//NAqjx5Vg7n+ebChnhylJgo5e4KHT6c+I63vIwGPl
         6AVkVswDvMWt9MnFRjjLx6f50WgS1ScipYa7miPiIjUEAc9dFJzLaHVYdSnBBLB4Uzzn
         tYeBve/fCx9RnZi1yqsrTxDFtux3Dd8u3qtKl1yAhDuXKX9piXvXGt9MV46zdSu5mHfG
         6XYA==
X-Forwarded-Encrypted: i=1; AJvYcCVTH22tma+0ra1qLkXZ34xH3wYPM6rF2cS6cJoGxSFR0us7bDaVVwA1qkL5cOkRnqT8h28aTuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpoIEny1AfoVToy/poMXBqmeAxGDMSXTmwZIEt58LrurTibSg3
	MFc18c12kfDT3cfCrVZ+DxSZscUAjKR3DjTLo9yJbbYGCe+5BtuAChBq4Ref1UjRKaU90CAKuZZ
	In4ipVFDSqKrFNA==
X-Received: from qknts18.prod.google.com ([2002:a05:620a:3d92:b0:8ca:32cb:b590])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4801:b0:8c6:a7c8:de60 with SMTP id af79cd13be357-8cb8ca675famr2167779985a.42.1772026825231;
 Wed, 25 Feb 2026 05:40:25 -0800 (PST)
Date: Wed, 25 Feb 2026 13:40:23 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260225134023.1176738-1-edumazet@google.com>
Subject: [PATCH net-next] inet: remove three EXPORT_SYMBOL()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260957-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.972];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C983B19856E
X-Rspamd-Action: no action

inet_rcv_saddr_equal() and inet_csk_listen_stop() are not used
from any modules.

inet_csk_accept() can use EXPORT_IPV6_MOD()

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/inet_connection_sock.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 5dfac6ce1110b3276fa8aaa02440c774c6a58176..26e2e792916c3a6fd989bdd2817953ea2be23c6c 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -107,7 +107,6 @@ bool inet_rcv_saddr_equal(const struct sock *sk, const struct sock *sk2,
 				    ipv6_only_sock(sk2), match_wildcard,
 				    match_wildcard);
 }
-EXPORT_SYMBOL(inet_rcv_saddr_equal);
 
 bool inet_rcv_saddr_any(const struct sock *sk)
 {
@@ -724,7 +723,7 @@ struct sock *inet_csk_accept(struct sock *sk, struct proto_accept_arg *arg)
 	arg->err = error;
 	return NULL;
 }
-EXPORT_SYMBOL(inet_csk_accept);
+EXPORT_IPV6_MOD(inet_csk_accept);
 
 /*
  * Using different timers for retransmit, delayed acks and probes
@@ -1537,7 +1536,6 @@ void inet_csk_listen_stop(struct sock *sk)
 	}
 	WARN_ON_ONCE(sk->sk_ack_backlog);
 }
-EXPORT_SYMBOL_GPL(inet_csk_listen_stop);
 
 static struct dst_entry *inet_csk_rebuild_route(struct sock *sk, struct flowi *fl)
 {
-- 
2.53.0.414.gf7e9f6c205-goog


