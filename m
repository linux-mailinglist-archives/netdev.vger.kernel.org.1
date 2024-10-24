Return-Path: <netdev+bounces-138507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BC69ADF3B
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 10:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B019282C6A
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 08:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7EB1B85D2;
	Thu, 24 Oct 2024 08:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeDon9Iz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612B81B2195;
	Thu, 24 Oct 2024 08:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729758728; cv=none; b=WEDWlFAhjr3aPuNSFjQo06KBpDjPEPaWPVja2petw/YeYA0atlGkCqG9ZLrSm6zT72ThrhFk5Odv0U9wqRH/0W7OwMiFBjxdF7uWT/b8vBkAfk68VBJ+YWPLYLBVJ4xZK3Jle94wVBFrEXAQxthl9BBkCKoWhpxu/UQKcmtykkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729758728; c=relaxed/simple;
	bh=zMz9K9VCd1BuUONjXzsj2wW2PG1SnscvORhFw0jPdTU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=idWnsfBydELb3XApCr0xkvm33JcALTU4frCZnSynjUxnswDjqpp4uuNhs8s6acH1uHTa1dFpVLSZf3KbUSP66A0g3AcrCo9XGzwenSDP18YckUW/zYtDhTx/PAFqYPwsJLAkLt6t8Dpy6+eQVRiDA0tAU4CLAiWgpZYqanKbMQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GeDon9Iz; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e2b9480617so532686a91.1;
        Thu, 24 Oct 2024 01:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729758725; x=1730363525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDj2W1cEB0I3jNJZkoU/AfaGHAZZ+DZNAW15dg9eAkc=;
        b=GeDon9Iz/cIt58VhBS4uWkpedCrG9DDG2G4foyQsKh+wnP3IRdmXGtm1Zn4Wxq7hTq
         XWEHRMmy/abCNb5nlU+Qv5BP/4Prz+LsslX+qDNXzUKY/v/Hp6Qk2MxKDWrpzFRTgIRp
         scgxZd1QxaAfyzQ2yGhIgvWHcFrdMHFmIE7aUE353AAwYXE2sUK4uRx24OX8MM0uK8k4
         uaxn3ifDq0/6+aIy0Unucm0t4OGZIMMo/xmcLBVKxVg/BLgM1ntg5FWkphnIEr7ZYvvm
         n8q1yHoLfGajIfg9Tf7F1HRFKO60HIi7PCuHcyNHzCNi3W6PtwLcNFJ+LSFa+/ZU4+Je
         1sAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729758725; x=1730363525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TDj2W1cEB0I3jNJZkoU/AfaGHAZZ+DZNAW15dg9eAkc=;
        b=QpKC8lxHZjuvjjic+7FGiSO/qEDDBu/K9bqMex5q07wINQyztonf3ecZYSrgoa7+wF
         BcZM1ahuVUQZAiQdCWD9BCNiQDHXvBb/t5YvtqI7fxJY69T0QEv/P1YnMPi0WMlYAYhW
         7E6TWc3jfyP9F5e8KMcOzBbOT/SZ5Ss1Z+u+KrFf3563pQUkwxzShQ8ykf6Q7RfQl25p
         jkBWLmadGd+xhCbwkclmy8YOkGJS2augdF0n608548jKuPVYVTELyc+ZCdgwUiLQBC0x
         ZJyHdkPC/lVaXWvDnJ6Oga0j4m//wjFmmbUSRAcUy1NDG7XB1DH2vuTzBY5TqUqAf22y
         LwYw==
X-Forwarded-Encrypted: i=1; AJvYcCXXdZB60BaZYkiM0m4XlcgPOXBKb1yDbtBoljoSneSUJJmOcRmmeof+1fi2jveQv/4g9mxhhflk1R+Qpt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZvfBDL0B+kWWycp/J1RxZuSYSqdaYGcAZWpmuwmB4ZLcje+Y6
	e4VjeBP+O5DSyaw8C2cCVxx6ZsmMpQtESvf0lpaO0WmBhuowvkDghzxl1Q==
X-Google-Smtp-Source: AGHT+IG6vbAWvEZkyrLEBAt6yAw8DnNP0HXpy3nSTdKEniwkKtcm4fM/Jmd+UmyvW9+VJxVf1itXOA==
X-Received: by 2002:a17:90a:cf93:b0:2e2:abab:c45b with SMTP id 98e67ed59e1d1-2e76b605b0amr5267789a91.21.1729758724940;
        Thu, 24 Oct 2024 01:32:04 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2e77e5a4ec4sm868773a91.54.2024.10.24.01.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 01:32:04 -0700 (PDT)
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
Subject: [PATCH net-next v4 4/6] net: stmmac: xgmac: Rename XGMAC_RQ to XGMAC_FPRQ
Date: Thu, 24 Oct 2024 16:31:19 +0800
Message-Id: <12beaf54b466600fb4fd6a068fbd3ed204ab33fe.1729757625.git.0x1207@gmail.com>
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

Synopsys XGMAC Databook defines MAC_RxQ_Ctrl1 register:
RQ: Frame Preemption Residue Queue

XGMAC_FPRQ is more readable and more consistent with GMAC4.

Signed-off-by: Furong Xu <0x1207@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h   | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index efd47db05dbc..a04a79003692 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -84,7 +84,7 @@
 #define XGMAC_MCBCQEN			BIT(15)
 #define XGMAC_MCBCQ			GENMASK(11, 8)
 #define XGMAC_MCBCQ_SHIFT		8
-#define XGMAC_RQ			GENMASK(7, 4)
+#define XGMAC_FPRQ			GENMASK(7, 4)
 #define XGMAC_UPQ			GENMASK(3, 0)
 #define XGMAC_UPQ_SHIFT			0
 #define XGMAC_RXQ_CTRL2			0x000000a8
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
index f934c0510968..c9c2e0b00a0c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
@@ -363,7 +363,7 @@ const struct stmmac_fpe_reg dwxgmac3_fpe_reg = {
 	.mac_fpe_reg = XGMAC_MAC_FPE_CTRL_STS,
 	.mtl_fpe_reg = XGMAC_MTL_FPE_CTRL_STS,
 	.rxq_ctrl1_reg = XGMAC_RXQ_CTRL1,
-	.fprq_mask = XGMAC_RQ,
+	.fprq_mask = XGMAC_FPRQ,
 	.int_en_reg = XGMAC_INT_EN,
 	.int_en_bit = XGMAC_FPEIE,
 };
-- 
2.34.1


