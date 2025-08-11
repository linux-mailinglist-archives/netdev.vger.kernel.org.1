Return-Path: <netdev+bounces-212420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9EBB20321
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 11:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE64420D61
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 09:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516752DCC1B;
	Mon, 11 Aug 2025 09:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="evaArqwR"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66ACA2DCF65
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754904031; cv=none; b=ThuSWMe5FmpRXjZKhBH3p8+Owmjummt8UWhesPLQNms56H+quIjIvipGE90Xg1sYyhUKl15sfD+TWpxjcatUqmNZaODTEftJz84LIu3ZW6sqnEVLkV8EfQVgQAv3mhxTc9DZVingdt1AJn9oCUWfxcgCIuvPZ6379hqG7cU86zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754904031; c=relaxed/simple;
	bh=oqhhLnQFcOm4lTP+wkeuZAvD+Ol0JWLnCmXLdUalUVU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ogeeA4DWPpglwFeINDFOIUomnTI2O3C8iC2wB+1HgmN5eG9tgGO7b5g4i4PS02qfJsg9MXOX+RF67rpMp+JBNMlaNROPwL3fLY4gM17sN2WvRCSerE2OOm5E5jeN9vbzF+8t1Pz5/jXl/39KOckhXqt6KFkdM/yG5BUkoJc0Q1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=evaArqwR; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 48972207C1;
	Mon, 11 Aug 2025 11:20:22 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dfgskGqa94vr; Mon, 11 Aug 2025 11:20:21 +0200 (CEST)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 22143207D8;
	Mon, 11 Aug 2025 11:20:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 22143207D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1754904021;
	bh=6oxpdCI+s++SIkZs3xMLgGxLCkeF3U6N9ycyA3XGEKU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=evaArqwRFNqOCTUlnIYOlpERPf6ZIgcJAFmgFa885alV5NUkVlo8IztywaDjaC8QT
	 YA/6Go9OpMGTqeN7IyP6waKq8YtEPvEHQ2jY957mSyjl2b4Lv2UjpIa0nJpcnCpNLv
	 fRmBM9d4h6bu7pLl0X/kF11THfVaxy0kCpFWMqpCWqn6qEO/jbhwAdaSuFZFW09gOt
	 BvZWelN7vijCVHX+Xk7/mDNk3FqQMQVadpsW0CegJJUuvPUcTQLv3DCBHBzbaIXax8
	 87oZjW5wsc5gZGZRWID4wyfbQC3gSk4bv29cm1PAzxsEzmMOi56ZkdYQvS6GetUo0Z
	 G9RB+O9aQ1WBg==
Received: from gauss2.secunet.de (10.182.7.193) by EXCH-01.secunet.de
 (10.32.0.171) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Mon, 11 Aug
 2025 11:20:20 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 0D2BD3183FF9; Mon, 11 Aug 2025 11:20:20 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 2/4] xfrm: restore GSO for SW crypto
Date: Mon, 11 Aug 2025 11:19:30 +0200
Message-ID: <20250811092008.731573-3-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250811092008.731573-1-steffen.klassert@secunet.com>
References: <20250811092008.731573-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 EXCH-01.secunet.de (10.32.0.171)

From: Sabrina Dubroca <sd@queasysnail.net>

Commit 49431af6c4ef incorrectly assumes that the GSO path is only used
by HW offload, but it's also useful for SW crypto.

This patch re-enables GSO for SW crypto. It's not an exact revert to
preserve the other changes made to xfrm_dev_offload_ok afterwards, but
it reverts all of its effects.

Fixes: 49431af6c4ef ("xfrm: rely on XFRM offload")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_device.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index d2819baea414..1f88472aaac0 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -415,10 +415,12 @@ bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
 	struct net_device *dev = x->xso.dev;
 	bool check_tunnel_size;
 
-	if (x->xso.type == XFRM_DEV_OFFLOAD_UNSPECIFIED)
+	if (!x->type_offload ||
+	    (x->xso.type == XFRM_DEV_OFFLOAD_UNSPECIFIED && x->encap))
 		return false;
 
-	if ((dev == xfrm_dst_path(dst)->dev) && !xdst->child->xfrm) {
+	if ((!dev || dev == xfrm_dst_path(dst)->dev) &&
+	    !xdst->child->xfrm) {
 		mtu = xfrm_state_mtu(x, xdst->child_mtu_cached);
 		if (skb->len <= mtu)
 			goto ok;
@@ -430,6 +432,9 @@ bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
 	return false;
 
 ok:
+	if (!dev)
+		return true;
+
 	check_tunnel_size = x->xso.type == XFRM_DEV_OFFLOAD_PACKET &&
 			    x->props.mode == XFRM_MODE_TUNNEL;
 	switch (x->props.family) {
-- 
2.43.0


