Return-Path: <netdev+bounces-173724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D691BA5B5D7
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 02:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8744B1890DBE
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 01:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE0D1DF252;
	Tue, 11 Mar 2025 01:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjQiePPY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B37DA923;
	Tue, 11 Mar 2025 01:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741656441; cv=none; b=mfkg6vlEi8Ak7tC9r8HkDfQZTavBRp7a8IECbhHQlmuWb/Jf1ZCY1UE8rGXBcw9D4Iciyjj3zkyNiKQXgzVpaNAoLtC61H0hBkPvt6RmOOFalU/MZtuZ3EShcjy3x3CF/QBbCEfa6zo+sjIjNVpRJDnMB0hTKyho9vQXFalX3+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741656441; c=relaxed/simple;
	bh=ht9scaUwYIWY/isuqrXAqzg0A5wR6NjSNdeQzdpWLP4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aHHJ/2c6V5pncq7tuvOTMjQCroGPM+mvwMNgfwpN5EGmscTfjvaGt8c7/lRGWkRq8GKj22ysUaEKT/qO4hFHHZePKqIscVs6DPA7BHhwE0KQvzSB70qNxL1+eNyrD/Zs6lLH0NTX4sBi9yNudnpOVfeBVQ0wmrG7ZdsDOBYNOpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KjQiePPY; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c0ca5e6d45so60938085a.3;
        Mon, 10 Mar 2025 18:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741656439; x=1742261239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mYu4oax/thewz4e+p/abSxr+bcjcos4iMdBqH/7SF5g=;
        b=KjQiePPYX4PrudbXPwGHsevGCJQ0cDci9pldlxpbs2NL2TRYoQ1spxbZ1LhZJ6LOP6
         OtQnONB0J/1gHJLywaF/IIMkJ4xVlE8obS6Fxu7pf2BThuLcS0yrbih8hMlL8a6r0glu
         VPFrOekY6nfSsgD6jBfacUVrYs4PIpOMB4WxKejrm+4NSbAIiTEwGDdDMZq49BZRV+/1
         Jd2FrFRREbGkdBTHaPJhjX1aHFYpKdwwB+RMqdwD7jBGNZMVVxKPrJNjGlv7M33RycLR
         TsGsb3eqGgb8E4gKf6IOnPvFvhQj74seTj8m2y5yoZubRdt9uQlZY4u+Ntaq80JKFQ9x
         mmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741656439; x=1742261239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mYu4oax/thewz4e+p/abSxr+bcjcos4iMdBqH/7SF5g=;
        b=jddfyyCPH08XC98xFNVgEBag+rEIrGmxh7EshkFh0lIhb/AZp1q2k0BRDcjAEHulHf
         YUZ53lwRRt/LQzyqDk5l/0+6U9Xyjs7d81wEY32Hc47gEAfUOFNE3dV08Wkmi4TcX6Ib
         7KuipRsAy0Jr01DfJL9IzYncndjmRyxszNjIWpCMuAAf794PwCyRe1Q4vxKBdRoQp5Rn
         V16jrDY2VDXbOUNY0wwmXEYPpFCSiSiZ+itvX2/yhpp8fWn1jSofSATQrJGzMRbfC5z3
         rgfoPOLzCifFFfhggBZ+pTjP96pcxjXPVAsmhjj3IUCXAFzcrfJnhsNury6j6EL03Llj
         Mo6g==
X-Forwarded-Encrypted: i=1; AJvYcCV1zlstLYQIArZHYFkG6CsHhoW1SRccUFDjwbg74VX9zvetXfmXXp35OPsH3DS7SP0m+jQH0TiGv6UEz3Q=@vger.kernel.org, AJvYcCW6ZNO5mfvnbbBgykNq4nxG60clieU35rCQZDrKWmbOU60d+t380bOznU/81aaMo0JRBZgL+ckQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/3ehcXXkbHyo2/M5QWE097EKugZCXFQPGVvtCTWoiCLb04qBm
	6wQSTJ4gSLCs2JIVRkquhS+6cyVefAiFEmMtHvJcAE8j59Zz3zw=
X-Gm-Gg: ASbGncuwB5uECbwMqdpt6OxBdBCM1pmFcmsJZIq9ySYB0nQybrZC7IE/BpdZRAgzaj0
	Ub2PC3OM4EllRUHxO7Op39hz3EmlomwUbQhHjeyicSY0ReMedVrJ9sdYuejmR3J7tnS8K+Si5eF
	gC7C9qLeD+KG37ZvcuM5VqbpRS4QtyWlmZbmIYP1BBG57cqDpxSEVjY2JXPThHmykOYJ2Qk52vb
	eaPBQysnlYIWUDdKbDDFPyrbkfSr/EWeO7HudV22NwI1G2+UtqwP9CTf30Wi90YBOrXJ48mDRZu
	GzD18d+6OjKZkMqGFoBkMj4d0Zu/FpDMz4AaMxsyNQ==
X-Google-Smtp-Source: AGHT+IG1lIg0zhgXXdip9xAmm17KRNm/AUw5DrBkAQ32s9Cq80PSZ7xrsQWtT87xxvnN7LcqufT+vA==
X-Received: by 2002:a05:6214:d06:b0:6e8:f645:2639 with SMTP id 6a1803df08f44-6ea2dd1e540mr10215056d6.5.1741656438961;
        Mon, 10 Mar 2025 18:27:18 -0700 (PDT)
Received: from ise-alpha.. ([2620:0:e00:550a:642:1aff:fee8:511b])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f70a2dd6sm65178346d6.61.2025.03.10.18.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 18:27:17 -0700 (PDT)
From: Chenyuan Yang <chenyuan0y@gmail.com>
To: gregkh@linuxfoundation.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au
Cc: linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Chenyuan Yang <chenyuan0y@gmail.com>
Subject: [PATCH] usb: gadget: aspeed: Add NULL pointer check in ast_vhub_init_dev()
Date: Mon, 10 Mar 2025 20:27:05 -0500
Message-Id: <20250311012705.1233829-1-chenyuan0y@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable d->name, returned by devm_kasprintf(), could be NULL.
A pointer check is added to prevent potential NULL pointer dereference.
This is similar to the fix in commit 3027e7b15b02
("ice: Fix some null pointer dereference issues in ice_ptp.c").

This issue is found by our static analysis tool

Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
---
 drivers/usb/gadget/udc/aspeed-vhub/dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/dev.c b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
index 573109ca5b79..a09f72772e6e 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
@@ -548,6 +548,9 @@ int ast_vhub_init_dev(struct ast_vhub *vhub, unsigned int idx)
 	d->vhub = vhub;
 	d->index = idx;
 	d->name = devm_kasprintf(parent, GFP_KERNEL, "port%d", idx+1);
+	if (!d->name)
+		return -ENOMEM;
+
 	d->regs = vhub->regs + 0x100 + 0x10 * idx;
 
 	ast_vhub_init_ep0(vhub, &d->ep0, d);
-- 
2.34.1


