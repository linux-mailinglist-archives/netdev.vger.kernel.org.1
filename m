Return-Path: <netdev+bounces-293600-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OF/+HoM6HWoqWQkAu9opvQ
	(envelope-from <netdev+bounces-293600-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 09:53:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CADE461B20E
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 09:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 160CB300735E
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 07:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39C63876B5;
	Mon,  1 Jun 2026 07:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="V2lLDlOF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DA5382385;
	Mon,  1 Jun 2026 07:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780300047; cv=none; b=h2egf8YLcmqSZ+D7Ug6HBAyZ9/mh/mzz63YX7XFwgDd6M3C84hBfVVFUzrZK5+c51aY2E/wB8dXfCo8iFsDyh21hpocPDkJCiM/aTnIj9L0VGjGmaHdyXoh8FqXOKkd/PulD8EsZIX65JALHX1Dm7xVri2Z/7etjn1Q+If7/yMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780300047; c=relaxed/simple;
	bh=VuT82U/yyx3Sk0pkvgQRFRX1c6I1DB1p3ZWFHx6HcvU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hea+42mQpOBoZOt+Lo31jFpnqK+a9e/LAaMRQXEP89Uv9Y31ywVb/QLJBVI+x4WLHOgGUk3rJBCQ0Pza1GoAVPmZgkK+0wVMPkzn4KQH29lkMQjtPb/FeZYd4Ov8fLJ82OmujIX3kJQ4KvtkdSToUGtJbXeBvqOy8kZVmnw3U0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=V2lLDlOF; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from PC-202605011814.localdomain (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 408fa7910;
	Mon, 1 Jun 2026 15:42:09 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	runyu.xiao@seu.edu.cn
Subject: [PATCH net] raw: annotate data-races in raw_v6_match()
Date: Mon,  1 Jun 2026 15:42:01 +0800
Message-Id: <20260601074201.1186061-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e82220a7103a1kunm09303ace12fec2
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTUpOVkwfSBpOGUxDTRhPGlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktJSE
	5DQ1VKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
	b=V2lLDlOFMYSj5R4KIr2vechQL66dSUZPcukkDM11oRCRHnOTFhgxunXsHnfzM0ANgqCAlrEE6tCNho5Jl65DTn5s1uhOE9gMH9NkOJmoVOhLM5JOfVW80bKmUS7ieOK42FtTNmnzGStCv9ZXmcjkEjhqPQ82mZ5iRK+2wog8uVY=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=ssIjgTwnxtI7gTWj0MyLH2uLjQ0cy90l/wuj88XAczs=;
	h=date:mime-version:subject:message-id:from;
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293600-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[runyu.xiao@seu.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CADE461B20E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

raw_v6_match() is a lockless match helper under sk_for_each_rcu()
and still reads inet_sk(sk)->inet_num, sk->sk_bound_dev_if,
sk->sk_v6_daddr and sk->sk_v6_rcv_saddr with plain loads.

Add READ_ONCE() annotations for these fields.

Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 net/ipv6/raw.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 3cc58698cbbd..7160d5513742 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -64,20 +64,37 @@
 struct raw_hashinfo raw_v6_hashinfo;
 EXPORT_SYMBOL_GPL(raw_v6_hashinfo);
 
+static void raw_v6_addr_snapshot(struct in6_addr *dst,
+				 const struct in6_addr *src)
+{
+	dst->s6_addr32[0] = READ_ONCE(src->s6_addr32[0]);
+	dst->s6_addr32[1] = READ_ONCE(src->s6_addr32[1]);
+	dst->s6_addr32[2] = READ_ONCE(src->s6_addr32[2]);
+	dst->s6_addr32[3] = READ_ONCE(src->s6_addr32[3]);
+}
+
 bool raw_v6_match(struct net *net, const struct sock *sk, unsigned short num,
 		  const struct in6_addr *loc_addr,
 		  const struct in6_addr *rmt_addr, int dif, int sdif)
 {
-	if (inet_sk(sk)->inet_num != num ||
+	unsigned short match_num = READ_ONCE(inet_sk(sk)->inet_num);
+	int match_bound_dev_if = READ_ONCE(sk->sk_bound_dev_if);
+	struct in6_addr match_daddr;
+	struct in6_addr match_rcv_saddr;
+
+	raw_v6_addr_snapshot(&match_daddr, &sk->sk_v6_daddr);
+	raw_v6_addr_snapshot(&match_rcv_saddr, &sk->sk_v6_rcv_saddr);
+
+	if (match_num != num ||
 	    !net_eq(sock_net(sk), net) ||
-	    (!ipv6_addr_any(&sk->sk_v6_daddr) &&
-	     !ipv6_addr_equal(&sk->sk_v6_daddr, rmt_addr)) ||
-	    !raw_sk_bound_dev_eq(net, sk->sk_bound_dev_if,
+	    (!ipv6_addr_any(&match_daddr) &&
+	     !ipv6_addr_equal(&match_daddr, rmt_addr)) ||
+	    !raw_sk_bound_dev_eq(net, match_bound_dev_if,
 				 dif, sdif))
 		return false;
 
-	if (ipv6_addr_any(&sk->sk_v6_rcv_saddr) ||
-	    ipv6_addr_equal(&sk->sk_v6_rcv_saddr, loc_addr) ||
+	if (ipv6_addr_any(&match_rcv_saddr) ||
+	    ipv6_addr_equal(&match_rcv_saddr, loc_addr) ||
 	    (ipv6_addr_is_multicast(loc_addr) &&
 	     inet6_mc_check(sk, loc_addr, rmt_addr)))
 		return true;
-- 
2.34.1

