Return-Path: <netdev+bounces-38438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D558E7BAEFC
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 00:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 216EA281F79
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 22:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22A54177E;
	Thu,  5 Oct 2023 22:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tHdMIZ5t"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1E0154AB
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 22:52:45 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD520E7
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 15:52:36 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d918aef0d0dso2207172276.3
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 15:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696546356; x=1697151156; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3Oz7VGuhkfxzsvalUB4WGErH8Z4TrWqr8F51Ij8/laM=;
        b=tHdMIZ5tS8RGbySNTGbtVgs1Zm3RXGpldh3ytPh+vSsFme5ZjHyfogfTbuu0W864Z8
         HnEjq/qv5BKK/9eoLfX2INT7dGyE4Z1cQstNXT60D90gxRqI7CwxBFsJeaFh26Wuo5Av
         GPN2UsVCZLG9kIPnmCwkl01UBTunFKUIMGQv1zAerck0cbLNNjAh2TwscdyZdTD/2EvI
         1yChzX//yb2G+VD2PQZyPNtFbxlAWRV99mHxrPNK/axfMOS+8Vod7EGE3dOLzUAHjq8Y
         rM0De59R8wNUZoP90ueE64m9whQ5o7ZrksPfsVzTZMS+C9Bd/HjKxwljx/LCzJmmGvHN
         Wmeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696546356; x=1697151156;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Oz7VGuhkfxzsvalUB4WGErH8Z4TrWqr8F51Ij8/laM=;
        b=X7zUGmxcx3LE3UWRHLgecCrWCduLJjmCd9oFqw0xyRG5IcQDrTfPnbzx6Mq8v6wdt0
         QJwE0JAz+fsgTHRKwIO5hbwjguLVR9XE2F+XlMufZ8QnDQB4J65fI76kswt/A7+fG1CT
         Y/jySj4ARg+iVDd318BoACrA5Ly+CXGItRd8sHRqEShtthn/+91GslqLeiNgEdsiqtdZ
         HtvRC4hS/VbEEs92NBfwIZ6xxqixMdVQ+oSSdcDH1yXlpO71Vwx3Va20Q6y/OisvJjxq
         myyYqvKsOCUkO/UXJKkITAOn4XX7VvzrBGjt86TITF4YT5PsM3SxBsmDwErsQqXKuaVh
         xXlQ==
X-Gm-Message-State: AOJu0Ywjk+u94cwbF/WrVUZ2OtZTFZpgm6RTIFoJFUnWdlN/CWeSPbUj
	GVOkqTdzkAuaW7A8Ndddwkm1Q3q69i4X1rBpxg==
X-Google-Smtp-Source: AGHT+IGDgPSWXZdhmhN7MdmN3bf5jRSxRNUgL0WJ8V/nI7kavwxEdlz4wYNdYbzKHL6kN1emrnS5q9Xxm9oJ1JljtA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:68ce:0:b0:d86:56bc:e289 with SMTP
 id d197-20020a2568ce000000b00d8656bce289mr102971ybc.4.1696546356067; Thu, 05
 Oct 2023 15:52:36 -0700 (PDT)
Date: Thu, 05 Oct 2023 22:52:34 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADI+H2UC/x2NywrCMBAAf6Xs2YU0Nb5+RUTqZmsXNKmbNCil/
 270NnOZWSCxCic4NQsoF0kSQ5V20wCNfbgziq8O1tiuNcZhyhpo+qBXKawJA2fkPLL+gPoi8xM f8prFS8RImWO4+homRsLO7Y92t70NB+OgLiblQd7//fmyrl/ZrJ0VjgAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696546354; l=2673;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=fHSGB3GybAy+lcwImCPC6umWTJnnaa6Fe/COzeftew4=; b=2ACCQqBmGkLvXioby9De9Mcm2kl8X/AKHpYXgLlmc18u5LikoehfZYt35LQvAVFalOi3YAlDi
 +/o6ilE3nP7AZKwVkQdZGhrazudQ3OAHN7r1l377kiu1UNfXo7neP/x
X-Mailer: b4 0.12.3
Message-ID: <20231005-strncpy-drivers-net-ethernet-cavium-liquidio-octeon_device-c-v1-1-9a207cef9438@google.com>
Subject: [PATCH] cavium/liquidio: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Derek Chickles <dchickles@marvell.com>, Satanand Burla <sburla@marvell.com>, 
	Felix Manlunas <fmanlunas@marvell.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect `app_name` to be NUL-terminated:
	dev_info(&oct->pci_dev->dev,
		 "Running %s (%llu Hz)\n",
		 app_name, CVM_CAST64(cs->corefreq));
... and it seems NUL-padding is not required, let's opt for strscpy().

For `oct->boardinfo.name/serial_number` let's opt for strscpy() as well
since it is expected to be NUL-terminated and does not require
NUL-padding as `oct` is zero-initialized in octeon_device.c +707:
|       buf = vzalloc(size);
|       if (!buf)
|       	return NULL;
|
|       oct = (struct octeon_device *)buf;

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/net/ethernet/cavium/liquidio/octeon_device.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/octeon_device.c b/drivers/net/ethernet/cavium/liquidio/octeon_device.c
index 364f4f912dc2..6b6cb73482d7 100644
--- a/drivers/net/ethernet/cavium/liquidio/octeon_device.c
+++ b/drivers/net/ethernet/cavium/liquidio/octeon_device.c
@@ -1217,10 +1217,10 @@ int octeon_core_drv_init(struct octeon_recv_info *recv_info, void *buf)
 		goto core_drv_init_err;
 	}
 
-	strncpy(app_name,
+	strscpy(app_name,
 		get_oct_app_string(
 		(u32)recv_pkt->rh.r_core_drv_init.app_mode),
-		sizeof(app_name) - 1);
+		sizeof(app_name));
 	oct->app_mode = (u32)recv_pkt->rh.r_core_drv_init.app_mode;
 	if (recv_pkt->rh.r_core_drv_init.app_mode == CVM_DRV_NIC_APP) {
 		oct->fw_info.max_nic_ports =
@@ -1257,9 +1257,10 @@ int octeon_core_drv_init(struct octeon_recv_info *recv_info, void *buf)
 	memcpy(cs, get_rbd(
 	       recv_pkt->buffer_ptr[0]) + OCT_DROQ_INFO_SIZE, sizeof(*cs));
 
-	strncpy(oct->boardinfo.name, cs->boardname, OCT_BOARD_NAME);
-	strncpy(oct->boardinfo.serial_number, cs->board_serial_number,
-		OCT_SERIAL_LEN);
+	strscpy(oct->boardinfo.name, cs->boardname,
+		    sizeof(oct->boardinfo.name));
+	strscpy(oct->boardinfo.serial_number, cs->board_serial_number,
+		    sizeof(oct->boardinfo.serial_number));
 
 	octeon_swap_8B_data((u64 *)cs, (sizeof(*cs) >> 3));
 

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231005-strncpy-drivers-net-ethernet-cavium-liquidio-octeon_device-c-3579264bf805

Best regards,
--
Justin Stitt <justinstitt@google.com>


