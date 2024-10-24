Return-Path: <netdev+bounces-138509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5185B9ADF3F
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 10:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F4B82838F6
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 08:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF311B0F05;
	Thu, 24 Oct 2024 08:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abcf+i3H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499A81B21B8;
	Thu, 24 Oct 2024 08:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729758740; cv=none; b=IWPJ8nYg2lrIWe+iG7TUE1j20u5Vfd9bv2rhba+CFkgmrZkmb307nMvtgyghu+5lQA8o4kGBssuvLFHZlEzxT3UhsBJ2vDti2SfDa7+O2oMlAVuclXeu990hjBVRY7WUYbkhu/vN28JG6VB8SvkqaTkTTXGPvJrxzEq0TzXqO/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729758740; c=relaxed/simple;
	bh=udSu0PifOzRa5GkWP7sFryWEU4fALlPs0aaNg1SJDJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f81LfVSblYFaL3lP7juoB1VWGcLij+dwJ8uUdpM7mpXF5I/dHibC7BlXH0Ufc3sE831QQdUTLAa3u7qfQpXckqNlAQvMb0qF/u6hZsZLG/wQwEnAYALXsm8p32mxnbgnBvlaLpjRj3mdLq0EoPq2g4fob00i96Yog9wzkA7rz+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abcf+i3H; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e2fb304e7dso550893a91.1;
        Thu, 24 Oct 2024 01:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729758737; x=1730363537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZgSPrHkP+5PHa4TM3CPdf/GMcXQ4aZTX0bTblaWKZw=;
        b=abcf+i3HvSSa95BIWwINispwYU1qlzRptCe/cvLQvAefDPrw4kxSdRhfLQilZqe0/3
         jEGQy/muPhF/DJp3brXfOhm79DbPj9i0wI5cqibugu/ZW6gZkUQdq+D/lpnrrlOk63pB
         TjyXr/aSwrVdGC923KNSGbIjL0dVzSmRc4bYHgHIEtIoYFYvspZIuGtCWhHBFxnMvtwq
         KYdGolBKUxx4FOWxsFdvQ7XDccCs0fqWG8tBO3YkIPlYK/4bjohyRH8W73cFhW70EMEK
         5yGAITTirbzZ4BmhJ3iy7jPmXQeH18yTTAEiq3pbQ3vRrRpDnOU06p3FXYLxG37+m5w7
         Zv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729758737; x=1730363537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZgSPrHkP+5PHa4TM3CPdf/GMcXQ4aZTX0bTblaWKZw=;
        b=Mtlrfzlh1y5lmPD4/HQCjHCFPKUQFhdWEY2hcCm2mxu7JFsLZi/PYH/dPUBYvIyFuI
         JacGaNRt3uQLFE24a/QRfTj+Uv6jD/Vb9O/KXA7gtYc9nTugR3qCb/tmyfQNRbgeKaTh
         oiY9z8Q2PhU8Vs2ylmGFO3b9qE5MQOJIqq3mhdnvS0ZyYIJ8KgkvI+FoCIPvAaHG8u0t
         sl8plE/nFTPsh+/OhFZfs6aqhhy3FDhNhlIFA7+en1sCM11sZc1xvRP9bsJidD0nrkOo
         FKVNFCHgTb8pphTZAwIbJW/BGfGUAACbUYBPHSNLK5ySyefB4VwVHnMNepopclKu5QFx
         0vLA==
X-Forwarded-Encrypted: i=1; AJvYcCWrAN1ivHSCCh6MDJuMNhhj5sl4irVDnlKMQnBpzb3UaBWCSEnvUhQRPttLYolcxrgKYOb5YarpJudbEOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh2brVvBqXMOw4wLvMynQxeP9lBJ4iVZht4Swj8gc2Y6umCXzb
	bKdiQmR03JDgotVyFLspigWHBt+1J+Byf8I9PjEFcLC7hOPbF9HHNaGPVQ==
X-Google-Smtp-Source: AGHT+IGxeqb9FJneLkOG4JiyKKdDqgjaUa5zcOHcKRWNDzxb+oLM2QjS6gqg9VGE59w8X6F7T8e92A==
X-Received: by 2002:a17:90b:380c:b0:2e0:d693:7884 with SMTP id 98e67ed59e1d1-2e77f322767mr1337661a91.5.1729758736720;
        Thu, 24 Oct 2024 01:32:16 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2e77e5a4ec4sm868773a91.54.2024.10.24.01.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 01:32:16 -0700 (PDT)
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
Subject: [PATCH net-next v4 6/6] net: stmmac: xgmac: Enable FPE for tc-mqprio/tc-taprio
Date: Thu, 24 Oct 2024 16:31:21 +0800
Message-Id: <e26a39e2b8f1165b855f03fc767efd83cb554993.1729757625.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1729757625.git.0x1207@gmail.com>
References: <cover.1729757625.git.0x1207@gmail.com>
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


