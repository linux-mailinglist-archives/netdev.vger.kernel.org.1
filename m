Return-Path: <netdev+bounces-229322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA5CBDAB10
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 18:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EBE63BB9DD
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 16:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A5E303A1B;
	Tue, 14 Oct 2025 16:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3XnP5N6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F542D876F
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 16:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760460526; cv=none; b=RzWYoR5pywPLF7m0fXVVrUVNkL1yqbHFwpWGFFV/o07pMFiwx0tqvOeZYhzfhRu6grRbHk1v5tj6MC+FV3WUB1+2HpFXl7yJ0BgmR1gEhyHwclMKiFNW1Y33UXGdRP5Jn04irRHE09kSvzVgFpeLVManPg0Xwj+fCPZ6bvVEGDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760460526; c=relaxed/simple;
	bh=y7SyNQdwhQ8j6s4dApzQSF09n017FvNnaQK3OZiKMnA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UjxPq6samgMSqq4z0cupF7JhFM+7ti0u7xLejyZyy6LRihk4lhAvaxZvNk+rtnHLlFa/SGsuM/siJlm/r52ZXn9PHCVE3JVeDorzG/cqCJLwcmrEIPMwYdMKG0KXw/HrCm60GyTyd6BsH4d8ypuCixnb9eAX0xq6VT6JTyhHTS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3XnP5N6; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-367874aeeacso56997021fa.1
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 09:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760460523; x=1761065323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c9Qi/kb9RGo1YDHbWBhpvncWw8E3KoMeCrZ3P00Tm2I=;
        b=M3XnP5N6IrE5DG1EkAi2YhHfIUveW9U3cYHY0HgeVyh9B+MKO7In9LpJqhEibs2RwI
         O1R30bkjgaVvoc21S7PL7PpI/4W9xfCzzTBJqKjfepyBGR+DrfYsh3hkP/8pstP3iCHz
         wTWP/msYnVXYM9b1eU0wAuAM42yqCSONKVgh233ol5rfS3lcqx4JmFR6Sz0bD8F8P7na
         oVqZOceR5/rf3CttbtBb6AlZfAgi+wZEFlMKVpzBCBNgb1RGCY4VAcd6YBWXv+gh3CnY
         7eTqJIdJIU+RHgBIYGGyfGvYwRoZsMbv0Pxw9GjJ7CACsskOzxN/UO3geyFSHejLty+q
         lucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760460523; x=1761065323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c9Qi/kb9RGo1YDHbWBhpvncWw8E3KoMeCrZ3P00Tm2I=;
        b=FR3xm5mjlzzEeZAHdkQ8i1pqJ5ZErNVmfKvo4VHizybxH9rhcRjDrMqYnE3pOARqFy
         KIxMWIYgGoiW4aDS/ApfO9r7wV9hEXVYgCVyaWGCO1daGP2CtMLyvDrHjdt7WC/lFZ+e
         mZB6NGwHqUmiAiAMjWYv9HoXoJrt7BYQU6oBCC4bX+foipKlZ2CxOlYsFuFlxHATYfdw
         XuyXACR4UyfsWso4zeEm3nUuFbJ4umXuQ2NbvLwGhDFWSzalg0P0llj9vzOSJ6Bq9lYQ
         grJpaVXg/bkiH4GlZCSbEqgMrXIei7VwNQQ/AL4iQiEUU0eok8eVaHinWWfefD3RqWlG
         s7ag==
X-Forwarded-Encrypted: i=1; AJvYcCVyQnRZ80cdGoxZtss6xZa7Ko73aUcthgnUXpLIbLPvCfhFFRHBVd3R5y2NI+jcM33pDyVBjXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwcp/jE9iDuB3elx+ym1HGCQKLNAtUEQCbXvFljM+Y4aO/SsdJ
	cVAnec/C9t66TIYWZhc1Ynploq0MAgX1pHDw+u+v7OXcxF25kAFLZZY+
X-Gm-Gg: ASbGncvwaENzSVeBLnNz8Xb6Dklx3JIpEW0/kM/SHRDJ9COOlI1VJJ72Dpro+ur/oBt
	A2bfwLvMcDkvthOZhxsIP6jyGS5mge2ro7BM2fmuMS7FPRi7l9n63PVKTY4B6DBMMPoa0mod1fI
	X9uYRv5BHebfM0f8PyKkDVAwxjHHNMZJFvZHYCx+9SVTBSKnO8b+IbfE8l8WHJSt2bsrEdgrZpj
	1gJPghwT1GDPoLwm5EGijB6oPnXSeqYlnMm20asDz1WP3wfwR3//3WjmF5fwefIsPZ4HilqABuM
	pSt2cEQisuDf03mUsCiyxQJ0zG/T+m8nB9I8gTrS8EgrSEGmk6awf7C7RnOFMFdz2EEfj7l2RfX
	ADt26P30cpMkkuO9C3j4EvbM2/gY3mxyD48VY2bZt1ebrWg8=
X-Google-Smtp-Source: AGHT+IEleG+I58OJH4rnMOXqyKjnNiR2vRFF7DYCaSq9NCZzQPNYtrggccOr/9rYwOrDtGQdKjfMAw==
X-Received: by 2002:a05:651c:158e:b0:36a:cdb0:c1e1 with SMTP id 38308e7fff4ca-37609db8da4mr59632741fa.19.1760460522383;
        Tue, 14 Oct 2025 09:48:42 -0700 (PDT)
Received: from home-server.lan ([82.208.126.183])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3762eb6a963sm40563481fa.57.2025.10.14.09.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 09:48:41 -0700 (PDT)
From: Alexey Simakov <bigalex934@gmail.com>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: Alexey Simakov <bigalex934@gmail.com>,
	Michael Chan <mchan@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nithin Nayak Sujir <nsujir@broadcom.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Alexandr Sapozhnikov <alsp705@gmail.com>
Subject: [PATCH net v2] tg3: prevent use of uninitialized remote_adv and local_adv variables
Date: Tue, 14 Oct 2025 19:47:38 +0300
Message-Id: <20251014164736.5890-1-bigalex934@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some execution paths that jump to the fiber_setup_done label
could leave the remote_adv and local_adv variables uninitialized
and then use it.

Initialize this variables at the point of definition to avoid this.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 85730a631f0c ("tg3: Add SGMII phy support for 5719/5718 serdes")
Co-developed-by: Alexandr Sapozhnikov <alsp705@gmail.com>
Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>
Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
---

v2 - remove bogus lines with initialization of variables in function,
since its initialized at definition point now.

link to v1: https://lore.kernel.org/netdev/20251002091224.11-1-alsp705@gmail.com/

 drivers/net/ethernet/broadcom/tg3.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 7f00ec7fd7b9..d78cafdb2094 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -5803,7 +5803,7 @@ static int tg3_setup_fiber_mii_phy(struct tg3 *tp, bool force_reset)
 	u32 current_speed = SPEED_UNKNOWN;
 	u8 current_duplex = DUPLEX_UNKNOWN;
 	bool current_link_up = false;
-	u32 local_adv, remote_adv, sgsr;
+	u32 local_adv = 0, remote_adv = 0, sgsr;
 
 	if ((tg3_asic_rev(tp) == ASIC_REV_5719 ||
 	     tg3_asic_rev(tp) == ASIC_REV_5720) &&
@@ -5944,9 +5944,6 @@ static int tg3_setup_fiber_mii_phy(struct tg3 *tp, bool force_reset)
 		else
 			current_duplex = DUPLEX_HALF;
 
-		local_adv = 0;
-		remote_adv = 0;
-
 		if (bmcr & BMCR_ANENABLE) {
 			u32 common;
 
-- 
2.34.1

