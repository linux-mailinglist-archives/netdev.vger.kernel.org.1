Return-Path: <netdev+bounces-138110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 679139ABFD0
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 09:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3A0DB25BB6
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 07:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF15158553;
	Wed, 23 Oct 2024 07:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hj+NmgKl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95791537C6;
	Wed, 23 Oct 2024 07:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729667210; cv=none; b=AWPLUnLgcyJPkMWfiKou7onmll1devhiErtQwyy66KuII+Gllxge+6jSwg1Q4L6Qs+eW1MpnPUweUpLrgcc8E5KS8x3a0rdj1dtAKHR3aF57jpBUpTscEFV/aFq7lpFBCh8pnAwx/NaowfTcI2xbJs9umzjD4H7ud2V/MfU8LT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729667210; c=relaxed/simple;
	bh=udSu0PifOzRa5GkWP7sFryWEU4fALlPs0aaNg1SJDJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IBKLOCS7NVxIcJIbf53Q6MQ9iyAacByiGcVZbzRSMGbwLHPvRYIHojjvvV9Uu3XhmH1paasdT4rK2I1ZkcyMQleaXcyNOcEIj4An1kGNUR/CukxmCnrgVJilXnSIc2RzBDwi6pfOPZyMHV4iqBqrQoucrr3AhR/CYJw9cdofkyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hj+NmgKl; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20cd76c513cso54160315ad.3;
        Wed, 23 Oct 2024 00:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729667208; x=1730272008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZgSPrHkP+5PHa4TM3CPdf/GMcXQ4aZTX0bTblaWKZw=;
        b=Hj+NmgKlz3BdLu7K4w9fHNI6ycKMLky8ecckQJG9MabIBuJ/WgAFM2hKA5wpbTByKs
         AXMUsknTOQj4RJWypdjnfTANkVqWI4/XYb4IvO0jEpJgq3wbo7C+P+0kFtp4AMaC9qgs
         qck+51vPdcbkS8aqqDB+ba2CqRxpYVPRfDVRGB6mF49SZEPnNL+Mi6sc3PGPoLGB1siq
         gOrSUtFix0GDDX3CA8Zrp11C6P1nWWPEyTrOMvE/804X2LxdFi8IXrb/5qZ8UtLQZm0Z
         hj0+IOy7Bs5ur7Mf3OpJDMtWsEI1vE4tvuu+kft/jp2Xn70BljkUzNZ8xYx3+8aqVQK0
         g4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729667208; x=1730272008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZgSPrHkP+5PHa4TM3CPdf/GMcXQ4aZTX0bTblaWKZw=;
        b=pcE1za4ggwKFpux/g4WLUWgk97mlwd9UhImaiAHt7H/y6D+Ktm9PS22Cy/8nxnaW5n
         92k+nmHHu+xrKWE4D45aDJoK2glIaKr/5bC27n4AgJAk+pWs9vPI7+ahF2Oz+dtjMonV
         vCJRudyBlfe2JIRERNC2sxSUImRhPtTvn+YGdzwjdjJwsFs+gMCQeLxyW/mpCPhEVRof
         pVkcg/wJf8mtRsz51r+N+vlA4YJQ5cVKYoigkhQpqN6ZbMYgmUNyA6X1NYJ3aZ+8S5Mh
         E0SbnLHo5ZSzjpNbvpBOprnFJPnFSCqx81kz425DPaZSv7/Lib3QOBpU1MWTCjptS4ae
         rqHA==
X-Forwarded-Encrypted: i=1; AJvYcCWezHlU8XgT9xBO6sLAMJCyhWAWPgsy2HYgp5w786k88NGnpLwBRGCq5qoQgHmkR07LW6jxGiARxPV5fAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWPGOFOrRsDy5SfOxA3UURDE/y80Js7dGGETvuMlGVCkDiIUP6
	4hi3DJLGjHib0SDlZrwMecVhU16m13wJo5eUyMc31A1H1JJo7s1+5gATqA==
X-Google-Smtp-Source: AGHT+IELOcrvReuVJG0FMMFGeSqbhWhh+ymRjXHqXoFCyW7Ap1f6pPPW/73rvH7E6LiAd4sPjI6cXQ==
X-Received: by 2002:a17:903:22d1:b0:20c:cd14:a7f3 with SMTP id d9443c01a7336-20fa9e3cdf0mr20205475ad.22.1729667207634;
        Wed, 23 Oct 2024 00:06:47 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20e7f0c167bsm51981745ad.140.2024.10.23.00.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 00:06:47 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v3 6/6] net: stmmac: xgmac: Enable FPE for tc-mqprio/tc-taprio
Date: Wed, 23 Oct 2024 15:05:26 +0800
Message-Id: <8ef55767b07be558f89e8a9959e24c87270ec451.1729663066.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1729663066.git.0x1207@gmail.com>
References: <cover.1729663066.git.0x1207@gmail.com>
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


