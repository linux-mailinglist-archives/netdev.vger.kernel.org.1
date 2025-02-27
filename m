Return-Path: <netdev+bounces-170185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F88A47A59
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 11:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E3FA7A1FBB
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 10:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E5B22A4C5;
	Thu, 27 Feb 2025 10:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="i1ps2cCh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC0721D5AE
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 10:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740652435; cv=none; b=t7XsZxEjQRivSRR9zwQYiiuxPERBimRqUp46WTQBgNwGh6DhQ8YROleOXI3wHvsYxQV5odvwuCTjIAJtRH4Y1wGcZW7qe7avrkdrx0Z/Ho1MUk0eD4yEX+toEZArNnCFKG1Jaz5eIZwTGHYXVCX4wbPl2Ha+x7su+rbrMtymdbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740652435; c=relaxed/simple;
	bh=ARqIPR+p2tpe5EaKR1df/smz8PWDinQX9DhGTpM5U7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uOI9lHk1EFDlOTDOw6vnFEZXVi7A4+hD+1pk2QETo/iDIBKyYIFoP0aWJJuRLCtOq35mYgFjXvv6ocNAFdfPtntXqeJ/WLwv/SdPnEUK/eXUkiYHAoeFVadQrp4mOwOhNsgV8PyBwkIt6kSLfLwrU3JJj6EHBa/Bzo7sPpc5zPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=i1ps2cCh; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4398ec2abc2so7012265e9.1
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 02:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1740652431; x=1741257231; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uZWB2hgX1A7RofWkTIOTroK4Gv7om7GgUCL4jMU0GpM=;
        b=i1ps2cCh2Y5wzu+0KcCR1y3U62S5qnHyT0tySW3HsK80vQeaZ7nkJkcHes4KOW9T3n
         +F9YAsgmwrm+38u+eodmkCa2UEw3EoEPva2ehxyUZsNt+2aP3RZEjbu8kkeVZABVvmUI
         BCbGC1gbsPMazcnTY2hhcgPC8YyLMCNkAFrXXgkZ9VqZIKVBXs0/oe5098FWSXFkI/DB
         LvnL2pwO7HfXB3TYWQ3bemAHPdmMzMkMWkAVCeT+rHOi0lJpiDHm6t2X9aDHF7orygYt
         Rkq3aVhvEg+OJOkJ9Xi8rPc8KANvtavM15lEsw7ZJAzTDGDdCrCcS5QpCiPiLpABnV33
         Ay7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740652431; x=1741257231;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uZWB2hgX1A7RofWkTIOTroK4Gv7om7GgUCL4jMU0GpM=;
        b=laLq6X4XmSCHX8hw+xEFTVkAx4fOlRVqL+vmvLGdyrhAUxjlWp3xwGcOnrgglsOZ2X
         Z38+zWKWAANz+Gnbdaa3+1+SEAmaAVSNFkaDKo8BNJYwqPpPJNkbbgYxhlRAnb11p9Wc
         R2Mrbp68f8FY+3wORcecfws5H4BXjWuLTXzNx/7h2TTfgCmatXuPFiKmKi/M0fOs6oAX
         OxUDlrvN9f9z5+TqzsdESj5eQY0KQ9wNjygzHErwkBBiuRvoGFPW9utGUbiaudNwlnqm
         zuwkCRXT4ULsFLg2uoYDF2LUmcVtjGjUU2TaOQs73g2NFH1xd21DB35NNOspPJRWCobG
         Bw+w==
X-Forwarded-Encrypted: i=1; AJvYcCXGPbnse3JLJMxDB9PYeGuXRCmcoUnt1w15YMNdDaQyGY/Ty8g4De4IbEjY3gabqVfSFIj9VmU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6oCYtQqLNFCsML8zMyDIdlvES5nLlUO8zB+jHCwHlrCuQJinf
	Jg9dv8LumcP2K0ItQvyzb78nldc5ybfO/sIGuV5TXHUckLaG2Azx0CUstxOVuHU=
X-Gm-Gg: ASbGncsN8DxNMKtSwU2e0yl8zhrx2IuhxfvQWQwDA4qVijsqf6/Og4qrBlmDWq94FiX
	3yjqqjlyW8tcyLpf/QYfJpdulB7mrHLcKGAlYxX3xcqR8BsCq++HqvZB1RGaPxn47I2Z+atN80b
	HFZMRdKbE++ZWUe0xy9DEtcaAwDRnWYArCbwyEBv7YQKNBpsJzeu6kgHkjnN8y1X6jrVk2q8/Wt
	kS0OhlLlcFIIa72TDMon5nLQ2lKjIqmoFoGUDLddTDcMwv/c9KteHyjK9OUTIsSykw4/kfLZeR5
	zU8Lx2s3K2pDcmM5BE5H1NTF60b7lKAOK9OrgnNCJhrQFOTqu0+LkXJlODv24UMdq2uU3GYEwEs
	=
X-Google-Smtp-Source: AGHT+IHWaUYc9t6tW0emQRrLnAiI/h4VX2LetyBut2pWf/Sr4AARB4vXq14BdTbHgSxE6htiNBuHmA==
X-Received: by 2002:a05:600c:4ed4:b0:439:4700:9eb3 with SMTP id 5b1f17b1804b1-43ab8fd1e98mr55737585e9.3.1740652431477;
        Thu, 27 Feb 2025 02:33:51 -0800 (PST)
Received: from [100.64.0.4] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b7a27ab2asm17854305e9.32.2025.02.27.02.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 02:33:51 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Thu, 27 Feb 2025 11:33:40 +0100
Subject: [PATCH 1/3] net: ipa: Fix v4.7 resource group names
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-ipa-v4-7-fixes-v1-1-a88dd8249d8a@fairphone.com>
References: <20250227-ipa-v4-7-fixes-v1-0-a88dd8249d8a@fairphone.com>
In-Reply-To: <20250227-ipa-v4-7-fixes-v1-0-a88dd8249d8a@fairphone.com>
To: Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2

In the downstream IPA driver there's only one group defined for source
and destination, and the destination group doesn't have a _DPL suffix.

Fixes: b310de784bac ("net: ipa: add IPA v4.7 support")
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/net/ipa/data/ipa_data-v4.7.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ipa/data/ipa_data-v4.7.c b/drivers/net/ipa/data/ipa_data-v4.7.c
index c8c23d9be961b1b818e8a1592a7f7dd76cdd5468..7e315779e66480c2a3f2473a068278ab5e513a3d 100644
--- a/drivers/net/ipa/data/ipa_data-v4.7.c
+++ b/drivers/net/ipa/data/ipa_data-v4.7.c
@@ -28,12 +28,10 @@ enum ipa_resource_type {
 enum ipa_rsrc_group_id {
 	/* Source resource group identifiers */
 	IPA_RSRC_GROUP_SRC_UL_DL			= 0,
-	IPA_RSRC_GROUP_SRC_UC_RX_Q,
 	IPA_RSRC_GROUP_SRC_COUNT,	/* Last in set; not a source group */
 
 	/* Destination resource group identifiers */
-	IPA_RSRC_GROUP_DST_UL_DL_DPL			= 0,
-	IPA_RSRC_GROUP_DST_UNUSED_1,
+	IPA_RSRC_GROUP_DST_UL_DL			= 0,
 	IPA_RSRC_GROUP_DST_COUNT,	/* Last; not a destination group */
 };
 
@@ -81,7 +79,7 @@ static const struct ipa_gsi_endpoint_data ipa_gsi_endpoint_data[] = {
 		},
 		.endpoint = {
 			.config = {
-				.resource_group	= IPA_RSRC_GROUP_DST_UL_DL_DPL,
+				.resource_group	= IPA_RSRC_GROUP_DST_UL_DL,
 				.aggregation	= true,
 				.status_enable	= true,
 				.rx = {
@@ -128,7 +126,7 @@ static const struct ipa_gsi_endpoint_data ipa_gsi_endpoint_data[] = {
 		},
 		.endpoint = {
 			.config = {
-				.resource_group	= IPA_RSRC_GROUP_DST_UL_DL_DPL,
+				.resource_group	= IPA_RSRC_GROUP_DST_UL_DL,
 				.qmap		= true,
 				.aggregation	= true,
 				.rx = {
@@ -197,12 +195,12 @@ static const struct ipa_resource ipa_resource_src[] = {
 /* Destination resource configuration data for an SoC having IPA v4.7 */
 static const struct ipa_resource ipa_resource_dst[] = {
 	[IPA_RESOURCE_TYPE_DST_DATA_SECTORS] = {
-		.limits[IPA_RSRC_GROUP_DST_UL_DL_DPL] = {
+		.limits[IPA_RSRC_GROUP_DST_UL_DL] = {
 			.min = 7,	.max = 7,
 		},
 	},
 	[IPA_RESOURCE_TYPE_DST_DPS_DMARS] = {
-		.limits[IPA_RSRC_GROUP_DST_UL_DL_DPL] = {
+		.limits[IPA_RSRC_GROUP_DST_UL_DL] = {
 			.min = 2,	.max = 2,
 		},
 	},

-- 
2.48.1


