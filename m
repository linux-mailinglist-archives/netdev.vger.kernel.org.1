Return-Path: <netdev+bounces-178610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54494A77CAD
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 15:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D265316AC64
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 13:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D942046BF;
	Tue,  1 Apr 2025 13:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iST4EujV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860DE202C43;
	Tue,  1 Apr 2025 13:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743515361; cv=none; b=kenWqJzvwipXgXFP41c5rNSxVhgBjEzLPktwS/nK7bPAq72ObNqdsuiTdOyk/W+JVazK0c1PtyNUq1dGEQkNG71BogAuFV0IgNp7zp+5b29MvQWSOLjp+TKtsT7/t2eLzQcktEBxWobRiIrAt+IHhux4Ear069tzAspUiyn1eiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743515361; c=relaxed/simple;
	bh=lTmvtAZFfM9uXdy/5V7cbp2eydMoTmaK/VFQFrqBxaM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LESJSn8PyXzZ1XtDL42kCnsR8gab+dwUKgOMKDPThFj9mCg/Z2H6YRqEQId1AMIpNlJ7Wbk16aLS6INn3aRGXklOZmB+B3MDpkD1sVnmJLCkJtyNwwvqs4akyfYZetezVJpC7z506GK5wGc4HVsDetUMBBqNBGEoHi+aTfnGQfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iST4EujV; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-22423adf751so102313115ad.2;
        Tue, 01 Apr 2025 06:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743515358; x=1744120158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3+q47wA2IEeOPKNJa5W5ktJHHXBcjtXz826Y0oM/YZc=;
        b=iST4EujVE+lvr8OOxmxulGpRDs+QJvjmHv4fQ58nF6IahFkP8r3PVwXXVZxcZcouUn
         RMzYqjVm3x49zX5sMjfN6vjkwrVEOMr8DlPdUkN20QOiVOY+OlNNUguWwGLwSsEpT0Dc
         nBHrmits1aONf1iz6jOOskHiqp3Ukqs2kEd23J/NJEcCxOImbgvDSI5A+OoU0Py6Csno
         BBwkuSJNxtURvmJfmDZD9xVk6rAoTUSVNBrPGden5SOX2ShYHpMc80oh6+/A7jYHU9ea
         eiyWXEeIIrW1GoPI4J7U77XNU0pA5gXfUsj4/aQOYvN2SxT0l6XE/pHc/6pZ/DrJP+yQ
         n1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743515358; x=1744120158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3+q47wA2IEeOPKNJa5W5ktJHHXBcjtXz826Y0oM/YZc=;
        b=i7L3/mDs72Z2gVP3GiDKIxt8lp0a8tn75EKqBEh8F79ZgIVF2+nUvwQhu4p3fiAuLo
         abs2EIBp5JK5i5lwyOLQmzvSgI6GmQCpvr0otXzww4i5/AsksVS6KiZM+eRqwXub0FSy
         uu3uxRRtMaTLp1NliXjG5jAzs8RN1aKRLya4DnFiA+O0ywMVtliJS5wH7LKyyZMVnLWY
         7EKayty/puDjnV5W9bZSfBbgwAcbFcgZx6uCLX7+9B/H/ugtqk7orqrrFYz1B1OrGpp8
         996NnKZdbTUjIGPgIpqiCwV73u+eVY4UdE6c4KyriQSrrfjd94Dmm0WqMqvbLwPgtd0j
         jMlw==
X-Forwarded-Encrypted: i=1; AJvYcCXgbgmNFqYEeqpcdJ/GfXZr3/6hJJ2A+aDpkJ5l/2RY4D3hDm7uznfI24xH5PrLpsNBp/w/8lgfMWgF8q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDSmfYrv5ZorOQxzaIqaGab0sAGEv/nkPPj29dZ71pNpXTpCk0
	vYQ5JqKKIfaxQuW/9Fy3qFT07oV/HCzZnaxGeUEunIz35VJPuki7
X-Gm-Gg: ASbGncu13qR8+85NpY/Mb32nnKnYBwtyOeFzb36qaeDM0neI571AhT2Q8a5gDw+5eol
	/sWkRDx0aKSJCNDOAKzStpADQBCvFR+zrtwUQ3ZMPTyylKyxKOBgjw0Z+aUzLid+T7KnNE4XId5
	C4TMpxMRyZ6gY06gTM8SuBGv/u1rljus4Mo9QUoXTsrk9tNNlgEa8rpdzrAJXq+XviOOMVWJIEG
	qypR7nMMzAlCIwVoA3e9DhfGN2jX88Whv1/zQRmTFguGuvNejZlpRDJ7X4iMWLTZNcKrM0p/SBR
	ruwpT4K/+hfaT7L/b+MuTiWy5sY2sbv/aLKK/XRcu1Mg/QYOZu0bvnAksQHfRNvO08o+QrI=
X-Google-Smtp-Source: AGHT+IFDuYQrB51/C/raCB2BuO/V6qNOIE/Zw48vTb0rNVKT36QdbUt5014p7SaKf9/1L5ughIF/5g==
X-Received: by 2002:a17:902:d486:b0:221:7eae:163b with SMTP id d9443c01a7336-2295c103f2dmr42994595ad.46.1743515357608;
        Tue, 01 Apr 2025 06:49:17 -0700 (PDT)
Received: from henry.localdomain ([111.202.148.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1f9584sm88076145ad.224.2025.04.01.06.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 06:49:17 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: m.grzeschik@pengutronix.de,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH v1] arcnet: Add NULL check in com20020pci_probe()
Date: Tue,  1 Apr 2025 21:49:03 +0800
Message-Id: <20250401134903.28462-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_kasprintf() returns NULL when memory allocation fails. Currently,
com20020pci_probe() does not check for this case, which results in a
NULL pointer dereference.

Add NULL check after devm_kasprintf() to prevent this issue.

Fixes: 6b17a597fc2f ("arcnet: restoring support for multiple Sohard Arcnet cards")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 drivers/net/arcnet/com20020-pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/arcnet/com20020-pci.c b/drivers/net/arcnet/com20020-pci.c
index c5e571ec94c9..65c6fab0e359 100644
--- a/drivers/net/arcnet/com20020-pci.c
+++ b/drivers/net/arcnet/com20020-pci.c
@@ -264,6 +264,13 @@ static int com20020pci_probe(struct pci_dev *pdev,
 							"pci:red:recon:%d-%d",
 							dev->dev_id, i);
 			card->recon_led.dev = &dev->dev;
+			if (!card->tx_led.default_trigger ||
+			    !card->tx_led.name ||
+			    !card->recon_led.default_trigger ||
+			    !card->recon_led.name) {
+				ret = -ENOMEM;
+				goto err_free_arcdev;
+			}
 
 			ret = devm_led_classdev_register(&pdev->dev, &card->tx_led);
 			if (ret)
-- 
2.34.1


