Return-Path: <netdev+bounces-66053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A1283D1AC
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 01:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C61111F251C4
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 00:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E8F385;
	Fri, 26 Jan 2024 00:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="0FmmRHXW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E0110EB
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 00:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706230205; cv=none; b=N04tGpbrWc7J9iKIFc9O2zLhEcHAlSf3UCSp5nhBxmETBVJigS3u+pA76USV80/ReMU8AxA9CDMxaUEH6liXGY/aXghqnWMpvV8KLnmVEV8KFx0LNg2HbXaFGwF0pKENVrcyQaT5LId8MyTjcBSi8tBiWq0R/16tXhf8XSTyX74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706230205; c=relaxed/simple;
	bh=DVVU13k2iErA69MxpMuBVwPz6jONwStqE8LR/+hlArI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lyz4LeBCJXAWhN6wPnuyC3VNhYLr5POIB/yy23jLn8ycegHz2Wgp+JpQ67/HMsJxOr2nXkC4p+ovM/bbeFDAeqNkOdIovkbtQ9KnxIJWmYUw6ZR58HPdDL/yLfhpspftGrTaGoCQ470aObBkt9xPAR+qkW8roQBoTQ9ITj83huk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=0FmmRHXW; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ddc268ce2bso189935b3a.0
        for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 16:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1706230202; x=1706835002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mrcIpoW9lBMlPuPTvDACdXXrnxwsa8BIfM7L4m5LDmA=;
        b=0FmmRHXW7n34VHU8atS9DB+x50m9DkMMrmEdBTxSiljnL0wC257srLZzVUeyAvbXGI
         iC4s73LoEwv58tj9rlhaA0pnt553b4/Ii7Z4KDiAHwrUMw6e5WY5Ukg5XzKfS4RCxFCb
         OWDVpezY+JZviTbgWsv+dzzw7XxfqW0thCw2mR3vQH967L/B6AnjYCDWUfR/crfrJThU
         oSIrRAW4ZOOYZD4vBoppXoDe4NdttJVj8iibbOGo531JqqZTeD1SdbBVmVp+wyJhjR0B
         6meTVj95Ullk1R+4nKZqXs8B2ZBdkG/Ql4NR6Z4P3NAzBrztpq8hX5YYctZQYoZJO2/U
         /afQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706230202; x=1706835002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mrcIpoW9lBMlPuPTvDACdXXrnxwsa8BIfM7L4m5LDmA=;
        b=OYbhGAkRLWdPTOEltcpd0vug0LOx4uc0a/fNF00AJQHttO0G1P6vx0SY3SuFcGe/a/
         z1JXjfEr43fLiq2vQrS4FOk/boy9Pw9AAyCt2oyNnHrK+eXXz+5CdMYMYtaa4PuFNWM7
         8x3kkNudwEajOVLeEvTDNsv8jhXAXXQqEJvipIBf2YsLUUERvHeQwUE5bIdHGjM2d8KY
         03SlIjCveeqFABb74kWPv8j+gMABvsImsZZRBSFMB8J296IVLE0dKl3nVvrv3ZJjvCrK
         JdRiXmMGBYMJpn/vTesWQKs9OTzOourBWUNTNT2g+fV1nlh6ls2tixeQtJkXvXDsh6Zi
         iU6Q==
X-Gm-Message-State: AOJu0YyTiABqGfx7lYMMdu5H3ZT3f81ryoidjlGeJ49QNQteQUGkrm3g
	aZ/TwVopnfEn9mF/i8xdHJkNJXa01pMp6uYl7Hg+eevkj5CHOCRBYeESGVqZDa3gEv5EwSOCyVF
	NaMsafQ==
X-Google-Smtp-Source: AGHT+IFrk0r2g2TAydkhzFn1up1QP1EA+8kYn7iueIyZBTX1+Sq3G68L3kXpXGxIpiNu1GwovFvKgw==
X-Received: by 2002:a17:903:247:b0:1d7:5b9a:c125 with SMTP id j7-20020a170903024700b001d75b9ac125mr888536plh.36.1706230202468;
        Thu, 25 Jan 2024 16:50:02 -0800 (PST)
Received: from hermes.lan (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id su16-20020a17090b535000b00293851b198csm124225pjb.56.2024.01.25.16.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 16:50:02 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2] spelling fixes
Date: Thu, 25 Jan 2024 16:49:48 -0800
Message-ID: <20240126005000.171350-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use codespell and ispell to fix some spelling errors
in comments and README's.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 devlink/devlink.c   | 2 +-
 examples/bpf/README | 2 +-
 lib/json_print.c    | 2 +-
 lib/utils.c         | 2 +-
 rdma/rdma.h         | 2 +-
 tc/em_canid.c       | 2 +-
 tc/m_gact.c         | 2 +-
 tc/q_htb.c          | 2 +-
 tipc/README         | 4 ++--
 9 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index f999e5940c63..dbeb6e397e8e 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -2329,7 +2329,7 @@ static int dl_argv_dry_parse(struct dl *dl, uint64_t o_required,
 	return err;
 }
 
-/* List of extented handles with two slashes. */
+/* List of extended handles with two slashes. */
 static const uint64_t dl_opt_extended_handle[] = {
 	DL_OPT_HANDLEP,
 	DL_OPT_HANDLE_REGION,
diff --git a/examples/bpf/README b/examples/bpf/README
index b7261191fc1e..4c27bb4e8cbe 100644
--- a/examples/bpf/README
+++ b/examples/bpf/README
@@ -15,4 +15,4 @@ with syntax and features:
 
 Note: Users should use new BTF way to defined the maps, the examples
 in legacy folder which is using struct bpf_elf_map defined maps is not
-recommanded.
+recommended.
diff --git a/lib/json_print.c b/lib/json_print.c
index 7b3b6c3fafba..810d496e99c7 100644
--- a/lib/json_print.c
+++ b/lib/json_print.c
@@ -217,7 +217,7 @@ int print_color_bool(enum output_type type,
 
 /* In JSON mode, acts like print_color_bool.
  * Otherwise, will print key with prefix of "no" if false.
- * The show flag is used to suppres printing in non-JSON mode
+ * The show flag is used to suppress printing in non-JSON mode
  */
 int print_color_bool_opt(enum output_type type,
 			 enum color_attr color,
diff --git a/lib/utils.c b/lib/utils.c
index 599e859ea393..6c1c1a8d31fd 100644
--- a/lib/utils.c
+++ b/lib/utils.c
@@ -1582,7 +1582,7 @@ size_t strlcat(char *dst, const char *src, size_t size)
 void drop_cap(void)
 {
 #ifdef HAVE_LIBCAP
-	/* don't harmstring root/sudo */
+	/* don't hamstring root/sudo */
 	if (getuid() != 0 && geteuid() != 0) {
 		cap_t capabilities;
 		cap_value_t net_admin = CAP_NET_ADMIN;
diff --git a/rdma/rdma.h b/rdma/rdma.h
index 1f8f83269457..df1852db5928 100644
--- a/rdma/rdma.h
+++ b/rdma/rdma.h
@@ -40,7 +40,7 @@ struct filter_entry {
 	char *key;
 	char *value;
 	/*
-	 * This field means that we can try to issue .doit calback
+	 * This field means that we can try to issue .doit callback
 	 * on value above. This value can be converted to integer
 	 * with simple atoi(). Otherwise "is_doit" will be false.
 	 */
diff --git a/tc/em_canid.c b/tc/em_canid.c
index 6d06b66a5944..228547529134 100644
--- a/tc/em_canid.c
+++ b/tc/em_canid.c
@@ -26,7 +26,7 @@
 #include <inttypes.h>
 #include "m_ematch.h"
 
-#define EM_CANID_RULES_MAX 400 /* Main reason for this number is Nelink
+#define EM_CANID_RULES_MAX 400 /* Main reason for this number is Netlink
 	message size limit equal to Single memory page size. When dump()
 	is invoked, there are even some ematch related headers sent from
 	kernel to userspace together with em_canid configuration --
diff --git a/tc/m_gact.c b/tc/m_gact.c
index e294a701bfd1..225ffce41412 100644
--- a/tc/m_gact.c
+++ b/tc/m_gact.c
@@ -18,7 +18,7 @@
 #include "tc_util.h"
 #include <linux/tc_act/tc_gact.h>
 
-/* define to turn on probablity stuff */
+/* define to turn on probability stuff */
 
 #ifdef CONFIG_GACT_PROB
 static const char *prob_n2a(int p)
diff --git a/tc/q_htb.c b/tc/q_htb.c
index 63b9521b89de..9afb293d9455 100644
--- a/tc/q_htb.c
+++ b/tc/q_htb.c
@@ -224,7 +224,7 @@ static int htb_parse_class_opt(struct qdisc_util *qu, int argc, char **argv,
 	opt.ceil.rate = (ceil64 >= (1ULL << 32)) ? ~0U : ceil64;
 
 	/* compute minimal allowed burst from rate; mtu is added here to make
-	   sute that buffer is larger than mtu and to have some safeguard space */
+	   sure that buffer is larger than mtu and to have some safeguard space */
 	if (!buffer)
 		buffer = rate64 / get_hz() + mtu;
 	if (!cbuffer)
diff --git a/tipc/README b/tipc/README
index 578a0b7b58a7..529d7814f125 100644
--- a/tipc/README
+++ b/tipc/README
@@ -13,10 +13,10 @@ possible to create a vlan named "help" with the ip tool, but it's impossible
 to remove it, the command just shows help. This is an effect of treating
 bare words specially.
 
-Help texts are not dynamically generated. That is, we do not pass datastructures
+Help texts are not dynamically generated. That is, we do not pass data structures
 like command list or option lists and print them dynamically. This is
 intentional. There is always that exception and when it comes to help texts
-these exceptions are normally neglected at the expence of usability.
+these exceptions are normally neglected at the expense of usability.
 
 KEY-VALUE
 ~~~~~~~~~
-- 
2.43.0


