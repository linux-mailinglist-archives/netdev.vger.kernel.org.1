Return-Path: <netdev+bounces-286596-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAK5NJiyAWppigEAu9opvQ
	(envelope-from <netdev+bounces-286596-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:42:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB4950C0BC
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CD6AD3012D43
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170973D9058;
	Mon, 11 May 2026 10:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="rNTIWMCs"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3013DA5B7;
	Mon, 11 May 2026 10:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778496136; cv=none; b=AcCGvbC7i1QitXbKRwrpTAZT0dpzKkMSTfZeIyN0c9DRcsyEUJ+8hutkBpTxQzFVkcaPB1mLvoKXQHl/PdCPg3iS5C1c3Kqzyx9XeK9HjnL5C1e+/4/cDFDFfWnetWYM4hNtOdaRDSljLeM7g6NXMchlEM6ITf5YiF0yv+6VHQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778496136; c=relaxed/simple;
	bh=zv4ypYBlXlacgkjArTcJ+qxpcgQPje6jIqRBAe1SKOc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fbFQT97JhviTPZ3Y1Q6guuCHux/WIsyEmncWK6rdphR9d04xsTrgZPmDhkBUgawYhF4DQuHsqqb3gidZU0P6KRn0jSQlOgyEz+XO1GKBQKn61BxIsE23pidoKI+7AOczqzLgYQ+Mg8sz6OiWUyhvkP84+BX5gY9Y6RmNiMOMz8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=rNTIWMCs; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=tnpW3RxsYB3WXMtCFMcp7qbYXymVb+70PXZPn7pH3Mw=; b=rNTIWMCsG58ZzX7cW61TdXFq30
	6CJzbMFAVpJzhSJLw0zYnrygVbF2D00CNSzaIcQhO2Ycw8o1KBQcbjgBvIurdLyXDD4myepbPpcSc
	+55yRqnrpxCZ7GpYLiSddLEntUJbMKFzYuYdMKV73kX+58qPE93oAdPcUBloNld1Ai6S2Wfhj7+k1
	X4qGcuffAFgK56GEP4K5btIASycRB0iWq0sVOQxLf5GL8bcwahRf8zOohcwZkTrynf3vZ4DkleZ94
	KbPlQWGt3YgehFRRAiolGgoTraGzdvRMEnUS7Wss4/tgFRxPvzxA+QcnlDdLTQDTq6IYSivYTiHIg
	ZWqX6bWA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wMO5R-001XeW-1l;
	Mon, 11 May 2026 10:42:09 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 11 May 2026 03:41:48 -0700
Subject: [PATCH net-next 3/7] Bluetooth: ISO: convert to getsockopt_iter
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-getsock_three-v1-3-1461fa8786ab@debian.org>
References: <20260511-getsock_three-v1-0-1461fa8786ab@debian.org>
In-Reply-To: <20260511-getsock_three-v1-0-1461fa8786ab@debian.org>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=3136; i=leitao@debian.org;
 h=from:subject:message-id; bh=zv4ypYBlXlacgkjArTcJ+qxpcgQPje6jIqRBAe1SKOc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqAbJvQ7E/qMrjv7D1RzYYNoh5mzYwQp2DvSYYn
 FWLw0EKwEOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagGybwAKCRA1o5Of/Hh3
 bSdQD/0erTKwmPjA6j6Hk5H5UNXppSVtNRx4kaSOmMK9jUQVl9S+jqmAjVG/s0wqatiNbt91wPg
 rEsIjeamCmvAHjTcq0aFi4A/PI3bn+Y/rDXFpG+RhyI1Pd4M/or3tOnxY3HXFY1TMYAlRXYgYH8
 gIpWk3X6q05IcVSd4YPPLYbxgrJHCi21Ha/b59kNc6QXxbmtS/gT3cb1PqQE5JrPOpNY1scwbR8
 gaLs5H9xdf7yrfAIJs72WJgXTHe0qxhZadIqVg2KsT/34/UxEsOZqAayHmhosljvKrWoyYTPAEE
 stCB5W4CnK8dSPtNOUZZgztJLDMAJx5KvC7ngjChABrnqvyGDKiIj17V2m3IQbRiTQiRxOCyFna
 myK0x/fwYW4v+YWihbIR7tESUxUOZakX90T0IQxYLrNeXOPD0yuUhSvR9zql/UPdKvlassaUFG/
 ArcoPYJfwG7FtuEEEcpKt6zIvn+bqMULGvcU/SEZ0YF/c7TNYC18mdfTyqIbK/QLpxYCzk4jxB/
 xx1qk7J3jiu61dz52zQyThXkRkVwAXBCWLxTVzpF+YUoskv8hW7AoNqU43TUoVfaW6Obuuf4C+l
 3FIVXPqkBsdWRbCfD/gkLFg8MnbPgIm4G3aMXrtQWZAdomiZKmIl3RaGxXW082JqhiGN/Z8R1gK
 Y6NfkonzNAaxnqg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: 8DB4950C0BC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286596-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Convert ISO socket's getsockopt implementation to use the new
getsockopt_iter callback with sockopt_t.

Key changes:
- Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
- Use opt->optlen for buffer length (input) and returned size (output)
- Use copy_to_iter() instead of put_user()/copy_to_user()
- Add linux/uio.h for copy_to_iter()

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/bluetooth/iso.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 7cb2864fe8724..0d792d36bb5ac 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -10,6 +10,7 @@
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
 #include <linux/sched/signal.h>
+#include <linux/uio.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -1842,18 +1843,17 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
 }
 
 static int iso_sock_getsockopt(struct socket *sock, int level, int optname,
-			       char __user *optval, int __user *optlen)
+			       sockopt_t *opt)
 {
 	struct sock *sk = sock->sk;
-	int len, err = 0;
 	struct bt_iso_qos *qos;
+	int len, val, err = 0;
 	u8 base_len;
 	u8 *base;
 
 	BT_DBG("sk %p", sk);
 
-	if (get_user(len, optlen))
-		return -EFAULT;
+	len = opt->optlen;
 
 	lock_sock(sk);
 
@@ -1864,15 +1864,17 @@ static int iso_sock_getsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (put_user(test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags),
-			     (u32 __user *)optval))
+		val = test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
+		if (copy_to_iter(&val, sizeof(val), &opt->iter_out) !=
+		    sizeof(val))
 			err = -EFAULT;
 
 		break;
 
 	case BT_PKT_STATUS:
-		if (put_user(test_bit(BT_SK_PKT_STATUS, &bt_sk(sk)->flags),
-			     (int __user *)optval))
+		val = test_bit(BT_SK_PKT_STATUS, &bt_sk(sk)->flags);
+		if (copy_to_iter(&val, sizeof(val), &opt->iter_out) !=
+		    sizeof(val))
 			err = -EFAULT;
 		break;
 
@@ -1880,7 +1882,7 @@ static int iso_sock_getsockopt(struct socket *sock, int level, int optname,
 		qos = iso_sock_get_qos(sk);
 
 		len = min_t(unsigned int, len, sizeof(*qos));
-		if (copy_to_user(optval, qos, len))
+		if (copy_to_iter(qos, len, &opt->iter_out) != len)
 			err = -EFAULT;
 
 		break;
@@ -1896,9 +1898,8 @@ static int iso_sock_getsockopt(struct socket *sock, int level, int optname,
 		}
 
 		len = min_t(unsigned int, len, base_len);
-		if (copy_to_user(optval, base, len))
-			err = -EFAULT;
-		if (put_user(len, optlen))
+		opt->optlen = len;
+		if (copy_to_iter(base, len, &opt->iter_out) != len)
 			err = -EFAULT;
 
 		break;
@@ -2660,7 +2661,7 @@ static const struct proto_ops iso_sock_ops = {
 	.socketpair	= sock_no_socketpair,
 	.shutdown	= iso_sock_shutdown,
 	.setsockopt	= iso_sock_setsockopt,
-	.getsockopt	= iso_sock_getsockopt
+	.getsockopt_iter = iso_sock_getsockopt
 };
 
 static const struct net_proto_family iso_sock_family_ops = {

-- 
2.53.0-Meta


