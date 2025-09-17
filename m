Return-Path: <netdev+bounces-223878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF98B7F794
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FEDD4881B5
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 07:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668732EAD0F;
	Wed, 17 Sep 2025 07:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malat-biz.20230601.gappssmtp.com header.i=@malat-biz.20230601.gappssmtp.com header.b="Tn3xO+zE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3AA27B327
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 07:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758093208; cv=none; b=uRmZcw8GeiO3HTrTU3akf4c5pXo9J9MCyHOfKKF4kPpBmLzyDjseVom7Vf12RB1NcOBOjm74Lxn5sLIfz85ZEBjD9DWQYpa1yT3drt92YtGMR+tjKudOSvAIGZmwH1Rxk0hcc6TRQQ3pAxEQ7Qu4BBGqexQvZ0N6Czmg6F5prBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758093208; c=relaxed/simple;
	bh=bUmCTb9jkGVVCvC/nOWrqBV9kwtDCMrxp4/c7tccdUA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FrMX7yQ9rtjOeb/GmWLOtRPray8DqzzWm0bvXzmOjD6Tqd1M5MEba2VuwEOjKLdA/y7GsFmgl/VBF5qjN13/evVd1yVKoF78sVa73uYYn9pj7RMNDsyrWY3lpG5GVvuRsuXuhPRftQ6Uhyp5TRhxHkx5QiPgJqsbt/suz4/BCPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=malat.biz; spf=none smtp.mailfrom=malat.biz; dkim=pass (2048-bit key) header.d=malat-biz.20230601.gappssmtp.com header.i=@malat-biz.20230601.gappssmtp.com header.b=Tn3xO+zE; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=malat.biz
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=malat.biz
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45dd5e24d16so59709475e9.3
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 00:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20230601.gappssmtp.com; s=20230601; t=1758093203; x=1758698003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ABVLiwcXV5PMjRvO+SuQAWut/4KQWIcA7lTzLyvH5OA=;
        b=Tn3xO+zEnjJucTrKtT72DemJLBUagoI4bXbTWPWi1RTbfM3emqb5OGGZOza8I1645G
         oP8bJFzjk1QzJaFPt8fp+XST3ik3w4Ejnj6K7kheppzWH9Bcjnk/5Tg4LfSUVjRvYnez
         tI99vOYj2AbD9Rhb0ypR5WwgOi5peNCSRzbJn0A3dO4aKo9ubU1pNOteIbJlUAAsKyrb
         4a3si558aS/x8+bXs3Phs477pwDMDF+Dr5RTtctsaWRljSf1TnaNqvGcQKrAPQzm6pXm
         M2n3DRbYHurK5L/ucVV02taguf7IkNS982vdhBBZzjxI12qe0xw/pUvWlZensmFl1mgJ
         P8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758093203; x=1758698003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ABVLiwcXV5PMjRvO+SuQAWut/4KQWIcA7lTzLyvH5OA=;
        b=O1I+KIxYJeBMr9DG0XJS3j9i1iZ1DCopyO/IkIlL7dBmtMRbZHHQNEeaMFLZNTl6zM
         b/Alx3w6Y4tXEOQVMc+tfLjeLVLstCP5GcKrXC+YBLcLsWHUlNYRpSBDCgGg7HlJm80L
         Nxt+IMY+uEzWQ5HY/7lKeKbdda/gbd3eSO3s3Y0GBOTudQZGvf3OdaYg1MMU6yJTOYSb
         3SNeeJHq/Iu4vA8cIzVZT3YjAfyfFnVSjLJxuPSz35mKa0D02oolnQaz6ZDAtOYrb2CK
         zgI3Hm88VWLgXTem5epbY5cM3ny0mfsHfs2AjwjGX+NEJrEZnUjQDB3L2GK5z1aBUzag
         C4ug==
X-Gm-Message-State: AOJu0YwO/QEazQ9v7ftBj9BLxrPN2WhAU13JCSVKv1Nqn9i2wxkIvnCN
	YWHvBDaWfaCWKmx83UpZHTM0Wo6gYGvaefrTT9cVvW51us8/XBcAWAKU/HZMm7EeNvdMtNfnJ+Z
	37DeNQA==
X-Gm-Gg: ASbGncvPbunEMteM1oWZp3WP6bqihI2hUPRfGw3/K9EkI0Ux0MZHxIgpSC9WtiRj49l
	qm8eDfINf/FIhr4rY3RKMASI7bFjt2649jF36DTHMgKD2+/kjzsDY4IhCtDu7CBgBncs0rEmGnY
	9mNyEki/l/ozOaMO+xw4iM2BSwHWLI6WSn50SC8AxMCpcq8qNjuaAixc1w6/QF6WdLz4hzFHNOg
	YzP1oQ5q3yUth4QY9sbMWyyP9QDda9nJ0BX/DgTOhX01LsHkyuCpQqo6hTUcxPX5E1SIpCu3P+8
	8NsWNE3pc1c4fKUfN8NzSwvDiJdY6n5RDAZgfRieV91nATOT5lhIzLA988zs8p2lz5aHC7pqwOl
	PMgCUGt0ygGI3mZaQ8ovE4v0c
X-Google-Smtp-Source: AGHT+IGDWjnay3JILWMQOopOj+q2n0DeNQNBc4uLGFp45zDsDjPITixBaZh5gHRaF0cSj0VuKEBk1w==
X-Received: by 2002:a05:600c:3150:b0:45f:28ba:e17f with SMTP id 5b1f17b1804b1-462072dc871mr9439625e9.31.1758093202627;
        Wed, 17 Sep 2025 00:13:22 -0700 (PDT)
Received: from ntb.emea.nsn-net.net ([193.86.118.65])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45f321032a1sm36380025e9.2.2025.09.17.00.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 00:13:22 -0700 (PDT)
From: Petr Malat <oss@malat.biz>
To: netdev@vger.kernel.org
Cc: sgoutham@marvell.com,
	lcherian@marvell.com,
	gakula@marvell.com,
	jerinj@marvell.com,
	sbhatta@marvell.com,
	Petr Malat <oss@malat.biz>
Subject: [PATCH] ethernet: rvu-af: Remove slash from the driver name
Date: Wed, 17 Sep 2025 09:12:30 +0200
Message-Id: <20250917071229.1742013-1-oss@malat.biz>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Having a slash in the driver name leads to EIO being returned while
reading /sys/module/rvu_af/drivers content.

Remove DRV_STRING as it's not used anywhere.

Signed-off-by: Petr Malat <oss@malat.biz>
---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 0c46ba8a5adc..69324ae09397 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -21,8 +21,7 @@
 #include "rvu.h"
 #include "lmac_common.h"
 
-#define DRV_NAME	"Marvell-CGX/RPM"
-#define DRV_STRING      "Marvell CGX/RPM Driver"
+#define DRV_NAME	"Marvell-CGX-RPM"
 
 #define CGX_RX_STAT_GLOBAL_INDEX	9
 
-- 
2.39.5


