Return-Path: <netdev+bounces-95496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5138C26BE
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 16:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7DEA1F2168F
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 14:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5347712FB39;
	Fri, 10 May 2024 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=gabifalk@gmx.com header.b="T/aQ35Ld"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A6A4C7D
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 14:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715351047; cv=none; b=ZJhfIEQtO6URVvhzL5TuKTGSUBTF8EiRYWj9nhTckYABo4UepDAMQJi7tbEdfTLxF9EemRVgiEXrTnD2Tuq3QjtEscV3Dqxb+XR2RuLETyp8fl63AYCR7UkQZ2rW8EESdf8wWw+U6QJOnJ8+NFLSD3R6MGiCL4h5zEmmI8i9dzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715351047; c=relaxed/simple;
	bh=SwOheVMFelxh6HynpToo1Q2i3lQ16QwRsjOYuPaa4/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N0RBnfPsTPCYyJwRTkCdWfREx/8AYsYA/I67mlBFJJF8bGfgNr9JJ3eBfZ6uJchptplFif2+St3rOu4oXQDG/B7wE97sXyEvcuEr/C/3ELtKhqiFKe2lzjvzwvI7Kyh/McDLHEADmr2myN6PrXfcnHMRvgpwjMLXUhF5keDotYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=gabifalk@gmx.com header.b=T/aQ35Ld; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1715351042; x=1715955842; i=gabifalk@gmx.com;
	bh=i55y6QRiveLDzlZQzkbZY0jhSnz+aae36ppOPoA2gqI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=T/aQ35Lda9kB9g1MY1vwvwJ/7hQuQMCydEUFn8r6T9cyZC7SKqSUcFcENj1RONXm
	 XurEud2NFlyB4WjhRrNuaPk6G/2ugemyi8ekgk3ZYYF+voS3f4uxh80QEe4F9YRhj
	 4qZ/FfFMxeCsrTHdvKDZW5vTJIazVvsGuqoK93leV8arJ2fAN1meaG2BV35y8/CHB
	 OYRi6ydHS15/i95Oz4YH3ledWvOpWqQChpfjoS6OpbE2PvJZqA+4+oXgWqdo8aIbv
	 YzzVgM+LnhGy1zkKqxehpoVMF1tKOqefM/zzvZi7C8yt5qneEMyzT2nNrIlEuoMgF
	 5Fo4AuvT/I1lPNHR5g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost ([46.120.22.143]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M7b2d-1ry1BX2iQn-0082D1; Fri, 10
 May 2024 16:24:02 +0200
From: Gabi Falk <gabifalk@gmx.com>
To: netdev@vger.kernel.org
Cc: Gabi Falk <gabifalk@gmx.com>
Subject: [PATCH iproute2] bridge/vlan.c: fix build with gcc 14 on musl systems
Date: Fri, 10 May 2024 14:23:45 +0000
Message-ID: <20240510142346.1508152-1-gabifalk@gmx.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QbM3tpoYTl2AUQ7h55nErgvYlZQhQaNvSAgI6jEeIliq59JdqjU
 2hTBDaftM/e82Z3NJ0MzBWNg1elIpoDo1ypMNgK67bWbywANRax5F9HIwGI555FmwS0XNAF
 3RfUGtTUQPX1xV899Jlrug8jv4GVWIm2hyrlAiwboAy2weJN6yi2Sv5MZBQWB6kr238J3jd
 UKuMCbRqgi8C6meJkGzZg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:a3/03oOgdIQ=;ZW4fNOumrkB+2uqGVw2AuXKxm4h
 38SxIWaoDemN97x3Jvcc1HcSJ/UjpQRM+WVJICbdmlnH9BQF1stSNbBmYrC6yT/dwUGOkHL1F
 7qTGenicmJIQDhK78QTnzATm6Z5wrV8lQl4NoFn/ADWQiN30336HB2SaK9aLif/8qVu1LQyMv
 c9c24dXUiKtDAII2FSoXiBbHH30gFeGBcOlkDsyPGTmQr4IhQ+wv3vDU8GdRultx1QR3juo0w
 lyx78j5jNP9i4a7IeS+OiEy1sHMwozlaNVZUnGx3MiHzFDi6DCYBlw7jIB6lycQ/7cP0NXXJz
 5uyUSSnoT0VHcBXjIcC2BrXeGTGU2fVgcoGZSDCRJ0UoyL2MetqxQwCaLdyfegwkIx4s/rTeG
 dqDF3TSmPodDSLuk9JDriPTn4BedWlMso3DOqX9VOuD83Lx9OOZ7yty1yBi0YL4+Sqb6o7bvw
 N8nlKdfCbnEHLC5z6DBdwFHeQmqrbEBD7lZtMmFlphFzGsRQU5A0eLFpk+YDRxbosL7G/xbpk
 CWI3FaucXxCUT3ib9R73NErBzLqrTFucgZy5AzCKYGyafcuDs/s7ch4POQGQmexqeZkSLvqqO
 ocGLk+1Nm3VdkcxvRDjRT9aJQ8r3kEXEXT8bH31JhsorzM2f5Ei5Gxf4O6pJ5dwgCtBLGEHgt
 FWDL/QEjGhqp9ZuWRi9IAYtG8ONi9Vg2pYocU6U87ZXL4Xh5t24aTRZAHGRTb5ixJgS2zDDNW
 n1RF4xsP/jyGPnI0BgYJRjoRctwMkMUO0FcP1kGvJDQbkKWWBKcG0x6is8LPUhfhVlY8zA/Tj
 otthiDUHIrXkEvrx2Cw86DS2owN9VwGOIhQ3FNPRfM/44=

On glibc based systems the definition of 'struct timeval' is pulled in
with inclusion of <stdlib.h> header, but on musl based systems it
doesn't work this way.  Missing definition triggers an
incompatible-pointer-types error with gcc 14 (warning on previous
versions of gcc):

../include/json_print.h:80:30: warning: 'struct timeval' declared inside p=
arameter list will not be visible outside of this definition or declaratio=
n
   80 | _PRINT_FUNC(tv, const struct timeval *)
      |                              ^~~~~~~
../include/json_print.h:50:37: note: in definition of macro '_PRINT_FUNC'
   50 |                                     type value);                  =
      \
      |                                     ^~~~
../include/json_print.h:80:30: warning: 'struct timeval' declared inside p=
arameter list will not be visible outside of this definition or declaratio=
n
   80 | _PRINT_FUNC(tv, const struct timeval *)
      |                              ^~~~~~~
../include/json_print.h:55:45: note: in definition of macro '_PRINT_FUNC'
   55 |                                             type value)           =
      \
      |                                             ^~~~
../include/json_print.h: In function 'print_tv':
../include/json_print.h:58:48: error: passing argument 5 of 'print_color_t=
v' from incompatible pointer type [-Wincompatible-pointer-types]
   58 |                                                value);            =
      \
      |                                                ^~~~~
      |                                                |
      |                                                const struct timeva=
l *

Link: https://bugs.gentoo.org/922622
Signed-off-by: Gabi Falk <gabifalk@gmx.com>
=2D--
 bridge/vlan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bridge/vlan.c b/bridge/vlan.c
index 5352eb24..0a7e6c45 100644
=2D-- a/bridge/vlan.c
+++ b/bridge/vlan.c
@@ -4,6 +4,7 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <sys/socket.h>
+#include <sys/time.h>
 #include <net/if.h>
 #include <netinet/in.h>
 #include <linux/if_bridge.h>
=2D-
gabi


