Return-Path: <netdev+bounces-76885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0FD86F461
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 11:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CEE71C208C4
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 10:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B63B66B;
	Sun,  3 Mar 2024 10:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wc5UeZYy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44109B664
	for <netdev@vger.kernel.org>; Sun,  3 Mar 2024 10:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709461737; cv=none; b=UOogG3qEPgFsHBLynOr119bzeyovztRlzipmLhBskqC8GnnwgzQ3ti2qGT1mBAHmkKTUt58b8PE7fbkY9AC9ky6sTfEkO+hqDhfcDuIRao1a625dnTzggHkQs9ec5S+PbGhYUtV0jbndgpdli2i7QqLm+yea8Tj9/DKX5ZU3ckQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709461737; c=relaxed/simple;
	bh=d/P4inDsFvyDRXgyPXJe5Z0RZSBIzPDk7yHSbj0fJWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CGYmR4cGKwuwH4bGyoHJt1P2gNUyhSiZsrVEhEODVfXrLnDIFn6x/PU43Cxtjwnezhl5X5RhIBONz3a2MlnmzAOg9nEEteBYVLxqTwxYL60fl6K7u5VoX4dIxFyNeUC6bu2ToTxymCUEiAe2mTaN1m/f9ScKZuDw1KEfui26lS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wc5UeZYy; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a44ad785a44so220769266b.3
        for <netdev@vger.kernel.org>; Sun, 03 Mar 2024 02:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709461734; x=1710066534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bJCuNryDI/h57BzepsAAGIlxjX0nOA3DaJDgnhgdd5E=;
        b=Wc5UeZYy/rBRt8sW032e/jWGYNO2wSvQLptZud6+yXHYsUaWYJ73ilOrpteztdEadh
         loiKjQ8en5OsHIIsBTOC7g+zLop5HCOuRmVN7fchzFapDSXDUwn6AvDWPBFxdr9/7N8k
         4Od0799FGEYu4Y0xnB1/CYaCB4LZCin2WcS5FmIJhEKdcl62lFEsxAccIn6iqD9i/zwm
         pjGK/1Re0zBsFXqIknsOmbbYxBYcBt00PU7TK1ZsK5tLLT0h+GrtWZzbBTaxsOZgGqYs
         hoQHj4H+iK2TFzoQuGYErcjycBEleQEdFQdDT92YhCadfg58Of6ub44nYABuifbKD0w4
         /VMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709461734; x=1710066534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bJCuNryDI/h57BzepsAAGIlxjX0nOA3DaJDgnhgdd5E=;
        b=RArSud2j7brVQZ4jp0haFBIW6h9wICGs+/PXFXvMsth1x1J3bnXHxDHMrJ9WJmTrGP
         eaxkCd0ryL1bXh9iy/0qpBEyVanGcFwamSLjom2QeMk0ZZPEhOQpx8cUwdfSpZhMz7x4
         qx1XWxiBCitwx2aCFOqMoFihXqnLCXzoRaZskG+ie+duZ8HFeKWTZIZGZnPxMKdO3epq
         KPno2fbMW9jaiZdj39b7NtF/UffvtZFpJw/21+wd9Ts0CxtEe1/WHg2ASNJlBh48rR+Z
         W+HqKh7EhFERSYTYPxZ64SfrM87anUIw/uTqMv5HJLBg0+9nH72IXl+rotX4YZmQmtDr
         TUjg==
X-Gm-Message-State: AOJu0Yzq+Oj4gkIJM8RPIbeb+8ybKyrAc3lqqTJyE/06TTXSrdQC/LkR
	prdMY0GHNG6d6pHd75jQaBFadBuq043Zj2csZ25cFbzWeggZGJZz
X-Google-Smtp-Source: AGHT+IHGS7OzvTvR9v+ougXLfFreU54pMGoEsixzDazthE6YeaN6cUUwWJ5rLOTE+7R6DsRCmsu/Wg==
X-Received: by 2002:a17:906:19cf:b0:a43:ab98:d376 with SMTP id h15-20020a17090619cf00b00a43ab98d376mr4595617ejd.15.1709461734387;
        Sun, 03 Mar 2024 02:28:54 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id um9-20020a170906cf8900b00a44d01aff81sm1530759ejb.97.2024.03.03.02.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 02:28:54 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	"Frank Wunderlich" <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v2 net-next 0/7] rtl8221b/8251b add C45 instances and SerDes switching
Date: Sun,  3 Mar 2024 11:28:41 +0100
Message-ID: <20240303102848.164108-1-ericwouds@gmail.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Based on the comments in [PATCH net-next]
"Realtek RTL822x PHY rework to c45 and SerDes interface switching"

Adds SerDes switching interface between 2500base-x and sgmii for
rtl822x and rtl8251b.

Add get_rate_matching() for rtl822x and rtl8251b, reading the serdes
mode from phy.

Driver instances are added for rtl8221b and rtl8251b for Clause 45
access only. The existing code is not touched, they use newly added
functions. They also use the same rtl822x_config_init() and
rtl822x_get_rate_matching() as these functions also can be used for
direct Clause 45 access. Also Adds definition of MMC 31 registers,
which cannot be used through C45-over-C22, only when phydev->is_c45
is set.

Change rtlgen_get_speed() so the register value is passed as argument.
Using Clause 45 access, this value is retrieved differently.
Rename it to rtlgen_decode_speed() and add a call to it in
rtl822x_c45_read_status().

Add rtl822x_c45_get_features() to set supported ports.

Then 2 quirks are added for sfp modules known to have a rtl8221b
behind RollBall, Clause 45 only, protocol.

Changed in PATCH v2:

* Set author to Marek for the commit of the new C45 instances
* Separate commit for setting supported ports
* Renamed rtlgen_get_speed to rtlgen_decode_speed
* Always fill in possible interfaces
* Renamed sfp_fixup_oem_2_5g to sfp_fixup_oem_2_5gbaset
* Only update phydev->interface when link is up

Alexander Couzens (1):
  net: phy: realtek: configure SerDes mode for rtl822x/8251b PHYs

Eric Woudstra (4):
  net: phy: realtek: add get_rate_matching() for rtl822x/8251b PHYs
  net: phy: realtek: Change rtlgen_get_speed() to rtlgen_decode_speed()
  net: phy: realtek: add rtl822x_c45_get_features() to set supported
    ports
  net: sfp: Fixup for OEM SFP-2.5G-T module

Marek Behún (2):
  net: phy: realtek: Add driver instances for rtl8221b/8251b via Clause
    45
  net: sfp: add quirk for another multigig RollBall transceiver

 drivers/net/phy/realtek.c | 325 +++++++++++++++++++++++++++++++++++---
 drivers/net/phy/sfp.c     |  10 +-
 2 files changed, 312 insertions(+), 23 deletions(-)

-- 
2.42.1


