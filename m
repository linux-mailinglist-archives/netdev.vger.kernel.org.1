Return-Path: <netdev+bounces-147661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 866069DAF46
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 23:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 548CB281FD7
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 22:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B82204085;
	Wed, 27 Nov 2024 22:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="cu6AFBcC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8DC202F98
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 22:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732747144; cv=none; b=SioZzV/oImzuLJzVPWl8wFEyUBurVIkQRNFdJJG9rYJFYQp/tTmcE4ROUR9K3kwW0XVlBfYC1oQNy322Taf3/Xc/yPeIb/BxI3/EJRP/+J8mmQxCcmc4qD8CUAQB3LJRdJJaL7zvAETW3LDGteaEvQ5bA1VIx5fvFnoePYyuss0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732747144; c=relaxed/simple;
	bh=pjU3PzSQG8nIEwSuwmX+wD/Ujw1NoMm4te2TB9IyQVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GxaxbHAGyPq/BuV3z85Rw8emrdbobNWlyGH0rbHI7/Ny6Iqw3x3dZaCTfv4tltzNzl6Sb4LCgYb0jJmVWLZ7Za3OxleGLuHDPCySG8UddiqF8SknYgAqT4CjET0q28KI9hgRRquP5FxAd1ak4CIjBv23D6jRcH0IqWy4pocKp2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=cu6AFBcC; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2eb1433958dso184075a91.2
        for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 14:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1732747142; x=1733351942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ooy7CJvq9SUyTVj3GUhLBN54umo1bJHs8huQT2HeNzE=;
        b=cu6AFBcCSIzWJQquzvk7VHUh5GSBbTkh7GoEnK7V5SWYXSXNlIMniypx++3CVGovxk
         0yOikWeYc7ibToBcbT+lFuHjQWjyjla3jaNnBCd5F+I1zaHEYJ1aPMUYttSRx1Tbs4MC
         1enyeX4PzhHRAutY7gRnvpNX6ubQpORDh0kLYsqMayM0h3j9BilJ+nQSAo1Qjbxc5heR
         /zVNqQnfNlN1VZYlWyLwRWjwdeJ20+VmcIKwmus7vr28640bTB/o3nrwBbg5Fa1cmgmG
         XALmgS9tekGa9ZOh7vJfvzso4srGS70Da8zgJ5KzrfN3hYRrO44EC5spsNMX2//mrmiA
         ryjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732747142; x=1733351942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ooy7CJvq9SUyTVj3GUhLBN54umo1bJHs8huQT2HeNzE=;
        b=HvPi1id74B9m/x+qsGYvTKGu82o9Wbojx3iCksA9jYscL/whCZeeF7P5kUiwy7/7Bb
         r5pAjrAatQDp+0Iz6V9Zn8RlnoIcsyE2j6/HpZpqr5tydRH8KqPmx6vkPsrZQWCfTosI
         SUYC1MO0rvuFfuieF8+4gTL56gMjU7yJjkcLF4EYNTP0iJGLRg4T0hcd84jhCQU6Gojt
         CymZ/jLsbvTlVVaFqYX1LPVXTq23YXNmTUb8mYijWHUAoqpNzG0MrbkVfdFgpPdg2PLJ
         KNFIPFihkyCrcC5dB3oU69pMtYR4683bKyTsYcBFIptve1QZh+Z74FCIsWyGvseRdmD5
         r/Nw==
X-Gm-Message-State: AOJu0YwHXZHMQkDvIF5uhMtnXJpn9cA4mW//IrAOR3cRRPYqC9MLluhZ
	ZpCwqijThDidBHEVDPs7M4+FE3IDiJT36+hTftNUeMWIFDjbGnpRXaRFRSEbaOTEfwoQf8dwJTm
	t
X-Gm-Gg: ASbGnctLRZprskULKQzrrPBHbtNl85zDP1IpQbrOWkLH0tIacPsOWpdRdZtuMGWQgBv
	Mby6ewCr7nsFBOkJ6UyV61PP245f7q29NpLi/MoqCeX5SM+97OR6V7vF1lG1DIvNUpbpD4Dg/sP
	9vFmCXZFyrF+9sbJQ3jnhFYTmZ4JEbwe3f0xJ9tuaTo3vL9Ww3bvIB3V8kns8Cje3JIC3LqplkL
	+ouePTHg/72YN6wGc6+SBVA/QpgEWJcgxY=
X-Google-Smtp-Source: AGHT+IFouv7JPHxLtFkVEFE1s2C6cXLdVibe09YBXKYyn5ZbX1uaPaTejYgXCKAh8eglhGGGusTdMA==
X-Received: by 2002:a17:90b:2d0d:b0:2ea:7570:af24 with SMTP id 98e67ed59e1d1-2ee097c46bamr5946614a91.26.1732747142237;
        Wed, 27 Nov 2024 14:39:02 -0800 (PST)
Received: from localhost ([2a03:2880:ff:24::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee2b2a2dd0sm106202a91.33.2024.11.27.14.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 14:39:01 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>
Subject: [PATCH net v2 2/3] bnxt_en: refactor bnxt_alloc_rx_rings() to call bnxt_alloc_rx_agg_bmap()
Date: Wed, 27 Nov 2024 14:38:54 -0800
Message-ID: <20241127223855.3496785-3-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241127223855.3496785-1-dw@davidwei.uk>
References: <20241127223855.3496785-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor bnxt_alloc_rx_rings() to call bnxt_alloc_rx_agg_bmap() for
allocating rx_agg_bmap.

Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 36 ++++++++++-------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 38783d125d55..9b079bce1423 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3764,6 +3764,19 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 	return PTR_ERR(pool);
 }
 
+static int bnxt_alloc_rx_agg_bmap(struct bnxt *bp, struct bnxt_rx_ring_info *rxr)
+{
+	u16 mem_size;
+
+	rxr->rx_agg_bmap_size = bp->rx_agg_ring_mask + 1;
+	mem_size = rxr->rx_agg_bmap_size / 8;
+	rxr->rx_agg_bmap = kzalloc(mem_size, GFP_KERNEL);
+	if (!rxr->rx_agg_bmap)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static int bnxt_alloc_rx_rings(struct bnxt *bp)
 {
 	int numa_node = dev_to_node(&bp->pdev->dev);
@@ -3808,19 +3821,15 @@ static int bnxt_alloc_rx_rings(struct bnxt *bp)
 
 		ring->grp_idx = i;
 		if (agg_rings) {
-			u16 mem_size;
-
 			ring = &rxr->rx_agg_ring_struct;
 			rc = bnxt_alloc_ring(bp, &ring->ring_mem);
 			if (rc)
 				return rc;
 
 			ring->grp_idx = i;
-			rxr->rx_agg_bmap_size = bp->rx_agg_ring_mask + 1;
-			mem_size = rxr->rx_agg_bmap_size / 8;
-			rxr->rx_agg_bmap = kzalloc(mem_size, GFP_KERNEL);
-			if (!rxr->rx_agg_bmap)
-				return -ENOMEM;
+			rc = bnxt_alloc_rx_agg_bmap(bp, rxr);
+			if (rc)
+				return rc;
 		}
 	}
 	if (bp->flags & BNXT_FLAG_TPA)
@@ -15325,19 +15334,6 @@ static const struct netdev_stat_ops bnxt_stat_ops = {
 	.get_base_stats		= bnxt_get_base_stats,
 };
 
-static int bnxt_alloc_rx_agg_bmap(struct bnxt *bp, struct bnxt_rx_ring_info *rxr)
-{
-	u16 mem_size;
-
-	rxr->rx_agg_bmap_size = bp->rx_agg_ring_mask + 1;
-	mem_size = rxr->rx_agg_bmap_size / 8;
-	rxr->rx_agg_bmap = kzalloc(mem_size, GFP_KERNEL);
-	if (!rxr->rx_agg_bmap)
-		return -ENOMEM;
-
-	return 0;
-}
-
 static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
 {
 	struct bnxt_rx_ring_info *rxr, *clone;
-- 
2.43.5


