Return-Path: <netdev+bounces-176071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B12EBA6898C
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 11:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27918189F9A7
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 10:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE143253F33;
	Wed, 19 Mar 2025 10:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VRC3lGlv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t/rPAshR"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5681F585C
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 10:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742380014; cv=none; b=A4mecIv/e5hRO8Oit4O+Nj9XhMPnMfjyb/ggfvj0x/luVIuQGlqPq8GwBrUiKz+kRzgD3/542dti/r4XtNeh7919wZXeqJJYestHjcU5phXGgORY0aPxV6WcKSUOwmoeNjXc8J4+fPbnG0kNFZfaUdPKbYuuHZEOXDtbot4kxvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742380014; c=relaxed/simple;
	bh=xpJo7BniFeJ3qScURG1VqRE0BIITF7LM9GR7lZ/lQ20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n/BanoWaRUzTPmF0bbSe0f/CzHX+uhZSr+9/ISdOG3qa+Bkj1sgXWumJ+8OhmobnoEPUtrPq6/9uzN/NETc036F1X99HqImsY2B7zZ2w53QZ1x5TUr6w6SNCs+YftF3vV5DyEc/U9faEzjnbZMxOcWQg6jFRH3XRW4twAu1teUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VRC3lGlv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t/rPAshR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742380009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bVqYEppXH5Ay8ZuM4WwVPsIdI6zdDIi+KShL59kFbbY=;
	b=VRC3lGlv37Y8RgWJR26Eoztiy5KVcUgjLKLKVmKImq1iGtGn9tJF8T4NbxTu9DS1dL8OpZ
	o+PA+lGxl6yZGdFCuRt+rnj618g7ShuLj3MxgFDIDfGbzqM7fHFQRoSoQ5oaK3i6pJkzoo
	kCd0qF5F1rCKsLpCT5pnw3YezlrqubOBDenQhM3parnBGJaJzda+HkNZwU/86XplGW8dBI
	O4HuP/mP2hDJM1Tha73FbHZBZoPArw360wEl6Nx7xqd+uBuoUTUfQjglob4/WqBoZUuoSe
	aBQGGvMaXYX41Hz1vl87ohxn5ODn3PZhY77nTocl3oBXCljsoEyjeFz5VCwVWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742380009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bVqYEppXH5Ay8ZuM4WwVPsIdI6zdDIi+KShL59kFbbY=;
	b=t/rPAshR3XTT9hxQEo+sRIcAUD0B0FZjRZVblI3dGn72dwI1B5yFmM62h2B2sb9nz1O43I
	CmSlr0rhofmIIzDw==
Date: Wed, 19 Mar 2025 11:26:41 +0100
Subject: [PATCH iwl-next v3 3/4] igb: Add support for persistent NAPI
 config
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-igb_irq-v3-3-b9ee902143dd@linutronix.de>
References: <20250319-igb_irq-v3-0-b9ee902143dd@linutronix.de>
In-Reply-To: <20250319-igb_irq-v3-0-b9ee902143dd@linutronix.de>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Joe Damato <jdamato@fastly.com>, 
 Gerhard Engleder <gerhard@engleder-embedded.com>, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 Kurt Kanzenbach <kurt@linutronix.de>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Rinitha S <sx.rinitha@intel.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1224; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=xpJo7BniFeJ3qScURG1VqRE0BIITF7LM9GR7lZ/lQ20=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBn2pvlwE/G17ZGwoTPzdOYfKeLHidnmvgijXbf2
 votplR2quaJAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCZ9qb5QAKCRDBk9HyqkZz
 gpA+D/4kOhRIgomm0Ihhn1CykXlP9YXhPZl2ltxqFBZRFZ4ENKMa5rQJeNbhV9mwhVew7yVYJzF
 5WCHACvaOn9pA3OoAsIYpUlTaI5u8UE79xRxnTaW3WYxVjEnXNZCPFTnGA7ZyiM6/s+GVB1eIDC
 U11JQF89MGI2xpu91xaTfxwkTZ0Exr8TdOtR4ep9XS0QdnsIcivVbBt2onSvSYSF3v6ZaK+5VHW
 2WFZjjbk8MtxnIubCio7LgMGfSgz7ZDu/0gAUtLqOlpADbzM4zMJucrZWPpae0+uzsTLD7HWvvx
 3u1RkxeLWQuAEp1C6EQopr/6Xa/j/ljoUtG4F+a6GK1eIeNGN4CeOoS2BebMbV59LKm/JOFr0V9
 /7MGAj1f6a0tXx1uze8N6opYbljdGoUjE+q3ETHUMJfqDQAnXV9W4h8gmVr2cWfOEF1QCSSGd3b
 bk5afaC1pboX60gk2PTpok3zNpcG8ZnCfq0ElHFbwWt1SY5zo4/9/y4a/71/VIcYNDaJUg1tn/i
 anqO+j0UolNrOiqMbWRgG3Vqqsn2+cxz3WyC9aIjxDF6lcDuDR22ysqhhjrGwVLKah06hYq4hog
 e/pBGFjLFceAcfqpnWL/Id3+07bmjIvutirHqlFK4fKd+kRlr60NJ6/MH1yrJqOaLxG2Au1GWbT
 rQ95mNxcGY9rkiw==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382

Use netif_napi_add_config() to assign persistent per-NAPI config.

This is useful for preserving NAPI settings when changing queue counts or
for user space programs using SO_INCOMING_NAPI_ID.

Reviewed-by: Joe Damato <jdamato@fastly.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 6870803a42455aa1d31f39beb027cf282064388f..054376d648da883f35d1dee5f879487b8adfd540 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -1197,7 +1197,8 @@ static int igb_alloc_q_vector(struct igb_adapter *adapter,
 		return -ENOMEM;
 
 	/* initialize NAPI */
-	netif_napi_add(adapter->netdev, &q_vector->napi, igb_poll);
+	netif_napi_add_config(adapter->netdev, &q_vector->napi, igb_poll,
+			      v_idx);
 
 	/* tie q_vector and adapter together */
 	adapter->q_vector[v_idx] = q_vector;

-- 
2.39.5


