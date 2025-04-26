Return-Path: <netdev+bounces-186223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 626A6A9D819
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 08:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45BC57A8976
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 06:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A348145346;
	Sat, 26 Apr 2025 06:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ovp8hzZy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75492F56;
	Sat, 26 Apr 2025 06:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745647535; cv=none; b=HQ69I4uVGLLxRMnyeO/dMVVlEj+507vyIMC1hXJWdQj2aCBXqMdJXH488zEB8b4wfhofv98YRdmt4HngAnxW9EjNbvL4b/lADYQF87v7bBo2JooFBiHLAfVu8ah5op19QLaOCA8eV7NVrhjoZYAIJvXX/7zKjl8uwcu0/pcduIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745647535; c=relaxed/simple;
	bh=+Iu3Pv9dfXKldLQnwTqAn464zwK92Et5ST3hgC+8/aI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GgHsFwaLC4siHzdA8a4Y5QUxOrjYHPK8Om31eE0yIpDbeZmOwoJHoGEw+3O8HcaZDxOPQ542Qzdt4xwyYvKWyTomownPTfivx55OKU4SqEaHYqh92wHDPlVjHdcM3P/Dpn2d5KP8YQ6k8EyL1lK6pvQm/V3xZBTgNBK3EynTvQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ovp8hzZy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3921CC4CEE2;
	Sat, 26 Apr 2025 06:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745647534;
	bh=+Iu3Pv9dfXKldLQnwTqAn464zwK92Et5ST3hgC+8/aI=;
	h=From:To:Cc:Subject:Date:From;
	b=Ovp8hzZyT0IWrYBQSuqEzkwusfYkNr7+O2/LIMfwGrPXOmrirL/uFONeZtS+f0Ouz
	 fEs/0NZ+EIqow81vwE/oQ/YQuisohuLNMPEjzzw4TOu1R5f3VX4tArD8g4JtUc+7qI
	 SkSxsweRLfwlSTTdwBM4DT/kIdMIAFl7GBaz5yye4PhhK0ORYwfAOLiSU/ApuYoBup
	 k5WI1GuYC1YNPyMISbSbVjnAnKdOb/vdEbTpZ4BUa0KBVqWKr738pPygZgarr8Yh29
	 eIUFRhqeBvovxW2e3fjZXhIKBdIc1/Zf6sCrwZdjr9et3KFBEkFHJtCIpdnyqUJSZ5
	 J7cq+ea+BXJUQ==
From: Kees Cook <kees@kernel.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: Kees Cook <kees@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] ipv4: fib: Fix fib_info_hash_alloc() allocation type
Date: Fri, 25 Apr 2025 23:05:30 -0700
Message-Id: <20250426060529.work.873-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1455; i=kees@kernel.org; h=from:subject:message-id; bh=+Iu3Pv9dfXKldLQnwTqAn464zwK92Et5ST3hgC+8/aI=; b=owGbwMvMwCVmps19z/KJym7G02pJDBk85SvduN3Nez22VejfM2NMP/pkS1jPo3fnHi7pSNjxl 49PO+h7RykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwEROCzP893m94sdtU87ZIYfN BT1fHpi2RobF77nyZ640bvZFzFP7fRj+Clx9+sn01m6bKV7XVLpXnJzK439dvltxciDPKtW3640 uMwAA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In preparation for making the kmalloc family of allocators type aware,
we need to make sure that the returned type from the allocation matches
the type of the variable being assigned. (Before, the allocator would
always return "void *", which can be implicitly cast to any pointer type.)

This was allocating many sizeof(struct hlist_head *) when it actually
wanted sizeof(struct hlist_head). Luckily these are the same size.
Adjust the allocation type to match the assignment.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: David Ahern <dsahern@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: <netdev@vger.kernel.org>
---
 net/ipv4/fib_semantics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index f68bb9e34c34..37d12b0bc6be 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -365,7 +365,7 @@ static struct hlist_head *fib_info_laddrhash_bucket(const struct net *net,
 static struct hlist_head *fib_info_hash_alloc(unsigned int hash_bits)
 {
 	/* The second half is used for prefsrc */
-	return kvcalloc((1 << hash_bits) * 2, sizeof(struct hlist_head *),
+	return kvcalloc((1 << hash_bits) * 2, sizeof(struct hlist_head),
 			GFP_KERNEL);
 }
 
-- 
2.34.1


