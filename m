Return-Path: <netdev+bounces-95502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD9B8C26FF
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 16:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 272811F24D9A
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 14:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4D1170895;
	Fri, 10 May 2024 14:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=gabifalk@gmx.com header.b="BOveBMYN"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA49170842
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 14:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715351828; cv=none; b=iKteQnCsnrRvzlWkk3L+e88TStcuraOZJHYRnoQ31nbJkSqaxBC5tKby8eJb8zJO4MW82793Dczt109u90uA8soHV4t3z5VlTyKiqVR+SNIRHCgmChmtsk1njbQWeRtWhm/5PHlcE79DpPGQqkbFBVuKXGEfBgZtdaddf1iI46w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715351828; c=relaxed/simple;
	bh=PURUP7mUa8cxlTORcW5XLAfB/QP+eo8uH5UFwYl4S/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B5yoS6yIBzoAYsMPI0LDoxQk6h2s2xFtRM0gU8JhVUsQLD8MJhii8WsyfH37googsJDBg3j4e3PbgP5PZtkhXo3WvenB6L8qNwl1ZYYS7tBmPj++tdqlKfdXXLsDfhfvWM5gIJuNA4c48zoVulu8zi7Da/zcuc1/C6CAC+XTo5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=gabifalk@gmx.com header.b=BOveBMYN; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1715351824; x=1715956624; i=gabifalk@gmx.com;
	bh=zVa8m9XE1a0HWhjQyF6jbJGnviYXI6E29uLCGXkVgxs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BOveBMYNDCT/2BSM1EgVEmBJ6po6Lbb7XeUJPCgwK+ZP/qv0XDAeskYOxHK6YVdJ
	 uQqAmBqq0mhwoEtwuhK7ZB7opw+3zgpuKDdhd4dSKTE9CZvsAXGyHiWuUU3GKBbJh
	 xhzkoH33npErsuGrOHEeyCREwLAp2nPeTLgnObVR1/ez/kHXzqId1LFLAf5irDFj/
	 2sn3xRb2qHC3XHCRCkASErvJiAXz5ai9mIM23aQzuRk1LK3NbE4vk1j16Q2E0P2cI
	 JBYfGKyWI6Fgut1EqfjtL3KJuuX6I/JNTO6VJONnFLiWuyraJ79FqRj6h72mqHlfz
	 eltd5zXabpk7xKVlww==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost ([46.120.22.143]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MBm1U-1rtJtc0wPs-00C6nq; Fri, 10
 May 2024 16:37:04 +0200
From: Gabi Falk <gabifalk@gmx.com>
To: netdev@vger.kernel.org
Cc: Gabi Falk <gabifalk@gmx.com>
Subject: [PATCH v2 iproute2] bridge/vlan.c: bridge/vlan.c: fix build with gcc 14 on musl systems
Date: Fri, 10 May 2024 14:36:12 +0000
Message-ID: <20240510143613.1531283-1-gabifalk@gmx.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240510142346.1508152-1-gabifalk@gmx.com>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q6f8pqsHASBVFqODTQv9sxNx1n7L9F65azo38fBu+PWVRtwGSDC
 PO0G/XAZt+/YyZa+4QHVJ3ueQOqiTC9hukHd/xtM9yHET52WIQChTLRbtm4xNfPrfb/+Znp
 e83Go/DgRi4TyKMPNOesipxRAIL+OTzIF+GdLFQFDKrWoCbJRfBgi04F9+fiD9HLp3vKRga
 lLzvUS0E32x3AM1qKGpMg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wsrje73Rz1k=;FI9xJb7qqYnYTHvCud5OCUJA2rr
 mWLNin8uh4kSEmA7+yKS16G9FnD2urOIeJERZAqQYxmmwECZnF/m/suy9maaof0N6bQOvAvry
 yarCFHSKxsufbLSHhMCRRG4ln3macEukmHECgq/qdUG0KgZOLf3vgupA33+5kqC1YiXN3MgDQ
 Q8xeg0ihhp97VRiLP+C2BEOK/SgTP7cQXbVdBcoUnEsoUHiqNKNLvjDZoABKqe46+ZOhJZfJj
 AOJnU3Qg3q1BGTLGINM0PsuHmy1duMLw4BksEpJhMsc5xbpeXD3JuN4/nmXOdRiLCWDyFyiEu
 rStrPNHYny3CiSaNkNcI8AaMwEm1a7Zc/ccZGWEmZOO8E1Ot5YNHKtuuRBqFrKUt69ll3XpIw
 9V7hY5wwKiWta0Pdx4yBahb4FIoS3PVA7cSSZ8TkWfKLU3cWmHyRZDj9bTnAsT1fyKT88AGDH
 84oRNI9ZFXoLPeXfQNqCzjRqxIokbxSAsYJs2yQVm3CZN3M/XzMOIgHsKPfzi54ySb0vH+zNE
 hUJcxjZDIOm4XpKi3l9EWKy4cQ4utCgOEMZdQzzsRqxL5GUaRjFt1KEIV2/dQhnCIb9OKeCKH
 F2X7hPGj7uZWGvBkMeFm74FjjqhXJ0f08AHl12s+2Xj4ROHdx9lcjT5V97HC80VQzA37QIv1H
 uBvAB5cipn6iR491eO2mc2HDf0C8vlVRELcqmt7c0Wh648A4ahfiKj+bkmk0AAnoyAjvYCqeV
 85Ftq4JRzNNRsbWilInHijhHuZpxkJ35UT7pbAlNcmP5U+Qc2XVnymvfyRJIucGmH9I9D3z7t
 Pyp6hjeQYYmH9Zxpab2jjRJJVGfTmdncl2e+7GDHFOQYs=

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

Signed-off-by: Gabi Falk <gabifalk@gmx.com>
=2D--
 bridge/vlan.c | 1 +
 bridge/vni.c  | 1 +
 vdpa/vdpa.c   | 1 +
 3 files changed, 3 insertions(+)

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
diff --git a/bridge/vni.c b/bridge/vni.c
index a7abe6de..e1f981fc 100644
=2D-- a/bridge/vni.c
+++ b/bridge/vni.c
@@ -10,6 +10,7 @@
 #include <string.h>
 #include <fcntl.h>
 #include <sys/socket.h>
+#include <sys/time.h>
 #include <net/if.h>
 #include <netinet/in.h>
 #include <linux/if_link.h>
diff --git a/vdpa/vdpa.c b/vdpa/vdpa.c
index 6e4a9c11..43f87824 100644
=2D-- a/vdpa/vdpa.c
+++ b/vdpa/vdpa.c
@@ -3,6 +3,7 @@
 #include <stdio.h>
 #include <getopt.h>
 #include <errno.h>
+#include <sys/time.h>
 #include <linux/genetlink.h>
 #include <linux/if_ether.h>
 #include <linux/vdpa.h>
=2D-
gabi


