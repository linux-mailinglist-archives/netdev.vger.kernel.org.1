Return-Path: <netdev+bounces-271778-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALcxEsJtxGn3zAQAu9opvQ
	(envelope-from <netdev+bounces-271778-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 00:20:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A8F32D572
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 00:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F123830120F1
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 23:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C8234D4E2;
	Wed, 25 Mar 2026 23:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sjkSpFEo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IZY0Qs+u";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sjkSpFEo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IZY0Qs+u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1A334B410
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 23:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774480756; cv=none; b=h7T2ibo3slS9tJS8qF48JAjHwijVNgis2b6CpgMXhwStU2OG5WZdqhxV6oE0FMQgOw+vGm7neGxiZKC/3RiGf8gguCmlntnHDYu0sjqztQzeyWcRItWAJrHkkcdG5L3bQpRN5nITms/Q1MZsyLCqbZcRWg8N3ldhea97enHdpdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774480756; c=relaxed/simple;
	bh=t2eh9wgZnVzJkciNOS2lhKvlQprzc/5WiuzcUJXdid4=;
	h=From:Date:Subject:To:Cc:Message-Id; b=TkZtz8GrqijyJAnICrVV0lwlRkGU/8iyXQUdZo/cZxnvaSHyYbqboRtPsfT/+iJ5vsOMr2/38nrK+MexPo+c2E3vwrMaEUkTJt2WZeaQ/gFhqm+2jodQsfRYbqr3QhumM4I5ibQzKV21tqbFR/yZPBomMu7QL/XljWfL7s71riM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sjkSpFEo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IZY0Qs+u; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sjkSpFEo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IZY0Qs+u; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.149.218.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1943E4D24D;
	Wed, 25 Mar 2026 23:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774480752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc;
	bh=XIits5soxfcVaDGE0rQET1vPJf8VDPsI6slBqBH2Bf0=;
	b=sjkSpFEoND7IzbOruS4TpvRoS9Z1SE10/kqm7b9Ymmfo0/wzTUzvwSj8h/k54mzV7J9BbU
	irBuSaj02SUPnGUrvhAbtpWlFDTthAVdIxU3C8G2BzxIyAij1BZVVerHScMHG9sVUpZj7K
	Dn+VEW4nEC+eTqEyTsNXzSN6mR5N9qw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774480752;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc;
	bh=XIits5soxfcVaDGE0rQET1vPJf8VDPsI6slBqBH2Bf0=;
	b=IZY0Qs+uqkigY5X5PnpQGCQ/yp2TFtirNkTuJhUGQRhO+OrkpVaN/lh56bg49ZIhAU3oLK
	J/+5uBE/hiUuVyDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774480752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc;
	bh=XIits5soxfcVaDGE0rQET1vPJf8VDPsI6slBqBH2Bf0=;
	b=sjkSpFEoND7IzbOruS4TpvRoS9Z1SE10/kqm7b9Ymmfo0/wzTUzvwSj8h/k54mzV7J9BbU
	irBuSaj02SUPnGUrvhAbtpWlFDTthAVdIxU3C8G2BzxIyAij1BZVVerHScMHG9sVUpZj7K
	Dn+VEW4nEC+eTqEyTsNXzSN6mR5N9qw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774480752;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc;
	bh=XIits5soxfcVaDGE0rQET1vPJf8VDPsI6slBqBH2Bf0=;
	b=IZY0Qs+uqkigY5X5PnpQGCQ/yp2TFtirNkTuJhUGQRhO+OrkpVaN/lh56bg49ZIhAU3oLK
	J/+5uBE/hiUuVyDA==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id E69172009B; Thu, 26 Mar 2026 00:19:11 +0100 (CET)
From: Michal Kubecek <mkubecek@suse.cz>
Date: Thu, 26 Mar 2026 00:03:02 +0100
Subject: [PATCH RESEND iproute2] ss: escape characters in command name
To: Stephen Hemminger <stephen@networkplumber.org>,
    netdev@vger.kernel.org
Cc: Josiah Stearns <B00TK1D@proton.me>
Message-Id: <20260325231911.E69172009B@lion.mk-sys.cz>
X-Spam-Flag: NO
X-Spam-Score: -4.29
X-Spam-Level: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271778-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkubecek@suse.cz,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,proton.me:email,networkplumber.org:email]
X-Rspamd-Queue-Id: B5A8F32D572
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Stephen Hemminger <stephen@networkplumber.org>

Since the process name is under user control with prctl(PR_SET_NAME)
it may contain escape characters to try and mess with screen output.

Reuse the existing string logic from procps (used by ps command).

Reported-by: Josiah Stearns <B00TK1D@proton.me>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Reviewed-by: Michal Kubecek <mkubecek@suse.cz>
Tested-by: Michal Kubecek <mkubecek@suse.cz>
---
 include/utils.h |   2 +
 lib/Makefile    |   2 +-
 lib/escape.c    | 111 ++++++++++++++++++++++++++++++++++++++++++++++++
 misc/ss.c       |  10 ++---
 4 files changed, 119 insertions(+), 6 deletions(-)
 create mode 100644 lib/escape.c

diff --git a/include/utils.h b/include/utils.h
index adf6a581a2a6..8b7e6d9e2c3b 100644
--- a/include/utils.h
+++ b/include/utils.h
@@ -369,6 +369,8 @@ const char *str_map_lookup_u8(const struct str_num_map *map, uint8_t val);
 unsigned int get_str_char_count(const char *str, int match);
 int str_split_by_char(char *str, char **before, char **after, int match);
 
+int escape_str (char *dst, const char *src, int bufsize);
+
 #define INDENT_STR_MAXLEN 32
 
 struct indent_mem {
diff --git a/lib/Makefile b/lib/Makefile
index cd561bc09235..7035f40f8953 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -6,7 +6,7 @@ CFLAGS += -fPIC
 UTILOBJ = utils.o utils_math.o rt_names.o ll_map.o ll_types.o ll_proto.o ll_addr.o \
 	inet_proto.o namespace.o json_writer.o json_print.o json_print_math.o \
 	names.o color.o bpf_legacy.o bpf_glue.o exec.o fs.o cg_map.o \
-	ppp_proto.o bridge.o sha1.o
+	ppp_proto.o bridge.o sha1.o escape.o
 
 ifeq ($(HAVE_ELF),y)
 ifeq ($(HAVE_LIBBPF),y)
diff --git a/lib/escape.c b/lib/escape.c
new file mode 100644
index 000000000000..b110f61b3038
--- /dev/null
+++ b/lib/escape.c
@@ -0,0 +1,111 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Escape character print handling derived from procps
+ * Copyright 1998-2002 by Albert Cahalan
+ * Copyright 2020-2022 Jim Warner <james.warner@comcast.net>
+ *
+ */
+
+#include <limits.h>
+#include <stdio.h>
+#include <string.h>
+#include <langinfo.h>
+
+#include "utils.h"
+
+static const char UTF_tab[] = {
+	1,  1,	1,  1,	1,  1,	1,  1,
+	1,  1,	1,  1,	1,  1,	1,  1, // 0x00 - 0x0F
+	1,  1,	1,  1,	1,  1,	1,  1,
+	1,  1,	1,  1,	1,  1,	1,  1, // 0x10 - 0x1F
+	1,  1,	1,  1,	1,  1,	1,  1,
+	1,  1,	1,  1,	1,  1,	1,  1, // 0x20 - 0x2F
+	1,  1,	1,  1,	1,  1,	1,  1,
+	1,  1,	1,  1,	1,  1,	1,  1, // 0x30 - 0x3F
+	1,  1,	1,  1,	1,  1,	1,  1,
+	1,  1,	1,  1,	1,  1,	1,  1, // 0x40 - 0x4F
+	1,  1,	1,  1,	1,  1,	1,  1,
+	1,  1,	1,  1,	1,  1,	1,  1, // 0x50 - 0x5F
+	1,  1,	1,  1,	1,  1,	1,  1,
+	1,  1,	1,  1,	1,  1,	1,  1, // 0x60 - 0x6F
+	1,  1,	1,  1,	1,  1,	1,  1,
+	1,  1,	1,  1,	1,  1,	1,  1, // 0x70 - 0x7F
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1, // 0x80 - 0x8F
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1, // 0x90 - 0x9F
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1, // 0xA0 - 0xAF
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1, // 0xB0 - 0xBF
+	-1, -1, 2,  2,	2,  2,	2,  2,
+	2,  2,	2,  2,	2,  2,	2,  2, // 0xC0 - 0xCF
+	2,  2,	2,  2,	2,  2,	2,  2,
+	2,  2,	2,  2,	2,  2,	2,  2, // 0xD0 - 0xDF
+	3,  3,	3,  3,	3,  3,	3,  3,
+	3,  3,	3,  3,	3,  3,	3,  3, // 0xE0 - 0xEF
+	4,  4,	4,  4,	4,  -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1, // 0xF0 - 0xFF
+};
+
+static const unsigned char ESC_tab[] = {
+	"@..............................." // 0x00 - 0x1F
+	"||||||||||||||||||||||||||||||||" // 0x20 - 0x3F
+	"||||||||||||||||||||||||||||||||" // 0x40 - 0x5f
+	"|||||||||||||||||||||||||||||||." // 0x60 - 0x7F
+	"????????????????????????????????" // 0x80 - 0x9F
+	"????????????????????????????????" // 0xA0 - 0xBF
+	"????????????????????????????????" // 0xC0 - 0xDF
+	"????????????????????????????????" // 0xE0 - 0xFF
+};
+
+static void esc_all(unsigned char *str)
+{
+	// if bad locale/corrupt str, replace non-printing stuff
+	while (*str) {
+		unsigned char c = ESC_tab[*str];
+
+		if (c != '|')
+			*str = c;
+		++str;
+	}
+}
+
+static void esc_ctl(unsigned char *str, int len)
+{
+	int i;
+
+	for (i = 0; i < len;) {
+		// even with a proper locale, strings might be corrupt
+		int n = UTF_tab[*str];
+
+		if (n < 0 || i + n > len) {
+			esc_all(str);
+			return;
+		}
+		// and eliminate those non-printing control characters
+		if (*str < 0x20 || *str == 0x7f)
+			*str = '?';
+		str += n;
+		i += n;
+	}
+}
+
+int escape_str(char *dst, const char *src, int bufsize)
+{
+	static int utf_sw;
+
+	if (utf_sw == 0) {
+		char *enc = nl_langinfo(CODESET);
+
+		utf_sw = enc && strcasecmp(enc, "UTF-8") == 0 ? 1 : -1;
+	}
+
+	int n = strlcpy(dst, src, bufsize);
+
+	if (utf_sw < 0)
+		esc_all((unsigned char *)dst);
+	else
+		esc_ctl((unsigned char *)dst, n);
+	return n;
+}
diff --git a/misc/ss.c b/misc/ss.c
index 28a82c669493..121ca6d55cb7 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -550,8 +550,7 @@ static void user_ent_add(unsigned int ino, char *task,
 static void user_ent_hash_build_task(char *path, int pid, int tid)
 {
 	const char *no_ctx = "unavailable";
-	char task[16] = {'\0', };
-	char stat[MAX_PATH_LEN];
+	char task[20] = { };
 	int pos_id, pos_fd;
 	char *task_context;
 	struct dirent *d;
@@ -599,6 +598,8 @@ static void user_ent_hash_build_task(char *path, int pid, int tid)
 			sock_context = strdup(no_ctx);
 
 		if (task[0] == '\0') {
+			char stat[MAX_PATH_LEN];
+			char name[16];
 			FILE *fp;
 
 			strlcpy(stat, path, pos_id + 1);
@@ -606,9 +607,8 @@ static void user_ent_hash_build_task(char *path, int pid, int tid)
 
 			fp = fopen(stat, "r");
 			if (fp) {
-				if (fscanf(fp, "%*d (%[^)])", task) < 1) {
-					; /* ignore */
-				}
+				if (fscanf(fp, "%*d (%[^)])", name) == 1)
+					escape_str(task, name, sizeof(task));
 				fclose(fp);
 			}
 		}
-- 
2.53.0


