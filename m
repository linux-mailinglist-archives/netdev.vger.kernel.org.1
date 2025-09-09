Return-Path: <netdev+bounces-221399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5495B5070B
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 22:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 863D93B65B4
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 20:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB63532A3CF;
	Tue,  9 Sep 2025 20:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNHfDlbx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2093D2F747B;
	Tue,  9 Sep 2025 20:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757449715; cv=none; b=qp7TBn2egbxz3Gvw2na+BoUQzMGkG9T+qSUp0PGz+QPA19ms04cDqDcZS7fFLpIPZ9srrSEPlMt7Kkevpe5KXqeurssyQ/vd7qbbk3P7mfrbj54bOP6EtKtCPBzbhhucBx45J7a7FJYNznqr/mlPZEuH0zDcrujXlu5R8qD9waY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757449715; c=relaxed/simple;
	bh=tD0+0ZYpsqsbc3fFT8l4+ZcUtMzM3K0vkSTOzW61kR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OCa3BdBUQsvR1Tn7VVXBEN5mkhNsWLwF8GKeZ0pyjeG+YJsjx5I/6n3B4xCuzXGodoDXSQwLsVXWpX+sU/zy50nlGDO4txZJe10HxTUbwGLYNRAVl/dyrOVHJOP8dtT7S0Eog7QnitgTRjhAWhHyHManmYo9//JbuQ57vkeurwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNHfDlbx; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45de1084868so16656485e9.2;
        Tue, 09 Sep 2025 13:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757449712; x=1758054512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CbMix5+DWmyUggOh0OF3R/1SnFjy31jtsOG4VomZp/Q=;
        b=UNHfDlbxs38SV/4pkMUvwSI7DKQVHkUgfNoTMCeZnWzly1QYP/sO/mVcuIW1CG6B+L
         6zQcezXiDlAKHH2t2z7qNzYy2ib8x5Wxk+xEw6KD7BAzffVbY28BNSgaPM+VDt7OlpAU
         JUZrJQTyAgiaC0/KY/8ifOemk3o7tjiJ5oNVgtWv1ChSzdGSURQyPEDyowChcYHgP53x
         SUYMYfHWoqr/sf+pK9Zql4tFSvZ7MlNEFTc04oCqAWcdxOcY83WMhpDdvoh0sz5L9FvL
         z8dxkGHNTAKVUqHN7GThtto2L5J87vsqTPCSpvdnM9SRa3bZFn8wazHFOuq+7ZZ+7bqY
         U7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757449712; x=1758054512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CbMix5+DWmyUggOh0OF3R/1SnFjy31jtsOG4VomZp/Q=;
        b=mtP3Pa/EIVtap1xXIKLR/NRflDdD44CKQre44Hp9gWvwm82DIyazxQ+8Cc+WIH+EQi
         YdRu4K8fbqVh5UbhTO1Mfa5N7zYKlqZ1etTdpNIK7ASXr9iJvaa4EF/4vP/ZPSGS8noO
         P9u1h3qEGaZyOozr/LpJM3uy5gY25eg6lalL0peVu7So6Y3H/A09wz3/JRtzFUxG+mJu
         VYabvO/fbJhMmvl3aoq6Wgdu2ekCPEjauOTovELMxFZtqtb32dY6uYgDhMspWLnfF6uf
         x04GPrYly1s2p9FCAP9xYPl3i2oN0IaUFqZakDZcvHT+vUCZ56+ziXo/BdPqVs1UF1Yf
         apMQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+qH75EYA34Z4TXdHSZvNiWPHMBIajbXvPFXRrzx5JfW8dbubb5hfVkNzJ5pa6A2m0ebiB/S6Z@vger.kernel.org, AJvYcCXt+yPNmhReW18ms1ckfh+/2+vu1mkjcynNb4Ryiq1b4F+KZetTwxFOp4X70KfAkQ5ebCRMFDI5P+pJJSc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0luQi8Ec/J9Hc1+aFKBSlmTDWXyfPoCNj1Pp8UPhSQTR+UPc1
	KzycJnH1BGrZI76Fep8heKldpaDr5k3n7jD6QBA+f0Y0UJKq6BmRtqlW
X-Gm-Gg: ASbGncv8kOPcG7z87NPcRN/yNFRal6JAPdVgAcGHuDEC/PG0C/uV3FJGJdnaQ2hjjwK
	Mw6Asmddg248/nfbwK9krf1oECShhM0wOgukYpqpHjiFPQW5pJca6h8qxeuqdI8kXu7LZHPs1ZL
	lA74DTch6Tbi4xiDh2tMSErX8Waogfll1SEXnHzdZmC4q9plYt+QMSj9CLzIPsS68crWCXv6f/5
	MO1L2Old5xXasNVmKw6dHUfAAzum8We5sJvp670Vr67LIiSrC+bNWpx21DHjdL63nJqBAdePFOb
	Q+FSQNDy2u/L6hacvQExBHuyZYKVn9KdbxArCVye8eAvPEegYdTnpA5tiNDxh2+Vib+nybQkJHx
	Zn8XFj8UnK26xQpuZ5Y+76hwEH35IgK0aKIuF+QORtdK8r7yuPY+MNhFOHbI8LOcQqa7/jhNh0h
	ipE641dg==
X-Google-Smtp-Source: AGHT+IFIpfEneAcAsyfbb4BXzh3CEpaqYBQuBJbMIsuK17THKtbrKlS7oMo1g1RExw28vNrALhIe+w==
X-Received: by 2002:a05:6000:2288:b0:3d8:afc6:e8f8 with SMTP id ffacd0b85a97d-3e642214be7mr9580305f8f.2.1757449712236;
        Tue, 09 Sep 2025 13:28:32 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3e7521be57esm3895842f8f.2.2025.09.09.13.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 13:28:31 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH 1/3] net: phy: introduce phy_id_compare_model() PHY ID helper
Date: Tue,  9 Sep 2025 22:28:10 +0200
Message-ID: <20250909202818.26479-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to phy_id_compare_vendor(), introduce the equivalent
phy_id_compare_model() helper for the generic PHY ID Model mask.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 include/linux/phy.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 04553419adc3..6adf7c5a91c2 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1308,6 +1308,19 @@ static inline bool phy_id_compare_vendor(u32 id, u32 vendor_mask)
 	return phy_id_compare(id, vendor_mask, PHY_ID_MATCH_VENDOR_MASK);
 }
 
+/**
+ * phy_id_compare_model - compare @id with @model mask
+ * @id: PHY ID
+ * @vendor_mask: PHY Model mask
+ *
+ * Return: true if the bits from @id match @model using the
+ *	   generic PHY Model mask.
+ */
+static inline bool phy_id_compare_model(u32 id, u32 model_mask)
+{
+	return phy_id_compare(id, model_mask, PHY_ID_MATCH_MODEL_MASK);
+}
+
 /**
  * phydev_id_compare - compare @id with the PHY's Clause 22 ID
  * @phydev: the PHY device
-- 
2.51.0


