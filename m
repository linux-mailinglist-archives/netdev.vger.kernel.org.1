Return-Path: <netdev+bounces-151543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDCB9EFF46
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 23:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80658165EEB
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 22:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377C21DED4A;
	Thu, 12 Dec 2024 22:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="ClfA67fZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351831DDC29
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 22:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734042365; cv=none; b=O1d+gD/roQh6dZDVodD+MeTXLJQcFT7EUXLR9gz5GoeFgYsQC9pZhjc+uyGXC112YXKQukJDqNL9lXrqvkGfT3c5ZVZyM47Y7bcQJv1X1L5rKr4GF54A3vbKXnDPO4+3fMOLfanxQUjZsK7U+PD4j2wIhcJnDqVpZWoAH9XXl4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734042365; c=relaxed/simple;
	bh=fk6IEo900LeVv/Adue9U9wZUGXGqs/H0KzmL3AgwpYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TeYW8AvkaMhbI0qPhYpQmqdpBnPw298SeXTZq8DINO1OQvwSsbvWsnDJUqmBA3WxLBFRY9rXUTk38cMubEUYsFUftwNoMl8SqqUM5r/lyWUwq8kq1PrIXyqg5BBUqqQup2ufAY+g+EEdZLRitkJvnqHjyQvse3IHaJDkPMWggSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=ClfA67fZ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ef714374c0so894476a91.0
        for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 14:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1734042362; x=1734647162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcDiSS11p94XXd1a1rKQpzM9wXRI4KlzXZt84qlYt9Y=;
        b=ClfA67fZimH35A+HQ+WuuiqLeC2Gf8dvm0JUUTaeVyaGXv/iHaWQgHFdria5sB0lDT
         C7gg26GpSSVX1LiAsXouuJ/8kI81arQfj9I9Ch41PCOU8QVUMhKpeVrJdHMMeXue9TPP
         CdkfJhNqGEOWbBRdvHW4wbX19Ne/Bp3Gz29WA9NAoqpuHsWVF9NOPJADahy7Ha3ah6oW
         bBmrGkCJxn/mgtGNUCjFGJBQHuA3mEOQE+0xQBocBqk/coZbxmMdEMcCsuWSRXrBRphj
         5jkqfFIyp1H4s4Etef+NEcvBZI0ZmG4INtfTwmJmQs2gInF0r8yiTxeBN5Q5p7RdTA7R
         WKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734042362; x=1734647162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mcDiSS11p94XXd1a1rKQpzM9wXRI4KlzXZt84qlYt9Y=;
        b=vfpnIvPzY+/NRGzKSZobuELisYtHc9uNrTMDZv1fWIqfc3lI9UauemqzvahpsrmAfL
         Km5RdyIni4rzbKpFaoch0uorT4687bZoOi/VIDWFWL2eJBXthZlsz+UODuFIj8Ug4pSq
         SzDJOKvLiT13grXtfwScVT59WNAq1EoiAzT7Rv4UfUaaWX1DDjm11YeOT07FpcaJGriT
         fUGE14LEjcQULxk8jSPT0mYTiIX/tNciEQLiYIn+SDZgRcp6IVA72HqT0HLIKZdTpesd
         RpxomfvMUlHlxeKCMKyCiUbxCfDwR0Vy1O/cRrvcGhd9goToqf4pv4wZbjHmSUdPcNnH
         axhA==
X-Gm-Message-State: AOJu0YxphD4qgnzIp3KuSO6gwS3upmvRWCIrlf2/CKJbeISr0qUS6rMt
	Rms+tLSClWrAlP4JdvsDKkNzlnVLAQkMQpgIYAZBAMq2R4SGQlw5PgjwW9n7hnJJt31LARV081g
	q
X-Gm-Gg: ASbGnctn+5FHU93kzPGpxW+J3B1RMrw+RsfvXyGeoh935ARUdnxQbXKy7OrYhGOe/Yl
	ftyBsgDdJ9NVnKgZcuCite5V5gABUU/0qpVto7zypuTXeqvvW6Hy/qtuGi45HWOKV9TYinuq903
	sFB/mQQsxxUsSVsixugayilZGg9fXkPpOB487N0mkIboadaNo4KDXFIR5oQC2V+tf3x3IygTM9U
	xxUW0mM80XCycY9XU3Ljld2edx6MFplhL/W69ZYLdrL+N2yM/lO2F4F4L11qp6GPFmRIxYfkNgm
	28u0/lqIi2QVf5SIqmj4Mtpw7Epy4aTWJg==
X-Google-Smtp-Source: AGHT+IHfUZvsijhsaVZ/ZczlRw16p8anashTkAwh2GnKR0fzO1bEsga5mtUGRT4m2QfEeOUCAFuqZw==
X-Received: by 2002:a17:90b:17c3:b0:2ee:9661:eafb with SMTP id 98e67ed59e1d1-2f2919ba2dfmr236307a91.12.1734042362407;
        Thu, 12 Dec 2024 14:26:02 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142daeb5asm1830071a91.12.2024.12.12.14.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 14:26:01 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 4/6] cg_map: use limits.h
Date: Thu, 12 Dec 2024 14:24:29 -0800
Message-ID: <20241212222549.43749-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212222549.43749-1-stephen@networkplumber.org>
References: <20241212222549.43749-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prefer limits.h from system headers over linux/limits.h
Fixes build with musl.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/cg_map.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/cg_map.c b/lib/cg_map.c
index e5d14d51..0feb854f 100644
--- a/lib/cg_map.c
+++ b/lib/cg_map.c
@@ -9,8 +9,9 @@
 #include <string.h>
 #include <stdio.h>
 #include <stdbool.h>
+#include <limits.h>
+
 #include <linux/types.h>
-#include <linux/limits.h>
 #include <ftw.h>
 
 #include "cg_map.h"
-- 
2.45.2


