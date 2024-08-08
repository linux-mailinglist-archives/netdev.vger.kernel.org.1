Return-Path: <netdev+bounces-116698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8CA94B623
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 07:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 925E61C22919
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 05:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB864146590;
	Thu,  8 Aug 2024 05:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="JXFUxPU7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771241448FA
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 05:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723094128; cv=none; b=JPeEU1xTFQqbu5IQObyT1chwctGqolpQVCma+8+MCX1/GYQxHeZHsHUS8aQYteo+w4ooR3qf6ivUuMMGAsVLnVQn9XeuX154dI3fsC5nCE2K85xYgsJxP32nz/i1CsB+sR/ozPTD9yMf2njJg0ooaixRtA+BZnP3d7SKcIKiJ2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723094128; c=relaxed/simple;
	bh=58teMBllqCJyAuhanMJB3sb9AqCAANAodhtiVpW1M+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BLqiGJvvA1CCtNj5SzaMddrk/Fhagzizlih8925BKKlOttGwfsufrMZpnBCT7UvFEkNJppRj57/rIVbalRI5+myFx+Bgg+Cy4Xcuw2F9dJtp2MDDYH+LtUqy+6KKuMw0hiu0yvsOej81NjzkpXyH3UPNovJEfJSsmtbr5y7dLug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=JXFUxPU7; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fec34f94abso5998765ad.2
        for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 22:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1723094127; x=1723698927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1j9XqDTgAn2eTjCCEpeOZJM6ut8ghoWPf0vOKXRiw+M=;
        b=JXFUxPU7QpP2x1uahvtELFd1HDGozXKZm/m69X/2W43Lbm0hxKP///Rx+f1BhaA66l
         exJndT/n6aSRE9Rp4y+WtshHMJ2CdScX33LTbN043rAY83SdQ+RIQa5FUBQKC4Xucql1
         WhpEgWLW7Idu/WX4bFc16HZBiyoWWsvHvERxMNy/8yMhIwU5tLW5WhmWj38AvtLnM+ld
         ZK076QVNyWuButa4aISbYF0XMlTM6c3ey3kpZEGHG8AtOkqwaNGr00AMJ4FDyP2YkDyS
         Rk9TMRIilL4LuNUADzLU6DpJ27+RH5b2DkT+CoDJxVYLQd2ygSPG+HJ7k4WoL+dk/pPS
         DsPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723094127; x=1723698927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1j9XqDTgAn2eTjCCEpeOZJM6ut8ghoWPf0vOKXRiw+M=;
        b=WeNij+c/2Mec8q/OFnh8GeKdKsh7ojoVgem5mGt3B8rvQl3f0zI8qLZY3I+5+qBfse
         oXa2vaTakM2hBtnD/d2bX3lpJi06zTrY2N66EII1dPY0ipr+cKpFVssDlUbHuzXNIaxG
         h2fJS+WU3/bqaOUkdzXVU4RCFMxQuWB7+OhQffJ18HjO14pJNGLb7MZfoweIc8ILir1Y
         mZnzah+u7PQi4PyeyoXIiSDVafS4RHs6oli1g/ILuZ0ob5AwfvflDJDpZuZKiHxdQg/U
         xsWPnIcYROHUkB4simmUfB6ArGznkgcFaUGVn7pp8eaxZD3m/YBXvlgdmCcpxXWt2loX
         9Pqg==
X-Gm-Message-State: AOJu0Yy++fP906jVTPKUG5E0c0o6GwDrKmKIhz4klha2xFiQVHxR/Auk
	CfQ1sIgnLyfpdt+rWSMQyYa/Wz4NE9O2AcLyHif7Om/CMl34cWPTKqJ4pTtpyz0YjIGYlS0sMzJ
	+
X-Google-Smtp-Source: AGHT+IEuwzKAfjQ3UAwaAsbg2SyrsThUvaCn2qmbYSASaAu8nhtNXGwR32Io7sALrxZIJ5rJ6n7xFw==
X-Received: by 2002:a17:902:eccf:b0:1fa:7e0:d69a with SMTP id d9443c01a7336-200952cdfdemr6839255ad.46.1723094126695;
        Wed, 07 Aug 2024 22:15:26 -0700 (PDT)
Received: from localhost (fwdproxy-prn-017.fbsv.net. [2a03:2880:ff:11::face:b00c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5927efe8sm114826215ad.224.2024.08.07.22.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 22:15:26 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	David Wei <dw@davidwei.uk>
Subject: [PATCH net-next v3 5/6] bnxt_en: stop packet flow during bnxt_queue_stop/start
Date: Wed,  7 Aug 2024 22:15:17 -0700
Message-ID: <20240808051518.3580248-6-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240808051518.3580248-1-dw@davidwei.uk>
References: <20240808051518.3580248-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation when resetting a queue while packets are
flowing puts the queue into an inconsistent state.

There needs to be some synchronisation with the FW. Add calls to
bnxt_hwrm_vnic_update() to set the MRU for both the default and ntuple
vnic during queue start/stop. When the MRU is set to 0, flow is stopped.
Each Rx queue belongs to either the default or the ntuple vnic.

With calling bnxt_hwrm_vnic_update() the calls to napi_enable() and
napi_disable() must be removed for reset to work on a queue that has
active traffic flowing e.g. iperf3.

Co-developed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index cfa4178a84a4..7762fa3b646a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -15176,7 +15176,8 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 	struct bnxt *bp = netdev_priv(dev);
 	struct bnxt_rx_ring_info *rxr, *clone;
 	struct bnxt_cp_ring_info *cpr;
-	int rc;
+	struct bnxt_vnic_info *vnic;
+	int i, rc;
 
 	rxr = &bp->rx_ring[idx];
 	clone = qmem;
@@ -15201,11 +15202,16 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
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
@@ -15217,9 +15223,17 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
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
2.43.5


