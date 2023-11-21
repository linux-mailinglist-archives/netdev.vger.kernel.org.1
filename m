Return-Path: <netdev+bounces-49599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F353D7F2AFE
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 11:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEDDD282073
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 10:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746E947796;
	Tue, 21 Nov 2023 10:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dQAx+xrH"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB54595;
	Tue, 21 Nov 2023 02:51:09 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9428F6000B;
	Tue, 21 Nov 2023 10:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1700563868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=A3NccixUkZgOsEUs7FqXe1NE2YZDf8SEnuhprc2W6ZM=;
	b=dQAx+xrHxBTgX9Xp5PcYtc6mX8O/vZ53FjFsyyoWnUkrNQVkhie5NI3uPthA3/OjRQ1pKi
	2e6QBIJuNcolSKLbo1o/NHj2+aa7LaUouBgjlbd0ubtwn4cw6mQA5Dog7xJe34V6liJRKw
	6rI4yv/hJREMP68lbsU+jXQ3OTHC/diWb6OPMmcfVF48Jk/0Ernu8CBl4ujUbcylJzLKHn
	ljilaBb1ts9OkKj+F7uhN7i2kUQYSK3YJz8TyxkOG0LBnT2vfL/jkSwV8TS9EIyzq1thC6
	HdDVqRLbKqnhHbts1Esqvmv3+GSaZhWYRLB3monugxHyXzAny5pmuno9dQWBeA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 21 Nov 2023 11:50:35 +0100
Subject: [PATCH net-next v2] firmware_loader: Expand Firmware upload error
 codes with firmware invalid error
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231121-feature_firmware_error_code-v2-1-f879a7734a4e@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAHqLXGUC/42NQQrCMBBFr1JmbaRJlaSuvIeUkqYTO6CJTGKtl
 N7d0BO4+48H76+QkAkTXKoVGGdKFEMBdajATTbcUdBYGFStGimlFh5tfjP2nvj5sWUgc+TexRH
 FYEZtfW2s8Qil8GL0tOz1GwTMIuCSoStmopQjf/fbWe7+r4dZCila5Vrd2HNtTvo6xJgfFI4uP
 qHbtu0Hl7pOJtIAAAA=
To: Jakub Kicinski <kuba@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
 Russ Weight <russ.weight@linux.dev>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>, 
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com

No error code are available to signal an invalid firmware content.
Drivers that can check the firmware content validity can not return this
specific failure to the user-space

Expand the firmware error code with an additional code:
- "firmware invalid" code which can be used when the provided firmware
  is invalid

Acked-by: Luis Chamberlain <mcgrof@kernel.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

This patch was initially submitted as part of a net patch series.
Conor expressed interest in using it in a different subsystem.
https://lore.kernel.org/netdev/20231116-feature_poe-v1-7-be48044bf249@bootlin.com/

Consequently, I extracted it from the series and submitted it separately.
I first tried to send it to driver-core but it seems also not the best
choice:
https://lore.kernel.org/lkml/2023111720-slicer-exes-7d9f@gregkh/

Jakub could you create a stable branch for this patch and share the branch
information? This way other Maintainers can then pull the patch.
---
 drivers/base/firmware_loader/sysfs_upload.c | 1 +
 include/linux/firmware.h                    | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/base/firmware_loader/sysfs_upload.c b/drivers/base/firmware_loader/sysfs_upload.c
index a0af8f5f13d8..829270067d16 100644
--- a/drivers/base/firmware_loader/sysfs_upload.c
+++ b/drivers/base/firmware_loader/sysfs_upload.c
@@ -27,6 +27,7 @@ static const char * const fw_upload_err_str[] = {
 	[FW_UPLOAD_ERR_INVALID_SIZE] = "invalid-file-size",
 	[FW_UPLOAD_ERR_RW_ERROR]     = "read-write-error",
 	[FW_UPLOAD_ERR_WEAROUT]	     = "flash-wearout",
+	[FW_UPLOAD_ERR_FW_INVALID]   = "firmware-invalid",
 };
 
 static const char *fw_upload_progress(struct device *dev,
diff --git a/include/linux/firmware.h b/include/linux/firmware.h
index de7fea3bca51..0311858b46ce 100644
--- a/include/linux/firmware.h
+++ b/include/linux/firmware.h
@@ -27,6 +27,7 @@ struct firmware {
  * @FW_UPLOAD_ERR_INVALID_SIZE: invalid firmware image size
  * @FW_UPLOAD_ERR_RW_ERROR: read or write to HW failed, see kernel log
  * @FW_UPLOAD_ERR_WEAROUT: FLASH device is approaching wear-out, wait & retry
+ * @FW_UPLOAD_ERR_FW_INVALID: invalid firmware file
  * @FW_UPLOAD_ERR_MAX: Maximum error code marker
  */
 enum fw_upload_err {
@@ -38,6 +39,7 @@ enum fw_upload_err {
 	FW_UPLOAD_ERR_INVALID_SIZE,
 	FW_UPLOAD_ERR_RW_ERROR,
 	FW_UPLOAD_ERR_WEAROUT,
+	FW_UPLOAD_ERR_FW_INVALID,
 	FW_UPLOAD_ERR_MAX
 };
 

---
base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
change-id: 20231117-feature_firmware_error_code-b8d7af08a8fe

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


