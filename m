Return-Path: <netdev+bounces-192454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D047ABFEEC
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 23:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 248751793CB
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 21:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EEF2BD03C;
	Wed, 21 May 2025 21:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="OSuTf2Qk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A612BD021
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 21:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747862844; cv=none; b=MqyygcIUhJNzUR6QsqbKVgYeVD5mTDQjbh/Eq+po5D0SuSZtnT4/YXia9RGj6d3RzCSveUAY5PqtQxAtWQV51iK8ZNZjGXueYH8bfOww9Nw7H4MJVq4Xxr//YV/q2l2mWZroJ2uwI5VH2gNdc5a/LqhGl4QCsZeoRJcKXJsOY48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747862844; c=relaxed/simple;
	bh=ITgjp8tcxJAs+XWQ3HmWBdofj/emT6C4UjotDH4ZooA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Co/YbWkhgR1S9ZfBmOYjIUZTj5lxL9u8uXajICxzmqcM7VLCOK+EYuhiTYmaEEC/NeDljMmhbDtBptKGvRt0XwcoT79N/+Z2O+FpDLO50Z8uxS3ioCVUtYzLdiFDJxxNKhurWxTOrjqdOAXlibtuKcUaKeMxDF4pIWbOROiYG/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=OSuTf2Qk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90C6C4CEE4;
	Wed, 21 May 2025 21:27:23 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="OSuTf2Qk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1747862842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x1Ap6u1MPt6q5NyiQYn8Yo08OyISSkapcHS2pNIIG3I=;
	b=OSuTf2Qk8W+U9Uyy0UsKl0IvmasD21fn+YxyByoiDBya32tWt4OM7SuaMITvUlNrzFW0EU
	nlcQ/z1gDWXIcOJ04sU0U6nEY/6qIXULO/TpNtT90zRYElflBdfwyJ7wEbsI6VH85TU7Vk
	X7jNHt54dvKCIxkb++4GA9+VQ2kK69g=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id da010e27 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 May 2025 21:27:22 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org
Cc: Kees Cook <kees@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net-next 2/5] wireguard: global: add __nonstring annotations for unterminated strings
Date: Wed, 21 May 2025 23:27:04 +0200
Message-ID: <20250521212707.1767879-3-Jason@zx2c4.com>
In-Reply-To: <20250521212707.1767879-1-Jason@zx2c4.com>
References: <20250521212707.1767879-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees@kernel.org>

When a character array without a terminating NUL character has a static
initializer, GCC 15's -Wunterminated-string-initialization will only
warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
with __nonstring to correctly identify the char array as "not a C string"
and thereby eliminate the warning:

../drivers/net/wireguard/cookie.c:29:56: warning: initializer-string for array of 'unsigned char' truncates NUL terminator but destination lacks 'nonstring' attribute (9 chars into 8 available) [-Wunterminated-string-initialization]
   29 | static const u8 mac1_key_label[COOKIE_KEY_LABEL_LEN] = "mac1----";
      |                                                        ^~~~~~~~~~
../drivers/net/wireguard/cookie.c:30:58: warning: initializer-string for array of 'unsigned char' truncates NUL terminator but destination lacks 'nonstring' attribute (9 chars into 8 available) [-Wunterminated-string-initialization]
   30 | static const u8 cookie_key_label[COOKIE_KEY_LABEL_LEN] = "cookie--";
      |                                                          ^~~~~~~~~~
../drivers/net/wireguard/noise.c:28:38: warning: initializer-string for array of 'unsigned char' truncates NUL terminator but destination lacks 'nonstring' attribute (38 chars into 37 available) [-Wunterminated-string-initialization]
   28 | static const u8 handshake_name[37] = "Noise_IKpsk2_25519_ChaChaPoly_BLAKE2s";
      |                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/wireguard/noise.c:29:39: warning: initializer-string for array of 'unsigned char' truncates NUL terminator but destination lacks 'nonstring' attribute (35 chars into 34 available) [-Wunterminated-string-initialization]
   29 | static const u8 identifier_name[34] = "WireGuard v1 zx2c4 Jason@zx2c4.com";
      |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The arrays are always used with their fixed size, so use __nonstring.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/net/wireguard/cookie.c | 4 ++--
 drivers/net/wireguard/noise.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireguard/cookie.c b/drivers/net/wireguard/cookie.c
index f89581b5e8cb..94d0a7206084 100644
--- a/drivers/net/wireguard/cookie.c
+++ b/drivers/net/wireguard/cookie.c
@@ -26,8 +26,8 @@ void wg_cookie_checker_init(struct cookie_checker *checker,
 }
 
 enum { COOKIE_KEY_LABEL_LEN = 8 };
-static const u8 mac1_key_label[COOKIE_KEY_LABEL_LEN] = "mac1----";
-static const u8 cookie_key_label[COOKIE_KEY_LABEL_LEN] = "cookie--";
+static const u8 mac1_key_label[COOKIE_KEY_LABEL_LEN] __nonstring = "mac1----";
+static const u8 cookie_key_label[COOKIE_KEY_LABEL_LEN] __nonstring = "cookie--";
 
 static void precompute_key(u8 key[NOISE_SYMMETRIC_KEY_LEN],
 			   const u8 pubkey[NOISE_PUBLIC_KEY_LEN],
diff --git a/drivers/net/wireguard/noise.c b/drivers/net/wireguard/noise.c
index 202a33af5a72..7eb9a23a3d4d 100644
--- a/drivers/net/wireguard/noise.c
+++ b/drivers/net/wireguard/noise.c
@@ -25,8 +25,8 @@
  * <- e, ee, se, psk, {}
  */
 
-static const u8 handshake_name[37] = "Noise_IKpsk2_25519_ChaChaPoly_BLAKE2s";
-static const u8 identifier_name[34] = "WireGuard v1 zx2c4 Jason@zx2c4.com";
+static const u8 handshake_name[37] __nonstring = "Noise_IKpsk2_25519_ChaChaPoly_BLAKE2s";
+static const u8 identifier_name[34] __nonstring = "WireGuard v1 zx2c4 Jason@zx2c4.com";
 static u8 handshake_init_hash[NOISE_HASH_LEN] __ro_after_init;
 static u8 handshake_init_chaining_key[NOISE_HASH_LEN] __ro_after_init;
 static atomic64_t keypair_counter = ATOMIC64_INIT(0);
-- 
2.48.1


