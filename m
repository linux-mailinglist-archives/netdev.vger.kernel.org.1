Return-Path: <netdev+bounces-55079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1198094BD
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 22:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1477A1F21355
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 21:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0225730E;
	Thu,  7 Dec 2023 21:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s+igP09J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B187F47AA
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 13:34:44 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db4004a8aa9so1729358276.1
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 13:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701984884; x=1702589684; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+dxQ+lFxuekIJsQrZiGvKP2+R83S4w5OOR8cyBrT1oo=;
        b=s+igP09JeB7W1ja3SIjcYioWkjyYxBhF6Hb8HT7jCDIrnyMsSGw8J0vAg1jr38+en8
         mHLGLx3SYCzuMHzIB1LjVdqQwNv6o5X5G+0IKfFct9lhqb/TZ7M+B3PWYiCSQspjDNsa
         RpRs/TYJw9NgXe8HklByOP3c8+bNQ4TRncB/4MAXH9OURwcjjtBNLWsFOB+LqVFSsfm0
         5SBxEPX5RhtTznqN0kWawiWTYSNBNJpq3N9pz4H4GjMO4qr02WB0EDOy0WJxWHWTHVpB
         5eWyM34jkZ9bM0Nid4lQdzsuPT6iIswPjRl/TYASTGBv+XiMR55rFSmeKMBXYl6FvkZp
         VOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701984884; x=1702589684;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+dxQ+lFxuekIJsQrZiGvKP2+R83S4w5OOR8cyBrT1oo=;
        b=eL+CZVzacQUbHofTSorxXrTci6ZkdFKt0h3tsYGYI5kli/OoS3+c0o1OOhhHwphyni
         TuZCKe+G2Z0Jbd66I6MyAs3/RQEcBK9bLGQNDucPb1fsW7pInjFs8zhGExUENpYKtjHU
         LZER19vK/CjDD0uIUSinetOPX5LRWfGfSCpT/p1Dwfx02iCuhJdK4akavV7z2cZ+nDrg
         k/2jgnlhtzS9QWGBJimQvGmxVO7mjijT8XRVo7tY7C+MszbO6/gsOrtdmJ2iztWiKyAo
         eOK7qsxkWYkh42uoElqtAcU4b7o+2BeTk//N5fflw37n6TCV2YOjuTBiJ58w8RxgqsIM
         ZedQ==
X-Gm-Message-State: AOJu0YyKabOlVwd+q+lxSxA8ZiOkI/NTtFNFYIZmynB6fFt+YSua4r/v
	Gzpowlvd1VmVs0jt9ankH7X2VEcUmNFiH5KWzQ==
X-Google-Smtp-Source: AGHT+IEgzdAATHoxhjUVd4cnR3dvFK0Qlar2PLS7jkiyijD9vhvYac3HXo2lIis5WbXhIOSPsw0S25yOh/YRBaCX5w==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:3144:0:b0:db3:f436:5714 with SMTP
 id x65-20020a253144000000b00db3f4365714mr45374ybx.0.1701984883901; Thu, 07
 Dec 2023 13:34:43 -0800 (PST)
Date: Thu, 07 Dec 2023 21:34:42 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHE6cmUC/6WOTQ6DIBSEr2JY9zVgKf6seo/GNBRflaSCeRBSa
 7x70St0Mcl8s5iZlQUki4G1xcoIkw3WuwzlqWBm1G5AsH1mVvLyIji/QojkzLxATzYhBXAYAeO
 ItBs96a93gE7veuSoxwQGlJE1l1IprSuWq2fCl/0cs/cu82hD9LQcL5LY0z8HkwABTy3rqmkqK RS/Dd4PbzwbP7Fu27YfgaQtMPkAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701984883; l=2405;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=NfdFJEILBicX+cKI9Lam0xi1N5rwWJPZbrcrKRNR7ek=; b=USHVW9EnVVap8XHQCQKZwCMqui5mXIlCs8pOQqrQSBk37cDVheZxNNOSUifYJos12XxU1VyCf
 mt+BoGh3e/1Bu0+A0U+bcdSiCoC3A3xOy3rdcwDhwzLsK7PZ95BW9iF
X-Mailer: b4 0.12.3
Message-ID: <20231207-strncpy-drivers-net-ethernet-amazon-ena-ena_netdev-c-v2-1-a1f2893d1b70@google.com>
Subject: [PATCH v2] net: ena: replace deprecated strncpy with strscpy
From: justinstitt@google.com
To: Shay Agroskin <shayagr@amazon.com>, Arthur Kiyanovski <akiyano@amazon.com>, 
	David Arinzon <darinzon@amazon.com>, Noam Dagan <ndagan@amazon.com>, 
	Saeed Bishara <saeedb@amazon.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on the destination buffer without
unnecessarily NUL-padding.

host_info allocation is done in ena_com_allocate_host_info() via
dma_alloc_coherent() and is not zero initialized by alloc_etherdev_mq().

However zero initialization of the destination doesn't matter in this case,
because strscpy() guarantees a NULL termination.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- update commit message, dropping inaccurate statement about allocation
  (thanks Arthur)
- copy/paste Arthur's explanation regarding host_info allocation into
- rebased onto mainline
- Link to v1: https://lore.kernel.org/r/20231005-strncpy-drivers-net-ethernet-amazon-ena-ena_netdev-c-v1-1-ba4879974160@google.com
---
Note: build-tested only.
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index b5bca4814830..4a41efcc996b 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -3276,8 +3276,8 @@ static void ena_config_host_info(struct ena_com_dev *ena_dev, struct pci_dev *pd
 	strscpy(host_info->kernel_ver_str, utsname()->version,
 		sizeof(host_info->kernel_ver_str) - 1);
 	host_info->os_dist = 0;
-	strncpy(host_info->os_dist_str, utsname()->release,
-		sizeof(host_info->os_dist_str) - 1);
+	strscpy(host_info->os_dist_str, utsname()->release,
+		sizeof(host_info->os_dist_str));
 	host_info->driver_version =
 		(DRV_MODULE_GEN_MAJOR) |
 		(DRV_MODULE_GEN_MINOR << ENA_ADMIN_HOST_INFO_MINOR_SHIFT) |

---
base-commit: bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
change-id: 20231005-strncpy-drivers-net-ethernet-amazon-ena-ena_netdev-c-6c4804466aa7

Best regards,
-- 
Justin Stitt <justinstitt@google.com>


