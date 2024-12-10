Return-Path: <netdev+bounces-150847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3DB9EBC0E
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 22:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 761ED282866
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 21:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEA72397A3;
	Tue, 10 Dec 2024 21:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="nW58CXIp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D3923979F
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 21:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733867060; cv=none; b=Al6EWvs3XYy5GAaep5LfbpdvB52DaFMWCt3DIc4sOm9pdpGUaj6PBheFV4dv11bHBdRdiAnrT5MB4KZz2Yy4TVUi3aNjWewtE9fJQ9MCu7zhF13Pe7SntuUFlNsRNcsAwUK/DtkoqHgFwN2G6ZhOSWkVfl/xOuXW7dnLczEbu+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733867060; c=relaxed/simple;
	bh=W5jD1BXbjpq55o/HknewRBr3KEb7ibIAQWOeSRB63mM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l8F73c/UAJlYNIae+m1L8SLZhPVr8f5u3GHfyO/OXg40jslNF/A/zFwDHTz6Eb8GX1urH3idGy6kg2h6KZAdTypAaeYXlslroymW14t/3/n5uPv7XfPuuQcwNBc6xkXrtGJHTLLLl3IG+iL9X9BHwd5fr3Em7m5ZpaFlINDfiKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=nW58CXIp; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-725ee6f56b4so2295217b3a.3
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 13:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1733867058; x=1734471858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VdNVS82GnqVvRx+tqCtnDFNgrwo4BS7XNjcHDeyKnz4=;
        b=nW58CXIphgDOIVy0XZyIVBTWjrl/YShmyUi2tqnGNocSqnwJnyVbphG+FzuZtNbu71
         dAIQothVL0or5pE2mizTnfO/NGafGTgZSF5JsJ0051vBMLApEkrFYCx6JtPo0cEPCXs5
         5GxiB3IZYs+vf91DAn+FRLrcR3QNa1XAat7z5ykNEC+EMTbWpsuVAVfmNr/swbn94RtY
         7cqYeyGfhQRwjc0qaFGtJc8rjnImoC0W4gbXhanyIb7CReHbJACo+LyYL307NuUYKw0B
         Jb1bIJL83elKbEiy4WZR+23qVmsq3eKeuaqsWHK3dSHq0ECn3B9dETUoVKtUKXd2W/eX
         Krgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733867058; x=1734471858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VdNVS82GnqVvRx+tqCtnDFNgrwo4BS7XNjcHDeyKnz4=;
        b=w9qX+HVPrk7aUfWAxaaGgeyBGHx+sCM83zmj/eYhVoYYc2XFgeuLUoXjKCMEqO0xuk
         zeBAeviOd9b3zL+YnqpZb1gCLGUhDDrFwLPCX3vQuDeSCNVJtIB3UxXy6jRJCpGFMbtz
         VHGWZeB0ZdL60rYraVPL/q0t2kG3AFMDsK379sWPQuLLnnZEF/MLvnWcrfuLGJ+nS9G1
         l3ULpQ1sfM8W1zUbxPyy35gjimqFBWM8LMHjz5z3JNR4mFxX9/zcy7Waopk0vixZshE7
         sU/QAwObQJ7vFoMc2XS3LPzYVZR5Oh8vpDOT06Jw3pvn3jSBZlHZu6eZTJORzxSlb1Aq
         PCIQ==
X-Gm-Message-State: AOJu0YxHGxFmB6FTdZyy2kM7Hwgd7LBIrNIxuYuQvG421p5C//mbaj1a
	12DSqpp/xjWdANw90iOFbKiCEWD1C4PPp6CNP2odZtkOOEFNcPDEYJO7gCx084Llpn19WnCbutO
	Z
X-Gm-Gg: ASbGncuuY3V1YK9jtbHZFLhJAY8vgz5JxX2zj6N0EgXzXWOnoNq4z38RS68NG1DavSj
	JjMoIQDKFz4kxU0ooViNeEBT/Om37tdMgvjVRyBhtKMRVl0ysbvR4wwBs22la3O84smERssgHOJ
	9c+SQV+Ce7+yHOGBGoUPfgVVmLxXxJNMVVff/VXbdwgZJTODt9ASOsmxwi0KVYY5WE90wr/fFE+
	whcYgJH0AWryGy9EPkamsmNMjzTKA7G4hr4m7uckj+OlGGVnHKypeMQIR4I1ziCeAQ7ysMmbE1L
	vraDbrF5cPIy0RQw9KR7EMiVkPguNII=
X-Google-Smtp-Source: AGHT+IE+hIIhFsZNeFfBs8XJtRcLLt74s7pNefX3zsAe+YwcTyC0uLCIFp0u0cBDCZbJZ+26mL/RqQ==
X-Received: by 2002:a05:6a00:179b:b0:725:dab9:f734 with SMTP id d2e1a72fcca58-728ed3c1845mr845252b3a.6.1733867058124;
        Tue, 10 Dec 2024 13:44:18 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725ec054318sm4560479b3a.27.2024.12.10.13.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 13:44:17 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC iproute2] ip: rearrange and prune header files
Date: Tue, 10 Dec 2024 13:43:32 -0800
Message-ID: <20241210214408.85761-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The recent report of issues with missing limits.h impacting musl
suggested looking at what files are and are not included in ip code.

The standard practice is to put standard headers first, then system,
then local headers. Used iwyu to get suggestions about missing
and extraneous headers.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
Marked as RFC since still needs checking with musl.

 ip/iplink.c  | 13 +++++--------
 ip/ipnetns.c | 19 +++++++++----------
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/ip/iplink.c b/ip/iplink.c
index aa2332fc..59e8caf4 100644
--- a/ip/iplink.c
+++ b/ip/iplink.c
@@ -11,17 +11,14 @@
 #include <fcntl.h>
 #include <dlfcn.h>
 #include <errno.h>
+#include <string.h>
+#include <strings.h>
+#include <limits.h>
+
 #include <sys/socket.h>
+#include <arpa/inet.h>
 #include <linux/if.h>
-#include <linux/if_packet.h>
 #include <linux/if_ether.h>
-#include <linux/sockios.h>
-#include <netinet/in.h>
-#include <arpa/inet.h>
-#include <string.h>
-#include <sys/ioctl.h>
-#include <stdbool.h>
-#include <linux/mpls.h>
 
 #include "rt_names.h"
 #include "utils.h"
diff --git a/ip/ipnetns.c b/ip/ipnetns.c
index 5c943400..a20cd8bc 100644
--- a/ip/ipnetns.c
+++ b/ip/ipnetns.c
@@ -1,21 +1,21 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #define _ATFILE_SOURCE
-#include <sys/file.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/wait.h>
-#include <sys/inotify.h>
-#include <sys/mount.h>
-#include <sys/syscall.h>
+
 #include <stdio.h>
+#include <stdint.h>
 #include <string.h>
-#include <sched.h>
 #include <fcntl.h>
 #include <dirent.h>
 #include <errno.h>
 #include <unistd.h>
 #include <ctype.h>
-#include <linux/limits.h>
+#include <limits.h>
+
+#include <sys/file.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/inotify.h>
+#include <sys/mount.h>
 
 #include <linux/net_namespace.h>
 
@@ -23,7 +23,6 @@
 #include "list.h"
 #include "ip_common.h"
 #include "namespace.h"
-#include "json_print.h"
 
 static int usage(void)
 {
-- 
2.45.2


