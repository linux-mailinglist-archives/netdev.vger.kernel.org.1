Return-Path: <netdev+bounces-140704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 103759B7AE4
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 13:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 417F91C21A70
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 12:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3F61BBBC5;
	Thu, 31 Oct 2024 12:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPxAIQZt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669EB1B3727;
	Thu, 31 Oct 2024 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730378363; cv=none; b=eo34+mDOvXIqbLG2FKlcGkoRKB7VALC6MLDVHrjDxSwNdIl4MRDbKLJRiL+ch05V5JVacYwsIlrv01+c+2/D7xnVEYvZ6MtP+piYpXFB/O/PI4Qcaj1sTckiqCqgl9rRr93FUxl6DCuurJ4hJeIWhD9CANxqSJlCmiR3eItmoRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730378363; c=relaxed/simple;
	bh=udSu0PifOzRa5GkWP7sFryWEU4fALlPs0aaNg1SJDJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BULUr9AwPz3aqR993pRlcqNMiFuVsZAr3riYTECP8sLRady7dCl2SJNibdcfd0vSEqPhoz4CNzRqrIdfbsYm85flPH+8niFecFbmzcU96Hm8EMQR67Bfu2efW4/JlIIna56LnHkwBG9FHxY/Oz1GWJs2I7vGH0DbKOAeqtN4hXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPxAIQZt; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e983487a1so671662b3a.2;
        Thu, 31 Oct 2024 05:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730378360; x=1730983160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZgSPrHkP+5PHa4TM3CPdf/GMcXQ4aZTX0bTblaWKZw=;
        b=bPxAIQZtv5kZxCLcgrXU96DKUhFmPstyCLHYjVkp9TrD8+qFgEW4oHM4hHNRhYyyIx
         tVg2ukhTzhMMEjLch3sLYQLF4PsECQnk7bN2i8XpOc5HnEPpEbqyaclcgPMcu1ecA73U
         2JxTXoZUSiwzWtS4Ak/ozDtGj0eJDyHLdx3IgeW9ex0Cn+Er0F20Qvi/TFkxxtmNQT72
         10crtRRvQC6PkV44DYQMkm/DNtBEGgnKWLX3k2UjM2doVd3Ssu23NCD4vw3yUwWs8lH4
         HI5FTxI9ZWjcuPzrRnOWTMNEZoFfUSrBP1fJFEIIgB7ZQaqw2aqlnGIoIXKBCZlCgPkE
         ff1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730378360; x=1730983160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZgSPrHkP+5PHa4TM3CPdf/GMcXQ4aZTX0bTblaWKZw=;
        b=daemF6RfuTuuUoTP6H8TYm3QVTAsQz9jLXld3BwXvipJVGb8TQ7iRhE4nLKim8VroE
         v8YgudfBBPrSkOwp64EdINLB8Ow9Y792S/NN8i3Hd9q+dI4rvtrOTsVFJY4QKBuhCuDX
         jZbm+U6lhrlsLRocQWYSPXetgHcx+tUx2rPOwGusPNy3VUWVywxsYSwAbgDPDXvq906M
         31sHVsmXjBGJIV+RlhY0PAdG3Z6ziAJ+l8GlcYAvbh3aArRNHUrSYYm83CehW7i6UVSy
         Cgj3f75ND0dZfZQWu2INfXyZm82XvEXAvBl4/gDwTQtZ/JA3LeTHsMoSo6xBAO469GBJ
         iGqA==
X-Forwarded-Encrypted: i=1; AJvYcCXd+xtZK7PozA/r1rCxgRuoSs2a35uWA2r5UMrnpe/S22nAfMU+yIei0Mnl7D2r0nL+nzcagB702qAP2sM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG8N8fIiAAM83LPbM4yhJkNZgXqKFToOotify8ICIlh4ch8Onb
	PL3F39wK2PpSRZc6DIPcstMbZOy4l4gunhudENs45J4JVH+PKLqw9w70ow==
X-Google-Smtp-Source: AGHT+IEYepYTbWzaNjZB6/WykZo7JXNjSOPeC4faI93w6dXeeMLicqGen6Mz6ACbQEadzKBbhQtzhg==
X-Received: by 2002:a05:6a00:1397:b0:714:15ff:a2a4 with SMTP id d2e1a72fcca58-720b9c96d0emr4011140b3a.13.1730378360174;
        Thu, 31 Oct 2024 05:39:20 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-720bc20f50esm1075931b3a.94.2024.10.31.05.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 05:39:19 -0700 (PDT)
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
Subject: [PATCH net-next v7 8/8] net: stmmac: xgmac: Enable FPE for tc-mqprio/tc-taprio
Date: Thu, 31 Oct 2024 20:38:02 +0800
Message-Id: <527799d9e4e28fbd51eb37754f130b037bc0f6ea.1730376866.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1730376866.git.0x1207@gmail.com>
References: <cover.1730376866.git.0x1207@gmail.com>
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


