Return-Path: <netdev+bounces-28157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A73D277E69C
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 18:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D973E1C21150
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 16:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBB216436;
	Wed, 16 Aug 2023 16:40:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFABE1641E
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 16:40:08 +0000 (UTC)
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D2819A4
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 09:40:03 -0700 (PDT)
Received: from kero.packetmixer.de (p200300Fa272a67000BB2D6DCAF57d46e.dip0.t-ipconnect.de [IPv6:2003:fa:272a:6700:bb2:d6dc:af57:d46e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id DF06FFB5C4;
	Wed, 16 Aug 2023 18:40:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1692204002; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=amJQTPXrCeuUiYKJIPBLJv02MxYZRVyiUw9AyUoaEmQ=;
	b=Kp9TQ+YtoGGHDDL28+D5GjW/EjCoCqxQT9iOMXbSplYWYauFZC+Zz22I74uTdd1osMdx/p
	WG2VnXo/8fSUj6QPvdfAZP8HcdH1+bJaENYm4zUywUNzAiVNNjEYrG6ItXjkrGoZnkHRe6
	SXrpSsQvTo1A2JfVPikuIyW8XplKa8A2eU4bUWNITEx52Dzohq++duLu1ZOSfsGrBWBQHj
	7qovh7oAdKVEYCbVhAx2xf3MSbK5mSU0p6Pu+AOtQO8/0UayKSk6MTI1+tTsd4EpojrvlV
	ZjwA0TIQJEclnU62HJ8NGs7dKL2SZ6MoSiNqfMfv78f+DkpQaYXKOmjYedT/UQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 1/7] batman-adv: Start new development cycle
Date: Wed, 16 Aug 2023 18:39:54 +0200
Message-Id: <20230816164000.190884-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230816164000.190884-1-sw@simonwunderlich.de>
References: <20230816164000.190884-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
	d=simonwunderlich.de; s=09092022; t=1692204002;
	h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=amJQTPXrCeuUiYKJIPBLJv02MxYZRVyiUw9AyUoaEmQ=;
	b=qc3/HpVqg9desG0/jzyJbn1zWCN6/fPRJYNVsdlmbHHpmqea1xsNZw6XdFaDlCIHcOkd6Q
	ZxJAgjnHzYT/tCdjN+vTofruJSTywIRChO6zfjIzlawC0O4aJWu442i/Tx9wYIjeXHlGOT
	Rulwus+yKUIxsS1lgKRuUA4InXcrvtQe7fDwCoc+N30fQpUoHlOaAafN7DZn+GB4bOgt5A
	UaiXNZpJWah9TTbnt5TNXJga3fbO66tAaHgoGt0PfE4p+h5hjtTx7mE0tNJIg3BHrin1zS
	/+XQNkuK51hTqkLlsdRRhgMixgdT/Kr28Z4e2U3sy1gJ61K2wwdjGMaNsqn6xg==
ARC-Seal: i=1; s=09092022; d=simonwunderlich.de; t=1692204002; a=rsa-sha256;
	cv=none;
	b=12vnSjM6zHgsGbIzvXGWSXbUnpAO9GKEA8Z421OW7nlBEXf1s3IHnqfDoM7fiUSErrrGPPQlGWqHw/3/X+ThbDW/2/vfHqnhOjzs4TB6yCnzX6vOZqCb3o7m8P1IFUEQfAx8IfUv8q0r9lzo0tu+fC5HZvMJYVQTxDq2dHHwpNu80iLbOqx0W3oJknvu7Zi3av9l9fE29gRW54h6FKA2skM6onxoisVPfytK2M0AVjef0VE2L8iDRR2iYREUBm8C91HJOc1e6t93TsZJ/mhsrEV3npvtdpp0Z0PCvQrbexjs63bfviFoOGOOkiKZ1T9TmGgwEW9LzbBeQDziyvYHPQ==
ARC-Authentication-Results: i=1;
	mail.simonwunderlich.de;
	auth=pass smtp.auth=sw@simonwunderlich.de smtp.mailfrom=sw@simonwunderlich.de
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This version will contain all the (major or even only minor) changes for
Linux 6.6.

The version number isn't a semantic version number with major and minor
information. It is just encoding the year of the expected publishing as
Linux -rc1 and the number of published versions this year (starting at 0).

Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/main.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 156ed39eded1..10007c5894a1 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -13,7 +13,7 @@
 #define BATADV_DRIVER_DEVICE "batman-adv"
 
 #ifndef BATADV_SOURCE_VERSION
-#define BATADV_SOURCE_VERSION "2023.1"
+#define BATADV_SOURCE_VERSION "2023.3"
 #endif
 
 /* B.A.T.M.A.N. parameters */
-- 
2.39.2


