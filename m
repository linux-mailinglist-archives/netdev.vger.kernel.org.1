Return-Path: <netdev+bounces-199254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 537B9ADF92F
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 00:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 956A87A6577
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 22:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460A627F018;
	Wed, 18 Jun 2025 22:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bmh1PY74"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FE927EFF4
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 22:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750284439; cv=none; b=oUIXeVi6h7NH/McYHK3m+z6evlXbNYPHnRHktnfvuiF4O+b9uC4m+kw2u3dMWRP8wtpRgr3AoFWhmPk/UsCXjvvdrMxxQcCP/zj7/AAaZWUPJf15swHKivLBJQH8WH9UcXBdv4fBi2dCMPy/fxPepJQ1aAmnJ2kycUmnretbGlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750284439; c=relaxed/simple;
	bh=Zfw9r/CjxyD3/T/FBJpIDs8gZG38Uk1Mm6aVAeKri5Q=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=tLwPRC++464E0HuWBvlQ7ulVFv1lRE+qzPrVRPcdX05IVuLpB8itNDRny/stzOL+DQzaNj8A5ZASgEk7l0SBZFbN1DVlVAmDK8RoBs+kOBbMs371JzmEiq+Ij+QjiA0CqhAZR33xkNWjnEYRIwXx7ogK+p7rd/U8cu2+5ly0HPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bmh1PY74; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-23636167b30so1994335ad.1
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 15:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750284437; x=1750889237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=ResaT67xXCdshcqf/Mz1Hh2eOY08aovvWJ5kJET0+Kg=;
        b=Bmh1PY74MtLtPQwJA4ZmuJ8xf53ita23c3E1SSmnvV5fcLjPDK6BYad2EKp1qzkdDA
         0pOS4IWby2fl2ws5GRAV1QUIJByBRLn+pT+yFl24NwU/Scd2jZFGitRGPgaYIyWobLOC
         c1wNOu6AUbCODghNDd09ttS8me7odqgu3SaQsU+TETnsuBWmqGDGSqga1lNiXZK6nBGH
         S+w2XY1uF4ypQOBpmUmpUEgOq2I4x2iT6mWeXnBNapWq06FFZ5Jn3ZKe/ZJhWq5lMvMW
         E//XPUkbNcgI0A+ghfs2FtwLvkniScWBU4gn3AXbT+FoCxI8RuU25NTxOl+8979LV9Hp
         wC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750284437; x=1750889237;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ResaT67xXCdshcqf/Mz1Hh2eOY08aovvWJ5kJET0+Kg=;
        b=E/UP/jF8amzet8OK4JX1WHF5XBOLFXxfs7ESEF91+ASCPIW6M2LuJGaIsrQexCHUD0
         p8BpzP36hQH6kJs+HdvE+WnqZg/d5tXpQ3cyy0rhOxNW9eMcjIxDG8q8CqHRmn64rl1q
         85emrs3JQLZwcHVBAsZ8R8mCRvZOJu48Ycr3I/BR77Eolin3e9+yPlyUZ1geWpGF7XRI
         6SvH1M11cRJ0+kPpDiK896O29vXZpGrtFz+CTxuAJsXtF5irWPJ3/YiKtTSgUGFikq5c
         akiuKBUlaUrfVzU4M2pq/bXc1E4VXJfi/svUFQ0EV3BVlNV9nQyKoXyW3vYiFTQARunX
         10hQ==
X-Gm-Message-State: AOJu0YxodVFVmb88rl/KQO4DYepWp8x56I5QhuCQ2+AnPtKunr0Ruc50
	Zu82yW/WkDsT3RpMs6GfUkpzrYGk3DK5WwQdA6rwhvEckq8PsekVdw0ZkKzwmg==
X-Gm-Gg: ASbGncujONZtAzsxWNWhu+2ivwbpauyWPxCHQj3l3jLpjGpSgI7dRimnYoBbCvXXfCP
	+rkrJ4yihidF/5LaIIbdz0NL55vv/ak46d318BUuY/5n3pliL9JGpj0cqp6QF9UweiG5zhNShgO
	tuw/1K9wiGPW1y5FzEOMWgojaS+QSFTpZXyFu1r7Ncco1rgF+99xxwiAcSNzgpp5x3y4CS5n/sL
	nq54D9WjDz7gvDhP5f+3QjY1XC1nbxi0HDh3AFQUiGtY8wr5C+4l8e6XT20ahyPI+EzsCXtTlpi
	/Gxt6RcKYKVEBzdGS9TpOu+USapGHHrju5xGlZ0u6T13k3QsxsLfHq2zPz57LgEUsW/gPFsYwjl
	RpEEWPAAQethrzJ+tgLiM
X-Google-Smtp-Source: AGHT+IEJCuQvlM/FsP+LaPN2G3uGbbqVtf3lVqXWvYLuy32z3Io/bRNNI6Cy8MdtHNd4JnYVnMSDEw==
X-Received: by 2002:a17:902:ccc2:b0:234:a139:1203 with SMTP id d9443c01a7336-2366b3c5ac7mr307133975ad.32.1750284436891;
        Wed, 18 Jun 2025 15:07:16 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d8a19d7sm106135295ad.83.2025.06.18.15.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 15:07:16 -0700 (PDT)
Subject: [net-next PATCH v3 0/8] Add support for 25G, 50G, and 100G to fbnic
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: linux@armlinux.org.uk, hkallweit1@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, pabeni@redhat.com, kuba@kernel.org,
 kernel-team@meta.com, edumazet@google.com
Date: Wed, 18 Jun 2025 15:07:15 -0700
Message-ID: 
 <175028434031.625704.17964815932031774402.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The fbnic driver up till now had avoided actually reporting link as the
phylink setup only supported up to 40G configurations. This changeset is
meant to start addressing that by adding support for 50G and 100G interface
types.

With that basic support added fbnic can then set those types based on the
EEPROM configuration provided by the firmware and then report those speeds
out using the information provided via the phylink call for getting the
link ksettings. This provides the basic MAC support and enables supporting
the speeds as well as configuring flow control.

After this I plan to add support for a PHY that will represent the SerDes
PHY being used to manage the link as we need a way to indicate link
training into phylink to prevent link flaps on the PCS while the SerDes is
in training, and then after that I will look at rolling support for our
PCS/PMA into the XPCS driver.

v2:
- Fixed issue with fbnic_mac_get_fw_settings changes being pulled forward
  into patch 3 from patch 4.
- Updated CC list to include full list from maintainers.
v3:
- Stripped out the QSFP support from the first patch
- Split the third patch "fbnic: Replace link_mode with AUI" into 3
    fbnic: Retire "AUTO" flags and cleanup handling of FW link settings
    fbnic: Replace link_mode with AUI
    fbnic: Update FW link mode values to represent actual link modes
- Added Reviewed by to
    fbnic: Add support for setting/getting pause configuration
- Various wording fixes for patch descriptions due to patch splitting

---

Alexander Duyck (8):
      net: phy: Add interface types for 50G and 100G
      fbnic: Do not consider mailbox "initialized" until we have verified fw version
      fbnic: Retire "AUTO" flags and cleanup handling of FW link settings
      fbnic: Replace link_mode with AUI
      fbnic: Update FW link mode values to represent actual link modes
      fbnic: Set correct supported modes and speeds based on FW setting
      fbnic: Add support for reporting link config
      fbnic: Add support for setting/getting pause configuration


 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |   5 +
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c    |  23 +++-
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |   8 +-
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c   |  95 ++++++-------
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h   |  23 ++--
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |   2 -
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |  11 +-
 .../net/ethernet/meta/fbnic/fbnic_phylink.c   | 126 +++++++++++++++---
 drivers/net/phy/phy-core.c                    |   3 +
 drivers/net/phy/phy_caps.c                    |   9 ++
 drivers/net/phy/phylink.c                     |  13 ++
 include/linux/phy.h                           |  12 ++
 12 files changed, 237 insertions(+), 93 deletions(-)

--


