Return-Path: <netdev+bounces-152987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C358D9F688A
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99E701658D0
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 14:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED9D1C173D;
	Wed, 18 Dec 2024 14:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="ijN4DzmS"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EBE1B0408
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 14:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734532387; cv=none; b=MebBH4661SGvpkegNEO5JKfL1GqhRKd3Pttr/rUmANBVsvnyQgoy+gT2Zwek0fAWeCLXFjsL4HjTNwoYy7Zpw+6y9P3nL352XLNyoGKtdt2qBUYNzn2FQCnR3RYd1+5sDllc7lqrnCuHDmr+lcsRNizOUyTvutj28fwKlMUQ5Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734532387; c=relaxed/simple;
	bh=+qUP/d1rIFueOqsZVf7wyszQCM9uJnmvtp20fTRpkww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mr7fDFDnRqWuXKs+9klqijA6p7kaLVeW0t/IUVf4SbVj6kzY0A5zNiEfbpMU5Mgz51vkY1KgeyOkVNC9dPwbn7O8dqduAWbC6I+7Sa4IHn1oG261EyFk41dPhSLW1h3nEZUgP001fGl083VteEln4e2rTEHeTSQWQs1wXthLpDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=ijN4DzmS; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tNv6b-004cdP-HW
	for netdev@vger.kernel.org; Wed, 18 Dec 2024 15:32:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=7BDUCOz2m6LxH15VpSFdXS6zzRdJrTV+Zd1AlfTLENM=; b=ijN4DzmSF3yT29dDBrKrm00GuI
	FxZJ1NJXgs2cg9gsVELuWQPox4PmZT/lDM0HiX97A+G4d9nPZYovA5hHOTXqs6Y6zA6DF1WJ8CfHO
	Cwk78fXqAm09UFw5zmaVWXb6l1x3kRKRAa1xRl5fhWrdDpB7rslBlccTuZo03cdE6XM6BViTP+c8Q
	wqLUxYuVFXKLHoEykWTjKnpazJ3ZzTTZjkOCgl2f4RfMWdNpj6DHq9mY+AuSB7VgRE4yZMso36QbC
	oRDv8UoLkZr7sxKcJM/YfZCvIah+q2CFT+edZu8kKvyPiEXsBFvT9pa4NBwnYZCg9o+AgSmXtGFnK
	Yv5Q+ujA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tNv6b-0000QS-5e; Wed, 18 Dec 2024 15:32:53 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tNv6V-008Env-JA; Wed, 18 Dec 2024 15:32:47 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 18 Dec 2024 15:32:36 +0100
Subject: [PATCH net-next v3 3/7] vsock/test: Add README blurb about
 kmemleak usage
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241218-test-vsock-leaks-v3-3-f1a4dcef9228@rbox.co>
References: <20241218-test-vsock-leaks-v3-0-f1a4dcef9228@rbox.co>
In-Reply-To: <20241218-test-vsock-leaks-v3-0-f1a4dcef9228@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Document the suggested use of kmemleak for memory leak detection.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/vsock/README | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/vsock/README b/tools/testing/vsock/README
index 84ee217ba8eed8d18eebecc4dc81088934f76d8f..680ce666ceb56db986c8ad078573d774e6fecf18 100644
--- a/tools/testing/vsock/README
+++ b/tools/testing/vsock/README
@@ -36,6 +36,21 @@ Invoke test binaries in both directions as follows:
                        --control-port=1234 \
                        --peer-cid=3
 
+Some tests are designed to produce kernel memory leaks. Leaks detection,
+however, is deferred to Kernel Memory Leak Detector. It is recommended to enable
+kmemleak (CONFIG_DEBUG_KMEMLEAK=y) and explicitly trigger a scan after each test
+suite run, e.g.
+
+  # echo clear > /sys/kernel/debug/kmemleak
+  # $TEST_BINARY ...
+  # echo "wait for any grace periods" && sleep 2
+  # echo scan > /sys/kernel/debug/kmemleak
+  # echo "wait for kmemleak" && sleep 5
+  # echo scan > /sys/kernel/debug/kmemleak
+  # cat /sys/kernel/debug/kmemleak
+
+For more information see Documentation/dev-tools/kmemleak.rst.
+
 vsock_perf utility
 -------------------
 'vsock_perf' is a simple tool to measure vsock performance. It works in

-- 
2.47.1


