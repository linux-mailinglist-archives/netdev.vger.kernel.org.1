Return-Path: <netdev+bounces-242873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCF0C9595B
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 03:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1E13E34281B
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 02:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2261B87C0;
	Mon,  1 Dec 2025 02:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="AAWJfbBw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827F91B4F0A
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 02:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764556149; cv=none; b=bvhkzPIr8mqb5dvcqynL9XshK6KMwtia7zkz/ErjxCHyz3tlphTqnKCJ+9d/JAArOicPDZsp0CnmVPZtWx8l7idq3NFFPA+bpCyPlyxoqaQxm3ucRKQ6AOSqxw5KzBLUXgA9Ue2VirOoKvBiCd8TqTb+86tLbkvWQQXJr9xRU64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764556149; c=relaxed/simple;
	bh=5VOylKFX6Co6JLOxgTQxukcZGJkBemzD1kTFR1NeheA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KorO9NfIXIV61X69a8lDRsu1ZV/hP4U6GC8tQZAFb3pC5HcQRJGjI1QBkVMDgGH9jPn8Zo73oSIaqP358psAcFwoszBQRpib+27fUKUsj/TGAOTacH1rtS4yX4d0IEoCoWvCJ41EohlNZaTJiSg9E+LQJl4gukJdd43RhyZYxno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=AAWJfbBw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA4AC19421;
	Mon,  1 Dec 2025 02:29:08 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="AAWJfbBw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1764556147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5WS5Bt2xgJzmfxrGniknd1LKMOxHsGV4xc24Ml7tZpQ=;
	b=AAWJfbBwa9XXC8zaf7CJyG/CxESpL6oL/plYZ2JLgL/65mgCfiuYXIGmBfmheZmZJl51je
	fOBvMONHQoz1qgq0j6KsklYaqwJDj9Vita1uiTt//OPavl4VSKbjOMhj0FcwasXKLkje3E
	iRoVp6akz0v2er/pS2sC2N36O06JrwI=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 83b050b0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Dec 2025 02:29:07 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net-next 07/11] wireguard: uapi: move enum wg_cmd
Date: Mon,  1 Dec 2025 03:28:45 +0100
Message-ID: <20251201022849.418666-8-Jason@zx2c4.com>
In-Reply-To: <20251201022849.418666-1-Jason@zx2c4.com>
References: <20251201022849.418666-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Asbjørn Sloth Tønnesen <ast@fiberby.net>

This patch moves enum wg_cmd to the end of the file, where ynl-gen
would generate it.

This is an incremental step towards adopting an UAPI header generated
by ynl-gen. This is split out to keep the patches readable.

This is a trivial patch with no behavioural changes intended.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 include/uapi/linux/wireguard.h | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/wireguard.h b/include/uapi/linux/wireguard.h
index dee4401e0b5d..3ebfffd61269 100644
--- a/include/uapi/linux/wireguard.h
+++ b/include/uapi/linux/wireguard.h
@@ -11,13 +11,6 @@
 
 #define WG_KEY_LEN 32
 
-enum wg_cmd {
-	WG_CMD_GET_DEVICE,
-	WG_CMD_SET_DEVICE,
-	__WG_CMD_MAX
-};
-#define WG_CMD_MAX (__WG_CMD_MAX - 1)
-
 enum wgdevice_flag {
 	WGDEVICE_F_REPLACE_PEERS = 1U << 0,
 	__WGDEVICE_F_ALL = WGDEVICE_F_REPLACE_PEERS
@@ -73,4 +66,12 @@ enum wgallowedip_attribute {
 };
 #define WGALLOWEDIP_A_MAX (__WGALLOWEDIP_A_LAST - 1)
 
+enum wg_cmd {
+	WG_CMD_GET_DEVICE,
+	WG_CMD_SET_DEVICE,
+
+	__WG_CMD_MAX
+};
+#define WG_CMD_MAX (__WG_CMD_MAX - 1)
+
 #endif /* _WG_UAPI_WIREGUARD_H */
-- 
2.52.0


