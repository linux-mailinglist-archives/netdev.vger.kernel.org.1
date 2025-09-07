Return-Path: <netdev+bounces-220653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFA8B4789E
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 03:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E085A204452
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 01:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C3E19CC28;
	Sun,  7 Sep 2025 01:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="YgfD/VfU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A18F19258E
	for <netdev@vger.kernel.org>; Sun,  7 Sep 2025 01:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757209805; cv=none; b=TovTsYjQXHzh+STVGakp/eXQOrczJPDF4g+gTcue5GZWGE8+8WFBnrOszvHmnKH62kXKgvlxwltvZCtQr69t8R8eNRTDf1dtalxuTTQPaBjiXuCzcTkhChlT7KFW6pxIUSXzaFuARABNnkbJAg88ADnRKLw/FA+NUCK874n5T0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757209805; c=relaxed/simple;
	bh=NI1MAcLaE+G6Ob5lqQCnkyGTl+0PpCx74c7q2Ce+RHk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NFGMJISfEg8om8EQNImdBzdrY3ciq74eFs8yOYa2qplWTZDeRRTjTr1X4qCHHUxNGanauyGCkm3m+QHcMxQv0HVWVB2ywn3nKzruEgdLL+mcTnEHeO1K4i47qUVsGVrEpiWyFEuryGyHjjQ9XbH/xmTe3Db0ZwppWR4kF84+juQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=YgfD/VfU; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from famine.localdomain (unknown [50.35.97.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id EA70143F26;
	Sun,  7 Sep 2025 01:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1757209349;
	bh=yLTjZnSiguzbZldhEEoSkY3tpeG2SjZ7IWRr2WRS8eg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=YgfD/VfUAB6QZhsmgHPGhI7lwec1mjobeHdqo8FXj6EB6nUGXKfFOxu/9p5fnMZ+d
	 MAv1ZJxRBs2P3qrBEHL1C1DIUT4Q9XtXDDd5I/SGLa8N5LNA05N61XVOQnd4C8Nfpw
	 AVfk3d0VPgU4f4VWJxSXANyx1Rc8IFuCy5BSLbxaoaiI0C9GP+shBB7fk/GghpIAHs
	 tDfDIi/jbBycWsRWlprO267AwUVr9slFlcFdZh5Nk9Sue4FEpfXccUbXGeN45ZCWl3
	 HF9mr7v4J5flwv8ftBiQz2gb3aL2qf+ltWk/v+qFkG19+JwqAcxPaYQ2tlvJi8+I9k
	 mDuduBVBlsH7A==
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>
Subject: [PATCH 2/4 iproute2-next] tc: Add get_size64 and get_size64_and_cell
Date: Sat,  6 Sep 2025 18:42:14 -0700
Message-Id: <20250907014216.2691844-3-jay.vosburgh@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250907014216.2691844-1-jay.vosburgh@canonical.com>
References: <20250907014216.2691844-1-jay.vosburgh@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	In preparation for accepting 64 bit burst sizes, create 64-bit
versions of get_size and get_size_and_cell.  The 32-bit versions become
wrappers around the 64-bit versions.

Signed-off-by: Jay Vosburgh <jay.vosburgh@canonical.com>
---
 include/utils.h  |  1 +
 lib/utils_math.c | 19 ++++++++++++++++++-
 tc/tc_util.c     | 21 +++++++++++++++++++--
 tc/tc_util.h     |  1 +
 4 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/include/utils.h b/include/utils.h
index 9a81494dd3e3..128cbb59cb90 100644
--- a/include/utils.h
+++ b/include/utils.h
@@ -163,6 +163,7 @@ int get_addr64(__u64 *ap, const char *cp);
 int get_rate(unsigned int *rate, const char *str);
 int get_rate64(__u64 *rate, const char *str);
 int get_size(unsigned int *size, const char *str);
+int get_size64(__u64 *size, const char *str);
 
 int hex2mem(const char *buf, uint8_t *mem, int count);
 char *hexstring_n2a(const __u8 *str, int len, char *buf, int blen);
diff --git a/lib/utils_math.c b/lib/utils_math.c
index 9ef3dd6ed93b..a7e747440039 100644
--- a/lib/utils_math.c
+++ b/lib/utils_math.c
@@ -87,7 +87,7 @@ int get_rate64(__u64 *rate, const char *str)
 	return 0;
 }
 
-int get_size(unsigned int *size, const char *str)
+int get_size64(__u64 *size, const char *str)
 {
 	double sz;
 	char *p;
@@ -121,3 +121,20 @@ int get_size(unsigned int *size, const char *str)
 
 	return 0;
 }
+
+int get_size(unsigned int *size, const char *str)
+{
+	__u64 sz64;
+	int rv;
+
+	rv = get_size64(&sz64, str);
+	*size = sz64;
+
+	if (rv)
+		return rv;
+
+	if (sz64 > UINT_MAX)
+		return -1;
+
+	return 0;
+}
diff --git a/tc/tc_util.c b/tc/tc_util.c
index ff0ac170730b..45d76e7578d4 100644
--- a/tc/tc_util.c
+++ b/tc/tc_util.c
@@ -257,14 +257,14 @@ tc_print_rate(enum output_type t, const char *key, const char *fmt,
 	print_rate(use_iec, t, key, fmt, rate);
 }
 
-int get_size_and_cell(unsigned int *size, int *cell_log, char *str)
+int get_size64_and_cell(__u64 *size, int *cell_log, char *str)
 {
 	char *slash = strchr(str, '/');
 
 	if (slash)
 		*slash = 0;
 
-	if (get_size(size, str))
+	if (get_size64(size, str))
 		return -1;
 
 	if (slash) {
@@ -286,6 +286,23 @@ int get_size_and_cell(unsigned int *size, int *cell_log, char *str)
 	return 0;
 }
 
+int get_size_and_cell(unsigned int *size, int *cell_log, char *str)
+{
+	__u64 size64;
+	int rv;
+
+	rv = get_size64_and_cell(&size64, cell_log, str);
+	if (rv)
+		return rv;
+
+	if (size64 > UINT32_MAX)
+		return -1;
+
+	*size = size64;
+
+	return 0;
+}
+
 void print_devname(enum output_type type, int ifindex)
 {
 	const char *ifname = ll_index_to_name(ifindex);
diff --git a/tc/tc_util.h b/tc/tc_util.h
index ec2063729b07..8ebca3963d94 100644
--- a/tc/tc_util.h
+++ b/tc/tc_util.h
@@ -80,6 +80,7 @@ int get_qdisc_handle(__u32 *h, const char *str);
 int get_percent_rate(unsigned int *rate, const char *str, const char *dev);
 int get_percent_rate64(__u64 *rate, const char *str, const char *dev);
 int get_size_and_cell(unsigned int *size, int *cell_log, char *str);
+int get_size64_and_cell(__u64 *size, int *cell_log, char *str);
 int get_linklayer(unsigned int *val, const char *arg);
 
 void tc_print_rate(enum output_type t, const char *key, const char *fmt,
-- 
2.25.1


