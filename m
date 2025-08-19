Return-Path: <netdev+bounces-215019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5394B2C9E5
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 18:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B46A3BC539
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 16:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD7F27B339;
	Tue, 19 Aug 2025 16:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdAGqD37"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BE3239E97;
	Tue, 19 Aug 2025 16:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755621719; cv=none; b=M06m4USYphvDFEufKAzaas0aWF+Uu7kSM8IpUR0eOgdNmAqhfusZ3yfCJneqrZu1SCtKqOKdr2R5+f3LMrtumcn3JLP1TDyItixJChlxo/L8ITGs+Lr8A96LRxTn+MElM02aRY/lxpTQobx/1JWuEz8Lbl56Roo12iBjpdmz9jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755621719; c=relaxed/simple;
	bh=L7ugk3c1F3aDLxjFmQfYDrLIX5ahouOMrY9nZZ75gTY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kiEzz1wDSxBnvdWXLRSHYPJyZ6QDsW4fFnC0Mx2b//UIRB55gBG1r6/YbrDfvj9nIi2vRA/z9HLEH83WfPFP8hJu+iM2H3JbIS+noltIZJM6E0NFOtwGg4vmz5BX9duEOp6/x77yJtyhl0zuUeWX8fJV+naO/LnzBoFTCV8iNQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdAGqD37; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45a1b0b2d21so28162015e9.2;
        Tue, 19 Aug 2025 09:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755621716; x=1756226516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uZw1E4DMHu+wuT12JHvmjEskbRTAPP0SSVwBlWFdfHo=;
        b=PdAGqD37wTuiGoAl5ikZF0epI4R/kx2M/Fz0SpcrWZRtX4fhm7/oDgGzvCcNKqLxlx
         KCMgO2HpbbIkw6stO9u4Ghs4vqGk7F4UnrYb3XuF17ABnbMM7/flFWV6g5dBu/+3Kbu7
         lcqREM9Oqkbg8pqePCW5HIyJoWefChb8lqteki9dQ7s8vvsh6QmCkr27TQpdiERUW8s/
         l6C/G4W4ZfR1ECBfFUckeT9oQVKxnUVIaiD0NgFGD/hCIy2YTxOvWGcGK5nc6CQDog9f
         5ldy/QsXd9owDarEczS9U89BZf+3IkjYOO848xkg8cq9q0kASH9ox1HxzpclQ9XKoWp3
         GrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755621716; x=1756226516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uZw1E4DMHu+wuT12JHvmjEskbRTAPP0SSVwBlWFdfHo=;
        b=YArsNu/T5nc0tj1AHx5y6KOWcuJwc6BIVZB0i6m8eRgTlSEe8KcgsJ9yyuP2d49s/i
         n7OZMC80B1WYmAJ4cF+BwdhDhzjTt5VAJODus5zK1R/m3P4FxVeidd6GmjYwsxVfHra2
         bVAbmklSFrD6SL0rpeljNFO96a034ZOzPC4/R2jIZLit338mvaU/6RltLzWbOTdXgnTw
         eUvuJ/BOUgs6wkr8sBJuICBUIyZcVZ4Jjt4PajwtleDBsEhBuKWk4miEpcRx2wRTYJUT
         1ODlVCsrjFh4/7ExNY+E61QXHxHXQHU2UY+snztoxm6d1jBVQV+P67y7A9uEzwFIfjV6
         kUXg==
X-Forwarded-Encrypted: i=1; AJvYcCV44vZ2Hoirp1viDZEpRVkjAg+5TkM+06Rjuzd87XZ9gpFVSuUG1LWxWhFoALEmkcSUVBRs9mt0jMGbrus=@vger.kernel.org, AJvYcCXNCR+1NLMLBatmIje3fMmYDenOA+z9qjDstR0eWckO77H5uyBsZOgClVqFvzrInbcjfbVaLvcT@vger.kernel.org
X-Gm-Message-State: AOJu0YwlxYINgCKHOYx7Ztu8g8YMNvm8RhSpfAxtIL62t0EH2P4Bcb5z
	8mcyt8OqZxM9FQ6UldmmjXEVtqywG4PlGLhvqiczpIsNm9OOrIqIH/q7
X-Gm-Gg: ASbGnctK/+f/jAQBZwWoGlbXEiWP2VG91Fs0KfM3pqXGpNCYxSba9KTw+RzbcLdyxjR
	o0FVAKcSJ6xAfsgVT6kVpoZ/PC8MYal9de6WosGeLxEW8SIKiwLqBqq9p6p8FkjGiij656peZVS
	OKtFc5wckICkqPw1xRKFYYNUGOoE+4mGaq2ku4zF2YxA51LgRNSk1qnq6fswx/4uM+kEgr+cZy4
	g5r3ATAuGzPlfH5MJzvkCQ0u1DznxhhQC9UPlH6xpH/H6CF6IhgYAvQ6iE+y7EcG81nuzZgEDF1
	wyuVCCjHSAZ+KMOZHcm1pnp6wqUfqWzkXxxVjawLtQnBUem/gCPNAsK48ayrxMUONgunnKPlY7S
	5quianSaFhJDqmjEgB3cwegehuk+rzt2yUhgeRNGjqE3WnFq/BVCp9WgxEIVpEWHSqGpzN2JSOK
	3Y
X-Google-Smtp-Source: AGHT+IHATRzTh5hpiVP2m8ujpz9WjIuf/HH/J5JNRybLTBTI3JYmuRDomRjMwNN6zxOOvHHnnNM+UQ==
X-Received: by 2002:a05:600c:4e86:b0:458:ba04:fe6d with SMTP id 5b1f17b1804b1-45b43dc105bmr24505065e9.14.1755621715304;
        Tue, 19 Aug 2025 09:41:55 -0700 (PDT)
Received: from Ansuel-XPS24.lan (host-95-251-209-58.retail.telecomitalia.it. [95.251.209.58])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45b42a8f972sm51494015e9.20.2025.08.19.09.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 09:41:54 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH 1/2] net: phy: introduce phy_id_compare_vendor() PHY ID helper
Date: Tue, 19 Aug 2025 18:41:40 +0200
Message-ID: <20250819164146.1675395-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce phy_id_compare_vendor() PHY ID helper to compare a PHY ID with
the PHY ID Vendor using the generic PHY ID Vendor mask.

While at it also rework the PHY_ID_MATCH macro and move the mask to
dedicated define so that PHY driver can make use of the mask if needed.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 include/linux/phy.h | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 74c1bcf64b3c..173567b86617 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1260,9 +1260,13 @@ struct phy_driver {
 #define to_phy_driver(d) container_of_const(to_mdio_common_driver(d),		\
 				      struct phy_driver, mdiodrv)
 
-#define PHY_ID_MATCH_EXACT(id) .phy_id = (id), .phy_id_mask = GENMASK(31, 0)
-#define PHY_ID_MATCH_MODEL(id) .phy_id = (id), .phy_id_mask = GENMASK(31, 4)
-#define PHY_ID_MATCH_VENDOR(id) .phy_id = (id), .phy_id_mask = GENMASK(31, 10)
+#define PHY_ID_MATCH_EXTACT_MASK GENMASK(31, 0)
+#define PHY_ID_MATCH_MODEL_MASK GENMASK(31, 4)
+#define PHY_ID_MATCH_VENDOR_MASK GENMASK(31, 10)
+
+#define PHY_ID_MATCH_EXACT(id) .phy_id = (id), .phy_id_mask = PHY_ID_MATCH_EXTACT_MASK
+#define PHY_ID_MATCH_MODEL(id) .phy_id = (id), .phy_id_mask = PHY_ID_MATCH_MODEL_MASK
+#define PHY_ID_MATCH_VENDOR(id) .phy_id = (id), .phy_id_mask = PHY_ID_MATCH_VENDOR_MASK
 
 /**
  * phy_id_compare - compare @id1 with @id2 taking account of @mask
@@ -1278,6 +1282,19 @@ static inline bool phy_id_compare(u32 id1, u32 id2, u32 mask)
 	return !((id1 ^ id2) & mask);
 }
 
+/**
+ * phy_id_compare_vendor - compare @id with @vendor mask
+ * @id: PHY ID
+ * @vendor: PHY Vendor mask
+ *
+ * Return true if the bits from @id match @vendor using the
+ * generic PHY Vendor mask.
+ */
+static inline bool phy_id_compare_vendor(u32 id, u32 vendor_mask)
+{
+	return phy_id_compare(id, vendor_mask, PHY_ID_MATCH_VENDOR_MASK);
+}
+
 /**
  * phydev_id_compare - compare @id with the PHY's Clause 22 ID
  * @phydev: the PHY device
-- 
2.50.0


