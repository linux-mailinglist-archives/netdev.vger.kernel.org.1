Return-Path: <netdev+bounces-263640-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJmdLMjpp2nelgAAu9opvQ
	(envelope-from <netdev+bounces-263640-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 09:14:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2423D1FC554
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 09:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BAD830C157B
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 08:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683C93909BC;
	Wed,  4 Mar 2026 08:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqCD+uiu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0AE390217
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 08:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772611681; cv=none; b=Nk8dJdbDzjFWfGPX/STUqtjOA/R97OsF0wL5S+2IYJszKrciSrKfFsm734skmx6G7puToMOgRBEIHRsPFE8oisECrYRjWCJ+o8jQtu8C0VQQ9sSooA+sLHYVCPlkDaV2tPCfhdTO5CLrT1gI0S5n1LUeAlFn/ORSkoIl5IUxkK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772611681; c=relaxed/simple;
	bh=h/CjFdpAJcVREpfZXVwfif/697poNJIUcK2DAAylgDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JOPPjwDmMlDBPUKAIEfdWPkqPIYJPo7IWrozx9QyzM7/zCTkzvF5QnKuDV+47nB8bgRfLL1HKTu0TFU5oIXUwFh6cg9E8sEub9IeUCvVzaC4OeenC8l5tLTR9CyuE8xWviANbMDEKzdZiLORpqTufCuhDbVJXiWUo8HivHz7WP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqCD+uiu; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3585ec417f6so2775163a91.1
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 00:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772611679; x=1773216479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62PbYYmVOOK5poz3ReEQOuGuTu2sU2hARoRYcSfvRXU=;
        b=IqCD+uiu952X9NlvzEC5txK44rc0zLqq+5VjZEY/UfhhDFJKrkXq9ogsoU9Me1vq55
         dquZI6BEVuDNEJKBY3wcUCgK7q1/xGkjYlQkNH1S0P7M9q1EfKs3xgVe+t7IAgKryS0Y
         zUepRbHwG5UpCYSM1CXr9nLXngGn+8qpujAT2FB5lKeHSGkzJ8z9bwLGrsafG8pR28CU
         45qwsd6ht4KCadn3UiToS9JchiNdQeKSf/+m7hDTrTP/L69lamgelz2ymirKDKS81M1j
         5Ss4gWezdQLxu4DJ7y8XTWRZdOPmm/AjbZWUTzUkjsR4PJhgO5hlCpZfEkswK9hD+hm3
         +zlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772611679; x=1773216479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=62PbYYmVOOK5poz3ReEQOuGuTu2sU2hARoRYcSfvRXU=;
        b=JR4N6cswlRuv3Mo9gSh2Qde7/N5klK0GtNLCvp7aCueg1HPCrPyrVkBCltSwq5k2W9
         g5ThwNb8chvBG5oZQ60plqfvXXGrM1tb8Iw8AX83AR9u6GAhFvXlObOdj+08GzLx+ODE
         EWQS2QYmUv4ZcbaNRC3ZH9i58CAl+BzyHzfd1nFj/wCRrqN4+24V65jRBhTqKxf8Cx+B
         a+SSyEPK/dAcHTavWKoYojlyQeeE7o11owS659XZCKnZEJ34cqcWkdoGzDoLOikx2nvF
         Rv07Js+izeUSpWmvY14q8nimeE9bevsNIu8ygGo1XnMfxCHLUyPAm0S6m9ni8/cNAtNt
         Ml8Q==
X-Gm-Message-State: AOJu0Yx1GoVGRGyn5ZV9ySaQmWE9dmIO0iXlsnRt1/Wtpi04XUOaAoKY
	3ITVWQhIdDDYL3ujFiT1X3FexXRWV7ArxrY2KtGyFJTf8RBtMj+TW1HI
X-Gm-Gg: ATEYQzxMrz2xVZBqk5vw2eCWuMJC+bXRoHjrTij4/59ZE0L3d67S97NVD2pfcvX8A3s
	WC/LxLTFj4+nlRTROEtx8DJlW26JN07t0+XUc/BSWRFVV8i+TsxbqioZFAsITpat74fb/7t0LUR
	dCsWGHvXLtcl5EmB8uvXXrY7m0PLwOn1/lFQXFX2g5jV827tKBpafthA2KedDi0oTHPdrmY/K0J
	RDYoDDjFV/aopz2zJ1FLFz2UfG6GM9dul5bKdXy+pDHZa9m8OWp53T3y1fQXGpGtZLA4j5iSe6M
	ibuKwlc2+lpErNGc92jam9juuzY6tagyWHKKBkxqNd99Q/km7DFGp9ZHjZbrpp0kiEHN3uIJpOe
	vpuvG7hQvTM3rsNWWvpU7PJx6x9LqpjbbDUYB7QHQ4GWhSJ56/lcaLuQ4xwcrzn6KwLbZMCvRVo
	xAXZlyPAThyBF+5p3ZhBypp2U=
X-Received: by 2002:a17:90b:384f:b0:34a:be93:72ee with SMTP id 98e67ed59e1d1-359a6d2687cmr1265093a91.8.1772611679144;
        Wed, 04 Mar 2026 00:07:59 -0800 (PST)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa5ea0dcsm15592172a12.3.2026.03.04.00.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 00:07:58 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yixun Lan <dlan@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Yao Zi <me@ziyao.cc>,
	Yanteng Si <siyanteng@cqsoftware.com.cn>,
	Inochi Amaoto <inochiama@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Shangjuan Wei <weishangjuan@eswincomputing.com>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net-next v7 2/3] net: stmmac: platform: Add snps,dwmac-5.40a IP compatible string
Date: Wed,  4 Mar 2026 16:07:19 +0800
Message-ID: <20260304080721.1658224-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304080721.1658224-1-inochiama@gmail.com>
References: <20260304080721.1658224-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2423D1FC554
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263640-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[38];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,armlinux.org.uk,ziyao.cc,cqsoftware.com.cn,bp.renesas.com,nxp.com,eswincomputing.com,altera.com,bootlin.com,cherry.de,st.com,synopsys.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inochiama@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,st-md-mailman.stormreply.com,gentoo.org,gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Add compatible string for 5.40a version that can avoid to define some
platform data in the glue layer.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 5c9fd91a1db9..02303a808fb5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -396,6 +396,7 @@ static const char * const stmmac_gmac4_compats[] = {
 	"snps,dwmac-5.10a",
 	"snps,dwmac-5.20",
 	"snps,dwmac-5.30a",
+	"snps,dwmac-5.40a",
 	NULL
 };
 
-- 
2.53.0


