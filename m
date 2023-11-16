Return-Path: <netdev+bounces-48355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2397EE238
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 15:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE4C528166A
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 14:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE3E32C6C;
	Thu, 16 Nov 2023 14:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PqFyl7tH"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F154719D;
	Thu, 16 Nov 2023 06:02:02 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C20DA2000C;
	Thu, 16 Nov 2023 14:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1700143321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OI8MkD291CkzowE8oOm7BtXKSZyE48TtKxrx2423dGY=;
	b=PqFyl7tHI5VwR2GOARvmf21vfQJHzN4P4RzOkxQxMv/UTvrX/e3gfY2i1BuwBYzgU2HXw2
	lpEasKjgsNYMeifH1bMhFgS+ymFEBYOO0TDxk4SMS/LByS/HLdZVZD+4lfJ6Gm+Y62t7Qm
	29AzrWMpxyePVxBNxcU2QdrL2i68FVQxyUABYG4R93h/VRz08kQvAqEGpEJhYQLWifTYUm
	sWOjvTISFLqnLdrC+O3TsAkpDzwf+jlsSjYn+WM6IJsaKwzDfFTkTu+Ngb1M1Os34QhxHY
	DIEejjoeiJAIVw+O67XZ/k5q4tztZ5ma6YaR+uNWnZocCJ74R8RRLycrre1aOw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 16 Nov 2023 15:01:39 +0100
Subject: [PATCH net-next 7/9] firmware_loader: Expand Firmware upload error
 codes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231116-feature_poe-v1-7-be48044bf249@bootlin.com>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
In-Reply-To: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 devicetree@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com

No error code are available to signal an invalid firmware content.
Drivers that can check the firmware content validity can not return this
specific failure to the user-space

Expand the firmware error code with an additional code:
- "firmware invalid" code which can be used when the provided firmware
  is invalid

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
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
 

-- 
2.25.1


