Return-Path: <netdev+bounces-184913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDFBA97B12
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 01:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9790D3B164A
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 23:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E71D21578F;
	Tue, 22 Apr 2025 23:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UTjoGpB0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73AE215182
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 23:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745365015; cv=none; b=dACyO7fx8kqe//AyvUdofdsppHBX/dycgzIA0UVymiCZY3Yn53+HwpXEMgkEpKvRhVYNhHDKxrxTB7ZbWeWylHRzU4Wn0Cn11V/J1fB4NANIZfeNR4wbZBXNb293DkYcjBK/7YqJMsiQpJgki/UmTtQKBahs2r6DT+cxrFUe76c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745365015; c=relaxed/simple;
	bh=pF8ez7aFcLBbvpQpgh5TTTiNbweXDacQUMN7hsRktsU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TSkStqNy46HclRaABo+dOruyoCPykknQYwjc05B0hr0iTyihUITEfax5sR6BAp6WHGN/Heagj87Kct4oWfxLyUF+gdUiILh/P6nvQCqOTjL5Ik9hKErOGqcHNKgNex4FaKigc3IfrdXuef0BjKfH8qSYCjSCVRatdyYfOzwH0Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UTjoGpB0; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3fb3f4bf97aso1871204b6e.2
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 16:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745365012; x=1745969812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YxbTj51VJBmBdYYQuCm52KKYLeJDF2R85Q1Cr+YvRDI=;
        b=UTjoGpB0ws7yVOZlUriGdkVrWwIinSsfHnWbaWp/JVbsUG4h/4nJzp7IJ3qwUyaaFf
         2XRv4h329qNwy28YSH/6/eDeeTEgnNNtvZ4msdjAiavIlcONJI39m1vvckVFZvRLYOGw
         LiONd4FzIgsT8ClLttEidpPUDUg/sjwdASu0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745365012; x=1745969812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YxbTj51VJBmBdYYQuCm52KKYLeJDF2R85Q1Cr+YvRDI=;
        b=u8rwd4FvNrF7JoxEZNrF91z+rs5Gp8cZEWSO6VMtrFGIpdKL1XVry2GyyxPzuJF+Ff
         f/jrgX/Cb1R3efv9RUnViyiVAc3DiriDdFoWLF/U1Fun/lJR5Yk0LnIrFyk07vQ1XWe5
         aU4k3n9kFPZDiHt//fvCfM3JEJcW3hzMSayNm89+GKCioVhoWf0McG4U1gIv3/BiHQvy
         1b13X/I1E5lDYJGxkEbcJhZqG2ZJNdGPlNyLm/Z0VjkDoaf89x0eYifpvjgAtSarmjgr
         5eKcaSPsV7wDjaRcfw4p/CBJGlPIiDWqy9YZ+YaNatgZHONLVKiZQGfTyd6KF9+5MaoC
         Em3g==
X-Forwarded-Encrypted: i=1; AJvYcCXg8vs9sRNvCfGF9Zgpfz5jogz6zyDHwll6R3KY3mU6IhCtBB0NOeoICt7B6j77YVCZKKECDzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbwiDaZjf7A7W6a095rDpQ4e3GhubGMDb8zgqEKciddiYmb4mC
	7HjmZeKqz1RDauCQXR+qxMw+aycpn8pB2OKLko1jWv2GWn1N0Zv+HLs6I9DEJHvtJWwOy5apQaE
	lDQ==
X-Gm-Gg: ASbGnctKbny5NPFlTr8Mjp2beolJW5HTLoU/7BOjdrLxpo0jdRQmrEPtw2WbOBbPukJ
	4r3ZpbQW/sAdxXxqSqfkK9RLjincmXls8Od2TYqZVFTHMwxY4AyMUaXg9QpmEWKxRzRoCgpQ5gK
	dI3F6guzDZsjkdfIPmlq150BaVEbpdT5Qe/AL34GfkV4UWerD4PgfJir2vRQBf9g7udE/My1xa8
	/k6H1qKWIEN8MYIlEI2MAvgvo/gOzZRPaAUkzccWVO4uFWX3+sUu/X7imISeHspE+tS8tWoLurY
	nVQvrDw9pA5PPOdI+HddHDt2ecWCpHqJY7oNQoH0m2/gVR6mfehn7PCIDisRR7Yyjhim1Px6a3E
	rlTBxSdidXtzpHjmPYg==
X-Google-Smtp-Source: AGHT+IEgzj9z3BiKM5p/koL0xTOJSuarSQ/kGm2LJ7y0keZ0ot7GJiasLqYoNQTyMaYM127wYpCSjQ==
X-Received: by 2002:a05:6808:2e4c:b0:401:16e:c5e1 with SMTP id 5614622812f47-401c0c6504cmr11728599b6e.32.1745365012688;
        Tue, 22 Apr 2025 16:36:52 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-401beeaf403sm2333582b6e.7.2025.04.22.16.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 16:36:52 -0700 (PDT)
From: Justin Chen <justin.chen@broadcom.com>
To: devicetree@vger.kernel.org,
	netdev@vger.kernel.org
Cc: rafal@milecki.pl,
	linux@armlinux.org.uk,
	hkallweit1@gmail.com,
	bcm-kernel-feedback-list@broadcom.com,
	opendmb@gmail.com,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	florian.fainelli@broadcom.com,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net-next v2 2/8] dt-bindings: net: brcm,unimac-mdio: Remove asp-v2.0
Date: Tue, 22 Apr 2025 16:36:39 -0700
Message-Id: <20250422233645.1931036-3-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250422233645.1931036-1-justin.chen@broadcom.com>
References: <20250422233645.1931036-1-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove asp-v2.0 which was only supported on one SoC that never
saw the light of day.

Signed-off-by: Justin Chen <justin.chen@broadcom.com>
---
v2
        - Split out asp-v3.0 support into a separate commit

 Documentation/devicetree/bindings/net/brcm,unimac-mdio.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/brcm,unimac-mdio.yaml b/Documentation/devicetree/bindings/net/brcm,unimac-mdio.yaml
index 63bee5b542f5..7eb6d5839f0b 100644
--- a/Documentation/devicetree/bindings/net/brcm,unimac-mdio.yaml
+++ b/Documentation/devicetree/bindings/net/brcm,unimac-mdio.yaml
@@ -22,7 +22,6 @@ properties:
       - brcm,genet-mdio-v3
       - brcm,genet-mdio-v4
       - brcm,genet-mdio-v5
-      - brcm,asp-v2.0-mdio
       - brcm,asp-v2.1-mdio
       - brcm,asp-v2.2-mdio
       - brcm,unimac-mdio
-- 
2.34.1


