Return-Path: <netdev+bounces-137922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 624FC9AB1CA
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 17:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 165121F22710
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 15:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E631A38C4;
	Tue, 22 Oct 2024 15:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KP2N7bjN"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2DA1A38EC;
	Tue, 22 Oct 2024 15:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729610067; cv=none; b=uFIT+aUIAdnSbbJ4zZ4Nyw2ONS1qeOXYFkt6D2bMUW8PtCt5bE7mLr3zjBm5gwHh81yGcI7qFheX7/54sH+KK3TI3EsXjtqdP6PHfYtm7sYsJrb+wLmWoN3KzoagSITR3gexSXlk6Bucmr9aQI3JSi9Bzv17BV+/GvHmp3mOISw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729610067; c=relaxed/simple;
	bh=2j66laylThSRY13caSNR6w/TLOJUvqt5xCyMELBnxMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NErzhVe7f548TyC9dwGLeehqdNyvLtkmnu63E92bFvHI5hcS6yW2wC1Kl2foMjg1M02xBLDBHanBl+qDnVQHp+ek+h7QmJPC2O463tk+LOGTiff6EpknYPKZVbYn8rxU99nmSTvP24E9aUW5kHQ0gGcm2tjF6Ow8h74vdW2kQRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KP2N7bjN; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CE9B740003;
	Tue, 22 Oct 2024 15:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729610063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WMZuGFEss8a90h3z7j9YoEt5zJ2q0/R63SAnfi2dgzk=;
	b=KP2N7bjNOUyEX8AzFe46XyJDvejdaYA9l2TVWQH7fymxQlLJkiIzmXYfGpbsT1e0iUcSDU
	sYTNpkdFMmcUPPVDLKG4IQOFBDIRNMgvEkvn/ikupnYYwHXnjfW1AT6q+YuEzrxPqtOuV2
	eWbz+GQBfSMQEjMPTQluqkDJxPrh9+zZ5V9odcnXSl1U1nsH1AH4szHFqvFr5Ab/y87sIp
	6oiH4SrD1WEc1RCmt5mxnKEsaajRi+3pdmkmKf/tMksIAGWJe3iDy0rGQjxamJTcTTLe4e
	Vgsp1Jlsf9H8Y//luk0EA+7raPsVPblaVEWgyAx7c2gkIpMIjF0bI9Qg07nr7Q==
From: Kory Maincent <kory.maincent@bootlin.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	thomas.petazzoni@bootlin.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next] netlink: specs: Add missing phy-ntf command to ethtool spec
Date: Tue, 22 Oct 2024 17:14:18 +0200
Message-Id: <20241022151418.875424-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kory.maincent@bootlin.com

ETHTOOL_MSG_PHY_NTF description is missing in the ethtool netlink spec.
Add it to the spec.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 Documentation/netlink/specs/ethtool.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index f6c5d8214c7e..93369f0eb816 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -1956,3 +1956,7 @@ operations:
             - upstream-sfp-name
             - downstream-sfp-name
       dump: *phy-get-op
+    -
+      name: phy-ntf
+      doc: Notification for change in PHY devices.
+      notify: phy-get
-- 
2.34.1


