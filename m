Return-Path: <netdev+bounces-55082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B80A8094D6
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 22:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5AD1282173
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 21:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1354B840CE;
	Thu,  7 Dec 2023 21:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I6d86M7H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778121727
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 13:42:24 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db548aff7baso1837300276.2
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 13:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701985343; x=1702590143; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cXooN35iBzAeNwLGwjaiKNH4Ne5XKWGQIuv5jnegq+c=;
        b=I6d86M7HjYJCDS0WvA8RUxJK4e7SCqyWcP0u6en/boXSyvEOIS3fbMCLqa890nttnv
         CgyMPyaGE7WOdRBeGpiP+DleEVLg9C2qs6eO5QjR/fZDz70ZCs5BZTjGO9XgulIehJhH
         Eu0/WcxSQCKlNDTAPnDYE+krCPXwbeYPEnxdBLkG7SlUi/6Jeq637hNE67JFVavSkc0M
         R0Hrh1cCvrxAtV5y2MdP9YROtu4KzL1G4bHYC0Au88EL7MihpNWf/9Q4WFTor6zHDiBA
         jnUIyoJyJ1OMd2ELQdwrBIjFniZhXHDRAdXGo6XCI3eYINaRvH6M9DubBJdlDBECTJqM
         Qsfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701985343; x=1702590143;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cXooN35iBzAeNwLGwjaiKNH4Ne5XKWGQIuv5jnegq+c=;
        b=fhg27/BGRcn7ucZySvRYvSQbt5ZjRz7Norz3gzJSdzkxDLevlduR59jILer2OkZCav
         WqUjWd0hZrWwYt64nyat3XuVCTXS3nvWbB11RpXx8hCLmY1y4IMlOdCmXJt/awbb6DAZ
         NFZsPssf7fjDHxZB+9XbsMwLDm1C6LEMZiIWJSkRCjka7It1ta4Z+Trii4b415WLxb+y
         4D7LjU/IWjs/w5CPfnwYFFvd+pNCK5/Osptrvt9nZosWD4N89RgYhrcOBaO+lilPKulG
         qeFxsPWhJ2Y0ElNiOm31iMJ0f24u08ZTYzkgiU/uPL4fshTWsx65Sc04KRsKsmz9/Pd3
         oK8Q==
X-Gm-Message-State: AOJu0Yx+daG+PVGuo2pOFPNZtxtzFHMj6xPfBoCx07WY2NTdFz2z3Cl6
	NNybqEMlqZmM8Fowk+x/yP2kMvCTEs7w3VPO4Q==
X-Google-Smtp-Source: AGHT+IHq7cnfGhS5kWGB92EkWvDF38ii4Kr82JtwvvglH7Drxa0FH5GqwrlG85VNZGEWG7j5QIDwKgpUeUUc95Q4lg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:cc4b:0:b0:db5:3bdf:ff55 with SMTP
 id l72-20020a25cc4b000000b00db53bdfff55mr38164ybf.6.1701985343690; Thu, 07
 Dec 2023 13:42:23 -0800 (PST)
Date: Thu, 07 Dec 2023 21:42:22 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAD08cmUC/62OTQ6CMBSEr2K69pn+SKyuvIchRNsHvARbbJsGQ
 ri7hYUncDXzzeabhUUMhJHdDgsLmCmSdwXk8cBM/3QdAtnCTHKpBBcSYgrOjDPYQBlDBIcJMPU
 YtvIZfEemhHG/aLSapoYcJTBw0ZXm4mpNpRUrjjFgS9Puf9SFe4rJh3m/k8W2/sucBQhoOefaV nhWL7x33ncDnox/s3pd1y8H5qObCwEAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701985342; l=3363;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=arW5/NshuDKnzlGPsdZ6VG016W07pYtyXnB5penkACQ=; b=Y+w93P3+97VcZk0K+Ib4bcU9zZBeUNMTZ3FduqPc+Jwb6Y61xtrpf8x0x+gaXm4EE1hafjk/s
 vet9G1k0/55DVqURJqdlUdIhtzP78WQNj/Vrtx9i2gvws3WK6mO2k/V
X-Mailer: b4 0.12.3
Message-ID: <20231207-strncpy-drivers-net-ethernet-qlogic-qlcnic-qlcnic_83xx_init-c-v2-1-eb1a20a91b2a@google.com>
Subject: [PATCH v2] qlcnic: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Shahed Shaikh <shshaikh@marvell.com>, Manish Chopra <manishc@marvell.com>, 
	GR-Linux-NIC-Dev@marvell.com, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect fw_info->fw_file_name to be NUL-terminated based on its use
within _request_firmware_prepare() wherein `name` refers to it:
|       if (firmware_request_builtin_buf(firmware, name, dbuf, size)) {
|               dev_dbg(device, "using built-in %s\n", name);
|               return 0; /* assigned */
|       }
... and with firmware_request_builtin() also via `name`:
|       if (strcmp(name, b_fw->name) == 0) {

There is no evidence that NUL-padding is required.

Additionally replace size macro (QLC_FW_FILE_NAME_LEN) with
sizeof(fw_info->fw_file_name) to more directly tie the maximum buffer
size to the destination buffer:

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- update commit msg with sizeof() rationale (thanks Kees)
- rebase onto mainline bee0e7762ad2c602
- Link to v1: https://lore.kernel.org/r/20231012-strncpy-drivers-net-ethernet-qlogic-qlcnic-qlcnic_83xx_init-c-v1-1-f0008d5e43be@google.com
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c
index c95d56e56c59..b733374b4dc5 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c
@@ -2092,8 +2092,8 @@ static int qlcnic_83xx_run_post(struct qlcnic_adapter *adapter)
 		return -EINVAL;
 	}
 
-	strncpy(fw_info->fw_file_name, QLC_83XX_POST_FW_FILE_NAME,
-		QLC_FW_FILE_NAME_LEN);
+	strscpy(fw_info->fw_file_name, QLC_83XX_POST_FW_FILE_NAME,
+		sizeof(fw_info->fw_file_name));
 
 	ret = request_firmware(&fw_info->fw, fw_info->fw_file_name, dev);
 	if (ret) {
@@ -2396,12 +2396,12 @@ static int qlcnic_83xx_get_fw_info(struct qlcnic_adapter *adapter)
 		switch (pdev->device) {
 		case PCI_DEVICE_ID_QLOGIC_QLE834X:
 		case PCI_DEVICE_ID_QLOGIC_QLE8830:
-			strncpy(fw_info->fw_file_name, QLC_83XX_FW_FILE_NAME,
-				QLC_FW_FILE_NAME_LEN);
+			strscpy(fw_info->fw_file_name, QLC_83XX_FW_FILE_NAME,
+				sizeof(fw_info->fw_file_name));
 			break;
 		case PCI_DEVICE_ID_QLOGIC_QLE844X:
-			strncpy(fw_info->fw_file_name, QLC_84XX_FW_FILE_NAME,
-				QLC_FW_FILE_NAME_LEN);
+			strscpy(fw_info->fw_file_name, QLC_84XX_FW_FILE_NAME,
+				sizeof(fw_info->fw_file_name));
 			break;
 		default:
 			dev_err(&pdev->dev, "%s: Invalid device id\n",

---
base-commit: bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
change-id: 20231012-strncpy-drivers-net-ethernet-qlogic-qlcnic-qlcnic_83xx_init-c-7858019dc583

Best regards,
--
Justin Stitt <justinstitt@google.com>


