Return-Path: <netdev+bounces-152178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3609F3002
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 13:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1D8188524E
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 12:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE9F20468A;
	Mon, 16 Dec 2024 12:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Abje9XLF"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621FD201256
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 12:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734350495; cv=none; b=CgKDRs1nNqapoyTF5BNtfG6v+i2xE2X13U7fFXZNx/b+Fo4cuOjHaMExNrOoKcmNOymYaeT/Cfu3EOFH/bnNV3/ICY2SjTwEn+l/qyGGg83L47hJ+70kYiDalVdQDfeatcqSvyzSHkQJVhKEyiY67pVN5qU5gW0tVpj1xfJGy7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734350495; c=relaxed/simple;
	bh=Q7YQhlf+L9X3BOCh4jwqaujSyQuvtCY48muVY33oktg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a1H96uaNaYmhtStSaf4U1g95ZKLwvHOJan+U2+Nd/gg6cDsT0S309AK/NppJ69E8rBdfwQ9uXkvCKygZQNpFS4vG7Z0ZSJP9y41mWCqs5RLiOQOhrTgxFsJG6VNsLoF2KJMvDMKs8Hd4c7g4mewKikjI9GvtVysStop1lHeyUJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Abje9XLF; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tN9n1-00Flkq-GN
	for netdev@vger.kernel.org; Mon, 16 Dec 2024 13:01:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=X4AZLLWGoTOkTtTvPWQe0jnzbQksU3T9sND+z/Z+GE0=; b=Abje9XLFl4rt2ybLLH3peGc436
	L9d9tj1zVmZ3Wrh5vSpur+ytkadkej6581/hfWygrW00U1XQOeszZrMILZphdMDyTptzyje2SCots
	FgxSFc7FMpIdXQvrXZozKIQdeRUQHSruMDSLm5gl0dnWh4SkwJE8w5b7+gY1q9lZGpY/3IHoZJkgx
	Z3/dI6SA6n+6ubMNLxMBogOIFCIP2FkcUeFPLdi0QU9ozYhGyk7kGEjrRxvUbn0+/pdxi+COuRCMA
	C0U5hIE6YmP72Racrkk7fGZlSO5h0HzoswXZQSUDgkUu4HVd2SLHRpANFvxJ8iGjqRUj++ohygfBn
	7ngueNOg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tN9mw-0001Kd-2T; Mon, 16 Dec 2024 13:01:26 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tN9mk-00DDDe-0V; Mon, 16 Dec 2024 13:01:14 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Mon, 16 Dec 2024 13:00:59 +0100
Subject: [PATCH net-next v2 3/6] vsock/test: Add README blurb about
 kmemleak usage
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-test-vsock-leaks-v2-3-55e1405742fc@rbox.co>
References: <20241216-test-vsock-leaks-v2-0-55e1405742fc@rbox.co>
In-Reply-To: <20241216-test-vsock-leaks-v2-0-55e1405742fc@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Document the suggested use of kmemleak for memory leak detection.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
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


