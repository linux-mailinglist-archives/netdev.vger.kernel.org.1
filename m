Return-Path: <netdev+bounces-194836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 472C8ACCE62
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 22:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F066189121F
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 20:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310DD224B01;
	Tue,  3 Jun 2025 20:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2+53Fn9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A41221F31;
	Tue,  3 Jun 2025 20:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748983750; cv=none; b=XufwDOieye2scnX1XcO7EXgY/RYIMqnB25uU5vz+pvz1lCcs3s5MlthhordKW4fh0k+gfxd+ldRu/q176YP60HMAKdxH+9fgwaU0qh0rRu2lYu1ko2+oJvWFr3jSGfBXikh5tXWo94arJbPL6/3fsWtYaoxBM/J4hmAi3P42MWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748983750; c=relaxed/simple;
	bh=bLdRTIaXhaS74UWomOCqZxJGucm8brlKdCwRnDtbXt8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P2wOQVrruq/LvLDBKnXYySHIPSbdYWd2t6aaG3noxJygdj86bh5nXikxiEitXqKpepXIKtggNqORhDoAo3VfpeXll3N3XnSv3xjtoP08IosYxyFt7qwW67cOY2Ih4aN2MySHerqtEQNGtI4mOeeygsq2hcYzCbrn4Has0hFuKoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2+53Fn9; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-441ab63a415so67346415e9.3;
        Tue, 03 Jun 2025 13:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748983746; x=1749588546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6veEb/KWAhbZcVIjM6zW31T3gcz+Ugy3LtpGhiCo/hE=;
        b=M2+53Fn9jLcEcy77o0TYOvLWslNCswYF+94+sDdlTuYz+0wzoo0N//yFF7bWoH0tAx
         z25f2so57I3l/RRx1/U1xlhvRmKh6Rzs9T+krvTSmtHBMmQvTjj9/nCPveQDDgqJwDVM
         nIcT/vrmbNbDuIiOjJRRL9W0w94LrAMkom4A6IiH+37spjqAMOTP1ai+R06XQ8c8GDeD
         bncxvH96+WEw0tRdfFbpIhF1cemK/FLmt3iyCutU2w50Y2ORhlXuR9/3PHhexAU6oMYW
         lgwohDA1Q0atWMu9zn55gOJ6ANen2TpczebffSKSBGZMiEUHGVxQiYjq4khEhNagSwO2
         Z+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748983746; x=1749588546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6veEb/KWAhbZcVIjM6zW31T3gcz+Ugy3LtpGhiCo/hE=;
        b=Wn5KoaW4BBtvBfQXAt5Kn4zity3ioNR0apVPFZuFUl6g+Knrl3hPasgtT/Msfi65D1
         SUGTF+e2af6cNeCCdmAbu7nAgZt0Mx5KyDkGBUxYAmILRCKt/bQ8o9vJfWmJ4ArP6yid
         jT1N/WbUUGifZIx4/NZaR36ykd0LsRX7z8H+DMqzkUUkf2b4UXcr/uB39qhR1tvfjrDo
         J2YSh32SbG7zVDLncNMWrcevsvCJHuEXScDgRGRtWKshxm7WB0s+vxMSTguDkcslzxOE
         UNCSDrV4hScRlp6cLVK3UcZXJqWV8pNiL7By+gnBn8J054VmIE+OtFOGDSJ1cg6Bp12L
         Einw==
X-Forwarded-Encrypted: i=1; AJvYcCVfmmHHtAZOQ8KIUQyRZtMvE4sNCnrT6y9n2W2rSrgNI3yNy4OXodsl/vyTV9JYnnYjS/x5LVlY@vger.kernel.org, AJvYcCWtj/2QcYINnkAJLkDP+8faLcHiLnP/d8FjQFOmp1DSozQGGP5bTKnkUNAanNbpb2XPSn0vXuQuqvyxsb8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3tjF4/DpbCph5FOSDBYkva0LxvzlUvoTfWU1239RDwsQXj7Lh
	qWS5CE0Qp71V7uVBOftavzbi3OuL4z32wNtjToz2fC6gSYb8mDo7x5Fa
X-Gm-Gg: ASbGncsDL09NhNbAEmr5/uc/71DR9OrjzVmTHYwtArkCewsKJCgJoPuGU2fUV+dslDq
	gs/MYS+vj3NDOrFqJLfpKzXeoWGSfXu3xlB6jiB2qa/qjrIWHNonDpmwL9FpkBrRHHwfU4v2R7R
	eDamJ/OT95Rfm+PjT1w6z0wq8TLULIdsm0RRyH4T6Czx17WqK1bMSNvMD0pZc3W45LFK1EGEN9l
	FvPTFQjn/XQD6l4NRLXLZIbLM/iwpQ0F1RM6hrd7eQJsZFYbY2IuacIwq0NdPWjQfXsReaATGeE
	To+YUK9vTbwBWNYkuZxeNoZ8P1rGw42BBHNqHzI3cjyzSUXrUxyscYTG5R0IVwLms36aAIiL4NU
	+V+cSiypAiyX3MWSBW59Wmd72vf7mdjhfKaSEm9bSxaO1JFwvm0/H
X-Google-Smtp-Source: AGHT+IE6EeQhG2oVrPlF9Ndqe3xtMBUoMmticZC935ob8iZom3JHsUGpc45T6lYCyebDP3AMe5cSgA==
X-Received: by 2002:a05:600c:1e8b:b0:43d:fa59:af97 with SMTP id 5b1f17b1804b1-451f0b45248mr1079835e9.32.1748983746302;
        Tue, 03 Jun 2025 13:49:06 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-1500-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1500::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451e58c348asm26258225e9.3.2025.06.03.13.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 13:49:05 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: jonas.gorski@gmail.com,
	florian.fainelli@broadcom.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vivien.didelot@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dgcbueu@gmail.com
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [RFC PATCH net-next v2 02/10] net: dsa: b53: prevent FAST_AGE access on BCM5325
Date: Tue,  3 Jun 2025 22:48:50 +0200
Message-Id: <20250603204858.72402-3-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250603204858.72402-1-noltari@gmail.com>
References: <20250603204858.72402-1-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

BCM5325 doesn't implement FAST_AGE registers so we should avoid reading or
writing them.

Fixes: 967dd82ffc52 ("net: dsa: b53: Add support for Broadcom RoboSwitch")
Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 9 +++++++++
 1 file changed, 9 insertions(+)

 v2: no changes.

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index feea531732c7b..525306193f80e 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -486,6 +486,9 @@ static int b53_flush_arl(struct b53_device *dev, u8 mask)
 {
 	unsigned int i;
 
+	if (is5325(dev))
+		return 0;
+
 	b53_write8(dev, B53_CTRL_PAGE, B53_FAST_AGE_CTRL,
 		   FAST_AGE_DONE | FAST_AGE_DYNAMIC | mask);
 
@@ -510,6 +513,9 @@ static int b53_flush_arl(struct b53_device *dev, u8 mask)
 
 static int b53_fast_age_port(struct b53_device *dev, int port)
 {
+	if (is5325(dev))
+		return 0;
+
 	b53_write8(dev, B53_CTRL_PAGE, B53_FAST_AGE_PORT_CTRL, port);
 
 	return b53_flush_arl(dev, FAST_AGE_PORT);
@@ -517,6 +523,9 @@ static int b53_fast_age_port(struct b53_device *dev, int port)
 
 static int b53_fast_age_vlan(struct b53_device *dev, u16 vid)
 {
+	if (is5325(dev))
+		return 0;
+
 	b53_write16(dev, B53_CTRL_PAGE, B53_FAST_AGE_VID_CTRL, vid);
 
 	return b53_flush_arl(dev, FAST_AGE_VLAN);
-- 
2.39.5


