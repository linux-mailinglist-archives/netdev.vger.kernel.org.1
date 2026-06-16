Return-Path: <netdev+bounces-299806-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7ljVNeEqMWpUdAUAu9opvQ
	(envelope-from <netdev+bounces-299806-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 12:52:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B94B68E7D9
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 12:52:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=bYvv89wy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299806-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299806-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 557FD300AC1E
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 10:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B455E42883D;
	Tue, 16 Jun 2026 10:52:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C4942847B
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 10:52:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607135; cv=none; b=mwnBmbPSDu4DFVNLc/bay6KFx7udseTVV+fZCp2NDcrMxEFk0BDjuYPb4HSqXeiGGMcjjryCStXFfpg0BYEfIe4BOS6vtY6x5QUCsnwgyhDdR+UFvi/leicLR1Qv/Mb6pkd3mMZbMAjfkup9Wx8FXWrCxnNSc/vcg9bS5vHQCpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607135; c=relaxed/simple;
	bh=xElz6TL/v5/9dkWuZiP4MPbAXo84M+Ts9Zd6c9TM5No=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=G44OLrhh+4EZmL8+ZMqN+QJW4gacxX6Ofb85I+UjmtEvf7nmjjSRf8CqgeBLRRs5uksczC1uXRnKz6L6Uwp1lh7Xno8x9I3AwcWQ8QmSQ3yYPhJmCIF9YhcecYWbkk2w899mZTmYLUluHHEdBxf4SqbIJUBscgbk9RKp9moKuPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYvv89wy; arc=none smtp.client-ip=209.85.214.173
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c0b944f6edso44761925ad.2
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 03:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781607134; x=1782211934; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JsNwyh+KeC3nDRQIncNAKnYy51JDR11+Uff9rlShFdQ=;
        b=bYvv89wy0kS2EZeVT9UZSq+QRocpnEBUHlZsCUDt2zpZx0nTjqkXZtiHOBdse/URpP
         wz7aGo/Ac1PO86/faFH0+ZljQav5m6TYraYOBDgIK214XqkRhgCPmNMQl88fJ4pY8te8
         MaBTGFMQ2g8EbXdw/sHwcULrPWUvA9ITkSm8gqvuTZqJ0KNdGhDA2Lh8fF6T9UDMVcOl
         yJoO9KmZ05dKrCJl5nTjXOh3FC6ifZXVwBNKIv7PkEDIK6SsOcT+QOxB8U2gybPBUQa7
         ieLTMaUb4gietKvT8zfZV4hS4TR9qj4IoI4yIKN7O4vCIGMRwA2gkhXcwzN4qTbJDeI0
         74fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781607134; x=1782211934;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JsNwyh+KeC3nDRQIncNAKnYy51JDR11+Uff9rlShFdQ=;
        b=eM5XHU7JsQ8XUoYZvS+90shaHPu/py7sG9DovlFWYehnIffjOWEVlPk9n9lgS/lNnI
         4MFMRO3ZxLo/45uqRq0FraVqMfzEvn7TZwB+tUo2AACWFMSkD64Id/ccj85Ej59zW9Dg
         F3HY1BOYOBYcWMUKDqux8LrfKhsf8fKQaZWuKhHX97xuoPdNb42RggDvNNDOv0S5sJnb
         aD13bcpdojsG8dRXks4agHr8/UqBnwxw8iPO3Eqj6QbDyz1ZgZL6VpKkpcYV3GPHUnnc
         HLULyx3EiZ/bdwTrqCpviN1cttQrZ+cLe0CUwlLUEu7bE4BUMhtyIkDKlAjxXrka9HH3
         tCfg==
X-Gm-Message-State: AOJu0YzW9Y67BixwyUJ0af1bxxjp8JX24fCnL+KSmkne5PCwBMP0Q8ZC
	u/WJW6XrzHjMZqWyPWfQonxXoV6DTUcFUEVeNHwyJiE8OgiaJ58+2x9Oid39AopL4itGmQ==
X-Gm-Gg: Acq92OHT6bD+sQZ99J21Qfw5ikkvJTSMqUhoj5hxaVWZCFMEksc84LErSWu+9KlCb6q
	fL1w9TSDPydJLb7G3GJSVfYRsFYqKLpNa5WrdKXiNF2/4xot4vAzNOFE4s8GXsMyRIDN0AY16La
	Whh+ggzCyEJ5khEuFYxX4M1Oa/nEikDYIJHjvk/Poo4LhRmWEnR0ta0AGJR+wo/tBBpaT/2NSuw
	GywVf7uLfcz4mBAg6A7v//r8czjH18rnGAcgKAvoVi5xMNX8HvgNtB83RhcGM1BJPVeQYmLcLWG
	dZxgYwQRBPKl50T6t9L5zvFMRHyIX/IWTkkueImvbtEtGgsvl36cMylmFZ3NQ5Qaen9kiUDx85T
	OfzqBq2F1JjAKV8bCCghQcsmQR5IVLUqxv+K0bAm8EchI5cj1bAk+dYUFXmik+XK96wgO220Noz
	ChhDdhvsQ9kluFXxQ11Qa6Q5AEU+k=
X-Received: by 2002:a17:902:e790:b0:2c0:b4f5:41ea with SMTP id d9443c01a7336-2c66424305emr154961485ad.17.1781607133919;
        Tue, 16 Jun 2026 03:52:13 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f7c5535sm130371465ad.18.2026.06.16.03.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 03:52:13 -0700 (PDT)
From: Wayen Yan <win847@gmail.com>
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org, horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: [PATCH] net: airoha: Fix QoS counter configuration for Tx-fwd channels
Date: Tue, 16 Jun 2026 18:50:29 +0800
Message-ID: <178160712947.2156222.3765685889775458986@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299806-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B94B68E7D9

In airoha_qdma_init_qos_stats(), the Tx-fwd counter was incorrectly
using register index (i << 1) instead of ((i << 1) + 1). This caused
the Tx-fwd configuration to overwrite the Tx-cpu configuration for
each QoS channel, resulting in incorrect QoS statistics.

Fix by using the correct register index ((i << 1) + 1) for Tx-fwd
counter configuration.

Fixes: 20bf7d07c956 ("net: airoha: add QDMA support for Airoha EN7581 Ethernet")
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



