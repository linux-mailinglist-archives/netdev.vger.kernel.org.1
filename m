Return-Path: <netdev+bounces-97105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC048C9150
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 15:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C58E1F21C06
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 13:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C67B2BCFF;
	Sat, 18 May 2024 13:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="aA/6Gg9G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CF81F5FA;
	Sat, 18 May 2024 13:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716037492; cv=none; b=GLtPH+FyDM/8/Df3gBrShcp5AubgXY0jK34Kwmi4jlTX/l57hYEg12yiT6qiu1VHL5I2/Q1tb4Y5ya5B8L0x0+poCEa7ZpHqLqz/LQ/X2E/Hyo68K2InBJPkvnjxnoa4KN0CJfnqmx6vqVitZhjFJ3U6cbB5OIiOGOBM0bVNcqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716037492; c=relaxed/simple;
	bh=RUjfpWzPBaoGkwn/Pmm4roGPCc8ljs1SzamDFRicGT8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kHHpdi39+aUSIZv6JCFuRA1+W4D24iJ3C98oSsvJnxOyWxaAenjGnDIjNO9McnYi8GacwVVmhXpxucoW38B2JUKu32+L4M1RJnpOdam4FB8u/Ksaza7YJqZG5z6m99/eKohaaEWo0dsDy0Hd0e39XBrDt0AsQHob8WuAdo4YWKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=aA/6Gg9G; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1716037492; x=1747573492;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mrZuWAfje+0i8K+OD1/L6Iu+gflYcACm+4AEdS34KKY=;
  b=aA/6Gg9G8KBIgeZtUE0F0y9soPDOUDuAwctjZML6fzc+eHMALjKIGs1C
   hvTRahj+gjGsrv1ILDp+dM1CB7IEUhvaDm7odKaFZEowbnk6vndDaBHWb
   ppX4M4m9N0sBgCUvSSAu1SMBA1bgNi/SPLSNukXH3giTzDcd1L8kM3QU+
   s=;
X-IronPort-AV: E=Sophos;i="6.08,170,1712620800"; 
   d="scan'208";a="295903782"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2024 13:04:49 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.17.79:3208]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.5.77:2525] with esmtp (Farcaster)
 id 84f5121c-7057-4153-b2f9-027c2ef572aa; Sat, 18 May 2024 13:04:47 +0000 (UTC)
X-Farcaster-Flow-ID: 84f5121c-7057-4153-b2f9-027c2ef572aa
Received: from EX19D002EUA004.ant.amazon.com (10.252.50.181) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sat, 18 May 2024 13:04:46 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D002EUA004.ant.amazon.com (10.252.50.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sat, 18 May 2024 13:04:45 +0000
Received: from dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com
 (10.253.65.58) by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Sat, 18 May 2024 13:04:44
 +0000
Received: by dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (Postfix, from userid 23002382)
	id 8F75520AC2; Sat, 18 May 2024 13:04:43 +0000 (UTC)
From: Hagar Hemdan <hagarhem@amazon.com>
To:
CC: Norbert Manthey <nmanthey@amazon.de>, Hagar Hemdan <hagarhem@amazon.com>,
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, David
 Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Sabrina
 Dubroca" <sd@queasysnail.net>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2] net: esp: cleanup esp_output_tail_tcp() in case of unsupported ESPINTCP
Date: Sat, 18 May 2024 13:04:39 +0000
Message-ID: <20240518130439.20374-1-hagarhem@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

xmit() functions should consume skb or return error codes in error
paths.
When the configuration "CONFIG_INET_ESPINTCP" is not set, the
implementation of the function "esp_output_tail_tcp" violates this rule.
The function frees the skb and returns the error code.
This change removes the kfree_skb from both functions, for both
esp4 and esp6.
WARN_ON is added because esp_output_tail_tcp() should never be called if
CONFIG_INET_ESPINTCP is not set.

This bug was discovered and resolved using Coverity Static Analysis
Security Testing (SAST) by Synopsys, Inc.

Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
---
 net/ipv4/esp4.c | 3 +--
 net/ipv6/esp6.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index d33d12421814..e73de3abe37c 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -238,8 +238,7 @@ static int esp_output_tail_tcp(struct xfrm_state *x, struct sk_buff *skb)
 #else
 static int esp_output_tail_tcp(struct xfrm_state *x, struct sk_buff *skb)
 {
-	kfree_skb(skb);
-
+	WARN_ON(1);
 	return -EOPNOTSUPP;
 }
 #endif
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 7371886d4f9f..600402e54ccd 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -255,8 +255,7 @@ static int esp_output_tail_tcp(struct xfrm_state *x, struct sk_buff *skb)
 #else
 static int esp_output_tail_tcp(struct xfrm_state *x, struct sk_buff *skb)
 {
-	kfree_skb(skb);
-
+	WARN_ON(1);
 	return -EOPNOTSUPP;
 }
 #endif
-- 
2.40.1


