Return-Path: <netdev+bounces-166727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF14EA3718E
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 02:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E1C016574A
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 01:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391F336D;
	Sun, 16 Feb 2025 01:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqdwrE84"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E93163D
	for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 01:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739668416; cv=none; b=UvHGoPKFK7h+XehISFQJgLTVYFxm/CxzftrEfyRWzov6ZEWuNFNf38qJFmVAu4Mg3+drr0ZehjSxdv2TIlCtwdTU4Pc4Tap7sB74ITFt2ngfVZ4VFp6zfy1gG+1eYXeoS3TqQiCB2iwvNN3+aIoGXHLoShnhjKKdN3bA3nza4Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739668416; c=relaxed/simple;
	bh=4Pbfy4+yqCDX7T7kfRkuFt/gJ+39MYWLzJmzIk9vFA0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mIMub6gMAmTfne2WQoQyGpYoQ6p/7XOtF/BXf2YtLl7gyNrFWHHEqTvMLWmhRImc/wOljueSCa9sGy/QNU5XlFPPMElo/KrLxUg4M3OZB5KvuAoy+sZRnzb3YPB+W7GbiZ9G1eUg6z2ibZVnJNsXxQuicvnYxUJPOfgG73oZ+mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqdwrE84; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30918c29da2so24221241fa.0
        for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 17:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739668412; x=1740273212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F4cG9wttqtAzp4zopvxi5x287IcNrzRDBTI8aw3YRow=;
        b=iqdwrE84kWTWAQRWK8CXBUgVMxuA7C+7SjAyYXIogreTyfvAX7PXAteEEUj04f/E7D
         yaS6QjyCkhb+8COQfhXZIB4UlaIexhWZeFncrpOJ8GtsTWHWRzsZg0iem8jcN91xhnA8
         9xzu2Men5MMRgaKaFAKqYclNsOThnxtMkAJbgYnrGhtrehgDCvkNQM3YZMVHBJBWUK5O
         ESRbJD1Y7glPNfNb9LzEcNFfziN2bfoQZstG9vaT18YcoeTg+AHLCVPhg1uBCYEd8JgC
         X5slJRoxMA3Elj5QyICrK0inuV+f2ol9HseID1gYOw01yFJdRaZiD/PsbcHMhi0ne85/
         Oscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739668412; x=1740273212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F4cG9wttqtAzp4zopvxi5x287IcNrzRDBTI8aw3YRow=;
        b=Q9fCjP8xkunql3Vs0lW5ium6kE/lIQziHzCz1Ubx/C+yR1A6GF4GV0qDiO46TeWJSA
         2zxRd3BWq+ZDEOO31NCDWQSrdAXuJtnwZhQ8Cm76zF2y6LmzUSq5tR9IJlgJI69wB4dO
         g5X0vd9gpHhz9SZ7IqLsGD2PKNIP/I7qfWzIK2dmTB3vCQifeJYh4G6tynQqYt7UMSt6
         OA7iZKIh9ZHUPySV1LmJfbXtf42CR/01z4ufEWdxY7+LcLSatTI3fsCPZPYa1bWFDr4Q
         9cX4++yTJluiuMY8uYiD1xvhgu7GZ6cLi/a5k1I8YFPvB/vVhgqj5GBwHMvFKGGUQpIH
         b3cw==
X-Gm-Message-State: AOJu0YysNKvg5rTqy6GzE0w5dHkr7nFLYgXKf9jTjO70oeOJltNv/3uE
	zHDPWBnh03rZv8J7KSA/MkcyRDLMiD8EPgLgEJyF1Cf5AwmvOPfDY4yjjSVBq59cuA==
X-Gm-Gg: ASbGnctOplM0BZ8guz8FaQBkGcVJ3j7FJr/za9iStltJjfrwEjQ2k1brqZY+9IzsDda
	xtheeJyF04B/j5CP0v0WOgblAiKQrxEkN2vxeLpnm2EeSHAMuQp/8IB47WhvHLoiBzoRvt2UTJ1
	mvpRd4Z+N0hAO5Zpm78rxQ1oc4fdwvrA6lMHCsgDeVhO75ee8/4atJHKdowoNUq45Ph9Xs998oj
	/SZXC/KA0PyhcVy6m441lQ4YKesxXdCttozYCLafvTtzkqnpdgqMR4CFJKv7jRbdls7mCAX9EXS
	Ng+cQw8TbGDhXSthLOXb9wQEAKpOSCgL4YWhlPwZ+zktAmyhQHNTFVxMVKaNwrFl0ujRqDG2
X-Google-Smtp-Source: AGHT+IFWstoWJvsv8a6uP1DnUm52uJl0x3HqRjcmVyzF7slUXYY8QYsPMOdrQm1JLqYbas8qwU30nQ==
X-Received: by 2002:a2e:b608:0:b0:309:1ec5:fcbe with SMTP id 38308e7fff4ca-30927a704b4mr14694961fa.22.1739668411834;
        Sat, 15 Feb 2025 17:13:31 -0800 (PST)
Received: from astra-student.rasu.local (109-252-121-101.nat.spd-mgts.ru. [109.252.121.101])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30910276f2csm10538631fa.67.2025.02.15.17.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 17:13:30 -0800 (PST)
From: Anton Moryakov <ant.v.moryakov@gmail.com>
To: netdev@vger.kernel.org
Cc: maintainers@iproute2.org,
	Anton Moryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH] ip: check return value of iproute_flush_cache() in irpoute.c
Date: Sun, 16 Feb 2025 04:13:22 +0300
Message-Id: <20250216011322.639692-1-ant.v.moryakov@gmail.com>
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


