Return-Path: <netdev+bounces-162635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8F1A27713
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 17:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 389FC16486A
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 16:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BF22153C6;
	Tue,  4 Feb 2025 16:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="XwEaUSDc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6512153C5
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 16:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738686282; cv=none; b=jpYqvonu48zzK9tpaGUe9SDN9kW17JPrzTJ4pjuLxvHUNilEosEnoidfbtjd7pSf6MLtlOSJSyvGUu3Q2UnjOPxBWXY7a49t3rnxbubIA2OoDpIy67fWRrjoH05QzcvcX94MdTqZt7CyzI7KUoCdUHySi677p75MB0PaLGOHprw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738686282; c=relaxed/simple;
	bh=ROxgMPT6X9ZDsmh3u9rY57c66JbOpEsk5nMuzANSjLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tB2haq1PNaBntwHtK7wyZDn+Dqy3Hna/f9pm4fSgVkApZ7Aww5Kbntc/0KWzi89R/R6wPsYF/+m4z299ELGLThfM6+Brk4Hc8miQNeM0k8KNr1zv4kc9JTm/eE8Mv8rhfli7QsEMqn2QyiDwFlzl25yxphGFPeL9URePrNLA5gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=XwEaUSDc; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2164b662090so113537995ad.1
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 08:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738686279; x=1739291079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zFtyskHX1hICOc4a+Sk6PTpl1HmVmvs6B80P2Hrr1Hk=;
        b=XwEaUSDciUvvmVaJFtU46OEp7O2HHdv2w95W+y+wpaJPqyYrnRiNh9CIE4BvnaSOmU
         /avwwB3RLcbCkhP2QlpVFddeyfZ/wykaS3mjbXxNSz2KxNRpO3NK7KVRr/lmBdahJozG
         Cfw2nFaUc2+NqR6JdLLyd1/0fGaeXcI1JLw9hU68cZVpkLZC7oRmB79xpkr/E6vxaciI
         32NqqhJCa0hBNN+m0+RWeyrU9GLkz/O+GV7t0Op5V+oKPNICldwZMLU4TawPmJjf8KcD
         7mnjm+8rGq6NUgLziBAWD2YKSgwtwIrTMhbiGCl+1qtq7BehXcvUaNzmyFZudghS5Ofg
         d3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738686279; x=1739291079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zFtyskHX1hICOc4a+Sk6PTpl1HmVmvs6B80P2Hrr1Hk=;
        b=Hp8v0t3WeBNzji1IOhRjSNZx2glxR8qAdRGkYXmyKUc8fo2LwNcpR/aGpoiy02cMnj
         E9fN/tB6pAJiD3GAm37bMYMK2wxVj4YaIRuDjE3VhkZBxVzqrJ+vkaHzmWrM6VhwTe59
         LUsFOdmDS1eh/6ZTZ+PcEqKvUCoRbQUv9v56RWijbguQrMQSgIcDcZp1fAPTBvc6rYG7
         OuTGzn5fkStkYimjDKfeho/HhFhgqsicP+fmwnNLzQnQ9u+daA+K/d643RDKwSpiXBkg
         iyADym2Z+Gb61vOz2ACqFPJ7Gs++na32tkZgf7VFLOyT7DMNmUFy33Qs8fStuEETwO+p
         pEKQ==
X-Gm-Message-State: AOJu0YwMGQ7xzq6A0RY2WpPf1sH0BbJPQ7V0bbVCJAbl9zLp5ZUD1w52
	WmlS4eAJP/XsaFcEv/j7BaYTaWfePy4tekJSC+3chn58+KxQoVEmAZ2miVJAdt5gsGvlxL//9wx
	j
X-Gm-Gg: ASbGncu6JhBuESElXxPZnTV42hJjOIvbbh6utzWXCVrRbek8FN77yxGNnFfQeNWmAQ+
	8gRFge7BDUTGNUIvT6u+XdirLiFpOuOw8MUKQLDOpXRVATYGYgFTunxiA5MP0NXFjFPKItlxPk5
	eoHskqsADiP9EKqxzS4nW3gC/miejmxG1m2Lq8OAvGgDxnpPIBN2GG5maOKV4NDyKuRDyW0AayU
	q6hCqzoVgPurP0gesHbtgVfFm2HRbvfonnGdUG4QE9lEyenGw+PlvUSvdeZtKKloDS9r6xjUuFu
	x/C2kqAVxqKbzDgBh+L0whDcx7sO6KKtbg/JE4H7swqceVkDbzw+11txpQz/RHzWIx3y
X-Google-Smtp-Source: AGHT+IHLmfQUr2pZ+J5EX5fXRsW45My4sbuq/m3LJLkqCvhWhUhKcUTBxM8x8ivRKk9wZgIBuQv1bQ==
X-Received: by 2002:a17:902:da81:b0:21f:860:6d0d with SMTP id d9443c01a7336-21f086074e3mr35145865ad.5.1738686279566;
        Tue, 04 Feb 2025 08:24:39 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f06e72c27sm15108335ad.114.2025.02.04.08.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 08:24:39 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Josiah Stearns <B00TK1D@proton.me>
Subject: [PATCH iproute2-next] ss: escape characters in command name
Date: Tue,  4 Feb 2025 08:24:16 -0800
Message-ID: <20250204162429.17902-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the process name is under user control with prctl(PR_SET_NAME)
it may contain escape characters to try and mess with screen output.

Reuse the existing string logic from procps (used by ps command).

Reported-by: Josiah Stearns <B00TK1D@proton.me>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 include/utils.h |   2 +
 lib/Makefile    |   2 +-
 lib/escape.c    | 111 ++++++++++++++++++++++++++++++++++++++++++++++++
 misc/ss.c       |  10 ++---
 4 files changed, 119 insertions(+), 6 deletions(-)
 create mode 100644 lib/escape.c

diff --git a/include/utils.h b/include/utils.h
index 9a81494d..e91c5f0e 100644
--- a/include/utils.h
+++ b/include/utils.h
@@ -372,6 +372,8 @@ const char *str_map_lookup_u8(const struct str_num_map *map, uint8_t val);
 unsigned int get_str_char_count(const char *str, int match);
 int str_split_by_char(char *str, char **before, char **after, int match);
 
+int escape_str (char *dst, const char *src, int bufsize);
+
 #define INDENT_STR_MAXLEN 32
 
 struct indent_mem {
diff --git a/lib/Makefile b/lib/Makefile
index aa7bbd2e..c259722f 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -5,7 +5,7 @@ CFLAGS += -fPIC
 
 UTILOBJ = utils.o utils_math.o rt_names.o ll_map.o ll_types.o ll_proto.o ll_addr.o \
 	inet_proto.o namespace.o json_writer.o json_print.o json_print_math.o \
-	names.o color.o bpf_legacy.o bpf_glue.o exec.o fs.o cg_map.o ppp_proto.o
+	names.o color.o bpf_legacy.o bpf_glue.o exec.o fs.o cg_map.o ppp_proto.o escape.o
 
 ifeq ($(HAVE_ELF),y)
 ifeq ($(HAVE_LIBBPF),y)
diff --git a/lib/escape.c b/lib/escape.c
new file mode 100644
index 00000000..b110f61b
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
index aef1a714..1d70242e 100644
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
2.47.2


