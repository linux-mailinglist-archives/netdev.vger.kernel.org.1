Return-Path: <netdev+bounces-223721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB83B5A3E2
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 23:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 804753266EE
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 21:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC752F9DB5;
	Tue, 16 Sep 2025 21:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="l5sATNR5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A497F2F9D96
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758057867; cv=none; b=aqp+GuyoGqPTKlPPp28DZWe9kEJRQebhD386X2jKZvHxQWiO3wK0zUlOQ9qItmNCSaxP+Mf0708zy56yt6RNkrL7UuaGq5nSiTs8WqErTnE0LxBr3dtp7rergFquF1hLXAf4e27MmaATXEKdahGIP+T8fr9V3/hiDVy572CzAdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758057867; c=relaxed/simple;
	bh=0HDwwiFCKoOPhPNU2jdJGhU3pCnmeGKogoSCoMZPLxo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ubP/fADAUGRCiZ8pmvv1I6R0iFRYTIJmwDbxICPC9ohgbbGl3KSVypNkyucmU+EJaCFrf8BMxBU1z/r3Gy1O/pWvzBxMWqVI4laLv1FIEg0WWXsX2BI8uar99C6sbiedX7XizJoSvifD5fgMuJs1dPW7rtBOGtAiLn7TcHo9XvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=l5sATNR5; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from famine.localdomain (unknown [50.35.97.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 81678454B9;
	Tue, 16 Sep 2025 21:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1758057859;
	bh=ZkLAvGJnW+30hnSenKnYJrmcUuk7sF54DG6idQpugq0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=l5sATNR5B27Foq4J0fadDrF50rku7d5wrZT2RGIq0JnGh4aacQm1hgbYrXVwpiMIO
	 p6ZJ08weVy8DouuyL3yMa7BYdv8krQtIrZt5DwH6abwK7M5wHreVxDCEdcGqcEGu16
	 mEKkzXUMLK4TXT46eGEypydKsTGIV/zxmS/xGNBHspWFbWHcoGsOFgaiGidiCNdTeL
	 uB9gcNvxdDdvSTJ9tXlZTvJzJWI3xGtomWOdpPDm2ZhWVw/X3wGABj3OWRiVspeppZ
	 61lBFjHy4XHd/wT+aA2FRxhhUtto1nje7RIxjb7Fi7uN13y/B2F6XV4ZcwoBpNkVq6
	 3lVe9WIkWz3SA==
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>
Subject: [PATCH v2 2/4 iproute2-next] tc: Add get_size64 and get_size64_and_cell
Date: Tue, 16 Sep 2025 14:24:01 -0700
Message-Id: <20250916212403.3429851-3-jay.vosburgh@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250916212403.3429851-1-jay.vosburgh@canonical.com>
References: <20250916212403.3429851-1-jay.vosburgh@canonical.com>
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

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Jay Vosburgh <jay.vosburgh@canonical.com>
---

v2: add Jamal's ack

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


