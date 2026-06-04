Return-Path: <netdev+bounces-295358-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4ag4NA2vIWrSLAEAu9opvQ
	(envelope-from <netdev+bounces-295358-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:59:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 73ED664222D
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:59:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Cv3njvQN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295358-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295358-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A288B30059BF
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 16:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB5B49252C;
	Thu,  4 Jun 2026 16:49:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DCA481A82
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 16:49:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780591794; cv=none; b=NSeBFPaxYi/cUCiDdEzkyP9mXgL4PeAMTY3AvDMlAMEmVs7kv48kIKMwNa9FQpTUtkpa2WgnpZxxQtR/LJp1eXSRVxSQIacWS2JXCO6tNTSQ4XDuvmEQW97r4gzwPOw4EDFB+ChneWHCvQGCYnerutKfjfUmB/3VYFnTkDdi9hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780591794; c=relaxed/simple;
	bh=8rZidRJc7KIbDb/hhTlBb8sIB4bj2J9nT1uZEO5jZi8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZU13c7kj0AuFmmGXgBiyeNtp4IwWsnH/TCdVnWm+HZbnQgDMvddVWrG8rEhc9xt/eo8u2rPjnAIeH9tzxAQp7G5ci5sCymcmsBxUWp5ayQvU7gC0vpNMPp91ZATVFrQ80ECdNLYXEfX5x9ZrXk+JorDETxHZaiacsMt59NsqhOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cv3njvQN; arc=none smtp.client-ip=74.125.82.54
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-137f27712fdso422618c88.0
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 09:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780591792; x=1781196592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q7LGlpmkBDdsMxU03nJ4arl9Id1e5bW5QofAE7pI1Zg=;
        b=Cv3njvQNvmOIpycyKLJVJQEZfduGkfAH5i7H2xsrsA1JvZ4A1Af14nVtYue/pQFulc
         O/pAoqIyYn6tXl7jjsONueW16KqTF1jcnvxJbOo2sxrxN8pxFCtGFngO/VE2trEwwNhP
         FDtgBf56MqTAt+sHm/Ed9vj+uRrOKclZuU54q+wZYo8ruu4YIm5eG/4fSM7wxdyqKzjS
         a/VGLcuK9I7c7zJAtSsUkMTu8R3OkhbuZG5vi36z0C/ym+Q26MSTfaoecpm/k2QbvJiz
         cakACjdBgeG36DiKUKYlq250+tn9X5CmaJDmj5WPmhpArsW39TxtgJ3sncoid2SOpPnV
         fymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780591792; x=1781196592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7LGlpmkBDdsMxU03nJ4arl9Id1e5bW5QofAE7pI1Zg=;
        b=pRM9+kLoREo79+iceGY7ZKdIOh1MSb9hwclzeM2vGtGlxp6brcwVrCW9rXhh3L4qqw
         wbugqQI6N6bdO5tIHQi5OVm/5NMLzmZh9FtW6hgmo6O56yVYmood+3Zw0MomqV5ZFmZi
         rM/ia56giECwU68fEWrP4nKuhrAr5wFQQi7/6JSb660sjd45ZrB496mP6EyDcxcEEwme
         /U1IAYnN0WEPbN8UT4CSRO2YBvbEjE/bSQqFk1+vqP8ezvojAPS2wAUzl/B6lwMDFUgT
         BIU79cqtJBINKeR2rb6EVD5Gymk7PJP6k0hKvpZyGkxkE/cEIlJm6CcBRuCrpJ70fqkD
         HMTQ==
X-Forwarded-Encrypted: i=1; AFNElJ9MzrrZv77tqi974/s36cjzM5BRYJ8Bar76tTN2JUqS8WeuLRMKV6+Mz9IeCKHLarWv5qYV0DM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaPNB8pwrUwF7r45XHt2gUVRmxldBIy0jySvOTiGJlma+ABFJs
	cS44Sm3SlZ9xVifqsOxIaDV/B0ez5DQIXKkZiLuCX7eZbMQQTUdsAXjY
X-Gm-Gg: Acq92OFkzrLeVepQzdowRp8KR5oRSyPG56XU2inhMr8CmNwhJZgRau8d6mmGqdcnlNH
	R0upcwWakIibLnwFfHDakvx14A+WDiwNXlWms5JnrWj/r/3rXq5807yEaaLd+ltTqxbNz7fNLz0
	mhO+C0x3SquGEnDNGqzBw0cfEfxHeDWXP+lmKu4FNOBGShkoGCc4t0F0eHYM5O/oRcFNDXQpXoJ
	IMJkj3YK9memQ7Wf906B0JMsaidsxAE9SOCILas8fHjqLos2pBff2fq0ezt4aS5vBLmncNqt2Rd
	YcMLwGZI/SRaWJ5LiECjuoPh82hLLFKikRiq49c3VKps21BN9Gy7IIdi1a+FCECxJ3TY1HKymO5
	clfNqSzVu9TcH+TDsRUkT+58Kt+WoxGaxRPU9phY5PtpZlvG9sNeFu/lSQQQCEiwnZsD1t3mMu2
	WUHQ+6ixqc+LGfMqzGis1cVePBsnYfqIxGb7dftrS7dzx5iVXRBF82Ot6ZAYlZhRdxciWqeo+ps
	TVIAX0=
X-Received: by 2002:a05:7300:fb91:b0:304:e865:f7d1 with SMTP id 5a478bee46e88-3074fc2ff12mr4125947eec.25.1780591791994;
        Thu, 04 Jun 2026 09:49:51 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df8076csm5762732eec.29.2026.06.04.09.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 09:49:51 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Chas Williams <3chas3@gmail.com>,
	netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	linux-atm-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net] net: atm: fix use-after-free in sigd_put_skb()
Date: Thu,  4 Jun 2026 09:49:17 -0700
Message-ID: <20260604164916.2681964-2-bestswngs@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,lists.sourceforge.net,vger.kernel.org,asu.edu,gmail.com];
	TAGGED_FROM(0.00)[bounces-295358-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:3chas3@gmail.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:horms@kernel.org,m:linux-atm-general@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:xmei5@asu.edu,m:bestswngs@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,asu.edu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 73ED664222D

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

  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000031: 0000 [#1] SMP KASAN NOPTI
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
with find_get_vcc(), and then takes sk_callback_lock; if the socket is
already SOCK_DEAD it drops the skb, otherwise it delivers while the lock
keeps sk_wq valid. sk_callback_lock is used rather than lock_sock()
because sigd_put_skb() can be reached from vcc_sendmsg() -> sigd_send(),
which already holds lock_sock() on the daemon socket.

Triggering the race requires CAP_NET_ADMIN and CAP_SYS_RAWIO to attach
the daemon.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/atm/signaling.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/net/atm/signaling.c b/net/atm/signaling.c
index b991d937205a..3dbe8e0fdc9a 100644
--- a/net/atm/signaling.c
+++ b/net/atm/signaling.c
@@ -54,14 +54,31 @@ static struct atm_vcc *find_get_vcc(struct atm_vcc *vcc)
 
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
+	if (sock_flag(sk, SOCK_DEAD)) {
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
@@ -258,6 +275,9 @@ static void sigd_close(struct atm_vcc *vcc)
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


