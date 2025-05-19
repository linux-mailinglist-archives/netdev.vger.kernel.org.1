Return-Path: <netdev+bounces-191636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC71ABC893
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 22:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 354201B655B6
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 20:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890AA21A444;
	Mon, 19 May 2025 20:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Y47gV97N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF202192FA
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 20:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747687412; cv=none; b=L3EPHK5RkOki6c8qrKL6IsyPJSYB2e9okAQ0eWKL+Z2WJ/ZOg4TZPKynF7xu6IzdY2RMGG5brQDRaVKRWPqMg2cmB7QHpL5VMkJaXanNsYX8yx3GxK858y/Cks1JUIUo24NzPKzGE/CXxZLnP/4YEcPu7Eo+VC+s4BMsO/jJD8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747687412; c=relaxed/simple;
	bh=UAy176ceq6WvBTCbjXLAAKi1cf5Jbnx087yGbzpwSkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=avaM+eIQE4klvTnJU/hvJRGdM8PO+8fe8L1SiQQfQ6lmfEzBzVdzphPNG9iJ1EoDvAVM69C9IKcqwMtEIJNyeyBletUjQoVxg0jcEW9zyyT6RS+iS29Um90jyXogGIsBVtIbtDChbD6exMidteI4i18cc/cJWNIEMhThFUZ0a94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Y47gV97N; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-74019695377so3822063b3a.3
        for <netdev@vger.kernel.org>; Mon, 19 May 2025 13:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1747687409; x=1748292209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUNIs4fBaGrg16qYhFNUrlkc+5r+0SkMuZ2iFKTO3t8=;
        b=Y47gV97N4cFRg/Ak9k1x7hV4BoU4whO/LGlpxrkaWDdhprHcW38kjkjZ8FAtzN/Paz
         6Ydipj2U3XmX7/PDY5FJzEQsNG4c9qYljAu1l3NXofb80sJV3ZhEwQEsiz7xDrMPn2KT
         uwzzrTavYY+1g/c6ELJq3CpTP2fQTT/dUFYog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747687409; x=1748292209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eUNIs4fBaGrg16qYhFNUrlkc+5r+0SkMuZ2iFKTO3t8=;
        b=fQX3r9Eo/BT0tsgkd9n6bR8BHoFxNQI9TPHO5VOsMwfz0STsUKC0rnoDR5awFvM+aI
         QFiYDJdq/0ewUvRZDsNbxa3cTa3GdApDPT4/9tCpbMBEBLc4n7mgqG9aZBKRUYgOpsRA
         wKFHGUkFr149EErDtTxvQb4olfH3SasRAGxT8/uv9hErs0cAaSISvCBEDWsA9N30+uqt
         wyNpUmJU+Vi1YIN5fv0Cjs2gzPx+ZNZbB4/fJ1lVZvYM4g9lJBBxtvhxDmEveFx8mvwL
         Sy8kLzDNh9u83zFODM7KSOxGwbZg0u7GMaymEIMMoqu+qVnLIMFdwdPKQNFH43/VuB7t
         qqDw==
X-Gm-Message-State: AOJu0YxovP/zVVCIaQvXxiKZgImYUChv1r45rqHB4kHXUu+z+lsi6heL
	fqMy4hmJNYBuGd6BHtW9SE52UCGF5IZdPO+EMeLqJqMTM/mU88cWo3s2jU1l3myN7w==
X-Gm-Gg: ASbGncum8soONxfBgFWvxVIXGEf5RAyGubHbIQM8dllmeYKFY/3WwhDBiUCAHqLiHaX
	su1RDvSEpAfsdl8fnwiQGVtM1VI+PcSzetI0R4pgxp4spLBao8a8QOgGsBIkGETbI0S9pGaNR9T
	Y/g9VRTS9vQp0ovKXhWkHeYFvlYEe0PyY9NC/0Uygii97X8FrNnRm3AYADh5tk/1gldFtjraJkT
	xyyJdK9Ws8s/O1WRCs76E44tP7CxCuSM/TzY7cCet4puIZ+TGuZZ63rtZ4PmM3SVGWaYBWFMTct
	AnyqxakqYtm75uMc1kEYYkk/oehotma3N/98qbxrJwlyyMQJ4nSWfIZTy0IWtcjJoeRds3+Ga3u
	MFMlCibKDvTwfr+qMpYqVXAExM7A=
X-Google-Smtp-Source: AGHT+IG5f94dACXiNiUjbjTRf5nPo04/QKRv6TYJrdz0TcBo+OeI3onq62xJKi5mMoELgIobJGNBGA==
X-Received: by 2002:a05:6a21:1807:b0:1f5:93b1:6a58 with SMTP id adf61e73a8af0-2162188b87emr22270994637.8.1747687409187;
        Mon, 19 May 2025 13:43:29 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4afe887sm64190955ad.88.2025.05.19.13.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 13:43:28 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	David Wei <dw@davidwei.uk>
Subject: [PATCH net 2/3] bnxt_en: Add a helper function to configure MRU and RSS
Date: Mon, 19 May 2025 13:41:29 -0700
Message-ID: <20250519204130.3097027-3-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250519204130.3097027-1-michael.chan@broadcom.com>
References: <20250519204130.3097027-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

Add a new helper function that will configure MRU and RSS table
of a VNIC. This will be useful when we configure both on a VNIC
when resetting an RX ring.  This function will be used again in
the next bug fix patch where we have to reconfigure VNICs for RSS
contexts.

Suggested-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
Cc: David Wei <dw@davidwei.uk>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 36 ++++++++++++++++-------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6afc2ab6fad2..a45c5ce81111 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10738,6 +10738,26 @@ void bnxt_del_one_rss_ctx(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx,
 	bp->num_rss_ctx--;
 }
 
+static int bnxt_set_vnic_mru_p5(struct bnxt *bp, struct bnxt_vnic_info *vnic,
+				u16 mru)
+{
+	int rc;
+
+	if (mru) {
+		rc = bnxt_hwrm_vnic_set_rss_p5(bp, vnic, true);
+		if (rc) {
+			netdev_err(bp->dev, "hwrm vnic %d set rss failure rc: %d\n",
+				   vnic->vnic_id, rc);
+			return rc;
+		}
+	}
+	vnic->mru = mru;
+	bnxt_hwrm_vnic_update(bp, vnic,
+			      VNIC_UPDATE_REQ_ENABLES_MRU_VALID);
+
+	return 0;
+}
+
 static void bnxt_hwrm_realloc_rss_ctx_vnic(struct bnxt *bp)
 {
 	bool set_tpa = !!(bp->flags & BNXT_FLAG_TPA);
@@ -15936,15 +15956,10 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 	for (i = 0; i < bp->nr_vnics; i++) {
 		vnic = &bp->vnic_info[i];
 
-		rc = bnxt_hwrm_vnic_set_rss_p5(bp, vnic, true);
-		if (rc) {
-			netdev_err(bp->dev, "hwrm vnic %d set rss failure rc: %d\n",
-				   vnic->vnic_id, rc);
+		rc = bnxt_set_vnic_mru_p5(bp, vnic,
+					  bp->dev->mtu + ETH_HLEN + VLAN_HLEN);
+		if (rc)
 			return rc;
-		}
-		vnic->mru = bp->dev->mtu + ETH_HLEN + VLAN_HLEN;
-		bnxt_hwrm_vnic_update(bp, vnic,
-				      VNIC_UPDATE_REQ_ENABLES_MRU_VALID);
 	}
 
 	return 0;
@@ -15969,9 +15984,8 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
 
 	for (i = 0; i < bp->nr_vnics; i++) {
 		vnic = &bp->vnic_info[i];
-		vnic->mru = 0;
-		bnxt_hwrm_vnic_update(bp, vnic,
-				      VNIC_UPDATE_REQ_ENABLES_MRU_VALID);
+
+		bnxt_set_vnic_mru_p5(bp, vnic, 0);
 	}
 	/* Make sure NAPI sees that the VNIC is disabled */
 	synchronize_net();
-- 
2.30.1


