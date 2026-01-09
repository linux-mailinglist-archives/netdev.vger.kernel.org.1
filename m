Return-Path: <netdev+bounces-248510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F422D0A7A7
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 14:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7853F3059ABC
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 13:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C510132BF21;
	Fri,  9 Jan 2026 13:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="vyPOp1Fv"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF1F2E8DFE
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 13:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767965856; cv=none; b=WNFiZLLYMbZY+7FqhazpLeqRNIvD3oN4F90y9I1ueSRjBi8qQMPmxwa6WiearWCmbYbXMd+gRa/80hoYRDINCvosb8+Q5NxoeKmD8h7+3VdUX6RIT5XIBw9XUNs+9Zz1v+pcU8C0T8c2T8FbK62ReroSpNFO5NQTzSwMdlcm9tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767965856; c=relaxed/simple;
	bh=xoQVwnRhD/7ikj34rALwV9A4VCjI3d6Vy09hzaPGwKM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfQX2qcowIgZCc1ZVh3oZa/94Wq0m9ZVwI2sof76c/oNOo8/ShOJ0Ae8yZm8VIqwxQomxjJXCdOmLW5FKBfsr6tray+R6hltOk6CIosQGTOoIu4w5q1pOWtnSptc/Kk1YWdyEYUi3LZq5JtGOlY1p0McOE7QXM/vBOmcfV0YfRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=vyPOp1Fv; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id B78B82084C;
	Fri,  9 Jan 2026 14:37:33 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BAS7mKu-fHYE; Fri,  9 Jan 2026 14:37:33 +0100 (CET)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 385E7206B0;
	Fri,  9 Jan 2026 14:37:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 385E7206B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1767965853;
	bh=jCjGjc6wgXRFFzILX2xwdQiHssOXuLYlWP4/SWQQ6NQ=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=vyPOp1FvQqNGyiRN4GnNU6UEHBwpKsEOyl7+G+R2M8GalYPCw30xFK7X3bGegC3PX
	 /Fk7CZrXsNNfvBcHnlnFeVdfQ3ZlNrwRnOiyStQ2oBwFvZsoXjisxirLSqZuHw1hsU
	 uPPvquHaClULAQg7BQ3P0vxqr/w9YjugZaqKpKvZdjyUcAiX62iFg6ygo5Gkfn72Xw
	 YNKM8Fgg9jXZzBXrNBrYA7F2vYSiwz/fFC5EDipcPJTjjGEfovT2R52l4ynrovRsj7
	 fwTIzngNdVw0E49zWvrxASOt3SOt4ZsAJsRwVxtUcBn3M/UkpAOQwukuQVube5ENEB
	 11FrTFZ5LsH6g==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 9 Jan
 2026 14:37:32 +0100
Date: Fri, 9 Jan 2026 14:37:26 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <devel@linux-ipsec.org>
Subject: [PATCH ipsec-next 2/6] xfrm: allow migration from UDP encapsulated
 to non-encapsulated ESP
Message-ID: <6d1b84fe4bb985a2e4dbe5b819bbf19ca77a9722.1767964254.git.antony@moon.secunet.de>
Reply-To: <antony.antony@secunet.com>
References: <cover.1767964254.git.antony@moon.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1767964254.git.antony@moon.secunet.de>
Precedence: first-class
Priority: normal
Organization: secunet
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
index 5ebb9f53956e..e5e8342a4e0a 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2009,14 +2009,8 @@ static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
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


