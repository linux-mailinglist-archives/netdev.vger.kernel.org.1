Return-Path: <netdev+bounces-19644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C335B75B8CB
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 22:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D508A1C213CC
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 20:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04F4156F5;
	Thu, 20 Jul 2023 20:37:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903AC2FA3F
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 20:37:30 +0000 (UTC)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DB31731
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 13:37:28 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-7680e3910dfso133201485a.0
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 13:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689885447; x=1690490247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HriJcnh4jagFumECalyju7yaryuK5V9b2Z8vk5GlVKQ=;
        b=Y+gkgHs1EfES/VwUSmUh4M5VOZjRU63gk0uIyy+tp6VTw2pgoGdJER3PV+YRfxvKvF
         21uqIeSInh6AwrKKuttd7890o1G2aIVQ16+1c1CY7b+51DxPsY8IBLM0tcaCoVt5hADw
         N33AV31R8XY3Al38o+5UkwsURNILxItxUfIzRJ8wKSY63EaKnnG/C8RuFTrQ0Hs+MgRi
         +fecuXELYl5PvBR+j7gUK7zZsgNK4VgS/XbPK2cuNTfvJMX3WIictLQ+HGJQf++clFex
         VkI3TCwms9hK8118WLnvIfPXGX3CFubjvKE7m6b7+QDGiNkN6BagG0vueR/FYpfV0Gkh
         8sCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689885447; x=1690490247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HriJcnh4jagFumECalyju7yaryuK5V9b2Z8vk5GlVKQ=;
        b=ii51ATRgIBc2yp5p1Rd4d9EPsybRldVQGrVwUAJ2cFEieERORHoGW2Uk4xfxc5a0rg
         9rZFdGqueHqB9TCEJ2XSt/Ikau8f1oJkaRL5rs95H43mcD3YsRbOJmGOJAa2tS7Lii1A
         GJMDcukausPLjlZ8WTcLU8rAZ7h4HTKD5msWX9Bx8QtXZQyj6s3a6nIt6g5gZTaWH1eh
         oeDmiRd26WpLaC8l++lGxj+UP6SRAfzRTxmpXx5OgY4jvXF8fHY63mgGuCQJNfHFWNwp
         vsqEOdtwrWuzZStFhGLT5dReHpWT/9UGB8DBcTFDcGQNiKuFxbr1O5JW6uZxmA9p5zEK
         6CIg==
X-Gm-Message-State: ABy/qLYb9pM1fBLbc/ByKk+ltSEbTgOertjyYwLK0vs/mHYW3RTEVRm/
	wbKywQ8WU0ehjOxyTuNQ7z2al1vnpC1MkTZYeFg=
X-Google-Smtp-Source: APBJJlGjNU3rnGda6Zc7k3MubYsKXCrLSCvZLV52vGnk0IrK57do/nEZ3ayinTrELlttDQpWLf5WSg==
X-Received: by 2002:ad4:5428:0:b0:636:e56c:eedb with SMTP id g8-20020ad45428000000b00636e56ceedbmr161981qvt.34.1689885447409;
        Thu, 20 Jul 2023 13:37:27 -0700 (PDT)
Received: from megalith.cgocable.net ([2001:1970:5b1f:ab00:fc4e:ec42:7e5d:48dd])
        by smtp.gmail.com with ESMTPSA id o4-20020a0ce404000000b0063c5fdf65b4sm710967qvl.130.2023.07.20.13.37.26
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 13:37:27 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
To: netdev@vger.kernel.org
Subject: [PATCH iproute2] bridge/mdb.c: include limits.h
Date: Thu, 20 Jul 2023 16:37:26 -0400
Message-ID: <20230720203726.2316251-1-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

While building iproute2 6.4.0 with musl using Yocto Project, errors such
as the following were encountered:

| mdb.c: In function 'mdb_parse_vni':
| mdb.c:666:47: error: 'ULONG_MAX' undeclared (first use in this function)
|   666 |         if ((endptr && *endptr) || vni_num == ULONG_MAX)
|       |                                               ^~~~~~~~~
| mdb.c:666:47: note: 'ULONG_MAX' is defined in header '<limits.h>'; did you forget to '#include <limits.h>'?

Include limits.h in bridge/mdb.c to fix this issue. This change is based
on one in Alpine Linux, but the author there had no plans to submit:
https://git.alpinelinux.org/aports/commit/main/iproute2/include.patch?id=bd46efb8a8da54948639cebcfa5b37bd608f1069

Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 bridge/mdb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bridge/mdb.c b/bridge/mdb.c
index fbb4f704..18793458 100644
--- a/bridge/mdb.c
+++ b/bridge/mdb.c
@@ -15,6 +15,7 @@
 #include <string.h>
 #include <arpa/inet.h>
 #include <netdb.h>
+#include <limits.h>
 
 #include "libnetlink.h"
 #include "utils.h"
-- 
2.41.0


