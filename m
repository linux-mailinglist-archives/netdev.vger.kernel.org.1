Return-Path: <netdev+bounces-269617-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GsuLVlDvGmAwAIAu9opvQ
	(envelope-from <netdev+bounces-269617-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 19:41:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0F22D12AC
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 19:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DFE313028C31
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14A537FF78;
	Thu, 19 Mar 2026 18:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3YBlNPP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E5D3ED13F
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 18:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773945674; cv=none; b=dbhq1CP7Ye3N+rthSuz33iAXOo6+k48Ss2EB48H2XtXtdF2Y/YRSFq3GWfkpOABVSS0Wcd8zPmQ/lR/2OIschf1L4PganYjvnyU5j8M+sxg1hTH2Mc5G76dVoZZXUM9n8cIfp6Rh10LuOyQ5y43KxbH7EdqgPytKpBMYRwtD9I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773945674; c=relaxed/simple;
	bh=ezG3pC99w4U2uwQ/yG5pLTV/NpoABjnTbl6EjBflYnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BMJkrxUVz90z4Hb39kN6IH1JR2WDAseRgRQKGdeL+M50GbiWOxYOpkQlJE18eLBwzaLAaikVz9to5GrOW2rZrC/pBkq8FZfF9hAoyDa4QWQGltO0kMssmasEg9FdkuV576dbP20DTV/K/MPHWr5GI9zuHvcNm5nVj3UDCZxOHks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3YBlNPP; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7d55b97f358so837365a34.3
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 11:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773945670; x=1774550470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wX6S1CdKc2mUwaozX73tCsBdgQ9rtIDSRhAEJ71WCy8=;
        b=e3YBlNPPJhBndwM7QhT4+/pIvEfTThLD9Kaz/rhgubMYCHO0CTApNCHL5iZBhvjEax
         ls+jMrI3ZcTgodf1ZwRhZJGu9d3A8VXSqKT8UAegFhlG7t9V/1bBQvfVTCPqiSwRLTiu
         BpQ52b6SAhsk7jvEf8iMfZRsbZG6S8MFXHmIegtvHxOgXMVvknfRfIcRIthb3B9lyzb8
         fEhwJwi9xjUVTtSGfX6oBOOuPIwXwAOBBq2fhy27GwAx29SLdJm7HhfMdjeasQtQmp6b
         DpBUELMaW+feb6an/xsU/3W7Ed06XIMV5TQaA6ezebpHp+Ix4ZGztNJALnD76/rIhysZ
         sWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773945670; x=1774550470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wX6S1CdKc2mUwaozX73tCsBdgQ9rtIDSRhAEJ71WCy8=;
        b=hfxVrL32QMCZjUDL2dCPhfYgxYiqvNMUZ95GGaardq8CJ9dU/ddbZGRcQzxjknAWPm
         KbHpXw/2cV6kpUqr9hlmp7ruCD8QdiSCA/jSRoAjlv6F93drhwca2ver+q5j0+qggzlL
         D0ljlxZfcw5Txf0o+QOe16C7PN6yrAOXTGPvtoiLRkYDzpzBVx72CMcqB+D9Iymhxh/d
         L0x3fbhlkXe33nXA81kvF/6oD6YZSL9pOR6fidNJxlo8eRpfQFJ5bZnUPcACetRRAeMx
         CDhkenK9K9jRX6LnR1adC6LORO/kfkJBHoXetRCcgWGtyhlRUxBI2S6+tk1yvlzdYGGS
         K7dA==
X-Forwarded-Encrypted: i=1; AJvYcCWb8jhJHd6sWsE0/OEachJxIY0rZ7RBjWYbGtzoK6y0Qg7WEl1ataqyhWImoZ2emFNFVCRBnoc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0mkkNSSoCxqW3fzHXpBhbHhdQjXzF9pjAJ/8dV7hYbhp4H8sw
	2S9A4PC006xu00g0W7DY1hlFGibAP2vpZVKLYUrCaAcdcOhnwBboUcYh
X-Gm-Gg: ATEYQzz7O+M7ub6fwewJH2vbcpq+xlOh6ejv0yyjv5q7jn2ThHbvNnz7TwNI5DWgCI+
	XPzuXEB+nN48pzhe4MIQuVgfgich1DRwgeXFwI4Wh2StuIiIz/+80FjI6CNrsWLSULcCthVeMJh
	s5svWr9MMsHSAiibs8VXfKlfwkQnv7IOazzKxDkRseLJ4L0ReBBceVv5vlhFXBF2ye4WucT8Zs7
	yNgy9Fx4zJjVMbPJMVQCh0ZX2acFLVHHds/UTzEj0+GFwnhBjyHi+vjIyrty5cIM0w1lO/peNXq
	vUHyc8mcsDZboKush/jWGHbmRWifKcqBSDFZhMwFXeHdJQSgzkG8MDettM/dU4UqSc/RXb9M54v
	YCvA+y51gTb6jrkX+vEQDW5gpHKET2O4z1IX64EQVlKipJAESZoDgx63uIcUEJxoHFvVgzPJYFS
	isIMKeO/ed5fseTAIu3QU18Dn3S3hbpIytHkPmw9Dpk2lV6quTGCuNekKCR6qZXaBdeQ6bpaCB6
	MYlRyEUCG4=
X-Received: by 2002:a05:6830:700f:b0:7c7:6043:dd8f with SMTP id 46e09a7af769-7d7eaedc687mr238381a34.15.1773945669849;
        Thu, 19 Mar 2026 11:41:09 -0700 (PDT)
Received: from celestia.turtle.lan (static-23-234-115-121.cust.tzulo.com. [23.234.115.121])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7eadcb757sm181486a34.15.2026.03.19.11.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 11:41:09 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Baruch Siach <baruch@tkos.co.il>,
	Serge Semin <fancer.lancer@gmail.com>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 2/2] net: stmmac: Prevent indefinite RX stall on buffer exhaustion
Date: Thu, 19 Mar 2026 11:40:31 -0700
Message-ID: <20260319184031.8596-3-CFSworks@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260319184031.8596-1-CFSworks@gmail.com>
References: <20260319184031.8596-1-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,bootlin.com,renesas.com,nxp.com,tkos.co.il,gmail.com,vger.kernel.org,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-269617-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cfsworks@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,kernel];
	NEURAL_HAM(-0.00)[-0.803];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6F0F22D12AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The stmmac driver handles interrupts in the usual NAPI way: an interrupt
arrives, the NAPI instance is scheduled and interrupts are masked, and
the actual work occurs in the NAPI polling function. Once no further
work remains, interrupts are unmasked and the NAPI instance is put to
sleep to await a future interrupt. In the receive case, the MAC only
sends the interrupt when a DMA operation completes; thus the driver must
make sure a usable RX DMA descriptor exists before expecting a future
interrupt.

The main receive loop in stmmac_rx() exits under one of 3 conditions:
1) It encounters a DMA descriptor with OWN=1, indicating that no further
   pending data exists. The MAC will use this descriptor for the next
   RX DMA operation, so the driver can expect a future interrupt.
2) It exhausts the NAPI budget. In this case, the driver doesn't know
   whether the MAC has any usable DMA descriptors. But when the driver
   consumes its full budget, that signals NAPI to keep polling, so the
   question is moot.
3) It runs out of (non-dirty) descriptors in the RX ring. In this case,
   the MAC will only have a usable descriptor if stmmac_rx_refill()
   succeeds (at least partially).

Currently, stmmac_rx() lacks any check against scenario #3 and
stmmac_rx_refill() failing: it will stop NAPI polling and unmask
interrupts to await an interrupt that will never arrive, stalling the
receive pipeline indefinitely.

Fix this by checking if stmmac_rx_dirty() returns its maximal value,
returning the full budget (which tells NAPI to keep polling) if so.

Fixes: 47dd7a540b8a ("net: add support for STMicroelectronics Ethernet controllers.")
Cc: stable@vger.kernel.org
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index f98b070073c0..05d3c548ce28 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5604,6 +5604,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 	unsigned int desc_size;
 	struct sk_buff *skb = NULL;
 	struct stmmac_xdp_buff ctx;
+	int budget = limit;
 	int xdp_status = 0;
 	int bufsz;
 
@@ -5870,6 +5871,12 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 	priv->xstats.rx_dropped += rx_dropped;
 	priv->xstats.rx_errors += rx_errors;
 
+	/* If the RX queue is completely dirty, we can't expect a future
+	 * interrupt; tell NAPI to keep polling.
+	 */
+	if (unlikely(stmmac_rx_dirty(priv, queue) == priv->dma_conf.dma_rx_size - 1))
+		return budget;
+
 	return count;
 }
 
-- 
2.52.0


