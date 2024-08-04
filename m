Return-Path: <netdev+bounces-115552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9490F946FC0
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 18:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D99C281444
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 16:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6FB77104;
	Sun,  4 Aug 2024 16:11:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3365E57323
	for <netdev@vger.kernel.org>; Sun,  4 Aug 2024 16:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722787864; cv=none; b=GEb6IcSJrl9i1SkSpk7Avdy+mT3hMPk4Du5IUm5EBv3TX9S7VARLBMlS8bnEB5gLaXBHl6W44TJckXtjCwjWs0vQgWpH2dsMTTvSk0Pd+CzPfSwVyVY9l+OLdVA7vZvYZomJLDKLK+IIyO+R8enD2MBwFq8KSkyCb+y8iF9JfIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722787864; c=relaxed/simple;
	bh=sYGhbRJ320N2BGZz88zbj1aLW/axkFy8iScjiB/F118=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ho6l1RR6VkAinWz9n6Y9rMmcW5xfUnE3CrUfrKI+BGNZq7VSGFiaeXzzdGsiGqa7O7DqBuNXat4vCc7WDo8aDE3pE0Fp9NGqOzOA3JG0KhwQ2tiWPQNTkh9XkuZwdOMZ8ubTh2lg/dSLuo37Efs/Cm3tr4bNyuVgcmAe+buXatQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: =?UTF-8?q?Andreas=20K=2E=20H=C3=BCttel?= <dilfridge@gentoo.org>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	base-system@gentoo.org,
	=?UTF-8?q?Andreas=20K=2E=20H=C3=BCttel?= <dilfridge@gentoo.org>
Subject: [PATCH] rdma.c: Add <libgen.h> include for basename on musl
Date: Sun,  4 Aug 2024 18:10:20 +0200
Message-ID: <20240804161054.942439-1-dilfridge@gentoo.org>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This include file is required on musl for availability of basename.

Note that for glibc adding the include can have the side effect of
switching from the GNU implementation of basename (which does not touch
its argument) to the POSIX implementation (which under certain
circumstances modifies the string passed to it, e.g. removing trailing
slashes).

This is safe however since the C99 and C11 standard says:
> The parameters argc and argv and the strings pointed to by the argv
> array shall be modiﬁable by the program, and retain their last-stored
> values between program startup and program termination.
(multiple google results, unfortunately no official reference link)

Bug: https://bugs.gentoo.org/926341
Signed-off-by: Andreas K. Hüttel <dilfridge@gentoo.org>
---
Only build-tested so far, but should be straightforward enough...
---
 rdma/rdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rdma/rdma.c b/rdma/rdma.c
index 131c6b2a..f835bf3f 100644
--- a/rdma/rdma.c
+++ b/rdma/rdma.c
@@ -4,6 +4,7 @@
  * Authors:     Leon Romanovsky <leonro@mellanox.com>
  */
 
+#include <libgen.h>
 #include "rdma.h"
 #include "version.h"
 #include "color.h"
-- 
2.44.2


