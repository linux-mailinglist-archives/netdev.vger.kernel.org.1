Return-Path: <netdev+bounces-206383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD57B02D07
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 23:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9123189E86B
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 21:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E212920DD48;
	Sat, 12 Jul 2025 21:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1OfQTIg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579761EB5D6
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 21:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752354280; cv=none; b=ltWhiiDPdzuYXO61MvOGkijc+W3k7uvvBDni38A5/JNLVbBDeClZiiVwxvCu/R+b98ycGVHceU1LyJvtIKule9M+Va7YVwzlUxu5vM9jiSi5YP9EQjCYwbmfJaTQt7RDzjhblN/QYx6qXEDuLaxH/ntKOg0EzhBJ+R654Lvtjs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752354280; c=relaxed/simple;
	bh=hzM4e9GQNPdul6p502bI30fon3cLoRt6GoNokcsR7Ds=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pi3Iz8MS3TudKfnRyaBpwj2Zk3PJE8w+4S4lRtx8fVTl8reKRlUVN+gjP37gixTsCJFb0no+W/3W8c1JyVhyS8aLYUQQIfoJUHulGvp3cOhpcSW0p5Fdwio8suADO6nHPSWad6D6Rg7HVwJ/vS7MJ4syX2LtquxcoJQWiL1wGEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1OfQTIg; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2350fc2591dso30964035ad.1
        for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 14:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752354278; x=1752959078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/7Yy54miT/gWfUHu8Cyu4CItLZigxgVN3p5H0HM5sD8=;
        b=H1OfQTIgKVtT6UrqnB5r778zR236oqbzzLMQ6UgA/AaDMXBi+3NFe0ldCkPj/QILpY
         r96d580LV+JkiziTHTPhzK3JMGsUqcZWVFkdH49UkRITnXfHcRupzoOWb1FN6y8w3Nh8
         r3iKPM85jPfSIvAo5h1KZCvdtxqSzan7HOgUVHBHi3Xmp8Eqd9L1CwQYPR9K/px/xvSV
         zb40tOu4WzgHWVdjy/W3TuaVqQGTsJtxSecWV6pk+43D7mOyMx2mFCM1Bwpye3uUGzfA
         1d7mroZPmrvFy6Cjr1aFmPUg1AjpbQKAPM56LkKApPGnASWYfdrX58iOyPlKiALByuJ8
         k0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752354278; x=1752959078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/7Yy54miT/gWfUHu8Cyu4CItLZigxgVN3p5H0HM5sD8=;
        b=HHvDnpfG9+AONXnGyPrBlWA5PqvHcaqgi9gZn5H7VGtW6ywvX5hVQnm9y00UPK7U0r
         qaqBZ9hO71jsp/+UurC5hq5oN/w/1EZuz0QFWAwVVMGJ0jnEVpjmwzRZGPiNZ4gxbxyT
         htfT2W+9pr5ec51lvKu1vPnXJYrV+STVirOaptl0w5Um17DiXEtM72zf/Tjo14M/ZBnA
         haoRAkzt3nNFAe0raIcA4pVlCGqg4VBKWPZQB2BjY3IOPEtRD1rhxYZXHVyj7s/CHfdd
         VTLbM8qYhss/DZQuyX3KnGwlRt5hzVTSNs8MrOZV7rX3CnoN/iyiYVCDl2P3n+2IVb50
         oMEg==
X-Gm-Message-State: AOJu0YwFJ53kFGkZftiEbPeYyBhv3ErBsjBWyQyEBak/4Fj7YgN+ie9J
	HZ5StqItsWg8FR/xJYRcO8r2nFWYFr6g6Om5Yd12GTwSkwq/yaspEPlandWXODPZ
X-Gm-Gg: ASbGnctmV6IxoixZplG1cNEi0RRo0l6OQ7lXwHxuU1sQLyNAMt3mjQQ16EeQ6Q38Qxd
	ex6gulcjDQoFplKIHhFvHrOtSgX1hwr3FZu8c1EYGLdgyEeFqpjBckwotT7+wwDQHD4S2qGSFoQ
	8MoZQxuBZgVPgEb+Tu5u77CpeV9AeUrvj5QiAIKt6ChGRYAftNn+1065m4HqZUkcky4kLud+sf5
	SvAuEoi+nmcYwq/PG37LE3PIIFx+ltIkNqKqGKvYwttYS6GHeUtorp3KUGe6R+j1xyiHFH+dT6N
	UKhauaqIZ7HHIioSo/n+Byp5KwDoh2HJvTaoPv5O+Rw3IBTIPaytcyO+Ual0UyJWD/6lFeyIpjk
	KzJE=
X-Google-Smtp-Source: AGHT+IHyTh25758M3tLHabwUh9QJasPRH8j5k6zWozzM5ZyXfB5UphqUqNlcbo/m1cJrYLXIfsuOzg==
X-Received: by 2002:a17:902:ecd0:b0:215:b1e3:c051 with SMTP id d9443c01a7336-23dedd2121amr100682935ad.11.1752354278377;
        Sat, 12 Jul 2025 14:04:38 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de435cb63sm66828735ad.235.2025.07.12.14.04.37
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 14:04:37 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Subject: [PATCHv4 wireless-next 2/7] wifi: rt2x00: remove mod_name from platform_driver
Date: Sat, 12 Jul 2025 14:04:30 -0700
Message-ID: <20250712210435.429264-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250712210435.429264-1-rosenp@gmail.com>
References: <20250712210435.429264-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mod_name is a legacy debugging feature with no real modern use. An
analysis of the underlying MIPS setup code reveals it to also be unused.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
---
 drivers/net/wireless/ralink/rt2x00/rt2800soc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
index 701ba54bf3e5..e73394cf6ea6 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
@@ -246,7 +246,6 @@ static int rt2800soc_probe(struct platform_device *pdev)
 static struct platform_driver rt2800soc_driver = {
 	.driver		= {
 		.name		= "rt2800_wmac",
-		.mod_name	= KBUILD_MODNAME,
 	},
 	.probe		= rt2800soc_probe,
 	.remove		= rt2x00soc_remove,
-- 
2.50.0


