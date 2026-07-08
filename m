Return-Path: <netdev+bounces-305779-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pNViAlw3TmqsJAIAu9opvQ
	(envelope-from <netdev+bounces-305779-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 13:41:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0288E725F60
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 13:41:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=OT7D5EhI;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305779-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305779-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1650430135CF
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 11:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38C33D349C;
	Wed,  8 Jul 2026 11:35:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3B637A486
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 11:35:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783510558; cv=none; b=tcaq8TXqKyzg3Uc7E+FQrqifUNgfVXy4AKNDzxcSM/vuM0oEEEdu3HKkIh8amWiYdfw4Ef/B0byWtigv3mxmFnrZIHVyEoaTroQ8XyDD5Ef/djXEuE+D/PB5vZmub2yNDZqREivPKxolfAxUfxp8GrWMELv/S4S59ZOVwPTpHLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783510558; c=relaxed/simple;
	bh=Ah83tdi6uMZ65rIqw/348ZXK0jFCKAqKHBYKp7CVmzM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=O/TEy4ZlQu5rFZ3hDp6+Kmcx0M3J39+usjXNU3eVFq5N2WE49vbl4Io92FIV1Fc8bVPMmmVCJ+tlesFKNk/f9ZSa75GOTBKglyBXSfzg7IXMnpu569K0g+bYUOX4dCuRxHEBjMiVOlo1JEaNAry2f4FaQDhiVBTNFY+5RzMxCEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OT7D5EhI; arc=none smtp.client-ip=209.85.214.174
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2caea3f742bso9945725ad.0
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 04:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783510557; x=1784115357; darn=vger.kernel.org;
        h=mime-version:content-type:message-id:date:subject:cc:to:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Brmbfs6RPXs03BhYiS0ot6De5Oja1VZ3H8esF8uHn1Q=;
        b=OT7D5EhITy+wHvzmvqZxMxMmB+iPT+0bGOrGyZCAYNIgkVfNBfaysgP3e6XzjmMtnh
         +fQVg6ZFLm/RdNfmnxQ7gjNo73ZzuEevSGydRs1aZW/nEapAHDoC3aliZOme2Mh7AOO/
         L8GPYjHm+LdDMzwPiyXu6AnkPNubcMgFUE6L7Jlg64nOrqEaR04pN+f8sEFYQTWqq2hq
         jmDq6AnQ/pBUYqZ2DVttG4BHRomNoi6/7MA21MTYLietew3gD6BUmshfVnyjAxG9qJq3
         r1PX2F9ghsNbpbz0Z1/lZdCzoBuzidbRIwKIctCbmi2sA+Gbalqx3tQpailQ6NdVVQnd
         GF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783510557; x=1784115357;
        h=mime-version:content-type:message-id:date:subject:cc:to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Brmbfs6RPXs03BhYiS0ot6De5Oja1VZ3H8esF8uHn1Q=;
        b=GxKHyD5jL/LMtW0DseQ3pQA4wDF/7q5CLH/3nzT/Zw2d0RpSKUbn18q59jVxgRubyd
         gk27eIwpwUSABOSlMAjgIcAOouyW7St39iswmeitzsrgmMlvTJwMCp5VwyX7kmSD9xo2
         7EqTeizuzTxIXOpUH5zTJ8Soyaz5ce7XCP9FTK79utVyCrNQQlFJ70maHLodx6e+cwKV
         9Do4BHNiVjsmK0Zi+lrdPb1CfU2ItlshlzVLPQ13XPNZWqpP1OZQyu6ZDRXXsIy4G3Eg
         8rfRfasZfV0fZmqHwrGhyIBdwwzdLPAmtQtuq9zWYsPaEXBBPlgbVSdi6pqnNesp3N+7
         ePag==
X-Gm-Message-State: AOJu0YycalsLmbQ+rKXsqjnX7c629PAi7bVQNUR866FZyUm2uK1BCwkH
	u4tMmY72ZgKVkcMJcCiuBBaZWcBLGQROqLyMtX81x1kHgAs7spDMFAXJqX8bOXwfgGE=
X-Gm-Gg: AfdE7ckKsvjDV/2vZnhRFLHPxbQeIT66hDHETKcJWVLMMfDGSlPdb0OSTUQpn+IfUf9
	wbBPF5b2j/dvNYHr7GhUIT2LEf45PlYjL4CCSZjt6dtARRv/e+8TLZDXAhIiRw8TBzDS6TNRqRj
	4Qt/qAKHJqz61ErEiEANVnFEVswQjgdUuztkc+rrgXQ7+DTu1wEGxCPrG7kZqwZEe7wSgpaFjAA
	WmukNGEKNhInEBecn6qyJZDIcM8G2JLWC9japMfdYSmcJIFM6+Wbz5dtokABQnbiAhTj6MpIZv1
	BQvMpdp66lhJ8RmBnjDgb/KrDij00abPfrRXAsjRc6zxWhuDmXfZ0wExyl5f9xDZU5vWoccBSI5
	DprtK7ZA+4cHdWMbepanxe0DTLXE1MMo/RkFYQujKOHuc4gx7YEkjdtRfEJavtIWqWqPW3D9LGU
	yVLE1OxQ==
X-Received: by 2002:a17:903:2411:b0:2c9:b396:1a55 with SMTP id d9443c01a7336-2ccea394d5dmr21404765ad.12.1783510556811;
        Wed, 08 Jul 2026 04:35:56 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d59e51sm26989615ad.76.2026.07.08.04.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 04:35:56 -0700 (PDT)
From: Wayen Yan <win847@gmail.com>
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org, horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: [PATCH net] net: airoha: Fix DMA direction for NPU mailbox buffer
Date: Wed, 8 Jul 2026 19:35:29 +0800
Message-ID: <178351055214.98729.11403147818632027428@gmail.com>
Content-Type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.39 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_BAD_CTE_7BIT(1.05)[unknown,utf8];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,lunn.ch,collabora.com,gmail.com,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-305779-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:lorenzo@kernel.org,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:angelogioacchino.delregno@collabora.com,m:matthias.bgg@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0288E725F60

airoha_npu_send_msg() always maps the mailbox buffer with DMA_TO_DEVICE,
but some callers expect the NPU to write response data back into the
same buffer:

- airoha_npu_wlan_msg_get() (NPU_OP_GET): NPU writes response into
  the buffer, then the caller reads it via memcpy()
- airoha_npu_ppe_stats_setup() (NPU_OP_SET): NPU writes back
  npu_stats_addr field in the response

On non-cache-coherent architectures like EN7581 (Cortex-A53 without
hardware cache coherency for NPU DMA), DMA_TO_DEVICE unmap is a no-op
— it does not invalidate the CPU cache. If the NPU-written cache line
is still present in the CPU cache when the caller reads the buffer,
the CPU observes stale data instead of the NPU response.

This is a timing-sensitive bug: small mailbox buffers (~24 bytes)
typically fit in a single cache line and may survive in the cache
until the caller reads them, producing silent data corruption rather
than a crash. The bug is more likely to trigger when the caller reads
the response immediately after dma_unmap_single() without intervening
cache-evicting operations.

Fix by using DMA_BIDIRECTIONAL for both map and unmap, which ensures
dma_unmap_single() invalidates the CPU cache on non-coherent systems.
The mailbox buffers are small so there is no performance concern.

Fixes: c52918744ee1e49cea86622a2633b9782446428f ("net: airoha: npu: Move memory allocation in airoha_npu_send_msg() caller")
Signed-off-by: Wayen Yan <win847@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_npu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index 870d61fdd9c6..b679bed952de 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -168,7 +168,7 @@ static int airoha_npu_send_msg(struct airoha_npu *npu, int func_id,
 	dma_addr_t dma_addr;
 	int ret;
 
-	dma_addr = dma_map_single(npu->dev, p, size, DMA_TO_DEVICE);
+	dma_addr = dma_map_single(npu->dev, p, size, DMA_BIDIRECTIONAL);
 	ret = dma_mapping_error(npu->dev, dma_addr);
 	if (ret)
 		return ret;
@@ -191,7 +191,7 @@ static int airoha_npu_send_msg(struct airoha_npu *npu, int func_id,
 
 	spin_unlock_bh(&npu->cores[core].lock);
 
-	dma_unmap_single(npu->dev, dma_addr, size, DMA_TO_DEVICE);
+	dma_unmap_single(npu->dev, dma_addr, size, DMA_BIDIRECTIONAL);
 
 	return ret;
 }
-- 
2.51.0



