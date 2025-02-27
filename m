Return-Path: <netdev+bounces-170187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FD4A47A61
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 11:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33B667A2EAF
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 10:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A19622B5AA;
	Thu, 27 Feb 2025 10:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="SubI7WfL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE5622A1E1
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 10:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740652438; cv=none; b=DgczMZq8s+Y0a9atGoARdWScUmrFRsD2R3z+ggify6ScISbofQ/hryefyGgeMGIkWNBels7BUqy78fJYRz8zhEz6R0RX+cIUCTdAHro3FawO4QNOoaElqITDbRJuBy66o8rvVPDhHWmQB5fEKu2G69p8OCjFvG/yg3bCDpOwO14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740652438; c=relaxed/simple;
	bh=Xaj4oMjuSjNjpSa3ETbZtATmjQ7K0I0WckpYcuhf1ko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EcXCJgnoJnQLiG1GT8iDZ0HwqoPHcIX/Enihq/14ObCeF1EXAI3gsehmKyZaVTbnjIvO2jNIJu+ct35qxszAYGqmOCsPPo7Dlq+dggHtd0Xjn1dc1fwv6Kv7xxrsLuS9Gam51+VSUbS8I7oTQr113V5ceI2CwJ4LtQ192mJnASE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=SubI7WfL; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-439ac3216dcso5082295e9.1
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 02:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1740652433; x=1741257233; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3kV/+mEBoYkvFSCaizpCuqTX8PtS4kw7sxZJGfAJUIw=;
        b=SubI7WfLLOXCfqidbCuBBJEE58WiPBSloJKxTO+BU+QWzxpXlQ3zWMBVRf5rQatEU7
         RymSShOIb7YGMaHaqg3zGfX6SaaScK1KmrksAVSxI009Su6+AWLcmbK5BNBqg7TcRYAg
         /3qO38WSDyEn1fLsNgq3JHLLEVcPiSrPK7saiFkMS/9DRTNnnCZChOZSVJIfYEdLjqK1
         WEsbKDx3BzbGSOvH6k+k281M+zFDdxofOKpFDOQ1+yCHZY+ovCCeZRdB2xq02Znd9Qrr
         N2yuBje4zAEkrxNBDUbCkg3Bn797hKpA8rD1+5FzjQ10pjuhBBaqnlDAO2XHtXx+47Co
         LG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740652433; x=1741257233;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kV/+mEBoYkvFSCaizpCuqTX8PtS4kw7sxZJGfAJUIw=;
        b=NsoG5qEx7LmZt5UT4BdNKU+sL8KzDRdpZodBGP17ptS8ceNEbPHMSzWzZeK5GKIJpX
         0E4MGwJO7iTVQoSI3lb0wN1BdPr7E2MJ+glx+9U7KuORuBfrf8blvpmeQterBHd/RpzY
         OsN/oygIhdyhQbpZTAbnhRjn+Dchv7V0tJdo8KNu/OL/oU4G/603UB4Y+h/apUobL0SA
         4tNeVwb5CoS13gEXIRl2vscKquAdiNahWmpQrlg/YZt/2iWw84P/5nxQYYuBEybM1jAa
         Jnf+oxIVBFq17ev4IaesPaQ9GZJDzhUvXTbujMeIbOOEpgQRZTaQaBPPlGfw9xSlq2RN
         7Mhw==
X-Forwarded-Encrypted: i=1; AJvYcCXAdV3MJq3OJo1r1iTYHAE2sA6KZp4ZejaHx1KFqmxQl4b4ie+r56eh27pyBhbuq9DoebqPoqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFSE7fnsbCYO76iKJ/KwMlxeGgLCAIJCcblrRyzeSOybswd6+s
	oDO0o4npyF6n1V8qMdGLoELXh2LJ1enm/MY+qO3QyGIzxT5mm7bHR0UAj7fFNQU=
X-Gm-Gg: ASbGncv/eZ8keoEXeJW0qWW3FTHQ78J4NS5yrc7mg3KaQ/Cb1jI/i/qx3V59S9erSyd
	NmnEyNBVkibu2CnLGoWdaG4ZAG9jGpth1lS7xWLt+DdSTtgsb33YMWFQ/UBZspOdrAYsLzsFbFV
	2J/dQUHt7OU55qTqgfFV3uhGfwtCsiEYXKK5OnBs60ZHPw4PwBKxH51h5WiAoUCBIrAwo0PoMAL
	sfgiK/3h0fsncAheC7f/xaF4F01Sa5jf9UPSzLThVETOd8DVKDMPpe6KcG0B1V/b1IWRlBQO+OV
	Tc83j/OJ8SApGrRl/mHUnfRvHq2/R82tbHCz6+VteHSmgIxj6FBEglw0xZ+JB3PtQr4r6tUvzZ4
	=
X-Google-Smtp-Source: AGHT+IGUfMm+wQqSIMbXYaeRiTXSjbtLUzOin3rGEggSO6N1QUyFM5nBpMlk0cSmhBIeKP8kb1PaJA==
X-Received: by 2002:a05:600c:4507:b0:439:8e95:795b with SMTP id 5b1f17b1804b1-439aebf38b2mr220117645e9.31.1740652432678;
        Thu, 27 Feb 2025 02:33:52 -0800 (PST)
Received: from [100.64.0.4] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b7a27ab2asm17854305e9.32.2025.02.27.02.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 02:33:52 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Thu, 27 Feb 2025 11:33:42 +0100
Subject: [PATCH 3/3] net: ipa: Enable checksum for
 IPA_ENDPOINT_AP_MODEM_{RX,TX} for v4.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-ipa-v4-7-fixes-v1-3-a88dd8249d8a@fairphone.com>
References: <20250227-ipa-v4-7-fixes-v1-0-a88dd8249d8a@fairphone.com>
In-Reply-To: <20250227-ipa-v4-7-fixes-v1-0-a88dd8249d8a@fairphone.com>
To: Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2

Enable the checksum option for these two endpoints in order to allow
mobile data to actually work. Without this, no packets seem to make it
through the IPA.

Fixes: b310de784bac ("net: ipa: add IPA v4.7 support")
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/net/ipa/data/ipa_data-v4.7.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ipa/data/ipa_data-v4.7.c b/drivers/net/ipa/data/ipa_data-v4.7.c
index e63dcf8d45567b0851393c2cea7a0d630afa20cd..41f212209993f10fee338e28027739a7402d5089 100644
--- a/drivers/net/ipa/data/ipa_data-v4.7.c
+++ b/drivers/net/ipa/data/ipa_data-v4.7.c
@@ -104,6 +104,7 @@ static const struct ipa_gsi_endpoint_data ipa_gsi_endpoint_data[] = {
 			.filter_support	= true,
 			.config = {
 				.resource_group	= IPA_RSRC_GROUP_SRC_UL_DL,
+				.checksum       = true,
 				.qmap		= true,
 				.status_enable	= true,
 				.tx = {
@@ -127,6 +128,7 @@ static const struct ipa_gsi_endpoint_data ipa_gsi_endpoint_data[] = {
 		.endpoint = {
 			.config = {
 				.resource_group	= IPA_RSRC_GROUP_DST_UL_DL,
+				.checksum       = true,
 				.qmap		= true,
 				.aggregation	= true,
 				.rx = {

-- 
2.48.1


