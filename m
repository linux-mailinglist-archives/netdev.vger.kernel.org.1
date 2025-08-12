Return-Path: <netdev+bounces-212772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A8EB21CC0
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 07:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D85B617334D
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 05:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9E129BDA4;
	Tue, 12 Aug 2025 05:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="l1bnU3Pt"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEBF254B19
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 05:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754975354; cv=none; b=u3S5/lTjr9HLKJxZdvUv/f/wNoXTmY1VFLG+Kxpi7uJmtAvggM9uM5Ed+fJ2QCwBluHn84SxukiY7FBs/LsZIKsqLGHgDM2lUE+AhjYcJQYOqr0piWAomIbCGoy/lrwpj3l1Cl0MNxgHJ6YkcMDlmqxpRHy4pWS2lkcJjh24m58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754975354; c=relaxed/simple;
	bh=B/ol2dXVD4I263rs/PQVbUbMvc/bMTTZh++/GJk4Mqw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eNNsa1zmrY6tfId4kQtaWKoxzWVA3DjdA7BJRcwM5ZDuhBWeQFQpoSwbSjYH4xF6Dq3uLnpiMIzXOXvr3zjKiJHcyRhomphIo+JJ263CAZq9IrCHoT//KDcsqQu1ffCr3FHrTL8uLeqYEcIHr/8MeonA+WWf+kiMydq3oAQgvQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=l1bnU3Pt; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1754975343;
	bh=iKwZUZKnoI4GSPDOmng0QmhnG0yOEmvHXa2p743vUDA=;
	h=From:Date:Subject:To:Cc;
	b=l1bnU3PtQJN5CCn3raupP7xS+97UnBgVzp1juySk8IzGpJrDdmVNHawSFiz1IrN0z
	 b9RifPTOi0lLJfwE4uyPYjvI6Ruzjv5kb1K/1AfzKuK0D6b0KPwsV1z0gYeiNsT3SF
	 VjsCfoxwBX2IrY7RCz0p076JS15WdaZb26EtLgkWCrUyjm0cpsuTqEcsKqrUQnKoc/
	 8NsWQfoYf80AF4RW/eOwy3hyO66WO/nzP3TKFyWqXGtkwzBsNlKFJSBmt1gYQ7zdYT
	 GMjoCJbqYoISczXq5tzKEdp4KEv0evNfHJFnG8AwcCZm5fP5e8tQsJRe5W0FWFSLR9
	 20UNYEarQXvGg==
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id 9C8696C07A; Tue, 12 Aug 2025 13:09:03 +0800 (AWST)
From: Matt Johnston <matt@codeconstruct.com.au>
Date: Tue, 12 Aug 2025 13:08:58 +0800
Subject: [PATCH net] net: mctp: Fix bad kfree_skb in bind lookup test
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-fix-mctp-bind-test-v1-1-5e2128664eb3@codeconstruct.com.au>
X-B4-Tracking: v=1; b=H4sIAGnMmmgC/x2MywqAIBAAfyX23EK+QvqV6GC21R6yUIlA+vek4
 8DMFEgUmRIMTYFINyc+QwXRNuB3FzZCXiqD7KTprJC48oOHzxfOHBbMlDIap4yVvVaONNTwilS
 tfzpCoAzT+351KxdfaQAAAA==
X-Change-ID: 20250812-fix-mctp-bind-test-5a3582643ae4
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Alexandre Ghiti <alex@ghiti.fr>, 
 Matt Johnston <matt@codeconstruct.com.au>
X-Mailer: b4 0.15-dev-cbbb4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754975343; l=1051;
 i=matt@codeconstruct.com.au; s=20241018; h=from:subject:message-id;
 bh=B/ol2dXVD4I263rs/PQVbUbMvc/bMTTZh++/GJk4Mqw=;
 b=f/aTCDM/YE9nPfBKPIPy50DxyIWQhgi+s83rpkm+RFU7TPCUMKQpXzVX9E7QVOhoIoZDXqOr6
 S3AMFwKR9q6BxA5FyAuOX1wvBa11RKTyZ+kAnsmM5CCQ8Y1Jn0LTPyl
X-Developer-Key: i=matt@codeconstruct.com.au; a=ed25519;
 pk=exersTcCYD/pEBOzXGO6HkLd6kKXRuWxHhj+LXn3DYE=

The kunit test's skb_pkt is consumed by mctp_dst_input() so shouldn't be
freed separately.

Fixes: e6d8e7dbc5a3 ("net: mctp: Add bind lookup test")
Reported-by: Alexandre Ghiti <alex@ghiti.fr>
Closes: https://lore.kernel.org/all/734b02a3-1941-49df-a0da-ec14310d41e4@ghiti.fr/
Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
---
 net/mctp/test/route-test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mctp/test/route-test.c b/net/mctp/test/route-test.c
index fb6b46a952cb432163f6adb40bb395d658745efd..69a3ccfc6310cd78d4138f56609f1d83d4082bd1 100644
--- a/net/mctp/test/route-test.c
+++ b/net/mctp/test/route-test.c
@@ -1586,7 +1586,6 @@ static void mctp_test_bind_lookup(struct kunit *test)
 
 cleanup:
 	kfree_skb(skb_sock);
-	kfree_skb(skb_pkt);
 
 	/* Drop all binds */
 	for (size_t i = 0; i < ARRAY_SIZE(lookup_binds); i++)

---
base-commit: 89886abd073489e26614e4d80fb8eb70d3938a0b
change-id: 20250812-fix-mctp-bind-test-5a3582643ae4

Best regards,
-- 
Matt Johnston <matt@codeconstruct.com.au>


