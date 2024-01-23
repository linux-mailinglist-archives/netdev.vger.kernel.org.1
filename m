Return-Path: <netdev+bounces-65225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2122839B4B
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 22:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A22DD2857D5
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 21:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F76038F9E;
	Tue, 23 Jan 2024 21:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pb/2U5jY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845A73A8EE
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 21:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706046271; cv=none; b=glvk+Q4UFuwcWTM9bsMkFDHRotYtf5+ZHZb3D3aFq3Tph6IBUQAGPSST3jFDXKI5537yFYyLVm290Z19xEENA43DB5CgOuZzlsdx/u2Vre+A8bsZ/3oNF/tyEMNJYgLWBU7SwjMKPjK335ky+IrdGgjJPrrWCa07gyBoAQQBR+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706046271; c=relaxed/simple;
	bh=BvxSB/pDO2jnrNwC0J1Av+EnE+DgvcJVeNNI0mTX2KI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gRwq/U3b+J1K4SfEv7czxbbuqvZaYJa0a3pji7fILW2atdttnlXPKeEvOxONOUCs/pboXPBlMY0yjCxz7M0ZHBX1OResAHCkJG9sZslYzVDuexYZx3Ux9UvYfQqtJbs+wWGnLG+2v2dAkO16e3geVl6Ya/iVd5UqVLKpdSrMLn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pb/2U5jY; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d427518d52so34570955ad.0
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 13:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706046268; x=1706651068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pSqq7f+3EB1MTvbivcd5VuYRADRq1ldDUtgdgeiF92Y=;
        b=Pb/2U5jYOlHkLLnqwis9hxRLUh3iYPMMIl6BqvtXgzz3SEKXZA1kdJaf64nQ3XFDh7
         yC3hBHO9YNVVqOhtp57NnAmgqGUWMjjgspvLDDc/OJ1wg1/DFev1pGtK6IMOYFYl8pLF
         cQ9L4i0wiXkQd5T+FVI2qyV+K2pmBCJ1GL9n0DLiJiZHt9mkcpiKQq2xgF4qTf/DbVAU
         CO49yrfBGoVENTYuheSeRSSAEgOr/D6mt4YNL4XuvR2BN8S1ZxNV3XqLXoGc52w/fB5y
         9UYn6mFCF6eh88Npc+8BWx61KIhZjjVLXw7nFD1SA7JUiuFXAwLgM50/ljtslEOrDR9T
         1Z6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706046268; x=1706651068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pSqq7f+3EB1MTvbivcd5VuYRADRq1ldDUtgdgeiF92Y=;
        b=amk67Raknp7pKXN4dSI8uUatOdyRlvG2JCNip07fxtdCSa81tGf7iHiOia5oC16wsT
         +ArVVNJBaD8I2/i78zZ24Gq7usCOprwq97zz2Pe606qphBbCTP9FgOkKjgtFPZ7rn4Vs
         ZUgqc5dZJmVFDXSPJEcjeNK8VOIGxweg9+9/0huOm9DZ0l1UuXK3PSUJDbyxJLbu7C4t
         qMckm6yDcin5oGViIaQ0RljhDiuXq8BQA8bN1TEeTVkQ2do7WRl6xW5xi2JBE2ZK5g9T
         pizEboqUCbxit96B8gXP7OMoWrOzv5++e/cMzeJHJSp3lEhl2C+97xkPvVXLUdd0BEya
         jSrw==
X-Gm-Message-State: AOJu0YxeBX+wMA2oY8sGqZf2sC7djh2+HZbjjL9nKu0WM3YB9n3oEmf1
	kC1pTkXLnpbZXJIcA8NxMQIKYH3ET/xMTy8HorR8nTaHrawlBOl+l6DJsrv/xpo=
X-Google-Smtp-Source: AGHT+IETtI7jnBugDDUBdUfjpNrllHhO4unCz5mAiJpVY7u1f8Vw8QLda9nV3eScEQH2fP510gt4jA==
X-Received: by 2002:a17:902:9f8e:b0:1d5:8cbc:863c with SMTP id g14-20020a1709029f8e00b001d58cbc863cmr271889plq.27.1706046267889;
        Tue, 23 Jan 2024 13:44:27 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([187.94.103.218])
        by smtp.gmail.com with ESMTPSA id t10-20020a170902bc4a00b001d714a1530bsm8108858plz.176.2024.01.23.13.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:44:27 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
	alsi@bang-olufsen.dk,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	arinc.unal@arinc9.com,
	ansuelsmth@gmail.com,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: [PATCH 00/11] net: dsa: realtek: variants to drivers, interfaces to a common module
Date: Tue, 23 Jan 2024 18:44:08 -0300
Message-ID: <20240123214420.25716-1-luizluca@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The current driver consists of two interface modules (SMI and MDIO) and
two family/variant modules (RTL8365MB and RTL8366RB). The SMI and MDIO
modules serve as the platform and MDIO drivers, respectively, calling
functions from the variant modules. In this setup, one interface module
can be loaded independently of the other, but both variants must be
loaded (if not disabled at build time) for any type of interface. This
approach doesn't scale well, especially with the addition of more switch
variants (e.g., RTL8366B), leading to loaded but unused modules.
Additionally, this also seems upside down, as the specific driver code
normally depends on the more generic functions and not the other way
around.

Each variant module was converted into real drivers, serving as both a
platform driver (for switches connected using the SMI interface) and an
MDIO driver (for MDIO-connected switches). The relationship between the
variant and interface modules is reversed, with the variant module now
calling both interface functions (if not disabled at build time). While
in most devices only one interface is likely used, the interface code is
significantly smaller than a variant module, consuming fewer resources
than the previous code. With variant modules now functioning as real
drivers, compatible strings are published only in a single variant
module, preventing conflicts.

The patch series introduces a new common module for functions shared by
both variants. This module also absorbs the two previous interface
modules, as they would always be loaded anyway.

The series relocates the user MII driver from realtek-smi to rtl83xx. It
is now used by MDIO-connected switches instead of the generic DSA
driver. There's a change in how this driver locates the MDIO node. It
now only searches for a child node named "mdio".

The dsa_switch in realtek_priv->ds is now embedded in the struct. It is
always in use and avoids dynamic memory allocation.

Testing has been performed with an RTL8367S (rtl8365mb) using MDIO
interface and an RTL8366RB (rtl8366) with SMI interface.

Luiz

---

Changes:

v3-v4:
1) Changed Makefile to use ifdef instead of dynamic variable names.
2) Added comments for all exported symbols.
3) Migrated exported symbols to REALTEK_DSA namespace.
4) renamed realtek_common to rtl83xx.
5) put the mdio node just after registration and not in driver remove.
6) rtl83xx_probe now receives a struct with regmap read/write functions
   and build regmap_config dynamically.
7) pulled into a new patch the realtek_priv change from "common
   realtek-dsa module".
8) pulled into a new patch the user_mii_bus setup changes from "migrate
   user_mii_bus setup to realtek-dsa".
9) removed the revert "net: dsa: OF-ware slave_mii_bus" patch from the
   series.

v2-v3:
1) Look for the MDIO bus searching for a child node named "mdio" instead
   of the compatible string.
2) Removed the check for a phy-handle in ports. ds->user_mii_bus will
   not be used anymore.
3) Dropped comments for realtek_common_{probe,register_switch}.
4) Fixed a compile error in "net: dsa: OF-ware slave_mii_bus".
5) Used the wrapper realtek_smi_driver_register instead of
   platform_driver_register.

v1-v2:
1)  Renamed realtek_common module to realtek-dsa.
2)  Removed the warning when the MDIO node is not named "mdio."
3)  ds->user_mii_bus is only assigned if all user ports do not have a
    phy-handle.
4)  of_node_put is now back to the driver remove method.
5)  Renamed realtek_common_probe_{pre,post} to
    realtek_common_{probe,register_switch}.
6)  Added some comments for realtek_common_{probe,register_switch}.
7)  Using dev_err_probe whenever possible.
8)  Embedded priv->ds into realtek_priv, removing its dynamic
    allocation.
9)  Fixed realtek-common.h macros.
10) Save and check the return value in functions, even when it is the
    last one.
11) Added the #if expression as a comment to #else and #endif in header
    files.
12) Unregister the platform and the MDIO driver in the reverse order
    they are registered.
13) Unregister the first driver if the second one failed to register.
14) Added the revert patch for "net: dsa: OF-ware slave_mii_bus."

Luiz Angelo Daros de Luca (11):
  net: dsa: realtek: drop cleanup from realtek_ops
  net: dsa: realtek: introduce REALTEK_DSA namespace
  net: dsa: realtek: convert variants into real drivers
  net: dsa: realtek: keep variant reference in realtek_priv
  net: dsa: realtek: common rtl83xx module
  net: dsa: realtek: merge rtl83xx and interface modules into
    realtek-dsa
  net: dsa: realtek: get internal MDIO node by name
  net: dsa: realtek: clean user_mii_bus setup
  net: dsa: realtek: migrate user_mii_bus setup to realtek-dsa
  net: dsa: realtek: use the same mii bus driver for both interfaces
  net: dsa: realtek: embed dsa_switch into realtek_priv

 drivers/net/dsa/realtek/Kconfig        |  20 +-
 drivers/net/dsa/realtek/Makefile       |  13 +-
 drivers/net/dsa/realtek/realtek-mdio.c | 211 +++++--------------
 drivers/net/dsa/realtek/realtek-mdio.h |  48 +++++
 drivers/net/dsa/realtek/realtek-smi.c  | 277 +++++--------------------
 drivers/net/dsa/realtek/realtek-smi.h  |  48 +++++
 drivers/net/dsa/realtek/realtek.h      |  12 +-
 drivers/net/dsa/realtek/rtl8365mb.c    | 126 ++++++-----
 drivers/net/dsa/realtek/rtl8366-core.c |  22 +-
 drivers/net/dsa/realtek/rtl8366rb.c    | 119 ++++++-----
 drivers/net/dsa/realtek/rtl83xx.c      | 267 ++++++++++++++++++++++++
 drivers/net/dsa/realtek/rtl83xx.h      |  22 ++
 12 files changed, 667 insertions(+), 518 deletions(-)
 create mode 100644 drivers/net/dsa/realtek/realtek-mdio.h
 create mode 100644 drivers/net/dsa/realtek/realtek-smi.h
 create mode 100644 drivers/net/dsa/realtek/rtl83xx.c
 create mode 100644 drivers/net/dsa/realtek/rtl83xx.h

-- 
2.43.0


