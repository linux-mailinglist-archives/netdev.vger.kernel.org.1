Return-Path: <netdev+bounces-93822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0EE8BD4C2
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 20:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2ACC1F22E25
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 18:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDE715886A;
	Mon,  6 May 2024 18:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxyiP6pB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3110B15821F
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 18:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715021028; cv=none; b=qv9EACSNfaxKX8VxOlp5MT18zX9GsL6OL1+NYvNoVOEK1iYRwOJBSw+Ua7Y+5s5eEVa0sI4i+hou5nFUlQAgRXNM2/mXYs2dwI58WnPSviSkdvbnacwhucxKWQdXNuBdLzphkCvbGgAPqYctZAoHhfb0vkaPFoug0zAqKHc0Sls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715021028; c=relaxed/simple;
	bh=Y8F1J4NEKwMv8yGYtLSDuKaHUenldK0AkirgfHp3W5A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ACMQRzd5ZpjjoNsJUSBh2XGMxz2ZHztmLzaWl2TB9GJOvlwlMGaX1NReGs/quBf1GIKpawVT/vtbXS+KOUqJgV/+wqCNKR61uum94/jvyp1UTE4KU4IG04/lDU5HJO6ql+zK6T/yC231ajHCBbxStAR9d/zzD935iO1Ss22s4Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxyiP6pB; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-34e667905d2so1693813f8f.1
        for <netdev@vger.kernel.org>; Mon, 06 May 2024 11:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715021025; x=1715625825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XGrFeZBE+UyMirIQuvpkVig+uV040mFGH60EiBlLxhc=;
        b=fxyiP6pB5gYuItd0Ih+DnnI8SRLhfxL0HDKBGnJNns5BUbvzpF085GcJx1kBTxclz7
         +CYUt3eM04RaNCsN3uCbxKP6ttl8uOMzYpI6cakt0eQ/JBqkzey9KTPjMUx4g4QVNQQn
         /iWwNggQlypMte7LAajSwiLKmVgUtUXmOMcY6/GHgsY+QmHPZhUjFbnhg1oJ3hCNZdG1
         /3gt8heShEhF39I+FhZg7tH0WvatCAKw6rqyXJI6HDKh53M9bDeCs4FmhB0ZgV6ZPpXA
         KvMGKC/NElktHfDV5tgUjesbbi9PdH9QHQqtjIUJ9c3XDn005CcdWPDav2UgolM/nZ8U
         7NfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715021025; x=1715625825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XGrFeZBE+UyMirIQuvpkVig+uV040mFGH60EiBlLxhc=;
        b=mrYJfuP962TScjk/8k8WHcfTXAEvu6xmGJKsZhLUGFIsYe8O4TFnqmIAD4H4Mo+jJr
         Mu6EzfLVD9NeGNT8+Y3sxKF7N1UsV61p9JzTEH4Gbxec13++X6yv2dSrO9SBVeWZvGVA
         Xx1o9Yy29E+txjyUH2TPNVQdCMDNPdSgf/Eyakxc9kb0a2BejaCbufB+Tkw00KDFdHo3
         6OmV+yKSTY6nCJJeeuY5I8HS0Z16R2WiQz3g1E0BxrFt0QEdFGNv5zVvx/jDnDFhtFk5
         Yp0QK6ti9268cifqdK3syMY4grpmdxZoaoQ16TGPUehxIAvO+TZlC8B+grJA8m5BOpON
         exrA==
X-Gm-Message-State: AOJu0Yx4MhlMxe5QcoKxn3hYib1IPb4CXA5omCAW4csV/Xl9UZaelUdR
	b3Oz1G8uTQmbdN08tiOuMmC+gQrVKOmAzdZkR/nXSrYKvg8iHYgpeohHCwWF
X-Google-Smtp-Source: AGHT+IFzsOWEfUUTTGWcUWD/WLulz2TGFLaLkhIMdCXJQRJdOYWmNtRMJf98tqsEHMblAwIjYPOmdw==
X-Received: by 2002:a05:6000:180e:b0:343:4727:d11e with SMTP id m14-20020a056000180e00b003434727d11emr7804530wrh.47.1715021024984;
        Mon, 06 May 2024 11:43:44 -0700 (PDT)
Received: from lenovo-lap.localdomain (85.64.161.236.dynamic.barak-online.net. [85.64.161.236])
        by smtp.googlemail.com with ESMTPSA id y10-20020a5d620a000000b0034ddb760da2sm11419803wru.79.2024.05.06.11.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 11:43:44 -0700 (PDT)
From: Yedaya Katsman <yedaya.ka@gmail.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Yedaya Katsman <yedaya.ka@gmail.com>
Subject: [PATCH] ip: Add missing options to route get help output
Date: Mon,  6 May 2024 21:42:56 +0300
Message-Id: <20240506184255.1062-1-yedaya.ka@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "as", "to", "connected" and "notify" options were missing from the
help message in the route get section. Add them to usage help and man
page.

Note that there isn't an explanation for "as" or "notify" in the man
page.

Signed-off-by: Yedaya Katsman <yedaya.ka@gmail.com>
---
 ip/iproute.c           |  6 ++++--
 man/man8/ip-route.8.in | 16 ++++++++++++----
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/ip/iproute.c b/ip/iproute.c
index 73dbab48aa45..b53046116826 100644
--- a/ip/iproute.c
+++ b/ip/iproute.c
@@ -61,12 +61,13 @@ static void usage(void)
 		"       ip route save SELECTOR\n"
 		"       ip route restore\n"
 		"       ip route showdump\n"
-		"       ip route get [ ROUTE_GET_FLAGS ] ADDRESS\n"
+		"       ip route get [ ROUTE_GET_FLAGS ] [ to ] ADDRESS\n"
 		"                            [ from ADDRESS iif STRING ]\n"
 		"                            [ oif STRING ] [ tos TOS ]\n"
 		"                            [ mark NUMBER ] [ vrf NAME ]\n"
 		"                            [ uid NUMBER ] [ ipproto PROTOCOL ]\n"
 		"                            [ sport NUMBER ] [ dport NUMBER ]\n"
+		"                            [ as ADDRESS ]\n"
 		"       ip route { add | del | change | append | replace } ROUTE\n"
 		"SELECTOR := [ root PREFIX ] [ match PREFIX ] [ exact PREFIX ]\n"
 		"            [ table TABLE_ID ] [ vrf NAME ] [ proto RTPROTO ]\n"
@@ -112,7 +113,8 @@ static void usage(void)
 		"FLAVOR := { psp | usp | usd | next-csid }\n"
 		"IOAM6HDR := trace prealloc type IOAM6_TRACE_TYPE ns IOAM6_NAMESPACE size IOAM6_TRACE_SIZE\n"
 		"XFRMINFO := if_id IF_ID [ link_dev LINK ]\n"
-		"ROUTE_GET_FLAGS := [ fibmatch ]\n");
+		"ROUTE_GET_FLAGS := ROUTE_GET_FLAG [ ROUTE_GET_FLAGS ]\n"
+		"ROUTE_GET_FLAG := [ connected | fibmatch | notify ]\n");
 	exit(-1);
 }
 
diff --git a/man/man8/ip-route.8.in b/man/man8/ip-route.8.in
index 10387bca66ff..df49f8b0e3a5 100644
--- a/man/man8/ip-route.8.in
+++ b/man/man8/ip-route.8.in
@@ -29,6 +29,7 @@ ip-route \- routing table management
 .ti -8
 .B  ip route get
 .I ROUTE_GET_FLAGS
+.B  [ to ]
 .IR ADDRESS " [ "
 .BI from " ADDRESS " iif " STRING"
 .RB " ] [ " oif
@@ -44,7 +45,9 @@ ip-route \- routing table management
 .B  sport
 .IR NUMBER " ] [ "
 .B  dport
-.IR NUMBER " ] "
+.IR NUMBER " ] ["
+.B  as
+.IR ADDRESS " ]"
 
 .ti -8
 .BR "ip route" " { " add " | " del " | " change " | " append " | "\
@@ -263,9 +266,14 @@ throw " | " unreachable " | " prohibit " | " blackhole " | " nat " ]"
 
 .ti -8
 .IR ROUTE_GET_FLAGS " := "
-.BR " [ "
-.BR fibmatch
-.BR " ] "
+.IR ROUTE_GET_FLAG " [ "
+.IR ROUTE_GET_FLAGS " ] "
+
+.ti -8
+.IR ROUTE_GET_FLAG " := "
+.BR "[ "
+.BR connected " | " fibmatch " | " notify
+.BR "]"
 
 .SH DESCRIPTION
 .B ip route
-- 
2.34.1


