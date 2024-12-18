Return-Path: <netdev+bounces-152986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3229F6887
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69D52188D6E5
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 14:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795721B424A;
	Wed, 18 Dec 2024 14:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Vhf1P8zo"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40751B0405
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 14:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734532386; cv=none; b=T5SeRte+Ys9llVBImtWfeXDKplqU8bk4amZmE5LKcF96jMYLmhZnnZLdRfdOykWwZ18N85TyisyCNDBCC/zQVxihFPRgSPiuwh4FEBlxy6JOXkHC7X+WSwGlxUK1b7PjUagBsH2aiOiQntOlcIy56oomIOeV7JHSAO3kdLTPkyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734532386; c=relaxed/simple;
	bh=iXtIiYUZygpcubXTXvB/dYhjPC0zDCMP0/SwPb2QHJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HiDqD6u2cfKRd2Q7Z0xsICxkx7ZTT1Xz0AzB5DODhomixRPFOCx/mVJ0/X3saHADXPsjv3cnax4N+5sBczk/TjHRYHvGl6DaKMlWFcwIWIEfbkaqS2RGy9QwNszgH5VFKYYEyrJdTBS7Z9xsvnvtSCu4tyb/H56j1ra7bh1zjBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Vhf1P8zo; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tNv6a-004s0r-Hz
	for netdev@vger.kernel.org; Wed, 18 Dec 2024 15:32:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=vOB798QAKIhsiRPN5MHIl3fI84uyUMpEJ8aFVEv5168=; b=Vhf1P8zo882Qrq1DxCGh36YYgG
	HQSPlb80AwkAl3GOlx+0mgDfyH7ZGzKGRhmE+nH1IOqDv9DPViDSiXtwmnRc8MdJpntFmxM9MViCF
	n/LV8CicwLlmM8R093DmyJSKvZc8Zjev1vO6PWpmVhrF+GcX0EQ63ZQyDVcOtZ6FnhUMSqDeEsFwB
	+SjTZPiOuFYc5n7YZSmpFC3ZTJKC/cJe2PtLY1RksJfnlih+gtwtGgP5dqAZN0z1JYaYTTh/MdSmk
	hT4baQLSEpFLeaBMKLwoek95+tQSx4Yg+K2gl0L7sBByia/35oNyQ+VyVPir6grB21iuGe8BqpOKD
	Pk8oCTmw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tNv6a-0000QM-7p; Wed, 18 Dec 2024 15:32:52 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tNv6V-008Env-Qx; Wed, 18 Dec 2024 15:32:47 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 18 Dec 2024 15:32:37 +0100
Subject: [PATCH net-next v3 4/7] vsock/test: Adapt send_byte()/recv_byte()
 to handle MSG_ZEROCOPY
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241218-test-vsock-leaks-v3-4-f1a4dcef9228@rbox.co>
References: <20241218-test-vsock-leaks-v3-0-f1a4dcef9228@rbox.co>
In-Reply-To: <20241218-test-vsock-leaks-v3-0-f1a4dcef9228@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

For a zercopy send(), buffer (always byte 'A') needs to be preserved (thus
it can not be on the stack) or the data recv()ed check in recv_byte() might
fail.

While there, change the printf format to 0x%02x so the '\0' bytes can be
seen.

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


