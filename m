Return-Path: <netdev+bounces-114213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC849417BC
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 18:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C7341C208D4
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 16:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F401A617B;
	Tue, 30 Jul 2024 16:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="XxRoxAe2"
X-Original-To: netdev@vger.kernel.org
Received: from forward204a.mail.yandex.net (forward204a.mail.yandex.net [178.154.239.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D591A6177;
	Tue, 30 Jul 2024 16:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722355898; cv=none; b=t8Kj7BxXEjqBQLoriIWCaoiy7Etw0PikDIxY/SGW72vwMKGakFRU6YWxsTM4Z5FWZSwc4IbLsK6EJMr3a9/v7JaFqcHeU8JJRW0P1JUsh3ngBop/CASkMvo85F+Xco8EETO4JaR2tIJphljv9R+EUQM6lwEY8dDUXyiemjYSxVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722355898; c=relaxed/simple;
	bh=9xq46AiLEciJhjWVl6ablTXxZG22njIKii2dUInMvUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YiXcmIt8+TAMx+B7dq4TV9IzY2Xv+niHqHPyq3jSpfmcfFvsmV/Y2PPMdi+AA9NN+eLD9N3VA2j3MMuhUZs+ub0WOP3LvQedNhNJE505w4abwHV93208tJpCSwXxBEtP57LTojgtLWjtEmHZDxoHb0gdFaj4/K7p+IGsM12AMMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=XxRoxAe2; arc=none smtp.client-ip=178.154.239.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d103])
	by forward204a.mail.yandex.net (Yandex) with ESMTPS id D2A1E69B72;
	Tue, 30 Jul 2024 19:05:04 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:48a9:0:640:5080:0])
	by forward103a.mail.yandex.net (Yandex) with ESMTPS id 7DF3A60917;
	Tue, 30 Jul 2024 19:04:56 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id t4YWXWtXtSw0-9YzPMW0s;
	Tue, 30 Jul 2024 19:04:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1722355496; bh=0bSL0dug3kMaGUZF4zCdpsGvEbqmBIiV+gNdXzkzm8I=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=XxRoxAe2qZKFTZlqa3cyQ4KAERbiU3GoKcsj4YaynaSAEad0hDVGlyupqEqEY3xii
	 19O3x4xRFnc1sBQsjN93K8VPDnILH36W6BlCDIq3pqAdC/mGZTA4LKsSpjQFIbwzUM
	 xK9ZDdyjI+oBN6vRFdWSX8BwCV582LVU6A1PIQUk=
Authentication-Results: mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Kees Cook <kees@kernel.org>,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] net: core: use __counted_by for trailing VLA of struct sock_reuseport
Date: Tue, 30 Jul 2024 19:04:49 +0300
Message-ID: <20240730160449.368698-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to '__reuseport_alloc()', annotate trailing VLA 'sock' of
'struct sock_reuseport' with '__counted_by()' and use convenient
'struct_size()' to simplify the math used in 'kzalloc()'.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 include/net/sock_reuseport.h | 2 +-
 net/core/sock_reuseport.c    | 7 +++----
 2 files changed, 4 insertions(+), 5 deletions(-)

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
index 5a165286e4d8..5eea73aaeb0f 100644
--- a/net/core/sock_reuseport.c
+++ b/net/core/sock_reuseport.c
@@ -173,11 +173,10 @@ static bool __reuseport_detach_closed_sock(struct sock *sk,
 
 static struct sock_reuseport *__reuseport_alloc(unsigned int max_socks)
 {
-	unsigned int size = sizeof(struct sock_reuseport) +
-		      sizeof(struct sock *) * max_socks;
-	struct sock_reuseport *reuse = kzalloc(size, GFP_ATOMIC);
+	struct sock_reuseport *reuse =
+		kzalloc(struct_size(reuse, socks, max_socks), GFP_ATOMIC);
 
-	if (!reuse)
+	if (unlikely(!reuse))
 		return NULL;
 
 	reuse->max_socks = max_socks;
-- 
2.45.2


