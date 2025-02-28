Return-Path: <netdev+bounces-170816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 291AAA4A08B
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 18:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40582176C49
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 17:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEEA1F0991;
	Fri, 28 Feb 2025 17:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRPnetrl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62E61F4C83
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 17:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740764125; cv=none; b=C6BjHnwqfe65/33jekdIUz+uEnuiBk/J00oVIIj2FZTtoeMPCc6Xj0yB0YHPi23+DpipatoKBjH8ttLQPl6jXYzh0v8T/tKwzIR2u+ONNzQGbd1bH+cjoS2ULNsKQ8DlURmOsssVGg3SMQSrlh9LqXupEVQ37eRDIT4mSOjVq1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740764125; c=relaxed/simple;
	bh=AvKcfi6J7Inl1hX+sxLBONbarQPJfKHGuYSlgE+eyjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LJ05ZNeDy9yVZE/6RSWwWZFcLASXVveKJCD2YlLnpEbHboOMh9VP9jQM1CxXwSR8SVe3kqqmrg5rIVh7FlG4QpwhjqjkIwqdLzEnHEwsW0rgVPfjCjfv3bPYNr4Jz8A7NqaqLHigzYCBB0HsumQlRKG088X5uxkUB5dLd6A1REU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRPnetrl; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43995b907cfso15920315e9.3
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 09:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740764122; x=1741368922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VEOHTT5bGWNRWFvPq36jSPYDFsBGCPSq40LhDAyjb0E=;
        b=VRPnetrl8KxWSaRZOSnqgd3P5UIamtu8O3akI9B/pPBy0jEh+XjgpC6N0YNgENYFPR
         bc46EieJN6Ld96RyBaRYtvJ71gMtXhejgbo9ZoYQ2y6w4v88esAKE6/GP4XNZ7H5QJfx
         TYDjiMpjTs1BD5gfqiNiDCG/RRh/jKL+ajmVipAnZDuSDn/24LpcMyiZ36setGmaku9M
         qEF9B+lejhDza2P7PvqXHEP8/nFE2jR1957w65ECx1qZ9jm/w7ElOv/gs+nWoE3r3yRf
         DMEwgol51Wy5sH9vskHPYbmWWQon2iINRyaFVqk+oO96qtXe+7b2m2uTbk/RH7B+qf8d
         15yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740764122; x=1741368922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VEOHTT5bGWNRWFvPq36jSPYDFsBGCPSq40LhDAyjb0E=;
        b=FO2qEiSW5sg3/PXpuya7DC2LSQGTZmu1BasnnT2ahfHQGgFbWliDvQnJiHbTXbYVf9
         0HoQ4l4WsEEyp7Kh8ykKfLI+u4xN5enOvAvC8JPjLtvO586zVJZzMFMDXvCPnxz+njTQ
         FoywyjANzdjiufojydFONGxVI0vBOJAgFmZgsl0szQkzO6g5nq3KNxCVlnfdMLGmzQ1c
         kud/OnGwog1OOG79rLoeJyNJeR6b8UocOU/QbGtgti5Xrt47I9yYNqdVVlOBJFVh5xru
         sAFD40aF2EfSq7NF6tdI7QFQ5gfo1BxbLDxxUaewIu3HKkpc9vrOv0QvusIGYgKYOPBh
         tTIw==
X-Gm-Message-State: AOJu0YwN5GvqGsvX7blqEw13XhAafEvcZfnsuas7HH+rzBmepeWXQAdE
	mLqeGOnpzWyDB/dI073erNQYdufgu4WASqtzcCZgDuWsX10lo2k=
X-Gm-Gg: ASbGnctkVzXg1/O+oK0SWI3kqIZAhrUjBFc+gttF4mlz7CvR+aRladq1zpl0Gp10g95
	kfEod/F3vaXFJKJFbLTNWTLhMjjf7/521VldjF4YYZzdaEtopuK63Mh0ridaF+6x6fPAxBLQN70
	db9UYzcUrWYW1hArpz2uoboAAwONIBWWPpkZcyHFZRE+LPPA7L9ZnD1PYG3gYdFm56yTgW5W/vm
	qFvYxVNKCxsJV5O+6tTlbynE4oQOdcNzwYu0G46ePy+X6i1PYPj0JuQnKBT8RFYUvif/mCpiuXY
	odFoo5VFWafPcrswIbsvfgy8oA==
X-Google-Smtp-Source: AGHT+IFV9SnDvRoCDjln11BCo+xow7BQMR81+7dh9GK2AYRrZ1dCedUHi+zXa6ZSguSHC9eQcj6PAQ==
X-Received: by 2002:a05:600c:3c92:b0:439:9595:c8e8 with SMTP id 5b1f17b1804b1-43ba66f5474mr41160285e9.0.1740764121743;
        Fri, 28 Feb 2025 09:35:21 -0800 (PST)
Received: from phoenix.rocket.internal ([2a12:26c0:2201:9b02::14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b73717ac0sm61917775e9.20.2025.02.28.09.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 09:35:21 -0800 (PST)
From: Rui Salvaterra <rsalvaterra@gmail.com>
To: hkallweit1@gmail.com,
	nic_swsd@realtek.com
Cc: netdev@vger.kernel.org,
	Rui Salvaterra <rsalvaterra@gmail.com>
Subject: [PATCH] r8169: add support for 16K jumbo frames on RTL8125B
Date: Fri, 28 Feb 2025 17:30:31 +0000
Message-ID: <20250228173505.3636-1-rsalvaterra@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's supported, according to the specifications.

Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>
---

It's very likely that other RTL8125x devices also support 16K jumbo frames, but
I only have RTL8125B ones to test with. Additionally, I've only tested up to 12K
(my switch's limit).

 drivers/net/ethernet/realtek/r8169_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 5a5eba49c651..2d9fd2b70735 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -89,6 +89,7 @@
 #define JUMBO_6K	(6 * SZ_1K - VLAN_ETH_HLEN - ETH_FCS_LEN)
 #define JUMBO_7K	(7 * SZ_1K - VLAN_ETH_HLEN - ETH_FCS_LEN)
 #define JUMBO_9K	(9 * SZ_1K - VLAN_ETH_HLEN - ETH_FCS_LEN)
+#define JUMBO_16K	(16 * SZ_1K - VLAN_ETH_HLEN - ETH_FCS_LEN)
 
 static const struct {
 	const char *name;
@@ -5326,6 +5327,9 @@ static int rtl_jumbo_max(struct rtl8169_private *tp)
 	/* RTL8168c */
 	case RTL_GIGA_MAC_VER_18 ... RTL_GIGA_MAC_VER_24:
 		return JUMBO_6K;
+	/* RTL8125B */
+	case RTL_GIGA_MAC_VER_63:
+		return JUMBO_16K;
 	default:
 		return JUMBO_9K;
 	}
-- 
2.48.1


