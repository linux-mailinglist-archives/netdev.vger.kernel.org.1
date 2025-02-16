Return-Path: <netdev+bounces-166728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A908EA37190
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 02:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 703AA16B79E
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 01:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C741373;
	Sun, 16 Feb 2025 01:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDnH6hY7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D033748F
	for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 01:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739668809; cv=none; b=faStUXbjb99ZqVN7yIWK2fx8rOzOkc0fF3D5JTecKeVWJ5vJlNdX61bgJLWGkp0nWylocHLwdnYdUPC/21z/QvI+JKOpf5ypgVS52R5ZRt5taWFcc4Yph8ZSFaJAlfRWFt8kY4YK04gM3DOSKsJfytrMNgBJ4jTjCi7SpB24sXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739668809; c=relaxed/simple;
	bh=4Pbfy4+yqCDX7T7kfRkuFt/gJ+39MYWLzJmzIk9vFA0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M6Lq9Cvxy5vbHXW6TxTX6ej5jcsobsR9pfsvEenGP9G80JKF34gtZBh+uSTBVkRqFYyXdN+AQGWPu6tqyqhxYxm2X21p5iM7s86dCILjaiE7aKgkwoYPxF5lQfPA8mXoN2RNlQ25VjHhWUtBCxWdMdHDTo5QDQD9vG++6CKKBlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDnH6hY7; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54605bfcc72so483826e87.0
        for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 17:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739668806; x=1740273606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F4cG9wttqtAzp4zopvxi5x287IcNrzRDBTI8aw3YRow=;
        b=cDnH6hY7ZVR8lzVR6Drgq7KGg5Zx9IiM78hLHy/a7qgefJCfketId3J+fLaF3Kh6+9
         2lTRWvxE2kvhS+Q+2BrwzvK8xDdpG+7g+yWYX4LCXcYtZTlPAtfLP4M/hL2XAKmIQf0H
         V+r2I/ZLmbYxmOvxxE7rZ+Yz/zTNXnb6RhKPskBWF8zs9/xN92cM6Xjvho6j4k0LhEVG
         28YX4xWzExYsfFhoui/LVahW2xTZtx0baDLdhQbA8oEADrxY/fBHkW9069WuZbKOs3L2
         U9puZIPOCD+uQgnziIIizFbAiV0JxKcLH88BvvuxbBm7e/oroGl1TWnj5Xji1nxTG+Wl
         +ElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739668806; x=1740273606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F4cG9wttqtAzp4zopvxi5x287IcNrzRDBTI8aw3YRow=;
        b=qXy6dFnvFdyex8u0jTK6B8X8EawaOAvdi1tCmu5Ch7QHkKnZzdF6ErLQRAyGInpmk4
         5lzv0lX66ENvVYljt88fuHKwLSGUTRxtfbHDFcHLNR0wdBM45WMK1nkCzWWNTbsGsfc5
         7ySKOgJ+0U02aY8G29NW4e5o2D36WKIbLUe+/2klUrEaZE6w247SU5VVb/aXl0k/T/DN
         Gy5LyzZNBR4wzyikAHJNOQmMiApmCe63tANZLK+G5of1A4RoeQBjJ8XbTzXe1wberaDS
         gssS+uHZynB7SSVepafHRwH+rn3xR3JpgoLkYKiNbvH4l90IaUdWDSMNPJjTlCfAByO2
         KfXQ==
X-Gm-Message-State: AOJu0YxLYexY2QcFc3+WaF1Gica3PqdjTmzVjFou+oHlNZh4j4xO34Sp
	lZUQlD41JUBExwslgjilqzEIiaPh+8yg1LqSKC0MCzQTlJjZa8057DUM0MvPf6FGnQ==
X-Gm-Gg: ASbGncuJC90+BA5KfjOkhQDaIXbnTPT9rr0DUrRNgHGKZ5/4jK8i5yI+FK7he348kPz
	ESfrK0LKU2AP9Ov6wCjORcl/ovkvp34B4KW0heJK8ftyzx3qNrfo0+JqDgEFm0qz7XgVNO73vRv
	6RVuRMy2US/72GHuSr/WYWn8MvihOnDVt+bwJvCfocCkHAZjTwTpil/BfVydhx/U1wmQQmKhedW
	ZBIKB2NkYsuXODbX5J7x978zdesKpA75G9/GskUmqlGUGKULlEh125WI1/XOoPqYAWCDoTRgxc6
	8+Zi1wASroUF7sBOS4I9D0bTYVPKK5V31df8heTK/Ztf1SUP5ZVo0DaMOLAg6DCZKWoqIRoGUA=
	=
X-Google-Smtp-Source: AGHT+IFdCdhIjAEI8txSMAC2HM/4tPwW8lyWBEJYBhJeXBpkRTF2isa/NfswsMIofQLd6aHlReOCbg==
X-Received: by 2002:ac2:4f03:0:b0:545:4f00:f92a with SMTP id 2adb3069b0e04-5454f00f9a5mr917780e87.20.1739668805380;
        Sat, 15 Feb 2025 17:20:05 -0800 (PST)
Received: from astra-student.rasu.local (109-252-121-101.nat.spd-mgts.ru. [109.252.121.101])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54618f8f22csm175253e87.93.2025.02.15.17.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 17:20:03 -0800 (PST)
From: Anton Moryakov <ant.v.moryakov@gmail.com>
To: netdev@vger.kernel.org
Cc: Anton Moryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH] ip: check return value of iproute_flush_cache() in irpoute.c
Date: Sun, 16 Feb 2025 04:19:58 +0300
Message-Id: <20250216011958.640831-1-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Static analyzer reported:
Return value of function 'iproute_flush_cache', called at iproute.c:1732, 
is not checked. The return value is obtained from function 'open64' and possibly contains an error code.

Corrections explained:
The function iproute_flush_cache() may return an error code, which was
previously ignored. This could lead to unexpected behavior if the cache
flush fails. Added error handling to ensure the function fails gracefully
when iproute_flush_cache() returns an error.

Triggers found by static analyzer Svace.

Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
---
 ip/iproute.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/ip/iproute.c b/ip/iproute.c
index e1fe26ce..64e7d77e 100644
--- a/ip/iproute.c
+++ b/ip/iproute.c
@@ -1729,7 +1729,10 @@ static int iproute_flush(int family, rtnl_filter_t filter_fn)
 
 	if (filter.cloned) {
 		if (family != AF_INET6) {
-			iproute_flush_cache();
+			ret = iproute_flush_cache();
+			if(ret < 0)
+				return ret;
+				
 			if (show_stats)
 				printf("*** IPv4 routing cache is flushed.\n");
 		}
-- 
2.30.2


