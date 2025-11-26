Return-Path: <netdev+bounces-241974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 883EDC8B3DA
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 18:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4A8EF359BCB
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 17:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C11313E3A;
	Wed, 26 Nov 2025 17:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="N1xYHHvQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1DA312828;
	Wed, 26 Nov 2025 17:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764178600; cv=none; b=ByYF4WP88QTDl40VlVGVcHLJFKl8hla/kpwcOGbCXjJH6skwRvHlAgi9y7gP+AJdMxB/p7t3g0Bn6KS9fk7aYVpZnmWHtHJPvU8SC0OPh1TmVuYRvlrvR5vZoFdCQ5h21rYTMCquFeydK3yhMGnR7Dq/k2oqnOE2rDbkxw2kz7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764178600; c=relaxed/simple;
	bh=FYLtqNMpFxR+mpsT+mbyaqJuN9Po8ME7GneCTwYMrs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sw+vLBNKb5KWCN3QooM9pDcDuDcI4xmYSfpdVAqITpkm6j4LWIRki4Q9bUn9+rvzChaj8JWszsU/qTK7XoG5w6fadjzI0KJSpaOhcv2H/KBX9RDfw/dMMkVjNg50eJsbBvzztXuE4U0Jan5EkWLLxUtc3172O1U12dsD8O0Oblo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=N1xYHHvQ; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1764178585;
	bh=FYLtqNMpFxR+mpsT+mbyaqJuN9Po8ME7GneCTwYMrs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N1xYHHvQtMOPQcvaEiX9X9CIPWOrVphyDkAVig+MVK7eS0o/xPlHlRIDExiqyb2s1
	 b3GPJltsdtE4iy3Q0o/sMKd/msdF86i6FsmbZeo2jT4oHvo5hHY2xjynIavYb8Hg3X
	 lyBs+jZSV38OZQkN3XYHBqkH6ZzuMrYP4t92c4sUXhrcZd5VpNJY9fjhEuSCr0XqkF
	 TOxPhX4Ibom0aZQO9BQvHAXBI9vmAg0h3fFgKLrCcus98JPYcN4ydXruqNKxjDAaJb
	 N39Nj1sdEk3CUCWi9hyG1y3RUXD1ickPJRnhJQ2C9KT3Iz5eQCsKbdBR8ff/1G6plp
	 mzSwIIqgVCVlw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id A17316010E;
	Wed, 26 Nov 2025 17:36:25 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id E40B9203866; Wed, 26 Nov 2025 17:35:51 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jordan Rife <jordan@jrife.io>
Subject: [PATCH wireguard v4 06/10] wireguard: uapi: move enum wg_cmd
Date: Wed, 26 Nov 2025 17:35:38 +0000
Message-ID: <20251126173546.57681-7-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126173546.57681-1-ast@fiberby.net>
References: <20251126173546.57681-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch moves enum wg_cmd to the end of the file, where ynl-gen
would generate it.

This is an incremental step towards adopting an UAPI header generated
by ynl-gen. This is split out to keep the patches readable.

This is a trivial patch with no behavioural changes intended.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 include/uapi/linux/wireguard.h | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/wireguard.h b/include/uapi/linux/wireguard.h
index dee4401e0b5df..3ebfffd61269a 100644
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
2.51.0


