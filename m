Return-Path: <netdev+bounces-109705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8449D929A18
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 00:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F45228103B
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 22:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BDF56766;
	Sun,  7 Jul 2024 22:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="eYc5oiyL"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0981B970
	for <netdev@vger.kernel.org>; Sun,  7 Jul 2024 22:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720392410; cv=none; b=r8K/JdlD5vX7a7cy3egcvLKc4RehR4dXjfaIRjV9OqSP+AYMNxNBSFr43SUre2b14XrzlJAHAT146Y3EvEpaKPoqqtfFxQXxEcn4CJpy9IrN8vpi62rg0RckQSugZ6I7Ckzgyn3+E43U3xyD+m0DF0eajYkdtxpD8v0G5WGdnDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720392410; c=relaxed/simple;
	bh=YN77VaJ7VVTFbS0RwmicdTZQvRTVuESW3tR6Mgbd/JQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgUz9UPTkXxK8DswGy/BNenuQ0peEDRVhAiT9Gx1bgXBTY07VX+VbpVfYOXPnFCIklcLgRxzOZ0hnOPH2xr6V+7nu15kzrAUPYanal1NjwDvgRnX88/RzcVFYJWnZUuTEznKceD13cbCgWxTW3RT+cvg0Pnvoy0703QS96UxOQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=eYc5oiyL; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sQaNu-00Eptk-LJ; Mon, 08 Jul 2024 00:29:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From;
	bh=AMRMfwTLPNxsgjKocG+YNGakQaPHJC19gcwx9Mcwiko=; b=eYc5oiyLVPgga9eoxIOhpZdPH8
	eaKzwmhtyPAhqagVdoddnKdyiWaMtc91QKtZCSW+HtFI1PBD2iEdl8aVNp6/HwUaLze1n/DrKc2vc
	f95xMLTJegt3CPah9R0gNAlsrlLUZmVuE9ouzZfcxSJ4IEvtBBq7Fu67oz2ygUc6clPc/2jJP7VjT
	+tpMYNMUIEPBuwMsweTUaxWu/Pom4AtKJO2+lYriXucvhALu0DtTeQDikc4dA2dzMT2+6ZxSOHtj/
	72A3n2mXoALdbrFdZ7bjxkU+ShVnM/9UcDZns70kCL1sN2BnX9+xGrf/x9h/y18+2bPIy5cuR0WzR
	z5ncyKog==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sQaNu-0003NZ-8H; Mon, 08 Jul 2024 00:29:30 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sQaNa-009IHx-SA; Mon, 08 Jul 2024 00:29:10 +0200
From: Michal Luczaj <mhal@rbox.co>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	kuniyu@amazon.com,
	Rao.Shoaib@oracle.com,
	cong.wang@bytedance.com,
	Michal Luczaj <mhal@rbox.co>
Subject: [PATCH bpf v3 2/4] selftest/bpf: Support SOCK_STREAM in unix_inet_redir_to_connected()
Date: Sun,  7 Jul 2024 23:28:23 +0200
Message-ID: <20240707222842.4119416-3-mhal@rbox.co>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240707222842.4119416-1-mhal@rbox.co>
References: <20240707222842.4119416-1-mhal@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Function ignores the AF_INET socket type argument, SOCK_DGRAM is hardcoded.
Fix to respect the argument provided.

Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/selftests/bpf/prog_tests/sockmap_listen.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index e91b59366030..c075d376fcab 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -1828,7 +1828,7 @@ static void unix_inet_redir_to_connected(int family, int type,
 	if (err)
 		return;
 
-	if (socketpair(AF_UNIX, SOCK_DGRAM | SOCK_NONBLOCK, 0, sfd))
+	if (socketpair(AF_UNIX, type | SOCK_NONBLOCK, 0, sfd))
 		goto close_cli0;
 	c1 = sfd[0], p1 = sfd[1];
 
@@ -1840,7 +1840,6 @@ static void unix_inet_redir_to_connected(int family, int type,
 close_cli0:
 	xclose(c0);
 	xclose(p0);
-
 }
 
 static void unix_inet_skb_redir_to_connected(struct test_sockmap_listen *skel,
-- 
2.45.2


