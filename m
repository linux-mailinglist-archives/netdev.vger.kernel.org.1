Return-Path: <netdev+bounces-223843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E35F8B7D5F2
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B44C1527B87
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 04:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B8730149E;
	Wed, 17 Sep 2025 04:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="I8X8PjeX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f228.google.com (mail-yb1-f228.google.com [209.85.219.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF992FA0F6
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 04:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758082164; cv=none; b=m/VOC4sH7aZBELptkrYEeLeS4GKSSbe6dYGOuBCv3wwcue0eSlWkZWt85KBeYrahs5TQYEluTZr2EfYqul+j/6UqE7lzufsLGW+Pzow14B3EhXX1EUbFw8buNjBDyj9HF0okpqw9CU57N/ITHaQauajGyjdFZEhA9WIlFa6YyXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758082164; c=relaxed/simple;
	bh=EpcWq4Se+vvHPb355umfhYJACcTX5HSoNUbvkp1CtOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=byHU6/lvQwFrq5F1OOTYUQ30kPo1dx4LJWSj+M8mEQ4kBuWWKqYwieHd7Lq8fLurQvUe2JFHrgWRrEaCdoAxuvJ77LFjQclRFI8+ZR5GE765ct74qf9GW2Q7rjXWm8qKNeao9/kweEm0+UAidL5gaixg+HiOYU13hxSLn6NQXsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=I8X8PjeX; arc=none smtp.client-ip=209.85.219.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f228.google.com with SMTP id 3f1490d57ef6-ea5c1a18acfso132895276.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:09:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758082162; x=1758686962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QJr5DlvkvhNZDA0jVrL4jcJECp4mTtvZjTpPa0iAxz0=;
        b=T6kUZxd9LYAspiwIOskbXvnhfpU+LeRxftihAfxncOlOxnNbLxooKvNU5xPNzTO7BL
         720ytrmRSwcssG+WApFKFp18hqiQ2ta6MJPEzraCAOn/ZgDDNy4oosA5STRQM53smdOO
         lWZCUaGIL8LZl8GwMQ11mOhDvcjhBeryRvVHr3vlmLDVE5Pxys7LWtwmwN2iGjeek0XS
         jE8nW4x0UIYvc8iR++IHOxZoHO8dJT0HlXIk7tBPvXrZvpUQIwT8g03LoOb/93tpz1n9
         I13tITloVq4egF1uAlowqZ+zvRL8/m12Rh4aXu9CuATys79RsLDRke/GJz4sdl87QXhl
         DTPg==
X-Gm-Message-State: AOJu0YwaiXmigONGUfUQQr4MsHLBCmbRMo8nRWiJzpiNgPeGsx0tTC6m
	v+vCym2Y6s9JIEQosQufx76BtY/PSj9jdqOUe6JYdsR80AAMy51v/37lfhh6ym21+jZjsEMFJFm
	LfBoCd2xiTzf3JwvVNczpZ9hxjDS6zuhoByAW1FLDpjaIQW1CNsRrq5FmeKRGUr+lV1SEKHLlQs
	xjWhMfqiJAr6V1rKNXy7andaraG8aS2OADnHtYc4N78oMESpj8Mxw7nXVaFDQGPb4Rx2WkalXoy
	S6lmh19YiA=
X-Gm-Gg: ASbGncvafHaWe5duNUIF/OClYqKT0XJSmXyqf5IIV5FuzivTNq2bj3xmFoTRFwrYRNZ
	DSGmS+iIcyq5iB3oHHh4/iYQF1XaR8n1UpjO1NsebAXvmmCuK5ZoQYkvlD1JbBXkgaoOM4ke/TS
	ss8aULGvd/ZOSWGW4kd586W1tekh2yJcCyHKf1I5Gww4ND4cO9oYuVaLqbaNWt+nO/+N+uL+IAB
	LFqZl9Pnts6OjQbxLLjLzDBFCc/kgnxoTH1Yt8L4gA5GXfN/nFx5WO9wPR+U/LLxpJjPxmbOWWc
	iaFJU8GrOxCzOStzlHoaUEqZAFz5gWNfwubr4Cbx/dxCd26bFynN2fBd/EqO5xHCo9qzbuI5N/Z
	n+kt15qwY8r9m+f8yrLum0OTDqpaXYHkeV4VO5Vefx6/ILWnH0Mf0VSWd0VLbCGX16KXxZFZNGg
	MIvA==
X-Google-Smtp-Source: AGHT+IHhBKRfa5D7dcbn5F0IGKYn5GhQ8ih5flEx1yDvu10c3S24i0mj3oIKbZRfz2/kkmCbuOQXfUoJQgj1
X-Received: by 2002:a05:690e:23cd:b0:628:3ca9:93bc with SMTP id 956f58d0204a3-633b061c6e0mr498499d50.15.1758082161863;
        Tue, 16 Sep 2025 21:09:21 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
        by smtp-relay.gmail.com with ESMTPS id 3f1490d57ef6-ea3ddce036bsm802744276.2.2025.09.16.21.09.20
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Sep 2025 21:09:21 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32df881dcc5so3924919a91.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758082160; x=1758686960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJr5DlvkvhNZDA0jVrL4jcJECp4mTtvZjTpPa0iAxz0=;
        b=I8X8PjeXqGz9+EwEz4vgezP6DpN5A2h/O8LHtSZXLva+S5AQ9ylfUmG18VsJgrYlTf
         W0+h7PjshUx4JcsRhaGzK2/VW0i4KQBkptvmMeouTjgYyqb6zZlfbBz6/81MZtqe2Miv
         bz2pe9hnEQx0sBVR6YAxJTN9dsmTQFwxHM+3c=
X-Received: by 2002:a17:90b:264d:b0:329:e4d1:c20f with SMTP id 98e67ed59e1d1-32ee3e9047bmr874033a91.9.1758082159721;
        Tue, 16 Sep 2025 21:09:19 -0700 (PDT)
X-Received: by 2002:a17:90b:264d:b0:329:e4d1:c20f with SMTP id 98e67ed59e1d1-32ee3e9047bmr874014a91.9.1758082159298;
        Tue, 16 Sep 2025 21:09:19 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ee223f2ecsm558562a91.18.2025.09.16.21.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 21:09:18 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Ajit Khaparde <ajit.khaparde@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net-next v2 02/10] bnxt_en: Remove unnecessary VF check in bnxt_hwrm_nvm_req()
Date: Tue, 16 Sep 2025 21:08:31 -0700
Message-ID: <20250917040839.1924698-3-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20250917040839.1924698-1-michael.chan@broadcom.com>
References: <20250917040839.1924698-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

The driver registers the supported configuration parameters with the
devlink stack only on the PF using devlink_params_register().
Hence there is no need for a VF check inside bnxt_hwrm_nvm_req().

Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
index d0f5507e85aa..02961d93ed35 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
@@ -1074,16 +1074,9 @@ static int __bnxt_hwrm_nvm_req(struct bnxt *bp,
 static int bnxt_hwrm_nvm_req(struct bnxt *bp, u32 param_id, void *msg,
 			     union devlink_param_value *val)
 {
-	struct hwrm_nvm_get_variable_input *req = msg;
 	const struct bnxt_dl_nvm_param *nvm_param;
 	int i;
 
-	/* Get/Set NVM CFG parameter is supported only on PFs */
-	if (BNXT_VF(bp)) {
-		hwrm_req_drop(bp, req);
-		return -EPERM;
-	}
-
 	for (i = 0; i < ARRAY_SIZE(nvm_params); i++) {
 		nvm_param = &nvm_params[i];
 		if (nvm_param->id == param_id)
-- 
2.51.0


