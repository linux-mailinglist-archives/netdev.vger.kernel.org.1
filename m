Return-Path: <netdev+bounces-297159-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gmJUKc1AKGpUBAMAu9opvQ
	(envelope-from <netdev+bounces-297159-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:35:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E2F6626F9
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:35:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=nMsFDVsc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297159-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297159-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BAB9E304CE7C
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 16:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E583B19A6;
	Tue,  9 Jun 2026 16:21:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480EE3B42D0
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 16:21:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022093; cv=none; b=nHal/gNSjSo2sCa0YNID/zJPfkyG6Ye/VYkEvv5gZeRR872mHDgSVU7Dlt6hvTWtUij9k+x6/JnFX/3LEvk9UKtRmDQ05IPO8AewI6fU/3I75PkQHThkXZLkHHSa/bnN4Jkw+Ucj2AQTU6Fwj4ylKOaf90HauNPkH9qMdWgcvEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022093; c=relaxed/simple;
	bh=ck+WKCWpzacqctEB7DtAb1BlHqEq2My9/KWEZvH7PVI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=taTMpkl3ff1LEeE9fIZ4fxZ8C9la0HjdGqvXSB96KPIfqiJuhhZAcFSnihEPFpBhtyZlAF5ZDbX8icL89STYrK9rr+4sSpOoK6ekZUfRo8QR8rc8SaCWfH1T6JQbxRdUj/QGlkVl95QWIEhPkTKa8WBWQiOHGnaAX7qt4aLCPrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMsFDVsc; arc=none smtp.client-ip=209.85.214.182
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2bf77d4a4e2so35976955ad.1
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 09:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781022092; x=1781626892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hUkosP9gtBfCsOOX+JW45J6OLqM+uaRONOFyKMC8tmc=;
        b=nMsFDVscdOPC/cCGHBwpKFmGVpRtv15z0n4gHPqC57apiWsTdyANk3JxMPvAeY6k4L
         uWKPUr4ZBSyozWR9Ma3FXNmu02XqXMlSLyWv9OOkxEd/wVKqX5RGK3Jfe9Yfo68dPkq7
         3ZK2Y90LNEt1whF8Myqt18hwGdNfqtwwDIpNus/mRK8sdHmbzIJwkBsQQjBHJIZXJEej
         7kC+Gfo9HCh5lGP0EZI7FwUvHXtSQFIiw9YQqBQ5Ut9K7Vd0+OBRXdD14zBTApYAz2nA
         ZSEmKiwlufp7y0CB+XcG5FHPltOMTLIRD99mTubvLKvhvdmD0xYv62LsMarF7Se34UH1
         RTNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781022092; x=1781626892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUkosP9gtBfCsOOX+JW45J6OLqM+uaRONOFyKMC8tmc=;
        b=Z8RYdZmRD1p3Ylq4Y1f3Dvg0eUJOQkXyM6ICjheSqT6KGC8+XbHkX8Pyqn7MOkpaXe
         9ywlhli6soq8chs8vJ84GuFDklQn02RfHH9iEL1bpRLtiRtzeDtaTZr6LbyODgBKjJM5
         fHkXM+mN1sBrHq8cpgALHrQT4xqkmYoE+I0zYaMvkvCDWelHng6wEHuCUm9Yt4AkW5qS
         ym2bXe6A3v5V5UHxQPfV7hMR1b+nJBJ5SYa8L0CgZ+rGyC6BWRbD9dt7pt4OTW4Voiqr
         K0QN0GdSlmoATFYrp0qyRMtWOz8ZvNne1X0jLXgXVFDZV13KmjcDvutHgYl07KQsIuyw
         v/MQ==
X-Forwarded-Encrypted: i=1; AFNElJ+pqY3CnVO/V4wKio2tkSN/M641aZp3CmevYBxVdKpwvBStLT0J8yZ2wuQ+ti0rnSPYq1BoTqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFoTxTJnNvYmul8lti0oQTkdq/JEvX67diDx58hAnnbIa96Nxo
	UOBR/zqmuPjO5Dt+MPVlOyS+35eXdZGa7aqAx3SjlM5aCcf9xk0qlrgc
X-Gm-Gg: Acq92OGs9WTEb5PaCWbHInRuuzgKc+r5dlUkzSLtUxAPXmGjIMVpqpcUBd4KGVJCtl5
	CS25R0uclNLrbQ4qYs/Zr9KaJ4SWxxfqqDXTek/a2a7vp3ORTGMl2teqibVfchxSmeCtkrXSj0s
	aSWaK5DQtX/M9M+Ft3lz6H83SS8dcPISI5BGsqkKxBh6uD32WgrXqVQq0xs221UBRxiRGy8C+to
	VWyrNHjTIW6QliuyGZ2qKlmsGuyedkmPmlDr1WoDWCNLkkjqRwqLvsP10QEdPx3+Dl+la/FS5bc
	wJgxd2uZAvxSkdIaOxGUUsdCF+xjHxvvFfFoOnLrw9U6mejeOlOSowA1uV9zP2cOGDbwJgW3OX/
	ObQBeo19A1Zl5O5SIVa0bdejr7LGO7GJQmwBX0zUEYc7yAYTZJpCfT17GT3Hg5e5EI6WUtby379
	Ihw8bgNy6DREVQ9yvhzP6oeS1GPT7SH/jXgKWOY1+6+/BnS0F+0ZEEk8Ex9Xg1A5lCgZKjExS3q
	ZQuKFFWqDdXIP/n7KQee3E=
X-Received: by 2002:a17:903:3b8c:b0:2bf:361e:3edc with SMTP id d9443c01a7336-2c1ec3f61a1mr181204435ad.2.1781022091605;
        Tue, 09 Jun 2026 09:21:31 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1663981basm216519105ad.67.2026.06.09.09.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:21:31 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Chas Williams <3chas3@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH v2] atm: fix use-after-free in sigd_put_skb()
Date: Wed, 10 Jun 2026 00:21:08 +0800
Message-ID: <20260609162107.2865310-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,lists.sourceforge.net,vger.kernel.org,asu.edu,gmail.com];
	TAGGED_FROM(0.00)[bounces-297159-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:3chas3@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-atm-general@lists.sourceforge.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:xmei5@asu.edu,m:bestswngs@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 41E2F6626F9

sigd_put_skb() delivers a signalling message to the daemon socket named
by the global @sigd pointer, ending in a call to sk_data_ready(). It
reads @sigd with no synchronisation, so it can race with a close of the
daemon socket: sigd_close() clears @sigd and the socket is then torn
down and freed.

Holding a reference on the socket is not enough to make this safe. The
daemon fd close runs __sock_release(), which frees the struct socket --
and the wait queue that sk->sk_wq points at -- via iput() once
->release() has returned. sk_data_ready() (sock_def_readable()) then
dereferences a freed sk_wq:

 KASAN: null-ptr-deref in range [0x0000000000000188-0x000000000000018f]
 RIP: 0010:sigd_put_skb (net/atm/signaling.c:65)
  sigd_enq2 (net/atm/signaling.c:228)
  sigd_enq (net/atm/signaling.c:237)
  svc_bind (net/atm/svc.c:135)
  __sys_bind
  __x64_sys_bind
  do_syscall_64

Fix it on both sides. sigd_close() now calls sock_orphan(), which under
sk_callback_lock sets SOCK_DEAD and clears sk_wq before the socket is
freed. sigd_put_skb() latches @sigd with READ_ONCE(), pins the socket
with find_get_vcc(), and then takes sk_callback_lock; it delivers only
while the socket is still the signalling daemon and not yet SOCK_DEAD,
otherwise it drops the skb. sk_callback_lock is used rather than
lock_sock() because sigd_put_skb() can be reached from vcc_sendmsg() ->
sigd_send(), which already holds lock_sock() on the daemon socket.

The READ_ONCE(sigd) != vcc check also rejects a reused VCC: a caller
preempted between latching @sigd and validating it in find_get_vcc()
could otherwise match a freed-and-reallocated, live (non-SOCK_DEAD) VCC.
This needs a concurrent (privileged) daemon teardown, so it is hardening.

Triggering the use-after-free requires CAP_NET_ADMIN and CAP_SYS_RAWIO
to attach the daemon.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
v2:
 - Also bail when READ_ONCE(sigd) != vcc, rejecting a reused VCC that a
   preempted caller could match in find_get_vcc() (hardening, no stable).

 net/atm/signaling.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/net/atm/signaling.c b/net/atm/signaling.c
index 358fbe5e4d1d0..346fb969166e8 100644
--- a/net/atm/signaling.c
+++ b/net/atm/signaling.c
@@ -54,14 +54,32 @@ static struct atm_vcc *find_get_vcc(struct atm_vcc *vcc)
 
 static void sigd_put_skb(struct sk_buff *skb)
 {
-	if (!sigd) {
+	struct atm_vcc *vcc;
+	struct sock *sk;
+
+	vcc = find_get_vcc(READ_ONCE(sigd));
+	if (!vcc) {
 		pr_debug("atmsvc: no signaling daemon\n");
 		kfree_skb(skb);
 		return;
 	}
-	atm_force_charge(sigd, skb->truesize);
-	skb_queue_tail(&sk_atm(sigd)->sk_receive_queue, skb);
-	sk_atm(sigd)->sk_data_ready(sk_atm(sigd));
+	sk = sk_atm(vcc);
+
+	/* Pairs with sock_orphan() in sigd_close(). */
+	read_lock_bh(&sk->sk_callback_lock);
+	/* Bail if torn down, or if the slot was reused by another VCC. */
+	if (sock_flag(sk, SOCK_DEAD) || READ_ONCE(sigd) != vcc) {
+		read_unlock_bh(&sk->sk_callback_lock);
+		sock_put(sk);
+		kfree_skb(skb);
+		return;
+	}
+	atm_force_charge(vcc, skb->truesize);
+	skb_queue_tail(&sk->sk_receive_queue, skb);
+	sk->sk_data_ready(sk);
+	read_unlock_bh(&sk->sk_callback_lock);
+
+	sock_put(sk);
 }
 
 static void modify_qos(struct atm_vcc *vcc, struct atmsvc_msg *msg)
@@ -257,6 +275,9 @@ static void sigd_close(struct atm_vcc *vcc)
 		pr_err("closing with requests pending\n");
 	skb_queue_purge(&sk_atm(vcc)->sk_receive_queue);
 
+	/* Make a concurrent sigd_put_skb() observe SOCK_DEAD and bail. */
+	sock_orphan(sk_atm(vcc));
+
 	read_lock(&vcc_sklist_lock);
 	for (i = 0; i < VCC_HTABLE_SIZE; ++i) {
 		struct hlist_head *head = &vcc_hash[i];
-- 
2.43.0


