Return-Path: <netdev+bounces-231371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F18BF80A0
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 20:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89A71427701
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 18:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EFC3502BC;
	Tue, 21 Oct 2025 18:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XECirQQ9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50473451DF
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 18:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761071105; cv=none; b=easGTqqt0NuWLJmCoEdod5fptYk6u4+k2vmWMyRMf91SGEC3H6gnu7p+in24hr2js8aKLay86VjqOS6Pbwtfik2XPDiqq2ZoBZkZHIhnQUQoghyyh/8vc5xLBTZtweBIcES17Y7plX8i2U2hOxJ89Xg7V8TnEQBmqduqaECGN5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761071105; c=relaxed/simple;
	bh=uGGtj65PbTrlbw+uhHSVW++NmhcnRg1oiufGnyI2qRM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZjXAmF9Ab47354ETaM5YAXiwd4UALyqy9048DSlFPkyde35XBTg2RHrr/pCOwOViWl/3/vHSW7HD8g5OJzvHjJbSIaCT/j3lZwLHzGR2QXK2bNXPQMKWwc0cT3phBcS/KCt+pYUii+BCjWYKj9DRQO1mzXF6i/VZNmYb6Mz3Zgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XECirQQ9; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-430ca464785so41337825ab.0
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 11:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761071102; x=1761675902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/hRaAHyijOpufUPv49cvX1ntk/2yuvuUY4aCKFAmWd0=;
        b=XECirQQ9heFZSgIbAb5HKk+eGkgpyrS6R7icQrRPvXjL58B/mUFT44sAfleJoxPBQt
         Z5IykCrkSQqUSar5YdJrTQ28GuoTS+o65wo5Ah2nNe+5DkTimbumcyyf+0kK4bdgDXJq
         l51edLFl/JENV3FPvclCgcvxvxzOpokiw0vzYKX/YHwwTxUSKFTyZj7A6Itg6R7Wa4L2
         X0z1FHNm6MXPo9+ScnJt/VP9VxP+WwMeWt/UWrTknJ4VMJR1OoHZruOiZWkDTnZ3EUNw
         WFlCEBlAHKsbtRWBcxezKjGa9LHYNjOVGixmsT0KoHJZkpnZAdXYlAko0iRyxmBj5gpn
         Ag8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761071102; x=1761675902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/hRaAHyijOpufUPv49cvX1ntk/2yuvuUY4aCKFAmWd0=;
        b=AsBRx1qfpnPmCQg25B69/bHvRx8qUZ4ajKkOmu+A21pvdEUYalE4z6pDXvnEknaHWX
         aKhqvcleAqpmtIrsl1AfNergq47i3iGUWc4tXmX0A70o20pN2Wjlu0LagPQzcUUrAaCb
         Ji8flLAHfrTQjU9iMFleSNYQTtNWeUZje+uJzpf7fo+uIEG+xNZiExkgbH5SGSDRxtfB
         /GEV4CCKkoL0ak2UTDMYwNCSRRVamu3LRVWk6WrerMqhu/ZDVzFoB2lGsLMvoaMqg3cY
         r8lB7Y7nyH4Qb+Dlt4K8SDFwAZ3nlexy4wCeG/4fiukUALZTbwRNufbCXTL6BCNvGTUY
         qpcw==
X-Forwarded-Encrypted: i=1; AJvYcCXpWAkY6kDZ5K+asXY+XXY8eoB/7lmbpWEX5wRiVN+6FQE9Z/hcqXS+oRV1/Jx2lKStNwBo0Xk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmnf1+w7yZL97fifBGfQYmfs10rS/sRdJu7pLhNh9MADs1Nr+w
	1S44Agttf7md+t5ivC+czmMdUD5j6sb3A5vbNMI2bSYCE2Ix11+y6gkwoGbSJQ==
X-Gm-Gg: ASbGnculXXqrsjGRTFAgsN19TNiZiM0210wWytOwGuem+yvyv1jeM2UK6O2rNLFYlzb
	t3YqVVj/BhOsSUKWDx7/kfSxrvnANoImuz3NRoHwI7az3YOXll59hLlQccioME7U6k+8GGAOlDK
	5bnQwZWKXtAXrUJb6sF2ysfka7INul086CqRhhR2tXRg+Ngq4mCy0dLiAx0scTC1ebohTZKI1Rw
	Vx7rgGx+y3E3kbDBIqd6QAg0vlic1K80Q1A7FMPr9MPSrvdxiQs46oEGzYScYiJ6ZIKdci3JO2m
	yC16SFsvKCZd87VPaQk+59tGiZZDYQt/i7F+beut13dNw/+qZ5c8Vbpbpunuulqd3SaoNMyIUL2
	Q/ECwO9Fe606v5hDNdv/qe/aMnI61SZGD37AFtjCwV3SgbTmVzTX23p3SMmePn9beuxtSXhIpVn
	+BxPRQdzoco9LPsG1zwPjs0Q==
X-Google-Smtp-Source: AGHT+IEjqZ6+79HpV6r/CD1o/Z4Q+UBJIDYVMWQbNCZ5pOHYsJukoWPbU6x5ZEpq+HAyIA6z7ev07w==
X-Received: by 2002:a05:6e02:1a66:b0:425:951f:52fa with SMTP id e9e14a558f8ab-430c5275304mr291734935ab.14.1761071101704;
        Tue, 21 Oct 2025 11:25:01 -0700 (PDT)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-430d07c9ef0sm45644795ab.35.2025.10.21.11.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 11:25:00 -0700 (PDT)
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: Jonathan Lemon <jonathan.lemon@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>
Subject: [PATCH] ptp: ocp: Fix typo using index 1 instead of i in SMA initialization loop
Date: Tue, 21 Oct 2025 18:24:56 +0000
Message-Id: <20251021182456.9729-1-jiashengjiangcool@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ptp_ocp_sma_fb_init(), the code mistakenly used bp->sma[1]
instead of bp->sma[i] inside a for-loop, which caused only SMA[1]
to have its DIRECTION_CAN_CHANGE capability cleared. This led to
inconsistent capability flags across SMA pins.

Fixes: 09eeb3aecc6c ("ptp_ocp: implement DPLL ops")
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
 drivers/ptp/ptp_ocp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 794ec6e71990..a5c363252986 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -2548,7 +2548,7 @@ ptp_ocp_sma_fb_init(struct ptp_ocp *bp)
 		for (i = 0; i < OCP_SMA_NUM; i++) {
 			bp->sma[i].fixed_fcn = true;
 			bp->sma[i].fixed_dir = true;
-			bp->sma[1].dpll_prop.capabilities &=
+			bp->sma[i].dpll_prop.capabilities &=
 				~DPLL_PIN_CAPABILITIES_DIRECTION_CAN_CHANGE;
 		}
 		return;
-- 
2.25.1


