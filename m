Return-Path: <netdev+bounces-210103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D58B121B3
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 18:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91AB8160BB1
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 16:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0444F2F0C7F;
	Fri, 25 Jul 2025 16:13:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BC52F005A
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460026; cv=none; b=CX5ktOiOJ/IrpB+oeuStg56jEKFiH29ASPy9vSU3UR9DztVHaPLmBrUsPdyu5uidMlM5u/COgqnCciKIDBY+41Y2bAV9VHCjqj/UwlFhSG+sindtPqnYBSSkA345dpACWuktvZzCC02LvEXCVmQQVzBsmce6SUyaEhmgR57+aN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460026; c=relaxed/simple;
	bh=zvEspbrOqFn9RSWIcczY3/lJWo6eKJMva8gmyhKadKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gD/D8WHSLVxTVpsLLJGIZUlOkmRvoTRFehdklbi2HU25+Q5Yl9uXqEPCvfNRbnjlkFEbpVDlLGKC/Bgc8pMsumzKM/tjd6e26A21mPFMvot6a+rLKhFiYidj+UmrqoQd86GOuvnA6d9MeJ1bPiSHhjZ5zKC3oFxBC8+WLm417tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufL3F-0006kE-G4
	for netdev@vger.kernel.org; Fri, 25 Jul 2025 18:13:41 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufL3B-00AFcs-0I
	for netdev@vger.kernel.org;
	Fri, 25 Jul 2025 18:13:37 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 86C344498EC
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 16:13:35 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id B90BA449846;
	Fri, 25 Jul 2025 16:13:31 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 71103d78;
	Fri, 25 Jul 2025 16:13:30 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Jimmy Assarsson <extja@kvaser.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 25/27] can: kvaser_usb: Expose device information via devlink info_get()
Date: Fri, 25 Jul 2025 18:05:35 +0200
Message-ID: <20250725161327.4165174-26-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725161327.4165174-1-mkl@pengutronix.de>
References: <20250725161327.4165174-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

From: Jimmy Assarsson <extja@kvaser.com>

Expose device information via devlink info_get():
  * Serial number
  * Firmware version
  * Hardware revision
  * EAN (product number)

Example output:
  $ devlink dev
  usb/1-1.2:1.0

  $ devlink dev info
  usb/1-1.2:1.0:
    driver kvaser_usb
    serial_number 1020
    versions:
        fixed:
          board.rev 1
          board.id 7330130009653
        running:
          fw 3.22.527

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Link: https://patch.msgid.link/20250725123452.41-10-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../can/usb/kvaser_usb/kvaser_usb_devlink.c   | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c
index dbe7fa64558a..aa06bd1fa125 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c
@@ -7,5 +7,56 @@
 
 #include <net/devlink.h>
 
+#define KVASER_USB_EAN_MSB 0x00073301
+
+static int kvaser_usb_devlink_info_get(struct devlink *devlink,
+				       struct devlink_info_req *req,
+				       struct netlink_ext_ack *extack)
+{
+	struct kvaser_usb *dev = devlink_priv(devlink);
+	char buf[] = "73301XXXXXXXXXX";
+	int ret;
+
+	if (dev->serial_number) {
+		snprintf(buf, sizeof(buf), "%u", dev->serial_number);
+		ret = devlink_info_serial_number_put(req, buf);
+		if (ret)
+			return ret;
+	}
+
+	if (dev->fw_version.major) {
+		snprintf(buf, sizeof(buf), "%u.%u.%u",
+			 dev->fw_version.major,
+			 dev->fw_version.minor,
+			 dev->fw_version.build);
+		ret = devlink_info_version_running_put(req,
+						       DEVLINK_INFO_VERSION_GENERIC_FW,
+						       buf);
+		if (ret)
+			return ret;
+	}
+
+	if (dev->hw_revision) {
+		snprintf(buf, sizeof(buf), "%u", dev->hw_revision);
+		ret = devlink_info_version_fixed_put(req,
+						     DEVLINK_INFO_VERSION_GENERIC_BOARD_REV,
+						     buf);
+		if (ret)
+			return ret;
+	}
+
+	if (dev->ean[1] == KVASER_USB_EAN_MSB) {
+		snprintf(buf, sizeof(buf), "%x%08x", dev->ean[1], dev->ean[0]);
+		ret = devlink_info_version_fixed_put(req,
+						     DEVLINK_INFO_VERSION_GENERIC_BOARD_ID,
+						     buf);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 const struct devlink_ops kvaser_usb_devlink_ops = {
+	.info_get = kvaser_usb_devlink_info_get,
 };
-- 
2.47.2



