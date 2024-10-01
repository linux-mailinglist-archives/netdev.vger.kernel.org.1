Return-Path: <netdev+bounces-130988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1315F98C562
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 20:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C089A1F245CF
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 18:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84A11CEE8D;
	Tue,  1 Oct 2024 18:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/QY98Dv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E30F1CDA36;
	Tue,  1 Oct 2024 18:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727807368; cv=none; b=SlbH6iy/wMiD5xTzhNN/7kg9/aIWSZr+mul3kmAdsVGXPXqofr966NR1ZnX3YgKmN3W42OOg/LvThUoZoQ32igZjN4v2s8XctajO0pdc/QOZpsZyJvxujweykSoRRgBYalZXuRAWiqv3ck79DPizakGlz/k6vyF1PSiIr81xmRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727807368; c=relaxed/simple;
	bh=O1JnaGDR92Hsq5CghCDvAJY6RbxyyGAsCKoBXpIV9w0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YdlZUAOtiQrsL3E10Tf8JCnoEfiHfjHuvnYU00rJ00S7nzFIMnUZoMpIx4QUXTYqf6n/T61Xyo99koP5IFaQQlir8Rg96mMJ3+dAHu7FeX/HElly/mmW2RVWwGF2/Z2VxO6sVGu8IBm9upjX05A3jxP5MsmHfJ/K9Mql3IDrbDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/QY98Dv; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71b070ff24dso5229451b3a.2;
        Tue, 01 Oct 2024 11:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727807366; x=1728412166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/ZUwxmusPDGmPf3q3AUKBZNi8n/O0xq8YxGYUSv+QE=;
        b=d/QY98DvRvDcoP8WuWUyIDbGsnjW9nsq7b9ShJuEz5DgU27cdEFwTFZh0RJqHmnS6e
         +0SFCyz797eAmEDNUUz3z1b2AmoxD1bceTzUtHl9WHrr5Btp8ctdvX13L4HwKdiDrrrD
         rhC4s8vsoK3QqYzkIxhA/aklLO9HM9WROoorYJSzaX8S1BvAkJdiEm0Favvft7SiA8Nj
         Q+aTYs0Dxt81TEmpnsaLpFbMH2ZjiI/wbhgiq234TDQg0NislLWB73H3KGOBU6WTOQWj
         rSVxiphv1vPpN10GnNE7urlIffVKHtT1FzPJzhyfIaZiFzNdgsmXZnmdlOFiwJrkpSqq
         9oXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727807366; x=1728412166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L/ZUwxmusPDGmPf3q3AUKBZNi8n/O0xq8YxGYUSv+QE=;
        b=FWisI5mkDoEp8hfdVQocvurFmVIeOf0utOOme2WXWMI0fJaMzLVIuGTKXR9yekTQzd
         CRMU4pEI+t2vBAXwjEhB6ybPPCssn7lGyiUJbYN5bl+HuR5TpSaPWsNVL8jioY+PSl/D
         OUrtqiZ2aTd7WgEzM1pmpKieCBFE6TL8Tl/7i5Tz64bIDwTnscziVj30U27FzKDi+UlC
         JlSeILt/cJ3yUwwJvJB2Nh2KhSF8WdzwB+zTEKCHKNQg3/mCTKNXxy9PRReBZXZ4js8g
         KqxSI+zsjLj1tveSkNq7HhZT6lOW503kFEhAmxMEhBmHUM8Fpql86xvAgj8wComzPz24
         P25w==
X-Forwarded-Encrypted: i=1; AJvYcCUe0JQHYNflxIZND7/NGRqsIAcG6Ec3vXeKNv4iuHHXiFkq4ZGozp/imw4lsNjdLpU69Es3wKKIevJTl6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJSXl2+i0X+6moN4HDyharSAYAOijhOc8ZAuzTaBu/RLWC4e3P
	FN74YzmOJW2ENi2lz0PXfcL2L92zjnITytszzeTTlxfuQQJkQIG2jUXOeYHA
X-Google-Smtp-Source: AGHT+IFTupHWxKat/ORC44dzuzBBNo5qnvcHZis8sog5Ylcm45A+gEGemYA/0Wf52E7U5ldQlAlByg==
X-Received: by 2002:a05:6a00:3cce:b0:719:2046:5d4f with SMTP id d2e1a72fcca58-71dc5d7157amr942077b3a.24.1727807366527;
        Tue, 01 Oct 2024 11:29:26 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26529d56sm8649467b3a.170.2024.10.01.11.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 11:29:26 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	steve.glendinning@shawell.net
Subject: [PATCHv2 net-next 6/9] net: smsc911x: remove debug stuff from _remove
Date: Tue,  1 Oct 2024 11:29:13 -0700
Message-ID: <20241001182916.122259-7-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241001182916.122259-1-rosenp@gmail.com>
References: <20241001182916.122259-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Not needed. Now only contains a single call to pm_runtime_disable.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/smsc/smsc911x.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smsc911x.c b/drivers/net/ethernet/smsc/smsc911x.c
index 4e0a277a5ee3..e757c5825620 100644
--- a/drivers/net/ethernet/smsc/smsc911x.c
+++ b/drivers/net/ethernet/smsc/smsc911x.c
@@ -2235,17 +2235,6 @@ static int smsc911x_init(struct net_device *dev)
 
 static void smsc911x_drv_remove(struct platform_device *pdev)
 {
-	struct net_device *dev;
-	struct smsc911x_data *pdata;
-
-	dev = platform_get_drvdata(pdev);
-	BUG_ON(!dev);
-	pdata = netdev_priv(dev);
-	BUG_ON(!pdata);
-	BUG_ON(!pdata->ioaddr);
-
-	SMSC_TRACE(pdata, ifdown, "Stopping driver");
-
 	pm_runtime_disable(&pdev->dev);
 }
 
-- 
2.46.2


