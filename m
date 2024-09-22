Return-Path: <netdev+bounces-129174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F5A97E210
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 16:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D8E12810D6
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 14:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3758A28F1;
	Sun, 22 Sep 2024 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="gU+UYAec"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ADDBA27
	for <netdev@vger.kernel.org>; Sun, 22 Sep 2024 14:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727016622; cv=none; b=jSt5NHA0S0ln0EEsvnJTwviwyu2YymGXiVwzJnNF9oVtjrSzvUbyGNipeIKE8Z9HJqi6lUZeAV36lP7pcXxnzSYGBi9AOUyvRnV2cGuymJnjWGANqbtNaZmYGiVPdlBqMOHMQ8EtAWgFrdSRAwGT9hIvw9NsUL8yu02BpDbKypc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727016622; c=relaxed/simple;
	bh=PaIB284EvgyZEnrtmdJgIB4a5QFh7/X4mK3A44TRcxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bfVUBDdvfwzKqWktLAAm8ErOGfdUqYk33hxQTHaO6HguLjHvCaTGe5nTQ/FD6kqUrNiKY6wdjTMmDlDzmbfEeRYxME6qouWG3VFsqW5W8vXYvAdKPntKXsBxICZHA+VIQsuzrXWTVf7RdR4VntRbo++8sQbipbboT8pCisSBrN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=gU+UYAec; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c46680a71bso2552708a12.2
        for <netdev@vger.kernel.org>; Sun, 22 Sep 2024 07:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1727016619; x=1727621419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3d944BDKuY8b/yUPC5xNbCL96du/ssM/tVVGCvZ3aCI=;
        b=gU+UYAecB9OrIO8JV8OCh1QnyTp39WCgilTf3/bo66I8vL7nWy8df57XuM16X1kcrU
         1SZliNXrW7BN4oQNyGoXgSMMW1pZ8qxb9IE1hUZBwQ6susihOwsGJ3sEWyKZzdvBwPsn
         Tqy/2I8fFkdBDyph/wVvv6fy638epfmsruVug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727016619; x=1727621419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3d944BDKuY8b/yUPC5xNbCL96du/ssM/tVVGCvZ3aCI=;
        b=C8YjUVFV6fDzrOf2F3910vMaC9ltT4T6AcLRU/EIPYROzl0OGGDU0/TfPdbUIqiJvy
         WcBZxQ2Et2dIMId9aKdu/qw6N9tM2QHbPWKX47xs9J/DJh5N9Vj7zNI2voU37mMG+G9X
         nDHP2mQR/wDsWazlYl2ST6Vf3HslOayeTGAiavABTjuy1jgDys7P0RkjKj/nox0i+11N
         RrCOo0r7iSA3yYXlju9FO9GaNgT0RmPHRqTntLFyf8UfQX1BStlmI9k45oUhzCh7/9Be
         9bz1NO9qwQf0cgIUBVIEvi3x7AZRvUbsior4wJJ5d5EUayWMAwQ5xSiWa0nrONxex2ml
         sRBw==
X-Gm-Message-State: AOJu0Yy3TcWWZCHzTF4kDoe0CY6LsaVHs7VoT9equlpWNjT6N4uRIJyA
	tB3Bo96R8zzAg0WT/QeB5MnkEJdvRsM/qfLeA5IbXC2HlLOwErnOyLBJlvtfIQLz7rVkKaBNpp0
	P5sw=
X-Google-Smtp-Source: AGHT+IHJ3OLVqiy4DgE4NnaGFI8/GsV40iaossYganaEo5dpLYOvFNm4B3Ul/d0qZU4/SLWC+gQvYA==
X-Received: by 2002:a05:6402:13d1:b0:5c5:bebb:5408 with SMTP id 4fb4d7f45d1cf-5c5bebb5afdmr1535849a12.6.1727016618419;
        Sun, 22 Sep 2024 07:50:18 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-20-102-52.retail.telecomitalia.it. [79.20.102.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bc8907asm9724838a12.85.2024.09.22.07.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 07:50:17 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>
Subject: [iproute2, PATCH 1/2] bridge: mst: fix a musl build issue
Date: Sun, 22 Sep 2024 16:50:10 +0200
Message-ID: <20240922145011.2104040-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes a compilation error raised by the bump to version 6.11.0
in Buildroot using musl as the C library for the cross-compilation
toolchain.

After setting the CFLGAS

ifeq ($(BR2_TOOLCHAIN_USES_MUSL),y)
IPROUTE2_CFLAGS += -D__UAPI_DEF_IN6_ADDR=0 -D__UAPI_DEF_SOCKADDR_IN6=0 \
			-D__UAPI_DEF_IPV6_MREQ=0
endif

to fix the following errors:

In file included from ../../../host/mips64-buildroot-linux-musl/sysroot/usr/include/arpa/inet.h:9,
                 from ../include/libnetlink.h:14,
                 from mst.c:10:
../../../host/mips64-buildroot-linux-musl/sysroot/usr/include/netinet/in.h:23:8: error: redefinition of 'struct in6_addr'
   23 | struct in6_addr {
      |        ^~~~~~~~
In file included from ../include/uapi/linux/if_bridge.h:19,
                 from mst.c:7:
../include/uapi/linux/in6.h:33:8: note: originally defined here
   33 | struct in6_addr {
      |        ^~~~~~~~
../../../host/mips64-buildroot-linux-musl/sysroot/usr/include/netinet/in.h:34:8: error: redefinition of 'struct sockaddr_in6'
   34 | struct sockaddr_in6 {
      |        ^~~~~~~~~~~~
../include/uapi/linux/in6.h:50:8: note: originally defined here
   50 | struct sockaddr_in6 {
      |        ^~~~~~~~~~~~
../../../host/mips64-buildroot-linux-musl/sysroot/usr/include/netinet/in.h:42:8: error: redefinition of 'struct ipv6_mreq'
   42 | struct ipv6_mreq {
      |        ^~~~~~~~~
../include/uapi/linux/in6.h:60:8: note: originally defined here
   60 | struct ipv6_mreq {

I got this further errors

../include/uapi/linux/in6.h:72:25: error: field 'flr_dst' has incomplete type
   72 |         struct in6_addr flr_dst;
      |                         ^~~~~~~
../include/uapi/linux/if_bridge.h:711:41: error: field 'ip6' has incomplete type
  711 |                         struct in6_addr ip6;
      |                                         ^~~

fixed by including the netinet/in.h header.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---
 bridge/mst.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bridge/mst.c b/bridge/mst.c
index 873ca5369fd6..c8f7e6606c3c 100644
--- a/bridge/mst.c
+++ b/bridge/mst.c
@@ -4,6 +4,7 @@
  */
 
 #include <stdio.h>
+#include <netinet/in.h>
 #include <linux/if_bridge.h>
 #include <net/if.h>
 
-- 
2.43.0


