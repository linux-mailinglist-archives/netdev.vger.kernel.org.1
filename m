Return-Path: <netdev+bounces-113800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF05D93FFDC
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 22:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E35881C22199
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 20:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDE918C335;
	Mon, 29 Jul 2024 20:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="sB3qcinS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A924C1891DE
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 20:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722286506; cv=none; b=CePKNXamhpWTuBSkH2M95Gyq2X67nnLAt0O//LNr6XTzdtgSqJ14JRkvTVk57Je35qe8+A+mwYtJS6rv9gsZSeAU1ihCUlrIJE8DoSX+c072IEyGUe/fifIdYBgArErffqhFXhH9uXeW5JMPA9VErVPe6tqxJiuQEdEjryJt+V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722286506; c=relaxed/simple;
	bh=FCi0ov896Gq6UxRxcVH2U6ITg7ZGTQ9dZPpfppkJFzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aNaeFTY5RcDPqvHrks20c7mr0Ew8ecygpZMPByY6i6WUtDZqv5sYvG9CQYs2QkJhn+11FQuV8GaDtGDF+Bco64wAJ9VP6NnPSpBTmiICqHaJKXozBCKCRNqD0yWFFew1PVVNKiIGUnvhzCVvpi7HeryBY4Vzx3+XtNmhjGP0eDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=sB3qcinS; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fec34f94abso24436265ad.2
        for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 13:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1722286504; x=1722891304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZo7mX1dOT2AZaScaQk0MSiUxisVz8yqlq1pvqUA8oM=;
        b=sB3qcinSa4kjmN7yCBwbT2SqxFQeh4bky6F1/rBdO4bc/GF64+p+T/RyzQNt7xpmAh
         drtl3azrNiqk8zsmQMZajHKo/Iwa+nONpJdbrJdIxdvspnCRiI6tTMteKPY5ic0mueyZ
         RI6nUHXX0DlLtFA64/ybFV5oOyTJF/xEsC/kUMx8IN529z4xNaGLAgOehg7UHduDWrt0
         c8vg4SsaWVl9/Kdz4cnISI6w3bIEA74ak4us0JuPHCpzOfxdEQXjAdJQgNn8s/xaAQVd
         aJBPeuQxpJrHKHeYPj6BvIB5IFjf/kAYSwiuFZSkJLJ4DQWESlDx7pfgGUYQwaOJxbz6
         mDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722286504; x=1722891304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZo7mX1dOT2AZaScaQk0MSiUxisVz8yqlq1pvqUA8oM=;
        b=tQyevL6aELKTA4l3ah4tSuf9gHvrxU0kxf4Jdl/KJXUx0nPspm8ocgcK/+5uxjhnVb
         ANaMg9OTWPz35pNLBaT3xKTwNQmsT/Z4WqYyQ2uKyrtbqRbhploxfeh+GyrCe5LctnFN
         2cYuc30RAgi28zc4nhmHQNm2y7vFQr2bJWYPL3B4RItkrsy03wgEQv4yKMhUDkZd1b+6
         90Uxlr6fV++t/N6n4y5PkZOcvjfBeSqZ/KPTpbU2pDoNj74HdpdcZwRh+L0+4wci9/Uj
         t/ziQXcgKABqGNCuLlpIKo3h172mq3B1IBQ/3BB6ZUOXvK9F4RxJacITxlawPWGyG64s
         +v0g==
X-Gm-Message-State: AOJu0YytKPhjSrrJbibk1dndcJ5bz2XW45rza2eSA+N5DpE11HBNXmHO
	6afQZ7hPVPi8yrVovLmp8HVvcEOwHfMK6BB0XJSqaMVFWbDRHIrILABY/tk7V2b7lwMh+MeoV3b
	TiIo=
X-Google-Smtp-Source: AGHT+IG61jKm5nkrp5+NMH1a4+M8YdK85bY9Hszpk4QColXgXz69B98aE2He+KcI7BJ35QD2/6zHJw==
X-Received: by 2002:a17:902:f792:b0:1fd:9420:104f with SMTP id d9443c01a7336-1ff0492d4e6mr79674275ad.53.1722286503765;
        Mon, 29 Jul 2024 13:55:03 -0700 (PDT)
Received: from localhost (fwdproxy-prn-021.fbsv.net. [2a03:2880:ff:15::face:b00c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee3f68sm87539345ad.171.2024.07.29.13.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 13:55:03 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Michael Chan <michael.chan@broadcom.com>
Subject: [PATCH net-next v1 2/3] bnxt_en: stop packet flow during bnxt_queue_stop/start
Date: Mon, 29 Jul 2024 13:54:58 -0700
Message-ID: <20240729205459.2583533-3-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729205459.2583533-1-dw@davidwei.uk>
References: <20240729205459.2583533-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calling napi_stop/start during bnxt_queue_stop/start isn't enough. The
current implementation when resetting a queue while packets are flowing
puts the queue into an inconsistent state.

There needs to be some synchronisation with the FW. Add calls to
bnxt_hwrm_vnic_update() to set the MRU for both the default and ntuple
vnic during queue start/stop. When the MRU is set to 0, flow is stopped.
Each Rx queue belongs to either the default or the ntuple vnic.

Co-Developed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 8822d7a17fbf..ce60c9322fe6 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -15172,7 +15172,8 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 	struct bnxt *bp = netdev_priv(dev);
 	struct bnxt_rx_ring_info *rxr, *clone;
 	struct bnxt_cp_ring_info *cpr;
-	int rc;
+	struct bnxt_vnic_info *vnic;
+	int i, rc;
 
 	rxr = &bp->rx_ring[idx];
 	clone = qmem;
@@ -15197,11 +15198,16 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 	if (bp->flags & BNXT_FLAG_AGG_RINGS)
 		bnxt_db_write(bp, &rxr->rx_agg_db, rxr->rx_agg_prod);
 
-	napi_enable(&rxr->bnapi->napi);
-
 	cpr = &rxr->bnapi->cp_ring;
 	cpr->sw_stats->rx.rx_resets++;
 
+	for (i = 0; i <= BNXT_VNIC_NTUPLE; i++) {
+		vnic = &bp->vnic_info[i];
+		vnic->mru = bp->dev->mtu + ETH_HLEN + VLAN_HLEN;
+		bnxt_hwrm_vnic_update(bp, vnic,
+				      VNIC_UPDATE_REQ_ENABLES_MRU_VALID);
+	}
+
 	return 0;
 
 err_free_hwrm_rx_ring:
@@ -15213,9 +15219,17 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
 {
 	struct bnxt *bp = netdev_priv(dev);
 	struct bnxt_rx_ring_info *rxr;
+	struct bnxt_vnic_info *vnic;
+	int i;
+
+	for (i = 0; i <= BNXT_VNIC_NTUPLE; i++) {
+		vnic = &bp->vnic_info[i];
+		vnic->mru = 0;
+		bnxt_hwrm_vnic_update(bp, vnic,
+				      VNIC_UPDATE_REQ_ENABLES_MRU_VALID);
+	}
 
 	rxr = &bp->rx_ring[idx];
-	napi_disable(&rxr->bnapi->napi);
 	bnxt_hwrm_rx_ring_free(bp, rxr, false);
 	bnxt_hwrm_rx_agg_ring_free(bp, rxr, false);
 	rxr->rx_next_cons = 0;
-- 
2.43.0


