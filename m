Return-Path: <netdev+bounces-275366-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +UoQMB8T0WkoEwcAu9opvQ
	(envelope-from <netdev+bounces-275366-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 15:33:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAF539B34B
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 15:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6348F3005981
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 13:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE211E5B68;
	Sat,  4 Apr 2026 13:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJaEYMxb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6123E145355
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 13:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775309595; cv=none; b=ljRwjzxN9/mhDBhle0uBlqoWmhvr4VEVk55tloulAKnkj4MZtHvV5c3qd2C2Nw9OQuBAINa4P03HxFsLhdkAPulx78CWda7h7uDVsFnQQO4l94b6m2j9l0Lyvbm0p3gSW+on84+hpZDiSmMB9c6njaKMasOAnG6mRtHEo6el3r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775309595; c=relaxed/simple;
	bh=/xn5L4USrPtgujNaz2tHUWealIM1HU2lwXzW22iViPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FkAxBWbBIAwqBTlwfDoli0Z0t5e9QIF9+zsG8zIvb2d5CWtnf7TdZ0qyYSp5/BOXCAUTK+akV2PBnf1S7dlo6iiaaTsPN/G2eEKWo/9zqKs+W1m21aZonINZQ+DlYI6/mdXER1hmrW3BPpdFlJXg3hEoKRKQA4zlfDjIr0XnJKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJaEYMxb; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3538952a464so434157a91.2
        for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 06:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775309594; x=1775914394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iNpL/8/dGzdqV00EBJ3niLmK24NofYvcyxqVS++1Uck=;
        b=HJaEYMxbLVhHaEq2iVKwsqzYn1/XKXqE7anGlCh0Ud65VZne3JijXD3NZfDwOzp2ht
         nW56YB7Do7HEkbTgTrHGln97ir4v8UDP4Jg10Qv+d6ahRwdBuSue82Le+q7vCcEJ+ZcB
         rC3seeXz0mWdDQVnGnB8a118raM1vA/ddCON6BE+NLTVsU4+ECtJQP1QyXfoedMqlqO2
         pY3VMFDtjIlG9qQ6KhTHHS4f43VVCC6NXj4QnlYZbJ8DccQc6aSK3/yfC1mepeqe1PiN
         TKmI0m+ztyOgEFJ1th5rzohQQyhgV9+y5EoqYAHEImjqiWGFv8mz40sB2UNA0V9cl8DW
         uQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775309594; x=1775914394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNpL/8/dGzdqV00EBJ3niLmK24NofYvcyxqVS++1Uck=;
        b=bPLiVYCnUN3P7bWxaewpdrE9k6soEa3FSbwtLZAJUqvXAOY5veYM9ILxA1aPFha8FI
         ayHek1Ih2DUgNj2czYXeYp8WS84vtC1sP/aOJoYqyqDQgV9at9jjuNQVN1ywGxbiQD8o
         cX5RZ4iNiNrB7B7qPXlqBsU93gC+C9w2aaVXXZb9aWjXO/1SS4WIGgH6QgYKUZNHiifG
         YUg4uZxoUyG59rRnHIZbtE/Eh/v7Nqm4r3lADeQwWo48DuoXb5kmaNQrphx33kIgHeWk
         0gR4gzuWNlg2zE+3vGfchBObmt11YpVoXHxJB4nXg4Kj0WnCeK84hGaGaDizzfx1+F2r
         bbxw==
X-Forwarded-Encrypted: i=1; AJvYcCX+lEboHzcpF38/zr62wkWtaSM4xE2L9GX+y66vErBcXfaSuhdz9Ag/qT+eAtfaFmCbS+PXqKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgM1op4Fel5dEAdh8BODLZu9eulGTyQd3S0elaR6yoXlxvT8/k
	zUlKw3fGpX/GjIf/pGQySew+jwj4IJYJ43P9xygkcA8tvYWp4OfjJFhC
X-Gm-Gg: AeBDievMdhf4s4IXLIXwBKiJVkLMueFEagWvbvYQgiFTOy42ZCgWRt6CeUt7sJ/lFiW
	2hqwE4ObhgEIdKQPPQpUuyOeIUTnUIyvaAWDJocUVzfE7vpxl7sqxCPkmzwkTUR3bbAfpahATnh
	vs/e9NBAdLVh8JWl/E8neaC2N/N+s1fG9VCHxGjfOvHwilht78GvxMQqJpHsBz1EuWD+sSOlD2i
	QHEu6kKf4CaR3rAgMXANmeMxIpLeZCUH01tVgJreUNLkht1oiPps2aD/h1X3vP9elYSQSk5YD6/
	DUI/dcXhwt4wrDtTQg5mtRZkJpms3BY6eD/whN3TkQ4dqzghKjxo6UHqKRL6cSehcuj0xHAbYMb
	6YJufHd0f7BRC8n5ywb3Xm6uX/LbesnqNLYijBePphdpYIJWd2yprHfudaOVOi+jPHmny9Tc8M3
	g7gt+L3yGGOTIvHyU2wT5AY/UlsX5cGjlz
X-Received: by 2002:a17:902:da2d:b0:2b2:67ca:5ffa with SMTP id d9443c01a7336-2b2815d8057mr38831995ad.0.1775309593530;
        Sat, 04 Apr 2026 06:33:13 -0700 (PDT)
Received: from localhost.localdomain ([189.1.242.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749a1e9csm94460445ad.55.2026.04.04.06.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 06:33:13 -0700 (PDT)
From: Yiqi Sun <sunyiqixm@gmail.com>
To: jchapman@katalix.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	Yiqi Sun <sunyiqixm@gmail.com>
Subject: [PATCH net] l2tp: take a session reference in pppol2tp_ioctl()
Date: Sat,  4 Apr 2026 21:32:45 +0800
Message-Id: <20260404133245.2391409-1-sunyiqixm@gmail.com>
X-Mailer: git-send-email 2.34.1
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-275366-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunyiqixm@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4FAF539B34B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

pppol2tp_ioctl() reads sock->sk->sk_user_data and dereferences the
returned l2tp_session without taking a reference on it.

Since the ppp socket/session lifetime rework, session teardown runs
asynchronously and can clear sk_user_data and drop the last session
reference in parallel with ioctl(). This leaves ioctl() with a stale
session pointer and can trigger a use-after-free.

Fix this by using pppol2tp_sock_to_session() in pppol2tp_ioctl() and
dropping the session reference before returning. This matches the
existing getsockopt/setsockopt paths.

Fixes: c5cbaef992d64 ("l2tp: refactor ppp socket/session relationship")
Signed-off-by: Yiqi Sun <sunyiqixm@gmail.com>
---
 net/l2tp/l2tp_ppp.c | 88 +++++++++++++++++++++++++++------------------
 1 file changed, 54 insertions(+), 34 deletions(-)

diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index ae4543d5597b..e6d7d3537180 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -1042,66 +1042,79 @@ static int pppol2tp_tunnel_copy_stats(struct pppol2tp_ioc_stats *stats,
 static int pppol2tp_ioctl(struct socket *sock, unsigned int cmd,
 			  unsigned long arg)
 {
+	struct sock *sk = sock->sk;
 	struct pppol2tp_ioc_stats stats;
 	struct l2tp_session *session;
+	int err;
+
+	err = -ENOTCONN;
+	if (!sk->sk_user_data)
+		goto end;
+
+	err = -EBADF;
+	session = pppol2tp_sock_to_session(sk);
+	if (!session)
+		goto end;
 
 	switch (cmd) {
 	case PPPIOCGMRU:
 	case PPPIOCGFLAGS:
-		session = sock->sk->sk_user_data;
-		if (!session)
-			return -ENOTCONN;
-
 		if (WARN_ON(session->magic != L2TP_SESSION_MAGIC))
-			return -EBADF;
+			goto end_put_sess;
 
 		/* Not defined for tunnels */
-		if (!session->session_id && !session->peer_session_id)
-			return -ENOSYS;
+		if (!session->session_id && !session->peer_session_id) {
+			err = -ENOSYS;
+			goto end_put_sess;
+		}
 
-		if (put_user(0, (int __user *)arg))
-			return -EFAULT;
+		if (put_user(0, (int __user *)arg)) {
+			err = -EFAULT;
+			goto end_put_sess;
+		}
+		err = 0;
 		break;
 
 	case PPPIOCSMRU:
 	case PPPIOCSFLAGS:
-		session = sock->sk->sk_user_data;
-		if (!session)
-			return -ENOTCONN;
-
 		if (WARN_ON(session->magic != L2TP_SESSION_MAGIC))
-			return -EBADF;
+			goto end_put_sess;
 
 		/* Not defined for tunnels */
-		if (!session->session_id && !session->peer_session_id)
-			return -ENOSYS;
+		if (!session->session_id && !session->peer_session_id) {
+			err = -ENOSYS;
+			goto end_put_sess;
+		}
 
-		if (!access_ok((int __user *)arg, sizeof(int)))
-			return -EFAULT;
+		if (!access_ok((int __user *)arg, sizeof(int))) {
+			err = -EFAULT;
+			goto end_put_sess;
+		}
+		err = 0;
 		break;
 
 	case PPPIOCGL2TPSTATS:
-		session = sock->sk->sk_user_data;
-		if (!session)
-			return -ENOTCONN;
-
 		if (WARN_ON(session->magic != L2TP_SESSION_MAGIC))
-			return -EBADF;
+			goto end_put_sess;
 
 		/* Session 0 represents the parent tunnel */
 		if (!session->session_id && !session->peer_session_id) {
 			u32 session_id;
-			int err;
+			int rc;
 
 			if (copy_from_user(&stats, (void __user *)arg,
-					   sizeof(stats)))
-				return -EFAULT;
+					   sizeof(stats))) {
+				err = -EFAULT;
+				goto end_put_sess;
+			}
 
 			session_id = stats.session_id;
-			err = pppol2tp_tunnel_copy_stats(&stats,
-							 session->tunnel);
-			if (err < 0)
-				return err;
+			rc = pppol2tp_tunnel_copy_stats(&stats,
+							session->tunnel);
+			if (rc < 0) {
+				err = rc;
+				goto end_put_sess;
+			}
 
 			stats.session_id = session_id;
 		} else {
@@ -1111,15 +1124,22 @@ static int pppol2tp_ioctl(struct socket *sock, unsigned int cmd,
 		stats.tunnel_id = session->tunnel->tunnel_id;
 		stats.using_ipsec = l2tp_tunnel_uses_xfrm(session->tunnel);
 
-		if (copy_to_user((void __user *)arg, &stats, sizeof(stats)))
-			return -EFAULT;
+		if (copy_to_user((void __user *)arg, &stats, sizeof(stats))) {
+			err = -EFAULT;
+			goto end_put_sess;
+		}
+		err = 0;
 		break;
 
 	default:
-		return -ENOIOCTLCMD;
+		err = -ENOIOCTLCMD;
+		break;
 	}
 
-	return 0;
+end_put_sess:
+	l2tp_session_put(session);
+end:
+	return err;
 }
 
 /*****************************************************************************
-- 
2.34.1


