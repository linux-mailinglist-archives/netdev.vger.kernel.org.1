Return-Path: <netdev+bounces-118086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD01D950783
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 16:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89592280DD3
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 14:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE1C19D891;
	Tue, 13 Aug 2024 14:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlzAyLWD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D144B19D095;
	Tue, 13 Aug 2024 14:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723559301; cv=none; b=bbgSzJBq+IvRQgABULtfdCdAqSYAie5nvCzj3pOD8ji9NHiD0e6dmbaanObfZcgxLllZVShdH/Ijsp0blGRlvQcYpHKfZVvoWjDxFdwRA45GKgVfkbLN5lj8qScO3wV+qIwMtFrsY/drZV48l5tja+BYe3MFGRiQXBtmt9tg6po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723559301; c=relaxed/simple;
	bh=z40n9s51ZlLhvANk2e/ULNzSWTjF41BWJ66lQbWzL38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lcGvYYa9eux4IVP0PmEdhLlX0HAh10HsxG31od/E+O3mhmdOriCsp9le5yvDtO9EYHjamJYECJqy0abmVfvN85zU/kKgZoZ8xKKLuLLZm21VbfWKmxgDDwJKtu9zDwEsFnlvUXsaAjVbyl5i7lXsSOMlwxXvwEhlyBQhEcm3vxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlzAyLWD; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7a9a369055so434181266b.3;
        Tue, 13 Aug 2024 07:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723559298; x=1724164098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MHgusO5dO2gYWTqDU455wfSOfSQYn0V50tEQrx9IKO0=;
        b=DlzAyLWDWLGOZrvpKlreP7FqV+105oAHphELDRd35b/Onrr6Jkb1T1j4ydtYnAg06v
         /nyoDKqK4ooLbIY4+fHNqA0EJWhAVg6dJ+sUF0Ed6yt6/nEFzFWsqGukqcwMiMjjViZ0
         pSoRpm11cuyebJuK5i82SAdwUL6JEwcTTZZ5HvHSCUIPGC2XYXPwFfUJ6bq4KFuHY1T4
         QD0mbs85heDJaUFCm3Vnnr0zFlOnstWV8w5XsLMKbtt0wXLSg37s1UTVP6mhnxRKMd4l
         6jxxs059PKHknUceIiy92mN9RRT6WWvxmaKHdZxrw/1rL0tfCUMSR2KzhhN510s6K+vp
         0Pbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723559298; x=1724164098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MHgusO5dO2gYWTqDU455wfSOfSQYn0V50tEQrx9IKO0=;
        b=LdqvEEavuqqZWCJBwcYidi5i5AMt0M2rW5rXYOmQ1ELaxHBtF5mIiuhTBypWn4x6Y8
         17Jlq2HO+tN7Aw4/ypEuXbSZX2NskQjEqjNrjRIwPAU4H2SQuODS2sLyy0NYe3JNL7Ux
         Bd1ge088nFbJzKK6NLjY3+A2EBV6gmCwYOoNWpD7GP3YFZKlC2Okl5WIecQvOWfnCRzK
         PI3lI81XQswh5MxTS70WMaFmHd9f9KXxOeb8Zb+FgyJmiTVhI+MKFxd41tvZ/w0FzC5R
         k2cFguPQB21RsybfZIGunIv68Z7nCBPS0CvqdiMosX2n7LlV8H5Nctj7EKgU0mOu1sqq
         ipGA==
X-Forwarded-Encrypted: i=1; AJvYcCXIoi1wCTZH+mwruL4Tet6ViPpJF9FcKTjWohWWV+xN7CkgroDcvFtndBELcVUQtWX2ADc6RhdsZOVn5JsZRUFQNkq2gI96hlqySc1prakP3Cw9Syo8OlX0UeFmPn10vTdS1qgOUxTfLqYHVqDJPIPYZn/5UowyV0fVoQgko014EA==
X-Gm-Message-State: AOJu0Yw+TAkk5cygdww66xjjBnerST3YDi+zRzaMSdODP84YfEw9e2kC
	FIzgTl7kd4eis6yqsw2C5y83R5REB30NyRRRePl0RZVCJ0O3tY7L
X-Google-Smtp-Source: AGHT+IF86EMQ/14fppNNRbr34RJ/hsy/7iB8wS8JEl/P4cXaBT3+xLqq8gSA+toVftzW9LTXpQ0A0g==
X-Received: by 2002:a17:907:72cf:b0:a7a:a6e1:2c60 with SMTP id a640c23a62f3a-a80ed2d4800mr235734966b.61.1723559297852;
        Tue, 13 Aug 2024 07:28:17 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.ipv6.cern.ch. [2001:1458:202:99::100:4b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3fa7c27sm74345166b.66.2024.08.13.07.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 07:28:17 -0700 (PDT)
From: vtpieter@gmail.com
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	David S Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marek Vasut <marex@denx.de>
Cc: Woojung Huh <Woojung.Huh@microchip.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: [PATCH net-next v6 0/6]  net: dsa: microchip: ksz8795: add Wake on LAN support
Date: Tue, 13 Aug 2024 16:27:34 +0200
Message-ID: <20240813142750.772781-1-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pieter Van Trappen <pieter.van.trappen@cern.ch>

Add WoL support for KSZ8795 family of switches. This code was tested
with a KSZ8794 chip.

Strongly based on existing KSZ9477 code which has now been moved to
ksz_common instead of duplicating, as proposed during the review of
the v1 version of this patch.

In addition to the device-tree addition and the actual code, there's
two additional patches that fix some bugs found when further testing
DSA with this KSZ8794 chip.

Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
---
v6:
 - patch 6/6: use GENMASK macro in dedicated mask macro instead of inline

v5: https://lore.kernel.org/netdev/20240812153015.653044-1-vtpieter@gmail.com/
 - patch 5/6: split off DSA tag_ksz fix to separate patch 6/6

v4: https://lore.kernel.org/netdev/20240812084945.578993-1-vtpieter@gmail.com/
 - patch 4/5: rename KSZ8795* macros to KSZ87XX*
 - patch 5/5: rename ksz8_dev_ops to ksz88x3_dev_ops
 - patch 5/5: additional DSA tag_ksz fix

v3: https://lore.kernel.org/netdev/20240806132606.1438953-1-vtpieter@gmail.com/
 - ensure each patch separately compiles & works
 - additional return value checks where possible
 - drop v2 patch 5/5 (net: dsa: microchip: check erratum workaround through indirect register read)
 - add new patch 5/5 that fixes KSZ87xx bugs wrt datasheet

v2: https://lore.kernel.org/netdev/20240731103403.407818-1-vtpieter@gmail.com/
 - generalize instead of duplicate, much improved
 - variable declaration reverse Christmas tree
 - ksz8_handle_global_errata: return -EIO in case of indirect write failure
 - ksz8_ind_read8/write8: document functions
 - ksz8_handle_wake_reason: no need for additional write to clear
 - fix wakeup_source origin comments
v1: https://lore.kernel.org/netdev/20240717193725.469192-1-vtpieter@gmail.com/

Pieter Van Trappen (6):
  dt-bindings: net: dsa: microchip: add microchip,pme-active-high flag
  net: dsa: microchip: move KSZ9477 WoL functions to ksz_common
  net: dsa: microchip: generalize KSZ9477 WoL functions at ksz_common
  net: dsa: microchip: add WoL support for KSZ87xx family
  net: dsa: microchip: fix KSZ87xx family structure wrt the datasheet
  net: dsa: microchip: fix tag_ksz egress mask for KSZ8795 family

 .../bindings/net/dsa/microchip,ksz.yaml       |   5 +
 drivers/net/dsa/microchip/ksz8.h              |   3 +
 drivers/net/dsa/microchip/ksz8795.c           |  94 +++++-
 drivers/net/dsa/microchip/ksz9477.c           | 197 +------------
 drivers/net/dsa/microchip/ksz9477.h           |   5 -
 drivers/net/dsa/microchip/ksz9477_reg.h       |  12 -
 drivers/net/dsa/microchip/ksz_common.c        | 271 ++++++++++++++++--
 drivers/net/dsa/microchip/ksz_common.h        |  31 +-
 net/dsa/tag_ksz.c                             |   6 +-
 9 files changed, 391 insertions(+), 233 deletions(-)


base-commit: dd1bf9f9df156b43e5122f90d97ac3f59a1a5621
-- 
2.43.0


