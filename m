Return-Path: <netdev+bounces-109447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BE19287ED
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 13:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8BD5B21713
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 11:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A17F149C4B;
	Fri,  5 Jul 2024 11:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITt+bPGu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F7B149DE4
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 11:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720178826; cv=none; b=RskEmeqLXKw8LbeQzd8dzuTRnURfdIgosmDSr9DznS42SXfVecQukFmDzJtHJ5c9ZK4qdyMNZfyUpjeIxtW5SoptpYoRMR3UFlKJBey30drEitvoAMu2GIqnSV3HzXIBCBl1w+DBONGxeh23HEQVQf93FgkWZ0gMnv4Uz/dcsOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720178826; c=relaxed/simple;
	bh=/iqhISmyjp10Y9gZXJqXSHFekdzGto3I0yZH76KXFPw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l18C7Fx3Tcj+1b5rFAfzJ/b+fHz6Iqoi0F/39eY3Lv4AA/86vUpEppNbnmypXjJfDZ3uucO5gZtPm99NpOosSw5PTR7iNsTXLATjt2DCiYs8qhVyfYBAvIPkTXR2RmszAFvi+6mWnRxknxNkkc3qGWYZY+iQNadMZ8NgD3N2gpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITt+bPGu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213C5C32781;
	Fri,  5 Jul 2024 11:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720178826;
	bh=/iqhISmyjp10Y9gZXJqXSHFekdzGto3I0yZH76KXFPw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ITt+bPGujL39bzyL+8MC5J48OI+puhMSJeRgObQImIADNNaAu/StWrx2phhDEVAVb
	 9oHPEKuJxyQBo75mjMr81g1iyEcY3mn1bxr3Rk3YfBwowuhb8Uy3XiRIVYK589gbPl
	 ZtYi8aKfNbsRu4Y6riGrO5OosUnM78QZx4AThfMc/C6urxTqhJLY9D/aiKGE77cJDD
	 +X1ZPMC0efhjjfFjjqS8V+gb/UrSPLfQAN7zBiBQrYuFzcXSG71cbuQmOTFsJEe/ZA
	 uOO4cBifihf+lZhk2twficp/zKlweaTrmHj/BRSG024WmQ9bP/gtXTPZrQ+RZKdnG+
	 hmLCz+3xnWFVg==
From: Simon Horman <horms@kernel.org>
Date: Fri, 05 Jul 2024 12:26:47 +0100
Subject: [PATCH net-next 1/3] bnxt_en: check for fw_ver_str truncation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-bnxt-str-v1-1-bafc769ed89e@kernel.org>
References: <20240705-bnxt-str-v1-0-bafc769ed89e@kernel.org>
In-Reply-To: <20240705-bnxt-str-v1-0-bafc769ed89e@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Michael Chan <michael.chan@broadcom.com>, netdev@vger.kernel.org
X-Mailer: b4 0.12.3

Given the sizes of the buffers involved, it is theoretically
possible for fw_ver_str to be truncated. Detect this and
stop ethtool initialisation if this occurs.

Flagged by gcc-14:

  .../bnxt_ethtool.c: In function 'bnxt_ethtool_init':
  drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c:4144:32: warning: '%s' directive output may be truncated writing up to 31 bytes into a region of size 26 [-Wformat-truncation=]
   4144 |                          "/pkg %s", buf);
        |                                ^~   ~~~
  In function 'bnxt_get_pkgver',
      inlined from 'bnxt_ethtool_init' at .../bnxt_ethtool.c:5056:3:
  .../bnxt_ethtool.c:4143:17: note: 'snprintf' output between 6 and 37 bytes into a destination of size 31
   4143 |                 snprintf(bp->fw_ver_str + len, FW_VER_STR_LEN - len - 1,
        |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   4144 |                          "/pkg %s", buf);
        |                          ~~~~~~~~~~~~~~~

Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
---
It appears to me that size is underestimated by 1 byte -
it should be FW_VER_STR_LEN - offset rather than FW_VER_STR_LEN - offset - 1,
because the size argument to snprintf should include the space for the
trailing '\0'. But I have not changed that as it is separate from
the issue this patch addresses.
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index bf157f6cc042..5ccc3cc4ba7d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -4132,17 +4132,23 @@ int bnxt_get_pkginfo(struct net_device *dev, char *ver, int size)
 	return rc;
 }
 
-static void bnxt_get_pkgver(struct net_device *dev)
+static int bnxt_get_pkgver(struct net_device *dev)
 {
 	struct bnxt *bp = netdev_priv(dev);
 	char buf[FW_VER_STR_LEN];
-	int len;
 
 	if (!bnxt_get_pkginfo(dev, buf, sizeof(buf))) {
-		len = strlen(bp->fw_ver_str);
-		snprintf(bp->fw_ver_str + len, FW_VER_STR_LEN - len - 1,
-			 "/pkg %s", buf);
+		int offset, size, rc;
+
+		offset = strlen(bp->fw_ver_str);
+		size = FW_VER_STR_LEN - offset - 1;
+
+		rc = snprintf(bp->fw_ver_str + offset, size, "/pkg %s", buf);
+		if (rc >= size)
+			return -E2BIG;
 	}
+
+	return 0;
 }
 
 static int bnxt_get_eeprom(struct net_device *dev,
@@ -5052,8 +5058,11 @@ void bnxt_ethtool_init(struct bnxt *bp)
 	struct net_device *dev = bp->dev;
 	int i, rc;
 
-	if (!(bp->fw_cap & BNXT_FW_CAP_PKG_VER))
-		bnxt_get_pkgver(dev);
+	if (!(bp->fw_cap & BNXT_FW_CAP_PKG_VER)) {
+		rc = bnxt_get_pkgver(dev);
+		if (rc)
+			return;
+	}
 
 	bp->num_tests = 0;
 	if (bp->hwrm_spec_code < 0x10704 || !BNXT_PF(bp))

-- 
2.43.0


