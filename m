Return-Path: <netdev+bounces-165752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 749C5A33471
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 02:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BC823A85DC
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 01:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DE686349;
	Thu, 13 Feb 2025 01:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="h6xR1/3t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2259781AC8
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 01:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739409215; cv=none; b=FzR7egoAZ2T6S7+qjScw0DJrovI5KOadUQ4PBb+zF7KgC2ayne7RWBe9C4G6kWqr2AcFG2RlgC+5BchGLxZtS1bBAKWMhtPy/eVdbDbummPB2EfVeAHdTDr9xii0hC2Tk/WLdHR3zmkEsZQ8xgOchddF7bNPBiwSrimPjPNhRjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739409215; c=relaxed/simple;
	bh=3Wv6fRui6JUppkVHVPDhuyoEourXEdFIz2Ar68Mhcgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mefaDLiAJhyWQM7E7ghm5bNISN4/QZGGLZ4BNNDeEFLnj587UEI00h490rGahGa0MB5Tu3YDoZAGxFK8IfBsvFqVoSuMQV/XgPPe7uDb87iyQh6DhCKimuo2MAjH7vNzHEiSjga5pxaDr+8wubOHptb1iWr3MZexKpxVEzDTwAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=h6xR1/3t; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-726ed359c56so318513a34.3
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 17:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739409213; x=1740014013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYbE7VuTl9BMV8ls+ftV23iDp1ujBGiTUNoHs2AfpuI=;
        b=h6xR1/3t6N66dwTLwLGvzi5TDsV0DqDmjh3gJp/Jjm5Dnech4O9rCh85/aQrsqd4F1
         vsre7b/JmQbRqv5PRdyjH+6sR1A1gO9cZPDMFQ4e1A5+8ehfLM7LIthHU+TpbQG01FD+
         J4aKrfHnvZDrPgpkUjrcdLjX24VPaQO8S+ot8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739409213; x=1740014013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYbE7VuTl9BMV8ls+ftV23iDp1ujBGiTUNoHs2AfpuI=;
        b=Lsrd+pYMQzm2qIReIkF8av5M2ERY3FOKZ62TVHOCxvrs7noV214vsrSOgbl6BecynD
         rtBjNrI3AAWPia5PtC0Uv6Br6LW+f+uHPbD35vgmY2aTDp8L+6WfC2Lfcvlgyi49skZG
         q1WMoDh1JTpy8h1/v6AKHTNELfXYkz0Bd0juqrqK46HNymaoYecO4LrEqtqW14DZs5Sv
         WX55pWrIHo4MpEJYAJ1jBfbTbwZUPVt07ixoT4goIpVOSIMlbSs+/dg76wpLMsU7mIBA
         YTc7q0SgLNhIf65R2nzN5Mu2MjNGDHQf2CrCCuUzVErm8oVqOEBW5S0+WjN6clRFoACx
         SkNw==
X-Gm-Message-State: AOJu0Yzb4SEtskt6v4n+2xUs25mtdx05eYZxIPs1wjG1+WnHinSsQQO+
	Zw0aW8craLrkt5jFvwIFzOR/AiBORXq4ys+Le7GkQBbKZd+GvfzrWHAH0x5KMw==
X-Gm-Gg: ASbGnct55nsII08vgMwJ3btJLz++zXIbEqm5Zom8nE5cZIVTexhYAV+OzG5hGsvcZqr
	F8jB/GDpviZ1RaOzK/x6ADT4EjHRBuFu7Ppbf50KqO6iR1L9EtmOvjuL1YIGnF3k2YyLA10xLrK
	Xq+QSQRQTzWPPKNAvqTiPjY7c1CBwyWEN/0uxJssqc+tIBlO2mwdcfNFeCWV5Xboq0kF1x9ar4n
	O5of2xmhTGSbpG/1xKPwFQdViS8R4lLemvOomJjpJfTPhUIPiMjEO7EqfEZRbKe9BVsK/YcEKSj
	QsABL3HmHWpKZz/RjyBL4rO+B3MjeBz/ejGJGu1Umip9ALNbBHQIz1I/yMmYpYGgeFA=
X-Google-Smtp-Source: AGHT+IH1X0NNE3pqbZwjNuV2aealYqQRH0pfK9uL7qenIbiPX003kYK+5F5tzCO/7XdOl4XScNL+Ag==
X-Received: by 2002:a05:6830:3148:b0:727:bf:e433 with SMTP id 46e09a7af769-72700bfe60cmr183967a34.19.1739409211762;
        Wed, 12 Feb 2025 17:13:31 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-727001cdb70sm195967a34.13.2025.02.12.17.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 17:13:30 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	michal.swiatkowski@linux.intel.com,
	helgaas@kernel.org,
	horms@kernel.org,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next v5 04/11] bnxt_en: Refactor completion ring free routine
Date: Wed, 12 Feb 2025 17:12:32 -0800
Message-ID: <20250213011240.1640031-5-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250213011240.1640031-1-michael.chan@broadcom.com>
References: <20250213011240.1640031-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Somnath Kotur <somnath.kotur@broadcom.com>

Add a wrapper routine to free L2 completion rings.  This will be
useful later in the series.

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 26 ++++++++++++++---------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 8ab7345acb0a..52d4dc222759 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7405,6 +7405,20 @@ static void bnxt_hwrm_rx_agg_ring_free(struct bnxt *bp,
 	bp->grp_info[grp_idx].agg_fw_ring_id = INVALID_HW_RING_ID;
 }
 
+static void bnxt_hwrm_cp_ring_free(struct bnxt *bp,
+				   struct bnxt_cp_ring_info *cpr)
+{
+	struct bnxt_ring_struct *ring;
+
+	ring = &cpr->cp_ring_struct;
+	if (ring->fw_ring_id == INVALID_HW_RING_ID)
+		return;
+
+	hwrm_ring_free_send_msg(bp, ring, RING_FREE_REQ_RING_TYPE_L2_CMPL,
+				INVALID_HW_RING_ID);
+	ring->fw_ring_id = INVALID_HW_RING_ID;
+}
+
 static void bnxt_hwrm_ring_free(struct bnxt *bp, bool close_path)
 {
 	u32 type;
@@ -7450,17 +7464,9 @@ static void bnxt_hwrm_ring_free(struct bnxt *bp, bool close_path)
 		struct bnxt_ring_struct *ring;
 		int j;
 
-		for (j = 0; j < cpr->cp_ring_count && cpr->cp_ring_arr; j++) {
-			struct bnxt_cp_ring_info *cpr2 = &cpr->cp_ring_arr[j];
+		for (j = 0; j < cpr->cp_ring_count && cpr->cp_ring_arr; j++)
+			bnxt_hwrm_cp_ring_free(bp, &cpr->cp_ring_arr[j]);
 
-			ring = &cpr2->cp_ring_struct;
-			if (ring->fw_ring_id == INVALID_HW_RING_ID)
-				continue;
-			hwrm_ring_free_send_msg(bp, ring,
-						RING_FREE_REQ_RING_TYPE_L2_CMPL,
-						INVALID_HW_RING_ID);
-			ring->fw_ring_id = INVALID_HW_RING_ID;
-		}
 		ring = &cpr->cp_ring_struct;
 		if (ring->fw_ring_id != INVALID_HW_RING_ID) {
 			hwrm_ring_free_send_msg(bp, ring, type,
-- 
2.30.1


