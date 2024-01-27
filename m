Return-Path: <netdev+bounces-66384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A50EE83EC8A
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 10:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60803282859
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 09:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159111EA8A;
	Sat, 27 Jan 2024 09:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="I/t4Xher"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12F920DC7
	for <netdev@vger.kernel.org>; Sat, 27 Jan 2024 09:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706349534; cv=none; b=aXZHPN+X8ThvPKPiADvJuHqxupeMihLfRRfNhmwgABPyHFIHt9hUnX6eSHMkKYxLPeeWvSQMiZmmphEG8SBF0seO/2yc9EDBNOd3qoq2+1nK+dV9wORr/ZzP5zNFtC0Ul+EoZ0MSiYrggplPBeeo6nUPLy1LymYcsPEFENkZ664=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706349534; c=relaxed/simple;
	bh=1yQi/Za97ZVFgDwB6sPcxji8K48qj0fXBbsYu9KGVg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pi9lLF2cYa9K+ZnWhcvK80+/DQgADBCtHkVPtlkXiHrRD+KoY5QaXHc00ti5D/aYZCM9xV8kdcVWM0PcTI/chC0f26Illj47bw0h1yofTyTR3ZXtzdGXyMOIbs0UfGLGl+nhGZHxnPAIBgXz46Yb8qyCmmdQ8f7CfXEFCktspQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=I/t4Xher; arc=none smtp.client-ip=80.12.242.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id TfSRrjkxjf5ckTfSRrsMmN; Sat, 27 Jan 2024 10:58:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1706349521;
	bh=bX4lN9MMUzGECMrluzbCNZVyJMP7Hm1BuQfleTGiBws=;
	h=From:To:Cc:Subject:Date;
	b=I/t4Xherdyz7b+YAF7aS/DnXmPfvTv5n7CeGxuQrZlcsAIuK+bqoLKSH+TLJAfYTp
	 NIgr+6DoLXTHZ7ve5+wCV2bo7zd+3DYwHwogclsMsiKOXDY7g5S1fz7cz23cA4gPmG
	 lEFmF3RLZ50k6R7P8X/DMbYQTSrNGHa/KoZlkxv9baS6zg6KTy5Com9oHaC806I05v
	 yPknr0wDK/TBXvQoubfRSeh/TvSYV8lVQiGGOI59pJbqPv8cJn/5RhP/UxJKmS2o6p
	 p6Y/m9ioG5fp94WRrOshfhQifrSTQQNWJz1naTR4Du5qs5D7dM7M3iEsjsaYAO7zOG
	 RHqOuPYKLYYYQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 27 Jan 2024 10:58:41 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH RESEND] nfc: hci: Save a few bytes of memory when registering a 'nfc_llc' engine
Date: Sat, 27 Jan 2024 10:58:29 +0100
Message-ID: <6d2b8c390907dcac2e4dc6e71f1b2db2ef8abef1.1705744530.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfc_llc_register() calls pass a string literal as the 'name' parameter.

So kstrdup_const() can be used instead of kfree() to avoid a memory
allocation in such cases.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Resent because of 'net-next-closed' message on previous try.

Added R-b tag. (see [1])

[1]: https://lore.kernel.org/all/9415e571-50a1-41d3-8205-68e4128bbe6d@linaro.org/
---
 net/nfc/hci/llc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/nfc/hci/llc.c b/net/nfc/hci/llc.c
index 2140f6724644..8c7b5a817b25 100644
--- a/net/nfc/hci/llc.c
+++ b/net/nfc/hci/llc.c
@@ -49,7 +49,7 @@ int nfc_llc_register(const char *name, const struct nfc_llc_ops *ops)
 	if (llc_engine == NULL)
 		return -ENOMEM;
 
-	llc_engine->name = kstrdup(name, GFP_KERNEL);
+	llc_engine->name = kstrdup_const(name, GFP_KERNEL);
 	if (llc_engine->name == NULL) {
 		kfree(llc_engine);
 		return -ENOMEM;
@@ -83,7 +83,7 @@ void nfc_llc_unregister(const char *name)
 		return;
 
 	list_del(&llc_engine->entry);
-	kfree(llc_engine->name);
+	kfree_const(llc_engine->name);
 	kfree(llc_engine);
 }
 
-- 
2.43.0


