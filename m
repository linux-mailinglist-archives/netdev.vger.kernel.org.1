Return-Path: <netdev+bounces-119943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBFA957A8C
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 02:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BB371C23247
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 00:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C387483;
	Tue, 20 Aug 2024 00:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="N+1tvxOM"
X-Original-To: netdev@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B36A927;
	Tue, 20 Aug 2024 00:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724114688; cv=none; b=busmnXU+7zyD0SVEHnljb+yz1BBChSX+k3bIGABHpLQ2WcDLXdAtoov3umJuL3XFWst6bozVqLRxdLleMK2mMc6XuAug6DlyByDRsKjw+q0/+AeVT4Ra31pSot5M8btPvUfihpHo5qgNZPK7uSL9kESVl2fwXviu20fdztIZMOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724114688; c=relaxed/simple;
	bh=SbiisiIvxEcOi5m79B5jAzNtkKLrvWHvBdoUL5vr+4o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FZ3a8x+Mr4czZyWpatthnJ92EiTlH/lzFokBDfJTWGMeZjLaucmAAAdUOpArutV+Jdfj8AFfiFZ7C/hy993/p6Y5cCDU2lQX0ZFbgTtAIl3t7crEw2lTqbcsrrtHpHXqMDSIJktb/gDMmITj9n2cuQ0CM7e6KK80uSIGTZPMiBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=N+1tvxOM; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id CB187C0000EC;
	Mon, 19 Aug 2024 17:44:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com CB187C0000EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1724114678;
	bh=SbiisiIvxEcOi5m79B5jAzNtkKLrvWHvBdoUL5vr+4o=;
	h=From:To:Cc:Subject:Date:From;
	b=N+1tvxOMiLFwlf/e00X4vjlUT694Yuroeqo4sUCF3vM7BESHTXDQ8GaOBvLJGCvNU
	 jkpQg5wm+EC64zamK409Ee7zFuvg05jWBt2B/GErVRJPR2xxD/FLqN5JcZetJnDw4I
	 q3BltZkKFOMWvqLqOp9spKxzQICz3yQlJDGfztC8=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 6890418041CAE1;
	Mon, 19 Aug 2024 17:44:38 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: robimarko@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: dsa: b53: Use dev_err_probe()
Date: Mon, 19 Aug 2024 17:44:35 -0700
Message-Id: <20240820004436.224603-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than print an error even when we get -EPROBE_DEFER, use
dev_err_probe() to filter out those messages.

Link: https://github.com/openwrt/openwrt/pull/11680
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_mdio.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_mdio.c b/drivers/net/dsa/b53/b53_mdio.c
index 897e5e8b3d69..31d070bf161a 100644
--- a/drivers/net/dsa/b53/b53_mdio.c
+++ b/drivers/net/dsa/b53/b53_mdio.c
@@ -343,10 +343,9 @@ static int b53_mdio_probe(struct mdio_device *mdiodev)
 	dev_set_drvdata(&mdiodev->dev, dev);
 
 	ret = b53_switch_register(dev);
-	if (ret) {
-		dev_err(&mdiodev->dev, "failed to register switch: %i\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&mdiodev->dev, ret,
+				     "failed to register switch\n");
 
 	return ret;
 }
-- 
2.34.1


