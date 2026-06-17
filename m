Return-Path: <netdev+bounces-300038-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gekNLfk1MmpQwwUAu9opvQ
	(envelope-from <netdev+bounces-300038-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 07:51:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3F1696AD8
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 07:51:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=VMZt9jKe;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300038-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-300038-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BC49B300407C
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 05:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA3C38398F;
	Wed, 17 Jun 2026 05:51:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3F03148D3
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 05:51:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781675507; cv=none; b=NkAghPFwdXvvSww/eS+sDLaLUuGyGVntnZcsz8F5Q8cv712pE5+cSU2eiMZg7q7xJ4JZhpKT7W0lZlnXJcn2TcuxbWbmCRJKI4R39e27+a9cXwbsNKGcdjay1j4ZF0AYO7LIXs0DxrKDqgKLSU6TPORS8SuEt+/KOdosIFsgrkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781675507; c=relaxed/simple;
	bh=qfvNln0pa11e9mwon0McWuzEQCAc/DCyJ5DN/ZvHcGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XGlSEnDm5KgcCBbzYTCdkqcc/9ghM61ygtogIldw1RnuRadd4QfNYfA7B/TcBGtM544mck5I1mTk0LqlstNV9EXoSacti4nNbMPyhU5XLm7+MoN/5uAA2J7bKvfraDgAc5TiXjpsgYLpOcjFW7lRSdVau4sEuXq7BwMbrAfI1O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMZt9jKe; arc=none smtp.client-ip=209.85.210.169
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84230ab8857so2494946b3a.1
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 22:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781675505; x=1782280305; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kkxqiQ4zP5GBX+kUzVlvAXk0Z7GWlJPzsDOx8k6B79A=;
        b=VMZt9jKemKDe3PBHJW8rwQvz475AGvIfxNxO6QVRDmhd1O//yxITWE+Qg8PSGIaRO8
         q9ZocFYlIVDNnR1lQ6T1OsBZgBAQwxgo9AN6RS4EL+GKh3P5PHiOhmlnHiXcH1fR3GiI
         yUc81iD0pCNiJ5jznnqkEtPCQlzeUBpVrxF/NmTeMDE9ffZKIfzhtpUSQzL1F0YSaSQi
         YlsArwG+IX6QhSGys1gxq9k/mM2c2uh3nRFTCEtVUzbFmsA4J6PnzTTUXVw6ZOSKNzS+
         DEnhxY+KNe2AeDeNUDhDLkEy7dU67QJIvBWo/MVGGPHJtrTzyGT6wsIjBC/J0gh16yYZ
         h1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781675505; x=1782280305;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kkxqiQ4zP5GBX+kUzVlvAXk0Z7GWlJPzsDOx8k6B79A=;
        b=EDuUfvA9zZXV90DSCgjfRo5w73CmL48tpMv4SLJ7ZM0MXCSPNBI4Az7zzxjW6AUwWR
         +4QLaZh0ZHau66J/JTO5wMsMeY+bdrczFaxmV0hiK7a59PRmRPSZDW/aPvTloDpwxvQ2
         gudj6zBvx/7peUV6DR5xRF03vIAUyt4/AVt0fKDwyl/9YbHgxmeZwCBqmXiiV+gQ+w5j
         RC/WRGQm4vUgAbitWi+34sYJq9ebDmk9aMEg0/d3hj3lOG3qaPQi+8NunKWsqpM5zQS+
         +56nwy+KoxKBpUz24wgwBuZA3k4vuf9N9uqj1TtFXGrQ+HmAWf5WkfRfXwkb47k79/tP
         wyRw==
X-Gm-Message-State: AOJu0YyvhksNqKThjPzjpW53tMOgKRdDofAg5aV2+YOWW2WzyEoX7f1o
	FSrWWNhVr46WUvxCBnvTmJfvYkhHXGIyO/dsSiCOpvuQEkyeNXLMr6j4nWyuxxfFgZ89Ng==
X-Gm-Gg: Acq92OHg+udZuC7o3yOx9TrjKigoE0oJNCvnapjS/FsPD+VqBFvRqZU6w9lbSELXTRD
	mQw7UBo7YSo0sTKO/qhDbx2qM1934+ejJ48JwcRu/w4p7ZBAeSCR016XtvTuISeVH5loXBRMxZ2
	MKYPpcj7XqCprjvNADBYUyoAUSPhBfMHjTbwtVCdcZsgTHlJCvLWJvPe/Id4Duy+iCBfYMGaFGk
	q36k0teuHJQjQORKSZc4X5EDCWwi2MF6aFv+/0kYSdZpR7qgbGCCjw93GKlTaUP3c9G23LoD1XW
	5WJ7tGVd+pOtJAMPmErhg1CQdEJJBLjzxIfEhhuIQCyAQbVVwJQn0phDSF5OiEEoFN1O+2/rEHL
	X8PXZAXleE/GBhlDDlt0SKIMVK/rqr9d62vCpBeIT+GKnJKDyd4qUYDZSeWaTVTbpnyVqcj5Cas
	oeZgyKug==
X-Received: by 2002:a05:6a00:3925:b0:839:9ad:ee31 with SMTP id d2e1a72fcca58-84524444c85mr2332894b3a.8.1781675505554;
        Tue, 16 Jun 2026 22:51:45 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ac9dc87sm13810534b3a.4.2026.06.16.22.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 22:51:45 -0700 (PDT)
From: Wayen Yan <win847@gmail.com>
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org, horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: [PATCH net] net: ethernet: mtk_ppe: Fix rhashtable leak in mtk_ppe_init error paths
Date: Wed, 17 Jun 2026 13:48:13 +0800
Message-ID: <178167550101.2217645.14579307712717502425@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300038-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AD3F1696AD8

In mtk_ppe_init(), when accounting is enabled, the error paths for
dmam_alloc_coherent(mib) and devm_kzalloc(acct) failures return NULL
directly, bypassing the err_free_l2_flows label that destroys the
rhashtable initialized earlier.

While this leak only occurs during probe (not runtime) and the leaked
memory is minimal (an empty rhash table), fixing it ensures proper
error path cleanup consistency.

Fix by changing the two return NULL statements to goto err_free_l2_flows.

Fixes: 603ea5e7ffa7 ("net: ethernet: mtk_eth_soc: fix memory leak in error path")
Signed-off-by: Wayen Yan <win847@gmail.com>
---
 drivers/net/ethernet/mediatek/mtk_ppe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_ppe.c b/drivers/net/ethernet/mediatek/mtk_ppe.c
index 18279e2a70..8451dc3fd0 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe.c
+++ b/drivers/net/ethernet/mediatek/mtk_ppe.c
@@ -918,7 +918,7 @@ struct mtk_ppe *mtk_ppe_init(struct mtk_eth *eth, void __iomem *base, int index)
 		mib = dmam_alloc_coherent(ppe->dev, MTK_PPE_ENTRIES * sizeof(*mib),
 					  &ppe->mib_phys, GFP_KERNEL);
 		if (!mib)
-			return NULL;
+			goto err_free_l2_flows;
 
 		ppe->mib_table = mib;
 
@@ -926,7 +926,7 @@ struct mtk_ppe *mtk_ppe_init(struct mtk_eth *eth, void __iomem *base, int index)
 				    GFP_KERNEL);
 
 		if (!acct)
-			return NULL;
+			goto err_free_l2_flows;
 
 		ppe->acct_table = acct;
 	}
-- 
2.51.0



