Return-Path: <netdev+bounces-153295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D979F78EA
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 10:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B31177A227D
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 09:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380A1222D44;
	Thu, 19 Dec 2024 09:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="WY+g56gg"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717C9221473
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734601792; cv=none; b=UYW7fop38MXCf9/rZX1ZWFA/7+FEnvyMp8lgkL+30j2hIFuVMHMxG6IJOWBmPeMsy4fknLtpy3U2ATP/9kt2dMw5Oc8pF1tMcdC3DMlmYNoA9cJbg1IztrGt3UcBtdWp+a17FrpA6LlRdQvpvbUYNMOs3hvNRaEslkrYBoxrt54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734601792; c=relaxed/simple;
	bh=0sDdAEZabG5E9GjTiowtmVlTAEy23d/F9QV7mjnBl8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rDP0u6j9F92OB7oPnzSl0YziDEsNxdTYhaTiASI5QIOQLXUcGRWhFSEC7jj2icdHdD5qHz6mDspveDRnhwfHW+gmrK9sqiaWWqIl6+Ywg8duh749GiHN7Q5grLftVHAWACLJyMk7cd+Jdq9b60/w+RqX1wCXvZUFGnXsh/qzLwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=WY+g56gg; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tODAA-007NpM-KZ
	for netdev@vger.kernel.org; Thu, 19 Dec 2024 10:49:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=Ab/Czx5yAuS9fCWJcYUV2QQ76tFP5JZBVcCL+Ei7LOY=; b=WY+g56ggFtMRC1ozluTUi0pcgz
	tha7+DSVvHchpu8XILvBk0xmkGErArDz2sFFxPIbvR6C+CWBgrOPQz0saiPY307InH/dBKD1W/Rbq
	eAEqIPae0YXOj7czYk4hzxYXOO+LFcdkU5pQSxWAApuoPD3Q09CS1peaoEke1c/+HFI9ZCYEOR62L
	Zr/RFJBTsIk8brQWeVOGUQV3itlv1cZcYAdBwY6pj/UfVJHKpnVFTsYWPLNCgO3t/XUjyHvgS5pDM
	pEv+13Isa7C3XBGUjbH0fJjuWOv9p/yu7doosYqNVL6BWev3Knboxqb5iNCxxSIcCXVK1XzWDaOVk
	gu2I3mwA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tODAA-0002iN-AX; Thu, 19 Dec 2024 10:49:46 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tODA3-00BSZD-Fa; Thu, 19 Dec 2024 10:49:39 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Thu, 19 Dec 2024 10:49:28 +0100
Subject: [PATCH net-next v4 1/7] vsock/test: Use NSEC_PER_SEC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-test-vsock-leaks-v4-1-a416e554d9d7@rbox.co>
References: <20241219-test-vsock-leaks-v4-0-a416e554d9d7@rbox.co>
In-Reply-To: <20241219-test-vsock-leaks-v4-0-a416e554d9d7@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Michal Luczaj <mhal@rbox.co>, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.2

Replace 1000000000ULL with NSEC_PER_SEC.

No functional change intended.

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/vsock/vsock_test.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 48f17641ca504316d1199926149c9bd62eb2921d..38fd8d96eb83ef1bd45728cfaac6adb3c1e07cfe 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -22,6 +22,7 @@
 #include <signal.h>
 #include <sys/ioctl.h>
 #include <linux/sockios.h>
+#include <linux/time64.h>
 
 #include "vsock_test_zerocopy.h"
 #include "timeout.h"
@@ -559,7 +560,7 @@ static time_t current_nsec(void)
 		exit(EXIT_FAILURE);
 	}
 
-	return (ts.tv_sec * 1000000000ULL) + ts.tv_nsec;
+	return (ts.tv_sec * NSEC_PER_SEC) + ts.tv_nsec;
 }
 
 #define RCVTIMEO_TIMEOUT_SEC 1
@@ -599,7 +600,7 @@ static void test_seqpacket_timeout_client(const struct test_opts *opts)
 	}
 
 	read_overhead_ns = current_nsec() - read_enter_ns -
-			1000000000ULL * RCVTIMEO_TIMEOUT_SEC;
+			   NSEC_PER_SEC * RCVTIMEO_TIMEOUT_SEC;
 
 	if (read_overhead_ns > READ_OVERHEAD_NSEC) {
 		fprintf(stderr,

-- 
2.47.1


