Return-Path: <netdev+bounces-222123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C952B53338
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 15:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46EEA5A4C42
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 13:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F260C2E8E17;
	Thu, 11 Sep 2025 13:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BY2aB+hs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381DE376F1
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 13:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757596137; cv=none; b=rYi1Xla3ogAk5ieKurj5sWD6QceMCB+moKo++RHA6eROhg6TAohIZP+/Lz2sSaAICgeUZLCcIe3e7wbdFWStGeI4ex5z5LTRsj5kLt9FhfrVM10xVbV41R2CK5lqVjfzeYNjEXpanAOgPGAJhWaIBjSuucKw60mEUse9EoEsq28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757596137; c=relaxed/simple;
	bh=6tu2GgRecX6mADSNiyvsCz3mmOGNrk1CUTa+72aUpfI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dFvJH3YgZNzl7BeZHBI1YT7RqwyZw2rDxAG29sM5sXntodHHwrr4/5P5Gos77FLck7r7AUnRt+amUUasK/hFGtBnaFrIi+RZQyrnBkR9/Eva67Fw2hfA8W68B+c/yfy/rmXH7UaTN61UpYx/oYP3h79U0UAsooT1jmV8TGKrrFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BY2aB+hs; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6228de280a4so1205515a12.2
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 06:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757596134; x=1758200934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NYfwO6IxQ0zU5483Ah3qwMr68UquIj+n1A2JlvNeSS8=;
        b=BY2aB+hsRNgDPDfOR20w0/PWsaPbF7EN7Ak7Cn7a4XnbI7+JySAW0J0RrbmaiTQxKI
         bZqOkF/e7GAel/2O8NUPhcPey7rCTebBRnWHFzf1ajEJPJ/ajJURY0ko9FJ+62j2iiVK
         /ow/jbkI6a0WTe5NtgtO9QgVLHGVDnhUlTxrZDiMUkhViwPFAwXBg5vF6ahodHcBgOCt
         VTJsCEsqk9F4RGoQ69iTSGZIXFby3gOmdciVujcXpavNp7lCqqIAkmE2M6AsVvEmHYLk
         H/PTdVH9YMUCDcwD63iqy9vsy9XCSaYaH02OF6dDpvS77fWXT8nw5tjDVds0/EYhGzpm
         ZFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757596134; x=1758200934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NYfwO6IxQ0zU5483Ah3qwMr68UquIj+n1A2JlvNeSS8=;
        b=KDOiTLI1MS2I1fg0K/q9hNWwSxke0Et0SGBIMVRVQJJfJYNvcjn1pX7PB9n6doVOJ5
         cOmotmsCkHWQGdcbB5efctDRag+t/vyLNv6xmc0RuDNwwhzPUuD+RhfF8b4xuT1PITvt
         CY1rUbH29RNtJ+jbJQJgXdPKHzAWiLLj7mv3LT7DIAMygM39xXUjZTM8nV6Qdb79QzZv
         Gnr/J7Eakr1hcjook75bNDkx5nQ9KmBBsLFecyub2vrgRL3IEpDdvZCLfIKRNtfi/EvC
         hBcT/94HjalCZMYrf7EHoY6OC0qF8dqUIJf78fw6AHUu7JjMoMEY3mXvSNydy6M/+6Il
         3N+g==
X-Forwarded-Encrypted: i=1; AJvYcCU9+ErulRHqLkOdUgmdjhJKkVfAcdY76dmA2iz8D2YUiEpP1UeYe2uY9pIhf5crXz+fSh35Xpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDe+nUQKrioADwioXCkDx15E6eCzW763OKjji4iDsRNTzN0auY
	1/juvPKJ/rqSc5ST0mcMdOtVsgtSQd+66RqY7I1BrtbeaZhQ0hNUhvn/
X-Gm-Gg: ASbGnctRdqLjq5FtXAG2gUBnujQfmyAZkM2vYZ8tkWBW4xr6DGPU0pmRkxTt9xgBW7A
	Be2J0jI1whZEjWisRbCIlo7Vy95IyC7To9l4Ot1H0h83hJN/TCD7F3cOb+93pX2tM89HbrdLzhc
	kK81d96vjG7hxHFPmiUiiPJXuCzkWJyjeOxTtfUSMbnLjMF6WT9bjGp2G8yfJzXW7KP98atccq1
	0t9eL7LJkfv1pAhoOeCVXsb9qG/z5DSjEQR9eeBZ/gNupD6jT9YlXGQlladdNKukdR0TIvto12t
	jyb/N1HGir2wy2lZ384FIme+uRud1hEsqQ13ZyzYugr6381A5qvSV7Z+qxy7YsDuyQ6WryGMyXX
	1y/1Ne1tO3gOMxzha+bVag96gJABc6l6VeSdtBrU7NeLiIlhjB98sxpP47GS32l4GUaKGWH56OU
	lg6DTwug==
X-Google-Smtp-Source: AGHT+IF1qK2NqhfPfnYI/pqLXo5VsNdOwjXB+8puBwtknztnJSi9VTru+UFZzNb+Q3zjKSsNmXtj+Q==
X-Received: by 2002:a05:6402:27d1:b0:627:9d08:97a6 with SMTP id 4fb4d7f45d1cf-6279d089899mr13990549a12.18.1757596134332;
        Thu, 11 Sep 2025 06:08:54 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-62ec33f3b16sm1133038a12.24.2025.09.11.06.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 06:08:53 -0700 (PDT)
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
Subject: [net-next PATCH v2 1/3] net: phy: introduce phy_id_compare_model() PHY ID helper
Date: Thu, 11 Sep 2025 15:08:31 +0200
Message-ID: <20250911130840.23569-1-ansuelsmth@gmail.com>
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

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v2:
- Add review tag
- Fix copy-paste error in vendor_mask -> model_mask

 include/linux/phy.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 04553419adc3..6f3b25cb7f4e 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1308,6 +1308,19 @@ static inline bool phy_id_compare_vendor(u32 id, u32 vendor_mask)
 	return phy_id_compare(id, vendor_mask, PHY_ID_MATCH_VENDOR_MASK);
 }
 
+/**
+ * phy_id_compare_model - compare @id with @model mask
+ * @id: PHY ID
+ * @model_mask: PHY Model mask
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


