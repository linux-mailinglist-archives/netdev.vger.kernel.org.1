Return-Path: <netdev+bounces-85980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A194E89D308
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 09:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EF921F23774
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 07:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D4B7C0BD;
	Tue,  9 Apr 2024 07:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UaeJ3+qH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D927CF1A
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 07:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712647827; cv=none; b=qX8XfDx8y0HzUggYfQD9hmikAaCb2lMuvUVRaFhC8e9+WS6Cmlq1F+g2KPt4A5Ti+MSpSc+M9uCb2vZKFxDY58hSiRa5+m9zZ2wugS+cQTBQ8TYQ3bucnyPWCOHeTxYp+kxtloXRyQoypq+8oqE8k9VwYkfubcMW6bADBBtfXy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712647827; c=relaxed/simple;
	bh=4NI7FJKuFTQY4aeS7sl/KMUekQTpuOZyqQpny1irIHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JgQfI4HgUgm0jGEBoO+w2Kkiapbk89TTqzp7sOEGkj5zJpcBsOyezklpvEUXl6+ZtUrd2HrC1pPrDbfbMAH9u5/t9H/WnpAjdm86nIAd3QTfh6zgx0mKGB54PjX7L7uUAHX1YysUoBcKFu0k9qExrNvgcCfkePJ1mopJTlcXOeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UaeJ3+qH; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a51addddbd4so393275166b.0
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 00:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712647824; x=1713252624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xZXHyZoWTVkpInUPpZtQKeqvDq8IoSsFeE2sWjXYNbc=;
        b=UaeJ3+qHU5UbFAb7ksZWBp7msfGqN3lFN5fiDmXNLAJiil8YSguBLhqHnu2J5lEbOs
         g6ZKxuiB3j5Hq7QJZdmuofJl7lUy5k/3fpuq+I6RTTTtM51Zt8hPtsJnQNRaE9Z20E+y
         2XtzOq1d00Hw2kPl7q163hiiXeoRByIBfFMggZ9WeuQgfOrLvKw6sDwaMJ0amb5Wb5Ri
         MmSOPlXgJ18tqSgy7+IzelYhucq6F6xcmxKsbtP9Y72ywpYN4hqX5DvynIDjMtGXe3U/
         FiEdCnNyvQCXiKAWkhM1yo6OLZjYLb4iH2z2fTZuBxDDEyWDOUfXXzACe3N27jNhkdmT
         ChkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712647824; x=1713252624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xZXHyZoWTVkpInUPpZtQKeqvDq8IoSsFeE2sWjXYNbc=;
        b=BphlBdoDPgYTl58wxHVtmI+RoRfO9WvDJAN/z0Pwmy67YmXQysR19o/fozves1zQud
         8DfCloFB4uqcnKS0O19NtJodADlabeS1Yw33f3QP+yvZHzlyTod1h3OQ6bg4dHr1nbyN
         RMipaBaO947MkY+LT4INA8XUgM7ocxGonx+jKRRzpnYWsKafJR1b6/7pRtSE+XAeZb2T
         oYh4JnGIq3WVqWaxmA/s5JjsDfSjQXWIsHiL5r4bJrY1gpneUUdnINiMueI3TCWVpBrQ
         YRqZzVSD0x3ZQM2ql0APC7juwnQ5j2q4UWjvEh9XgAC9ppxTeUw4VGRe1sVFgrRulHNa
         bv0A==
X-Gm-Message-State: AOJu0YwiBFl22QuZHzhIiucVbdcL2LlYWoI5Iq48BJL744W7Il0cMfCf
	8iimCnrHOAzQtDRB+sm7avBOe+caW+/bjeYNN8qh+RRsiC+RcDVL
X-Google-Smtp-Source: AGHT+IFd5oLC+ec9FpxE2r29dnlc4hW7kCIng0kQqwpgJM9pkYwTQtaQG3vBNVaHsHqILY2F1e0XZw==
X-Received: by 2002:a17:906:f282:b0:a51:f820:14c with SMTP id gu2-20020a170906f28200b00a51f820014cmr639447ejb.20.1712647823465;
        Tue, 09 Apr 2024 00:30:23 -0700 (PDT)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id j25-20020a1709066dd900b00a473362062fsm5315694ejt.220.2024.04.09.00.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 00:30:22 -0700 (PDT)
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
Subject: [PATCH v4 net-next 0/6] rtl8226b/8221b add C45 instances and SerDes switching
Date: Tue,  9 Apr 2024 09:30:10 +0200
Message-ID: <20240409073016.367771-1-ericwouds@gmail.com>
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
rtl8221b and rtl8226b.

Add get_rate_matching() for rtl8226b and rtl8221b, reading the serdes
mode from phy.

Driver instances are added for rtl8226b and rtl8221b for Clause 45
access only. The existing code is not touched, they use newly added
functions. They also use the same rtl822xb_config_init() and
rtl822xb_get_rate_matching() as these functions also can be used for
direct Clause 45 access. Also Adds definition of MMC 31 registers,
which cannot be used through C45-over-C22, only when phydev->is_c45
is set.

Change rtlgen_get_speed() so the register value is passed as argument.
Using Clause 45 access, this value is retrieved differently.
Rename it to rtlgen_decode_speed() and add a call to it in
rtl822x_c45_read_status().

Add rtl822x_c45_get_features() to set supported port for rtl8221b.

Then 1 quirk is added for sfp modules known to have a rtl8221b
behind RollBall, Clause 45 only, protocol.

Changed in PATCH v4:
* Changed switch to if statement in rtl822xb_get_rate_matching()
* Removed setting ETHTOOL_LINK_MODE_MII_BIT in rtl822x_c45_get_features()

Changed in PATCH v3:
* Only apply to rtl8221b and rtl8226b phy's
* Set phydev->rate_matching in .config_init()
* Removed OEM SFP fixup for now, as there are modules with the same
  vendor name/PN, but with different PHY's. We found rtl8221b, but
  also the ty8821, which is not yet supported.

Changed in PATCH v2:
* Set author to Marek for the commit of the new C45 instances
* Separate commit for setting supported ports
* Renamed rtlgen_get_speed to rtlgen_decode_speed
* Always fill in possible interfaces
* Renamed sfp_fixup_oem_2_5g to sfp_fixup_oem_2_5gbaset
* Only update phydev->interface when link is up

Alexander Couzens (1):
  net: phy: realtek: configure SerDes mode for rtl822xb PHYs

Eric Woudstra (3):
  net: phy: realtek: add get_rate_matching() for rtl822xb PHYs
  net: phy: realtek: Change rtlgen_get_speed() to rtlgen_decode_speed()
  net: phy: realtek: add rtl822x_c45_get_features() to set supported
    port

Marek Behún (2):
  net: phy: realtek: Add driver instances for rtl8221b via Clause 45
  net: sfp: add quirk for another multigig RollBall transceiver

 drivers/net/phy/realtek.c | 324 +++++++++++++++++++++++++++++++++++---
 drivers/net/phy/sfp.c     |   1 +
 2 files changed, 299 insertions(+), 26 deletions(-)

-- 
2.42.1


