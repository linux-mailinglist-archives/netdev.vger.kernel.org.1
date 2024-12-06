Return-Path: <netdev+bounces-149787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 597B09E7827
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 19:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26E871886383
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 18:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88531D5ADD;
	Fri,  6 Dec 2024 18:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="fInc+A9g"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530BC2206B2
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 18:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733510163; cv=none; b=V65KMT+pX6gP5pmxBqoiP6JSeriRkF9mFNvbilKwXdhVTfgy2ro5FHq/zD/scEwc7OX3uTvmL4BLLrslW/E+MXjV/CmGLwhdZ/F+XTeV+yG/H/lbRQmYpC+qH8JJ10YVCB3pdaNTMl5b41iIh7rVXhgLBz6fuuu/2xwcp3hGVZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733510163; c=relaxed/simple;
	bh=tSczHC8zpyoIY3iqu4LdXulEkjhCzQOuHl+tISPzKs0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AgU72hNQAN5OGDvLCgPdW2w1zMA0BmwDR866vYWoVdmwn+sJglax5sR2OthIKJ6B3s2zAm0kiEY1JYBj35Wf2aZUuAw0NYUUgFGVNzvY+x6yRNjbMC/uAX1UddS+SqlcGwvwIQgQ1NXI/cjMjRJcr+5PgPwVEWPr1yD6ljMgXKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=fInc+A9g; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tJdB7-004OrH-N8; Fri, 06 Dec 2024 19:35:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=wBN7/ol7TUrDrXw5usJz5pglJHSJtQFy2mBXrPf0tJw=; b=fInc+A9gVBd3xiAfCPzxrYGKTD
	OACaZjLRsQdSAT40e6AMeofj4Z/Aqras4Ilh93a52H+60e/70P/LlbtAp95YDorTRw0GVHsnZ1+Ph
	96bpOhzxsaV3FEIwuQOFZ+oQRe2SRB2yAlXg7twKnWfuYuPdQNSoxyWAryGbf+FeXKBErSAnPOlRi
	e8U+OQSzgTGlN8aBpatSLeC1lkOZjnkMV7uKYST41i+Oy9mpQZ4vVMXjgpGMNNdvbnwwvlVnCKDsA
	CaQAvmYhIdklDOthLV4yVfXM01fID5TFXC280u3FWJC667JufKQ93TfdYmq9Y/iqqjGnPy3DA4d+j
	Zyuxv9yg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tJdB7-0008Fx-CE; Fri, 06 Dec 2024 19:35:49 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tJdAo-007yMC-SB; Fri, 06 Dec 2024 19:35:30 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 06 Dec 2024 19:34:51 +0100
Subject: [PATCH net-next 1/4] vsock/test: Use NSEC_PER_SEC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-test-vsock-leaks-v1-1-c31e8c875797@rbox.co>
References: <20241206-test-vsock-leaks-v1-0-c31e8c875797@rbox.co>
In-Reply-To: <20241206-test-vsock-leaks-v1-0-c31e8c875797@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Replace 1000000000ULL with NSEC_PER_SEC.

No functional change intended.

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


