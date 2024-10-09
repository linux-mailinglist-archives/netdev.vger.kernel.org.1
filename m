Return-Path: <netdev+bounces-133582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEBF99660A
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 11:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB6071F26BBF
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 09:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD9C18FDAE;
	Wed,  9 Oct 2024 09:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYcH4Go6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A870218E36E
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 09:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728467605; cv=none; b=CWQlHLJy3qV8GAxwoYBTBQxyfiowyuUk814BLRruS+S7+TYbb0Q3Wrf4bpAcW2bCf9P1nnkk6qYs/7ufB6sUHycuyXwjmG9jSpgSTxmqXp7785xYBZ5zaVwn9npJVvKt2NFeL0GGWp817f/o+SDTTr7yn4wu1pojEizLxSJy1R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728467605; c=relaxed/simple;
	bh=F2XhvOHh/Hm8PvuaJt9wCdMxqpfZVyicuiJ5TnRuiJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=acWQDl2R/7QBGMshqUo9z81se5bFouon++ZKDhUqWsTINKWTJrnwY3BaA+NEkf8gCdrjmjbj7PlVWm5YoL1k12PCd7nbtuzbBzkbCn1iPsDUR4SClBghGjx0JPCMSIfiZDur5H4ckP0r2Qx4+QvqNn3dZwDgnY31Y6p7LMuvXnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYcH4Go6; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20b833f9b35so57558085ad.2
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 02:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728467603; x=1729072403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jEKMkad4kFs/dGfs87IDHI956zjpKlFA4h4DN10Ks5s=;
        b=DYcH4Go6xaLdWxnAePj9xzMsYn+hC9VFtgPKNzEHbS48SaQtpZsCTqzX3oM75vKSik
         RUhgpbjyQ8UIgKEft/xDuUCmr1D8b3d+gyLn3id2vAJBMrqyj6o3COWzxhhD5MzAhuom
         s0NsNEa6Yr7sWBL5v8/YViP1tdP4XkdeppFZ7aqhh1bTfpURV74HcfYMW63SFMEB1hiW
         z2RcIvmVAo/+8NQIKPzwBihaAY0grARaLoTj3zP2l8lLIW7xSsBHCII720azWFufSv3D
         L03VrQxX9FBUOQvIOnd5+nHmLpELvZXo9B7ZS69r61vb+Pxpkbw34Ri7nWxh/1wmN4oK
         /Vng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728467603; x=1729072403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jEKMkad4kFs/dGfs87IDHI956zjpKlFA4h4DN10Ks5s=;
        b=RphioBqt2rgrdOIsPISpmp3JYIJQZxaUX176RqWUGN3mz045SB+6olMGQZjmJnLEpm
         Tw9slkTOzgdqrODbZ9GtfoZBwwL1oNjWA/XEEKFyJDIfgv7t2nmPZDspIdQvA4lcY4DL
         Y/2rFZ+WaYrSBRyYvjOU/RMxB6aCPUxJOZ9SZqffJIZBy79hiRZafeumrJxJ9XmaNiEt
         QFCC0qGsUwgx6ZhWMm0zDHQe0Z6536ap5BkNMv53BakLIeG0l0n2Ma6T3S0dlMKE/dsZ
         h/3qwhAEF3QLJ0tuZrCdHMICO9NzEIfg9pLMgmDEI5XZ2CSkeuxmO6f7T0q7dQWMLJ5E
         DHtw==
X-Gm-Message-State: AOJu0YzYPQYatDo3Na9qNjmu+e9W4iFLSicL76wUEE9/nJh2UtsbxovS
	TClHtv+lM1JowRomZDbEs/x3AHt4YfiVbZVlSqyK6dZVrR7a3oUt2+dJ2TJkDqE=
X-Google-Smtp-Source: AGHT+IHANo+orBuVSovO6YLMcW9J1V0H99xMRJvpge3N6MOrGFqMfu8+h0zyGJJbp7VKKEQhfDCd0Q==
X-Received: by 2002:a17:903:41c5:b0:20c:675d:9215 with SMTP id d9443c01a7336-20c675d95b5mr22726615ad.4.1728467602629;
        Wed, 09 Oct 2024 02:53:22 -0700 (PDT)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c6f21a408sm6684545ad.107.2024.10.09.02.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 02:53:22 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@kernel.org>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Jianlin Shi <jishi@redhat.com>
Subject: [PATCH iproute2] ip/ipmroute: use preferred_family to get prefix
Date: Wed,  9 Oct 2024 09:53:09 +0000
Message-ID: <20241009095309.17167-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mroute family is reset to RTNL_FAMILY_IPMR or RTNL_FAMILY_IP6MR when
retrieving the multicast routing cache. However, the get_prefix() and
subsequently __get_addr_1() cannot identify these families. Using
preferred_family to obtain the prefix can resolve this issue.

Fixes: 98ce99273f24 ("mroute: fix up family handling")
Reported-by: Jianlin Shi <jishi@redhat.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 ip/ipmroute.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ip/ipmroute.c b/ip/ipmroute.c
index da58d2953049..c540eab133a4 100644
--- a/ip/ipmroute.c
+++ b/ip/ipmroute.c
@@ -271,7 +271,7 @@ static int mroute_list(int argc, char **argv)
 			id = *argv;
 		} else if (matches(*argv, "from") == 0) {
 			NEXT_ARG();
-			if (get_prefix(&filter.msrc, *argv, family))
+			if (get_prefix(&filter.msrc, *argv, preferred_family))
 				invarg("from value is invalid\n", *argv);
 		} else {
 			if (strcmp(*argv, "to") == 0) {
@@ -279,7 +279,7 @@ static int mroute_list(int argc, char **argv)
 			}
 			if (matches(*argv, "help") == 0)
 				usage();
-			if (get_prefix(&filter.mdst, *argv, family))
+			if (get_prefix(&filter.mdst, *argv, preferred_family))
 				invarg("to value is invalid\n", *argv);
 		}
 		argc--; argv++;
-- 
2.46.0


