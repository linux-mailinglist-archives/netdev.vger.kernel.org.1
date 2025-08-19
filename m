Return-Path: <netdev+bounces-215017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABA7B2C9EA
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 18:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AADB178C1D
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 16:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201BE27B339;
	Tue, 19 Aug 2025 16:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fYuma3ay"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f228.google.com (mail-qk1-f228.google.com [209.85.222.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E70239E97
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 16:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755621608; cv=none; b=c41tskwO21dCuGkg6vE7hC081YzWwXlCb9Fv2bJLf7yRjPIKIqWheg797zKjfLalgXetZs+vdQun8nFTNG+5gkyYEVnp21NN/L9BwG5bMPDovCDCfYUPmepOKGr4ehCZHgmKaQTibmrmvoMYkBATjOTv22XRhPtz9Y8droW1+DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755621608; c=relaxed/simple;
	bh=NefKA9kuHAYmsnJPtIi2C8g1Fa//dlT9XNbcTbAlln4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tXkHAvL15j3QPQj9jfHnCerBV+X96O7Zgg+DRTlyO8ICXCydgtaRa9LiM5sUvn9RIJ0FxET1qs4FXtKqFmKzCx5/et/R27Q+TNGSyjKHo5nwJ0xikYsLouSAjcKYbp7t0U/9xewiM102jI9B4qHrD+OhQ60Au0IndIbQx75zzaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fYuma3ay; arc=none smtp.client-ip=209.85.222.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f228.google.com with SMTP id af79cd13be357-7e8704b7a3dso614563785a.1
        for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 09:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755621604; x=1756226404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DAFUgCNfzef7QGzW8mqYazNE6E0me8b/k0QPgzoStao=;
        b=fYG2of2I4Gt3PN5+YA0n77ic85UfnzS4JE0537GhDvj4tXuLHBIz0lyL0mCMEzo4Ot
         g34prNdbri3ir618JmOXAvF9Xie4vsEFnJGOwwnqJ2Dkt5vocFX14ybuTM7R49dWaeLT
         1bNveohDxzaySUcJ8kv6D9Lth1/5AkmfxGHL3UOp9Zmh+W7tW1Jdxuhtg9RAXHvrRdYN
         +BZ4GKtSKALlSwyDELHXj512u/kUaAwW9dQgKrwbIoLWutOEHIufNe3O+eClkJg6fjzL
         Uih+WfyRNWu+MY0u4sJfHfty9tDJMi8Mob70FBWVcPFjFYF7ZM+NHAWXNaJOxy8123PL
         FbBg==
X-Gm-Message-State: AOJu0Ywvx0E0pJX1ZMKRYO2kKbFBgFXYNBHLeAhxkm0AvSSJwhDw8Gkl
	IOy6WNjqydiS61Q//W//672Xw+BEI6UUK1bVhSbRvQBPVI4+eco44mnIWVabkwVdU8moGmEwEgY
	TNEKftLgMc2K7IYaxTqehlUnWbHPYE01VU1GFaJZGxryZbbdhxtmNjYQ9Lh7KkeM+W52QawaeJ8
	ooTpIjPCsVPcxgolyKwgfLpkLL07MrsjqkJHv6fuVt9KlLwQ7I6tYuJucmrmoYm2uzDcMhEeD3y
	cWYN4/jxW8=
X-Gm-Gg: ASbGnculBkEEeMb4Jrtv1xZovaO+84KDo4xZRv9TjUSctEhMkmaJlEHux/H74RpGNlP
	0wkwTU1yalEgJWMgMK5bBon4aPhTLrxVygd3Gr03oFxz1ZkvVcS/eYfhFSbYRINteKtYNEQPEHj
	I+cXvB/ZiVTJkepP/UooiU7ldj4GZSmjCWAOH7vg733uBCB0GO0/NI+2COSi8kg2vmA1T5UaXnR
	fd9VyoJjSrBFwv7guhre37RNLxAwOHVOAQGAQiBsSN64geMdEYPGPbjKP+XVdvrgKwKl27bcGuS
	WwEP4pfE+XYhAtwaWupVaa3YtuZBtqVIeOwqRVQjOkChhdUargnAsSVK9lN7E711EPDr5uoUqhE
	09hebyOqPOSaRo5wgeJSmoqXhWk0XXGCMXf8bXmKZjbCpI6gB88Guq6bAYzW7ns3qoJ2Tn9P46H
	V/ug==
X-Google-Smtp-Source: AGHT+IEhxIMalns+ZvYZ4C2wQBrkbYzZt11Ku2ta3zq3GX/7V7Fdnt/rhC5zr0z8KdLl3P3BhKx4wPmqJT51
X-Received: by 2002:a05:620a:17ab:b0:7e6:97a2:ea7d with SMTP id af79cd13be357-7e9f3438607mr363419685a.62.1755621604305;
        Tue, 19 Aug 2025 09:40:04 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-70ba929a226sm7419036d6.44.2025.08.19.09.40.04
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Aug 2025 09:40:04 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e8704e1baeso1711890185a.1
        for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 09:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755621603; x=1756226403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAFUgCNfzef7QGzW8mqYazNE6E0me8b/k0QPgzoStao=;
        b=fYuma3ayy7ixBQL+gfF1Cy/4lSyWR4scGqGGLoAZwyIOTol5ArCdHR9C9NvXFjCkcL
         G1J8nn1auxqrLqybCbjxIilh2lnSbxlsnW9JAMFDzjDOqGfLiKMJGWauiTrVqRPf+YyQ
         VtZ9qbCGwWFIDzzpQ6JF+gG9LA9Adfz5Ev1co=
X-Received: by 2002:a05:620a:318c:b0:7e9:f820:2b86 with SMTP id af79cd13be357-7e9f8206067mr240997285a.71.1755621603321;
        Tue, 19 Aug 2025 09:40:03 -0700 (PDT)
X-Received: by 2002:a05:620a:318c:b0:7e9:f820:2b86 with SMTP id af79cd13be357-7e9f8206067mr240993385a.71.1755621602737;
        Tue, 19 Aug 2025 09:40:02 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e19b14dsm791908085a.39.2025.08.19.09.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 09:40:02 -0700 (PDT)
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
Subject: [PATCH net-next v2 5/5] bnxt_en: Add Hyper-V VF ID
Date: Tue, 19 Aug 2025 09:39:19 -0700
Message-ID: <20250819163919.104075-6-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250819163919.104075-1-michael.chan@broadcom.com>
References: <20250819163919.104075-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

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


