Return-Path: <netdev+bounces-70474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E5D84F256
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 10:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AAAB1C20FE0
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 09:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313216773D;
	Fri,  9 Feb 2024 09:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFHxFIFA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BA2664AC
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 09:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707471456; cv=none; b=L6YI6dfVYFW1INb40UJCUKd6mCVbRg7ZkYF+WWnJRdOsFDkKUVrAXQRaArcAAPjsXO2BCx3E3CJv+9emp7n4f2IzCMPae9G6/34gZzUyRDw65wE5k6upcgfZ3GUpwPfjnaomU6Z4hIxZ2cLGj0vDQuxdREIgE7rMF4qBAqaTAw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707471456; c=relaxed/simple;
	bh=IBfwb5xJFywY7Qg/BA7Zs8R0H/jAYwUE/V+/jZ60DHM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l7yIfOhD4U14MaWSgHOn8DKCstVSzHyQiO3yle9wYtMlo2i1j8MFJGiBbRP66LWYPKXVM7kq0k93mQcFSGUkGj16Tn3hzbd7V2sD9Pw/yT1LlwKcAzxcpOqqv4+MrTcmN3XdXRxTwsQuX8OZFUZ2f9bLIHFgR/bCoOWaa6evWeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFHxFIFA; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-511625a9d84so237463e87.1
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 01:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707471452; x=1708076252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qQHED3yEDzAPWIE5f1wk40fziHzGqB47Kk7cOI44Hjs=;
        b=VFHxFIFAAPragUV5lwpSk4swPtXvgeNE46ARnw4QaHFgTa/d7eCrJqFtaY7OOj1pDH
         0jEezfrgZzGeyKl/EdWyBIZLL4E7frnoLqYoy8I4mkP9C6quBM/Q6+cdxMFlxWnVE/yk
         rRpRT6iKz9dLbyKl8/x0d8Wd/+gulA+vhn0jNkfN1czOevLLt36NlaHtvaZCgalf7P1c
         viLXqJMAq1FI3MpOJ74WMt8YDHUx+leRnWZawFVLU5FefUXbTy25OTZeT9F1lCsqMOuw
         ONWYk4zXbpQ8FUCck52qAOHtdyCi/C6XG8GzVBz0toMc2qegdepPFtqCeblow1Z9hPwk
         uCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707471452; x=1708076252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qQHED3yEDzAPWIE5f1wk40fziHzGqB47Kk7cOI44Hjs=;
        b=BpE2zcb3R2IwwbujkV3Quwtctt9F0WGIeI9TYphLD4Vuv9qa3rSzi+E8/gqNZNWuHU
         bCwu5/kfNiFlgsw4Zn5dPRg5QdoTH+rIJX3bcZ/maJE+V4BxjigeTi2JhfECqMX7N5do
         M1vUdrkx/GdS10or1S9oe4lNut/8NKqToir2T/u/JKYZwprylxlUEQWAFQG9Wfx7t2kU
         wzDEFzAfSypmoYyybqsSrBPtyYg15bz0MktJ8Msqv1X8uSts34A8jp9/8DPCewVZt88L
         U3DtimgUSs7jr6+WFZC5gWOwSlc5WzUN7jnWJWi+Z+Iq6VZg2GEnZwS/DV+VorBdrMTw
         QoPw==
X-Gm-Message-State: AOJu0Yyk5MbILwjlXqqWYlfRnbRabhoJBQxNYvnR8KCm6eMla0UMUsZV
	HcI8BW8Ri/Zugo6TGR0jgaeDuFK/y3B+SlTrCil2eg8awH0gdHBSwwSR2oPHaHt4Mg==
X-Google-Smtp-Source: AGHT+IFbaPzAbdEv+f0IpIGz0tpM0ag+iXjiK9GcdpHl+se5MNkKbs8j6I1IgUjY5V8Q2R5wYPloyA==
X-Received: by 2002:ac2:4146:0:b0:511:5b50:4cca with SMTP id c6-20020ac24146000000b005115b504ccamr530478lfi.5.1707471452176;
        Fri, 09 Feb 2024 01:37:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWhgbhbbNySP/4S3JQvGRfH1ijueIoo4Pqu02+Rg/ObHoXvejNQYsgS5Bc+qq5S+dD11V0wir8pyan+ucS0s+j93yJvQmXHC/ATQUsg7MwXJTpfId0a
Received: from localhost.localdomain ([83.217.200.104])
        by smtp.gmail.com with ESMTPSA id 8-20020ac24828000000b005117ac9cd1asm49659lft.88.2024.02.09.01.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 01:37:31 -0800 (PST)
From: Denis Kirjanov <kirjanov@gmail.com>
X-Google-Original-From: Denis Kirjanov <dkirjanov@suse.de>
To: stephen@networkplumber.org,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	Denis Kirjanov <dkirjanov@suse.de>
Subject: [PATCH iproute2 1/2] lib: utils: introduce scnprintf
Date: Fri,  9 Feb 2024 04:36:18 -0500
Message-Id: <20240209093619.2553-1-dkirjanov@suse.de>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function is similar to the standard snprintf but
returns the number of characters actually written to @buf
argument excluding the trailing '\0'

Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
---
 include/utils.h |  1 +
 lib/utils.c     | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/utils.h b/include/utils.h
index 9ba129b8..5b65edc5 100644
--- a/include/utils.h
+++ b/include/utils.h
@@ -393,4 +393,5 @@ int proto_a2n(unsigned short *id, const char *buf,
 const char *proto_n2a(unsigned short id, char *buf, int len,
 		      const struct proto *proto_tb, size_t tb_len);
 
+int scnprintf(char * buf, size_t size, const char * fmt, ...);
 #endif /* __UTILS_H__ */
diff --git a/lib/utils.c b/lib/utils.c
index 6c1c1a8d..752da66f 100644
--- a/lib/utils.c
+++ b/lib/utils.c
@@ -7,6 +7,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <stdarg.h>
 #include <math.h>
 #include <unistd.h>
 #include <fcntl.h>
@@ -2003,3 +2004,16 @@ int proto_a2n(unsigned short *id, const char *buf,
 
 	return 0;
 }
+
+int scnprintf(char * buf, size_t size, const char * fmt, ...)
+{
+       ssize_t ssize = size;
+       va_list args;
+       int i;
+
+       va_start(args, fmt);
+       i = vsnprintf(buf, size, fmt, args);
+       va_end(args);
+
+       return (i >= ssize) ? (ssize - 1) : i;
+}
-- 
2.30.2


