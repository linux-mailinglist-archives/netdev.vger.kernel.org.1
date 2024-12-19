Return-Path: <netdev+bounces-153299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F19289F78ED
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 10:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83ED118942BA
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 09:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2595822370D;
	Thu, 19 Dec 2024 09:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="px4DmMfP"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246C522333F
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 09:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734601796; cv=none; b=GxH6gUMG+572gPv2AozXhf1781eESEA8FwiyHDsD7yx/INgCgmsueszaFJTS5XwHtuulaZvLM28OHsBAd+uNP+GMOyQuvcFTjtObCABrZjPOFLhXpciiNkWo212yARZnZTkUFgGzqOtK8wwP7klJzq2VjxqaPD91u2U4lgleO+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734601796; c=relaxed/simple;
	bh=Va+O7/XwTERIBLq5+oyCKSMkTqAMHn/79Wr8yRSOBrk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hoTAaKzFLnsdAov4SeXgrVXas6/xyhkQO1nXs4ffOE8HE178409QwWUSzxCAQKQErYApQtfgv+8cWD1OVJq/zZMpbOgfq9RkeiOBtmE4cc+Ch06tgPChWbBhYKvoulB6N+f3C/42u8kOAslgYagJZPjvRuGjL4Y5IOg77WmJZuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=px4DmMfP; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tODAG-007Npm-BF; Thu, 19 Dec 2024 10:49:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=rQDODt8aj3eUFG5y1UBvvZIFZYD8q6B5r2EQL7FUEQ8=; b=px4DmMfPKzH5hYH9FX5o34bWGe
	oQZaTuZVtHj3WEAoCNsh5agtfl7JYwdMtmdLoGzbuARQeNiDaX3zYIufOQkTRpCBT0j6qRMaNcHvm
	uGzkhhRSzkrUWmxqlAuvAxefULOp1rUBzBqV5aDwGb45Ai3/fQMlA79ENQxsp+JcWN/0kB1VMNwQm
	os0w5SDKHw79xpewlxdTT9qc78NfS3C8pzLF23NEEXcMgb35/d3KcNposQV0dc57qcY4j2vxLJDpK
	6d6HHDTvOzV0bY4CXb51AzN/xiv4UvI3UnL7oVbN0GW5z3lNq99t2MBeqVLL93jiiqBmklCrRT1eq
	Fio0jWEw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tODAF-0004rW-NE; Thu, 19 Dec 2024 10:49:52 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tODA4-00BSZD-7F; Thu, 19 Dec 2024 10:49:40 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Thu, 19 Dec 2024 10:49:31 +0100
Subject: [PATCH net-next v4 4/7] vsock/test: Adapt send_byte()/recv_byte()
 to handle MSG_ZEROCOPY
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-test-vsock-leaks-v4-4-a416e554d9d7@rbox.co>
References: <20241219-test-vsock-leaks-v4-0-a416e554d9d7@rbox.co>
In-Reply-To: <20241219-test-vsock-leaks-v4-0-a416e554d9d7@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

For a zerocopy send(), buffer (always byte 'A') needs to be preserved (thus
it can not be on the stack) or the data recv()ed check in recv_byte() might
fail.

While there, change the printf format to 0x%02x so the '\0' bytes can be
seen.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/vsock/util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index 81b9a31059d8173a47ea87324da50e7aedd7308a..7058dc614c25f546fc3219d6b9ade2dcef21a9bd 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -401,7 +401,7 @@ void recv_buf(int fd, void *buf, size_t len, int flags, ssize_t expected_ret)
  */
 void send_byte(int fd, int expected_ret, int flags)
 {
-	const uint8_t byte = 'A';
+	static const uint8_t byte = 'A';
 
 	send_buf(fd, &byte, sizeof(byte), flags, expected_ret);
 }
@@ -420,7 +420,7 @@ void recv_byte(int fd, int expected_ret, int flags)
 	recv_buf(fd, &byte, sizeof(byte), flags, expected_ret);
 
 	if (byte != 'A') {
-		fprintf(stderr, "unexpected byte read %c\n", byte);
+		fprintf(stderr, "unexpected byte read 0x%02x\n", byte);
 		exit(EXIT_FAILURE);
 	}
 }

-- 
2.47.1


