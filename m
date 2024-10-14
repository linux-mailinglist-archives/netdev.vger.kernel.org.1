Return-Path: <netdev+bounces-135315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4BE99D874
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 22:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C1D6B211FC
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 20:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F3115ECDF;
	Mon, 14 Oct 2024 20:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rashleigh-ca.20230601.gappssmtp.com header.i=@rashleigh-ca.20230601.gappssmtp.com header.b="KhE5h86F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FF5142E77
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 20:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728938630; cv=none; b=PaSc7b4J8COmcVnEJEMlkTXYOpyBlSKWUG0qQzsnAj3ryWrReWHnl4efS01r884s0MwJzGsKeNs+2xlOI5SL4gKrk5XvIEmC+t3klk/xme8blpHYSNOJhhag5+YIoz71vQOjQaIqocMVIKQQsdQM/L6HyiYos0YdCvFm1V+rmNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728938630; c=relaxed/simple;
	bh=v2CyZi665RDOaH0UnhdiIDWg6fQlNV7eFcv3BbyTsQc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jTDCYD4S+fG1eeiXs1JGkPO1OmclrqbSfM0fhj8MqhdtmnOVGFf8YL02+xov6vk7BLZORc1i4gmNCBB0SYzdgCGuHjuk7vRnOQ8n5ah6e5WNoJ5aqTb8vNSsgrbkZoGajqr0GCqarDELIsqjNOfazhK4tVwXzJEqCux8tRSCDRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rashleigh.ca; spf=none smtp.mailfrom=rashleigh.ca; dkim=pass (2048-bit key) header.d=rashleigh-ca.20230601.gappssmtp.com header.i=@rashleigh-ca.20230601.gappssmtp.com header.b=KhE5h86F; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rashleigh.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rashleigh.ca
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e592d7f6eso1271628b3a.3
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 13:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rashleigh-ca.20230601.gappssmtp.com; s=20230601; t=1728938628; x=1729543428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x0bZWepZSwRuV9+tfkRhsQNZh91Lb1j8hAZncGa7PbY=;
        b=KhE5h86FxjdRyqH/C0fVbM1vt0LDvvUPT2bFbDZ/LYhjI82L/AuAuI5Kg6/n/0R7bE
         BUzjIo9KentP9eIpi4t8qWZfNB2lzAAke9fxTNqdbwlFzVueRhLovJ83IRbP9hh5kVjv
         uf01b+DAYJ4gzYrOHUA+cec/DdpTKPT7L6jGxfLfO4qgrqETDr435zXAbFsMd3KMlyE5
         GeRy6Cgn6+AIqRSBlXe25FZW8nAg7A6jvxZkpnah1znXmYp+TyCyQYnEZpRH3C5/lGQQ
         vqYYyfmACQv4SN4ekf3HzEyZ+kdAI9Ka/oBZUXVIoOGhSQA5zJCgxzweRW7dwBUB2k9q
         qMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728938628; x=1729543428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x0bZWepZSwRuV9+tfkRhsQNZh91Lb1j8hAZncGa7PbY=;
        b=mlDZIaZcZdIG5XCvrZF5rIkOF+MGzbiKGDRhAYh0yrIIje44f3Nu3wH8lyVZ7OGh3+
         GKfUQEhHk+GZqKcmAS8KiPfHaJsGcnfvhaWzhxfEYQv5Atcn9txd7Lpe7h0VJB8R3ZK+
         qMmevBA+Vd7F4ljZIYJTWX3GI91i/mz9sXzWfA2yYW1yRFPtXU15g8kIRBseDi0y+h2X
         rFJIQ7RE+Z6mFkxjBHDqdPx2IAYXf4HDV7YogNLDgMF/arE2y6S9xWdkLeBfxF/vVTQh
         MVDR+YpP49Y5Jk3RVN3h3wJl4GLTGqnESpdtGoRB9wobw5pCDpUI3wYanLCKLH6U2GTD
         M+WA==
X-Gm-Message-State: AOJu0YxMjkJU124VMW04TLZC59KnrAZioEPOrcqGVDOf7HOouHjMITNh
	cmFiMKAlGRu/drbaoUfjl+DuN5aFYNzD9Un5yf2oydNkIv9FAl/HBAVFo7mBQJmKXSZ8ovdUU6P
	B
X-Google-Smtp-Source: AGHT+IHFRneeo2l7UZQRVSgZ1y1jVXeuHKGsDul3qFOpGsDOny8GiZe6t3FtzTvS2N38n7adPWQrYA==
X-Received: by 2002:a05:6a21:2d89:b0:1d7:11af:69 with SMTP id adf61e73a8af0-1d8c9699b1cmr15758644637.32.1728938628365;
        Mon, 14 Oct 2024 13:43:48 -0700 (PDT)
Received: from peter-MacBookAir.. ([2001:569:be2b:2100:89c8:f5a8:9f9d:9746])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e6550aa07sm2671801b3a.49.2024.10.14.13.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 13:43:48 -0700 (PDT)
From: Peter Rashleigh <peter@rashleigh.ca>
To: andrew@lunn.ch
Cc: netdev@vger.kernel.org,
	Peter Rashleigh <peter@rashleigh.ca>
Subject: [PATCH v2 net] net: dsa: mv88e6xxx: Fix the max_vid definition for the MV88E6361
Date: Mon, 14 Oct 2024 13:43:42 -0700
Message-Id: <20241014204342.5852-1-peter@rashleigh.ca>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the Marvell datasheet the 88E6361 has two VTU pages
(4k VIDs per page) so the max_vid should be 8191, not 4095.

In the current implementation mv88e6xxx_vtu_walk() gives unexpected
results because of this error. I verified that mv88e6xxx_vtu_walk()
works correctly on the MV88E6361 with this patch in place.

Fixes: 12899f299803 ("net: dsa: mv88e6xxx: enable support for 88E6361 switch")
Signed-off-by: Peter Rashleigh <peter@rashleigh.ca>

---
Changes since v1:
 - Update message to clarify why the change is needed
 - Remove changes to mv88e6393x_port_set_policy to a separate patch

 drivers/net/dsa/mv88e6xxx/chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 5b4e2ce5470d..284270a4ade1 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -6347,7 +6347,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.invalid_port_mask = BIT(1) | BIT(2) | BIT(8),
 		.num_internal_phys = 5,
 		.internal_phys_offset = 3,
-		.max_vid = 4095,
+		.max_vid = 8191,
 		.max_sid = 63,
 		.port_base_addr = 0x0,
 		.phy_base_addr = 0x0,

base-commit: d3d1556696c1a993eec54ac585fe5bf677e07474
-- 
2.34.1


