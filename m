Return-Path: <netdev+bounces-116731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3BE94B7CF
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 09:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 683DE28C9FF
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 07:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE30818786F;
	Thu,  8 Aug 2024 07:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alpinelinux.org header.i=@alpinelinux.org header.b="i4mtnSJb"
X-Original-To: netdev@vger.kernel.org
Received: from gbr-app-1.alpinelinux.org (gbr-app-1.alpinelinux.org [213.219.36.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A732684A51
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 07:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.219.36.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723101917; cv=none; b=aNrQYENga8T8ye/pDkoSDjxsuteM+dWzRCPTKnCb6uIskPIDTRRmAzx4uXYX1y31wLILCKNaE9Hgn26PptWkt24oz3/34MsB1FR8DECrXky3ptgFE+r9SsiiRhD6nwIoXaIWQKBFHd9oT7ejhZapTTITUuMkn2NUF9UAxFKLVWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723101917; c=relaxed/simple;
	bh=dJYASicKG3RfjTudLhqJmgNfSesQdMZ6LD2xReJimEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lUDUMD1OdtCixLp5C64zXTlQLzqx4+d97vimU/I7TAwDDFBYfhOhhXCD7YMvWHO4jNaDhH16apTU+m7vMoYgGvZOo3erowlyngY8cHjMxwOb7gPtrvCv0M9JKK/+rWpIoepy2N8LUQO44KM9LBn9nKI4/Tw0gmat5lTNjU30kyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpinelinux.org; spf=pass smtp.mailfrom=alpinelinux.org; dkim=pass (1024-bit key) header.d=alpinelinux.org header.i=@alpinelinux.org header.b=i4mtnSJb; arc=none smtp.client-ip=213.219.36.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpinelinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpinelinux.org
Received: from ncopa-desktop.lan (unknown [IPv6:2001:4646:fb05:0:1866:2b8d:eb1b:9ca3])
	(Authenticated sender: ncopa@alpinelinux.org)
	by gbr-app-1.alpinelinux.org (Postfix) with ESMTPSA id 0635B222F47;
	Thu,  8 Aug 2024 07:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alpinelinux.org;
	s=smtp; t=1723101566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KmPcMeHXLKjBCyD1c9Efu54SeSrT0jFGqaWL1W+dsfA=;
	b=i4mtnSJbnFvXRyONQz4+Wm+P0gTHWYt6Z2E11Yyqt+zFQ1RSDMVCC9yVWQyAS9HeFvd+CU
	JfZuep42/TTA3DG07aT5uom/tXgwboPtROh7AmG9SagLrJg7BxUotjxtET3SKLA6Cahg34
	ZYAc/F2dozf6/iZf1mvf0sOAodlfj90=
From: Natanael Copa <ncopa@alpinelinux.org>
To: netdev@vger.kernel.org
Cc: Natanael Copa <ncopa@alpinelinux.org>
Subject: [PATCH] libnetlink: fix build with musl and gcc 14
Date: Thu,  8 Aug 2024 09:19:01 +0200
Message-ID: <20240808071901.21404-1-ncopa@alpinelinux.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes compilation error with musl libc and gcc 14:

../include/libnetlink.h: In function 'rta_getattr_be64':
../include/libnetlink.h:280:16: error: implicit declaration of function 'htobe64' [-Wimplicit-function-declaration]
  280 |         return htobe64(rta_getattr_u64(rta));
      |                ^~~~~~~

Reference: https://man7.org/linux/man-pages/man3/endian.3.html
Signed-off-by: Natanael Copa <ncopa@alpinelinux.org>
---
 include/libnetlink.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/libnetlink.h b/include/libnetlink.h
index 30f0c2d2..0139efa0 100644
--- a/include/libnetlink.h
+++ b/include/libnetlink.h
@@ -2,6 +2,7 @@
 #ifndef __LIBNETLINK_H__
 #define __LIBNETLINK_H__ 1
 
+#include <endian.h>
 #include <stdio.h>
 #include <string.h>
 #include <asm/types.h>
-- 
2.46.0


