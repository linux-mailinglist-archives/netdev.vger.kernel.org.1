Return-Path: <netdev+bounces-136741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AC29A2D1C
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 21:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8182EB277F1
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 19:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCCD21D2DA;
	Thu, 17 Oct 2024 19:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZW3DxGG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EFF21C17C;
	Thu, 17 Oct 2024 19:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729191760; cv=none; b=TOZaoZ6bmSfKVFQUtL3e1uy0BWyQQbZi+EqdVQ34j4sbbK+1KiqKery6q9LDJqp4qc7UT1ZuF7F4EXjtUhb1cB0xXCUnI9lBKQ+dGIu5OnRH/W5LVaYMqiMylkMTtx+UbGCzWRLdujDkbNMB7vhYJi3jAcnmwvl89t5NvklH1F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729191760; c=relaxed/simple;
	bh=8Xm49cYq79t70wGbob1EFfMthRU3wGFZiDD8Zmuw+wY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ccYF+7VIlJps2xTzVB8H3eUok5RjF3TNRBZ8/XFBB6fkzMQ7huo3ngd8q66K8UojfcZD9pSEGpjtHMCWcmyrNCVT0BlnaVyr9G+5ir5E0/s0EbwHnQJ+CCpuj/TordvJuvsVrYjdv3qqYaZGyE79d5FMWcO7HvLzPcalcl8lWug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZW3DxGG; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20cdb889222so13984815ad.3;
        Thu, 17 Oct 2024 12:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729191758; x=1729796558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GC/gKkJk9hC2ZN6gsa1BgR5QAlv+EhRRSXqtQaRP8SI=;
        b=aZW3DxGGcKxXN5VQXcZ21BBYGPOiGoQYafnPyN7b4Yi+eXLrJl3VgNKhlCtgOEcizq
         X2iU3Yk758s8dePR7HgnLB5ZWVG0Ehjn1JMyovo1Uotg454Sg9SVWwSyw+zJhSSouXyW
         jRPkTIzKJVMHPw7l3LxiDk9SWqC1bMyW8lptpCnYnUNhbOClB2zxEEYgfPvaLtPNwqBq
         dHqHJMpsfnxhg9RI+gW+a+PHOSWkRvbUdrRBQjh7xf6Oj3V2AKnTAWYckAzk4Kl+bLTI
         AAKhQc+L5Y9/IfdsLXPc+tr9v+nkYddd2DNCwJ6yn6kAZl+ZTeGBp+Vs3XRRMkNfgL+F
         dt2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729191758; x=1729796558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GC/gKkJk9hC2ZN6gsa1BgR5QAlv+EhRRSXqtQaRP8SI=;
        b=ssS6C+UVSuGhGui0GGwXZRl1Lvhjq7pnEJS5U93B3XXEDL+zXiHXmAGMFNfV3WVp3H
         GJpPAY9/r8zMh7FPvsC/D5a2q3Y0GJ1+RbIL85uPFRMBzAJY7uyiBeXaRFXsDaZOEb0c
         YhE+ttE4zdz9dPtTrtIu8Pe+ib9MvxMxu2zKI9KAUPEdfj+luRC3Y+h7o6KWcvk/y35c
         I9FCiS+fJwfcQDxHkASo2wpgncczUHjjwhm7N5A0NMkx9EkPRxFrg2R0yPHJI5RF54FA
         FFYAunWOjjJM8DcqQst95IO51NTwfW569bl7l571DSDxKKLuF37N60rue4QjL+xa8oy8
         wBnA==
X-Forwarded-Encrypted: i=1; AJvYcCUFXGdk/abLJaEtH4Iq3GpBjnHzsGpNeiVhr44yoA7s5BarpkpSRkane6/Rj2ielldw95vH9Oeo@vger.kernel.org, AJvYcCXOzgfLCHJfnDGbPZjHhjFlah2QcPioA5hpt/zxDsEirEihVXONK+5RldFDAkqyKJWWdJGiTd2xjkJN5qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLGd6Ti6MX8amacpwpkvCo8YZWQcTD+2oT+qoTH1CDf1HSojCK
	vLK7Isqk1x6wOS9JH5lmFZRspWQQNepj4PxsyL20Y0273u+B4Eov
X-Google-Smtp-Source: AGHT+IFxY9RHtPWYtiLYxs1vE+ZHCnyS5DOSUEKiLiK3G1hM2Ct0AWcdyiyvq6jKcQ839l247tfxuw==
X-Received: by 2002:a17:903:120a:b0:205:3e6d:9949 with SMTP id d9443c01a7336-20ca16be7demr326442175ad.52.1729191757703;
        Thu, 17 Oct 2024 12:02:37 -0700 (PDT)
Received: from ubuntu.worldlink.com.np ([27.34.65.170])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e55da3bc5esm206054a91.39.2024.10.17.12.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 12:02:37 -0700 (PDT)
From: Dipendra Khadka <kdipendra88@gmail.com>
To: Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Dipendra Khadka <kdipendra88@gmail.com>,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/6] octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_ethtool.c
Date: Thu, 17 Oct 2024 19:02:29 +0000
Message-ID: <20241017190230.32674-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241017185116.32491-1-kdipendra88@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add error pointer check after calling otx2_mbox_get_rsp().

Fixes: 75f36270990c ("octeontx2-pf: Support to enable/disable pause frames via ethtool")
Fixes: d0cf9503e908 ("octeontx2-pf: ethtool fec mode support")
Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
v4: 
 - Sent for patch version consistenct.
v3: https://lore.kernel.org/all/20241006164210.1961-1-kdipendra88@gmail.com/
 - Included in the patch set
 - Changed the patch subject
 - Added Fixes: tag
v2: Skipped for consitency in the patch set
v1: https://lore.kernel.org/all/20240923113135.4366-1-kdipendra88@gmail.com/
 .../net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c  | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index 32468c663605..5197ce816581 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -343,6 +343,11 @@ static void otx2_get_pauseparam(struct net_device *netdev,
 	if (!otx2_sync_mbox_msg(&pfvf->mbox)) {
 		rsp = (struct cgx_pause_frm_cfg *)
 		       otx2_mbox_get_rsp(&pfvf->mbox.mbox, 0, &req->hdr);
+		if (IS_ERR(rsp)) {
+			mutex_unlock(&pfvf->mbox.lock);
+			return;
+		}
+
 		pause->rx_pause = rsp->rx_pause;
 		pause->tx_pause = rsp->tx_pause;
 	}
@@ -1072,6 +1077,11 @@ static int otx2_set_fecparam(struct net_device *netdev,
 
 	rsp = (struct fec_mode *)otx2_mbox_get_rsp(&pfvf->mbox.mbox,
 						   0, &req->hdr);
+	if (IS_ERR(rsp)) {
+		err = PTR_ERR(rsp);
+		goto end;
+	}
+
 	if (rsp->fec >= 0)
 		pfvf->linfo.fec = rsp->fec;
 	else
-- 
2.43.0


