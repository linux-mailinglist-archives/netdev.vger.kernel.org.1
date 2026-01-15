Return-Path: <netdev+bounces-250023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73069D23011
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 09:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8ED9E30A5EA5
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 08:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7E3326D44;
	Thu, 15 Jan 2026 08:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="BgbIbU11"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583C03246FF;
	Thu, 15 Jan 2026 08:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768464310; cv=none; b=RTO+2SYC1/tmK0UXQkfROuJut1R8rewAs6eARUvX9eLF7uPQRRUIgSgDYhe/tP1F6agXQ60P3cVvsjxbqFnryZwjp5Ft8UaqiD52TxRfIKHykcxEYmIPaSCCl7CbvG5g2L/JwVrxFcdXGrNEWWfv4aQgZe+dT7/VZ5u4kbWaN0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768464310; c=relaxed/simple;
	bh=W7WG4tY/8Ek7xdMesHq/smnqRfZ2X89VHnmZZ8rg0Vg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IzI3MeHD0aMCB812TStOxjp7JfG09ST+TzMbwttfthNfk/UYvrFAJK9RI/4EmLHaqj9EYEoxuyFVlrM+08yIgbRyOycnRrt+LsWsH9AhZNh946b1zI8GGwDliQFQqc8jMxa2OJsirpMrfsRaseGiPu+vdiPtDAxlX5jipzF66kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=BgbIbU11; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id EE0B12085F;
	Thu, 15 Jan 2026 09:05:07 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u7WSrNOjph2g; Thu, 15 Jan 2026 09:05:07 +0100 (CET)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 6B9E92085B;
	Thu, 15 Jan 2026 09:05:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 6B9E92085B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1768464307;
	bh=bQV4YtS+J9hrzqqruJEkhSV0WwGyvYhM9Wtso+im2mA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=BgbIbU11+BgQEn8FAq6mWHSAHVUWvhSQvOG0z+++EFCZufEFgPMw2QI9udwazInAH
	 Pj9E8sbrSN+ldII3S0sdxWiW9VsJClPyDVkpqE166eJ0nl3oIy2LhZRKwubDdAhq0u
	 +5cA9GRpLrGB+8N8cvuulEKyRUb29ndqptDmUYm22jFrkC95nC1m4Q271/puGXWmGu
	 fHFIRgUvlyHd2BIm7om/Lh8P/2RLWr0YBPust0/1n5SCE3pa6znFQb4vEMn6ENzPfG
	 prVVCT2IaFOc+2S9H/gu0xkVm1w9BgkaKECn8+zKtHsHAkzg2PCYVHodJrmlLXU0FQ
	 sGZn8HIq+/HLw==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 15 Jan
 2026 09:05:06 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Antony Antony <antony.antony@secunet.com>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	<netdev@vger.kernel.org>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Chiachang Wang <chiachangwang@google.com>, Yan Yan
	<evitayan@google.com>, Shinta Sugimoto <shinta.sugimoto@ericsson.com>,
	<devel@linux-ipsec.org>, Simon Horman <horms@kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH ipsec-next v2 2/4] xfrm: allow migration from UDP encapsulated to non-encapsulated ESP
Date: Thu, 15 Jan 2026 09:04:52 +0100
Message-ID: <ae55983daddfd1a484995979c3832bf21871f8e5.1768462955.git.antony.antony@secunet.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1768462955.git.antony.antony@secunet.com>
References: <cover.1768462955.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-02.secunet.de
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


