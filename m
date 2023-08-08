Return-Path: <netdev+bounces-25565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FEA774C56
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 23:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FCBD1C20EB0
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 21:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58E9171AE;
	Tue,  8 Aug 2023 21:06:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74EE15495
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 21:06:00 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D501444AA
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 14:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Content-Disposition:In-Reply-To:References;
	bh=jZMvn5ht/Go/zujD6mS25V48zpSAnsygd8QTlP50OrM=; b=o+8pmZ5MPPQtZnLv4kiuR6lLjh
	QBGOGovinCtMKExRevb3t9G+RYGAlsVF/VHHaTzy+g58Huo5vqmwgZhQ24j1PXrYJq4PMh9Sn7pJZ
	mIzxTBz1Lf4yhfdyXCy1FvJlsWGlDxpfXGh4WKN+y3Vn9P24ssAR286Zq3+oE3l1ei4U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qTTsw-003WGM-QL; Tue, 08 Aug 2023 23:04:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: netdev <netdev@vger.kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Simon Horman <simon.horman@corigine.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next v3 0/4] Support offload LED blinking to PHY.
Date: Tue,  8 Aug 2023 23:04:32 +0200
Message-Id: <20230808210436.838995-1-andrew@lunn.ch>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Allow offloading of the LED trigger netdev to PHY drivers and
implement it for the Marvell PHY driver. Additionally, correct the
handling of when the initial state of the LED cannot be represented by
the trigger, and so an error is returned. As with ledtrig-timer,
disable offload when the trigger is deactivate, or replaced by another
trigger.

Since v2:
Add support for link speeds, not just link
Add missing checks for return values
Add patch disabling offload when driver is deactivated

Since v1:

Add true kerneldoc for the new entries in struct phy_driver
Add received Reviewed-by: tags

Since v0:

Make comments in struct phy_driver look more like kerneldoc
Add cover letter

Andrew Lunn (4):
  led: trig: netdev: Fix requesting offload device
  net: phy: phy_device: Call into the PHY driver to set LED offload
  net: phy: marvell: Add support for offloading LED blinking
  leds: trig-netdev: Disable offload on deactivation of trigger

 drivers/leds/trigger/ledtrig-netdev.c |  10 +-
 drivers/net/phy/marvell.c             | 281 ++++++++++++++++++++++++++
 drivers/net/phy/phy_device.c          |  68 +++++++
 include/linux/phy.h                   |  33 +++
 4 files changed, 389 insertions(+), 3 deletions(-)

-- 
2.40.1


