Return-Path: <netdev+bounces-267989-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPqiBaFWt2lyQAEAu9opvQ
	(envelope-from <netdev+bounces-267989-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 02:02:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69968293353
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 02:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E44330293DE
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 01:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD4E21146C;
	Mon, 16 Mar 2026 01:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZoAtixp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A8821ABC9
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 01:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773622869; cv=none; b=citYGB1STH1a1cXFOZkBPG87OcLfHnezCAeSBWJP+IGO9FlZ9frnEO8Y94MEwl19V54KAB93r6mguuqx6YGcTM3gwa6F9Ral/AjdeipuKEhb0vflJPY7AO1Fea5FBF7WMvLAHh6rc7hSh6i7DI1u59LHiDpWMxmx2mF+l5FeVV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773622869; c=relaxed/simple;
	bh=oXR7vTLd0I1RsCDRTzJ+Auh0cCkgfICbXcBBqdH8Z5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WNjH4KBzha1E//kfEN8j/2lC9d8cGirR+kRbti9fmTDgKIqdrthAmwoV+ZzI1Yfp5Ds2keR0c/4WPnUElZAHz3nPj191obUc4CpfCA+499AZ5LXtOjrvIMFm7CNf0sZkBz8JIKtu9IWSzZt5sfaTnf2IYQcyeR9llVAV0rBvVwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZoAtixp; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ad9a9be502so24074305ad.0
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 18:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773622868; x=1774227668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67f6aplaQjeW67VXDX4TdCndW5aSx2/hPT60hva8Vws=;
        b=WZoAtixp4HTELIgEbTkFX/oEibL8IlKhkkwi36RH0V0niZeh3izt90Ad3qnkpKOXEW
         otvRMBjnQYPz4jIptm1RY2Op98BVhONvc+GBFs7XEEBZtO+5sfcTZnTvXZtwrKG99gDu
         HlDHiRpC/RekYqlJSLQyVAY5hpWvQ6wWyktOsS+1shUeyPXSGFJGdEVweLAjNg1I0V/c
         W5RfZC0F/EXxFNUJukJlVwcN13fjriWWWvQpBYeCzOwT+VfdaSKBakZykdSpsFr7CGK4
         3Sx81tfAOEySOpXIxCRFS53x+DZ9eplIctqgLjXKipjXc5uSoQJGMIC+/ZUlF9HKaOuw
         9E5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773622868; x=1774227668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=67f6aplaQjeW67VXDX4TdCndW5aSx2/hPT60hva8Vws=;
        b=paxw9F/bFBV1pfX1t/pP0uwj8eeBt1JwBKSMB+VPxrCvLgBtxit9Esng3XvarrItt0
         Bf2w38yLr9FflGB+skYt831WqJCwwOLcmWFe3oj2mmBR2d90jFdKmaQlPKjPFvpD8dhn
         zfSf/XWs7lJ2NMl82jCkIoJJ3AWxAGGcHsFaVfsd58QOb2xoQDbBnt9iDCq7T5SYLLS6
         LcYeNVQSG4u3X2dgqe5TYInPAIVk/4Og5dNGv2I8L82PmKmR9lP7ZPQBSqCzvSVXtlPL
         HpMbCKy+0gb/UAfpaF5Pka7u/yLXN8S3n7ObsZxgYeyuXTOT9OhT6nisIzIFg3LI4/vu
         rATA==
X-Gm-Message-State: AOJu0Yx0Te+Tqo0erjkYx94zUfsWz0A1MHTbqtfShmukfbcGwbd9pOQT
	9gb6Gj9qQYI7ArUFm4Mr7WG3cPal1wFNFULuk/mlXZvZznH6gpTuFMDE
X-Gm-Gg: ATEYQzw7zym2MpoBenhFmLW4o+E5BgyhO9RjHW0WPy0iC/ie9xeMht7KpJ5en4Vuzc/
	qXTf8gFW3nqzY+lccJlrCrlPF9fCg/ucKMerTht3NGF47Ocv6L7DfrN4lKcfsHNKNTyhU31pkYT
	HMh0XgoR9kUSpO3fZ4LbGwfu+HqATPn7r0m60Al4SNs8bINqaZ2kiFpe4iTrxSgHjRYs7ct2M9q
	JJT5dM5UzuPR+R0EXeRxPeQAvH/05dZuE27laUA4ZC5durIoyju1i+lB3sNXQieTfy/N31M51Jc
	j3a6mF3kYIu60imGKLPdRbLvuREf6fOFnlbCmOArz4yRwUaLh4qH3T+LRNF9BdNHkRQk6MTp2SN
	zjCh6JVyLe4MhOotLuXZRtw8Ak8/2OIvmcZ4PrsvTPHvQtleMXp5theWDxoe6GKpGapWmJ9TDjz
	Ej2A5QdwJ1q+FS5Xa960D5v1zUvaV+j211sA==
X-Received: by 2002:a17:903:b8f:b0:2ae:4fc7:8053 with SMTP id d9443c01a7336-2aecac6c131mr104368395ad.46.1773622867648;
        Sun, 15 Mar 2026 18:01:07 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece839dffsm89559855ad.78.2026.03.15.18.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 18:01:07 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Inochi Amaoto <inochiama@gmail.com>,
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
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Shangjuan Wei <weishangjuan@eswincomputing.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Zhi Li <lizhi2@eswincomputing.com>,
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
Subject: [PATCH net-next v10 2/4] net: stmmac: platform: Add snps,dwmac-5.40a IP compatible string
Date: Mon, 16 Mar 2026 09:00:38 +0800
Message-ID: <20260316010041.164360-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316010041.164360-1-inochiama@gmail.com>
References: <20260316010041.164360-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267989-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,armlinux.org.uk,ziyao.cc,cqsoftware.com.cn,nxp.com,bp.renesas.com,eswincomputing.com,altera.com,bootlin.com,cherry.de,st.com,synopsys.com];
	RCPT_COUNT_TWELVE(0.00)[39];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,st-md-mailman.stormreply.com,gentoo.org,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inochiama@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 69968293353
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add compatible string for 5.40a version that can avoid to define some
platform data in the glue layer.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
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


