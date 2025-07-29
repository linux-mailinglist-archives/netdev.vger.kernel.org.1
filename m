Return-Path: <netdev+bounces-210693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBEEB1457F
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 02:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 103A4541297
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 00:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D24191F84;
	Tue, 29 Jul 2025 00:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5ZzXGnk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73D2188907;
	Tue, 29 Jul 2025 00:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753750741; cv=none; b=QxHcQEMeZnYiCxnFyfEDhnBvahQIdTzphZueUF7IVoxYXfw52nBvty+eHtnGPo9bkmUOpbqIYCCrkxGTeFhkDwP8a1SxcIjaOZ0iUaLesq47UXRxaRTmq5orhuZ9yZCWv0uKx/1I+Mw5+OClzdux0iR/ix8GwuTvkBCb5RMnUNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753750741; c=relaxed/simple;
	bh=3UxsRunM2OzZOQdhu8LG7c4qMq35SxnU8BhlQWIl1zw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LmcK0/MutaXYNbbrcpAU9VwMv5N9DwXuHVHrDMZjUnwDZfV1nXuMkeQgWFGQnKkn3dNFH86UOM8RU/aZ3KaDxO8Uv/SXX5x+Mz4L5KQJo/suI1ycB0Aq1Wz/ENJSK6Ym0gUkdwvkw6wQOyFYZXbgRAqzvQXDtIQQBC4YBiZxL/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5ZzXGnk; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2407235722bso354295ad.1;
        Mon, 28 Jul 2025 17:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753750739; x=1754355539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AtASNyLUF1p1yz0j1yNKcyuNg1Mz3fb/Stm9EAI71Fw=;
        b=i5ZzXGnkJ1xiu5a/vq39ucCCNw6egvCAadQpAjMKyq0ft+8M8YPMkqVW+EtIkZ0nZJ
         vkxLTF7gZvfrtnc4OkuTpm+BsfQ/4khinkaSXNKJ1I1vp0rM+rs2ZH02NAdY4Y3ASQFP
         wZ+5sH+iTfPIb3f88jFtX/thcVYn8quId3whsJVJvdmNqkCYVuMhMitYr28SGa91EXJp
         i++flN+IIq5SueQc/n/f9w77LZQJzKpU6+FVEnb32HbNBkzqIP9zAc/2o7e0cJSbskHO
         01bkzqYu9pksTrIeTcdh2OXwlOPPdX5rX2UDRqSjngKuyZPXENgfRsALqN7JROCbBKOC
         sG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753750739; x=1754355539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AtASNyLUF1p1yz0j1yNKcyuNg1Mz3fb/Stm9EAI71Fw=;
        b=MHw6FUEfHVy8+pUh1rdfRgz5+dRyCMxR/gBOMieZ+0g8S4AV9M0WRZqvi4uvtWKuxk
         stHJBmXQtBmwcGZ+rgVtb5xnRUon3mp0Gli0v4HjkUmgOYob/47SfipoDvhywWuXzt63
         EVZcITujS2BlxxhTjnmAeH/xWhhrPnGSsyy80QI91VClPoNA+/jbmYPIU8xToBVJWjIj
         QwbJ/9uRqKUPP+Z+7IdyUqBKuMiV7sSJuirLpH5PL8KHhyxB/q0b6URZyaVPGHQaMXbl
         1lU1Va7kEo4zjDyXNUBSsU/xiXA9/eO6M5ZlnGmZwd0McMT2/ZSQalegUHq6jDq2rPW2
         rKHg==
X-Forwarded-Encrypted: i=1; AJvYcCW7JmOS6iZ+anjBprUSrkd/SA2Jk9x8RUhR0VUGGSsJr1mugF5CEGkBG2hWURc1z8+StAhS9rZbqHuGFs4=@vger.kernel.org, AJvYcCWnSn7uebr8xiWWttEHhl0tPXm7I25Wv+T0zpdWl/gdniPZrfPFKPERRKxtkFMNKgQlWRprPHbk@vger.kernel.org
X-Gm-Message-State: AOJu0YxDQhIMzei7gP0dQZOcvUAJVO8Si8f3XHV77//MQiqdD2MbfE2M
	bRXgFDCXZAokhcq7uwCVykejEKyxvAXZR973T6oIQsJ2lBCDKbTu8iX9
X-Gm-Gg: ASbGncv3vq394BKZBOkG6iZhf4B7qVLswEdfIqtm2C9FSIpuvSCegoPFWgAcwyh/mbu
	d8VkElOr8IY3qa7C1+4TyRfyEAxiLMxhz5EONUTdegVmvm2ONH05x65zre25zsmwe81doWvZlYd
	xzFaHx0tyZJ9WKX+79XkfYPK0akfKK37Ox+mPiSlRT6NHksA4Y4ZJOQkApC2FJ7OqtPYCK0IS2H
	9vzp9wufnhwwKqzaMtU1eb6L1rU6o14E0llM1Ogok+fPN+o6PYgK8QOvAisKf+eBx88p6EUoZlr
	hs8xo9XgYH4z6RA+8UjPC+gJXHDXgGK97KcqX5oi95H4PmXCblelUp5Neui77I8oFrN4cVAO90D
	JuuWgk4CCNMnhcEc735phVNlufQ6izg==
X-Google-Smtp-Source: AGHT+IF9Bg5Zu6y7fipgjdm6LdUgCbn/A61A3xzqctG8DkrRyCRfIRoNve1QivpmfSghCbmfMWDwpw==
X-Received: by 2002:a17:903:246:b0:235:ed01:18cd with SMTP id d9443c01a7336-23fb317ae95mr183311175ad.44.1753750738940;
        Mon, 28 Jul 2025 17:58:58 -0700 (PDT)
Received: from localhost.localdomain ([131.107.8.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24011bc0b00sm37348865ad.69.2025.07.28.17.58.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Jul 2025 17:58:58 -0700 (PDT)
From: Tian <27392025k@gmail.com>
To: irusskikh@marvell.com,
	netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Tian Liu <27392025k@gmail.com>
Subject: [PATCH net v2] net: atlantic: fix overwritten return value in Aquantia driver
Date: Mon, 28 Jul 2025 17:58:52 -0700
Message-Id: <20250729005853.33130-1-27392025k@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tian Liu <27392025k@gmail.com>

In hw_atl_utils.c and hw_atl_utils_fw2x.c, a return value is first assigned
to `err`, but then later calls overwrite it unconditionally. As a result,
any earlier failure is lost if the later call succeeds. This may cause the
driver to proceed when it should have stopped.

This patch uses `err |=` instead of assignment, so that any earlier error
is preserved even if later calls succeed. This is safe because all involved
functions return standard negative error codes (e.g. -EIO, -ETIMEDOUT, etc).
OR-ing such values does not convert them into success, and preserves the
indication that an error occurred.

Fixes: 6a7f2277313b4 ("net: aquantia: replace AQ_HW_WAIT_FOR with readx_poll_timeout_atomic")

Signed-off-by: Tian Liu <27392025k@gmail.com>

Changes in v2:
- Add full name in Signed-off-by
- Update subject to include [PATCH net v2]
- Add Fixes: tag
- Expand commit message to explain why OR-ing errors is safe

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


