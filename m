Return-Path: <netdev+bounces-96272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9988C4C65
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 08:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB366B20AB2
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 06:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9994DBA42;
	Tue, 14 May 2024 06:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiY5T07L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED170AD49
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 06:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715668726; cv=none; b=Lv5EOhHMzmvPKAtGD5drduenvriUm19oF63T+JibOZVNPKYeX8zpNePycVIUQbzxB+A6qbEKlhFOkTIwW17Jggg3L5n4DNySV22mnSzVrLezrP/atT6SEYma4PfguzwEuBew/AocnCHslukvs+QYC7h48df4O6uqjd/mXd8e5NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715668726; c=relaxed/simple;
	bh=Qm6rNt8dPj6daYE776RKEyJDTac1R8bYkiYVwnaxtLo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=YJJqALGDkAbHT8JXL+XS1li+QNxw8R6cg27WMrET1Rp8kckgPBCLEAhXWk/ZikFuMvtVBeQ0c7ZSBiHzxeAafpgny8xDUMK3zFMtKhwSSz2DjJI824iyAAHUKAOdYHaP+Q3PM70UVAVFm10e5bJweB17LSzffYEukeiGYRw9ZnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jiY5T07L; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41ff0c3eacdso2285605e9.2
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 23:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715668723; x=1716273523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kYYX01YUkTOtcRVVkBXGTTJzKddGkklHmJORcYWbWiE=;
        b=jiY5T07LpJJWKB42n2haVOUTu5RufNPg0R9+hvA91oPS8hD2YSWIz/KLAAx1Zt/POK
         8lkYFEXKTCCEdkJZFsIkmCwoS0bh8CWrbwr9FOVFHktbwg/AH9na3Ah0sqoWDL7h91sH
         qW/Uam9VbzNkyYO0/Q3Hny7GkcAT4BqjDImqobfv+1LmRjSvHSGBGD62KKOrfOzitT6n
         invTsNgmgS5cgOhW8GrOYpbDpTfQauw4HHKAz9froGEYdkiv6tygAX/58b6B73rbCyQx
         mUjZRK7UCVBk4FkfKLvhEB+A2wFGVACJ3ttg90V0fZeYnHUS3NrlBZB9PSMt/vH9B0XQ
         UYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715668723; x=1716273523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kYYX01YUkTOtcRVVkBXGTTJzKddGkklHmJORcYWbWiE=;
        b=T5Ml7lwEtAN52Y+bO/oAH+9uc0aNaAAnRDCTiakbM1uBTj2u4VoTVHY4QK90Ef4c8l
         j28gI0f8uctce1f/h2hz22PalpvZ3O2m8IyZry9PiCt4K4TNFEZErH8qxOcMhOfn+LTY
         xsYb3gNjOMN97A56qywtRyMmzDFTbajfi4eJ7lMruH1Nca5WQyGzRXwvOsQqHWLXl2QS
         0Dels3w/35hYHLkzV5gRRihDN6yRRiu67d2gzMUFXGEutFrHdq+I83bEJj4DncKlheE6
         bISTlPDc5C3QIrSi6N1v+0gF1Y+GhSg6gUDSKx1YfHLheDEcYxXwwxzY/yRdTgHWIU39
         2Znw==
X-Gm-Message-State: AOJu0YxMVFhLazvMwMf4rEtXuIyG9QRYDmdIdBvEEwko7HKVLf7Tn3c3
	FoUcDPdWoaOOmJWMeNsNqp0toNFYpDBhgryBWcsQFjAUps0haVJvWg5SKO8b
X-Google-Smtp-Source: AGHT+IGUEXSvKxOqZNSVNk69oqn/mlkTP0itGdwJSUu1XWvMTvln9PyPGFPhboHLBxFbLQOBq83cnw==
X-Received: by 2002:a05:600c:1d0a:b0:41b:e58c:e007 with SMTP id 5b1f17b1804b1-41fead7a643mr86213705e9.4.1715668722504;
        Mon, 13 May 2024 23:38:42 -0700 (PDT)
Received: from gentoo-musl-test.lxd ([115.187.46.112])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-41f87c25459sm217109735e9.18.2024.05.13.23.38.40
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 23:38:41 -0700 (PDT)
From: Brahmajit Das <brahmajit.xyz@gmail.com>
To: netdev@vger.kernel.org
Subject: [PATCH 1/1] Fix implicit declaration of function 'htobe64' in gcc 14 on musl systems
Date: Tue, 14 May 2024 06:35:37 +0000
Message-ID: <20240514063811.383371-1-brahmajit.xyz@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On musl systems with GCC 14 and above, the htobe64 function cannot be
found by default. From the man page[0], the function is from endian.h
header file. If the file is not included in, then we get the following
error message. The issue however cannot be reproduced on glibc systems.

In file included from ../include/libgenl.h:5,
                 from libgenl.c:12:
../include/libnetlink.h: In function 'rta_getattr_be64':
../include/libnetlink.h:281:16: error: implicit declaration of function 'htobe64' [-Wimplicit-function-declaration]
  281 |         return htobe64(rta_getattr_u64(rta));
      |                ^~~~~~~
make[1]: *** [../config.include:24: libgenl.o] Error 1

[0]: https://linux.die.net/man/3/htobe64

Signed-off-by: Brahmajit Das <brahmajit.xyz@gmail.com>
---
 include/libnetlink.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/libnetlink.h b/include/libnetlink.h
index 30f0c2d2..77e81815 100644
--- a/include/libnetlink.h
+++ b/include/libnetlink.h
@@ -12,6 +12,7 @@
 #include <linux/neighbour.h>
 #include <linux/netconf.h>
 #include <arpa/inet.h>
+#include <endian.h>
 
 struct rtnl_handle {
 	int			fd;
-- 
2.45.0


