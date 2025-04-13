Return-Path: <netdev+bounces-181967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55656A8721C
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 15:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4AE57AAD8A
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 13:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B9D1C5D56;
	Sun, 13 Apr 2025 13:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoZMtsGP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7915D1B3935;
	Sun, 13 Apr 2025 13:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744550863; cv=none; b=IDvkhRPvUEZaoPTXBXgT2rqjiro+IvpEJePmt1TD90HIssUUB/GtOOzijTCpcvwo3kQ45jD1eieJbhFGqvrF/7ma0cR4RSv27hDVFTsMVQuQYZQmhvnAbnkFwMZvyeD6/PdQK+IsDyWWsqJe3G+1Gk066dneJlMwzbaA8vbxifo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744550863; c=relaxed/simple;
	bh=N9wz+htBUt4Thh9mmvTOacndIanMl47AV5Ka9WyAOfI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k7xQT57Ij0ok0L9BpqXQVVga2z4jpOFKSoDa3gsBOwzrsi8rgPRKsl143tGpYVK4WEQ5B+KmNrvX/0NPHAXF+hX0A6fuPzhLwQAuRh9IrJl5Z9vhs3vrAEThQHe811hDPuG9wSW8WqoDAP9ktxIr8Ero6aAI86Lki6Yo0i7DcZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HoZMtsGP; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-af548cb1f83so3346161a12.3;
        Sun, 13 Apr 2025 06:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744550861; x=1745155661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VUFOZwO8sYK8u3NtVjSug2/K/KZv864HSmO704e9cyc=;
        b=HoZMtsGPXcTS4VzSPFqD+3ATlJV102qD+lRZv8K9zf+2S5cUzX0Zhwy0nIplr3sU4p
         lTNVbjqiiT6IUiZlrOV8nlgyEyI5IdWS6SmOTAw3U7zkHZ70Rgw1oXt9MpyKH7YeLiP/
         yo4y9b7lvrnyoIuBViUim5UOyGLCVPzkUqQlic1SJUa26E3vsfmICyUjymLvWRc7Ia4K
         vC3s0lztnUcLIfYNmVfU/REYgpZ+2IlycYUP4z2OjXXWHw1CU+B633RgZ+/p6XpqsonA
         BQx0lXbQiIzMW0zGP29SjCE8tOCtAQhtRd8Lah7G2ecOnsTbo1OA/xhrF+M2dgdInUNg
         7IZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744550861; x=1745155661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VUFOZwO8sYK8u3NtVjSug2/K/KZv864HSmO704e9cyc=;
        b=q04VjFYqfLUPf+U9c2bJLSVL/hSnDK9nXn7sj0WIcTz1QN/orP3cinjBK/ZK3rKlG5
         oWY+UUk8RUX6lP7QBd2HU7CUwh+H6AE0avKEjlVxKN74yQUftwct04NhcToGmb9srOiP
         b9J8UfDergZh8w8SzGtFkgKu+FoXcf/RQl8omtQkInKqOoMeNO+T744NzwF2qxR67t4W
         kszOclV+ydvfEgtYrklw+DkFAYv5l/RplMSZJXExCdS6JqH5pLxO7WssoACsdfkbt0hw
         5uUnPfQ9vtNH6ODjcpRwtyFCdmHrjAuxf2t096ENYnLwiV4ShliIvQB5glRUjJBLxWtH
         K6Xg==
X-Forwarded-Encrypted: i=1; AJvYcCU8biPzEMH5whFb9wObyXEpGLYhK4FrYAmizTEKIpSVdDJ17SCwcFwpmE26dXLGsc6rXaeOQWr73ECLU5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcrD4m7QEl3wxQO80UTmxqUv8ugL8Y5n31QGLnIAkwX8tjfim+
	zt9bykxsuZnkpC8yhZAqf5v9ERKnCvxBk0a3cxpwm2t4oJvG1sVPGtzU7HSJ
X-Gm-Gg: ASbGncslT+rTwzSp7MKwMH6dC+nxNCfDRBYCqi/eakB3S2BrWHFJDdDMVl7Bdanvg2/
	8pIjRuMYjnEXg8KENWcyX7VneWYI1CswfKeLt1i+L/H4mBFq6SdSjvqQbUW2BSi4AXit4ulmefU
	s4QieZaDFpB+9tVV+ZmS2uyaFOaeSR2IIwMp+wtWOXqIwuk2tlRW3ewC1OSMcEregx1bel483WC
	wK9eHzNepkoMTov4hULoBgPN9tj5UUrH2lQqFKFQdRGMn7U2uQ9LpfK7FN6KSkUaehF5twj+Al4
	AZ7+jhgj686ZAQdQhL6Yj4+0VQ8PFSPCLgPgQ9HhAg==
X-Google-Smtp-Source: AGHT+IHxbcWo1FTTXAgI3HFx91ZVRvshyhwCRu6RXyvWTmtL1auRMlOouKG6UIBCLdQj1Ywu6mv3jw==
X-Received: by 2002:a17:903:244d:b0:227:e74a:a063 with SMTP id d9443c01a7336-22bea4ff4f1mr115965765ad.37.1744550860597;
        Sun, 13 Apr 2025 06:27:40 -0700 (PDT)
Received: from hh.localdomain ([222.247.199.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b65a6dsm82416755ad.4.2025.04.13.06.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 06:27:40 -0700 (PDT)
From: hhtracer@gmail.com
X-Google-Original-From: huhai@kylinos.cn
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	huhai <huhai@kylinos.cn>
Subject: [PATCH] net: phy: Fix return value when when !CONFIG_PHYLIB
Date: Sun, 13 Apr 2025 21:28:11 +0800
Message-Id: <20250413132811.5601-1-huhai@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: huhai <huhai@kylinos.cn>

Many call sites of get_phy_device() and fwnode_get_phy_node(), such as
sfp_sm_probe_phy(), phylink_fwnode_phy_connect(), etc., rely on IS_ERR()
to check for errors in the returned pointer.

Furthermore, the implementations of get_phy_device() and
fwnode_get_phy_node() themselves use ERR_PTR() to return error codes.

Therefore, when CONFIG_PHYLIB is disabled, returning NULL is incorrect,
as this would bypass IS_ERR() checks and may lead to NULL pointer
dereference.

Returning ERR_PTR(-ENXIO) is the correct and consistent way to indicate
that PHY support is not available, and it avoids such issues.

Signed-off-by: huhai <huhai@kylinos.cn>
---
 include/linux/phy.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index a2bfae80c449..be299c572d73 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1787,13 +1787,13 @@ static inline struct phy_device *device_phy_find_device(struct device *dev)
 static inline
 struct fwnode_handle *fwnode_get_phy_node(struct fwnode_handle *fwnode)
 {
-	return NULL;
+	return ERR_PTR(-ENXIO);
 }
 
 static inline
 struct phy_device *get_phy_device(struct mii_bus *bus, int addr, bool is_c45)
 {
-	return NULL;
+	return ERR_PTR(-ENXIO);
 }
 
 static inline int phy_device_register(struct phy_device *phy)
-- 
2.25.1


