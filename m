Return-Path: <netdev+bounces-89530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD2C8AA9AC
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 10:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E6FAB20979
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 08:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B0A4C62A;
	Fri, 19 Apr 2024 08:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZLOZfa2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764E13FBB1
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 08:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713513756; cv=none; b=JK1CgTaOwxrjB6rHhOkKq0EnJDW8x55ODPeeFhp1UXvqLpfoD+V27o4p+5fWc9aLePxqkg9T4ZKCzqyGVtcY6tTwzhCD8l4C6vmqOse6lJ/RjlvgH31JuMdI4mqoKykCYVfVRTOvSHi/T7rOWz4ilMBZpGpMrBGQP2wNqDwHgQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713513756; c=relaxed/simple;
	bh=myVJDsTKa/WXoL1yBWtObLyf8yonTFEDcG8Zxydo+U8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O7aF4bdjQgb4xW0qlR8VjDywp8Iqhf0hZYJ5y1Tz94wDyDVZtmLaNxkapPCzwcmdR+DEWK4V59nH94KFku9v+rma+RsZfqoKfelgh+XY7zM0Jfx0m5rzUz8ggkkXi70qxKP+aat5GC6Febx+A04OHtBc90wRtL4WscbSONfFiPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZLOZfa2; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2a55a3d0b8eso1248726a91.1
        for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 01:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713513753; x=1714118553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+NbIohFzFH14A3SlvF9HeYBj5jvgE3wBhghJ4bHde3o=;
        b=CZLOZfa2i5uNSW96JyJxx/rKj2b64bPNldR+Yz0i7VtUg2LMoKjy13ZXO/ueRe/7XG
         hMPTrBYLQBacwY9j4gfTAOgMSbYvuhYDJUtu0lipv4sZjNhgYP4Sjw/UiAJzRCPZXxQX
         lD7YMDBVcjvMUesk2rFkka7tBX4TFx3WuPmtQp3GA1FGL8kziQt66AFHG00pH3OrH4YG
         ssCyGsqWSTGdOs/0/kaS8oBLGisJWyveqW39p+RCeB276U0rPj17MnMfdsKwsZHyyTmU
         Sys6sfmGl52NOFgyFIqEjKdCqS2ema0jD1X7CHKuzlriOZHUPwvBvL+MuNW7uRBoEecu
         WdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713513753; x=1714118553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+NbIohFzFH14A3SlvF9HeYBj5jvgE3wBhghJ4bHde3o=;
        b=rtuPJks0MDUBGU3/mE619EIVUnb9SZE8jUN58D6FGa6UqWS3yBPs8Vb94fO0eTKLNF
         hcaaaMLrOk+dVakMjRTxh/sLX2paweUzkF50ju/I6fTZcmKGbC+iNS+OjaLHdFk3TW7b
         bEtFgRyxd/gKeW6gmDlkREFQbenon08hyPiRYH/wk0CUuLsaHyzvQqKZpGSnItJHiKIW
         SusAYDx409KNVM68XtHYKd/vyJ4g5Lv2r474GxGJxbRyaGtikHSlz/YMkNG1912wzbQv
         oLwFID05sgtcAz0gCdhBjo0/qWPvUyoYcqCsaNyd704ouqY8XGqfcw9FC17M80osznjG
         7a0w==
X-Gm-Message-State: AOJu0Yw7SG2RzarjXjusaJ+LP34EdprcmHCYvx1bSfOZNOza9C4yQR9z
	qcBpSCYoNTIXpoLEwVyatoQgjSyVSbmSZ0Al6VbNWYDknvAKXtqcUjbcOcvyuvwSaw==
X-Google-Smtp-Source: AGHT+IFEjwzZPgiuLVd/yxNg1EAvsl6OMBBNIxdraC43rkRPkiT0JgZ14y8A5G3KWtCrBq3X0eUCQQ==
X-Received: by 2002:a17:90b:4aca:b0:29b:c31:1fe1 with SMTP id mh10-20020a17090b4aca00b0029b0c311fe1mr2151220pjb.10.1713513753240;
        Fri, 19 Apr 2024 01:02:33 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id j1-20020a17090a840100b002a78c2e21b3sm4331561pjn.20.2024.04.19.01.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:02:32 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Henrik Bjoernlund <henrik.bjoernlund@microchip.com>,
	bridge@lists.linux.dev,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net] bridge/br_netlink.c: no need to return void function
Date: Fri, 19 Apr 2024 16:02:00 +0800
Message-ID: <20240419080200.3531134-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

br_info_notify is a void function. There is no need to return.

Fixes: b6d0425b816e ("bridge: cfm: Netlink Notifications.")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 net/bridge/br_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 2cf4fc756263..f17dbac7d828 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -667,7 +667,7 @@ void br_ifinfo_notify(int event, const struct net_bridge *br,
 {
 	u32 filter = RTEXT_FILTER_BRVLAN_COMPRESSED;
 
-	return br_info_notify(event, br, port, filter);
+	br_info_notify(event, br, port, filter);
 }
 
 /*
-- 
2.43.0


