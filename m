Return-Path: <netdev+bounces-185363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BB2A99EA7
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 04:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91F2544654A
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 02:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03FB18FC91;
	Thu, 24 Apr 2025 02:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWxv689/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3EB18C031
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 02:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745460736; cv=none; b=qgjfl+6XQqkjpa/6NWxMaCYqCUM+w7NbzWT8Esu9GOBBOK3qw9wc6rlpCoXHbfCnoyHXjcnWV2ik8GJMUr0JxTSuRaJQxLCaEjcbjd9CfSqE+t4AwCszYdRGBpPiGWYlbsRNBRR16sWIBMQQofCLJs248ZGn7zr48RtIO1o1dgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745460736; c=relaxed/simple;
	bh=MHb/cjT+9ndM+MTp2t+b4he9mHxtFQoex1b69sUI7JY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qDizzr86RBvzEN5vqYp5/kwFL6EjKXofQTbxrVa6gfplxZZlm1z9z7pAdkaR732EjszTS6kIibBn9r6HZFqOn7IX+XtefXZCbhUUUKjm76tSIOvsD0IdRBwup5s7bqr+HceYT3/BCE0Cf4KTjwIAsiK9yzv2kdQU+HYnw6hkCFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWxv689/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D69FC4CEE3;
	Thu, 24 Apr 2025 02:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745460736;
	bh=MHb/cjT+9ndM+MTp2t+b4he9mHxtFQoex1b69sUI7JY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pWxv689/HJn0PYO8J6VzQmuyGsOIF3pc9TsWIgElrZLFTRXcUUVSK58M6d0n+lsoW
	 n3GkCI7x1msngcXN2V5xR3zivIT8ds3N6BCwNKu7kXqaxsdaNzkHzFQNUS4YGUmAxf
	 2qDk4zYhdNMnJrMrSvJxjNMaJclC0K9Bv9Dpwmr1pQs1TXGmfGHn15Tl41A+j7ZX9o
	 DEVkwVuKzseW47ydXHJqgyxLHgqmweX5bZkMYCcMG5Q9poSsqtWzSp495tUNUu3Eqn
	 IASjPxtgXjzWYsjCe1liF2GcbALTnMA/0eYEPeoy2IPu4T2639zlNSWbeiZYgl1vMr
	 mMzDp0sB/uNpA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 01/12] tools: ynl-gen: fix comment about nested struct dict
Date: Wed, 23 Apr 2025 19:11:56 -0700
Message-ID: <20250424021207.1167791-2-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424021207.1167791-1-kuba@kernel.org>
References: <20250424021207.1167791-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dict stores struct objects (of class Struct), not just
a trivial set with directions.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 9613a6135003..077aacd5f33a 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -1015,7 +1015,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
 
         # dict space-name -> 'request': set(attrs), 'reply': set(attrs)
         self.root_sets = dict()
-        # dict space-name -> set('request', 'reply')
+        # dict space-name -> Struct
         self.pure_nested_structs = dict()
 
         self._mark_notify()
-- 
2.49.0


