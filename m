Return-Path: <netdev+bounces-151542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8AD9EFF45
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 23:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A901518869BA
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 22:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB421DE8A6;
	Thu, 12 Dec 2024 22:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="2x71bl12"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3E51DE4C3
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 22:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734042363; cv=none; b=hmaAdMxiQJqUbwGHWV1e6Pg7OH5odVe6r4VqINlkObqx+0uvjuO/ZFTATLsDkqcj2dEufoYxBFCio103JcL9R6b4WW31NMWvooobaywifhBMf56hTcqnKNh9NE4ri+tHvprO91Il0H1HhwqacMVP8/N2gxOEwbwtK2A7jHFrBBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734042363; c=relaxed/simple;
	bh=c+GxrhNs6QXkT8kD7hxSNn6pEXNu+n40ZnEp5+bktDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OJ0kvsmt0KVoroenB1IY+EgeHJ/mQPXFF9alGApIEg7R7XhpebRa/5afWMiLqS4Rtmm/XsvzSwrJzNCdApgZ4nFTSLLOekejjZKjS4ldoKRky1Gpuz9tGvOZzqyjrwOZSxl05mMcR0cpGMj1EvaL1HN1Z19l9AqL6/PoYhkTfs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=2x71bl12; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7fd45005a09so797455a12.2
        for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 14:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1734042361; x=1734647161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbXQ/awNwKDLahfsmSBZ0PT1qcU7+OPYWqXZOdU5w3c=;
        b=2x71bl12MHtK7R26V4hQSZqvp8ZTWnXA2YRcatL2RHrYWd0oBTg4TxZIUQfdmfr/Tx
         KumeEte0ZQa4vzPNjDS1OSPBEdNWjMuizJ6C6Kk2aXge9z2iiJjL/kB5AYmWfvl/7ICR
         vkLgZO0ZpnMlxWEvlTbpjNaqzcY8oOg5SA92YkibZFULFuIBESjz2WG161GhErbTUW9i
         WsOdGDR6OjnYV99QDbjh8LRHuVgWM34QCieO23TWAW4NLrMMK7d8tnjytZtqpuDqMWEo
         6kBumhes8Z2a1dZ/vNG5326GRHGcRz81zYtOZylyIOe6EQZzWr29MmHP3Vd2FDq3GRzv
         oMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734042361; x=1734647161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbXQ/awNwKDLahfsmSBZ0PT1qcU7+OPYWqXZOdU5w3c=;
        b=Ry2uQSBunFjJYnvOqHUkUzWjTuijb5cgzwUy1S0o1E1ijlcEQMEMdIpOk8S5jo8oXk
         CNzK7bNZ9RV4DCA73SNiGBoj6TxQrhj8lHz4Y7Vz98I1tRCn4tnvnL3hYsHmwLHWqoZy
         bewiQk7ptMGe6WI0fg9y3pHw/UFeyK69rWXT8x9dRiAR/qsvYdb+ZkWCWHw/Mgnzrb2I
         XkIestp3w3NGaQMRI4+0JGtY1Eefofxkt12yZEzAaZJjLPDCH+v1g9UNXQ7YUFmglWuE
         Xj6MMTHQyho7UBO1tl2JqFrYEL842XAbk7KryWg3rCL5zv/aHOd65p7UfEnh6ikPKmQq
         yt4A==
X-Gm-Message-State: AOJu0YxM39e48Um2lIERw/lh+jY0puyhWw0vK0LjDRrTupdXTLweP5mj
	5kxQyN8J0R9k99cNZ0c8jf5vCxW043x/fGliq5UID3rnjgWYQ3gVeHc5HU2kPSKxMmpiDUZlf9Y
	H
X-Gm-Gg: ASbGncvvlOJA+4/KB6eY+WasxvdTDzuAQQZNM6AH25Q9bk2gWJWinQf2U1vGXot/MTS
	I9B5Xt9p1LbVe7ylyHb/Qk+K0/bRnNs9UOcGyqY6oxdrDq58Fe0kwke4RcEHO3qxjdM57NW98y5
	s7bCqOUaqnC5K5G5nA0URubpY6jXafUPvKBo3trheQOUDzrfCSq7PnMU3pzEAq8cBEv4xmen99t
	ps2DrcaPR2tx2m6kuPNpwiUj7B9m+Mf5PQ4VyrWucvPKTVmOUSza3/11nn/xD1WXsEQfx7sTNOi
	uKbwjXFUJKBhE+rHhM0JSXSXaIAL4bMfQA==
X-Google-Smtp-Source: AGHT+IFsse8DI3uMZ0Lh109wG9OXgRH75KNhGEMA33cbyNQUuHdereK5y16I3jCDEgg9ABWsNTKjRw==
X-Received: by 2002:a17:90b:3b8a:b0:2f2:3efd:96da with SMTP id 98e67ed59e1d1-2f28ffa54a4mr659498a91.24.1734042361570;
        Thu, 12 Dec 2024 14:26:01 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142daeb5asm1830071a91.12.2024.12.12.14.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 14:26:01 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 3/6] ip: rearrange and prune header files
Date: Thu, 12 Dec 2024 14:24:28 -0800
Message-ID: <20241212222549.43749-4-stephen@networkplumber.org>
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

The recent report of issues with missing limits.h impacting musl
suggested looking at what files are and are not included in ip code.

The standard practice is to put standard headers first, then system,
then local headers. Used iwyu to get suggestions about missing
and extraneous headers.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
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


