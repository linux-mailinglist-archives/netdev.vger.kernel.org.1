Return-Path: <netdev+bounces-301291-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id moi9B2U6Ompn4QcAu9opvQ
	(envelope-from <netdev+bounces-301291-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 09:48:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6255B6B4F93
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 09:48:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=XdXRDIyJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301291-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301291-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8FC3307F296
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 07:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84C43C5DC5;
	Tue, 23 Jun 2026 07:47:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDF33BA253
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 07:47:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782200828; cv=none; b=Eyg+JDbItRY9Ku8Oib0ymh7tAqo58naSHtcYXXY0myC0aA7Zg92g7yVODnEa1XG0sOUCt/3dp3jcRHXJBG7ePqyFtzBwWye43S8oLbLnJqAExfPF4T5VWN+mI4/ppoIvsu2yBRKSvq840a23qkF1Y1FiNOMOiDUi3w6/Fg+PSmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782200828; c=relaxed/simple;
	bh=EXUbPBa7rv7rs1r8YW/fmhj7HW1HR6AkwNyGcZQYoYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RrWSSUh+DlxKbUKZRznPsmZFhNRmYIaGXjbKwK1Ah0EsAiK5q7ZaItl0jzeyfLyTBa+dbVcJSC9xVfOEeCUun2rbmugLl7JzwlubV3xXSqTasXQbzf8OlLPOoMN7oVZKNjttkDu2D8f1xy/C5vVMLC6lAeCtN17lETtKmV8vU3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdXRDIyJ; arc=none smtp.client-ip=209.85.210.173
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84347ad88edso4537770b3a.1
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 00:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782200824; x=1782805624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOXvZJIgT1xf7y6r5/ilxE6ikYQEvsUFg4mACphcji4=;
        b=XdXRDIyJHEjxfZsAzZHVsRNjQDJuhfJ6nqme5Hljet4p5LFK2JgXNAhHynqoWKJrOO
         jgyZK2tOUYnfcRNjfXi6sPN5ebMas5SkokjFJ2yU289jm9XmuIKWxSEY1Pjcjkf0tfXz
         u+PsqneDllE+fMeF8675v2Aa3XSLAHseZDxvf3mWXmCCP4oIOTlSf34UZ/wmGqrWA3fu
         OSNiCJCI6paaWKCcRe918BymPzzY6toOHWL192tjqfDww5/oEP2FubhdQk6/nVevrKqD
         TzZsnsHDhtFw0IMF6OPYQH/rYpYsAbi/T6ZGQC648FWk5D2/dPIWwDpTpiCDsKf2qgPo
         +tlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782200824; x=1782805624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HOXvZJIgT1xf7y6r5/ilxE6ikYQEvsUFg4mACphcji4=;
        b=NN0+a25g8qkWW5rEnvgy12dLONNsrzfskiEt2veW4itWk7wm8ImsHul2+iwpPPCrI+
         M8ottkJkGJl3F8x9WO+iAHv7gGW46BKyRB0wRGIMX9+h6eyj+TBVhwpFGGMTLthLxoN2
         p8+jchHD86ElsgGbCMhq8SmVfkPhg2PN+HfWgycRYbAUUkkCMOgaHkQQa/k5QK4Umodp
         LUkkX3UcZ5dNQPFnMtPCpHcHGpcR86Wc4UCPWjDqwWzbOa4OAtiDDRczScNT0Eo/1yxq
         iNyPisiaXYhdry36+cZlZIdFi3vh9cMRywm1awjXsCVUFy1llOrA15lMoOCh0EhjYS5a
         96sg==
X-Gm-Message-State: AOJu0YzSnr2CjUncN8uu8QZ4mKSUHITyjnOCdTyeEuDz+oDhWYUT9iX/
	Rw1ZN6DKJV+qTspb77mhWgssOXtOMpbt3UYV1z1xu3l8cduUqwRbl0Jg
X-Gm-Gg: AfdE7clC44yNodwzNtTuYhTyMdFfA5KayCTx2bqte/6ol+JKheq9LJT3LcW7iub4kwa
	CYmg8cP6DLypzFzUBZhgiGer4EImjpVb+/nIXzO3BtEx9+TPgYDwkDTE4cpQhJs2XCG2ll6coPz
	rcPP/u2TzIWQrCQe+N2059px9S7eAANb5JCU9Et5gnx9XAzXe9ttAxkNVIUIhaeusxpo65z7nvI
	sXlPP1jZFS3XtZH2FqYcuGRRP6Xwl9dopTjhkF+r8vx/FB9Qex045pbtEDV8o6DppDLQT0NVLKu
	H9DhAWVoqi0ia8yiDJtGl+vrTk3xEPXGjJ597EkmjgXqznto3z4AVxIvDIVpWvM2TOukjv3T4wP
	pKqkHWmOdfJqSmsNYNpYrHiPB6qQSPZwidya9evD5H+slxwObKAy7F3lSpgbz2/O5pTaVTyCpTJ
	0ksipgV+hMC0w=
X-Received: by 2002:a05:6a00:3e21:b0:841:69e4:f21b with SMTP id d2e1a72fcca58-845508d3c1fmr18398996b3a.39.1782200823739;
        Tue, 23 Jun 2026 00:47:03 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564d8f1a1sm11063117b3a.18.2026.06.23.00.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 00:47:03 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Inochi Amaoto <inochiama@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Yixun Lan <dlan@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net v2 2/2] net: stmmac: dwmac-spacemit: Fix wrong irq definition
Date: Tue, 23 Jun 2026 15:46:35 +0800
Message-ID: <20260623074637.503864-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623074637.503864-1-inochiama@gmail.com>
References: <20260623074637.503864-1-inochiama@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301291-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[inochiama@gmail.com,netdev@vger.kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:inochiama@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:dlan@kernel.org,m:rmk+kernel@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-riscv@lists.infradead.org,m:spacemit@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:dlan@gentoo.org,m:looong.bin@gmail.com,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,m:looongbin@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,foss.st.com,armlinux.org.uk];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inochiama@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,gentoo.org,gmail.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6255B6B4F93

The current irq definition of the wake irq and the lpi irq
is wrong, replace them with the right number and name.

Fixes: 30f0ba420ed3 ("net: stmmac: Add glue layer for Spacemit K3 SoC")
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c
index 3bfb6d49be6c..322bdf167a4a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c
@@ -22,8 +22,8 @@
 #define CTRL_PHY_INTF_RMII		FIELD_PREP(CTRL_PHY_INTF_MODE, 0)
 #define CTRL_PHY_INTF_RGMII		FIELD_PREP(CTRL_PHY_INTF_MODE, 1)
 #define CTRL_PHY_INTF_MII		FIELD_PREP(CTRL_PHY_INTF_MODE, 3)
-#define CTRL_WAKE_IRQ_EN		BIT(9)
-#define CTRL_PHY_IRQ_EN			BIT(12)
+#define CTRL_LPI_IRQ_EN			BIT(9)
+#define CTRL_WAKE_IRQ_EN		BIT(12)
 
 /* dline register bits */
 #define RGMII_RX_DLINE_EN		BIT(0)
-- 
2.54.0


