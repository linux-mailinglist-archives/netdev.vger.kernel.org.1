Return-Path: <netdev+bounces-196310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E74A0AD42F0
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 21:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D88BE188CF4A
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 19:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809F1264609;
	Tue, 10 Jun 2025 19:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIOz6iHO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7C823BF96;
	Tue, 10 Jun 2025 19:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749584030; cv=none; b=tvYTaZgEHni6u+NfMyEvr/I5PGgAwAIYrbDnM2aB/88p4sNMCf8oMjTYb0UHlj3UAlWoAL7cTXT02jr1N8+5/iR5pQkSRUTeiBILTkqcmEu0J9qZVz7dNxlbZBmicpxscA+zAjPAolREXqNo5nD5cDiaZzKBZq86W0+pv7cvNUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749584030; c=relaxed/simple;
	bh=gIrmb7EoDA1kISDTWepbk0NttJx/iC0IZ6ESPLH1FVU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q2qe4gvoP/So3I+H4Trmg/yeKXqa8a4Ifc5MTcchOleewwssy8ffQxc+jBLqKS8znR80HA9v/uPnZpn2V9Qcib0Q0HFM88So0M5eWEshJdEvLz6lb9+LTrmKRCpblDIxzX5/qa+azKSopAZQ/1mDqfEJAYv61BvrPqjIBLRiT5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIOz6iHO; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso6457035b3a.2;
        Tue, 10 Jun 2025 12:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749584028; x=1750188828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XhUUNw39IDk31dkfQ5ihVXr3ByGFasXS5Iw3p1YWcD8=;
        b=iIOz6iHOq6J3RGDLi6CgkyXq5wbVQIkHfS+AzBaMqi990eD8TYnECW69T6Fq2JSg3t
         A5Q4oMKzrUecWdbiCxXV2JRqRFrGXzqqrbETc9CifZmHVvwE7eCs4ovZk74jZG5M+9zJ
         w6dAsqeCcOpfW1u1eIMHv4j/3o+a0fymLaAXLdGd+kR9hbxyKwrJfO/qyXfTVH69tc7G
         b351dM3cXsqKjsIU3CY2XPxQ5iOBAJ7Apre7u0lH5PXfVj5ZCbMHjZBzm5UQyXhCwtq7
         DneiRBzvQv1+RNmLRubgZoTZGV2SkPIq5t8CkGkaCXSFihHr+po5OOp0e+p+FDe3WcFs
         E/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749584028; x=1750188828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XhUUNw39IDk31dkfQ5ihVXr3ByGFasXS5Iw3p1YWcD8=;
        b=AaHYov6la3IDKV0JU2P/2P/91UCPPJbju57of+zoAjCRfycPEk802cBfx/COI3RZ3M
         A6a9DMLjg+/YB5uS9ELByT/kjKjBsnYztAshHL4TuOO43ko6t+vBSPMCzegHwqlRDLRk
         xI+d//0APQy+ACbVziLH+/+MfdbuqHAK6ZMDxlOqJamoTfAML/i1A5Biww4dpmuNFTcm
         4de9YGWEhc3d6YJXChmLBvcDKXO02Fmnj+t6KeSc/QVJffe0udq9XxGmQJQ27Y/YXoND
         Tp6AA4Lp4OgAutsVJGTqjsLpcPeVrX7XK2yT/pztaER64cuEf6a84djk56p0mvXOpQEH
         hUMg==
X-Forwarded-Encrypted: i=1; AJvYcCU3VWrddkHH1UIW9gjEK4aczRWnkiLq8vh4ThfsAGGE/AEecEhLy0L+UvmUJBBevUFRPwYmtg3MrX7VNnY=@vger.kernel.org, AJvYcCVu0G4uZtxnrK5NrEiI3Dw8nyGqd5XtJ895c0u2/sA6QJ4jBpglav9ezbYTjfFxlw6JofwYWVWZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyUefYOA7IcsVjfGzXdyc/FbY8i1/W2b3+6VbSCG3Cwl6XFXnAk
	066gbPX/kFxEHn8IlPmpaMkXMJCWaM6K9rNra3gNWI0kCJ9+s/ASqhs=
X-Gm-Gg: ASbGnctPLJfLB3r2WBlYtG4yltDnT1olnhusBtPNbigBUgR5LAWnQT6PaQnucCEMyAg
	bV/nlTOUDrKPaCGqraX4Yyl3tzw8DiWivsr6bq0VrDSS37EL1Zxet/+nCRxfxrs8VH3Lj5TP6ti
	9asMgjl20XaEVxH3ih/s/3cP9bjBTBzo4zm7uybExY3bMbq59qt8/X5/aQRiDL3kaugFG0gMUEe
	ZkaEcMO9L23B8R26XrJ1oAPqIVOpQWeZzsLJF1X64r9TzmVuukr2JzCrBsl3tkTwj/BXGjj2ET1
	HalhgUcrm0CQbZafYJAIBHKrB/Kbo+MJMzNI9xHof9oaYbh39cNKoykoB4a9SNAI3wQcZrafj5U
	N1f5EzN4eoaXYKWgv
X-Google-Smtp-Source: AGHT+IHKwCHrWOaH1C0yVAFoJbvzLPW2UUQ7qdhdiVcQrlxu455khTvPVJte63loJV4IXI5UjM21rA==
X-Received: by 2002:aa7:88d1:0:b0:736:31cf:2590 with SMTP id d2e1a72fcca58-7486fe83ac1mr16334b3a.16.1749584028197;
        Tue, 10 Jun 2025 12:33:48 -0700 (PDT)
Received: from L1HF02V04E1.TheFacebook.com ([2620:10d:c090:400::5:9a0e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482af382a8sm7753999b3a.21.2025.06.10.12.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 12:33:47 -0700 (PDT)
From: kalavakunta.hari.prasad@gmail.com
To: sam@mendozajonas.com,
	fercerpav@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: npeacock@meta.com,
	hkalavakunta@meta.com,
	Hari Kalavakunta <kalavakunta.hari.prasad@gmail.com>
Subject: [PATCH net-next] net: ncsi: Fix buffer overflow in fetching version id
Date: Tue, 10 Jun 2025 12:33:38 -0700
Message-Id: <20250610193338.1368-1-kalavakunta.hari.prasad@gmail.com>
X-Mailer: git-send-email 2.37.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hari Kalavakunta <kalavakunta.hari.prasad@gmail.com>

In NC-SI spec v1.2 section 8.4.44.2, the firmware name doesn't
need to be null terminated while its size occupies the full size
of the field. Fix the buffer overflow issue by adding one
additional byte for null terminator.

Signed-off-by: Hari Kalavakunta <kalavakunta.hari.prasad@gmail.com>
---
 net/ncsi/internal.h | 2 +-
 net/ncsi/ncsi-rsp.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index e76c6de0c784..adee6dcabdc3 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -110,7 +110,7 @@ struct ncsi_channel_version {
 	u8   update;		/* NCSI version update */
 	char alpha1;		/* NCSI version alpha1 */
 	char alpha2;		/* NCSI version alpha2 */
-	u8  fw_name[12];	/* Firmware name string                */
+	u8  fw_name[12 + 1];	/* Firmware name string                */
 	u32 fw_version;		/* Firmware version                   */
 	u16 pci_ids[4];		/* PCI identification                 */
 	u32 mf_id;		/* Manufacture ID                     */
diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index 472cc68ad86f..271ec6c3929e 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -775,6 +775,7 @@ static int ncsi_rsp_handler_gvi(struct ncsi_request *nr)
 	ncv->alpha1 = rsp->alpha1;
 	ncv->alpha2 = rsp->alpha2;
 	memcpy(ncv->fw_name, rsp->fw_name, 12);
+	ncv->fw_name[12] = '\0';
 	ncv->fw_version = ntohl(rsp->fw_version);
 	for (i = 0; i < ARRAY_SIZE(ncv->pci_ids); i++)
 		ncv->pci_ids[i] = ntohs(rsp->pci_ids[i]);
-- 
2.47.1


