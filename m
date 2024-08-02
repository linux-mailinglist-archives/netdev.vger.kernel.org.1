Return-Path: <netdev+bounces-115259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B7E945A4F
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 10:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 219A81F22C4C
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 08:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480B91C3792;
	Fri,  2 Aug 2024 08:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="qMRdoGSz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5991C232D
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 08:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722588881; cv=none; b=oU20698zGl8nDhy23sTNzdO5O15URjXK9SSuoWNak/gThwBzmFPqJtyWYUU3NwxeypMvfzxu3M0mHf40TiH4AnNAvze9tQ/sbJu1UZefboLoJwJ6CKgNFUghkXLr3Yoccy7tO5lctxEZu2RYg5Wsa/9Uk+7OAx1evZJzIoXpgh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722588881; c=relaxed/simple;
	bh=2tLyiqy1c6Ec2RTwu+vRdI20odKLB1Ri2YZc3q6e9K8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F3CElWU+PCtqoLd90f27KFue6AtzTxnNyqf8oRnZQ7IMU3oAZek8Zpe1A2LLG6ppT3c0yhG0zZbW9p1g2/4zhGO3oH2Jz0bPrFYAh+ElkNXayPOBTKXiNnjAat42/XZE7ZQW4tjG3Np4gHDXr5f/UeY++7gHO+KgbbEDub0B9VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=qMRdoGSz; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ff1cd07f56so58659445ad.2
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 01:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1722588878; x=1723193678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aPPcJGChXzWxSKC37YDmT/lmJurXmaDRiVHFrLrBrv8=;
        b=qMRdoGSzQU/2K1rXtfR7NBAVYelVDhMqsk10zLRQWyVu6na0sESGWcDWkNz3R7t0pr
         GE3tnOJARZwnxr1SCD8W1dbywROZE2xAII48Vl5SIjAcfUGZ3kLmNCX9yf60zDr91VXw
         /xnDpKZMsCOhBr6mmriTp1lsLaaPASK172rQ0lz+0V9o4kZ1Y8zdbCnXjRnxT9N+0RFJ
         K+cqYZpV8kx7LHq6M4lll3u9dJnMtqq8Z66UEO0pUVPH7zz8mdqTgFJYO/1oWhiK1DhX
         snWttOXlxkIQXz6rWtuB7k+Wc//AjQPF8NVv/mGD1F6GZ7Y2eH6QnAdASwtnCfCoc7ut
         GiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722588878; x=1723193678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aPPcJGChXzWxSKC37YDmT/lmJurXmaDRiVHFrLrBrv8=;
        b=d4FV1oRBEOMzj66QtwlhfFzxBKX2X2kM5YHvpD41sO3sOyx7z3AVZUBd2fk6HtjhEc
         E+gH9qFxAZ9b8tHB7RMlKpcO2WV5ePMRi6qrT/EkcH3/mVESytH0C871IrlaJCBbc0O/
         Mi2u88VUvUaa6fftrhUj1qOuP7L88YgFKkx/IJ2JDtVjeQoXLXpcqyMQFvjOgkqx6z0b
         wFcrDfpxzZyWcovOGUpLmEP88ZwqL214lQOan9BB/Auf+eW/FM8G8pbp9MBgydKPBRpf
         W4QVbmZd5wAh1YzBlHIXE3ZlvBdEGOftBqVmqqOZt72WPm6kGpYsMcvzYG2bx2t5pNW9
         GTcA==
X-Gm-Message-State: AOJu0Yx7DW5YWadPNB/SWbX7VWUWMjhjzgOKpXHeSOSo0n6fsTarYWs9
	fovacKiY0eFIsUeXItDb64wZTIE4F5lniYc/Vh96gRMLbxerR5++yAcDMlWpEno=
X-Google-Smtp-Source: AGHT+IHik8xxOwOlBOeNsvN8UIni6eltN2TUYBce+ba9KYk4mfZ3W/xy1fXgAFr5UXlgHVmDpZLxZw==
X-Received: by 2002:a17:903:2441:b0:1fb:8890:16b4 with SMTP id d9443c01a7336-1ff573c4f57mr35694665ad.48.1722588878419;
        Fri, 02 Aug 2024 01:54:38 -0700 (PDT)
Received: from localhost.localdomain ([2001:f70:2520:9500:7232:5bec:f586:e017])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f29d88sm12075985ad.8.2024.08.02.01.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 01:54:38 -0700 (PDT)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: [PATCH] net: dsa: bcm_sf2: Fix a possible memory leak in bcm_sf2_mdio_register()
Date: Fri,  2 Aug 2024 17:54:11 +0900
Message-Id: <20240802085411.3549034-1-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bcm_sf2_mdio_register() calls of_phy_find_device() and then
phy_device_remove() in a loop to remove existing PHY devices.
of_phy_find_device() eventually calls bus_find_device(), which calls
get_device() on the returned struct device * to increment the refcount.
The current implementation does not decrement the refcount, which causes
memory leak.

This commit adds the missing phy_device_free() call to decrement the
refcount via put_device() to balance the refcount.

Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
 drivers/net/dsa/bcm_sf2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index ed1e6560df25..0e663ec0c12a 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -675,8 +675,10 @@ static int bcm_sf2_mdio_register(struct dsa_switch *ds)
 			of_remove_property(child, prop);
 
 		phydev = of_phy_find_device(child);
-		if (phydev)
+		if (phydev) {
 			phy_device_remove(phydev);
+			phy_device_free(phydev);
+		}
 	}
 
 	err = mdiobus_register(priv->user_mii_bus);
-- 
2.34.1


