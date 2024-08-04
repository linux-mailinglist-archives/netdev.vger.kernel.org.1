Return-Path: <netdev+bounces-115551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A85946FBF
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 18:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E9E428140D
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 16:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B1C12B6C;
	Sun,  4 Aug 2024 16:04:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25CA1DFE8
	for <netdev@vger.kernel.org>; Sun,  4 Aug 2024 16:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722787461; cv=none; b=FwgPWHXQVxF20wQnoCTZUntJXv3KouBhGhkmL+Zn7imhicC2AB/hIhwk7bfU+N2WEwWm2HEfP4BH3/NWtxyFLrMq5b7DCuW9udump4WsnUdugQBqcsYwYbQLxz4VEFvrQFBz711co1b8chziJ3N+b7tscwcqwR2Rux9uTRAf0Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722787461; c=relaxed/simple;
	bh=BWZmLRwbovTiQg1AeUbKVb51zPj0f60xvEiWKWMq+Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TU3m8lrRpb3Qq5tB2nyqxobendJ8o07+YMipUULrs1aFhZli9iMmmjw7FrYQa3zb++2E7NAidzxoNsgRS01hjQCis+PhMOS820mH+cpNGH5OIWP3N0Yux/7QRdt2xRxyQD12PqgpQhEcnQOf251RtI9f7RsoUP682JKxeTl6doY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: =?UTF-8?q?Andreas=20K=2E=20H=C3=BCttel?= <dilfridge@gentoo.org>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	base-system@gentoo.org,
	=?UTF-8?q?Andreas=20K=2E=20H=C3=BCttel?= <dilfridge@gentoo.org>
Subject: [PATCH v2 iproute2] libnetlink.h: Include <endian.h> explicitly for musl
Date: Sun,  4 Aug 2024 18:03:23 +0200
Message-ID: <20240804160355.940167-1-dilfridge@gentoo.org>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240804085547.30a9810a@hermes.local>
References: <20240804085547.30a9810a@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The code added in "f_flower: implement pfcp opts" uses h2be64,
defined in endian.h. While this is pulled in around some corners
for glibc (see below), that's not the case for musl and an
explicit include is required there.

. /usr/include/libmnl/libmnl.h
.. /usr/include/sys/socket.h
... /usr/include/bits/socket.h
.... /usr/include/sys/types.h
..... /usr/include/endian.h

Fixes: 976dca372 ("f_flower: implement pfcp opts")
Bug: https://bugs.gentoo.org/936234
Signed-off-by: Andreas K. Hüttel <dilfridge@gentoo.org>
---
 include/libnetlink.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/libnetlink.h b/include/libnetlink.h
index 30f0c2d2..7074e913 100644
--- a/include/libnetlink.h
+++ b/include/libnetlink.h
@@ -4,6 +4,7 @@
 
 #include <stdio.h>
 #include <string.h>
+#include <endian.h>
 #include <asm/types.h>
 #include <linux/netlink.h>
 #include <linux/rtnetlink.h>
-- 
2.44.2


