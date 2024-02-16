Return-Path: <netdev+bounces-72297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A468585778D
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 09:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6AE81C20AD6
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 08:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22501C6A0;
	Fri, 16 Feb 2024 08:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="LENS3FWV"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE2A1CAAE
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 08:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708071585; cv=none; b=IXS3nf6KhOzlp7duFgB/VjZ6Ziw2MM6qw/AO/eBVT62g6kK3oW4A5EnurGbNa4incgqTgAG8c4i/q0mr+i0hoIdjGNGffeWm2vYBTqcAk0BkkWeX1yYfmLQb+LnmSBNPKB37AiGYUFVP05ujMIzRIMNcoOjOftOGsBQLn78Hahs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708071585; c=relaxed/simple;
	bh=vQaKwBVNDERx4H3FbRc7vbamiZIki/37TVdJhw6eB2E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=blbpm5YUJCZ0zIlhtqfkNCaPJVUjm9MWN6p3VilTeUEqkv89N5A7a4WTqXLwGapgCj8VTfwVialisl7Try87pEHOaiftVWyMvvfD3QhdXuKO4LDNpIlumHojG5H6HTd7RNPe6fWwSoOT02tJiurYHP7hNwPZdansKsSSKPiGvAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=LENS3FWV; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 32BE220489; Fri, 16 Feb 2024 16:19:34 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1708071574;
	bh=ce5V6oTF/voGcV8OB8w/pov95QZRuMKqtP8LM1ZyNRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LENS3FWVdOywnBHeD7IbiVgsJfea7g6R1HSwUdOIYUHlSDzJ3d4rTL87oW1jTvR54
	 oI2PEqWRBDYrN5a43L3LoFTRflXP51++MIfhQI85BLSDotfSK23EeaqXkkyQR88ne3
	 LNkx35co7Ck2f+Z6uJpkLzlnLRalkfTh1j8/NiP4HUiuf/qvzSg07i45kFJZg5kew/
	 tvYbhP/QObM6NrquoGHi1X2d0wD7BwDGHOGd/1B7WZopdH0FB47tUsuiJVHpLWxdML
	 OWAjL46EjaCrK8Rg0QyWTq31HSB5Fo7J7gr995c13OqWg+06skee5uvim8+aGXRQRT
	 a/tTDj5TiTmTA==
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: netdev@vger.kernel.org
Cc: Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Liang Chen <liangchen.linux@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH net-next 07/11] net: mctp: tests: Add netid argument to __mctp_route_test_init
Date: Fri, 16 Feb 2024 16:19:17 +0800
Message-Id: <af2f104d91a01b16d4235d027b1b100fe8dc558f.1708071380.git.jk@codeconstruct.com.au>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1708071380.git.jk@codeconstruct.com.au>
References: <cover.1708071380.git.jk@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We'll want to create net-specific test setups in an upcoming change, so
allow the caller to provide a non-default netid.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 net/mctp/test/route-test.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/mctp/test/route-test.c b/net/mctp/test/route-test.c
index b3dbd3600d91..0880c3c04ace 100644
--- a/net/mctp/test/route-test.c
+++ b/net/mctp/test/route-test.c
@@ -293,7 +293,8 @@ KUNIT_ARRAY_PARAM(mctp_rx_input, mctp_rx_input_tests,
 static void __mctp_route_test_init(struct kunit *test,
 				   struct mctp_test_dev **devp,
 				   struct mctp_test_route **rtp,
-				   struct socket **sockp)
+				   struct socket **sockp,
+				   unsigned int netid)
 {
 	struct sockaddr_mctp addr = {0};
 	struct mctp_test_route *rt;
@@ -303,6 +304,8 @@ static void __mctp_route_test_init(struct kunit *test,
 
 	dev = mctp_test_create_dev();
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+	if (netid != MCTP_NET_ANY)
+		WRITE_ONCE(dev->mdev->net, netid);
 
 	rt = mctp_test_create_route(&init_net, dev->mdev, 8, 68);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, rt);
@@ -311,7 +314,7 @@ static void __mctp_route_test_init(struct kunit *test,
 	KUNIT_ASSERT_EQ(test, rc, 0);
 
 	addr.smctp_family = AF_MCTP;
-	addr.smctp_network = MCTP_NET_ANY;
+	addr.smctp_network = netid;
 	addr.smctp_addr.s_addr = 8;
 	addr.smctp_type = 0;
 	rc = kernel_bind(sock, (struct sockaddr *)&addr, sizeof(addr));
@@ -349,7 +352,7 @@ static void mctp_test_route_input_sk(struct kunit *test)
 
 	params = test->param_value;
 
-	__mctp_route_test_init(test, &dev, &rt, &sock);
+	__mctp_route_test_init(test, &dev, &rt, &sock, MCTP_NET_ANY);
 
 	skb = mctp_test_create_skb_data(&params->hdr, &params->type);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, skb);
@@ -419,7 +422,7 @@ static void mctp_test_route_input_sk_reasm(struct kunit *test)
 
 	params = test->param_value;
 
-	__mctp_route_test_init(test, &dev, &rt, &sock);
+	__mctp_route_test_init(test, &dev, &rt, &sock, MCTP_NET_ANY);
 
 	for (i = 0; i < params->n_hdrs; i++) {
 		c = i;
-- 
2.39.2


