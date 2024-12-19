Return-Path: <netdev+bounces-153293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 181899F78E7
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 10:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74D8D7A1438
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 09:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A517222562;
	Thu, 19 Dec 2024 09:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="VTe7B8FH"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5704222D44
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 09:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734601790; cv=none; b=kKgAKAzP6XzZ5nKNbURyePf/hAubamjeIrU3gE3tGlqskQ58sssHDqlxSwNxKIRQ74SOaCkIkuiWqU76ssgqoSh/MGYaEP9OMt3dhDytf5naTmMT9L9ZyHGxVd8QM4PmU70Mrgn4AIdxuEw68evd4X5xJiEuUDZFp6NxPyZaWHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734601790; c=relaxed/simple;
	bh=+qUP/d1rIFueOqsZVf7wyszQCM9uJnmvtp20fTRpkww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xnv+ZrQ9GzY0uHmIkBIb8wEnKW3hv43XCvFRLpmBolp32F1SHVZii0ji8PU1Mivmo8Cjw8fvtMd0I0j2Bcb8fjFKMBLHR4XvOi5TGdSyOtyI27KLxUL4zqo/sy0iYMenuCaO8oi9yxR5OVUFYMZR3+vi88p1LGESulel8C/bxWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=VTe7B8FH; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tODA6-007NpE-CT
	for netdev@vger.kernel.org; Thu, 19 Dec 2024 10:49:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=7BDUCOz2m6LxH15VpSFdXS6zzRdJrTV+Zd1AlfTLENM=; b=VTe7B8FHAAZwWFF1Jsse5Bjveq
	pIw1aX/XZojysBDiTBMf4BeNiU4vaK5P4PV5fHL1H0OoTSmG7Ckxv417mWIc9K1zFYDkyRx7VgYNi
	q/yyj79iIN6sSUdhRUgm/MpmJ7tGRAqZQA0qUyjKkA/V5cTvfbh2kq/FCi2D/HyzVmd1tairkTdJW
	9NKdngK18mE485fcVeDRPXl0V3aUw8cngb+RXFypEeXndQ+ATT5AahK7EZ0CCe8TBn8xYZUPbtLHf
	OlTMTV2qbhRS6lSu8HUGhu0DF15/uJzipq1khAxY1bEH5oTyRWzh1qAgP/Yq7VNYEUQTOnEUBD3yI
	dh2s+LwA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tODA5-0002iH-W3; Thu, 19 Dec 2024 10:49:42 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tODA3-00BSZD-VZ; Thu, 19 Dec 2024 10:49:40 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Thu, 19 Dec 2024 10:49:30 +0100
Subject: [PATCH net-next v4 3/7] vsock/test: Add README blurb about
 kmemleak usage
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-test-vsock-leaks-v4-3-a416e554d9d7@rbox.co>
References: <20241219-test-vsock-leaks-v4-0-a416e554d9d7@rbox.co>
In-Reply-To: <20241219-test-vsock-leaks-v4-0-a416e554d9d7@rbox.co>
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


