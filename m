Return-Path: <netdev+bounces-238534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FD5C5AB39
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 01:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39D414E273B
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 00:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D947A927;
	Fri, 14 Nov 2025 00:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vzuZzl2W"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0491684B4
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 00:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763078553; cv=none; b=BqChjjccfgt+BVV4XtRpilXlroczSSwQ+nrv6xBjZfrQZ6cZo8bUAG72hb+86DHL/0HEIzNfaiY4jo1C3OgmnQGJ5DAjnN8jjvIpc9QjmPpPOsXVo7hP/i8GYzJ/LmU7ajwbpWTmS/rnK2KVh/G1OAO1VeTPf08QvMVZ+1Ykudk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763078553; c=relaxed/simple;
	bh=YYn1QNldg/j8f7MEluaOq/sfg3Ag5Ezy21dLuxoykPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SbCGzWwK1/O4tx/njeafxuEZmRKZEOEIGvcHfYK++amh0i0y+Sd04l9iL+qAbj/LEu0bLrLIHDlWrBU1jOFK4cFSz4Vg5RR9TatlQmiOXi9tttJGJJVxrSmBLqoA3I7ZSk2JUE9/rghGCeJPIgIqNVctcCSrwrVRTr0oAvVcJLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vzuZzl2W; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763078539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DeLzK0AVkutEbiXaCDUp2PW5ApiEQmzw+19O+u5NMA4=;
	b=vzuZzl2WfOpzYa3td/eH5uIXhfkM5U7IpVHw9y+EhDfTQlRO/dVZeoQ8cgzb5dkpeLBJ7m
	p+qtK4928Nin00Wlnm72LdMq92/MJF3Wilr+ziaPp+SHGId24tF83zckbn5SgGKAwi1lJb
	GZ30caCzdqVTW7Ra5oFvlYpUr/62Hno=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] crypto: af_alg - Annotate struct af_alg_iv with __counted_by
Date: Fri, 14 Nov 2025 01:01:54 +0100
Message-ID: <20251114000155.163287-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add the __counted_by() compiler attribute to the flexible array member
'iv' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 include/uapi/linux/if_alg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/if_alg.h b/include/uapi/linux/if_alg.h
index b35871cbeed7..4f51e198ac2e 100644
--- a/include/uapi/linux/if_alg.h
+++ b/include/uapi/linux/if_alg.h
@@ -42,7 +42,7 @@ struct sockaddr_alg_new {
 
 struct af_alg_iv {
 	__u32	ivlen;
-	__u8	iv[];
+	__u8	iv[] __counted_by(ivlen);
 };
 
 /* Socket options */
-- 
2.51.1


