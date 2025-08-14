Return-Path: <netdev+bounces-213528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3595B25854
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 02:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CA581C05457
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 00:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470E72AD22;
	Thu, 14 Aug 2025 00:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXptMRF/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C241F1E531;
	Thu, 14 Aug 2025 00:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755131146; cv=none; b=gY1MwI/NTi46XLwbdtVdM/c0MZj9wdDYrOKxB9D8A0EfwvsTr9onnQ925BMs5jW49Thw0ZwgfPrW3/N4ZtzPK1OKu2Ih+o9gsYvmBUcqxFetYTuxPpcSxAkHtP7buj4zq63iu8b3zDYqM68RBhSjK/veeZLBDZvZuFvAU5t14oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755131146; c=relaxed/simple;
	bh=lY5oSXCVJGur92N5/G9v2wDj+uUDfDg7ogHm89YOXiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XHTGKGG9TyHPhOugseG9ezudkj8D7NFd9AJ+RTqWRC0bc2dXisBFs0yewqq4jxlX1gVauF/sy6s1u/Dq17IJ0NbVuK75m/UaF6PETcnZfyTA2Vvw9caRulhm5jnnn8jSviqUmhIirhwNpSeU4R6SCVypC32WXVg69o028AZkgeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXptMRF/; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76e2e618a98so373124b3a.0;
        Wed, 13 Aug 2025 17:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755131144; x=1755735944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpHGJwPIgvE780lCCyCC+udz0OEfy41+SgqD9+ahgY0=;
        b=MXptMRF/QdedO9WJ+zyx9KnU7X+uELA8EbStKBbcvGLQJhCfFyr9/idVzhFYndjFWL
         9sgpVhmzKz9hcSmeqdgeYclzn9l1wHNLZZZUBIBAswlboRj0D2Vjsp9pmu/qmJRFFDPz
         BZr4Hy3CBnVo7IQ8r9+UOLCPJDcVMJPdvjxkluxeT31u7kVUn35egw7QYFZQBoBnDkiZ
         fxf//3yg7OViORqhKyupeHJesoSrneJ1kcXOGEdr4QA0yT4UEFSgn2SADBXjgDHm9LaO
         nKm8es7TGP5a6MfanyfAM7qbhSHDNLD8ezy5tvEem9nBWwMLAT3jRmY93QynVcAu8Kdu
         7T+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755131144; x=1755735944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UpHGJwPIgvE780lCCyCC+udz0OEfy41+SgqD9+ahgY0=;
        b=vyHDZjEywZKDXwoI0DvptrGYXyVXZqSU0gBe1864T5Wt2OxnWEfcu2zHjx2B6530pu
         s7kFxej0R+A6TQ3lS4Za2PFysiZ2LFuFQcPSmi7DgpegVeAXVGZtlSgDEeTJMKhHvC1s
         htohdOrdwaMWtkGZhX1JBrytyNNTOJy6896hEkjOHNSMBNtECKm3GpTdUaUwaqyE0Bk2
         RVZbXtkRKULzajoffsLX8tsPPWx8ixWkRytv1nnU+Zlnfi0eFxX0Bb71VQhLBgVyB8oZ
         6MKX1wqt+7/1tLYoHlIpMnxTHJRep+Z2YLwz2KxsofVJgTXwIXIJcoNngbIZWfQioqJd
         0Z/w==
X-Forwarded-Encrypted: i=1; AJvYcCUesDFjz/Cc7VDSVxEpUb0/V6o9uI0+nztzHqur4BK628anGD7ZGywun9BgriQWX0MPJURTDok9k0im3Xk=@vger.kernel.org, AJvYcCUy81I9iSY2RRF8oYG7ujLhq7XC+u6xSobVNdJv81jfuFx1kdeb7I2ByUUMMDl/dAsnq5d0T+ck@vger.kernel.org
X-Gm-Message-State: AOJu0Yyci4s+bOxm07ai2IH8FXds5g3XgndfRLKIZPwjO9Xm7vLEpV3A
	TtRMKlCzlV8rNtCKnw1yhbuPiFskP76L3m4KExDFUVMyH+myW2wtdZlE
X-Gm-Gg: ASbGncs5kKAMeKkPH+pKp1PtJIilaaxcXZLQthLzJ3pXn67U8bLozi3rcJR4kcf8B11
	U6YWB3yqTMsGCet9rr+g2y25LFEY8lBdUkNyMd4MPv2dqcj9+60e/lupaI7KoLUjm11wqEt3GwA
	U8kMeeY9pSCd0GeKUBWI8JhjCiHGxgFFAFTpKmEFyzDZiw9Oz7vwbxWSnE3a2KyjJezLUnsUra3
	TZjWDurqcSkrTGlWZJEFe4/EanfvrF0amjc1HLXe1aIj5UYnblHoB2Vy3Z7iAsiGO9DdgdjjcPx
	skmgP1/5Bmw8ZEmYMnpVy2ccmmDFKjtxHXYcjIsNdNSNXRlTvBv5cX+qa0dZnO7YmXwjywtmbUm
	3HNuL9J9eBH7kSJqJzb/tX1l0+BiF94GiCPn59Ug=
X-Google-Smtp-Source: AGHT+IFnWXI1YN3Lrtd5EbEhS7vmwR1SumMKXDfzOWIY5kAt462NQratsGWREKGeSFMS3fLj/v7yxw==
X-Received: by 2002:a05:6a00:4f96:b0:76b:e109:a1f4 with SMTP id d2e1a72fcca58-76e2fd4cb3bmr1531299b3a.12.1755131143803;
        Wed, 13 Aug 2025 17:25:43 -0700 (PDT)
Received: from localhost.localdomain ([207.34.150.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbce84sm33224424b3a.71.2025.08.13.17.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 17:25:43 -0700 (PDT)
From: Kyle Hendry <kylehendrydev@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: noltari@gmail.com,
	jonas.gorski@gmail.com,
	Kyle Hendry <kylehendrydev@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND net-next 1/2] net: dsa: b53: mmap: Add gphy port to phy info for bcm63268
Date: Wed, 13 Aug 2025 17:25:27 -0700
Message-ID: <20250814002530.5866-2-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814002530.5866-1-kylehendrydev@gmail.com>
References: <20250814002530.5866-1-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add gphy mask to bcm63xx phy info struct and add data for bcm63268

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_mmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_mmap.c b/drivers/net/dsa/b53/b53_mmap.c
index f06c3e0cc42a..87e1338765c2 100644
--- a/drivers/net/dsa/b53/b53_mmap.c
+++ b/drivers/net/dsa/b53/b53_mmap.c
@@ -31,6 +31,7 @@
 #define BCM63XX_EPHY_REG 0x3C
 
 struct b53_phy_info {
+	u32 gphy_port_mask;
 	u32 ephy_enable_mask;
 	u32 ephy_port_mask;
 	u32 ephy_bias_bit;
@@ -65,6 +66,7 @@ static const struct b53_phy_info bcm6368_ephy_info = {
 static const u32 bcm63268_ephy_offsets[] = {4, 9, 14};
 
 static const struct b53_phy_info bcm63268_ephy_info = {
+	.gphy_port_mask = BIT(3),
 	.ephy_enable_mask = GENMASK(4, 0),
 	.ephy_port_mask = GENMASK((ARRAY_SIZE(bcm63268_ephy_offsets) - 1), 0),
 	.ephy_bias_bit = 24,
-- 
2.43.0


