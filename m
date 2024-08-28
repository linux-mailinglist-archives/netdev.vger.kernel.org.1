Return-Path: <netdev+bounces-122892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7622963013
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 20:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46256B2246B
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 18:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7781AB52F;
	Wed, 28 Aug 2024 18:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LlpEdqbw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351EC1AB51B
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 18:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724869990; cv=none; b=jaVDhzk15yGnE+KYIqd2R/gmNIfsebN0RyAzvI3F5T4QRtDZz9JPyc1XVsl7gAtMQMxYIsCc3j3EqbXdWzkNquyui06dXfIdPTZ9GxyEptxkkrpVdWQZzc6ryq0f0KT7p1BeSyKUTj2OozvDP/k9rd9xJOCl4o6TWfhfcC6AMpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724869990; c=relaxed/simple;
	bh=uVfYXnO7KEr4MbCNM2tPLz1fBzFWKDDMSgAG33nKbo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vDQrGD+MpglhPtKSBVK0FcEQOVWMBaxi0eBIizw0QRguQAJF81PwxaWCR+iaiY7mlA1xR/pj3cCZDSGJGftSwAEciXaDBSoDb5DQ+lAqrE5DQyhuNizxsgBn5O9nYNkSWiYDqDPgCozKxyVXyfDiMHje2MZutibLzWYQfLBiG5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LlpEdqbw; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6bf8b41b34dso36402106d6.0
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 11:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724869988; x=1725474788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSRkRd1bUOamWqoWx9cZCQwg3atj77uWWzgwowWKD7U=;
        b=LlpEdqbwbjhHdblMfjiFjvTw5RrmQB/hra0m+8EK0ubAyhH7t+LBsipcR2R94ouO2Q
         kxIhCcNEn/YXdpI1ccCjQdHg2eVemlxdNpWMsciQXZKFFKIZmqwJlzakFxbh3yczBQfA
         GHOBXdlTqtx8y2PliEQ6TFuBNcU3bfQn2lTTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724869988; x=1725474788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xSRkRd1bUOamWqoWx9cZCQwg3atj77uWWzgwowWKD7U=;
        b=jfZHpyr+R4wJGZNX+EIAQ5Qm/ncjswqJGgW0Tkkfa5Ky0h2HD+7e5WpOY/QwGPR+iL
         Uza0G0nZTWMFNkjC+Ct8+FXiMOu3Nv+UsdM+zKHFzpAnVXifS5D6oS4yniZ86eFi88Fi
         0zNhfBgcT10M6vlZ/oNlyOUolK6HH5O6jN9skWNpflGjehlC2tTVcQjBKPsaM/md4kpX
         9VmzefD5g8YcCghg2G+vGrJ7fgyxzkLZu6iUvko/LNVnMxTVUF25lkeQmxTMjr7duxXy
         P/nbKCHa+yo7bVyD7iB36+O8mvIqWzwQ4q6tvUlfnPfd1tUnPL5/GuD66sXJBo9PDVqt
         P5NQ==
X-Gm-Message-State: AOJu0YwGcznHwktsvsc2ITftmtsxn4nA6fAKSY7dEFnk+xo05jQ3fIZh
	XlaM6oqdf4w/YBrde8DLY/v1wih42iSU6/X+EYGTZbwffbpXlbu+5LhPEx+g4Q==
X-Google-Smtp-Source: AGHT+IFQEhx0A7SuCwUNydWJFS3ZfCv/R/ZSxd4wl5ZDtczrjvSEWhvZFXKx7Yy8/T3S4F3dQvXgHA==
X-Received: by 2002:a05:6214:5d81:b0:6b5:df48:bc6e with SMTP id 6a1803df08f44-6c33e69c6e9mr3535386d6.39.1724869987925;
        Wed, 28 Aug 2024 11:33:07 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d4c36esm68126866d6.43.2024.08.28.11.33.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2024 11:33:07 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	horms@kernel.org,
	helgaas@kernel.org,
	przemyslaw.kitszel@intel.com,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Hongguang Gao <hongguang.gao@broadcom.com>
Subject: [PATCH net-next v4 6/9] bnxt_en: Remove register mapping to support INTX
Date: Wed, 28 Aug 2024 11:32:32 -0700
Message-ID: <20240828183235.128948-7-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20240828183235.128948-1-michael.chan@broadcom.com>
References: <20240828183235.128948-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In legacy INTX mode, a register is mapped so that the INTX handler can
read it to determine if the NIC is the source of the interrupt.  This
and all the related macros are no longer needed now that INTX is no
longer supported.

Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v2: Update changelog
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 19 -------------------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  2 --
 2 files changed, 21 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 67f09e22a25c..2ecf9e324f2e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -302,10 +302,6 @@ static bool bnxt_vf_pciid(enum board_idx idx)
 
 #define DB_CP_REARM_FLAGS	(DB_KEY_CP | DB_IDX_VALID)
 #define DB_CP_FLAGS		(DB_KEY_CP | DB_IDX_VALID | DB_IRQ_DIS)
-#define DB_CP_IRQ_DIS_FLAGS	(DB_KEY_CP | DB_IRQ_DIS)
-
-#define BNXT_CP_DB_IRQ_DIS(db)						\
-		writel(DB_CP_IRQ_DIS_FLAGS, db)
 
 #define BNXT_DB_CQ(db, idx)						\
 	writel(DB_CP_FLAGS | DB_RING_IDX(db, idx), (db)->doorbell)
@@ -11959,20 +11955,6 @@ static int bnxt_update_phy_setting(struct bnxt *bp)
 	return rc;
 }
 
-/* Common routine to pre-map certain register block to different GRC window.
- * A PF has 16 4K windows and a VF has 4 4K windows. However, only 15 windows
- * in PF and 3 windows in VF that can be customized to map in different
- * register blocks.
- */
-static void bnxt_preset_reg_win(struct bnxt *bp)
-{
-	if (BNXT_PF(bp)) {
-		/* CAG registers map to GRC window #4 */
-		writel(BNXT_CAG_REG_BASE,
-		       bp->bar0 + BNXT_GRCPF_REG_WINDOW_BASE_OUT + 12);
-	}
-}
-
 static int bnxt_init_dflt_ring_mode(struct bnxt *bp);
 
 static int bnxt_reinit_after_abort(struct bnxt *bp)
@@ -12077,7 +12059,6 @@ static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 {
 	int rc = 0;
 
-	bnxt_preset_reg_win(bp);
 	netif_carrier_off(bp->dev);
 	if (irq_re_init) {
 		/* Reserve rings now if none were reserved at driver probe. */
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index b1903a1617f1..3b805ed433ed 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1755,8 +1755,6 @@ struct bnxt_test_info {
 #define BNXT_GRCPF_REG_CHIMP_COMM		0x0
 #define BNXT_GRCPF_REG_CHIMP_COMM_TRIGGER	0x100
 #define BNXT_GRCPF_REG_WINDOW_BASE_OUT		0x400
-#define BNXT_CAG_REG_LEGACY_INT_STATUS		0x4014
-#define BNXT_CAG_REG_BASE			0x300000
 
 #define BNXT_GRC_REG_STATUS_P5			0x520
 
-- 
2.30.1


