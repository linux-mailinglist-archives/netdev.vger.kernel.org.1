Return-Path: <netdev+bounces-131932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0964298FF7C
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 11:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69480282067
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 09:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185E213D244;
	Fri,  4 Oct 2024 09:20:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eidolon.nox.tf (eidolon.nox.tf [185.142.180.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EBE146A68
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 09:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728033600; cv=none; b=FkKgXmqBGoGdQoFQI1Mbm9kjLaH8jELTk/mLr2vZ5Q8humkhFjqmkBaR/R+ynZbasDATcCps2sD/g8P0UtChhZ2YdFiZg4WlUmIRJgNBKvqfeMc6wwWnV+Jy4/qiD84O14FUkcktiK9pWTsMclUQSTb7zuKC2OgKrgUZd6+zF5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728033600; c=relaxed/simple;
	bh=lIOIUD/Hh94tGgsFr1gNc65qT7EslmF1axiWhJ3Jv30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eU9KZgL6C45nmN/FZCtQNzIH9kZQMfxize7HD4F0da/JWc3TYCY3XOaSkxZKRe+XKwpiYWkVMRqwPZW/wa6fFt0ZESRlk6sHAU32f2jzmacGaJ/vx5/uXIktNSKZOOIz7+n7+Q9R84824iVT7bKNF0MIfkRAGMVTOPNgnboYAcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net; spf=pass smtp.mailfrom=diac24.net; arc=none smtp.client-ip=185.142.180.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=diac24.net
Received: from [178.197.223.28] (helo=alea.q.nox.tf)
	by eidolon.nox.tf with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <equinox@diac24.net>)
	id 1sweS5-00000000d8S-35UO;
	Fri, 04 Oct 2024 11:18:22 +0200
Received: from equinox by alea.q.nox.tf with local (Exim 4.98)
	(envelope-from <equinox@diac24.net>)
	id 1sweRh-00000000G1q-46cP;
	Fri, 04 Oct 2024 11:17:58 +0200
From: David Lamparter <equinox@diac24.net>
To: David Ahern <dsahern@gmail.com>
Cc: netdev@vger.kernel.org,
	David Lamparter <equinox@diac24.net>
Subject: [PATCH iproute2-next] rt_names: read `rt_addrprotos.d` directory
Date: Fri,  4 Oct 2024 11:16:38 +0200
Message-ID: <20241004091724.61344-1-equinox@diac24.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`rt_addrprotos` doesn't currently use the `.d` directory thing - add it.

My magic 8-ball predicts we might be grabbing a value or two for use in
FRRouting at some point in the future.  Let's make it so we can ship
those in a separate file when it's time.

Signed-off-by: David Lamparter <equinox@diac24.net>
---
 etc/iproute2/rt_addrprotos.d/README | 2 ++
 lib/rt_names.c                      | 3 +++
 man/man8/ip-address.8.in            | 5 ++++-
 3 files changed, 9 insertions(+), 1 deletion(-)
 create mode 100644 etc/iproute2/rt_addrprotos.d/README

diff --git a/etc/iproute2/rt_addrprotos.d/README b/etc/iproute2/rt_addrprotos.d/README
new file mode 100644
index 000000000000..092115b12423
--- /dev/null
+++ b/etc/iproute2/rt_addrprotos.d/README
@@ -0,0 +1,2 @@
+Each file in this directory is an rt_addrprotos configuration file. iproute2
+commands scan this directory processing all files that end in '.conf'.
diff --git a/lib/rt_names.c b/lib/rt_names.c
index e967e0cac5b4..f44b1e4ba34e 100644
--- a/lib/rt_names.c
+++ b/lib/rt_names.c
@@ -315,6 +315,9 @@ static void rtnl_addrprot_initialize(void)
 		ret = rtnl_tab_initialize(CONF_USR_DIR "/rt_addrprotos",
 					  rtnl_addrprot_tab,
 					  ARRAY_SIZE(rtnl_addrprot_tab));
+
+	rtnl_tab_initialize_dir("rt_addrprotos.d", rtnl_addrprot_tab,
+				ARRAY_SIZE(rtnl_addrprot_tab));
 }
 
 const char *rtnl_addrprot_n2a(__u8 id, char *buf, int len)
diff --git a/man/man8/ip-address.8.in b/man/man8/ip-address.8.in
index d37dddb7b1a9..6c3f07f1173a 100644
--- a/man/man8/ip-address.8.in
+++ b/man/man8/ip-address.8.in
@@ -303,7 +303,10 @@ receive multicast traffic.
 the protocol identifier of this route.
 .I ADDRPROTO
 may be a number or a string from the file
-.BR "/etc/iproute2/rt_addrprotos" .
+.BR @SYSCONF_USR_DIR@/rt_addrprotos " or " @SYSCONF_ETC_DIR@/rt_addrprotos
+(has precedence if exists).  A directory named
+.BR rt_addrprotos.d
+is also scanned in either location.
 If the protocol ID is not given,
 
 .B ip assumes protocol 0. Several protocol
-- 
2.45.2


