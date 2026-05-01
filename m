Return-Path: <netdev+bounces-283218-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPGqM3XM9GkDFAIAu9opvQ
	(envelope-from <netdev+bounces-283218-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 17:53:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 902E74ADBD5
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 17:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 192B03016D1E
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 15:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0978D3D0925;
	Fri,  1 May 2026 15:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="LwvONb9C"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC30255F2D;
	Fri,  1 May 2026 15:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777650796; cv=none; b=EOQ9Q03sGNAtD38Dvph0rzwc8d5QkeQ+OMN9eKHpH9TLcoX0fiAfDx3GqJVG2CrclvQ/1rTvv7IJD5I86F+bkvJiYkEpe7HOr3KgrNuMWBAZzdUwY1McYpzn94NDi5iEOGs4LO/rNVhgu9g6v0QSrToyJmDsx3UsdCQm7vjcRBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777650796; c=relaxed/simple;
	bh=2RzQAc1xCBTOApgSCT3b/XDOkjZpHj50sn+KhiO7Kv0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ue3NJqBBP8NTk9bw+83senZIqBydC36c9tCjjq6gZByW7661xp1X9BKX3i59O25wsNGvtroYuWpt3KMCCCX9qJzDLplQudsUIFW0DhRUqwtcabg3iorfDKgfJxkbriozwKmb6B5BBaMREccZ8P5WrtWRmWlUxKhA3Y0Es0NsbKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=LwvONb9C; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=wk6HrIetaG5h57CrSbWNYYlAjHlopMNgZIksPE136dQ=; b=LwvONb9CPQQlR7vWdEvRkY4wws
	7gGbHNYxpdvSMLWAZvjhKMXIfbnSFfcPeCDSoMaWKrw8TdqTMwI+bX/22HyKGfX/HsUszFgJfgjbK
	NdAn5I2ZnY3NVzlIlDHR1458jglJX4p0950pwcDMSHPeDgWCb7LIPrl23yK6B+TJgBIkOOiveFc1S
	BMrdr9q2HuOndbFAxIpsL1Oiri8vT3NBWqYeexsRNIyZ7Qf2O0dMNPJfdlkawlKMGR0q73eoZ39XD
	cGemnjslRL7J00b+wLL2Ht3jUYExo1MRmEaiRIyu2E5NY4YeKxrAhwMud62gEDuhsBDmM7Ov/VV/K
	EikDVXtw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wIqAy-008gXq-1b;
	Fri, 01 May 2026 15:53:12 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 01 May 2026 08:52:51 -0700
Subject: [PATCH net-next 1/3] netlink: convert to getsockopt_iter
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-getsock_one-v1-1-810ce23ea70e@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3187; i=leitao@debian.org;
 h=from:subject:message-id; bh=2RzQAc1xCBTOApgSCT3b/XDOkjZpHj50sn+KhiO7Kv0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp9MxeOV3EhrpJhtSFkKpq6NyBuuzMgfbR2eN4m
 MnyhjsFZrOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCafTMXgAKCRA1o5Of/Hh3
 bXDrD/kBVcq49jX6TQWTuCp94RKqjrrsPW2Bi5tVQQQaG35DyS+Nmp1yeVXXCsoys6m88H5hdro
 RQelY2vgG/k4qIdc+SIClvFua6QYgOtUDvnVJR6ciWqC9bvt4uzG1pBz7cTPWTnF1ly5uJTok3H
 KgoGcLIYlmprQdtPy3fWYplo/zdLw6DCNzMchb91EPT4eieDF3zdFPSqLHGgMh0Jy9gtMgvi2Pm
 7T97f82k9ltLbtbaFyZV5dMfNKhypYOHGZPs4GTKb5QsNtMZv0jCPDFnYcHI2SzE8eBD9E2YxpW
 9c9+U9SdqKZi38tDDKWC0qUpCFoep/MGqbnCFniGT5ZBVjl39xxqxBthYGCdv6hBvLZrrD9jla4
 iTzNmNrIJAeynw2/k6/D+aIyXB9cJSzHBYDITeNcjwPPbwW5hht/YgLtVJN3y1d7mtzt39sg4eM
 rdjluoC3Cf6peF5hEobI7P/30NnR45Y1OpVDZfXMvzkjO9IkKuravOob4W9Zf1Kg0tzWF91Vvt3
 JdxP6TS0RQi8Md2BpYXtzfaaGUcpNbPQ7hwU1mI4tgNMHXQ/4tzlSOmzy1jcl7aNDVwcnW89lA1
 OAu9UQsgNLdlbqM4P5oVflIac51Oukbkj35EdmgMThkCimRiCG3fy4N5RxcjoZKiYhUrln0sHsr
 YfV3d5IlP7mbfwA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: 902E74ADBD5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283218-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Convert AF_NETLINK's getsockopt implementation to use the new
getsockopt_iter callback with sockopt_t.

Key changes:
- Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
- Use opt->optlen for buffer length (input) and returned size (output)
- Use copy_to_iter() instead of put_user()/copy_to_user()
- For NETLINK_LIST_MEMBERSHIPS: walk the groups bitmap and emit each
  u32 sequentially via copy_to_iter(), then set opt->optlen to the
  total size required (ALIGN(BITS_TO_BYTES(ngroups), sizeof(u32))).
  The wrapper writes opt->optlen back to userspace even on partial
  failure, preserving the existing API that lets userspace discover
  the needed allocation size.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/netlink/af_netlink.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 2aeb0680807d6..db3be485b4804 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -39,6 +39,7 @@
 #include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
+#include <linux/uio.h>
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
 #include <linux/rtnetlink.h>
@@ -1716,18 +1717,18 @@ static int netlink_setsockopt(struct socket *sock, int level, int optname,
 }
 
 static int netlink_getsockopt(struct socket *sock, int level, int optname,
-			      char __user *optval, int __user *optlen)
+			      sockopt_t *opt)
 {
 	struct sock *sk = sock->sk;
 	struct netlink_sock *nlk = nlk_sk(sk);
 	unsigned int flag;
 	int len, val;
+	u32 group;
 
 	if (level != SOL_NETLINK)
 		return -ENOPROTOOPT;
 
-	if (get_user(len, optlen))
-		return -EFAULT;
+	len = opt->optlen;
 	if (len < 0)
 		return -EINVAL;
 
@@ -1751,14 +1752,14 @@ static int netlink_getsockopt(struct socket *sock, int level, int optname,
 
 			idx = pos / sizeof(unsigned long);
 			shift = (pos % sizeof(unsigned long)) * 8;
-			if (put_user((u32)(nlk->groups[idx] >> shift),
-				     (u32 __user *)(optval + pos))) {
+			group = (u32)(nlk->groups[idx] >> shift);
+			if (copy_to_iter(&group, sizeof(u32),
+					 &opt->iter_out) != sizeof(u32)) {
 				err = -EFAULT;
 				break;
 			}
 		}
-		if (put_user(ALIGN(BITS_TO_BYTES(nlk->ngroups), sizeof(u32)), optlen))
-			err = -EFAULT;
+		opt->optlen = ALIGN(BITS_TO_BYTES(nlk->ngroups), sizeof(u32));
 		netlink_unlock_table();
 		return err;
 	}
@@ -1784,8 +1785,8 @@ static int netlink_getsockopt(struct socket *sock, int level, int optname,
 	len = sizeof(int);
 	val = test_bit(flag, &nlk->flags);
 
-	if (put_user(len, optlen) ||
-	    copy_to_user(optval, &val, len))
+	opt->optlen = len;
+	if (copy_to_iter(&val, len, &opt->iter_out) != len)
 		return -EFAULT;
 
 	return 0;
@@ -2813,7 +2814,7 @@ static const struct proto_ops netlink_ops = {
 	.listen =	sock_no_listen,
 	.shutdown =	sock_no_shutdown,
 	.setsockopt =	netlink_setsockopt,
-	.getsockopt =	netlink_getsockopt,
+	.getsockopt_iter = netlink_getsockopt,
 	.sendmsg =	netlink_sendmsg,
 	.recvmsg =	netlink_recvmsg,
 	.mmap =		sock_no_mmap,

-- 
2.52.0


