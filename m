Return-Path: <netdev+bounces-242129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E24DC8C972
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 02:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 26D1934A3F4
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 01:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A9221770A;
	Thu, 27 Nov 2025 01:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOHgrATC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C354A208994
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 01:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764207798; cv=none; b=DBEzB6Yhdp4wG71nqDdaT6kfF3aiY6uGautAX28dCx2pusVD4sDh27rN3EaVQXM1oy6E2j3c8pIsrd0lvYQMM4aDB93bQATdFfovVvjyXmmdPnKe2h2DCdC54wL6JZ2shYSdeDeq/LEco+4lXlA6MSL9PPeUZCVaioEhuFw1JlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764207798; c=relaxed/simple;
	bh=uX4tw/P3GGKL3FlxOQe7gKz6s1sddcWT9N/o0T0FWGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pK0RD3LjyOaYCfk0snhy3IIwadK8VdOkLkBV7Gry0ILi54E/Fh5Gh7l6h0DZEL4NOcFB92o+M+/GWELwRLQSOqKANXeWBNVCRIVFQO0f2vSKorZ+HHy37JgKg8DNxuMJ1Z/Mr0OJSvopg8sKKA7rqStVXOwZTZg/RBoTzZnGjKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOHgrATC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD374C4CEF7;
	Thu, 27 Nov 2025 01:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764207798;
	bh=uX4tw/P3GGKL3FlxOQe7gKz6s1sddcWT9N/o0T0FWGs=;
	h=From:To:Cc:Subject:Date:From;
	b=fOHgrATCR2taUp8OXx1rdRveIpZIORBGTTyQvHT7m7wgu71miPVXT8EECkksKcFy3
	 PuL1z5GZTP2zImvpp5pIOx1O7ISAUHkIEPSHCIK5ZfCpbqmVrFdNeRqFWYTimL+Cez
	 Jkh4ZKfJFouFDCzNbM9N3PR3JtFuVJebDofuc6tHYCr6Zb5g/u8/gt5mdzIeZxNvqJ
	 +VFCADeZL4GWvJ66hH+qdQ9xeCRQDNS/RJgNDkCllna1oWNgnwE73uu2PZ+rypzBsg
	 x/CsMo+R5pZ5doP78Rt2/qaVdi1LRDjl7ugM9Mb7YU/G0cYzXpc9W2jTqeLlVgNSo4
	 vNkbZNkG8YzZg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] net: restore napi_consume_skb()'s NULL-handling
Date: Wed, 26 Nov 2025 17:43:11 -0800
Message-ID: <20251127014311.2145827-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit e20dfbad8aab ("net: fix napi_consume_skb() with alien skbs")
added a skb->cpu check to napi_consume_skb(), before the point where
napi_consume_skb() validated skb is not NULL.

Add an explicit check to the early exit condition.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
AI code review reported this on my bnxt patch..
---
 net/core/skbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 5a1d123e7ef7..a00808f7be6a 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1490,7 +1490,7 @@ void napi_skb_free_stolen_head(struct sk_buff *skb)
 void napi_consume_skb(struct sk_buff *skb, int budget)
 {
 	/* Zero budget indicate non-NAPI context called us, like netpoll */
-	if (unlikely(!budget)) {
+	if (unlikely(!budget || !skb)) {
 		dev_consume_skb_any(skb);
 		return;
 	}
-- 
2.51.1


