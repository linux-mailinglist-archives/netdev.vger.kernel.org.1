Return-Path: <netdev+bounces-236888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB84C418F9
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 21:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9900B420E72
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 20:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3795430BBBA;
	Fri,  7 Nov 2025 20:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoyBBcBA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2E2309DA1
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 20:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762546372; cv=none; b=frLnFW2U4TEsRp2lGBfE7TDrfQLuPlUzJmXhKJ3W6RocUBMyd0Wa8UeVfZmbwPEpGlVvNvtn1E7v7mTT+jMV6ypSbIXcAsUFk71qDdAA6oFDFpS46OTgClwzRU39IfOa/AgMBJpEqEza/ouqLVXe1j034dTitGZMSo/zVoBV9WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762546372; c=relaxed/simple;
	bh=q+Oljg6oRYn/wzyY6ZW+TEK32wEhmKjJz0W0fLoZnGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GMFrOxxucB9q1AxalAOqFxRdyuYABMQm0ijAuLcEzG6SQcvgkrB2RxEi6d1rmgN3qTjGXScO4QwSHEaYs/2QfapUAUbcxU9t3KpeweF/kUvamq4tX/75a2Bd9Z3eM7noGl1btfHY7m7Ibq2vkm2PtzVqnpCk67JwYkQ+4JBD0t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZoyBBcBA; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so1084805b3a.1
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 12:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762546368; x=1763151168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gmLBjJR7+9+QwX0fWKlfYtGSCTKiJyl3M6K88B8Ym2w=;
        b=ZoyBBcBAOwzb91BZqdRRLIrH1TriFrObJaJMMVxW82w37XJSy864J7U2jSbGfUrD/Y
         vQDxfPsjNj9qSlm7nAIKnD1SNQAZlu2EKUkp4O2CQLevIENPjDGazHtSYLXtVjn8rvxR
         s7zLmBy/B9SRweNU4sHDZOI9F1l3uP1J5Ic9SNNw3/uhXiccfgZz3KlMJRks2ZMmR4CQ
         Eh52G4oAWnkIMQKyQc/I5bcpbQchJpNyCsWihDN0cUGn28Jc74EJrc6HBXd+tzenZuYg
         0g6OCmm5FFkSqMgv8Ng/seP0OIxUYvIr85akMNAMV/DtP8DuIg46dQhrTurkG94MoS6n
         fFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762546368; x=1763151168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gmLBjJR7+9+QwX0fWKlfYtGSCTKiJyl3M6K88B8Ym2w=;
        b=fh0Kq+zXfdGCwvWCWQ1vXeEmKrBlmwcfqitu2ehAjNoI4/7myLunoKGmh0iINwid4d
         EnTVwhg+G+VV/3BVPEcdb/eBcOxsdimhN1KtTuen7zBC8sySoqISI/pI1GQkejLZm9mz
         3bFhLBxV2YkdpuP1cuIE42zbNThvhx56PSXVTXzbiLDCrE/pUFN7x79jWq6ikqkCgn4V
         Sry6VmjwhBohNIqgt6R/KtAIGaRpIn9z4HVa6DrNHDUs+w06EFnfuJzoOTHgpjBio3QQ
         dJKsTmDDVhxoNZriKmO92tc8Nq1vFC0b0gEC6CV+FQZb5A4mRoNyCpFlzD82S3rThCa5
         Gi3A==
X-Gm-Message-State: AOJu0YzSZiuYpBX2ZkoIpC0ROQ1t8wW1wpF2+F5r97I0/+NKc9yCYRUl
	5gRHnjhB1AObUeBR9YbJmrCorEnvMVnRYfqPHn8VVQmEVlbDmAsYA+EM
X-Gm-Gg: ASbGnctYZJU1vUSovkD34qUkYDir+doOfGeXyHjO3GNDIuJDJQhLbW+atk2WESHtngd
	OdAjPfUfdGO4Cj5QfWcZhCHQKHaVV196xJI1h8wrUUDcvyFAYapyHMh8T1YXP3B8qFZHdxx4Lti
	PoN2GCUyXBjQw+BvHocSmcaBQyWB/4WQdYs6eykS12ljgN+El7680XzbWh3Na5Nd/KfaUb/+0tr
	4XCPsnQhyk09kYQox3SI132T+r5L7ZMx11ie85+Q/WhfSre4k7zclKyyJbdGG0+2t11Kii3ZyFu
	O5L8s3OUUnol2UqeegnPPA+B84OxWnZfKa4ZwAulojj/moHJd1x96defooU5GoMCn6aRO7AF241
	+uyOgawos8qLJa2eQCf2b40P8QvcDJgYvdYIXU29Fhr6QQQv8gXyniVZTPjkZ90OhGR2zJx5D4Z
	xjfQbrNPXU+85nmc6ozxMl7Q==
X-Google-Smtp-Source: AGHT+IGquAvMPEEx3nkW2d82X3WNn0DCOofSOoddPCdlJEAt8dKqkNI+ctNil0/sdM1xqx2QGMDKyA==
X-Received: by 2002:a05:6a20:72a4:b0:334:91ab:f189 with SMTP id adf61e73a8af0-3538b000317mr757236637.22.1762546368290;
        Fri, 07 Nov 2025 12:12:48 -0800 (PST)
Received: from iku.. ([2401:4900:1c07:5fe8:9724:b1da:3d06:ab48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc17784bsm3828553b3a.47.2025.11.07.12.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 12:12:47 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH net-next v2 0/3] net: phy: mscc: Add support for PHY LED control
Date: Fri,  7 Nov 2025 20:12:29 +0000
Message-ID: <20251107201232.282152-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi All,

This patch series adds support for controlling the PHY LEDs on the
VSC85xx family of PHYs from Microsemi (now part of Renesas).
The first two patches simplify and consolidate existing probe code
the third patch introduces the LED control functionality.
The LED control feature allows users to configure the LED behavior
based on link activity, speed, and other criteria.

v1->v2:
- Patches 1/3 and 2/3 are new.
- Added LED control support to all VSC85xx PHY variants.
- Renamed led callbacks to vsc85xx_* for consistency.
- Defaulted the LEDs on probe to the default array before parsing DT.
- Used phy_modify() in vsc85xx_led_brightness_set()
- Return value of phy_read() checked in vsc85xx_led_hw_control_get()
- Reverse Christmas tree in vsc85xx_led_hw_is_supported()
- Updated the commit message to clarify the LED combine feature behavior.

Cheers,
Prabhakar

Lad Prabhakar (3):
  net: phy: mscc: Simplify LED mode update using phy_modify()
  net: phy: mscc: Consolidate probe functions into a common helper
  net: phy: mscc: Add support for PHY LED control

 drivers/net/phy/mscc/mscc.h      |   4 +
 drivers/net/phy/mscc/mscc_main.c | 438 ++++++++++++++++++++++++-------
 2 files changed, 349 insertions(+), 93 deletions(-)

-- 
2.43.0


