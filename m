Return-Path: <netdev+bounces-114999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9E3944DEE
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFCFD1C22D11
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDC01A489D;
	Thu,  1 Aug 2024 14:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="ZIVPi3qI"
X-Original-To: netdev@vger.kernel.org
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB301171658;
	Thu,  1 Aug 2024 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722522323; cv=none; b=LTyMLohzrR18dNoOgKiep5LLnIeoL+GsagucbqZPJjGmGI/lFLvoQu6N6n1LSCio2FLgs/q+XroIW7UDmQ8I3p2HaTEkR9RQlxnjnrQMBZx2fw4x1WHj5Pm1VDMGpJjKkXHqeopX2cPLBrXdXBFYEl/bov0XDAI3l3+FZaWK7Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722522323; c=relaxed/simple;
	bh=tnPMVDODPErVkXhX7JdHgDvfNxcP2SANWJcEaBq5ZSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LO8yRZeATXQodU1g79dOOHaPPV/3diEH/Kcn2yagHMbAG5MJxoZUTkw7C7sL0T1ksSVquDJ8P84S++uxdSER7ax18whszjuHBJN3UOb9bnpFRYcxrwkdvhIgZyyUTB4QLCLc5HLvBuN3CQeKkSEKLw8kIywsgvBt1Q6JBu9iOQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=ZIVPi3qI; arc=none smtp.client-ip=178.154.239.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:110e:0:640:f58d:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id E2BDB60AF2;
	Thu,  1 Aug 2024 17:25:11 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 9PYaALjHfa60-EttXx6ns;
	Thu, 01 Aug 2024 17:25:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1722522311; bh=PS1gDGUZKZonTsRZRmMbNyVHwQJErXIEm14MkBjHuts=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=ZIVPi3qIA6bkzoiXssrKWzPpHDhlfb2z74txpRdVpRMxuzH4HUDah7szEs0B3nBoF
	 9aqTI1iHkJ4uovyayWlzShfXoaaz+ueMXsTGG/vneNFmbHOec97+/oxmwejJNk4Ry+
	 FADUInPPl3N3IVBZxt2XSr8IaE+t+3QAyg75wDX0=
Authentication-Results: mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A . R . Silva" <gustavo@embeddedor.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kees Cook <kees@kernel.org>,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v3] net: core: annotate socks of struct sock_reuseport with __counted_by
Date: Thu,  1 Aug 2024 17:23:11 +0300
Message-ID: <20240801142311.42837-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to '__reuseport_alloc()', annotate flexible array member
'sock' of 'struct sock_reuseport' with '__counted_by()' and use
convenient 'struct_size()' to simplify the math used in 'kzalloc()'.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v3: one more style nit (Jakub)
    https://lore.kernel.org/netdev/20240731165029.5f4b4e60@kernel.org
v2: style (Jakub), title and commit message (Gustavo) adjustments
    https://lore.kernel.org/netdev/20240730170142.32a6e9aa@kernel.org
    https://lore.kernel.org/netdev/c815078e-67f9-4235-b66c-29f8bdd1a9e0@embeddedor.com
---
 include/net/sock_reuseport.h | 2 +-
 net/core/sock_reuseport.c    | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/net/sock_reuseport.h b/include/net/sock_reuseport.h
index 6ec140b0a61b..6e4faf3ee76f 100644
--- a/include/net/sock_reuseport.h
+++ b/include/net/sock_reuseport.h
@@ -26,7 +26,7 @@ struct sock_reuseport {
 	unsigned int		bind_inany:1;
 	unsigned int		has_conns:1;
 	struct bpf_prog __rcu	*prog;		/* optional BPF sock selector */
-	struct sock		*socks[];	/* array of sock pointers */
+	struct sock		*socks[] __counted_by(max_socks);
 };
 
 extern int reuseport_alloc(struct sock *sk, bool bind_inany);
diff --git a/net/core/sock_reuseport.c b/net/core/sock_reuseport.c
index 5a165286e4d8..4211710393a8 100644
--- a/net/core/sock_reuseport.c
+++ b/net/core/sock_reuseport.c
@@ -173,10 +173,9 @@ static bool __reuseport_detach_closed_sock(struct sock *sk,
 
 static struct sock_reuseport *__reuseport_alloc(unsigned int max_socks)
 {
-	unsigned int size = sizeof(struct sock_reuseport) +
-		      sizeof(struct sock *) * max_socks;
-	struct sock_reuseport *reuse = kzalloc(size, GFP_ATOMIC);
+	struct sock_reuseport *reuse;
 
+	reuse = kzalloc(struct_size(reuse, socks, max_socks), GFP_ATOMIC);
 	if (!reuse)
 		return NULL;
 
-- 
2.45.2


