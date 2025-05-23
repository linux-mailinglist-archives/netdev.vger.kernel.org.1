Return-Path: <netdev+bounces-192918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CEEAC1A61
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 05:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED4F8A42CCD
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 03:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A007220F20;
	Fri, 23 May 2025 03:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ql0iWFsD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE6B2DCBE7
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 03:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747970734; cv=none; b=JrgZuBCjvLIkDfym8gfpqK7qiP1NV3oHU1SFgCC0uczFGd8n1GVlW1RaCiKpmYl2rf+Rg0naSvJpv7k/BNc0I3Rn1bs4rJGgHIawql/soDYi8wND/0Wuk+H5A2vXy7e2VFeLxt7OK9VDDSbB5sZx2RgUuzObjpmull1sMpoA+EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747970734; c=relaxed/simple;
	bh=7g7uI4qpyx5pmzUet4Y4XxNBNYzZ6ES55RfzClVS5lU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ILTceuZE+F3By1EhT/sNPnFQqSj+JceE6CKdAVZNV13HkX/LenAwNSqT87AVf3STmC9qod3mgLUF4vjrKCGtpfz9sNO5lAyL+9doj2HZ68R6dsMuXLPyINoXXZiQ6qQtG9arSBWQXszqdFCT0AhA1xhRrEOqe/b6Qi4QN47KgTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ql0iWFsD; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7394772635dso6361011b3a.0
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 20:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747970730; x=1748575530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AvnmG1muOxMgS8qNju6SA5T467j3gsLgfCM4zNl8E5o=;
        b=Ql0iWFsDpcPOBJyefnpxzothHlbKDO4l6+Z+YOCoST+79GEEzG4B4YtTnb3fSoBJMY
         UIgR5dfG80EYRRNxzGk9uRrxFC6oUE41CYjIpCkpInBJYRYXmmmq+5qxGQJT68KI7GHT
         lfYuNT+oR4W/bnoxzvjEmFVIjWKBQyX/MvvgHwhGi8Ve6rrub808PjDB0kyu1huVVoIv
         IYl1W5U0TLWqS2t5P+Y2V4StDm40ji4atVyS7j+ppaNj1w7Uczce5hrfb6uUK3RbjjXD
         8YWpVfpNpBcXnBGV0PQdrxuG/zRgkPmJyHqSQbFJ+lbBM8zXaEjrb12+Bh27rkNqAvAB
         Kyog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747970730; x=1748575530;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AvnmG1muOxMgS8qNju6SA5T467j3gsLgfCM4zNl8E5o=;
        b=AK5ZnO7QZ6xZq0tQ146EhqtM6FKada93tohiCrUO3Rz9KcB8t5mEn9wGoKE3d9/bhE
         ZN51fIgAj2fAL1qTp5hr0pkHF+4SegiDqqYq0ip0d+yVcDEsUYPE7FlvvcMEpJ7O0ow+
         DrMXQ3VkgbuzRZTXEkBcnCKRgE6nUWoQyQXbwqUGUNi7vaSOCEPv30jFLghfxYCal2ZA
         TakXjnkPr27sQDDx2D6U4Bo8rMnJb0aBNOKIwNpMcuAL4AQjsdlOxl7VPSUwWVNFL49R
         30K47kAN6yjelgf5Q4+Y5A6bjmVOA8DgC0JmeLHaJkLqODbyBcMuCV4cn5eFOhe8xfXo
         NjtQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9n16QpYVCRiP0bTDWx7gD+/6/d1zn7hEK6U6Z9C37jZvlr1mKQ51N3OkkWEuHM0laY4Rb+EQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5s9xrmRqeUFZCqt7XKdfE1YDYI96+NNgJNgDESELuUMU47xR4
	Kr0Nd0ehCZx4xUGPj/MOOvT2dfdkZVTfQCJtB/Eue+OOhqKKmsYhsSKHw++k0e5zA/R30WZT2pS
	ns8lhNOnvo7s5Tnty+NgLjHjkJQ==
X-Google-Smtp-Source: AGHT+IFr9sIaedgXmdU+43OMl6m/noUp43/4toQhhKOaWiEmXvU4723s+wg27dvO3gCq2fj2MwCs4AdfzrD0Ad6ZIA==
X-Received: from pgac20.prod.google.com ([2002:a05:6a02:2954:b0:b1f:8cc1:95c1])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:1807:b0:203:becd:f9ce with SMTP id adf61e73a8af0-2170ce3a504mr38199942637.39.1747970730660;
 Thu, 22 May 2025 20:25:30 -0700 (PDT)
Date: Fri, 23 May 2025 12:25:18 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250523032518.251497-1-yuyanghuang@google.com>
Subject: [PATCH iproute2] iproute2: bugfix - restore ip monitor backward compatibility.
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	Luca Boccassi <bluca@debian.org>, "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>, 
	Adel Belhouane <bugs.a.b@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The current ip monitor implementation fails on older kernels that lack
newer RTNLGRP_* definitions. As ip monitor is expected to maintain
backward compatibility, this commit updates the code to check if errno
is not EINVAL when rtnl_add_nl_group() fails. This change restores ip
monitor's backward compatibility with older kernel versions.

Cc: David Ahern <dsahern@kernel.org>
Cc: Luca Boccassi <bluca@debian.org>
Cc: Maciej =C5=BBenczykowski <maze@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Reported-by: Adel Belhouane <bugs.a.b@free.fr>
Closes: https://lore.kernel.org/netdev/CADXeF1GgJ_1tee3hc7gca2Z21Lyi3mzxq52=
sSfMg3mFQd2rGWQ@mail.gmail.com/T/#t
Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
---
 ip/ipmonitor.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/ip/ipmonitor.c b/ip/ipmonitor.c
index b890b4d0..1f4e860f 100644
--- a/ip/ipmonitor.c
+++ b/ip/ipmonitor.c
@@ -5,6 +5,7 @@
  * Authors:	Alexey Kuznetsov, <kuznet@ms2.inr.ac.ru>
  */
=20
+#include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
@@ -328,38 +329,46 @@ int do_ipmonitor(int argc, char **argv)
=20
 	if (lmask & IPMON_LNEXTHOP &&
 	    rtnl_add_nl_group(&rth, RTNLGRP_NEXTHOP) < 0) {
-		fprintf(stderr, "Failed to add nexthop group to list\n");
-		exit(1);
+		if (errno !=3D EINVAL) {
+			fprintf(stderr, "Failed to add nexthop group to list\n");
+			exit(1);
+		}
 	}
=20
 	if (lmask & IPMON_LSTATS &&
 	    rtnl_add_nl_group(&rth, RTNLGRP_STATS) < 0 &&
 	    nmask & IPMON_LSTATS) {
-		fprintf(stderr, "Failed to add stats group to list\n");
-		exit(1);
+		if (errno !=3D EINVAL) {
+			fprintf(stderr, "Failed to add stats group to list\n");
+			exit(1);
+		}
 	}
=20
 	if (lmask & IPMON_LMADDR) {
 		if ((!preferred_family || preferred_family =3D=3D AF_INET) &&
 		    rtnl_add_nl_group(&rth, RTNLGRP_IPV4_MCADDR) < 0) {
-			fprintf(stderr,
-				"Failed to add ipv4 mcaddr group to list\n");
-			exit(1);
+			if (errno !=3D EINVAL) {
+				fprintf(stderr, "Failed to add ipv4 mcaddr group to list\n");
+				exit(1);
+			}
 		}
 		if ((!preferred_family || preferred_family =3D=3D AF_INET6) &&
 		    rtnl_add_nl_group(&rth, RTNLGRP_IPV6_MCADDR) < 0) {
-			fprintf(stderr,
-				"Failed to add ipv6 mcaddr group to list\n");
-			exit(1);
+			if (errno !=3D EINVAL) {
+				fprintf(stderr,
+					"Failed to add ipv6 mcaddr group to list\n");
+				exit(1);
+			}
 		}
 	}
=20
 	if (lmask & IPMON_LACADDR) {
 		if ((!preferred_family || preferred_family =3D=3D AF_INET6) &&
 		    rtnl_add_nl_group(&rth, RTNLGRP_IPV6_ACADDR) < 0) {
-			fprintf(stderr,
-				"Failed to add ipv6 acaddr group to list\n");
-			exit(1);
+			if (errno !=3D EINVAL) {
+				fprintf(stderr, "Failed to add ipv6 acaddr group to list\n");
+				exit(1);
+			}
 		}
 	}
=20
--=20
2.49.0.1204.g71687c7c1d-goog


