Return-Path: <netdev+bounces-165361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C453A31BC7
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 03:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A7F83A32D9
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 02:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA65514A62B;
	Wed, 12 Feb 2025 02:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZEfCwtL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528BA70809
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 02:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739326400; cv=none; b=ToOOkemAn26YUDtxVBcrHhT/RBvM2bbcVXlfCUGdUGJQsXUCL9hAeSxvBp7JBszY6KXNZLA2ia86BvMBn8GsTpWuUsaRc1U2poUDp5DDlNPfa3Je6yCvRV4jXucWqnO/4K+2B4xX3adH3h0nP6sAGuKHAuoCBFn4/TwOfLYkSgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739326400; c=relaxed/simple;
	bh=+/B593SmQT5mbUFkEjMNutNlFiqH4deP9fAgQLDXXvM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WtB1yK4mls2Eu+1t+NnrTI4O8+IqmFi5K6oKQY2W/BPmNys9DuIhGZr3iPwd7LP32J9roWS2QK3UJ4Q5PPoN30LLbMOpQuNNEwToRn74OVN45guVREIvTFWGr3PxDDFaOH2bq5XyKeEO5GMONs8qrAQGYSD1BmH8QG2a3ZD7wxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZEfCwtL; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220c2a87378so265655ad.1
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 18:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739326399; x=1739931199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Pnx2/jJtG4JTadkzEhw1I4yWW/cg32nWfvMiGMEaiU=;
        b=FZEfCwtL1GjQeZboJpOrj0xnOAqtlMs+1/vXPY/iGKpkjegkEI4lfsvX4uWdoak5I7
         38/vUBt77S5mR6ezu0fVvkin7aEUQ7S83dZBgdgdFzGmGRtOoe/C6P931Pi4oFtH5cQH
         8HgRL/B3AlPC0rUYcn4rHWtDDro/Y1Za4jUop/iIWwEFerqFim97qbVldpKH87djaswa
         SLXdVDyt0Q/aEew04LgCOQOVY1QaDFlGqVO/3riRKTIoXm1nAG2R6Dgejxs+ydgxHaRl
         T6Zk5jemYaJUD/w6CqhlgFiiF/1rwXxEnXKSEA5lISZ7ufsccS+59QAAEtWS6riJzP4c
         ZS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739326399; x=1739931199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Pnx2/jJtG4JTadkzEhw1I4yWW/cg32nWfvMiGMEaiU=;
        b=jC9SUcNYCmZzOUh9DLpp0VxQtfvC2ssGExJwdbxCIF1JRsoaV3q9duS76la4JAGJUR
         MpWGEQ2rOGoKVYZn+YupWx8iiMxeqmy6c4H6BpSyAYo8F/uzSflJx58G7ETgh4VYmCN+
         mWeNpe7TzFpTCkE1bANGLLL03WGpNiqWcuXqciXAK6D6l1qlZPO15AiMeWsaL+OgPi0/
         gz6Qt2XlkIBWp2PhWH95n7Wex9ZrF2gi+GAsmNx4xxbboc7f6jKud648SnakIJMnD6bb
         czOkiy78FfE6CXYSOh/vDainNWU4wIrYP/BgO0lAqxy4xv6CS4CQKn01HvTS2qB/gTGM
         ngzQ==
X-Gm-Message-State: AOJu0Yw263o8oCMqdr5xQeCThmpHaj2u+9kPhLf/Nyh1ygy4B+DoHE7+
	bVWsHwfu8+m3umhLoyj4ou5Gq+1K93Byrfo67S+YOd9Y1hLHfkV7
X-Gm-Gg: ASbGncthaI0S1Fm9EdosyKJLDeaKjf6UhYHx2h2f8lAjttiRgpbwViM+NGRag8cDrD5
	pDerc30jHRQbDmKlB6bb/7rEf8xLQlMI9wUyDZ5LFqxGYM4RQzTBMn0vePHtbpzdu/71yImJaUl
	QfJlHB9KdRxIyGdRU83svTSIKjE11kMMi4Ch/3Utdb5hzNldErQ7hDyxqVZAGze+EOHAveAWkyF
	Y/1r6Ky2c8xxPu95Cpo16aSE6S9oL7bRtKLAUCC4/07ez3/wi76DKO64FOVOEKpSTnI5NkldAYX
	gpMcNOz4V7WdQsUaUq7iCE49Jv3eAWHWAAAYfmSavIHsfHU2Jg==
X-Google-Smtp-Source: AGHT+IGnQ3T53gmddcoGh5RFkXJnnQaNroa/ymWquGHeUzKjL+S9tt0g4lDVa+ieEBv8vYkOix4TYQ==
X-Received: by 2002:a17:902:f601:b0:21f:4144:a06f with SMTP id d9443c01a7336-220bbad659cmr21829265ad.13.1739326398628;
        Tue, 11 Feb 2025 18:13:18 -0800 (PST)
Received: from ritvikos.localdomain ([49.36.192.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f368b4bd6sm102457325ad.229.2025.02.11.18.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 18:13:17 -0800 (PST)
Received: by ritvikos.localdomain (Postfix, from userid 1000)
	id B184A1403AA; Wed, 12 Feb 2025 02:13:11 +0000 (UTC)
From: ritvikfoss@gmail.com
To: ioana.ciornei@nxp.com
Cc: netdev@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH net-next] Documentation: dpaa2 ethernet switch driver: Fix spelling
Date: Wed, 12 Feb 2025 02:13:11 +0000
Message-ID: <20250212021311.13257-1-ritvikfoss@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ritvik Gupta <ritvikfoss@gmail.com>

Corrected spelling mistake

Signed-off-by: Ritvik Gupta <ritvikfoss@gmail.com>
---
 .../device_drivers/ethernet/freescale/dpaa2/switch-driver.rst   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/device_drivers/ethernet/freescale/dpaa2/switch-driver.rst b/Documentation/networking/device_drivers/ethernet/freescale/dpaa2/switch-driver.rst
index 8bf411b857d4..5f3885e56f58 100644
--- a/Documentation/networking/device_drivers/ethernet/freescale/dpaa2/switch-driver.rst
+++ b/Documentation/networking/device_drivers/ethernet/freescale/dpaa2/switch-driver.rst
@@ -70,7 +70,7 @@ the DPSW object that it will probe:
 Besides the configuration of the actual DPSW object, the dpaa2-switch driver
 will need the following DPAA2 objects:
 
- * 1 DPMCP - A Management Command Portal object is needed for any interraction
+ * 1 DPMCP - A Management Command Portal object is needed for any interaction
    with the MC firmware.
 
  * 1 DPBP - A Buffer Pool is used for seeding buffers intended for the Rx path
-- 
2.43.0


