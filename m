Return-Path: <netdev+bounces-140266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE699B5B5B
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 06:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDD41B22928
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 05:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3E11DFDA3;
	Wed, 30 Oct 2024 05:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ip6nKLPK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D891D1730;
	Wed, 30 Oct 2024 05:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730266640; cv=none; b=ug4cd3DvlOfuhq/8CtGKDQh0LI+wU1P+37ST7AEFCtNbLEZ/WoFtgmQno/3OOZnduCSYkOfRVARexWAhplDWK8jUqCuNhcTpN4JUPPgWk2bybr8FKFJXjdkKPV5zy2QzBQpldkO+SogzTXuhTb2EmlMmbYMXYLugU1lKRFbEOm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730266640; c=relaxed/simple;
	bh=udSu0PifOzRa5GkWP7sFryWEU4fALlPs0aaNg1SJDJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GOn4mCyhi+BeaQQD4v/t5+bfn9g6AOti01zxPXTxvaL+KG8GpwYJY7EUmv3zDVn88JxZ3oDqF8P8XmDZ/9SyNHSSEtyJKJiJmyYanwlJ12Zm//Q5HXzZ3HJO4lpwGby9hYG/8Xq8ECKjTso1RP1Wlbe17OAT08U7yZpie3T83m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ip6nKLPK; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7180cc146d8so3414643a34.0;
        Tue, 29 Oct 2024 22:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730266637; x=1730871437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZgSPrHkP+5PHa4TM3CPdf/GMcXQ4aZTX0bTblaWKZw=;
        b=Ip6nKLPK0tDB0cW/YiOYo8R12lDCesYQIo0GuuiM3t7g30Nm2LYQv4v3s3/mSpxh6l
         AW5Eu15uRg3bj1jGRx5rGn2f5MMlZdaXp5TBClyPZCOckXVADMtVJcX9cJjyRlw+ySI8
         Fo7rKE7hENM139ZmuoHTYER7KhBwgIJlxYMRSj7do5hlaudoZkFBgSgc9siVQzh+2F/V
         Vljok9oKkuRbugL4FMyFXrb6VVZUkiG352nl4NDhPGzyfBuC/qq9Vy7pCnZ1ophdXOau
         xmN8Np/Zae+kGzSSJUMtv1VX7MsmUpmlJk+CqGTts8ynQ+XX9WJumW9fJayi0D6jb4ph
         Jo8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730266637; x=1730871437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZgSPrHkP+5PHa4TM3CPdf/GMcXQ4aZTX0bTblaWKZw=;
        b=vRkwArn1e8zQehP2dxxCcp9XLEpXv5kV8tQiWT088So5joZ6kspDa64X/pXVAvcmAH
         XiHWGorxMzLI9MEh79pU0N8wd+gciN5E4AxuGCFtAHmxHhSDKVuwnLsi0lbja0f16JDk
         XT8FKvyOO3i13AELJ4mgc999tV3ssrZlH47P15u16D0+2kDNyS7Fp5Qbhr8Ayd4TlWYl
         PkTLcr4s5d3dSW38HET3t6MY+6TdHlCeY/fnYvhBXFg9mnyluOPvqCKCKmwFJizbjxht
         CtS9B/odsaTDGFU5gdCDobX1bW9Rvx8Nz43yrYtt0fjl0JaL2fZSu7rYV2pOniWatDOT
         KaKA==
X-Forwarded-Encrypted: i=1; AJvYcCVDaERmgEV0wq+EwsY66pdgZ49RoP0sgaZi43wvF0K5yfMtfEa5Swyz9NtoaTvqXCInwmxTxnEUgBAYJHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwnWgWAkPaFVnExseDNSsuFeqF/RGnkU76a0dNAdv4FY703Eku
	g8qA4uVl+6J6+xqGMr23SlznDaSu+DJkQcRNY2GM5r4wFT+86TTSCL5gnQ==
X-Google-Smtp-Source: AGHT+IGMcZP86Gb9PnWt4RuHGD9rvSbLa8zwQO6JV3gjbDXZLVASBGbVFvRNeULnympjKkTbrbfaPg==
X-Received: by 2002:a05:6830:43a7:b0:710:f74c:1b2d with SMTP id 46e09a7af769-71891ffc758mr2049461a34.2.1730266636633;
        Tue, 29 Oct 2024 22:37:16 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7edc8661098sm8516595a12.8.2024.10.29.22.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 22:37:16 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v6 6/6] net: stmmac: xgmac: Enable FPE for tc-mqprio/tc-taprio
Date: Wed, 30 Oct 2024 13:36:15 +0800
Message-Id: <661aeb8658f53e71814d204da393968b998a9939.1730263957.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1730263957.git.0x1207@gmail.com>
References: <cover.1730263957.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The FPE on XGMAC is ready, it is time to update dwxgmac_tc_ops to
let user configure FPE via tc-mqprio/tc-taprio.

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 75ad2da1a37f..6a79e6a111ed 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -1290,8 +1290,8 @@ const struct stmmac_tc_ops dwxgmac_tc_ops = {
 	.setup_cls_u32 = tc_setup_cls_u32,
 	.setup_cbs = tc_setup_cbs,
 	.setup_cls = tc_setup_cls,
-	.setup_taprio = tc_setup_taprio_without_fpe,
+	.setup_taprio = tc_setup_taprio,
 	.setup_etf = tc_setup_etf,
 	.query_caps = tc_query_caps,
-	.setup_mqprio = tc_setup_mqprio_unimplemented,
+	.setup_mqprio = tc_setup_dwmac510_mqprio,
 };
-- 
2.34.1


