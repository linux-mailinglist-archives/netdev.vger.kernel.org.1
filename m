Return-Path: <netdev+bounces-287101-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yI2ODIwLA2pmzwEAu9opvQ
	(envelope-from <netdev+bounces-287101-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:14:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2125F51F283
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1FE1E301B06B
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB314C6F17;
	Tue, 12 May 2026 11:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="B7UxfAtN"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A6B48C8DE;
	Tue, 12 May 2026 11:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778584367; cv=none; b=NttV5gcb3WYgympW5iPQj36zPZGO5ftf35RRM09K3o5GN5WINtt0lB3EwgqdeXXocZ4gSfhhB3LNLRygAkOU25fd8rdke69p1jjpvLVq3JMi7HZMWdUbvg4imKXBypBisR1h5d6Vf/qZlEu+HTM9WtKzZYsf45QGYo2OL/OpWFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778584367; c=relaxed/simple;
	bh=HK+Sfftx5xMXf/ohhSVSyX4kM0dUiUEr9WG/OrDiAs0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s+o4QepU/SdakaCdZFZb6qPOq29tBe1mC8k9t1+r+wUCM3UzrpZl6qLDF+H9RtPcDeXtLicKuJNabWcRICSTQQlL7+5tTlHed64t5ga2A7mujxJjmbSBAjRs7LVLys+HbJA7PKjjXz9F39eL0jH9VWfs9hOPv7wmpQkhx1Qdk6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=B7UxfAtN; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=sNHiQxq5X7Gs6FyItbbqpwShrdRtmwW2a3t0q+1JSZQ=; b=B7UxfAtNONy69D8f7EEyNm6204
	h7bbFNSOWZpMxyN03jbln7IBzR9b9bhRRr9l81C8+7dpAktnLN34aEPF+x25TTW8kukftW3Bhs6OF
	qqeDThWQJNwwZO6IqKco+i1X4r40Fza5qnJMVtgM5mCEvgumCF8E+jDNgR9i/UHnOeHtQ6hY1FWVE
	OnqrQ5Xg+uo7iude5+z9jPfJeEnz0HBJ856elPS/pwfnTCxic6HZNGRwLzB7Q490rg+hd2kt4Io4i
	iz6E+efWF0xqWP3BZWiqrrocLNdkXjCnP7yZIh53dN3AIiG4M/svqp/f+Nm6GZiw/hpC1yR71mehr
	kUX+O4oQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wMl2W-002Kqu-36;
	Tue, 12 May 2026 11:12:41 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 12 May 2026 04:12:17 -0700
Subject: [PATCH net-next v2 2/6] Bluetooth: hci_sock: convert to
 getsockopt_iter
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-getsock_three-v2-2-30b7b22ef14c@debian.org>
References: <20260512-getsock_three-v2-0-30b7b22ef14c@debian.org>
In-Reply-To: <20260512-getsock_three-v2-0-30b7b22ef14c@debian.org>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=3818; i=leitao@debian.org;
 h=from:subject:message-id; bh=HK+Sfftx5xMXf/ohhSVSyX4kM0dUiUEr9WG/OrDiAs0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqAwsbGmfHz2HnWNFsHbzsK7EdpZyQCiqUwas6U
 N6aBnCuOECJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagMLGwAKCRA1o5Of/Hh3
 bTNPD/sHnTvtkff+PCBtG6N+tawpf4284y16XGZzDhT91hIfn/cA+ZzbCnUi6CONbtl0qs9bhj3
 Vk71pcVACGrnMrFLMuXYW/VFwsx/+5+fzo/TnNpJ+GFf2nzxqw/U5ts3vYOJTHixPO2VMyZvC80
 Zmj5R92fEM8KM9EgE+n6SC0HsxMJnfo5gtmuyABzr9eMe6afO4uRPE16YvpyRPL6DPVrmi6EhC5
 1OC1XzUid3Rya7oMBAIh8+41kHeyk8u9JuMEy07xU/5lzNi1aLLyLf52uRi+Ty2DS9eVgIlnBH4
 Fof3bByuaUEI/iLyEfBG9nM4veMvRuTI+vnz7RdtfnbyHhxB7NgAma7jU8T4gDvE7J8rx0/VdDJ
 mqF6gWa085P2vhupJA+ibpUhmTkFAOCDNIMEO9IU0I9lV/1bUQpJsM88qM2DksZMplnHO7BbMtd
 mBcemkVBA9YCCVzd0PHrdZzZGyaRgWP9Mf7Qdda8bQUOzWuLoWY/dLysRs7AmHnB/SzTLywWbWw
 h4bB2EDqRHNkEisewm9NmW5ICpCSzV4PDI4Al19/f7WbUY2zWTXG0dnRBNvUs23JXDdc3dKkgBD
 7VmJ96fNmjItgzciJo2bbz/K0/0hiWcTW2OI6Xp89E/TlIHfK6CwaT1joLklWYvYGe7JSvck728
 gZ3cV+BdihMdOQg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: 2125F51F283
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287101-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Convert HCI socket's getsockopt implementation to use the new
getsockopt_iter callback with sockopt_t.

Key changes:
- Replace (char __user *optval, int __user *optlen) with sockopt_t *sopt
- Use sopt->optlen for buffer length (input)
- Use copy_to_iter() instead of put_user()/copy_to_user()
- Add linux/uio.h for copy_to_iter()

The sockopt_t parameter is named sopt rather than opt to avoid
collision with the existing local int opt used by HCI_DATA_DIR and
HCI_TIME_STAMP.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/bluetooth/hci_sock.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 1823c06ba8940..61fec674a2078 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -27,6 +27,7 @@
 #include <linux/export.h>
 #include <linux/utsname.h>
 #include <linux/sched.h>
+#include <linux/uio.h>
 #include <linux/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
@@ -2063,7 +2064,7 @@ static int hci_sock_setsockopt(struct socket *sock, int level, int optname,
 }
 
 static int hci_sock_getsockopt_old(struct socket *sock, int level, int optname,
-				   char __user *optval, int __user *optlen)
+				   sockopt_t *sopt)
 {
 	struct hci_ufilter uf;
 	struct sock *sk = sock->sk;
@@ -2071,8 +2072,7 @@ static int hci_sock_getsockopt_old(struct socket *sock, int level, int optname,
 
 	BT_DBG("sk %p, opt %d", sk, optname);
 
-	if (get_user(len, optlen))
-		return -EFAULT;
+	len = sopt->optlen;
 
 	lock_sock(sk);
 
@@ -2088,7 +2088,8 @@ static int hci_sock_getsockopt_old(struct socket *sock, int level, int optname,
 		else
 			opt = 0;
 
-		if (put_user(opt, (int __user *)optval))
+		if (copy_to_iter(&opt, sizeof(opt), &sopt->iter_out) !=
+		    sizeof(opt))
 			err = -EFAULT;
 		break;
 
@@ -2098,7 +2099,8 @@ static int hci_sock_getsockopt_old(struct socket *sock, int level, int optname,
 		else
 			opt = 0;
 
-		if (put_user(opt, (int __user *)optval))
+		if (copy_to_iter(&opt, sizeof(opt), &sopt->iter_out) !=
+		    sizeof(opt))
 			err = -EFAULT;
 		break;
 
@@ -2114,7 +2116,7 @@ static int hci_sock_getsockopt_old(struct socket *sock, int level, int optname,
 		}
 
 		len = min_t(unsigned int, len, sizeof(uf));
-		if (copy_to_user(optval, &uf, len))
+		if (copy_to_iter(&uf, len, &sopt->iter_out) != len)
 			err = -EFAULT;
 		break;
 
@@ -2129,16 +2131,16 @@ static int hci_sock_getsockopt_old(struct socket *sock, int level, int optname,
 }
 
 static int hci_sock_getsockopt(struct socket *sock, int level, int optname,
-			       char __user *optval, int __user *optlen)
+			       sockopt_t *sopt)
 {
 	struct sock *sk = sock->sk;
 	int err = 0;
+	u16 mtu;
 
 	BT_DBG("sk %p, opt %d", sk, optname);
 
 	if (level == SOL_HCI)
-		return hci_sock_getsockopt_old(sock, level, optname, optval,
-					       optlen);
+		return hci_sock_getsockopt_old(sock, level, optname, sopt);
 
 	if (level != SOL_BLUETOOTH)
 		return -ENOPROTOOPT;
@@ -2148,7 +2150,9 @@ static int hci_sock_getsockopt(struct socket *sock, int level, int optname,
 	switch (optname) {
 	case BT_SNDMTU:
 	case BT_RCVMTU:
-		if (put_user(hci_pi(sk)->mtu, (u16 __user *)optval))
+		mtu = hci_pi(sk)->mtu;
+		if (copy_to_iter(&mtu, sizeof(mtu), &sopt->iter_out) !=
+		    sizeof(mtu))
 			err = -EFAULT;
 		break;
 
@@ -2185,7 +2189,7 @@ static const struct proto_ops hci_sock_ops = {
 	.listen		= sock_no_listen,
 	.shutdown	= sock_no_shutdown,
 	.setsockopt	= hci_sock_setsockopt,
-	.getsockopt	= hci_sock_getsockopt,
+	.getsockopt_iter = hci_sock_getsockopt,
 	.connect	= sock_no_connect,
 	.socketpair	= sock_no_socketpair,
 	.accept		= sock_no_accept,

-- 
2.53.0-Meta


