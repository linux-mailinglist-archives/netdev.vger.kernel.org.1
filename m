Return-Path: <netdev+bounces-241858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4B5C8976B
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 12:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 59AEC4E2A31
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 11:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2769317702;
	Wed, 26 Nov 2025 11:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NeX7qZz4"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88432DC796
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 11:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764155665; cv=none; b=KZSVxg13KpP4aY3LOMS9GPbWGBPyv0PtRpIY739HdDPKnuBvHouYmieFiNwNZR1SWmeQj9gy6Hln3q/1eBzoYDzW6GuQ6dJqkSqzB0GriShM+zzQyYNt0KIVpxYzRD93DIZR4fyLyyrSOt/n4Ake+HR07XXRsEwqCd630+weoXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764155665; c=relaxed/simple;
	bh=+5prDWlD7lNvY3hLar9kp0MOEBAmRXacq+FAOaruLu0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HGcMCWQdAImnNx8xbltuJPf5vng6y+RhCsKJCiXEDRvX2t5p73nyb6aIWT1HBu+cjgljdgCu6oRHzM9rL9yR5pHINJ3ngKF99VeAzAgh1dv7KM/dW+G8v2tacoHv+w5pPGg/u/zQRZF0npXQKFnIZUXLxI2rCJKbEO8VjII+Boc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NeX7qZz4; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764155656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r3yB1s+BNk75F2/5SJHK9QkN8gG67r1xL/kmC4ebo9I=;
	b=NeX7qZz4M3BPj3zPu/OVFgMYhQbqe38ndu/9VJfZacNTfzPuET5r08CsnjXHd6wxogBMDh
	Ch8qjRFNlR+5p/Yn+OuGG8SgFNOMnunqjz44dwmo0q/bNLBNU4MPq9lK0yChfIZqW+UGNJ
	FovU8L9tNCEh7ChbQ5fZfOisEIy7s8o=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: ipconfig: Replace strncpy with strscpy_pad in ic_proto_name
Date: Wed, 26 Nov 2025 12:13:58 +0100
Message-ID: <20251126111358.64846-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strncpy() is deprecated [1] for NUL-terminated destination buffers since
it does not guarantee NUL termination. Replace it with strscpy_pad() to
ensure NUL termination of the destination buffer while retaining the
NUL-padding behavior of strncpy().

Even though the identifier buffer has 252 usable bytes, strncpy()
intentionally copied only 251 bytes into the zero-initialized buffer,
implicitly relying on the last byte to act as the terminator. Switching
to strscpy_pad() removes the need for this trick and avoids using magic
numbers.

The source string is also NUL-terminated and satisfies the
__must_be_cstr() requirement of strscpy_pad().

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 net/ipv4/ipconfig.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index 22a7889876c1..27cc6f8070b7 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -1690,7 +1690,8 @@ static int __init ic_proto_name(char *name)
 			*v = 0;
 			if (kstrtou8(client_id, 0, dhcp_client_identifier))
 				pr_debug("DHCP: Invalid client identifier type\n");
-			strncpy(dhcp_client_identifier + 1, v + 1, 251);
+			strscpy_pad(dhcp_client_identifier + 1, v + 1,
+				    sizeof(dhcp_client_identifier) - 1);
 			*v = ',';
 		}
 		return 1;
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


