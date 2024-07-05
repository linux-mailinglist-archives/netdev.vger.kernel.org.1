Return-Path: <netdev+bounces-109448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 004329287EE
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 13:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D6F81F23BE2
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 11:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BED149DE4;
	Fri,  5 Jul 2024 11:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7nE/x0T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653CD149C70
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 11:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720178828; cv=none; b=ECrwW592hoPeMUiIw9YGCkkfsVvx2/0MJw8D3w6E41uas1phGOHmo+UIrG3Vg9TGyKq44COnxr05Z0mXy+178v6tGE7TEhPhbVDiN3LLh1lKNF5I7kCeG+vfAvcMfZdlUScBBUjwDTEN1+1x4oTYeRZqt4A4St+vWiTvU8zt4ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720178828; c=relaxed/simple;
	bh=yrBV5IftFpUXlj5MIMux76e/rLUFvmgMTRAmNwhBNoI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bfM5iNvwLb+OdAebzvLRX+BSzxrltlf1YQ0D2Ug6h0vmGmgTRnudNVaoLpvHnPt77AIk0Q6akS2CHz1NAc6wUPHK/H/mBTGUtlfq45Ykz/q5P93jTzh5Ksr06/4RUFywXGAeExuNXm4r7e4IXk1qUWuQz5jSjuIuLryka/QLd98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7nE/x0T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19D0C32781;
	Fri,  5 Jul 2024 11:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720178827;
	bh=yrBV5IftFpUXlj5MIMux76e/rLUFvmgMTRAmNwhBNoI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=D7nE/x0T/C+QisBajqr9Irh+NeIxuAd18OzXZ1XEB95o0gViRPX5se1yXytKCkR/v
	 nFVem7Sado/NIMcgRWCQ6jtSdVOGEstS3iPU6W5WAZyVyHZj44qdksEr0dY+KEtlJZ
	 Wp57udGBEUtX7kFB7i5/AM28XRgschlpiaHTcGnjRTuQ/52W1zY6GfaP6XI0dCV5xI
	 pxlF1nnZdvYk8DM+ezuYJ5weg3T2LU6NQauZ2NxAYTtkN1RGI/VtAYcOnHFOPRXIdF
	 Z3YPAY62ZBk26CUeIkTQxbhAWK8NTltP8WzdY3TRaJd9grs8JhqujiwrheRQPppQDp
	 lWLG9i9TMI7gQ==
From: Simon Horman <horms@kernel.org>
Date: Fri, 05 Jul 2024 12:26:48 +0100
Subject: [PATCH net-next 2/3] bnxt_en: check for irq name truncation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-bnxt-str-v1-2-bafc769ed89e@kernel.org>
References: <20240705-bnxt-str-v1-0-bafc769ed89e@kernel.org>
In-Reply-To: <20240705-bnxt-str-v1-0-bafc769ed89e@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Michael Chan <michael.chan@broadcom.com>, netdev@vger.kernel.org
X-Mailer: b4 0.12.3

Given the sizes of the buffers involved, it is theoretically
possible for irq names to be truncated. Detect this and
propagate an error if this occurs.

Flagged by gcc-14:

  .../bnxt.c: In function 'bnxt_setup_int_mode':
  .../bnxt.c:10584:48: warning: '%s' directive output may be truncated writing 4 bytes into a region of size between 2 and 17 [-Wformat-truncation=]
  10584 |         snprintf(bp->irq_tbl[0].name, len, "%s-%s-%d", bp->dev->name, "TxRx",
        |                                                ^~                     ~~~~~~
  In function 'bnxt_setup_inta',
      inlined from 'bnxt_setup_int_mode' at .../bnxt.c:10604:3:
  .../bnxt.c:10584:9: note: 'snprintf' output between 8 and 23 bytes into a destination of size 18
  10584 |         snprintf(bp->irq_tbl[0].name, len, "%s-%s-%d", bp->dev->name, "TxRx",
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  10585 |                  0);
        |                  ~~
  .../bnxt.c: In function 'bnxt_setup_int_mode':
  .../bnxt.c:10569:62: warning: '%s' directive output may be truncated writing between 2 and 4 bytes into a region of size between 2 and 17 [-Wformat-truncation=]
  10569 |                 snprintf(bp->irq_tbl[map_idx].name, len, "%s-%s-%d", dev->name,
        |                                                              ^~
  In function 'bnxt_setup_msix',
      inlined from 'bnxt_setup_int_mode' at .../bnxt.c:10602:3:
  .../bnxt.c:10569:58: note: directive argument in the range [-2147483643, 2147483646]
  10569 |                 snprintf(bp->irq_tbl[map_idx].name, len, "%s-%s-%d", dev->name,
        |                                                          ^~~~~~~~~~
  .../bnxt.c:10569:17: note: 'snprintf' output between 6 and 33 bytes into a destination of size 18
  10569 |                 snprintf(bp->irq_tbl[map_idx].name, len, "%s-%s-%d", dev->name,
        |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  10570 |                          attr, i);
        |                          ~~~~~~~~

Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 220d05e2f6fa..15e68c8e599d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10538,7 +10538,7 @@ static int bnxt_trim_rings(struct bnxt *bp, int *rx, int *tx, int max,
 	return __bnxt_trim_rings(bp, rx, tx, max, sh);
 }
 
-static void bnxt_setup_msix(struct bnxt *bp)
+static int bnxt_setup_msix(struct bnxt *bp)
 {
 	const int len = sizeof(bp->irq_tbl[0].name);
 	struct net_device *dev = bp->dev;
@@ -10558,6 +10558,7 @@ static void bnxt_setup_msix(struct bnxt *bp)
 	for (i = 0; i < bp->cp_nr_rings; i++) {
 		int map_idx = bnxt_cp_num_to_irq_num(bp, i);
 		char *attr;
+		int rc;
 
 		if (bp->flags & BNXT_FLAG_SHARED_RINGS)
 			attr = "TxRx";
@@ -10566,24 +10567,35 @@ static void bnxt_setup_msix(struct bnxt *bp)
 		else
 			attr = "tx";
 
-		snprintf(bp->irq_tbl[map_idx].name, len, "%s-%s-%d", dev->name,
-			 attr, i);
+		rc = snprintf(bp->irq_tbl[map_idx].name, len, "%s-%s-%d",
+			      dev->name, attr, i);
+		if (rc >= len)
+			return -E2BIG;
 		bp->irq_tbl[map_idx].handler = bnxt_msix;
 	}
+
+	return 0;
 }
 
-static void bnxt_setup_inta(struct bnxt *bp)
+static int bnxt_setup_inta(struct bnxt *bp)
 {
 	const int len = sizeof(bp->irq_tbl[0].name);
+	int rc;
+
 
 	if (bp->num_tc) {
 		netdev_reset_tc(bp->dev);
 		bp->num_tc = 0;
 	}
 
-	snprintf(bp->irq_tbl[0].name, len, "%s-%s-%d", bp->dev->name, "TxRx",
-		 0);
+	rc = snprintf(bp->irq_tbl[0].name, len, "%s-%s-%d", bp->dev->name,
+		      "TxRx", 0);
+	if (rc >= len)
+		return -E2BIG;
+
 	bp->irq_tbl[0].handler = bnxt_inta;
+
+	return 0;
 }
 
 static int bnxt_init_int_mode(struct bnxt *bp);
@@ -10599,9 +10611,11 @@ static int bnxt_setup_int_mode(struct bnxt *bp)
 	}
 
 	if (bp->flags & BNXT_FLAG_USING_MSIX)
-		bnxt_setup_msix(bp);
+		rc = bnxt_setup_msix(bp);
 	else
-		bnxt_setup_inta(bp);
+		rc = bnxt_setup_inta(bp);
+	if (rc)
+		return rc;
 
 	rc = bnxt_set_real_num_queues(bp);
 	return rc;

-- 
2.43.0


