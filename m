Return-Path: <netdev+bounces-141409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E319BACFC
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 08:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCDBE1F21799
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 07:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD81018E056;
	Mon,  4 Nov 2024 07:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rp1uvu2T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4968118BC1C;
	Mon,  4 Nov 2024 07:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730704204; cv=none; b=M6X3BreHpWAUKOO1vpkJQkJb2sk2Orynq6Ij7Tb2qMpq/UEWpfLyDRXmlRq6kuANThqM6cmM+fcD2xbFErc+Cdb+Rrb1vPS4DMPszrh1m1oWUQTNpnUhY+mP1N551ekop8X5MYMAFMOvXk303Sbo3AYGSoWNaqmthd5M7AcJLnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730704204; c=relaxed/simple;
	bh=SPTQRdNmFS3eg3OMkNxVNgHYn8eqrM74yPTEqKfKPFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fFpE9BD9Ys+5yowp6ge5FICSsk9YjYfDxh+iS3Ej/pY4XNGekIFG4WrLd3C5zwlRhMKHW209SfX4MJMYiJIA3wU2h3Xrbi9ZliSAImctZ/K0GAwGby9Nj31tPKrZBjWGxStuXzfO3Tn416xnlYyjErp3m79no/Fxd/BZ428mQlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rp1uvu2T; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-720be27db74so2408383b3a.1;
        Sun, 03 Nov 2024 23:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730704201; x=1731309001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s9UkprCFZg16TQx7+CiZHw9Frii8Y8zJSSYmND9/FPI=;
        b=Rp1uvu2TEiUDQrE1eK1lm2BJevPQ62EzXZOrdgjBkn/OzNEGelmShglqt1yLW8zHbq
         bHKQS4EdrZ6M57MPmy0qqrsdWPti1NkHMAkyrwm53rJxJ6m4xor2/bE1CJ8BnCbl9kEV
         DWh+1a+yjG/C0EYytpD62kD05nZm6LmStS6zSLGMPdNhtgFzvFBWRvlvNZ0VSVVQZCnA
         /Dc/7Ocf9+ou35iDnaQeeL78/KTSnWR8eBNWyme2CgR3ckeJJuh34rlTAgdl0LJoe2ep
         Qfi/gmKNsAuXbHO75Y/MfHO8yyFIKRn88ur3tkPc9uru6uMnLMbbJnZhBVXFgDmw0xQf
         DElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730704201; x=1731309001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s9UkprCFZg16TQx7+CiZHw9Frii8Y8zJSSYmND9/FPI=;
        b=PLAaMysmbmJbfzd6VXP+z44J0Ow7p6bc0BvFV1Etjma7TXVyTbBbSPmfJ2ztFZNktv
         /LxGMRNwbDYmF7DP9FcPpROk0XTTmvOOaJ3RpXL8zpd/rTC8cXITrzVUFKtGVlQzMTDD
         tSCuBX/vFhZpGncVbno5qLuKaeQj4r9ZtfyWfjSgLBa3zYnKYdg9QIRzbGxFvD62+5DM
         ELmthfKIimnNrTOwho3Bu1afbbcgJuJhN1y6mcyAHHWbzQCSj6HU9pJkI+8dahLuylZe
         3v8rx6Vjy3ImwLYMyTTC2Nuz+KTOBI7ueHf21DqOiHvAaEFpQxHeX5KqfTvThlrUueL8
         gX/w==
X-Forwarded-Encrypted: i=1; AJvYcCUaqGMIBhaP8JgV73kCSJ5nXr08xXDKCrpLwjnQvze7Dxk3ENkgYAbeJXy7nQ8PBCHNa/GPmx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrtUGEYK0bR7HPQ9n/o25P1il7+xjdv32Psbl/ew8diAXn9jmQ
	OBIClLf28RsRA9hP8QI8/stVee34R5YXPe4zXgd71RhlGcTo0DlhuBcVYw==
X-Google-Smtp-Source: AGHT+IF2k2G5IGCgAy6sSnILrilGhrmljwXtk7pK2TIp41EgoVgl/WC5//mhdIyv9RCsx8VewjaqBA==
X-Received: by 2002:a05:6a00:2383:b0:71e:735f:692a with SMTP id d2e1a72fcca58-720bd1a046amr21456926b3a.14.1730704201404;
        Sun, 03 Nov 2024 23:10:01 -0800 (PST)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2c3de2sm6721122b3a.112.2024.11.03.23.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 23:10:01 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: linux@armlinux.org.uk,
	hkallweit1@gmail.com,
	andrew@lunn.ch,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH] include: mdio: Guard inline function with CONFIG_MDIO
Date: Mon,  4 Nov 2024 17:09:50 +1000
Message-ID: <20241104070950.502719-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The static inline functions mdio45_ethtool_gset() and
mdio45_ethtool_ksettings_get() call mdio45_ethtool_gset_npage() and
mdio45_ethtool_ksettings_get_npage() which are both guarded by
CONFIG_MDIO. So let's only expose mdio45_ethtool_gset() and
mdio45_ethtool_ksettings_get() if CONFIG_MDIO is defined.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/linux/mdio.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/mdio.h b/include/linux/mdio.h
index efeca5bd7600b..558311d9d7cad 100644
--- a/include/linux/mdio.h
+++ b/include/linux/mdio.h
@@ -165,11 +165,13 @@ extern int mdio_set_flag(const struct mdio_if_info *mdio,
 			 bool sense);
 extern int mdio45_links_ok(const struct mdio_if_info *mdio, u32 mmds);
 extern int mdio45_nway_restart(const struct mdio_if_info *mdio);
+
+#ifdef CONFIG_MDIO
 extern void mdio45_ethtool_gset_npage(const struct mdio_if_info *mdio,
 				      struct ethtool_cmd *ecmd,
 				      u32 npage_adv, u32 npage_lpa);
-extern void
-mdio45_ethtool_ksettings_get_npage(const struct mdio_if_info *mdio,
+
+extern void mdio45_ethtool_ksettings_get_npage(const struct mdio_if_info *mdio,
 				   struct ethtool_link_ksettings *cmd,
 				   u32 npage_adv, u32 npage_lpa);
 
@@ -205,6 +207,7 @@ mdio45_ethtool_ksettings_get(const struct mdio_if_info *mdio,
 {
 	mdio45_ethtool_ksettings_get_npage(mdio, cmd, 0, 0);
 }
+#endif
 
 extern int mdio_mii_ioctl(const struct mdio_if_info *mdio,
 			  struct mii_ioctl_data *mii_data, int cmd);
-- 
2.47.0


