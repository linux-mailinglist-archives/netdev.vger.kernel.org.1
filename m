Return-Path: <netdev+bounces-210412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A0BB13277
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 01:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61EAB1891461
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 23:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF341F542A;
	Sun, 27 Jul 2025 23:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVZPCtHm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8507483;
	Sun, 27 Jul 2025 23:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753658275; cv=none; b=rCyA25oYaZhmc0VzJ0xwzKB+lo7FxAQBUS6uphO7P6hs5E6B6/eLpVD96zYFS/Xp3wOvy8y/o5521Q/yYdpniG/k0G08vuOwXYZsJX2depi3m1eR6WRNSEVtVyTs8P8MvNPv1uwary8oovrkUrMeUTVcwzOxTokbAfvsWAgFNvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753658275; c=relaxed/simple;
	bh=+7OGdLC999MX/UyGSWp7RbHOj1r+Wnjm0uJqbefECec=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U+iBCDySSFhA806/U4KfKQzTjLnAAxp3IygbuxpH7kwskIWn3potkW/MsXTbcf/n/Jx1vZ+4MTtoKzO/NB1ecLTSUwlRd2T11jFt/V5QE/ozIWMqdiGF1/Y88t34CZHkFoTuDXn3JsHWKzd99OtnBICaxjjsaJOO5WhtPf0MXV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVZPCtHm; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-75ce8f8a3cdso2405770b3a.0;
        Sun, 27 Jul 2025 16:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753658274; x=1754263074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CAgL+P6oosbyTvQVgEEGo+GzggVXDRApmnRdu6jgmv4=;
        b=PVZPCtHmcpZOpB9drAoXmWfrOC+AAdWXlrbGiR1uLR2s9elFQG2jG0lDp7S9v9XXUp
         losGmMThe5DTKfOeujL8sMaXlPmpPGB3iYGw64EyFPuYc9sRhxR6rgZU7wQaCp4zXaMV
         9svE+RieAnjMkBrlELPzjgj95kyOGcMbmlCUGFz6SjS79Zad+5RFddlZ1hIbee5ZuRS9
         K4q4PwcnMd1P95H68JU87uVQI/jSDN/YidfxDTa7HFGH73aJCnvauXof0KfldkWsxb4A
         HR+EGyoYbue7xNMeNYUWyuI7RzTkVi/u3sBUWSzUO0AhttbEmU5fBwBIAunJ4RL15Ta6
         X7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753658274; x=1754263074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CAgL+P6oosbyTvQVgEEGo+GzggVXDRApmnRdu6jgmv4=;
        b=GmRgyOvYkR4UmVNF9/vFyckvizJdNQRB/GZG0QTQGnCqk/A7xqeDEWbJsWEV4pgkGH
         14KnZWro2RrNCxKWxnIhXj3H25It2AFRnIMNah8P6uTiE2i62l0MMK9V03Cm1v2i1XtB
         4JfpZRe6wNBgLrXpN+u8Z80+gE+p25qi4Ox3dW7OKgA0NGQ+Ar3FWhxGISUXGQE8o23C
         AGKlUX+rBrF0m92naEfIWvKVXyAYE0yrEYXEXvCPrVclnBNrHofSlfIB5Z2tl0s0T6mE
         vYF30gurCsTAarZJdA5f3PTAgCpFwkjqq0z9Gyn0bqikj67QJVnOhJAUzG9ntfCN4b9y
         7mnw==
X-Forwarded-Encrypted: i=1; AJvYcCVeyo8HHbijt4+lz2Yj5wx+ao4SKEaSxKluDaFwCrrDgJ2i+Ve/lhKOmYVBq7JFaaQZv7A9rUwo@vger.kernel.org, AJvYcCX2aU2tL+IT6m1Auk6OtigbEUwoXXXCZr87VObZWhfN9rxM0v46jwG/yLHeagibm0Ne+YBdM6EPc6SKgiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyRmt2q3kUVNc6Jzvuu9E+JbBMUdccHDkdPsjsXUD+/eOupqr6
	6dm3RsTN5nQloOedLqJSsKZ/vL2S2zA72MJzv5Nx6RXoxlhqxRYcG7a1
X-Gm-Gg: ASbGncsTe60UlhX/knscDXqiQkbA+JgiRxf3oHU7xUuuCMATC7CCdCnXblQMiH6Zjsw
	b/k4ibVzTQ8FUOj3IBDOjUVbS/LqmbIhpL4CtZlRzWKkMv5UZ/tmO6CwBd15PCdPzFfK8EqsLxM
	6cwYgbVrO9gsshn5QI6R4w8GyV7DSgUBOn1WwEVLoCQxogRoNK77H8CBVLWxp7nkOYCaxKelkiD
	bTzLYJ2Z3qYhqCroBi+jIX0o9y7h2mwNF6qqiBGcWiOouPNMm/zC75CUsgwLIqol0PkHUspgvhH
	jxpUUG6rbmcd+R0eA2WjxnkP2RI/us23DKWG5ZqT8GypNYwLgOm3UVfxu65AGUlmwRq/mE2gxjD
	yLs8cWzvZhZ552LCQpYorJYSmuJEfzPY=
X-Google-Smtp-Source: AGHT+IFrag9otWTEPqlMI3765jD98T2uc+rLc+q6j8vE6viAvqn44FVlMznEsoHpBGacrs7PjJglOQ==
X-Received: by 2002:a05:6a00:3d07:b0:748:de24:1ad4 with SMTP id d2e1a72fcca58-76338ba7567mr13048727b3a.17.1753658273667;
        Sun, 27 Jul 2025 16:17:53 -0700 (PDT)
Received: from localhost.localdomain ([167.220.100.18])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-767668ba533sm1520385b3a.3.2025.07.27.16.17.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 27 Jul 2025 16:17:53 -0700 (PDT)
From: Tian <27392025k@gmail.com>
To: irusskikh@marvell.com,
	netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	tian <27392025k@gmail.com>
Subject: [PATCH] net: atlantic: fix overwritten return value in Aquantia driver
Date: Sun, 27 Jul 2025 16:17:50 -0700
Message-Id: <20250727231750.25626-1-27392025k@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: tian <27392025k@gmail.com>

In hw_atl_utils.c and hw_atl_utils_fw2x.c, a return value is set and then
immediately overwritten by another call, which causes the original result
to be lost. This may hide errors that should be returned to the caller.

This patch fixes the logic to preserve the intended return values.

Signed-off-by: tian <27392025k@gmail.com>
---
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c  | 2 +-
 .../net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils_fw2x.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c
index 7e88d7234b14..372f30e296ec 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c
@@ -492,7 +492,7 @@ static int hw_atl_utils_init_ucp(struct aq_hw_s *self,
 					self, self->mbox_addr,
 					self->mbox_addr != 0U,
 					1000U, 10000U);
-	err = readx_poll_timeout_atomic(aq_fw1x_rpc_get, self,
+	err |= readx_poll_timeout_atomic(aq_fw1x_rpc_get, self,
 					self->rpc_addr,
 					self->rpc_addr != 0U,
 					1000U, 100000U);
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils_fw2x.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils_fw2x.c
index 4d4cfbc91e19..45b7720fd49e 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils_fw2x.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils_fw2x.c
@@ -102,12 +102,12 @@ static int aq_fw2x_init(struct aq_hw_s *self)
 					self->mbox_addr != 0U,
 					1000U, 10000U);
 
-	err = readx_poll_timeout_atomic(aq_fw2x_rpc_get,
+	err |= readx_poll_timeout_atomic(aq_fw2x_rpc_get,
 					self, self->rpc_addr,
 					self->rpc_addr != 0U,
 					1000U, 100000U);
 
-	err = aq_fw2x_settings_get(self, &self->settings_addr);
+	err |= aq_fw2x_settings_get(self, &self->settings_addr);
 
 	return err;
 }
-- 
2.39.5 (Apple Git-154)


