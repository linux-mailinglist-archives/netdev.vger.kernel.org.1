Return-Path: <netdev+bounces-152984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D92FA9F6886
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B02F1615BD
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 14:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BF41B0417;
	Wed, 18 Dec 2024 14:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="qEhNrxpc"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECE81A4F12
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 14:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734532385; cv=none; b=HBdzEfraQMZ+caWskQakI9yDcZReRLgDECUtj6LtRFu19S3kIjA7nphLSzXlMJ4PIIlbkPnmzFX2tg0NPmqke6u40VjkcP0HwyVl/kXetawiVEBsmBUy+29BA9C0m+EFE/A2NZ5wlqITXnMOU4lJ4LO8NUTtGEFBAqm9nK9s4g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734532385; c=relaxed/simple;
	bh=0sDdAEZabG5E9GjTiowtmVlTAEy23d/F9QV7mjnBl8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QYmNARadQhkpUn5HJ0KSpQY7HGfzLIFBNyOvf8goEsVSdmVc62hto6ArL4u7bqCff9gjt5X8HmWOqMwTQpXw8dLCfzTQ+buqa6dkCJn70pr9x9/hfRcQO7GW80NV+ZZ+JWI61OGAU4y65XBT2JUvyp8wEKWk1TJ3c8MfC1pSRKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=qEhNrxpc; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tNv6Y-004s0c-6p; Wed, 18 Dec 2024 15:32:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=Ab/Czx5yAuS9fCWJcYUV2QQ76tFP5JZBVcCL+Ei7LOY=; b=qEhNrxpcHTb7V3PZ7h18PnQBwu
	l9xTf0/p7bOlEmmtCvNgSDBquJTYsNPiSOdMsx69v9hIhDBt6fiGreRBYUFn+Yt3XNViftXos199R
	1zR6ylKx2Jq9xmNRtqSBQo2SeI+FhJd7GqfjFWDiACoL1K1fFbBPphrcDCYiE/miBXepomelAsFs6
	gq8eF0ld/byTOWuYPpdL1+IVCgG1JeCH87gjelwF3Sh1k2HrAMXt937I45AINS7PzgqNf5OgFEJ8t
	MODlNz6SZdy6neBBZ7rTgU7/ymEf5ezEjGVGJ2ye1GNaeNFJoAZAIu24Ecn8yEKObwQGylhhcZZ2/
	NRjhHvpw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tNv6X-000702-Lj; Wed, 18 Dec 2024 15:32:49 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tNv6V-008Env-2p; Wed, 18 Dec 2024 15:32:47 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 18 Dec 2024 15:32:34 +0100
Subject: [PATCH net-next v3 1/7] vsock/test: Use NSEC_PER_SEC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241218-test-vsock-leaks-v3-1-f1a4dcef9228@rbox.co>
References: <20241218-test-vsock-leaks-v3-0-f1a4dcef9228@rbox.co>
In-Reply-To: <20241218-test-vsock-leaks-v3-0-f1a4dcef9228@rbox.co>
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


