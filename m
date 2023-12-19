Return-Path: <netdev+bounces-58761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA85818012
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 04:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EE791F241AE
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 03:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F356D24;
	Tue, 19 Dec 2023 03:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P01OgUpB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AA66129
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 03:07:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9014C433C8;
	Tue, 19 Dec 2023 03:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702955266;
	bh=goJWjkYjfb4mBzapTHQDg8Gt/sZLIRs0obu26Rivb6U=;
	h=From:To:Cc:Subject:Date:From;
	b=P01OgUpBwsljzPCqAr59x7sCNVeGGb5yKbEksZ9EQb58h+FaFrsrJn8j/WXeiMkvT
	 79H55z66huFcdr3PgrmqpvY13W71Ei4qIoQHmSG9SXcWWvDv6brprNRrj1HoKKfDJ/
	 Hy6BlkDRuLj/JROH3IY9Gw4U0+X9gustxeitFm9p6KVqo6LY3wapifMN2HEnvMF9sp
	 vufKOw1EcAC9YFGJn4gMPaaSlCcd8zSk5Msszd5vvsA33TGfb48WsdkFW/eznuXxBv
	 e2PdRLJRyO/EIaQmf0SBqwwwV/kCeDadCgTwnHSIVkAPkPeaNgsq+gy9q0cdsAwUN6
	 wiDKKbC4NwD7Q==
From: David Ahern <dsahern@kernel.org>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH net-next] net/ipv6: Remove gc_link warn on in fib6_info_release
Date: Mon, 18 Dec 2023 20:07:42 -0700
Message-Id: <20231219030742.25715-1-dsahern@kernel.org>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A revert of
   3dec89b14d37 ("net/ipv6: Remove expired routes with a separated list of routes")
was sent for net-next. Revert the remainder of 5a08d0065a915
which added a warn on if a fib entry is still on the gc_link list
to avoid compile failures when net is merged to net-next

Signed-off-by: David Ahern <dsahern@kernel.org>
---
 include/net/ip6_fib.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
index 95ed495c3a40..1ba9f4ddf2f6 100644
--- a/include/net/ip6_fib.h
+++ b/include/net/ip6_fib.h
@@ -328,10 +328,8 @@ static inline bool fib6_info_hold_safe(struct fib6_info *f6i)
 
 static inline void fib6_info_release(struct fib6_info *f6i)
 {
-	if (f6i && refcount_dec_and_test(&f6i->fib6_ref)) {
-		DEBUG_NET_WARN_ON_ONCE(!hlist_unhashed(&f6i->gc_link));
+	if (f6i && refcount_dec_and_test(&f6i->fib6_ref))
 		call_rcu(&f6i->rcu, fib6_info_destroy_rcu);
-	}
 }
 
 enum fib6_walk_state {
-- 
2.34.1


