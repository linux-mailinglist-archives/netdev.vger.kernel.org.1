Return-Path: <netdev+bounces-140539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C82D9B6DD2
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 21:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 211DD282D80
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 20:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2125216E18;
	Wed, 30 Oct 2024 20:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgucLx0h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99F71F4713;
	Wed, 30 Oct 2024 20:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730320661; cv=none; b=LwVrhoJn8fbM48AfnEkxiIWMLySNSwgHvtv6Y9YjSo1m+S3CYJcMcOKakoh6phdeR5uaCzw23/WLNBenxTi7YkOdjYuMCmti7WKclmSDpPQer8hsTKPH3o16oCz/WNn7L/iRWpREhAd+A9AhH4u0CtBEULCpIJSxj5KJJc27TE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730320661; c=relaxed/simple;
	bh=0SRoFqBcsDw85/QaKVA6EwGOPq1eSAenDqaeKxv/yfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LVCp3Dp1DWwk6KmEwQqIt3fYn6786xqTDDnfirGWjHgkdNr4zj/cskyeGgtO0Sl+wIEpsZ5GdIQDU0ayWdIUpacm+SpG87/p/xLzJQiwi8DIkxSLMGZw/uCLu/GEmj6xrhaiisvIHhDEAQ+BJcssXJy4Bc3OkhLEWGb5EKqGeBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgucLx0h; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20c803787abso2269775ad.0;
        Wed, 30 Oct 2024 13:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730320659; x=1730925459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5aBaoW4lFkmcmvYotmRAFRNfP1wDd/xzHaiUde4U+w=;
        b=JgucLx0h2UPAHxiQWRfWRn6bR5CBN7tZcNAfcrzGPw2CwEeGevCYR8IDNfmwNv1gz+
         /4TiPEl+pmAQW7BxtiMvfyzTyxrYQNSKif6dUG8O6R5Gk+JUj7ohSyue+xNc43ChsrbO
         dQm8rY+OlhmsNSwXh5vua46gQs+czur66z/byzeJcaua45J5p12Osn6cLQcrr++EE5/M
         L0vyFzEpiY3TGxkrAlZHxAW8uGwYtGYDtATKLp77NZ1pMdnki8cxpjmzll1x5MZYaAdB
         qwLWppFCeaUrGe3+K7lOjJyOBX4wxbQj9VXMwb69tLPv3dYpzSCeYsg8c3fW/3M7ev/U
         g4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730320659; x=1730925459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5aBaoW4lFkmcmvYotmRAFRNfP1wDd/xzHaiUde4U+w=;
        b=WLKmjEp+kz1W/xXbqa7V2vXrv4zqIyecWX3Kx63gseYUDhIOlnxp4Il+LGdH12pRio
         vBI4YSRsavpFni3Moz/rmLyHVylscOHgezvgh3ICOrq9Pn2r2PM6do6/J48YDU2oEMhV
         hHuBq31+VpnZW7nIx7INkDD248KnpOMtcLEObavM6Gh0q8rkyo85k2ppklbN+CrengTX
         OWAK6+2zAVUBeJpWEQBJ5E96e8L67DTOp4o7Ozln2oXDGucXakOQSaxmtrKBg7VUrV2I
         w3jYVPcGjTiU1GMT6iJvAcHlEDnYmlsZRIdY/le1lyQ+S8AOFKtBFOYhPJEFiK4gxypv
         py0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXVYhhGpw5jJ1ksv2msrDf5nmooq3CdpttZK3aIsLbmVtm5/nm600TmF81nq0E4v8dvSSbbQBkdvTvlX2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhnbzCwTwRdL0aW3sV6A3q/cmCLQq5qlDcyM4Y0xjQFkSSGbla
	ohpxaPPcT+ybCZ1E6AGsAMG5k9AL56tGQRpavI4N4Z7W2wWAo+1H1HGXObY7
X-Google-Smtp-Source: AGHT+IEslBPsWMVT3kfzLveckiZE/aUDHqe0JSGMATWwFGxenxaBxCHDrKRDl5uJf1tayeMUUJ+8zA==
X-Received: by 2002:a17:902:e88a:b0:20c:cd01:79ae with SMTP id d9443c01a7336-210f9043b2dmr58075525ad.24.1730320658853;
        Wed, 30 Oct 2024 13:37:38 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056ed85dsm40645ad.5.2024.10.30.13.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 13:37:38 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rosen Penev <rosenp@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 02/12] net: ibm: emac: tah: use devm for mutex_init
Date: Wed, 30 Oct 2024 13:37:17 -0700
Message-ID: <20241030203727.6039-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030203727.6039-1-rosenp@gmail.com>
References: <20241030203727.6039-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It seems that since inception, this driver never called mutex_destroy in
_remove. Use devm to handle this automatically.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/tah.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/emac/tah.c b/drivers/net/ethernet/ibm/emac/tah.c
index 267c23ec15d7..4b325505053b 100644
--- a/drivers/net/ethernet/ibm/emac/tah.c
+++ b/drivers/net/ethernet/ibm/emac/tah.c
@@ -90,13 +90,17 @@ static int tah_probe(struct platform_device *ofdev)
 	struct device_node *np = ofdev->dev.of_node;
 	struct tah_instance *dev;
 	struct resource regs;
+	int err;
 
 	dev = devm_kzalloc(&ofdev->dev, sizeof(struct tah_instance),
 			   GFP_KERNEL);
 	if (!dev)
 		return -ENOMEM;
 
-	mutex_init(&dev->lock);
+	err = devm_mutex_init(&ofdev->dev, &dev->lock);
+	if (err)
+		return err;
+
 	dev->ofdev = ofdev;
 
 	if (of_address_to_resource(np, 0, &regs)) {
-- 
2.47.0


