Return-Path: <netdev+bounces-293932-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHeCCAskHmoohgkAu9opvQ
	(envelope-from <netdev+bounces-293932-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 02:30:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F5D6268D4
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 02:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88896300828A
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 00:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861A72E2DF2;
	Tue,  2 Jun 2026 00:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="emTMC40q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DF22C029D;
	Tue,  2 Jun 2026 00:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780360196; cv=none; b=B83HSM45exuURUX3RGVSdG7q51HIwhllfC3MwEeCwWMwgL55IkRBqLbk3JfPFVF5d5kQXGB5a+6oXD3fZSxk3QroO5wVsCwHwSs0Pl5cgqZ9p4fRpNMhSQs4bbdTlU3i4G3YZ+rtUdpGnOD0/F4KYt6a3cG6/y3KQz3s5e0tpwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780360196; c=relaxed/simple;
	bh=4Uwehhbo7B2anv5JiXyrOzwLm1Of00wQ3PUTHxPrC6E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MAEtdckxXzMrf5zeSZsIZddMQLfAFZH35YEBKUaNeZ44dTdNUvgM2GydL325UgLG2IHqUzjf6DB1FuwBpCppLx8WWj283S/VSXmhzp7Xjk8YY8ZKkicrPPb5Gps469yGDTdu5t8YihTnRgs1iXDg1BIFfn+HJW96VZelT7wvVss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=emTMC40q; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 40a8c3caf;
	Tue, 2 Jun 2026 08:24:34 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	edumazet@google.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	runyu.xiao@seu.edu.cn
Subject: [PATCH net v2] ipv6: use READ_ONCE() for bindv6only default in inet6_create()
Date: Tue,  2 Jun 2026 08:24:14 +0800
Message-Id: <20260602002414.1504106-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e85b7c62103a1kunmbd764a6114f2d5
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDSk0dVklNHh5MSk1MSR4ZSFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSU
	hOQ0NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=emTMC40qEA0HJ8B8Gf8pqKy5PuDI0/P8loulVudkRSvIN7kyK7mr8dCVoQvfSBVgCKjOYBIlreXQpDpMbsrziurXjaUVtqix7JLtkPJb4+8F0NBV54udBHxP9CI/kN+JevSaklSTysFPDPNCi1upE0f/jnM4LfOPucOodyDR0Xk=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=O0lEsgmG7jjp0S0PazzP2vtRhdGSUANPfEdz9qWrOFA=;
	h=date:mime-version:subject:message-id:from;
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293932-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[runyu.xiao@seu.edu.cn,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 42F5D6268D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

inet6_create() reads net->ipv6.sysctl.bindv6only locklessly.

Use READ_ONCE() for this sysctl access.
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
v2:
- Shorten the commit message per review feedback
- Drop the Fixes and stable CC trailers

 net/ipv6/af_inet6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 0a88b376141d..79fc6ce6ff77 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -211,7 +211,7 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 	np->pmtudisc	= IPV6_PMTUDISC_WANT;
 	inet6_assign_bit(REPFLOW, sk, READ_ONCE(net->ipv6.sysctl.flowlabel_reflect) &
 				      FLOWLABEL_REFLECT_ESTABLISHED);
-	sk->sk_ipv6only	= net->ipv6.sysctl.bindv6only;
+	sk->sk_ipv6only	= READ_ONCE(net->ipv6.sysctl.bindv6only);
 	sk->sk_txrehash = READ_ONCE(net->core.sysctl_txrehash);
 
 	/* Init the ipv4 part of the socket since we can have sockets
-- 
2.34.1

