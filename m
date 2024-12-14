Return-Path: <netdev+bounces-151953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4187A9F1D3A
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 09:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59E3A16495F
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 08:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F56F374CB;
	Sat, 14 Dec 2024 08:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="hp+iG3w+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB1D383
	for <netdev@vger.kernel.org>; Sat, 14 Dec 2024 08:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734164156; cv=none; b=rVPANsa/bdZhT9WhVCqGqQa7Ou+KbcOnumsXaRRMeCHM2VBfZR9f312tKaT8QcOLLPlsFB/2PO+36jR0IeyOVz6xkuVQvLPR7vW210NVhj2PHqKnrZ1IDThtEaswhmz+y/6MbS5TFzZBjritFnDWr5r7TYA7C2uyxwj7u0C5uFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734164156; c=relaxed/simple;
	bh=rzlBhrsVO6ud8lUeuKwgBOpjgjO5vT6s7FZb9yrPtRE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Bh+xAAfammaWnGiUCfCwm5Pt4W93NrASm1BhU1mpEoNX+rBB0tqE+5Cewd3zRfbiZYb35uO86uCte7ryUIIxLut/PYN/s3M1bNqPQrAraliOKsZuvNUFoK5Z6e7oIzfkHczw9bTtWNT1nw+0GZSBVuRWJoXMwZkn306PTkKNZFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=hp+iG3w+; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2163b0c09afso22731635ad.0
        for <netdev@vger.kernel.org>; Sat, 14 Dec 2024 00:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1734164153; x=1734768953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NkrvS1xSxaibceskE/G8u9ssxN/LaFEx6FjdMx7kI3I=;
        b=hp+iG3w+UxuYm05F4tmctiexbC1auVXqNrCkOK6gcQ8zHYxRKlGP/KTjLxJBHyOr3G
         EWrMuudN+WMe9hMnobKqIkSudLS4mnFwpD9azWJIrnoaPAnl0iQ0V85tugzWiNC29Cku
         2PCCeVjM20VemU/ShMpb8u0GBcNih+o9SLzXW7uLtxMh1MxyvTbrlFm1H5n/fDMfnfJ2
         VvnxEhPulkJS+W5czBh3QqXtjWDFOoxnGlpb1vJcJsWtLdXpQ/WhOgGlrmeKw89DL+33
         p8JYUAHEK/vfix6uETs9MTdkHBeDipcoE+fSELXzDqsedtG/cuPwug/u8n/voZbLaRuD
         D2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734164153; x=1734768953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NkrvS1xSxaibceskE/G8u9ssxN/LaFEx6FjdMx7kI3I=;
        b=r15Tgz3kDJgm6jyeVsMEFizobpFieSqUOrNzD5pj4N7xWW2AbaAaiGgCO2Ff5Llc28
         21PTTFzpwpz+L03y7/iYBoXPrt2xAd8FhwI7ZYUMeI3dxg6XclNx693yCWdHNNhNvFQL
         FWxDZFctreRz2Vyp1+kMxqGgLAq7wATb3ahtmPJ4836We39n0w6nUXug4JiR3bHkXa4P
         tUzy8NQ9v6adagwBchPYGWLucllz4aCQiU7GcYTOUxhjUGQNzG5vTVuxBJU165orhKz3
         aoIjdPWL4TFSAun1hD7uQYLwsV0ij+M+8j6MrtHbicOA5Lb7iQHdrqZeQZCrSPXRBTNi
         spZA==
X-Gm-Message-State: AOJu0YxRz2MKH4FItPO4Kcgue1OZxmfuTwgz4+sfADGzOPg4n/B8RJKg
	WaLgzQrezN6ybbBL8KphnRkqoHT7r5f6Wgh7FqgULat4w7leNOL9DXdTBqjIGCtSVcPZ+m1K0FD
	poL/qRA==
X-Gm-Gg: ASbGncuaukXcqPnCsYCGjvGBx2yQ0wynnbUh40ceV+7XE4neT+5dtI09uo9w48YvadK
	Z48d4cbDJjJq47IDLybaKp+JcRklpSUEcG5rD9pUb2XeQSKdycV761rFub5spPjXs8D9za1AoHS
	mBCcq0fm5jXmaDc5U70GpWbTSyA2iLs76lJxsNaxyXUnvDanOmXbnq+MZHUk7E157aZBsSgN7jL
	OqSOwQgRCQPMCn8/nxavhkC4CwcKAdhwk1jVxpJ9g5bPSuvl8yG7/fhlBWOxqWgkYc0wSUqzy9m
	CM9IBW6VlXalMbB4PHhOcsG2PpzVe/cCLIzRkvTmrbY=
X-Google-Smtp-Source: AGHT+IE31gVV4HQLd+cecK2P81VDvJObvxRd8EAl8q1+HO5X+A2UqE7hVoUz3Gon5rLbtdrwIvpFFQ==
X-Received: by 2002:a17:903:42c6:b0:215:b8c6:338a with SMTP id d9443c01a7336-21892980b98mr61546215ad.4.1734164153292;
        Sat, 14 Dec 2024 00:15:53 -0800 (PST)
Received: from localhost.localdomain (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1db86f9sm8537885ad.21.2024.12.14.00.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 00:15:52 -0800 (PST)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: [PATCH] net: mdiobus: fix an OF node reference leak
Date: Sat, 14 Dec 2024 17:15:46 +0900
Message-Id: <20241214081546.183159-1-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fwnode_find_mii_timestamper() calls of_parse_phandle_with_fixed_args()
but does not decrement the refcount of the obtained OF node. Add an
of_node_put() call before returning from the function.

This bug was detected by an experimental static analysis tool that I am
developing.

Fixes: bc1bee3b87ee ("net: mdiobus: Introduce fwnode_mdiobus_register_phy()")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
 drivers/net/mdio/fwnode_mdio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
index b156493d7084..83c8bd333117 100644
--- a/drivers/net/mdio/fwnode_mdio.c
+++ b/drivers/net/mdio/fwnode_mdio.c
@@ -56,6 +56,7 @@ fwnode_find_mii_timestamper(struct fwnode_handle *fwnode)
 	if (arg.args_count != 1)
 		return ERR_PTR(-EINVAL);
 
+	of_node_put(arg.np);
 	return register_mii_timestamper(arg.np, arg.args[0]);
 }
 
-- 
2.34.1


