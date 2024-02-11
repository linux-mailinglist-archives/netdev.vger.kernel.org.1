Return-Path: <netdev+bounces-70828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 628E7850ABF
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 18:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08D831F21C09
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 17:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20C15CDF6;
	Sun, 11 Feb 2024 17:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6fzInwA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139325C614
	for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 17:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707674244; cv=none; b=Xz2L9/6UgTFwRYhF2tXlFqKwdKA9k+uUcjs6y1LxDgWmZTlYaM1Q3bEkoxqQjEe9QB8hF4Us2k2XOYF8nxwtlz4Lc1cOGkzUhe82FU+quzARMZdzw1z4tq+4HrqBWt3uBpvVO4U3eYVpc0uwZZdtzkB+Fid0iLDuPg9r7e9T+Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707674244; c=relaxed/simple;
	bh=v0zMSken/f+N2vjbgW8b2W3qSsl0EtCDoJsq7zNDFwY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vlu/RdnxQ6TvVZ8MSMW3lW5c0o8jFyoJerpy+Ja9dzJzv7mGR8Dv7aYDh78OhibI8C2s+R1oHhRZ0aJpabh+T7btw2AENZI7SlD3AzhKyue5GtImCz2YkMAjKnHsTRa+NV3KkUyTyUwZinM9OSU2Sl+KIF+JdzFIwdSdLUNemqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6fzInwA; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33b0e5d1e89so1719759f8f.0
        for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 09:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707674241; x=1708279041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3E7paJgdLIfwJpW6m66EY3h3nWsYIUHvQlOvH0XUHvY=;
        b=I6fzInwAa2QCGh04WaD3cwkf3FTUBNKIC7F0E44mlTW5DPLv0Fk8ndzhgx3YuihUlo
         L9HBGfA0sFRpwX9qXg5bWGrbI8wKB78T5aKrMvJJ6oB7n23koSyiC8VZRCBxieH8ExF6
         3hv4JbTyegQHARRLF68S1qICFMcLR7wyN9rZzYUdFMNtKFPX2KoNe2LzchCw+jcgALaU
         Fo/x9Ymjbs0fc0bHnkOa+CTwBj9bc9sfdJFBiSAaV0AvujjGJcykhsbkLjPXqvvygY25
         rTD8Ix6/3vyoGiprFkDg+mvh2yzY1JvOzDUh5QKwa9b/rfxx17M9UyBzcw1LN/4PeX3k
         +7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707674241; x=1708279041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3E7paJgdLIfwJpW6m66EY3h3nWsYIUHvQlOvH0XUHvY=;
        b=M9aLl4/C+cq1iwNaL/aYkbqqRp44WunGsrzhZ1Q/e7KhHwXxOYjyRa0Ms1uAxLNWOg
         CEE23woiDyvWpVct1LkxZ5g9X+/700SgfoIhIVedhdrKZTDQy9yQRpwZh52P0STrsCKC
         KxzCGWwATKx5McTh+9z0tQU2D+ml8BBqOn2bWmWjJa3ObNcztPzHtRF9ALbAcKAB1jaC
         B38tvd0z288PHLjzUNFcXxPQrnDtIqUuGa8bgvVLlnVrN+fBGcBuN9wGWn2zkn8WfDLz
         iea6jt2KLIeojUZGKzhq/ekgq8m6RgpQIztFv75FbNv92RWzR3pbB8BC5GJCugLyHfQ1
         ihsw==
X-Gm-Message-State: AOJu0YyjofopmmXbfEJ2m+zsA9prAKmACGGCR1c0Qr440sq8GpWmh0yF
	rRakbE3hvyMtH7gOmzDbnIO+7aoSnnLCWljjrA1o8fK3NDp3kxs5JvZ+tkXaTcI=
X-Google-Smtp-Source: AGHT+IFWmV11gk7pq+ded1KC6B6tnU2u0JDixVSrv51Vp428DzJAUqs6aQxWmN5c/CaZ79n6N4l2Ew==
X-Received: by 2002:adf:f387:0:b0:33b:69bb:25c6 with SMTP id m7-20020adff387000000b0033b69bb25c6mr3514071wro.16.1707674240855;
        Sun, 11 Feb 2024 09:57:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVZShRg3GSWSypbLo4I41X8IVoLhzcjXXG4sV2UqX8qWWMn4eJfsh6ljNgfzPr9mWCntmDVOT2SErsQ0lW9CoHtLVZE
Received: from lenovo-lap.localdomain (109-186-147-198.bb.netvision.net.il. [109.186.147.198])
        by smtp.googlemail.com with ESMTPSA id jj19-20020a05600c6a1300b0040fccf7e8easm6321342wmb.36.2024.02.11.09.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 09:57:20 -0800 (PST)
From: Yedaya Katsman <yedaya.ka@gmail.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Yedaya Katsman <yedaya.ka@gmail.com>
Subject: [PATCH] ip: Add examples to usage help
Date: Sun, 11 Feb 2024 19:57:04 +0200
Message-Id: <20240211175704.5963-1-yedaya.ka@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the usage only shows the syntax with all possible options,
which makes writing the most frequently used commands cumbersome, since it
requires parsing the syntax in your head. This praticularly affects
users new to the command, that resort to reading man pages or search
engines in order to find the correct invocations.

Copy over the examples from the man page, with the same indentation
for the command exaplanations that exist there. I removed the second
link example to save space.

The whole section is indented the same way the other sections in the usage
are, to keep the uniformity.

Signed-off-by: Yedaya Katsman <yedaya.ka@gmail.com>
---
 ip/ip.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/ip/ip.c b/ip/ip.c
index e51fa206d282..78c3f130c593 100644
--- a/ip/ip.c
+++ b/ip/ip.c
@@ -73,7 +73,16 @@ static void usage(void)
 		"                    -l[oops] { maximum-addr-flush-attempts } | -echo | -br[ief] |\n"
 		"                    -o[neline] | -t[imestamp] | -ts[hort] | -b[atch] [filename] |\n"
 		"                    -rc[vbuf] [size] | -n[etns] name | -N[umeric] | -a[ll] |\n"
-		"                    -c[olor]}\n");
+		"                    -c[olor]}\n"
+		"Examples: ip addr\n"
+		"              Shows addresses assigned to all network interfaces.\n"
+		"          ip neigh\n"
+		"              Shows the current neighbour table in kernel.\n"
+		"          ip link set x up\n"
+		"              Bring up interface x.\n"
+		"          ip route\n"
+		"              Show table routes.\n"
+		);
 	exit(-1);
 }
 
-- 
2.34.1


