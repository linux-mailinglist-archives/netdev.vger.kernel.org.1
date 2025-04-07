Return-Path: <netdev+bounces-179793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5A6A7E869
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80A8118956F8
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 17:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B4021ADAB;
	Mon,  7 Apr 2025 17:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LfgpScDF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009B621931E
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 17:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047131; cv=none; b=j4PbLq1Y0gzoqhfb5dOy4C0mIXY0C3uuRFXXsqtryHaqnDbziNVjFwTsnqE8OW7KpeppJNDCRCIvJ5mN+OUCAMCwFB9WfO7RmCMeS9JHiwCB7IGTXOuJBXaHGB3B/X6FOkeBJoW1tG7my/IQsVypt4XMZDvwonbzpGEmL9fJ2Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047131; c=relaxed/simple;
	bh=514kAmrhGuHv4oZb4ZbGQ+3ynXJnMvwu1BF8ij5YNts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RAC8zHyatSzRa2rXQmCTeTSKELt29Znmp2Mm9mnEJ8PCzNdcyWty3moYdwBtGL1XLMjWZ5+JD3VQhKYzCY3tYmY7FPThn1It89xrpKdm/fcpr2ORBtyC5shOfDPOrOtDBac/NTjTLPVgdNAPpMS1ZU3kku3ByblO5gkhG9rDiZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LfgpScDF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744047129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fGIjBEcrhQWS3vGRuAYETRUbaEuHXfFrZ4Y6pHxlPf0=;
	b=LfgpScDFBJ84cvHbmNtcjfKR45426h/qy9TEHlCZ/JJqNxzrcAZIs1mzsRdO4IcU+kq9BS
	48PtIsRIJ4ob5FXtNYkVq9o0Jvpp9b4X7uebs1YRoTs5rC1X8L0TPeIg7I+6k8GU6VsN36
	/zWiO01ALP12jnnu6bH9TzHxLQpHp10=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-iXQzf7EmMXS-JL9YSKuBcg-1; Mon,
 07 Apr 2025 13:32:05 -0400
X-MC-Unique: iXQzf7EmMXS-JL9YSKuBcg-1
X-Mimecast-MFC-AGG-ID: iXQzf7EmMXS-JL9YSKuBcg_1744047122
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9749D18001FC;
	Mon,  7 Apr 2025 17:32:02 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.4])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E27C91956094;
	Mon,  7 Apr 2025 17:31:56 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Michal Schmidt <mschmidt@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Lee Jones <lee@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 11/28] mfd: zl3073x: Load mfg file into HW if it is present
Date: Mon,  7 Apr 2025 19:31:41 +0200
Message-ID: <20250407173149.1010216-2-ivecera@redhat.com>
In-Reply-To: <20250407172836.1009461-1-ivecera@redhat.com>
References: <20250407172836.1009461-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Add support for loading mfg file that can be provided
by a user. The mfg file can be generated by Microchip
tool and contains snippets of device configuration
that is different from the one stored in the flash
memory inside the chip.

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/mfd/zl3073x-core.c | 106 +++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/drivers/mfd/zl3073x-core.c b/drivers/mfd/zl3073x-core.c
index 5570de58c46e4..9920c5329d50f 100644
--- a/drivers/mfd/zl3073x-core.c
+++ b/drivers/mfd/zl3073x-core.c
@@ -424,6 +424,108 @@ struct zl3073x_dev *zl3073x_dev_alloc(struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(zl3073x_dev_alloc, "ZL3073X");
 
+static int zl3073x_fw_parse_line(struct zl3073x_dev *zldev, const char *line)
+{
+#define ZL3073X_FW_WHITESPACES_SIZE	3
+#define ZL3073X_FW_COMMAND_SIZE		1
+	const char *ptr = line;
+	char *endp;
+	u32 delay;
+	u16 addr;
+	u8 val;
+
+	switch (ptr[0]) {
+	case 'X':
+		/* The line looks like this:
+		 * X , ADDR , VAL
+		 * Where:
+		 *  - X means that is a command that needs to be executed
+		 *  - ADDR represents the addr and is always 2 bytes and the
+		 *         value is in hex, for example 0x0232
+		 *  - VAL represents the value that is written and is always 1
+		 *        byte and the value is in hex, for example 0x12
+		 */
+		ptr += ZL3073X_FW_COMMAND_SIZE;
+		ptr += ZL3073X_FW_WHITESPACES_SIZE;
+		addr = simple_strtoul(ptr, &endp, 16);
+
+		ptr = endp;
+		ptr += ZL3073X_FW_WHITESPACES_SIZE;
+		val = simple_strtoul(ptr, NULL, 16);
+
+		/* Write requested value to given register */
+		return zl3073x_write_reg(zldev, addr, 1, &val);
+	case 'W':
+		/* The line looks like this:
+		 * W , DELAY
+		 * Where:
+		 *  - W means that is a wait command
+		 *  - DELAY represents the delay in microseconds and the value
+		 *    is in decimal
+		 */
+		ptr += ZL3073X_FW_COMMAND_SIZE;
+		ptr += ZL3073X_FW_WHITESPACES_SIZE;
+		delay = simple_strtoul(ptr, NULL, 10);
+
+		fsleep(delay);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+#define ZL3073X_MFG_FILE "microchip/zl3073x.mfg"
+
+static void zl3073x_fw_load(struct zl3073x_dev *zldev)
+{
+	const struct firmware *fw;
+	const char *ptr, *end;
+	char buf[128];
+	int rc;
+
+	rc = firmware_request_nowarn(&fw, ZL3073X_MFG_FILE, zldev->dev);
+	if (rc)
+		return;
+
+	dev_info(zldev->dev, "Applying mfg file %s...\n", ZL3073X_MFG_FILE);
+
+	guard(zl3073x)(zldev);
+
+	ptr = fw->data;
+	end = ptr + fw->size;
+	while (ptr < end) {
+		/* Get next end of the line or end of buffer */
+		char *eol = strnchrnul(ptr, end - ptr, '\n');
+		size_t len = eol - ptr;
+
+		/* Check line length */
+		if (len >= sizeof(buf)) {
+			dev_err(zldev->dev, "Line in firmware is too long\n");
+			return;
+		}
+
+		/* Copy line from buffer */
+		memcpy(buf, ptr, len);
+		buf[len] = '\0';
+
+		/* Parse and process the line */
+		rc = zl3073x_fw_parse_line(zldev, buf);
+		if (rc) {
+			dev_err(zldev->dev,
+				"Failed to parse firmware line: %pe\n",
+				ERR_PTR(rc));
+			break;
+		}
+
+		/* Move to next line */
+		ptr = eol + 1;
+	}
+
+	release_firmware(fw);
+}
+
 int zl3073x_dev_init(struct zl3073x_dev *zldev, u8 dev_id)
 {
 	u16 id, revision, fw_ver;
@@ -451,6 +553,9 @@ int zl3073x_dev_init(struct zl3073x_dev *zldev, u8 dev_id)
 	/* Use chip ID and given dev ID as clock ID */
 	zldev->clock_id = ((u64)id << 8) | dev_id;
 
+	/* Load mfg file if present */
+	zl3073x_fw_load(zldev);
+
 	dev_info(zldev->dev, "ChipID(%X), ChipRev(%X), FwVer(%u)\n",
 		 id, revision, fw_ver);
 	dev_info(zldev->dev, "Custom config version: %lu.%lu.%lu.%lu\n",
@@ -475,3 +580,4 @@ EXPORT_SYMBOL_NS_GPL(zl3073x_dev_exit, "ZL3073X");
 MODULE_AUTHOR("Ivan Vecera <ivecera@redhat.com>");
 MODULE_DESCRIPTION("Microchip ZL3073x core driver");
 MODULE_LICENSE("GPL");
+MODULE_FIRMWARE(ZL3073X_MFG_FILE);
-- 
2.48.1


