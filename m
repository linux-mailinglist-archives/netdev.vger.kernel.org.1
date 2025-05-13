Return-Path: <netdev+bounces-190143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08912AB5480
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 14:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B185A863759
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 12:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344C028DB52;
	Tue, 13 May 2025 12:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bell-sw-com.20230601.gappssmtp.com header.i=@bell-sw-com.20230601.gappssmtp.com header.b="IO41QlRz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0E723814A
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 12:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747138444; cv=none; b=bNPwDFNU8ZOUc9OSQpCJ+OFSTqX7162jWgqzWaiYZRL9Ja8mS46mI3oEe0f2MmopbIuoOeSCf6HdzZm23+MKON5m9R4wb8KEm0hx7j3yH1lY14MkOB9v7HvDpKAVCPxE0NedCQJVPPsaCC26Ph05crtivNp0MHRQ2FsaO7PhLxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747138444; c=relaxed/simple;
	bh=LA/KCLameLqFOczlCUJ/2B4/nB7vo4JUftohFXDrgXY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ye4h9Mf2E1Cy8AQ0djv8YcWqgrVJ9SJTjFU1Pfx/F6PVqPlBjCqJ4TAS1nCxhDAEO6KVheXhavksyccIJX/BX8qHLht9NaBMmiMrnmHr5m+pAUs4pCxBL9JYuGkjwGcO8nxdtCv3m839LcfvL8p+OU1dTA9OVNQoLRR9pGuscLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bell-sw.com; spf=pass smtp.mailfrom=bell-sw.com; dkim=pass (2048-bit key) header.d=bell-sw-com.20230601.gappssmtp.com header.i=@bell-sw-com.20230601.gappssmtp.com header.b=IO41QlRz; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bell-sw.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bell-sw.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54fcb7e3474so3757768e87.2
        for <netdev@vger.kernel.org>; Tue, 13 May 2025 05:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bell-sw-com.20230601.gappssmtp.com; s=20230601; t=1747138440; x=1747743240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fBlZgEOoEfroAGDNOtFCLBH/jbcjwtEuds8r227tD1Y=;
        b=IO41QlRzvA1J3/3k6dZolCl9QVCbpTfH3iBDZwWoiMTxW+N3rGNpk4iAYqRjmDepsB
         Us4Rixd7qymtPtaL+i8zFrRo3CEeuQ0G67CdVjqXbJpp/EidTFZJ/6i/TMPuq1EnmZlp
         W1vRf49mCUxXWVqTcoYMN8DBVd5d/L8nLsypfd9GhSBciK7tBVPc+QEl8NGOJI+XN6zs
         CICYu55GRxHh/WiLEySM/ACtvi3+yLuz8SU01Z56KlG3l8Y9rRFP/BoenVSh5rloZnuE
         4zYR9sdV2xvHd3ibO+bmjkaVdlASbzRwjvoSRfwNxdAsl0f42GO7IodySDV2K01I5VQP
         F2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747138440; x=1747743240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fBlZgEOoEfroAGDNOtFCLBH/jbcjwtEuds8r227tD1Y=;
        b=RT+mL3RgcNzfOIPXfeI3WG/wyY33Ui4EHPFMov8+Yx6PvHEu77NzRoltHc8CZ/jtC0
         kDPbwZvkvk1NcNZBZ+SXEqR5DUjCtJF1plib4aQW74Vj+KIAPWxhVgKNHeGIDTUQMzVp
         3HdfN+FDejh5MYiXjbGj8tb36DiZrMrCw+ajduTRasaWAAufPyShNx5CLQzyVQ0RXL3s
         2tybSkVIlcItqOPa2qUz5BAhXJFaktDXXqjMHPrCC22ZefZbQqa88K8Mv6FavXdfy9Kl
         OTGG9pstjEPc1OmFU8JpT+XY53Msj7BLKVhMptgPMrRqX11mU/gSfzOrmdJCaZA5Ktzw
         qjlA==
X-Gm-Message-State: AOJu0YyjzIGxcmuWryaUvB7dUS0wUe139GP21r5qK3sWp9E2cioQ/OIR
	XJRPg+x/N6YIfgPI6asCVmoH2rOSH5BV9+Iwxilk0BCaxl8BoMZ/Y4G1V2YRBA==
X-Gm-Gg: ASbGncs+viAD5x0goaQ9osIBnD3/H9FvC+wDebBykjws1wBOmbCaLTtoWxIQoXFtrTy
	3y6+xRitByT1wc1uVnVp5+a1dKV3aRKh2dHkqvLYKknv/aYPI8uQEoxlfntvNuka2gHBVCLsrBx
	a6CabSyu9VqJi9xVCgKdCra4T4p4HeS5r2zrnrxDxdFJA3NJqHjiFO025Ql8OUxPry3scLKg4EX
	mlFKiNEOoSHnAqYtx2tZ3PHIJPT32uDs3Lg9ByyYtCSeq9aX4XhU5VGpy5SnXEs+JmZi4u4QVMy
	KRJdtwSBqszhxfZbZ3VROjljP67EItmZOpvqZiTFC7LZxJ/hS1DS56lOfwnth9G6+VA=
X-Google-Smtp-Source: AGHT+IE+2GmTp6jx2k0URSKcwhuRxgmsdmMIIUyJ9yehgMa56iPa5P8QafOjySC9AD26kZQGxzILCA==
X-Received: by 2002:a05:6512:6286:b0:54f:c4ab:106e with SMTP id 2adb3069b0e04-54fc67cbe49mr5266453e87.28.1747138439923;
        Tue, 13 May 2025 05:13:59 -0700 (PDT)
Received: from localhost.localdomain ([5.8.39.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54fc645cd2bsm1848085e87.73.2025.05.13.05.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 05:13:59 -0700 (PDT)
From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
To: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Subject: [PATCH v2] wifi: rtw88: fix the 'para' buffer size to avoid reading out of bounds
Date: Tue, 13 May 2025 12:13:04 +0000
Message-Id: <20250513121304.124141-1-aleksei.kodanev@bell-sw.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set the size to 6 instead of 2, since 'para' array is passed to
'rtw_fw_bt_wifi_control(rtwdev, para[0], &para[1])', which reads
5 bytes:

void rtw_fw_bt_wifi_control(struct rtw_dev *rtwdev, u8 op_code, u8 *data)
{
    ...
    SET_BT_WIFI_CONTROL_DATA1(h2c_pkt, *data);
    SET_BT_WIFI_CONTROL_DATA2(h2c_pkt, *(data + 1));
    ...
    SET_BT_WIFI_CONTROL_DATA5(h2c_pkt, *(data + 4));

Detected using the static analysis tool - Svace.
Fixes: 4136214f7c46 ("rtw88: add BT co-existence support")
Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---

v2: initializer style change

 drivers/net/wireless/realtek/rtw88/coex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index c929db1e53ca..64904278ddad 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -309,7 +309,7 @@ static void rtw_coex_tdma_timer_base(struct rtw_dev *rtwdev, u8 type)
 {
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
-	u8 para[2] = {0};
+	u8 para[6] = {};
 	u8 times;
 	u16 tbtt_interval = coex_stat->wl_beacon_interval;
 
-- 
2.25.1


