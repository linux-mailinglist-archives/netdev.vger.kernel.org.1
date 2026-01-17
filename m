Return-Path: <netdev+bounces-250738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 947F3D390BF
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 21:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5ED643008C40
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 20:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012CA2E092D;
	Sat, 17 Jan 2026 20:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="BU4ROL1p"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A989426D4DD;
	Sat, 17 Jan 2026 20:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768680417; cv=none; b=syRTBH3PsHDJ918l9gbVtnf1HMMWzZehkst3Bzi6czzCSjxPTcr5HfOIOsenTQwcYTm3N9hCIU+wlEDVLLBl9BN8j8X8I7bi4+4hIcr9fBAM4XzyjQtU5gV3CTfBpE72+z/Dl64KwYi/xnn9Nk/bpoh9okrAxIOlLzdOmPJrTg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768680417; c=relaxed/simple;
	bh=s0x8d6mIOzcfWGJkCSvdBYfGLIrOsGazmHgvxGS5/W4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kSkOf/WKzcFq4jyz9bDsuhKHU2ybguSJQJ5DiO6XvXiTjbjp7HTylshJ1+LzXFFwkdH9SR+d/wWRJ3ax5VUI7qr0zs1FKs2vfRWMi2X1lqE54S3TLDyGq4XweSbn3BECq8jDw39y7z7bwQUjfN6SEcNSpJykYx/WPKNDEaiZAb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=BU4ROL1p; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 3441720799;
	Sat, 17 Jan 2026 21:06:55 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SC-LzYfpI0Z2; Sat, 17 Jan 2026 21:06:54 +0100 (CET)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id A89B3205CD;
	Sat, 17 Jan 2026 21:06:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com A89B3205CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1768680414;
	bh=bQV4YtS+J9hrzqqruJEkhSV0WwGyvYhM9Wtso+im2mA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=BU4ROL1po3TcevAPE0/a6i2k6PsFbLrJRV95TW6XdK6dDirnlCE5Z5GYSCBzt8nb4
	 EU7XyVttO+noWn9156px65Rpu8lS9XJmWrp1OkIxbqB9Ot/n46mUfTgWXk5M9MBzYR
	 Yqzdi7fapM547oWd3SLV/9DP+qM25W2fsOpii6YIQ4uuZdehXBHLXgI1adsgcTA1es
	 +p854sGMPjhTetoNfORBS64vw2oDDyGhKSLL2Lpn5AbPpX0bUYjD3hGw7pR9emlvua
	 eTY1iE4RzsC+J8t5lZfxdaN/m8/zmpZT80qgzaJ0WZi9Q+kflvCBHlA3PXbcsBmfMQ
	 VLqTCZQv7SYUw==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 17 Jan
 2026 21:06:54 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Antony Antony <antony.antony@secunet.com>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	<netdev@vger.kernel.org>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Chiachang Wang <chiachangwang@google.com>, Yan Yan
	<evitayan@google.com>, <devel@linux-ipsec.org>, Simon Horman
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH ipsec-next v2 2/4] xfrm: allow migration from UDP encapsulated to non-encapsulated ESP
Date: Sat, 17 Jan 2026 21:06:41 +0100
Message-ID: <7cf636d5ec43c3df24d2b8dd6303170dd686135c.1768679141.git.antony.antony@secunet.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1768679141.git.antony.antony@secunet.com>
References: <cover.1768679141.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-02.secunet.de
 (10.32.0.172)

The current code prevents migrating an SA from UDP encapsulation to
plain ESP. This is needed when moving from a NATed path to a non-NATed
one, for example when switching from IPv4+NAT to IPv6.

Only copy the existing encapsulation during migration if the encap
attribute is explicitly provided.

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 net/xfrm/xfrm_state.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 4fd73a970a7a..f5f699f5f98e 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2008,14 +2008,8 @@ static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
 	}
 	x->props.calgo = orig->props.calgo;

-	if (encap || orig->encap) {
-		if (encap)
-			x->encap = kmemdup(encap, sizeof(*x->encap),
-					GFP_KERNEL);
-		else
-			x->encap = kmemdup(orig->encap, sizeof(*x->encap),
-					GFP_KERNEL);
-
+	if (encap) {
+		x->encap = kmemdup(encap, sizeof(*x->encap), GFP_KERNEL);
 		if (!x->encap)
 			goto error;
 	}
--
2.39.5


