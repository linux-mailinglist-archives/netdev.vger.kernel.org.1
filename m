Return-Path: <netdev+bounces-292305-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJxdJsH0Fmo6ygcAu9opvQ
	(envelope-from <netdev+bounces-292305-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 15:42:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB145E5379
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 15:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0461F30A629A
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 13:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F26740C5C5;
	Wed, 27 May 2026 13:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lj5vyJlD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E332405874;
	Wed, 27 May 2026 13:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779888997; cv=none; b=bFvEYLvievPm5/VEX7YiW2LfFiSAKV2+4vRbM6njBNdE838e7IBqpBtWrGLuzfjLgWWVCcWSRY/vkqqUt6YHQP+Ec6VglUS1yysdY1o2E7AyHvyhVaszaocVajqcKvDEQriJ5PXzxZP+/EiEDhMz7pM0AmpzD2HUhWMx0g0c35o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779888997; c=relaxed/simple;
	bh=a+wRMTbwIRA8gHKefUAy8Qer+/Q0gu4oP6SEZpHjGIk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=FTadU+O+P2CTmFA9pUs5V4cNA0TXLk8Zyta+10kfTX0z5LlJVobn87gXdxF4Ilm/CVOU/AvjVdogyc/N83HqBiDSXwihr29fXsnSQDJ5AEx7WQOd5gFtI3sqNhZkA4iNMFNJBnP76n+0f5iE3AHDXqQC7ZNqZb2lGN2X2gJN65A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lj5vyJlD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA261F00A3D;
	Wed, 27 May 2026 13:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779888995;
	bh=W93tvAG1gi7b+6memlyo/w2BK1fcNWozBaR+Wh3AtEs=;
	h=From:To:Subject:Date;
	b=Lj5vyJlDAczgsaXkWHjvGnbSz3Kncb6V0zAt+uDJv8gao46zUWWvmfjt6rui/VQsL
	 XhRHVrMxIqdgvvronROdmAmBqu4/7Lo6dF6NUXee+M00bA/vwmdhjvQv0/J8Gp5FT6
	 xjM6+b4hYHHR18Nc+KVmLgcOqHmBiuzq2IlVOU3NADvPZ8jDBCPjhd/JQv6TInXtSY
	 LiZNKfjOPs9xjXkzGNhNvcUJZwpct3uqIr29srmbDZUf85+fAcH+144PP1HibsH19D
	 JfArCp5Vj0JqeksDbui2lUjDK1Nec+ckHR+SWEXhUSkRSkeiZdrwjsV0Jqge8gPDRE
	 ULz/ieGGH2gDg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	James Chapman <jchapman@katalix.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] l2tp: pppol2tp: hold reference to session in pppol2tp_ioctl()
Date: Wed, 27 May 2026 13:36:29 +0000
Message-ID: <20260527133630.2120612-1-lee@kernel.org>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292305-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1BB145E5379
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

pppol2tp_ioctl() read sock->sk->sk_user_data directly without any
locks or reference counting.  If a controllable sleep was induced during
copy_from_user() (e.g. via a userfaultfd page fault sleep), a concurrent
socket close could trigger pppol2tp_session_close() asynchronously.  This
frees the l2tp_session structure via the l2tp_session_del_work workqueue.
Upon resuming, the ioctl thread dereferences the stale session pointer,
resulting in a Use-After-Free (UAF).

Fix this by securely fetching the session reference using the RCU-safe,
refcounted helper pppol2tp_sock_to_session(sk) on entry.  This locks the
session's refcount across the sleep.  We structured the function to exit
via standard err breaks, guaranteeing that l2tp_session_put() is cleanly
called on all return paths to drop the reference.

To preserve existing behavior we validate the session and its magic
signature only for the specific L2TP commands that require it.  This
ensures that generic/unknown ioctls called on an unconnected socket
still return -ENOIOCTLCMD and correctly fall back to generic handlers
(e.g. in sock_do_ioctl()).

Signed-off-by: Lee Jones <lee@kernel.org>

---
v1 => v2: Restrict session validation in pppol2tp_ioctl() to L2TP specific
          commands to preserve generic socket ioctl fallback and perform
          checks silently to mitigate WARN_ON() DoS risks.

 net/l2tp/l2tp_ppp.c | 82 +++++++++++++++++++++++++++------------------
 1 file changed, 50 insertions(+), 32 deletions(-)

diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index 99d6582f41de..e0b1915be1a6 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -1045,64 +1045,76 @@ static int pppol2tp_ioctl(struct socket *sock, unsigned int cmd,
 {
 	struct pppol2tp_ioc_stats stats;
 	struct l2tp_session *session;
+	int err = 0;
+
+	session = pppol2tp_sock_to_session(sock->sk);
 
+	/* Validate session presence and magic integrity ONLY for commands
+	 * that belong to L2TP and require a valid session.
+	 */
 	switch (cmd) {
 	case PPPIOCGMRU:
 	case PPPIOCGFLAGS:
-		session = sock->sk->sk_user_data;
+	case PPPIOCSMRU:
+	case PPPIOCSFLAGS:
+	case PPPIOCGL2TPSTATS:
 		if (!session)
 			return -ENOTCONN;
 
-		if (WARN_ON(session->magic != L2TP_SESSION_MAGIC))
+		if (session->magic != L2TP_SESSION_MAGIC) {
+			l2tp_session_put(session);
 			return -EBADF;
+		}
+		break;
+	default:
+		break;
+	}
 
+	switch (cmd) {
+	case PPPIOCGMRU:
+	case PPPIOCGFLAGS:
 		/* Not defined for tunnels */
-		if (!session->session_id && !session->peer_session_id)
-			return -ENOSYS;
+		if (!session->session_id && !session->peer_session_id) {
+			err = -ENOSYS;
+			break;
+		}
 
-		if (put_user(0, (int __user *)arg))
-			return -EFAULT;
+		if (put_user(0, (int __user *)arg)) {
+			err = -EFAULT;
+			break;
+		}
 		break;
 
 	case PPPIOCSMRU:
 	case PPPIOCSFLAGS:
-		session = sock->sk->sk_user_data;
-		if (!session)
-			return -ENOTCONN;
-
-		if (WARN_ON(session->magic != L2TP_SESSION_MAGIC))
-			return -EBADF;
-
 		/* Not defined for tunnels */
-		if (!session->session_id && !session->peer_session_id)
-			return -ENOSYS;
+		if (!session->session_id && !session->peer_session_id) {
+			err = -ENOSYS;
+			break;
+		}
 
-		if (!access_ok((int __user *)arg, sizeof(int)))
-			return -EFAULT;
+		if (!access_ok((int __user *)arg, sizeof(int))) {
+			err = -EFAULT;
+			break;
+		}
 		break;
 
 	case PPPIOCGL2TPSTATS:
-		session = sock->sk->sk_user_data;
-		if (!session)
-			return -ENOTCONN;
-
-		if (WARN_ON(session->magic != L2TP_SESSION_MAGIC))
-			return -EBADF;
-
 		/* Session 0 represents the parent tunnel */
 		if (!session->session_id && !session->peer_session_id) {
 			u32 session_id;
-			int err;
 
 			if (copy_from_user(&stats, (void __user *)arg,
-					   sizeof(stats)))
-				return -EFAULT;
+					   sizeof(stats))) {
+				err = -EFAULT;
+				break;
+			}
 
 			session_id = stats.session_id;
 			err = pppol2tp_tunnel_copy_stats(&stats,
 							 session->tunnel);
 			if (err < 0)
-				return err;
+				break;
 
 			stats.session_id = session_id;
 		} else {
@@ -1112,15 +1124,21 @@ static int pppol2tp_ioctl(struct socket *sock, unsigned int cmd,
 		stats.tunnel_id = session->tunnel->tunnel_id;
 		stats.using_ipsec = l2tp_tunnel_uses_xfrm(session->tunnel);
 
-		if (copy_to_user((void __user *)arg, &stats, sizeof(stats)))
-			return -EFAULT;
+		if (copy_to_user((void __user *)arg, &stats, sizeof(stats))) {
+			err = -EFAULT;
+			break;
+		}
 		break;
 
 	default:
-		return -ENOIOCTLCMD;
+		err = -ENOIOCTLCMD;
+		break;
 	}
 
-	return 0;
+	if (session)
+		l2tp_session_put(session);
+
+	return err;
 }
 
 /*****************************************************************************
-- 
2.54.0.746.g67dd491aae-goog


