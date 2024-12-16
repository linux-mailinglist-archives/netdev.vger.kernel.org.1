Return-Path: <netdev+bounces-152174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3939F2FFA
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 13:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52BC1168123
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 12:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDF12046B2;
	Mon, 16 Dec 2024 12:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="BQD4B4vW"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A96C20459A
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 12:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734350487; cv=none; b=kgN7jLU04WE5PNwecLd5juiq2hDDG9QK/HUW/r61HZq4frQW9crvBoZlJlMZF1PT8sEyUws+d3c6W0fvOFqNqUhsWBzRJJj/M+845i3SBljKkMeqaKeL+jUEX3srpczN054tzi41bXpTLzj6Ro52vg5chS8vzcsr63xOctopQSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734350487; c=relaxed/simple;
	bh=0sDdAEZabG5E9GjTiowtmVlTAEy23d/F9QV7mjnBl8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sfY5BpjMrgU9V8QRBPq+ZAFO3zC7SI1UHDlnBb74EQQq3d+5EQt0iJKHChLXcjlUohb4n9sFBWs0YGyJlPHWFsNkPXMOiatv5VODRxA7RNymsKBVD0NsWo9Ilm7GSrOVCoUuFlW7F+gOTOV3RnbyZR2pwqO6OY0y6ImZf1v63/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=BQD4B4vW; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tN9mr-00FlkD-Vz; Mon, 16 Dec 2024 13:01:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=Ab/Czx5yAuS9fCWJcYUV2QQ76tFP5JZBVcCL+Ei7LOY=; b=BQD4B4vWMpm+iI1gdaa1We206B
	XdHlZwHd/DKkRTjB/1YSelgCM/6HpJc888aGXPjzZ38MictWHTFwGYLmw+/RERFdDeXOKf4Yeq1al
	04n/CzEbSsz3iYSDLD7fAGNiaQVqTUe82uReZlZ/iss/OoIusxIozvXNSzr6DkKGGtzCNzKJzVP5k
	mKF/yZR/9zPk3gtyPo+fhfDErqWBnJR0vuZ8eeZdYCyDxD3/GVMau7uhtCzBBUCKLXwylBOAaDb3E
	L8/fjdmifRHzPJ/88015vKcAnHwOzdAq3n2D7ObKcT3Ph8Zi4r9JKapJOBBTjKcoidOhfSFMEaYkL
	LIAzublA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tN9mr-0001Jf-KT; Mon, 16 Dec 2024 13:01:21 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tN9mj-00DDDe-GO; Mon, 16 Dec 2024 13:01:13 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Mon, 16 Dec 2024 13:00:57 +0100
Subject: [PATCH net-next v2 1/6] vsock/test: Use NSEC_PER_SEC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-test-vsock-leaks-v2-1-55e1405742fc@rbox.co>
References: <20241216-test-vsock-leaks-v2-0-55e1405742fc@rbox.co>
In-Reply-To: <20241216-test-vsock-leaks-v2-0-55e1405742fc@rbox.co>
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


