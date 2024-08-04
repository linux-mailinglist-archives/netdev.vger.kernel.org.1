Return-Path: <netdev+bounces-115543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 620DE946F71
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 16:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 948211C20A36
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 14:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677EB57323;
	Sun,  4 Aug 2024 14:58:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C441EA934
	for <netdev@vger.kernel.org>; Sun,  4 Aug 2024 14:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722783497; cv=none; b=WsTrimjFl7sovOaoffmrThb5qI/212PJ+XFQDzIhZ8ophmvgOscdVAOeyUEEl/CFYpZN/OawaDvCkTUUtiOKYhQVff6UJdvczPJzxlualk2GwZGx6//VRNN2lHGvvpUr89gcOKYiAeck8tjmjhMdiXrh7hv3Lg8YJgm79ikrGYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722783497; c=relaxed/simple;
	bh=Oge7P5fNOxwc9EQ8ymZ3OcxKTjCJ0CGsTrkPkBfB1FA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nBUeFMWXUD3y6hyoLjR1qGZ3WV6WrPBIH/41mDYbTZPTkAvfu2Rn4K7h2NESsBsp0uz9npmhyXHWAqBHdGoD449lD+Oe05/dr4SHP+0ESCPdd9bjfNi84xNYNSQ3p/wspRgi0MNrE3OCqc8Rq0eECAkL4s5+/CopJ9KKY2Xcv0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: =?UTF-8?q?Andreas=20K=2E=20H=C3=BCttel?= <dilfridge@gentoo.org>
To: stephen@networkplumber.org,
	netdev@vger.kernel.org
Cc: base-system@gentoo.org,
	=?UTF-8?q?Andreas=20K=2E=20H=C3=BCttel?= <dilfridge@gentoo.org>
Subject: [PATCH iproute2] libnetlink.h: Include <endian.h> explicitly for musl
Date: Sun,  4 Aug 2024 16:57:46 +0200
Message-ID: <20240804145809.936544-1-dilfridge@gentoo.org>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The code added in 976dca372 uses h2be64, defined in endian.h.
While this is pulled in around some corners for glibc (see
below), that's not the case for musl and an explicit include
is required.

. /usr/include/libmnl/libmnl.h
.. /usr/include/sys/socket.h
... /usr/include/bits/socket.h
.... /usr/include/sys/types.h
..... /usr/include/endian.h

Bug: https://bugs.gentoo.org/936234
Signed-off-by: Andreas K. Hüttel <dilfridge@gentoo.org>
---
This time also to the netdev list, sorry...
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


