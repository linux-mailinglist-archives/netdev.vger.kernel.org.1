Return-Path: <netdev+bounces-214431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E08B295EB
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 02:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C6014E5778
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 00:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38684221DAE;
	Mon, 18 Aug 2025 00:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SOtVz59O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5868222564
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 00:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755478243; cv=none; b=Gvio4z2hXH8CNixfJPP+s3DK49Yg9tI5Wi8/04I0a6Idt1A1cArAa+v3IHyfc3MkJfAdtV5I+W9EwNPSy6NV7iY7B70S0EzLiB/Yies6D4iQzyyIhcJsYLh7prHl/2MbECiz4Fw2jCLuPEYq+BnsuCfQBdvcwFSib12exls9IoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755478243; c=relaxed/simple;
	bh=NefKA9kuHAYmsnJPtIi2C8g1Fa//dlT9XNbcTbAlln4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KcLbEOKPfJZNM24DLMPvH+pm0jm5i89kzf3rDvTzNOhHXfuyHmPykw7+y9vUqGmggfoKcSR3w24Kv+xUUZTR60rVMYxPBQLnQFxLxw2AXit8tEnwRTZXFIalbpUpztfzOrGPtLJ4xXY68B5lyCuRZB+2D9TTY7RwV1Laqn/lAcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SOtVz59O; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b109912545so40419321cf.0
        for <netdev@vger.kernel.org>; Sun, 17 Aug 2025 17:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755478240; x=1756083040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAFUgCNfzef7QGzW8mqYazNE6E0me8b/k0QPgzoStao=;
        b=SOtVz59OLU+7YakWnjaaBvJjs/AAHxv4UZHXYfW1hX0ElIZBVRpfd/9tYgKsPuEyec
         UB14nzKiM20bVd863DzdOth0urvc9NaMza6kocMS8Kp0OBc6/7+AVuVz7LU/+qM32x2n
         6nVXtdUOCQYF6fDUxgAKl3UBnKzpYScagSsEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755478240; x=1756083040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DAFUgCNfzef7QGzW8mqYazNE6E0me8b/k0QPgzoStao=;
        b=SOfC8o+aYDTi7+C44h1757kasQj9VvUrja8RTpk7rMRDUljzYKGzARWVScWMItMOVW
         icuTT88FginWTg1HvsJXZTS/92i8/0hLA505Ivo83ynyzZ1gwNsxHAIhLLzi0aKxVK28
         7X4z22y2IegQmjncuYXJWrq89LBXzQbFvliZIjD98+rfWu5kRLfHmNkKKUgtLe2OaSGm
         dgb6G2tfal6/0R4i8XmkKqXmskzgbWn27HIF7SRtMd5akIVV49/YYTaWXQ4iFQxVBjxO
         q1J2GnZJ2FIDYAI228qsg5whPQYPNIfL6mzkX+DiioBML6dYmBXQSfZxDfuX61RN2MiV
         PDhg==
X-Gm-Message-State: AOJu0YwpAiz9v6wWocKo6o/SWVAEP+yjuiY1fJ9bVKJLY13ROEGzTppo
	fvrUjX6v5LZq1K3Vk46bUxTBHDMJB6QN++BekWlk0sawf5EuFDPgkk5so0Ag7Yqb0A==
X-Gm-Gg: ASbGncsTrYZqnQjxBHpNEWPO7rV8PwOyh0i9+n+Acxp1ZY/egrRGyuCj7bFwilPRMEs
	GCUDWOrnncXpSRpKWzw4stuw0abUVBdRySQ8oZ37g8QZ1DKvuhwqDIZ3cf80/v5CLZWBWiD/lyI
	W37re05JnpotwutCbqq25Idg87TwNm6TY9bIZaQoNWQeCRIOw59yKSopyXSXC3q0GSB8KaXv0hs
	3QkCyo+0OH3gYMpRpQGIB6fwfm1f/aCuuRBI45/1vz5SFYx3ztgTdRyeH0K0WMZFOta/mNqw4I0
	Q4Q11JBegQlPQngImVav5ZCpCe0UHMkHLFv1D313l9zi6bhjhl2y+sN/+myzEj/X7TPymAd1dGP
	cmlAs5aJy4x5SKVgT/wlC6VRoiDL0mCCcYMO3PskQDnEXn1rxDdINwKSmlMB6KC/YjEEMbqLibg
	==
X-Google-Smtp-Source: AGHT+IEYDhQ5sJQoawFHZC3GoUk2gY+txl2Z+PTeefqHoVKCXncvTiarPKqe1xBgPihemCcAzlJmVA==
X-Received: by 2002:a05:6214:406:b0:709:65c0:ae8d with SMTP id 6a1803df08f44-70ba7d0d10bmr145882936d6.50.1755478240573;
        Sun, 17 Aug 2025 17:50:40 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba9301703sm44987526d6.49.2025.08.17.17.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 17:50:40 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next 5/5] bnxt_en: Add Hyper-V VF ID
Date: Sun, 17 Aug 2025 17:49:40 -0700
Message-ID: <20250818004940.5663-6-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250818004940.5663-1-michael.chan@broadcom.com>
References: <20250818004940.5663-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

VFs of the P7 chip family created by Hyper-V will have the device ID of
0x181b.

Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 5 ++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 2d4fdf5a0dc5..ba99de403138 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -142,6 +142,7 @@ static const struct {
 	[NETXTREME_E_P5_VF] = { "Broadcom BCM5750X NetXtreme-E Ethernet Virtual Function" },
 	[NETXTREME_E_P5_VF_HV] = { "Broadcom BCM5750X NetXtreme-E Virtual Function for Hyper-V" },
 	[NETXTREME_E_P7_VF] = { "Broadcom BCM5760X Virtual Function" },
+	[NETXTREME_E_P7_VF_HV] = { "Broadcom BCM5760X Virtual Function for Hyper-V" },
 };
 
 static const struct pci_device_id bnxt_pci_tbl[] = {
@@ -217,6 +218,7 @@ static const struct pci_device_id bnxt_pci_tbl[] = {
 	{ PCI_VDEVICE(BROADCOM, 0x1808), .driver_data = NETXTREME_E_P5_VF_HV },
 	{ PCI_VDEVICE(BROADCOM, 0x1809), .driver_data = NETXTREME_E_P5_VF_HV },
 	{ PCI_VDEVICE(BROADCOM, 0x1819), .driver_data = NETXTREME_E_P7_VF },
+	{ PCI_VDEVICE(BROADCOM, 0x181b), .driver_data = NETXTREME_E_P7_VF_HV },
 	{ PCI_VDEVICE(BROADCOM, 0xd800), .driver_data = NETXTREME_S_VF },
 #endif
 	{ 0 }
@@ -315,7 +317,8 @@ static bool bnxt_vf_pciid(enum board_idx idx)
 	return (idx == NETXTREME_C_VF || idx == NETXTREME_E_VF ||
 		idx == NETXTREME_S_VF || idx == NETXTREME_C_VF_HV ||
 		idx == NETXTREME_E_VF_HV || idx == NETXTREME_E_P5_VF ||
-		idx == NETXTREME_E_P5_VF_HV || idx == NETXTREME_E_P7_VF);
+		idx == NETXTREME_E_P5_VF_HV || idx == NETXTREME_E_P7_VF ||
+		idx == NETXTREME_E_P7_VF_HV);
 }
 
 #define DB_CP_REARM_FLAGS	(DB_KEY_CP | DB_IDX_VALID)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 25ca002fc382..1bb2a5de88cd 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2130,6 +2130,7 @@ enum board_idx {
 	NETXTREME_E_P5_VF,
 	NETXTREME_E_P5_VF_HV,
 	NETXTREME_E_P7_VF,
+	NETXTREME_E_P7_VF_HV,
 };
 
 #define BNXT_TRACE_BUF_MAGIC_BYTE ((u8)0xbc)
-- 
2.30.1


