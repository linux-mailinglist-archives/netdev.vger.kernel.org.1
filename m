Return-Path: <netdev+bounces-110160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B04BB92B215
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 10:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B6CA28256C
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 08:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C28E153567;
	Tue,  9 Jul 2024 08:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6njLnKa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A131527AA;
	Tue,  9 Jul 2024 08:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720513405; cv=none; b=cHvHNQeOnOcbRvUxLKOis2dwIYlWbLQD6dLI3JVwW6vBh2b4K9H71z3jddeIre7uBoWv5B5p35gBKC61MNPB3umQKlv/NGnLLqR26utQZHUaKa2gBMmYHxo1WERrv3BkPUyJw8YEVawLzNq34GUZnxl+10xK96XulDzRHIhmn7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720513405; c=relaxed/simple;
	bh=oEiQb2bvaGSOSuz6qMe7NADDXyIGC4xctDpoDBC1Ibw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TbnxZOG3CjLWjfnIUAndfBbya6CFZkM1igLNMH6pqC1CdqzCwze4IaOCg2KVnh9WbbSuMCNfjI3EF6IEMC6adGDpP49YqBvp+da0A18lOazacY8aq6Jf5x7uZrm2fP2ED/EwXr3vJAaSCf3YJbu132tTJRPx7S4I9fu90dwPHwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6njLnKa; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-75c3afd7a50so2442912a12.2;
        Tue, 09 Jul 2024 01:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720513403; x=1721118203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8/7znqqkBhNFJlanRTa4ag0D5o5jL152q+Urfiz2A8=;
        b=H6njLnKaala6TMtivNJ84MY6f/hJF9FuKR7XGwwXZ5HgRBEIbmBjnoansBY7SvluwM
         ZhVkblaUSB0a6vGTVX1qvGNgrdouPVAT2awATsgjy8bNnmEVXKMHF+BoUn77aJNmayV1
         z1kBO6LPWW9pTXHQri7Q+v/HqZT//B4ApJQ4bP+PmwVQM5JSeZsn6kdUcgZQYl8PB0f5
         9BUrZoMAjvTy+kQ7rTESG/IbIH4RhoNfEJtjNdz6vBnR5ftKAmcI73piNwo0piRqFAdd
         9caQIHIk4Q1n5BtPnMEXCU6uIUbyp1X68+l/jYWCbAFlp15cYZUE/J7aPCUQh5RtBO+z
         g53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720513403; x=1721118203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P8/7znqqkBhNFJlanRTa4ag0D5o5jL152q+Urfiz2A8=;
        b=vPum1uvzil70c1vHVBbeX5e4NpxX6p8+qUaxBQEQc0VwmGJ7jIWJTQXXTOU6I8mhQn
         xeo+XbZXIHyjxhZ/0IJaI/dqRhsjfSw4Ub+Pz4g17PosatxIA+4v694B5ENeRbdG4niJ
         eR7dy6dhoWsTKlg+69aQPXeP/avsO4/vlGHEtKjY+yAx+RFn5xfvedIJcOFBkQOHYTm1
         ixZybNOvCibK+ch7XXKCrwlkuJdcGlzoYddP8nGGaP1T72ZEFDZUpFJe7dVJWFqywIny
         09tZlBMDCPurJ7OY7koRf3R4Bu0obw7bI4SWNOz+jPdrtU+/ANo6ES4QKh+KW8GStkah
         4olQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnbcp+qzWC8kb2FO2Y1sIgLGduEqlMcY1i7QCTcLC1crbPzz/af2rshlYjDtMH9o8llY13epsFUGMKmt4iHALq4WGqxthCxXRxK1NW
X-Gm-Message-State: AOJu0YwE2rl+T2AyoTPBzV57xXNhfSF7JcFlnKs1iLQWuDngtEFvAqMf
	0wt/EJGIaWUy/N+amoxJMjtAW7MCs80DTY+bXpuKKnjcsN37TDAf
X-Google-Smtp-Source: AGHT+IHsqtsn6gyOtXLL7y6Rzws8PcIlR1wfJvphBhSBBRCCn9DI8cbMl/kEnHnZ4m8DDm7Ae1Wzhg==
X-Received: by 2002:a05:6a20:2588:b0:1be:ffe4:b2a2 with SMTP id adf61e73a8af0-1c298203941mr1960899637.7.1720513403354;
        Tue, 09 Jul 2024 01:23:23 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2c99a92a430sm9588929a91.4.2024.07.09.01.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 01:23:22 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	xfr@outlook.com,
	rock.xu@nio.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v1 5/7] net: stmmac: xgmac: rename XGMAC_RQ to XGMAC_FPRQ
Date: Tue,  9 Jul 2024 16:21:23 +0800
Message-Id: <8e719b6c4c1fad64eedb0faad15d7920f708b736.1720512888.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1720512888.git.0x1207@gmail.com>
References: <cover.1720512888.git.0x1207@gmail.com>
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
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 917796293c26..c66fa6040672 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -84,8 +84,8 @@
 #define XGMAC_MCBCQEN			BIT(15)
 #define XGMAC_MCBCQ			GENMASK(11, 8)
 #define XGMAC_MCBCQ_SHIFT		8
-#define XGMAC_RQ			GENMASK(7, 4)
-#define XGMAC_RQ_SHIFT			4
+#define XGMAC_FPRQ			GENMASK(7, 4)
+#define XGMAC_FPRQ_SHIFT		4
 #define XGMAC_UPQ			GENMASK(3, 0)
 #define XGMAC_UPQ_SHIFT			0
 #define XGMAC_RXQ_CTRL2			0x000000a8
-- 
2.34.1


