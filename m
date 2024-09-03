Return-Path: <netdev+bounces-124413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E4F969580
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 09:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2516C1C2323C
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 07:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55E31DAC41;
	Tue,  3 Sep 2024 07:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwL9/4d1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCAD171C9;
	Tue,  3 Sep 2024 07:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725348596; cv=none; b=P0DOZj3OL5mBeBNh5BLNLP9mPL86Bp0sO35GFw6dYdnxl9t9CH6K/pxjFilLgR/Z1mnUiaaCgXvEFx5zvnbn4VD4x0MVQnsqeKAdXicVdiRrh2L5l9w675G+XSYVeWMYYk6jMaXg2rEB6dw3eBImXO6guGJ49gzODpkwCiGPE1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725348596; c=relaxed/simple;
	bh=8UbaJl5e853OSI6GPlasFrnnlrbjyzUr3/6fMoeJWOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OVtKbHea2syBMHR2QhdCgafcm3a9acFP0L0zR/hnC+CXzeOOaBJ95gDLH2R6ZBQbaTjcjvU3sNoGi7dzLix55uohWkzF6gZDAI4EnVJonrURATHClsb4nOLx1PMCNCwXhnbEEUjjGg9Gv7+3rFiNW5h6EKnuGNmk/TLbOfo1F5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MwL9/4d1; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42bbd16fcf2so33268715e9.2;
        Tue, 03 Sep 2024 00:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725348593; x=1725953393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Va87QrbleAQsq44INM+JbVeUGv1keqyFrGSxukKZ4M8=;
        b=MwL9/4d1XRFlpZlLAfQGSkzwRcaJrndQzCMT8f8K7diEbGyCbY3PD6ZwxA6HfP8ftQ
         uT6k3KNPW+9l7uxGok7Lj3CS80d3+D13cqOvqIG2GzUr+j9uuT3thNsH6NHhiOV3YS0Y
         NmP42WV1vdjkNco3JJ3a3yhP+EL23H9RwiILnnYPpz05PdnJbiw+Bcr4R6SfrnyFFYKB
         8lKyFsM25uPc7w9xCFnqxiCAe25VmxSys7wJv7s1+jZN9RgSE0k3TzmHzRYMFRBZSTFz
         ZRO5iUuAfe13ya0+k6piyzhZYW6kZs/17DQT31MGLDFpY1ziDcwf//4zrMh5MbazyNf/
         cScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725348593; x=1725953393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Va87QrbleAQsq44INM+JbVeUGv1keqyFrGSxukKZ4M8=;
        b=T80fQ/pzKfgaq9WAUlBbst9yc8OekJeVqa05OBqbfqdfOfFaCLuS0Jo+rcRLNu396a
         Q/UbqvqWzS6FiF5jVjuoV5219G1GfUVR9792FtxvyC72+Ct4LzUDVt7JEhXA2oaQfXyp
         V5WwsgcHOPGBTHugVntmBbaS5V/fIfIb3PXYhGl0yZh55AqSIx3KfEY3SShSehqENy5X
         ZgA5GS+4QqBaj71bwjofiXgSvzUYeEpVdjcZ8yCkp/AKMcELNmlEDSdB/P7r0nCYi+7T
         xGP8vJ+bR3DPqoOMqsoSym1aIEWaT8dw20bPEJwcpACH0Nk0hvaKJvlBe6nFi+luI1lQ
         3MUw==
X-Forwarded-Encrypted: i=1; AJvYcCWGJm1M4Nsf4WUtNgsUJcCLBEabMf9DKDCMgIdhQDWWB8SeWeQrBU/QitmkL9gjopNzbuXBm/BlIgqSMLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhaBzYxW8YLAY4BJRufOjtf3y8QPAuCZx8+mIkgr3xUE4D5DKK
	B9y2sIywckxksenKTPRnGfHSKKY7Q3Xm2rSaUdOz3A6nyKJ26sz+
X-Google-Smtp-Source: AGHT+IHoSwnh150ySCVCgL6H5ZM6h/TyXfrUwMAdfNMetfEcIlUdtUYDgCoRCv7+Bp9k+/T2EDO41w==
X-Received: by 2002:adf:fe03:0:b0:374:bde6:d375 with SMTP id ffacd0b85a97d-374bde6d48bmr5225643f8f.29.1725348593090;
        Tue, 03 Sep 2024 00:29:53 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.ipv6.cern.ch. [2001:1458:202:99::100:4b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226c6a37asm6121947a12.1.2024.09.03.00.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 00:29:52 -0700 (PDT)
From: vtpieter@gmail.com
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Arun.Ramadoss@microchip.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristram.Ha@microchip.com,
	o.rempel@pengutronix.de,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: [PATCH net-next v3 0/3] net: dsa: microchip: rename and clean ksz8 series files
Date: Tue,  3 Sep 2024 09:29:36 +0200
Message-ID: <20240903072946.344507-1-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pieter Van Trappen <pieter.van.trappen@cern.ch>

The first KSZ8 series implementation was done for a KSZ8795 device but
since several other KSZ8 devices have been added. Rename these files
to adhere to the ksz8 naming convention as already used in most
functions and the existing ksz8.h; add an explanatory note.

In addition, clean the files by removing macros that are defined at
more than one place and remove confusion by renaming the KSZ8830
string which in fact is not an existing KSZ series switch.

Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
---
v3:
 - rename all KSZ8830 to KSZ88X3 only (not KSZ8863)
 - update Kconfig as per Arun's suggestion

v2: https://lore.kernel.org/netdev/20240830141250.30425-1-vtpieter@gmail.com/
 - more finegrained description in Kconfig and ksz8.c header
 - add KSZ8830/ksz8830 to KSZ8863/ksz88x3 renaming

v1: https://lore.kernel.org/netdev/20240828102801.227588-1-vtpieter@gmail.com/

Pieter Van Trappen (3):
  net: dsa: microchip: rename ksz8 series files
  net: dsa: microchip: clean up ksz8_reg definition macros
  net: dsa: microchip: replace unclear KSZ8830 strings

 drivers/net/dsa/microchip/Kconfig             |  9 ++--
 drivers/net/dsa/microchip/Makefile            |  2 +-
 .../net/dsa/microchip/{ksz8795.c => ksz8.c}   | 13 +++--
 drivers/net/dsa/microchip/ksz8863_smi.c       |  4 +-
 .../microchip/{ksz8795_reg.h => ksz8_reg.h}   | 15 +++---
 drivers/net/dsa/microchip/ksz_common.c        | 48 +++++++++----------
 drivers/net/dsa/microchip/ksz_common.h        |  4 +-
 drivers/net/dsa/microchip/ksz_spi.c           |  6 +--
 include/linux/platform_data/microchip-ksz.h   |  2 +-
 9 files changed, 57 insertions(+), 46 deletions(-)
 rename drivers/net/dsa/microchip/{ksz8795.c => ksz8.c} (99%)
 rename drivers/net/dsa/microchip/{ksz8795_reg.h => ksz8_reg.h} (98%)


base-commit: e5899b60f52a7591cfc2a2dec3e83710975117d7
-- 
2.43.0


