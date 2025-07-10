Return-Path: <netdev+bounces-205927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA1EB00D52
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 22:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44E3E5C4A54
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 20:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A1B2FEE25;
	Thu, 10 Jul 2025 20:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MN51Q/qm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73A62FE38C
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 20:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752180042; cv=none; b=OAZunlWJTFH57TzBlRPyZx1kTU7l3pKE3BNoo1IdUqAxwF2MUzOS89QXb81A4ap1f0Z6zv5La4Em0tuA1EMpttZ67vwQ0zDy0lNbzeIevWd7ivfWood1+hnykIZfRPqcwA/LtvlhOjprSbrrayBULn3mpMLA2MlPbcHv59gxu6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752180042; c=relaxed/simple;
	bh=tOmWsDZjXYZrX79WZwFa0/xfJfwpMatxUje6IdXWfuQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVQJaavD0rAQDHT++fwu2nNEsuRq4CzNt+TNJlUs1JPDZBHZEwWTrNtgVzQu2egovKAamIvSnhQiN21MwQXSN5cu44aZbQxVSNklNRydziERfJTb3ORIu3MSbTLayyWSsT/SPYGKv7cnDRQtxzIp5Qr2Sn269r3+Vy7S35dMuCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MN51Q/qm; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2366e5e4dbaso20962655ad.1
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 13:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752180040; x=1752784840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VO38fcy2IGM6LD63a6glaKdz4VebB+XyShXWwatjXNM=;
        b=MN51Q/qmf6/gb1YjBdBeYLgW22utI4SLv0lR6hEpYlB7KX+Isydf/BQ50C1ZelakjH
         y2P/9kDmWDZlwritTpEERx171v13EkvQOGyctnNWF63g38AetKV0OVkmeE0XlJi5JQ8o
         7W3h8OAz51cd/gZkdEuy2e/9X/2khBYJq+4g+Q8UYS/4QNi2fpFj0oXwKOpehwIVcjVH
         R/JK6kCYiIPJei4YwsdLVbF/zBfoDSdnQ89QzEWQ09IyJWkC34bP7TFEbqY0SKefIhr8
         sYKj48bdUNraeosxmLkKt9/ePtgJrIDIf7mVbOOqJeoHgtS4nymuVsX4MPsllDg/ht9c
         QUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752180040; x=1752784840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VO38fcy2IGM6LD63a6glaKdz4VebB+XyShXWwatjXNM=;
        b=nwhIowTCMreD4qGC+iPh9chXkJbyzRoDxEfdsa9nvqb3iz7Wql6Hbcm77pkSLK2s5T
         uY2upN6xQxzYLYKzHETk4vDXcGwX9UuJgYy0etUq4Y1t6/ojCADGYd86asm+etKNTDJU
         ZiF3xyQTvo8I4MCCYPQs/csBgYOzhukarTsiLrWwuM83PAYorMULo3tY45liBVL2sMNT
         If7UFLqs72V9pMur7UrIlPcBFrN+cXg6hCLDWmmjCAQ08A3SO9gzvObw25nNS7415Zgi
         G8vexJ8iWyZtRmty9GVxXljJbSgzqi1eZcwux0yIYl7c0rVhEemhnAPYaW4vWdkZPNoU
         vKBQ==
X-Gm-Message-State: AOJu0YwsArp8ugwt6sx88DND2di8VEaHCJoBpgvynUchseQWRsp/NNhc
	77PvIVEeWvYYEV3F2zbnN9N/LvBIkCANbLbMJwm/jQSd8MyK4iQRdFiYgmDN8q66
X-Gm-Gg: ASbGncuG2MZtiFmXZ+GXwE4NQWOfwV5jal+SIjvLoYKHz5BpYeyIeSAaGbzdWHpfa9u
	f2iJUtJEjpOj4NA/AAfyuPearHm/Rwnmulwu2241lK0M8MObLWYND32jis0AXo12u1Kj9NQZsJP
	XlRu+9/J8tgAubk0ltMx2xvONu149TkGIh15GlMwQZOvQd3DHgwMm/HqgjMxK9vv6Qpu1jFJlho
	p2WvtKhphyWDAiS/9E+cecLR5MQguUc35n2epbU1kSgEiDQ6dQNSq/GpDM3jrycmBT8D9176o1F
	WobJ8sb9BRm9SvadVrzSnFd89InIFnlaixNckna7ckWzYyn2x1L+z2wT0eS9SigKbUK8TCB7m8y
	xFts=
X-Google-Smtp-Source: AGHT+IE/b6ZrZGckGZJfWQ4sE3aG48d3iKY6s72U2oAaesTMCCNHjygKa4UZaHRdLQ0wtI3i/JM/9w==
X-Received: by 2002:a17:902:e745:b0:235:e1d6:2ac0 with SMTP id d9443c01a7336-23de300830fmr67948655ad.24.1752180039913;
        Thu, 10 Jul 2025 13:40:39 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3eb7f4d7sm3547861a91.46.2025.07.10.13.40.39
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 13:40:39 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next 08/11] net: gianfar: assign ofdev to priv struct
Date: Thu, 10 Jul 2025 13:40:29 -0700
Message-ID: <20250710204032.650152-9-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250710204032.650152-1-rosenp@gmail.com>
References: <20250710204032.650152-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is done in probe but not of_init. This will be used for further
devm conversions.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/freescale/gianfar.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index 53839dfc5e7a..2e9971ae475e 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -678,6 +678,8 @@ static int gfar_of_init(struct platform_device *ofdev, struct net_device **pdev)
 
 	priv = netdev_priv(dev);
 	priv->ndev = dev;
+	priv->ofdev = ofdev;
+	priv->dev = &ofdev->dev;
 
 	priv->mode = mode;
 
-- 
2.50.0


