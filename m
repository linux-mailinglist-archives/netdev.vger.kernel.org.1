Return-Path: <netdev+bounces-238002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4032CC52A01
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 15:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 90D6C4EC596
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 13:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F297433343F;
	Wed, 12 Nov 2025 13:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkQAr3bH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CFF247291
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 13:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762955855; cv=none; b=ipFpCvDnnPP5T436QkTKEMvByCTGuShN5svRJntrVlQi5F+qQOLkjHx0ktGB0TpwNVVQy4iE0DRQF59uGIlIbaABDf4p9dXEXd3K9S/Gk7H9IEeMQzwnx+3CvYtXL/JDOs7CYl258/FYe5Xv7q5OjH0Ab2xOhrzXFJ8m581VBu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762955855; c=relaxed/simple;
	bh=k2G+UAOlxryfN7Ts6BKG6DLQwr8X02cUPkX0Arp69f0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r59UORJHj+IC9/+AC2puxqha8nXUvr7RdsYDVU/jqshWP/C97heou8aVK9RHI2bKgRi3UQdXmLQT77uF+6o4qJGfA480si7FtBl9Jqq2g8NkbrPg62+6EwF8FM7l48KtxyCRUj4iLvfiFuVSQI21XymC9nJoBWbBgIU5VQ7akEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkQAr3bH; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7a59ec9bef4so1085880b3a.2
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 05:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762955853; x=1763560653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lt/l+8Leq/bLhALiuQnMosDsUZRfKXTeoOFBaF6JTLw=;
        b=fkQAr3bH3AuLuM0DP7CIc02Zg9Iq30NQIVufcrlpZTNRJisyIoHQu0IH88lHd2OtvW
         fxIKN/UFOiaJMoJ7uK0huTo0Nc3tSZ482+NC1P3hm9Lrl7pmeBbG9TEzKn2eaoyW6Xnf
         ipWc+7HAg/cWq1sbT91iLPpKRzJfByYX8d5LOTGrNfTFZHUluCdYuvILV2g6Jfp4m+rp
         nelLGlEmNzpmLhMKKruPNID52ikJIOabNbhcI2Yc48Tr5/gSqn1Vo4/S8mLQfqUrgfMb
         ny7VR4kKGeL9/34SUfi/jhIy5kaFkAliBx4GmBUpTQaEekLftmJ8kzdc+cYjScV1BYSs
         JTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762955853; x=1763560653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lt/l+8Leq/bLhALiuQnMosDsUZRfKXTeoOFBaF6JTLw=;
        b=NqFFwRnRNP4r2HKG6Ijz8IYpWKHN2ziOu+wUc/Hut6GX7IlO9IKEqM/c8EW0WmzH7r
         zW/kcOtyQbrA7ssZr7MT2QCOGLhvsw2aVdoYGYvOJnGV52TF8wyDq9Vivb2LevGnQfl2
         tEA/TttDHi5AssJiBPi692xHTanPqgJTphx2ga5RNRo1wse3y1uepgIYrjQVXV1IHrbN
         6L+bWXzfu0Y8uAdIWO8hyEak0IwVoieBqNNGfNCMZgr+Ca5Z0bIB7kV6/cokkNzMZ5zr
         h/r8J96lSiUeZlaNdd/VmpuuFixuxauB0Rn0+5z95RT6R3m7PR+TM/vwvbdePj1FGf18
         U/AQ==
X-Gm-Message-State: AOJu0Yz6vuNATd53Dc7FtH/k7kdoHdJGEwUs9b7aIsnRjWdKDdjXns7J
	ng8r0L45dJQSU4m6npxbXI75pd2z87+fvM0Ppz7IKhUp2hy9S/7KjQrj
X-Gm-Gg: ASbGncuqPXZCU6ZFQjlLGFHHhJcToaSUe5nj+4rZcQR63XPptkh7Cn2HkcGZ7WMs6Cp
	qAIie6ze/kklauRLbpRC0Z6tirO0l62MuXg+Tmqj1o5fIoJXghFTJciHJbfAucOVryriWHkHaK7
	tfWJGAx7WpOgVF43BPzHWhWG/rhZ3r0fvF/kUke4GqMiJ+48h+/JJn0kG6IP48NWEnVDoU5QFNg
	hzWOTq2YoZFi4AeBkCfDIEG4buRQJejrvKoS/fAB/i404Dmi2nankQpxwgSOlDsFmV+Qe0AZ3yX
	t1zMKG+jyeXfcXFNJmYYgSZGpKO/4LyCQSKJNrtC7ktzqbPa3e6Cc4n6kNNcGER8vMihQIWJH4N
	kuegTXU2zPpjvYNMElbI8YJq3y7hFKqweNCtRgFHqut0gctpjoZKHNpcsghmGUaYtAOMKUuY/BO
	BuUwQZSEa83+tYTdq76R9g
X-Google-Smtp-Source: AGHT+IHZ/VsvfL1qBauYYeHFVM1I2oce6UrmCkeGZ0waGhdgmzOFEbz48XMrpfJQfxZr/VfEUub6bA==
X-Received: by 2002:a05:6a00:124e:b0:7b8:758c:7e86 with SMTP id d2e1a72fcca58-7b8759bc702mr941901b3a.15.1762955852653;
        Wed, 12 Nov 2025 05:57:32 -0800 (PST)
Received: from iku.. ([2401:4900:1c07:5748:1c6:5ce6:4f04:5b55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0f9aabfc0sm18361299b3a.13.2025.11.12.05.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 05:57:31 -0800 (PST)
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
	Parthiban.Veerasooran@microchip.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH net-next v4 0/4] net: phy: mscc: Add support for PHY LED control
Date: Wed, 12 Nov 2025 13:57:11 +0000
Message-ID: <20251112135715.1017117-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

v3->v4:
- Sorted the members of vsc85xx_probe_config struct to avoid the
  holes
- Fixed Reverse Christmas tree in vsc85xx_led_combine_disable_set()
- Added Reviewed-by tag
- Added new patch 4/4 to handle devm_phy_package_join()
  failure in vsc85xx_probe_common()

v2->v3:
- Added Reviewed-by tag to patches 1/3 and 3/3.
- Grouped check_rate_magic check in patch 2/3.
- Formatted the patches with `--diff-algorithm=patience` option to
  improve readability.

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

Lad Prabhakar (4):
  net: phy: mscc: Simplify LED mode update using phy_modify()
  net: phy: mscc: Consolidate probe functions into a common helper
  net: phy: mscc: Add support for PHY LED control
  net: phy: mscc: Handle devm_phy_package_join() failure in
    vsc85xx_probe_common()

 drivers/net/phy/mscc/mscc.h      |   4 +
 drivers/net/phy/mscc/mscc_main.c | 497 +++++++++++++++++++++++--------
 2 files changed, 379 insertions(+), 122 deletions(-)

-- 
2.43.0


