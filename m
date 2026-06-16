Return-Path: <netdev+bounces-299823-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FDz0HR89MWpWewUAu9opvQ
	(envelope-from <netdev+bounces-299823-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:10:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3355968F236
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:10:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=CQFngQ8f;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299823-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299823-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 304D13070AF0
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 12:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDD043D4E0;
	Tue, 16 Jun 2026 12:02:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1145F34E741
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 12:02:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781611330; cv=none; b=VJ1+B0R7SxFJkRwV8G8dJKxozvJ+Fr4zsg08roJPO28gmEcMEI1f9y6XLrIqzRQYBkzIuXtLoObSAZbSVvkZK12QFdHgeqB6fFIXGf8XdAmRtvOd+i8d5G4KtnTFLdJxlqKP7mXY7nSMwQQ/EO7mqtW4WXmYmapIvS6CRZmJgkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781611330; c=relaxed/simple;
	bh=YA05WrW8GLWqzUGnP2oKazYooiYLhjswwVleumjucTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HTuy64JiIbPK0VVYGj/d2TN4Hv6QYQXX77rO/ukDYaPHPL6sw1Ovirz4t3wP5s908SUAhiT+VjMQcA4yF9OqmX/xXuolC2wkAIfHBi6/eEGjmDmqyaOPtWJNuWt2IBv6RB9ZUOTpQX4+Wwxi40jWqZKbkqPMP0Z8G0MpxoZ156g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQFngQ8f; arc=none smtp.client-ip=209.85.210.180
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8424b00710aso3124326b3a.0
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 05:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781611328; x=1782216128; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R6rJ2lBTSRBiSi/3hBuK1toMuKkxHnWeZuud2dPMa4c=;
        b=CQFngQ8f2ZdYiVUEphLUUzUK3Tz/k0dhvTDSjcXbYFEz6Jl8H5j/5qehzreAzJXW4i
         /FjVftIVANff3ftMmKxn6RKJuWN/Y5llGN71FubsDPkut4oe1EFvHaIUd1C5xmHDe2hY
         HS/dmcRRNYzwb3NgPg80wQ3Ywt0yBak7DSBtvdHnGhG5NFgnsQF9lkY3SHj4ZuecU0Zf
         tRpU0+BwZsU2xsXWgaLKtrsBXoo5CvYqVdXyhhOO/pKQHYry/+65S7xR4/eOON1eiRVP
         fxSc7vhZrA2HF+MdwJOFQMMD/zlg1nfBMZ/yuIJK8ziSov67+DTFoEaHaXUm6YnVNPx4
         Dp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781611328; x=1782216128;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R6rJ2lBTSRBiSi/3hBuK1toMuKkxHnWeZuud2dPMa4c=;
        b=a8m6GWjw8h7MFpQhR5TdQp1hXtNZUtepNq9qHMMLs+OlGp+wjs5AZfLMnBkU9uH+I4
         acuM1UxpIGT/y1Ygzy9dblIUgNOACei7s1wzdairZNXq4LhAGjpMSVncexfjwHm4NskN
         fd+nVEaZMqUe3h43Nht030L9y0zyETDs7IwtbHit5cnJbjn75zXSuYxtHMfj5RpdQXJ4
         cxjjV07CfO33mIcwu7ll/HqgCm3JTCyiem+zM7PyL6+5zktOwh0WPRJOm5l5Htw2bSRV
         k2D51+PYOBpFOCVpWruBAQBVA0T0/A2nhhSJ6vpZyixbzhHQCx8+uezQM3I234sht6w7
         Ao5w==
X-Gm-Message-State: AOJu0YypVdLcCn1QmNrP9GkvfT6vAP9sDolIyDa5huRCyuTMuGjYthlv
	I6f9BN3AtL+NUSWIiqeRd0HN7S2Q4t2sVSLbyBNuzJWO52ZIAjpKJQmmNQrrGnqcEzTMPg==
X-Gm-Gg: Acq92OHpXWflaW24e6nC3LTnitGXszVvJu8SzvYaH5TKal15EHSokit4tCJ7X53E87q
	0OJXEeOU+cyqf8k6TO+uj3lgc7mrN5Cw9IoUz5mj0qGdEY5ZdQRJMoUtDM1rWy2GeILV+K9AWN3
	+p/3i7hxlRrAu+OFqJbuEeXlyYa0c3/jC/iegYEcKOZlPuQM3C2uA2/nkJQJpzMTyxN8z+T6Xtf
	Sj6AzRXT0DR0einnyJx2MuU2fc0/v68d6p9fp/fnyYnLjw9i0rquzNBJj/UTPn0f+i7PMSGpqSv
	wWPA1R9EOuNQ5WNJHr/itJBpOg9zJl3BE/BJGgZGxjEXv7t3ZLqK8aEctrgCaksn94yM7wX1Xhl
	n2yqHz8lZaIFE9QcG0PI9VMDFyOOkHz4ZyrZXIxyKTP3sBM4HZ2Jy0iexZiE0/lfXpCTvwtIYYy
	GSfFALgwweolGcnSub
X-Received: by 2002:a05:6a00:993:b0:83a:4846:90bf with SMTP id d2e1a72fcca58-8451566da92mr3284092b3a.43.1781611328433;
        Tue, 16 Jun 2026 05:02:08 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ac9bfe1sm13341635b3a.12.2026.06.16.05.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 05:02:08 -0700 (PDT)
From: Wayen Yan <win847@gmail.com>
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org, horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v2] [net] net: airoha: Fix QoS counter configuration for Tx-fwd channels
Date: Tue, 16 Jun 2026 18:50:29 +0800
Message-ID: <178161132384.2164449.18407700117859190327@gmail.com>
Content-Type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299823-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,lunn.ch,collabora.com,gmail.com,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:lorenzo@kernel.org,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:angelogioacchino.delregno@collabora.com,m:matthias.bgg@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3355968F236

In airoha_qdma_init_qos_stats(), the Tx-fwd counter was incorrectly
using register index (i << 1) instead of ((i << 1) + 1). This caused
the Tx-fwd configuration to overwrite the Tx-cpu configuration for
each QoS channel, resulting in incorrect QoS statistics.

Fix by using the correct register index ((i << 1) + 1) for Tx-fwd
counter configuration.

Fixes: 20bf7d07c956 ("net: airoha: Add sched ETS offload support")
Signed-off-by: Wayen Yan <win847@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 31cdb11cd7..329988a840 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1256,7 +1256,7 @@ static void airoha_qdma_init_qos_stats(struct airoha_qdma *qdma)
 			       FIELD_PREP(CNTR_CHAN_MASK, i));
 		/* Tx-fwd transferred count */
 		airoha_qdma_wr(qdma, REG_CNTR_VAL((i << 1) + 1), 0);
-		airoha_qdma_wr(qdma, REG_CNTR_CFG(i << 1),
+		airoha_qdma_wr(qdma, REG_CNTR_CFG((i << 1) + 1),
 			       CNTR_EN_MASK | CNTR_ALL_QUEUE_EN_MASK |
 			       CNTR_ALL_DSCP_RING_EN_MASK |
 			       FIELD_PREP(CNTR_SRC_MASK, 1) |
-- 
2.51.0



