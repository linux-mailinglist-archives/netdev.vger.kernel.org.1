Return-Path: <netdev+bounces-306839-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id daTEEFknUmrVMgMAu9opvQ
	(envelope-from <netdev+bounces-306839-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 13:22:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0E87415E8
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 13:22:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=fsPK9RDo;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306839-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306839-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F5BC301A3AD
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 11:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73E23BB9E3;
	Sat, 11 Jul 2026 11:21:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6517B30F938
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 11:21:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783768918; cv=none; b=uprLJ0D7GTdu2K2CiW4zeOZJqO78C6u1axAJiKjfv3jn4e/++wPtyFF54kRc4QwYJriwfsbaTzoK2fw58uBgS0MzU5hnUwCBd6uMeRNSa0ZBv/+VBEKs5PIgNaH3CX3kqH+5HhjVXIk5ZK+IUycWTmrDqFnJ+MzUN2nHJBp4WhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783768918; c=relaxed/simple;
	bh=aLVgQ3leMGx642aXBRRSiFOiEu4HM09OXuWn7xGZS/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HJq1cAWQEPCFFkGUw1COguY1Ob6EMYPN5UZ5AmilE+2XXN3TqmY9kUADliMV+c9/ZPMyquymAMF4jsvIvTy01pTlIGWT2tNKjb0d1MOcLBBrrIZ48C3rasY12KXZlBKXqxOQp6F1WJDQpiIzJzckU1O111EPXe21RulyIFawP1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fsPK9RDo; arc=none smtp.client-ip=209.85.214.169
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c7c61b5292so31583355ad.0
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 04:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783768917; x=1784373717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RsxVtJ3F9+zJOkJQ6Hk1HPdO5PzPQX9X5kHg2GQ5Qyw=;
        b=fsPK9RDo6nrz85/alhD7Km/u3h5H1B+4SPUEOy5eyD95/CfBqntV/wW9IHxW5uUPaS
         fqp0hysjI1VIiifTnSp/ZUi0V2dCx66YzeKANC25dQ1lmlbvMWb83gopVXsUjlkdRscR
         lCpclsI4WTr9v2wjb+QcUz/oQOidCqIz/qF7sFl+Ss1olrTHxiEdaLTzF+QA9xVgI+sk
         2ROTOdF/ZJoTdjcehcDvKKDgIECOoVyKDCsoZHjBHua9zXwl8AAxfX8z46VcpLyebG1X
         gV6DHzinpyO/eXPibOsTcNwg591ibsAAju0jbai1bdBpdjAMG+25lLZc7Kh4qyGfT6iX
         smgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783768917; x=1784373717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RsxVtJ3F9+zJOkJQ6Hk1HPdO5PzPQX9X5kHg2GQ5Qyw=;
        b=cpFTQ2bqjP/1K48nNMtKaAEK48wdCgjpTZInA7w6rDEQnEp68z5kl3HKJy1bteqjEg
         jJO2+6UlP3U9Ozj3xUfR9Uidp3S63nPI5iCWugXTBlvLa+uLNA0uKE67HmeXHC1n/jNn
         kZuH+mIfwbdaxWkzrE6xI8pdUdrILNayce4nxH4nwGVib5B7KBKY+c4sNsMNOzCf4pk7
         hqEw9maPhezSk9mPiGJljWRwIahL6GmubTlk+bR8D/VDGVpPNIGPtV2K8C53LNFjwwWt
         gVsR3AyYZNHKst//FweaSx9p4cSzQpUWUyVlsEhZWyGXwS5ogFOcJRZNPsSJP3oOQ6oY
         o5ng==
X-Forwarded-Encrypted: i=1; AHgh+RpHvYsEHYWf1oF3n6CKs9Rbd2Gt/Hi3co+RLwT3bz6nbITOd4ldDzTxrjgS3AeIYzbbatu2QBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5KB4UI2RH9VeHRI5oTYknPQvjV5ANITmjda5X5oZP6KnIUdlA
	oGCQUlngGhBGmpBcJxUBWEk7CzpsX69lEHRbki2reeOWXrNsxQt8Z0D5
X-Gm-Gg: AfdE7cn7yyOuSmHk5JoO0FXbiC1cwPWdwmsZ9UeXhvXnOB7seCu/Gf1KECUxOO3sJhG
	pZ2po166YabHrF7U1OXerXdbv6aRT0aK0i2mn1HYbkRw+zaeo5PgViVMhiEYTiP68uxseBLxSgR
	ZP/2D0Ix380g69eLuVXNa53nnFY+cjaAmVmmIu9GNPzHtdp92aSVelDtx+eROfNNR8wMZPDu/L6
	zh1ZOHOGfZRiXtwALKTJMcP7OdA2HKEx+ahV4NO3e+0tQu9P2SJye8yDTEKs8N3FE33MnOPAW94
	9SZblWDFdWvL/TLY17oixVoR4qtOXM9Vv2yI4nEaHc1w4lkfiNN3id7QHnbWYJFotpjbZtyzGIr
	GV+cFwNV5ESBiEYqIGyC8hV+kRo71i2IWPBdTn0jEGhe38NGBCd67iJEQAHa0jAeAldyAFQ+U6u
	ZVyjmVLlgj65J3FKvf+Ka2kayTnYBKgShzq18NHsAVPFk5f4pCtx4AHQ==
X-Received: by 2002:a17:903:2f88:b0:2ca:b8fd:1a8f with SMTP id d9443c01a7336-2ce9f044760mr26086835ad.39.1783768916739;
        Sat, 11 Jul 2026 04:21:56 -0700 (PDT)
Received: from DESKTOP-VNSSJ2S.lan (59-127-145-64.hinet-ip.hinet.net. [59.127.145.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9c21429sm73254255ad.37.2026.07.11.04.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 04:21:56 -0700 (PDT)
From: Zhi-Jun You <hujy652@gmail.com>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sujuan Chen <sujuan.chen@mediatek.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Zhi-Jun You <hujy652@gmail.com>
Subject: [PATCH net v2] net:ethernet: mtk_wed: setup WDMA_RING_TX(0) for non-DBDC MT7986
Date: Sat, 11 Jul 2026 19:21:28 +0800
Message-ID: <20260711112128.971-1-hujy652@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306839-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[hujy652@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,collabora.com,mediatek.com,vger.kernel.org,lists.infradead.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:sujuan.chen@mediatek.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:hujy652@gmail.com,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hujy652@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C0E87415E8

WDMA_RING_TX(0) is required to set MTK_WED_WDMA_RING_TX for WED RX
but on a non-DBDC MT7986 it is never setup because idx is 1.

Setting MTK_WED_WDMA_RING_TX with WDMA_RING_TX(1) is not feasible because
WED still tries to send through WDMA_RING_TX(0). This is verified with
register dump.

Fix this by calling mtk_wed_wdma_tx_ring_setup if wed is v2 and
rx_ring[0] is not allocated and reset tx_wdma[0] if it's already
allocated.

Fixes: 4c5de09eb0d0 ("net: ethernet: mtk_wed: add configure wed wo support")
Signed-off-by: Zhi-Jun You <hujy652@gmail.com>
---
Changes in v2:
- Address warm reset concern raised by AI review.
- Return value concern is skipped until further comment from reviewers.
- Added a comment to explain this special case.
- Link to v1: https://lore.kernel.org/netdev/20260630144831.1109-1-hujy652@gmail.com/
---
 drivers/net/ethernet/mediatek/mtk_wed.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
index 10d9beaae372..3fd704cac02f 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed.c
@@ -2334,6 +2334,13 @@ mtk_wed_start(struct mtk_wed_device *dev, u32 irq_mask)
 		if (!dev->rx_wdma[i].desc)
 			mtk_wed_wdma_rx_ring_setup(dev, i, 16, false);
 
+	/*
+	 * non-DBDC MT7986 allocates only rx_ring[1] and tx_wdma[1] during setup
+	 * but tx_wdma[0] is also needed for WED to function.
+	 */
+	if (mtk_wed_is_v2(dev->hw) && !dev->rx_ring[0].desc)
+		mtk_wed_wdma_tx_ring_setup(dev, 0, MTK_WED_WDMA_RING_SIZE, !!dev->tx_wdma[0].desc);
+
 	if (dev->wlan.hw_rro) {
 		for (i = 0; i < MTK_WED_RX_PAGE_QUEUES; i++) {
 			u32 addr = MTK_WED_RRO_MSDU_PG_CTRL0(i) +
-- 
2.47.3


