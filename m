Return-Path: <netdev+bounces-285249-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLmnAG5w/GmkQAAAu9opvQ
	(envelope-from <netdev+bounces-285249-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 12:58:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0674E7217
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 12:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C9AD53016B7F
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 10:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9807B3EFD34;
	Thu,  7 May 2026 10:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="VSm+c0cD"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049493EF0A0;
	Thu,  7 May 2026 10:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778151503; cv=none; b=g2z7bLtG/IoM8CiIAFOvJ50uqvblRouE1M2NqFUDHMakiaQclbMwTE+4DhW5H0BO6gVNYjob17wO4xRz6hzdRSm6rUIDUWXX11mLPp1t+XMYaUxoSRU+PyN+r7jdgtA8c7w8GW1eDWUp9Fy2QRnaG6MGJuFV5MNvOsEJdl+LEug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778151503; c=relaxed/simple;
	bh=PEiFTTvD5HbPowkM40xyoZftErVoXe3+8eFL12D9lSk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s4k2G7hJZjIZeXAVVpN2RIh/VXMxSP5xqA8ZYFPHMgM7KTbobUSxkUY/EQVNHAvYH/5hURgd9XZXl+gwijs9lzWVHCiv6Gug+BH6IzomINOQr49G4RRmCzkQc9ULluzLXcSiEsP6VQOPi7e7tLUCMD4AhUQeKYsUeqp52tHFLFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=VSm+c0cD; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=B/UCBY8qkZL6VTVSrvN0oMYXSzmxSRwhsEudHIJA8lQ=; b=VSm+c0cDsI+S1uMQLQ8Ba2QizP
	3xs7BI7OS34jI6kf1f9SWoPevJI7/Wg2l3oonyn7Rz9HOgXGTaFfSWOggN3/ynDQRTo567ksPW8Ad
	BtJkvquBfrFIudF4nPfPpCJi1+b/pSp7gafLjh7CU+FAo4SJV+8avUVJ7i/asdZ2HS5FZ4TyLdgs1
	NDjTiR9pES+L3o8CoDD7TggUiqYiRR3fphlE6lzVukKev1OBCQosc2Jy1DdVYgA04MxKNotRfz8ib
	2CTxn3B8/q4D4ClkfXOMj2xKnn3Tml5yYlYJ9ruHEiomCNpCDmn3qrEOv1vOHDQIu6mkjfMcAA6II
	YJhphKPw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wKwQd-004Jnh-0m;
	Thu, 07 May 2026 10:58:03 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 07 May 2026 03:57:50 -0700
Subject: [PATCH net-next v2 1/5] mctp: convert to getsockopt_iter
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-getsock_two-v2-1-5873111d9c12@debian.org>
References: <20260507-getsock_two-v2-0-5873111d9c12@debian.org>
In-Reply-To: <20260507-getsock_two-v2-0-5873111d9c12@debian.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 Matt Johnston <matt@codeconstruct.com.au>, Martin Schiller <ms@dev.tdt.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-x25@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=1952; i=leitao@debian.org;
 h=from:subject:message-id; bh=PEiFTTvD5HbPowkM40xyoZftErVoXe3+8eFL12D9lSk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp/HAw+PqiYlIqu2g+vQIJ4sGKhymICGJH8A5aJ
 LRNKp5QTrGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCafxwMAAKCRA1o5Of/Hh3
 bTGZEACddDVc2ljz8il0FwNf0KPysb2S8zdIcMsQ9TuC+lMyGSoofGhrVy29iY5RnpeVrz3UYCP
 UoO6mFfc12nUH3L2+N2I/IaEgnTKRNT5nLTwwl8qPwi/BGVkK3rl2RGdF78eebhOVxVHJBb2+ps
 u+wxDia38a1dPmnguJRdkEpu42tyErDYCUl7E8Xp24UGHJqEQ+mdsN+61N/NiXmV1fWQQkqeQbZ
 dG9VObmJ5dwAYhy0G7vg8N+aqrrb8m5HL+LN7ooZUmj7frFZbDkLNrcwyt60pZH52BxktiU3ABR
 n963pAmpUOxbGGDi6k/cBBFEeciPAJV/vx30CRjSbbdIYJ+KtiOBPzvhBgrAN0MpA0I73NBPKR2
 K80wt6F6ayb/GyYSfClMQZHOUi0oRXFVNSKfl3dJs+ut7Ve+XJnGQQuJojdZQRqs+ZqBc6a5VOe
 UtK25qzivSsAEdRg3EsqvCw4vqY5annkKGhlh1YtPBBpsUIDMNwN9eighmriyovBAuVD6Swdi0L
 opc9zrgfBOG3zG18/DVLgctvdJZg5rtZDg9QbpJMXzdz1ShRAbU13Srl04sKmh5wtufbwvkE69b
 n5oPE77aSTSmXU4wQvp1yEcsC7gCgLFTVcnFtP2eDcTxuRLO4dtjR5r82wq9OPkMZ6n5+zhdTJN
 VI3iOeCOmvP46yQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: DC0674E7217
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285249-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Convert MCTP socket's getsockopt implementation to use the new
getsockopt_iter callback with sockopt_t.

Key changes:
- Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
- Use opt->optlen for buffer length (input)
- Use copy_to_iter() instead of copy_to_user()
- Add linux/uio.h for copy_to_iter()

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/mctp/af_mctp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
index 209a963112e3a..8af5e2b3c8d12 100644
--- a/net/mctp/af_mctp.c
+++ b/net/mctp/af_mctp.c
@@ -12,6 +12,7 @@
 #include <linux/mctp.h>
 #include <linux/module.h>
 #include <linux/socket.h>
+#include <linux/uio.h>
 
 #include <net/mctp.h>
 #include <net/mctpdevice.h>
@@ -405,7 +406,7 @@ static int mctp_setsockopt(struct socket *sock, int level, int optname,
 }
 
 static int mctp_getsockopt(struct socket *sock, int level, int optname,
-			   char __user *optval, int __user *optlen)
+			   sockopt_t *opt)
 {
 	struct mctp_sock *msk = container_of(sock->sk, struct mctp_sock, sk);
 	int len, val;
@@ -413,14 +414,13 @@ static int mctp_getsockopt(struct socket *sock, int level, int optname,
 	if (level != SOL_MCTP)
 		return -EINVAL;
 
-	if (get_user(len, optlen))
-		return -EFAULT;
+	len = opt->optlen;
 
 	if (optname == MCTP_OPT_ADDR_EXT) {
 		if (len != sizeof(int))
 			return -EINVAL;
 		val = !!msk->addr_ext;
-		if (copy_to_user(optval, &val, len))
+		if (copy_to_iter(&val, len, &opt->iter_out) != len)
 			return -EFAULT;
 		return 0;
 	}
@@ -639,7 +639,7 @@ static const struct proto_ops mctp_dgram_ops = {
 	.listen		= sock_no_listen,
 	.shutdown	= sock_no_shutdown,
 	.setsockopt	= mctp_setsockopt,
-	.getsockopt	= mctp_getsockopt,
+	.getsockopt_iter = mctp_getsockopt,
 	.sendmsg	= mctp_sendmsg,
 	.recvmsg	= mctp_recvmsg,
 	.mmap		= sock_no_mmap,

-- 
2.52.0


