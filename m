Return-Path: <netdev+bounces-83889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F04894AFD
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 07:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0B98282AB6
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 05:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8B5182B3;
	Tue,  2 Apr 2024 05:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSMz7pwX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FBF323D
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 05:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712037540; cv=none; b=sPgTDG58v49KgYtdWdC9X9NgYlfoiLMR68+a3Zjnv+sFiqDKlair+Lbi1c8dou9HE8L6pPtR1M8p6q8UvcqtS0HaBb1Spgy41EemuSWNSh07q+lNqyr0IissUOdDqmLL1fVOehrVcKXpBbJ4unn/08Kz698jpmVQSXSLkOMz07o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712037540; c=relaxed/simple;
	bh=JHpK7F129BRN/2ChpNokqZOOynTLQmnd07EAZ08OUz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fbx8aBq1Uri/0iaQoFIsAy7gbRWUFPP130QWQ8IGPn7iI37OkqBHHDMZj5mrmEAlC+GGk9LGj7VYvyLRK/nkGDU+lkOH55Vnxekx1WG7N9nrkwkgwPu/nudJrVgPgXvBHdK8lR9D439/VEkD6RSWkYKwORtqJ7wiDrKrmfuADVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSMz7pwX; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56c5d05128dso3200025a12.0
        for <netdev@vger.kernel.org>; Mon, 01 Apr 2024 22:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712037537; x=1712642337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=03piG+5W1Pn6SEuRFGlLq3L2yfVa5u5uupaNZARH38g=;
        b=ZSMz7pwXzxxJWKvxrhXbXhtjyejM9RFEq7jRyZ1S94//nVSW6B+SWUigoBibhT+6Ja
         dVTZIGiUekBljqY62ky0d1wH+OCLhdAFfoABrog2Qm9/5J/O1F0iZDz8rewFu8d0WfE6
         uLGeM4rOGeM//6tRG+kwmcgICE5qAPvAmsLUrJO+YMA0lUS7GeMH6wAfKIlwzTtL5TlY
         hW7ApWxr2mCfPUrf7yzXhMgiAW9FdlDHeNAFwJuoM45ilJlxsZDv2uIn/RnsNqzJ2JZ1
         7bljNEUaCwUNRi7HCJ6TRMpwCr288OTKzKg7FpbmDF8Ou7UPF9FYXvrW7s7hjaqBSOA7
         oeHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712037537; x=1712642337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=03piG+5W1Pn6SEuRFGlLq3L2yfVa5u5uupaNZARH38g=;
        b=FT8X499EOPLjuGOZEZWcFko+T7STjJ437hHNuFO88v3yadmGKueVzg91yguFIPVgEr
         8S6DH6+MMQxIWi7giWAD5fp0nJ3qBzvS17lF8BQIAhC6mk6D7PUXqaqMdk1wjkN4qU1b
         JJNRnt0TnTqm5yvv0b1XCRspHhpT/bh1MjUekTmaOb18uWPY2AMexX81ZQA/RP2Lv55b
         X1S6l+V3HfpxiAme0MW0mI/BNxzLqHsxUPlr46W3XDIndsnezlEAIS+SQSjn45IWz7kA
         Pjvp21MuF+MvSMCpE+Ib8R2p7mwiUs766YnCoGUtd86DNdlqudA9JebrbI4QsAgCctkA
         BkCw==
X-Gm-Message-State: AOJu0YwndoP3ZhUDBUYQCz438dl4UsjCEJ+A2l1H4gqjgRzaGbMNm4Te
	UfxzrhuDKfPfrE+d0pvI7zHc6XcTmPRQcFWSASGFNAhUmizlO5SnkUY1lnRIyWM=
X-Google-Smtp-Source: AGHT+IEtuMkPlU+kaigSUFEIWSpl8EZ0vtEuTKErRuYAerHie9t6E2h+uLloHdov98mNuGElGoNByg==
X-Received: by 2002:a17:907:3185:b0:a4e:3775:9e7c with SMTP id xe5-20020a170907318500b00a4e37759e7cmr8966351ejb.56.1712037536684;
        Mon, 01 Apr 2024 22:58:56 -0700 (PDT)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id cd1-20020a170906b34100b00a4a396ba54asm6136636ejb.93.2024.04.01.22.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 22:58:56 -0700 (PDT)
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
Subject: [PATCH v3 net-next 0/6] rtl8226b/8221b add C45 instances and SerDes switching
Date: Tue,  2 Apr 2024 07:58:42 +0200
Message-ID: <20240402055848.177580-1-ericwouds@gmail.com>
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

Add rtl822x_c45_get_features() to set supported ports for rtl8221b.

Then 1 quirk is added for sfp modules known to have a rtl8221b
behind RollBall, Clause 45 only, protocol.

Changed in PATCH v3:
* Only apply to rtl8221b and rtl8226b phy's
* Set phydev->rate_matching in .config_init()
* Removed OEM SFP fixup for now, as there are modules with the same
  vendor name/PN, but with different PHY's. We found rtl8221b, but
  also the ty8821, which is not supported.

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
    ports

Marek Behún (2):
  net: phy: realtek: Add driver instances for rtl8221b via Clause 45
  net: sfp: add quirk for another multigig RollBall transceiver

 drivers/net/phy/realtek.c | 327 +++++++++++++++++++++++++++++++++++---
 drivers/net/phy/sfp.c     |   1 +
 2 files changed, 302 insertions(+), 26 deletions(-)

-- 
2.42.1


