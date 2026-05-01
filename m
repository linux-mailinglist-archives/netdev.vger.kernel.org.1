Return-Path: <netdev+bounces-283219-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFxgBMDM9GkDFAIAu9opvQ
	(envelope-from <netdev+bounces-283219-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 17:54:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7901A4ADC09
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 17:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2E6D303F459
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 15:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FE73D3486;
	Fri,  1 May 2026 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="YrsSLkVt"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142E63D3329;
	Fri,  1 May 2026 15:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777650800; cv=none; b=bBZ/49HvAtKAdJhA/thsUl0dn35JvbzxuSsa67uruvrorQeOc+QdCgHQEFTxVdgL34xVDnomhayPCE4vGTo6Wa3ZND2CxgOUSKteY7p8g0uZKYXeQSsX+9rBnoLhFuyksCi39ebqSnE8HV6CT2dKazF9k396rHd8EwA5LD3Tyz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777650800; c=relaxed/simple;
	bh=nKqsENwt7zl8D64Zk3SgAIA9zAPWDo4dhBidlktOtXI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r6EEjvcakMQOEK1ASWgk2mWug29iv8ar3Vaer8s/JT41TcTWzZdzWCDZjlt9ZSpNebx6xXeXqa0NIGefSR3EsqyFS8P0kQvGNPuoaARe9cfx7wT3mgt0gsfR8B65bHSp62SSGrvqRmvxImUtmo4mHna/1Mo/2fUmgzzAvjT7uUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=YrsSLkVt; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=qcrw3v+wIZaPGl3hCbJKV0pWXoH63HuPgzadTbwie7w=; b=YrsSLkVtG1xSAfIy/1Xw71I40E
	HbHDMURh41pZdvCpuARnaSo7rxGtlgeYV0uwAt4ODI7L7p+/APOaDx9KnTgZ0X4C3AyoJ5Jr9Iwlf
	AIRH8rM1VsT0RfgzPsu0qRbhjqnNTgGEggJE3bIrajWdkdKdGh9eryO4yX4CIrU5kTgwEdIi4pPxD
	qwkodR0xVcp/EUyL0aLVKejo8+bqeMVK/FamEEm9/LuvZ6XPvwb/JN9l9NFJHztZgltMoAbLRFTPA
	EHMSo7e2nK5+usEptjkOuP1P7nKUc2IOBcvU6oTfVj3l3/2tfOgeUWLzgpBcCp2WgEFSooQhGW0Ou
	QAjrQK5w==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wIqB2-008gXs-2j;
	Fri, 01 May 2026 15:53:17 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 01 May 2026 08:52:52 -0700
Subject: [PATCH net-next 2/3] vsock: convert to getsockopt_iter
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-getsock_one-v1-2-810ce23ea70e@debian.org>
References: <20260501-getsock_one-v1-0-810ce23ea70e@debian.org>
In-Reply-To: <20260501-getsock_one-v1-0-810ce23ea70e@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 sdf.kernel@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=2745; i=leitao@debian.org;
 h=from:subject:message-id; bh=nKqsENwt7zl8D64Zk3SgAIA9zAPWDo4dhBidlktOtXI=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp9MxeICUvzlYmvxzVQM9PPYGIrdo2NwL0xtO6W
 H0xx4Sa8HmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCafTMXgAKCRA1o5Of/Hh3
 bV+MD/sGxW0tC4svuAbveKyUQ+ATkRZuctf8c6iTSjPdhol0xh277kVmoZ7jE90rwn3sCTe5gB4
 dqOpmblR7UNS1DqY+oS2HlFBHU+EoCsVeQvagO9qas+K1f45bq+dycoC3weAS0wXFPqB/q1WmkC
 2RdHJJKmhOoOBDmxix6lfR1PwXoR50JLeuBrnlwkDNen3jsBAq4gkjptnAfQPrxprs4X+xX4Ck2
 rGQd6r8w2pyLDbzEmFzRa07x4mogS2l2KScF//7QvNZDwEUMPpJm0uvZZBTyLV1BLpHVyMV2I23
 SlCeywDb0QIwllaMjzGOMYZ9UUdImOzzBaK/gLuIxdoqE7bseYH70lGRgWjCK1Pn8ZKUYOQQND5
 8IdWdTo9zkf4nMAjzjTl1XonodbwsHXbRNRhE+/Sf1VXwAlcsdgby/y+RpQ+KmtVJqh6hyM/g1J
 pgzBA7LZMPCJhYdrU+ia27leB9w8uaRfOdED+lBEQU/+OUoeaE0I/fIQNTRIIuhv/9Xl2/uWZkk
 wH5/SCJa5KXLuLkD9k1kQdVnqdWmoZGkRAeE6/TrJzbr5bWbrOX6iEe/buGdFw8Um8+JAkrBMHQ
 buZROQM3gCTxgWnSgxCMyrG4G9OueJuyI+Dd9M+5/hFY81CcWlpq44Jggd2UGc9pS85BDHXV9y0
 sSbSBumXZFLJB/Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: 7901A4ADC09
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283219-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Convert AF_VSOCK's getsockopt implementation to use the new
getsockopt_iter callback with sockopt_t. The single
vsock_connectible_getsockopt() callback is shared by both
vsock_stream_ops and vsock_seqpacket_ops, so both proto_ops are
updated to use .getsockopt_iter.

Key changes:
- Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
- Use opt->optlen for buffer length (input) and returned size (output)
- Use copy_to_iter() instead of put_user()/copy_to_user()

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/vmw_vsock/af_vsock.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 44037b066a5ff..d4a97eeb596e6 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -155,6 +155,7 @@
 #include <linux/random.h>
 #include <linux/skbuff.h>
 #include <linux/smp.h>
+#include <linux/uio.h>
 #include <linux/socket.h>
 #include <linux/stddef.h>
 #include <linux/sysctl.h>
@@ -2091,8 +2092,7 @@ static int vsock_connectible_setsockopt(struct socket *sock,
 
 static int vsock_connectible_getsockopt(struct socket *sock,
 					int level, int optname,
-					char __user *optval,
-					int __user *optlen)
+					sockopt_t *opt)
 {
 	struct sock *sk = sock->sk;
 	struct vsock_sock *vsk = vsock_sk(sk);
@@ -2110,8 +2110,7 @@ static int vsock_connectible_getsockopt(struct socket *sock,
 	if (level != AF_VSOCK)
 		return -ENOPROTOOPT;
 
-	if (get_user(len, optlen))
-		return -EFAULT;
+	len = opt->optlen;
 
 	memset(&v, 0, sizeof(v));
 
@@ -2142,11 +2141,10 @@ static int vsock_connectible_getsockopt(struct socket *sock,
 		return -EINVAL;
 	if (len > lv)
 		len = lv;
-	if (copy_to_user(optval, &v, len))
+	if (copy_to_iter(&v, len, &opt->iter_out) != len)
 		return -EFAULT;
 
-	if (put_user(len, optlen))
-		return -EFAULT;
+	opt->optlen = len;
 
 	return 0;
 }
@@ -2631,7 +2629,7 @@ static const struct proto_ops vsock_stream_ops = {
 	.listen = vsock_listen,
 	.shutdown = vsock_shutdown,
 	.setsockopt = vsock_connectible_setsockopt,
-	.getsockopt = vsock_connectible_getsockopt,
+	.getsockopt_iter = vsock_connectible_getsockopt,
 	.sendmsg = vsock_connectible_sendmsg,
 	.recvmsg = vsock_connectible_recvmsg,
 	.mmap = sock_no_mmap,
@@ -2653,7 +2651,7 @@ static const struct proto_ops vsock_seqpacket_ops = {
 	.listen = vsock_listen,
 	.shutdown = vsock_shutdown,
 	.setsockopt = vsock_connectible_setsockopt,
-	.getsockopt = vsock_connectible_getsockopt,
+	.getsockopt_iter = vsock_connectible_getsockopt,
 	.sendmsg = vsock_connectible_sendmsg,
 	.recvmsg = vsock_connectible_recvmsg,
 	.mmap = sock_no_mmap,

-- 
2.52.0


