Return-Path: <netdev+bounces-173623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F1EA5A319
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 19:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 145B03B0837
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 18:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0879E236428;
	Mon, 10 Mar 2025 18:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GipNl7lw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFBF23AE67
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 18:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741631638; cv=none; b=VTznnHMV1TB+gN308CsF/yJSbQCLFBxL9XPoj9x048zUVJ9YtZu2CtfH0SJH/ytGwIMJzNOcYNrnLaemueFVzxjmvVrhPTPjKiZjglN0iJ1khPZjqd+myUCVqi5w7NxpXTTnopBKQ8+DYce+HGxvZX+wFa/NlM8tv1nCIHh/9HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741631638; c=relaxed/simple;
	bh=X4EmDIHKxCO1Tbgawu0l+i7aDrgAym5PvLKH3/pHB7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ey0VZmpHcOFcvV710Ok6Lz1luEt9YdRhTVm5s09tOywJ+lcB/IMGXKMbFe+WM14EIEd5hm0S29fNEa0z5sUklU6dZQJJ+GCJQTED8wqnjiH4u9hCE3Tl24/tSbT8nU5gis5W+AZUbbs74UEpB+tSVF+mtaliOcmYdREoKhCIQ5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GipNl7lw; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7271239d89fso1057222a34.0
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 11:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741631636; x=1742236436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/qyPLT7qupz3BVeiKpzkMthg4z1ljJw+9vJHQvjn5g=;
        b=GipNl7lwX4Anfn1X/0ALVsHRSl6FrC8IP1biZ5aLxGC+bnNkpuPksGOIv2J+cHTymO
         czT8UOKe+a/4VWmP+lAdKQJFZbMoTfJ5ocMP3HO2g2by3PX//+0Q70zYoZpMQ1QdrvXe
         WDD/Q7EbBWfKLZjYDmzOZcVFp9FOeX6RDIzB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741631636; x=1742236436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/qyPLT7qupz3BVeiKpzkMthg4z1ljJw+9vJHQvjn5g=;
        b=JSdr8SRSaELThw49Y1pBh9ZPprdAN2C+GnCnWekIpoPdcOufKyIhh6GZlGvjwda5pX
         94j1UnZQp4UVvJv3Mzs9VXIavHuV04njMJxTUdTVSfKUrlcsFNLeKGPHzkaWoG+2VLX0
         07BUVk3T1Fg2gvNZq4LIfuiOavfD/yGnTz9iFtt9nks8uq+pNVZkehlMF919E5/hwMS6
         0IHRp09rrohEaPPkqX42TtzY5j44l8EnvZbRFJyKwTzbXn6Machv3STH6L4a+AIjxA4U
         Owomt6Hi7XRUZ6WNmgzeOAetbjh/bOxJro5QMMij5I6RjhqWu0HdBfuXBb8OEjXWlk3l
         vWaA==
X-Gm-Message-State: AOJu0YzSf7XXbAQWdFajFS+/BVLZ1FWzRXgJRpkN/kebpm5WXQIwxRGD
	s+ZEyhamJVxOQzyPO7S0/M5uMgG4lUDF1QJTn49bkbMnJS1+DV/17Yo1BAyIuA==
X-Gm-Gg: ASbGncsPiqOrl/IxrAKuI7nEPibSoJoX0mTvkyUqA+shFB1RBmDaEugIo3OwaPT8AEh
	shsRMkBPQFepKoiMbmP95j20OHTt1tRlo210A8AakJQuuB8kYrN/zicL+TEIZtVduk7ADmlCAVO
	S4nrbZ/TgbQ+MKmx5iSf3RoOYNY/66dGdAUhsadvEo9hCuYVXfhIy0/01E3wpo09tAbx4n1CEcV
	zx65fw2mcP6KUa4yPQ2/nEEdmuApqHGnh7DNh7vACZsEYcJ5ZTp43Ber+dqj7gkA+HkZV1ExpBb
	z4klqBWzWEVCbakC3ptY3a6R1PTXDRYc7ofPLtG6HWmBY36GQ0lHNOI6+JhFa4Cy8a8zzBRJxLr
	x7GiAAcTNIwBo4oUBgKq4
X-Google-Smtp-Source: AGHT+IHd+F5NaoiAsDbsdt3YEJ6lHC5GcxutrYUHyPfeQ2m1cCBcXGwBafvT7Du/GRnoji96isIFAg==
X-Received: by 2002:a05:6808:244c:b0:3f6:7179:8777 with SMTP id 5614622812f47-3f697b69d28mr6395694b6e.18.1741631636195;
        Mon, 10 Mar 2025 11:33:56 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3fa33834905sm41814b6e.27.2025.03.10.11.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 11:33:55 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	shantiprasad shettar <shantiprasad.shettar@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net-next 4/7] bnxt_en: Query FW parameters when the CAPS_CHANGE bit is set
Date: Mon, 10 Mar 2025 11:31:26 -0700
Message-ID: <20250310183129.3154117-5-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250310183129.3154117-1-michael.chan@broadcom.com>
References: <20250310183129.3154117-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: shantiprasad shettar <shantiprasad.shettar@broadcom.com>

Newer FW can set the CAPS_CHANGE flag during ifup if some capabilities
or configurations have changed.  For example, the CoS queue
configurations may have changed.  Support this new flag by treating it
almost like FW reset.  The driver will essentially rediscover all
features and capabilities, reconfigure all backing store context memory,
reset everything to default, and reserve all resources.

Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: shantiprasad shettar <shantiprasad.shettar@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index b09171110ec4..49c95bbe2086 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -12300,6 +12300,7 @@ static int bnxt_hwrm_if_change(struct bnxt *bp, bool up)
 	struct hwrm_func_drv_if_change_input *req;
 	bool fw_reset = !bp->irq_tbl;
 	bool resc_reinit = false;
+	bool caps_change = false;
 	int rc, retry = 0;
 	u32 flags = 0;
 
@@ -12355,8 +12356,11 @@ static int bnxt_hwrm_if_change(struct bnxt *bp, bool up)
 		set_bit(BNXT_STATE_ABORT_ERR, &bp->state);
 		return -ENODEV;
 	}
-	if (resc_reinit || fw_reset) {
-		if (fw_reset) {
+	if (flags & FUNC_DRV_IF_CHANGE_RESP_FLAGS_CAPS_CHANGE)
+		caps_change = true;
+
+	if (resc_reinit || fw_reset || caps_change) {
+		if (fw_reset || caps_change) {
 			set_bit(BNXT_STATE_FW_RESET_DET, &bp->state);
 			if (!test_bit(BNXT_STATE_IN_FW_RESET, &bp->state))
 				bnxt_ulp_irq_stop(bp);
-- 
2.30.1


