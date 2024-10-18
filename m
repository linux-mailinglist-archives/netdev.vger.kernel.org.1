Return-Path: <netdev+bounces-136872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C67BA9A35AE
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 08:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE5131C20F56
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 06:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6481188733;
	Fri, 18 Oct 2024 06:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGspe9SQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D56818C93C;
	Fri, 18 Oct 2024 06:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729233632; cv=none; b=aPgac4fq9OpAF4kyBhQODgHcY29FlFfpxOuNhPYgOB3b7JhbCe0XiozbeClATW3uO6yZaBjhAgHBwD1yutRMtrBvk3ZZSbh0BVS2v9O0Wp8SY+rqkpB8tYs9qOhgm9eAhxQJaTjto78bwiXieD62GmeCtt5UJnpGaJ9jmjFxE2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729233632; c=relaxed/simple;
	bh=udSu0PifOzRa5GkWP7sFryWEU4fALlPs0aaNg1SJDJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bRbtvd4PzSi7YP1UII6Uw6kHxFne/PROSMYABfFr2E0a/OfipTzI87Fcti/rmKYKRW2IyJaifccft06BRp+4YTcm05LaoXbNdXkv9W7Ajb7PbNzSu5KxsYRprcVfX9VbY8TG2iuj8Yk3Kcar4sGHMJT3MZbD0GOkwqRBeCWkX4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGspe9SQ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20c8c50fdd9so19163175ad.0;
        Thu, 17 Oct 2024 23:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729233630; x=1729838430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZgSPrHkP+5PHa4TM3CPdf/GMcXQ4aZTX0bTblaWKZw=;
        b=MGspe9SQdinHzlmPs9lVi2FgsIoYgtjpuLUJQDxlM0ThcDNcN/L1mWjlAF+K9EmtfO
         ODgI7XdzuHPkV36UA6F58b77DSYudLhW0dEEIaKvPFOJoYUwpPYfGj9JCPXw5ExankQn
         j9eFgKy9I9Q4JEf+RjwPjtNZ1GC8RHEAas4u35RNUTw/AsMKly5tL2C0aQqu85rtqjoY
         /I0lu4l080ZOWKhQaG3j0AYPP3aGHjA0zhkI6qCsBsQ7K2vEpLvmzkcnRCvzZ+xc5Nlm
         V1TUcnJBVvhqz5isxZSvXg31A0LXkCkQyZbtY3G1rvAhXF10zQ+Y/Dx7bIp5Ko2IuNOy
         rRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729233630; x=1729838430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZgSPrHkP+5PHa4TM3CPdf/GMcXQ4aZTX0bTblaWKZw=;
        b=I5mmbi82p7q+Uw0MAiC6vOcSffIffPWTnmr0zcshLIXqWtLP49YizOm4ep2L3trIQh
         79H3yr5eo5KCq6NpEr63SUcTPTOs6NLWc9x9VedsWAYzIWGfqdtNuHhGKDKZk9H4CLXI
         QbkUoEJDKb4VxZ+jm7AELU5p0RYsRQLZAqYvl4EMdlTpsfmMtgWyBHQ0Du0FMj+YYI12
         AffdLma6riADNW7Te0OCxQcOJ1TsHswy/GD+qtDfNFln50+QDhvw7K1kimfBvSVZqiOI
         e/ZF8md8zmPHPOscKHYo2cHf3kXkvY3sxy6eADUEywJltPwXfuY8AwOeVKX2RmDiQb9o
         vD7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVL1iumVJisrmKFTEE6f7ePecSzal28sPPJDqkkU1LPCyBDD0ML9iorkpUeiY2ZbSPzkmQB+BjlZEwFMNI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc6IheHd0E+Cmaq9JSRDhDE536buFFA+Rt9Xxw3HIKNJfMAw71
	WAP7AXN5n+XvUudMpEkZwtDyZWilwKlmd2D5Jx3p4jpwNQrncld0Gs/leQ==
X-Google-Smtp-Source: AGHT+IESugbPIpWfbBYQesKtzI8163cWBzPYauR2huuOlT53gaEAxREbyE0/wzo69ZzWjSymRoyEzg==
X-Received: by 2002:a17:902:c94c:b0:20c:f261:24f3 with SMTP id d9443c01a7336-20d47928b66mr91420885ad.17.1729233629882;
        Thu, 17 Oct 2024 23:40:29 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20e5a74766fsm6285455ad.73.2024.10.17.23.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 23:40:29 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v2 8/8] net: stmmac: xgmac: Enable FPE for tc-mqprio/tc-taprio
Date: Fri, 18 Oct 2024 14:39:14 +0800
Message-Id: <947ce15f80c474be286b3f969f21a74b017b89e4.1729233020.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1729233020.git.0x1207@gmail.com>
References: <cover.1729233020.git.0x1207@gmail.com>
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


