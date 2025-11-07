Return-Path: <netdev+bounces-236861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 314BBC40DE4
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 17:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 032E74E4995
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 16:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106F0275B0F;
	Fri,  7 Nov 2025 16:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBMUo84b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0471274B48
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 16:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762532588; cv=none; b=G4otU6le6RhUo107/YAbl752OM2xi7ps/Xn0yt7oUZBimAwq93/jev6KO+ufUMwVoKwNZAH58IKnfVxsLxgw8o7U29VCZuy9hIo80/g2bnWb+3nyTexm85AiXH6Yb/5f3LjjUExc56klMW49z6rxfiCUeRt/PBoTgE1mFGosrHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762532588; c=relaxed/simple;
	bh=LUviT9N/Mbx0OTPuAbFckwoNAdcxWVfSK3AExgVTnrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e8g0tuC+8vpGIQ7uVUDuOq7O1/iga+1hiPHXU1hMjB1rk2j4YD8k3Enn0klIbBHgYuLhY03vb1dAEN2vX8Xiynf33A/jgDEw8M7h0FWeCDK8LkY/sR/CbPqTdefmcx0mgLZYqhC3CmeYvUJsyB9LGAsqSl31XqkPrGMvv2EKKG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBMUo84b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C45C116B1;
	Fri,  7 Nov 2025 16:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762532587;
	bh=LUviT9N/Mbx0OTPuAbFckwoNAdcxWVfSK3AExgVTnrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UBMUo84bT+FxIx63QVfQrwZkLmKx9k/h4c8o/T00CvU95n1Je0tHgzNq5IRumQubb
	 sdYgV6XV/Uxc241cCS4jl7zX2fejOx2Gem5cV2kW+DuySILLinU/DZ7beDtwpHeAbp
	 3Skd9Fd92i4zBKkogF+r+YyCx1dyaiqQeTu6YHGOfh07l0+stolZ/C63rm5g9/nTFj
	 gUXQpzR32tUVfc/wn3iQufHV45SP8pz+NSQJx5+HL0CqjnXK/4R/qbAkIqwuGDCQMZ
	 TKx2HmQTauHBaor1HilH9UmUKAi3sPrAb9sAMVV9PERPp6q7D5Gtbu3DRW/zUs59en
	 ajQTYtTVUuLtQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net,
	donald.hunter@gmail.com
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	joe@dama.to,
	jstancek@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 1/4] tools: ynltool: create skeleton for the C command
Date: Fri,  7 Nov 2025 08:22:24 -0800
Message-ID: <20251107162227.980672-2-kuba@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107162227.980672-1-kuba@kernel.org>
References: <20251107162227.980672-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on past discussions it seems like integration of YNL into
iproute2 is unlikely. YNL itself is not great as a C library,
since it has no backward compat (we routinely change types).

Most of the operations can be performed with the generic Python
CLI directly. There is, however, a handful of operations where
summarization of kernel output is very useful (mostly related
to stats: page-pool, qstat).

Create a command (inspired by bpftool, I think it stood the test
of time reasonably well) to be able to plug the subcommands into.

Link: https://lore.kernel.org/1754895902-8790-1-git-send-email-ernis@linux.microsoft.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - use kernel source version
v1: https://lore.kernel.org/20251104232348.1954349-3-kuba@kernel.org
---
 tools/net/ynl/Makefile              |   3 +-
 tools/net/ynl/ynltool/Makefile      |  52 +++++
 tools/net/ynl/ynltool/json_writer.h |  75 ++++++++
 tools/net/ynl/ynltool/main.h        |  62 ++++++
 tools/net/ynl/ynltool/json_writer.c | 288 ++++++++++++++++++++++++++++
 tools/net/ynl/ynltool/main.c        | 240 +++++++++++++++++++++++
 tools/net/ynl/ynltool/.gitignore    |   1 +
 7 files changed, 720 insertions(+), 1 deletion(-)
 create mode 100644 tools/net/ynl/ynltool/Makefile
 create mode 100644 tools/net/ynl/ynltool/json_writer.h
 create mode 100644 tools/net/ynl/ynltool/main.h
 create mode 100644 tools/net/ynl/ynltool/json_writer.c
 create mode 100644 tools/net/ynl/ynltool/main.c
 create mode 100644 tools/net/ynl/ynltool/.gitignore

diff --git a/tools/net/ynl/Makefile b/tools/net/ynl/Makefile
index 211df5a93ad9..31ed20c0f3f8 100644
--- a/tools/net/ynl/Makefile
+++ b/tools/net/ynl/Makefile
@@ -12,10 +12,11 @@ endif
 libdir  ?= $(prefix)/$(libdir_relative)
 includedir ?= $(prefix)/include
 
-SUBDIRS = lib generated samples
+SUBDIRS = lib generated samples ynltool
 
 all: $(SUBDIRS) libynl.a
 
+ynltool: | lib generated libynl.a
 samples: | lib generated
 libynl.a: | lib generated
 	@echo -e "\tAR $@"
diff --git a/tools/net/ynl/ynltool/Makefile b/tools/net/ynl/ynltool/Makefile
new file mode 100644
index 000000000000..cfabab3a20da
--- /dev/null
+++ b/tools/net/ynl/ynltool/Makefile
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+include ../Makefile.deps
+
+INSTALL	?= install
+prefix  ?= /usr
+
+CC := gcc
+CFLAGS := -Wall -Wextra -Werror -O2
+ifeq ("$(DEBUG)","1")
+  CFLAGS += -g -fsanitize=address -fsanitize=leak -static-libasan
+endif
+CFLAGS += -I../lib
+
+SRC_VERSION := \
+	$(shell make --no-print-directory -sC ../../../.. kernelversion || \
+		echo "unknown")
+
+CFLAGS += -DSRC_VERSION='"$(SRC_VERSION)"'
+
+SRCS := $(wildcard *.c)
+OBJS := $(patsubst %.c,$(OUTPUT)%.o,$(SRCS))
+
+YNLTOOL := $(OUTPUT)ynltool
+
+include $(wildcard *.d)
+
+all: $(YNLTOOL)
+
+Q = @
+
+$(YNLTOOL): $(OBJS)
+	$(Q)echo -e "\tLINK $@"
+	$(Q)$(CC) $(CFLAGS) -o $@ $(OBJS)
+
+%.o: %.c main.h json_writer.h
+	$(Q)echo -e "\tCC $@"
+	$(Q)$(COMPILE.c) -MMD -c -o $@ $<
+
+clean:
+	rm -f *.o *.d *~
+
+distclean: clean
+	rm -f $(YNLTOOL)
+
+bindir ?= /usr/bin
+
+install: $(YNLTOOL)
+	install -m 0755 $(YNLTOOL) $(DESTDIR)$(bindir)/$(YNLTOOL)
+
+.PHONY: all clean distclean
+.DEFAULT_GOAL=all
diff --git a/tools/net/ynl/ynltool/json_writer.h b/tools/net/ynl/ynltool/json_writer.h
new file mode 100644
index 000000000000..0f1e63c88f6a
--- /dev/null
+++ b/tools/net/ynl/ynltool/json_writer.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Simple streaming JSON writer
+ *
+ * This takes care of the annoying bits of JSON syntax like the commas
+ * after elements
+ *
+ * Authors:	Stephen Hemminger <stephen@networkplumber.org>
+ */
+
+#ifndef _JSON_WRITER_H_
+#define _JSON_WRITER_H_
+
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdarg.h>
+#include <stdio.h>
+
+/* Opaque class structure */
+typedef struct json_writer json_writer_t;
+
+/* Create a new JSON stream */
+json_writer_t *jsonw_new(FILE *f);
+/* End output to JSON stream */
+void jsonw_destroy(json_writer_t **self_p);
+
+/* Cause output to have pretty whitespace */
+void jsonw_pretty(json_writer_t *self, bool on);
+
+/* Reset separator to create new JSON */
+void jsonw_reset(json_writer_t *self);
+
+/* Add property name */
+void jsonw_name(json_writer_t *self, const char *name);
+
+/* Add value  */
+void __attribute__((format(printf, 2, 0))) jsonw_vprintf_enquote(json_writer_t *self,
+								 const char *fmt,
+								 va_list ap);
+void __attribute__((format(printf, 2, 3))) jsonw_printf(json_writer_t *self,
+							const char *fmt, ...);
+void jsonw_string(json_writer_t *self, const char *value);
+void jsonw_bool(json_writer_t *self, bool value);
+void jsonw_float(json_writer_t *self, double number);
+void jsonw_float_fmt(json_writer_t *self, const char *fmt, double num);
+void jsonw_uint(json_writer_t *self, uint64_t number);
+void jsonw_hu(json_writer_t *self, unsigned short number);
+void jsonw_int(json_writer_t *self, int64_t number);
+void jsonw_null(json_writer_t *self);
+void jsonw_lluint(json_writer_t *self, unsigned long long int num);
+
+/* Useful Combinations of name and value */
+void jsonw_string_field(json_writer_t *self, const char *prop, const char *val);
+void jsonw_bool_field(json_writer_t *self, const char *prop, bool value);
+void jsonw_float_field(json_writer_t *self, const char *prop, double num);
+void jsonw_uint_field(json_writer_t *self, const char *prop, uint64_t num);
+void jsonw_hu_field(json_writer_t *self, const char *prop, unsigned short num);
+void jsonw_int_field(json_writer_t *self, const char *prop, int64_t num);
+void jsonw_null_field(json_writer_t *self, const char *prop);
+void jsonw_lluint_field(json_writer_t *self, const char *prop,
+			unsigned long long int num);
+void jsonw_float_field_fmt(json_writer_t *self, const char *prop,
+			   const char *fmt, double val);
+
+/* Collections */
+void jsonw_start_object(json_writer_t *self);
+void jsonw_end_object(json_writer_t *self);
+
+void jsonw_start_array(json_writer_t *self);
+void jsonw_end_array(json_writer_t *self);
+
+/* Override default exception handling */
+typedef void (jsonw_err_handler_fn)(const char *);
+
+#endif /* _JSON_WRITER_H_ */
diff --git a/tools/net/ynl/ynltool/main.h b/tools/net/ynl/ynltool/main.h
new file mode 100644
index 000000000000..f4a70acf2085
--- /dev/null
+++ b/tools/net/ynl/ynltool/main.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/* Copyright (C) 2017-2018 Netronome Systems, Inc. */
+/* Copyright Meta Platforms, Inc. and affiliates */
+
+#ifndef __YNLTOOL_H
+#define __YNLTOOL_H
+
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <string.h>
+
+#include "json_writer.h"
+
+#define NEXT_ARG()	({ argc--; argv++; if (argc < 0) usage(); })
+#define NEXT_ARGP()	({ (*argc)--; (*argv)++; if (*argc < 0) usage(); })
+#define BAD_ARG()	({ p_err("what is '%s'?", *argv); -1; })
+#define GET_ARG()	({ argc--; *argv++; })
+#define REQ_ARGS(cnt)							\
+	({								\
+		int _cnt = (cnt);					\
+		bool _res;						\
+									\
+		if (argc < _cnt) {					\
+			p_err("'%s' needs at least %d arguments, %d found", \
+			      argv[-1], _cnt, argc);			\
+			_res = false;					\
+		} else {						\
+			_res = true;					\
+		}							\
+		_res;							\
+	})
+
+#define HELP_SPEC_OPTIONS						\
+	"OPTIONS := { {-j|--json} [{-p|--pretty}] }"
+
+extern const char *bin_name;
+
+extern json_writer_t *json_wtr;
+extern bool json_output;
+extern bool pretty_output;
+
+void __attribute__((format(printf, 1, 2))) p_err(const char *fmt, ...);
+void __attribute__((format(printf, 1, 2))) p_info(const char *fmt, ...);
+
+bool is_prefix(const char *pfx, const char *str);
+int detect_common_prefix(const char *arg, ...);
+void usage(void) __attribute__((noreturn));
+
+struct cmd {
+	const char *cmd;
+	int (*func)(int argc, char **argv);
+};
+
+int cmd_select(const struct cmd *cmds, int argc, char **argv,
+	       int (*help)(int argc, char **argv));
+
+#endif /* __YNLTOOL_H */
diff --git a/tools/net/ynl/ynltool/json_writer.c b/tools/net/ynl/ynltool/json_writer.c
new file mode 100644
index 000000000000..c8685e592cd3
--- /dev/null
+++ b/tools/net/ynl/ynltool/json_writer.c
@@ -0,0 +1,288 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+/*
+ * Simple streaming JSON writer
+ *
+ * This takes care of the annoying bits of JSON syntax like the commas
+ * after elements
+ *
+ * Authors:	Stephen Hemminger <stephen@networkplumber.org>
+ */
+
+#include <stdio.h>
+#include <stdbool.h>
+#include <stdarg.h>
+#include <assert.h>
+#include <malloc.h>
+#include <inttypes.h>
+#include <stdint.h>
+
+#include "json_writer.h"
+
+struct json_writer {
+	FILE		*out;
+	unsigned	depth;
+	bool		pretty;
+	char		sep;
+};
+
+static void jsonw_indent(json_writer_t *self)
+{
+	unsigned i;
+	for (i = 0; i < self->depth; ++i)
+		fputs("    ", self->out);
+}
+
+static void jsonw_eol(json_writer_t *self)
+{
+	if (!self->pretty)
+		return;
+
+	putc('\n', self->out);
+	jsonw_indent(self);
+}
+
+static void jsonw_eor(json_writer_t *self)
+{
+	if (self->sep != '\0')
+		putc(self->sep, self->out);
+	self->sep = ',';
+}
+
+static void jsonw_puts(json_writer_t *self, const char *str)
+{
+	putc('"', self->out);
+	for (; *str; ++str)
+		switch (*str) {
+		case '\t':
+			fputs("\\t", self->out);
+			break;
+		case '\n':
+			fputs("\\n", self->out);
+			break;
+		case '\r':
+			fputs("\\r", self->out);
+			break;
+		case '\f':
+			fputs("\\f", self->out);
+			break;
+		case '\b':
+			fputs("\\b", self->out);
+			break;
+		case '\\':
+			fputs("\\\\", self->out);
+			break;
+		case '"':
+			fputs("\\\"", self->out);
+			break;
+		default:
+			putc(*str, self->out);
+		}
+	putc('"', self->out);
+}
+
+json_writer_t *jsonw_new(FILE *f)
+{
+	json_writer_t *self = malloc(sizeof(*self));
+	if (self) {
+		self->out = f;
+		self->depth = 0;
+		self->pretty = false;
+		self->sep = '\0';
+	}
+	return self;
+}
+
+void jsonw_destroy(json_writer_t **self_p)
+{
+	json_writer_t *self = *self_p;
+
+	assert(self->depth == 0);
+	fputs("\n", self->out);
+	fflush(self->out);
+	free(self);
+	*self_p = NULL;
+}
+
+void jsonw_pretty(json_writer_t *self, bool on)
+{
+	self->pretty = on;
+}
+
+void jsonw_reset(json_writer_t *self)
+{
+	assert(self->depth == 0);
+	self->sep = '\0';
+}
+
+static void jsonw_begin(json_writer_t *self, int c)
+{
+	jsonw_eor(self);
+	putc(c, self->out);
+	++self->depth;
+	self->sep = '\0';
+}
+
+static void jsonw_end(json_writer_t *self, int c)
+{
+	assert(self->depth > 0);
+
+	--self->depth;
+	if (self->sep != '\0')
+		jsonw_eol(self);
+	putc(c, self->out);
+	self->sep = ',';
+}
+
+void jsonw_name(json_writer_t *self, const char *name)
+{
+	jsonw_eor(self);
+	jsonw_eol(self);
+	self->sep = '\0';
+	jsonw_puts(self, name);
+	putc(':', self->out);
+	if (self->pretty)
+		putc(' ', self->out);
+}
+
+void jsonw_vprintf_enquote(json_writer_t *self, const char *fmt, va_list ap)
+{
+	jsonw_eor(self);
+	putc('"', self->out);
+	vfprintf(self->out, fmt, ap);
+	putc('"', self->out);
+}
+
+void jsonw_printf(json_writer_t *self, const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	jsonw_eor(self);
+	vfprintf(self->out, fmt, ap);
+	va_end(ap);
+}
+
+void jsonw_start_object(json_writer_t *self)
+{
+	jsonw_begin(self, '{');
+}
+
+void jsonw_end_object(json_writer_t *self)
+{
+	jsonw_end(self, '}');
+}
+
+void jsonw_start_array(json_writer_t *self)
+{
+	jsonw_begin(self, '[');
+}
+
+void jsonw_end_array(json_writer_t *self)
+{
+	jsonw_end(self, ']');
+}
+
+void jsonw_string(json_writer_t *self, const char *value)
+{
+	jsonw_eor(self);
+	jsonw_puts(self, value);
+}
+
+void jsonw_bool(json_writer_t *self, bool val)
+{
+	jsonw_printf(self, "%s", val ? "true" : "false");
+}
+
+void jsonw_null(json_writer_t *self)
+{
+	jsonw_printf(self, "null");
+}
+
+void jsonw_float_fmt(json_writer_t *self, const char *fmt, double num)
+{
+	jsonw_printf(self, fmt, num);
+}
+
+void jsonw_float(json_writer_t *self, double num)
+{
+	jsonw_printf(self, "%g", num);
+}
+
+void jsonw_hu(json_writer_t *self, unsigned short num)
+{
+	jsonw_printf(self, "%hu", num);
+}
+
+void jsonw_uint(json_writer_t *self, uint64_t num)
+{
+	jsonw_printf(self, "%"PRIu64, num);
+}
+
+void jsonw_lluint(json_writer_t *self, unsigned long long int num)
+{
+	jsonw_printf(self, "%llu", num);
+}
+
+void jsonw_int(json_writer_t *self, int64_t num)
+{
+	jsonw_printf(self, "%"PRId64, num);
+}
+
+void jsonw_string_field(json_writer_t *self, const char *prop, const char *val)
+{
+	jsonw_name(self, prop);
+	jsonw_string(self, val);
+}
+
+void jsonw_bool_field(json_writer_t *self, const char *prop, bool val)
+{
+	jsonw_name(self, prop);
+	jsonw_bool(self, val);
+}
+
+void jsonw_float_field(json_writer_t *self, const char *prop, double val)
+{
+	jsonw_name(self, prop);
+	jsonw_float(self, val);
+}
+
+void jsonw_float_field_fmt(json_writer_t *self,
+			   const char *prop,
+			   const char *fmt,
+			   double val)
+{
+	jsonw_name(self, prop);
+	jsonw_float_fmt(self, fmt, val);
+}
+
+void jsonw_uint_field(json_writer_t *self, const char *prop, uint64_t num)
+{
+	jsonw_name(self, prop);
+	jsonw_uint(self, num);
+}
+
+void jsonw_hu_field(json_writer_t *self, const char *prop, unsigned short num)
+{
+	jsonw_name(self, prop);
+	jsonw_hu(self, num);
+}
+
+void jsonw_lluint_field(json_writer_t *self,
+			const char *prop,
+			unsigned long long int num)
+{
+	jsonw_name(self, prop);
+	jsonw_lluint(self, num);
+}
+
+void jsonw_int_field(json_writer_t *self, const char *prop, int64_t num)
+{
+	jsonw_name(self, prop);
+	jsonw_int(self, num);
+}
+
+void jsonw_null_field(json_writer_t *self, const char *prop)
+{
+	jsonw_name(self, prop);
+	jsonw_null(self);
+}
diff --git a/tools/net/ynl/ynltool/main.c b/tools/net/ynl/ynltool/main.c
new file mode 100644
index 000000000000..8e15e4ee543f
--- /dev/null
+++ b/tools/net/ynl/ynltool/main.c
@@ -0,0 +1,240 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/* Copyright (C) 2017-2018 Netronome Systems, Inc. */
+/* Copyright Meta Platforms, Inc. and affiliates */
+
+#include <ctype.h>
+#include <errno.h>
+#include <getopt.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stdarg.h>
+
+#include "main.h"
+
+const char *bin_name;
+static int last_argc;
+static char **last_argv;
+static int (*last_do_help)(int argc, char **argv);
+json_writer_t *json_wtr;
+bool pretty_output;
+bool json_output;
+
+static void __attribute__((noreturn)) clean_and_exit(int i)
+{
+	if (json_output)
+		jsonw_destroy(&json_wtr);
+
+	exit(i);
+}
+
+void usage(void)
+{
+	last_do_help(last_argc - 1, last_argv + 1);
+
+	clean_and_exit(-1);
+}
+
+static int do_help(int argc __attribute__((unused)),
+		   char **argv __attribute__((unused)))
+{
+	if (json_output) {
+		jsonw_null(json_wtr);
+		return 0;
+	}
+
+	fprintf(stderr,
+		"Usage: %s [OPTIONS] OBJECT { COMMAND | help }\n"
+		"       %s version\n"
+		"\n"
+		"       OBJECT := { }\n"
+		"       " HELP_SPEC_OPTIONS "\n"
+		"",
+		bin_name, bin_name);
+
+	return 0;
+}
+
+static int do_version(int argc __attribute__((unused)),
+		      char **argv __attribute__((unused)))
+{
+	if (json_output) {
+		jsonw_start_object(json_wtr);
+		jsonw_name(json_wtr, "version");
+		jsonw_printf(json_wtr, SRC_VERSION);
+		jsonw_end_object(json_wtr);
+	} else {
+		printf("%s " SRC_VERSION "\n", bin_name);
+	}
+	return 0;
+}
+
+static const struct cmd commands[] = {
+	{ "help",	do_help },
+	{ "version",	do_version },
+	{ 0 }
+};
+
+int cmd_select(const struct cmd *cmds, int argc, char **argv,
+	       int (*help)(int argc, char **argv))
+{
+	unsigned int i;
+
+	last_argc = argc;
+	last_argv = argv;
+	last_do_help = help;
+
+	if (argc < 1 && cmds[0].func)
+		return cmds[0].func(argc, argv);
+
+	for (i = 0; cmds[i].cmd; i++) {
+		if (is_prefix(*argv, cmds[i].cmd)) {
+			if (!cmds[i].func) {
+				p_err("command '%s' is not available", cmds[i].cmd);
+				return -1;
+			}
+			return cmds[i].func(argc - 1, argv + 1);
+		}
+	}
+
+	help(argc - 1, argv + 1);
+
+	return -1;
+}
+
+bool is_prefix(const char *pfx, const char *str)
+{
+	if (!pfx)
+		return false;
+	if (strlen(str) < strlen(pfx))
+		return false;
+
+	return !memcmp(str, pfx, strlen(pfx));
+}
+
+/* Last argument MUST be NULL pointer */
+int detect_common_prefix(const char *arg, ...)
+{
+	unsigned int count = 0;
+	const char *ref;
+	char msg[256];
+	va_list ap;
+
+	snprintf(msg, sizeof(msg), "ambiguous prefix: '%s' could be '", arg);
+	va_start(ap, arg);
+	while ((ref = va_arg(ap, const char *))) {
+		if (!is_prefix(arg, ref))
+			continue;
+		count++;
+		if (count > 1)
+			strncat(msg, "' or '", sizeof(msg) - strlen(msg) - 1);
+		strncat(msg, ref, sizeof(msg) - strlen(msg) - 1);
+	}
+	va_end(ap);
+	strncat(msg, "'", sizeof(msg) - strlen(msg) - 1);
+
+	if (count >= 2) {
+		p_err("%s", msg);
+		return -1;
+	}
+
+	return 0;
+}
+
+void p_err(const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	if (json_output) {
+		jsonw_start_object(json_wtr);
+		jsonw_name(json_wtr, "error");
+		jsonw_vprintf_enquote(json_wtr, fmt, ap);
+		jsonw_end_object(json_wtr);
+	} else {
+		fprintf(stderr, "Error: ");
+		vfprintf(stderr, fmt, ap);
+		fprintf(stderr, "\n");
+	}
+	va_end(ap);
+}
+
+void p_info(const char *fmt, ...)
+{
+	va_list ap;
+
+	if (json_output)
+		return;
+
+	va_start(ap, fmt);
+	vfprintf(stderr, fmt, ap);
+	fprintf(stderr, "\n");
+	va_end(ap);
+}
+
+int main(int argc, char **argv)
+{
+	static const struct option options[] = {
+		{ "json",	no_argument,	NULL,	'j' },
+		{ "help",	no_argument,	NULL,	'h' },
+		{ "pretty",	no_argument,	NULL,	'p' },
+		{ "version",	no_argument,	NULL,	'V' },
+		{ 0 }
+	};
+	bool version_requested = false;
+	int opt, ret;
+
+	setlinebuf(stdout);
+
+	last_do_help = do_help;
+	pretty_output = false;
+	json_output = false;
+	bin_name = "ynltool";
+
+	opterr = 0;
+	while ((opt = getopt_long(argc, argv, "Vhjp",
+				  options, NULL)) >= 0) {
+		switch (opt) {
+		case 'V':
+			version_requested = true;
+			break;
+		case 'h':
+			return do_help(argc, argv);
+		case 'p':
+			pretty_output = true;
+			/* fall through */
+		case 'j':
+			if (!json_output) {
+				json_wtr = jsonw_new(stdout);
+				if (!json_wtr) {
+					p_err("failed to create JSON writer");
+					return -1;
+				}
+				json_output = true;
+			}
+			jsonw_pretty(json_wtr, pretty_output);
+			break;
+		default:
+			p_err("unrecognized option '%s'", argv[optind - 1]);
+			if (json_output)
+				clean_and_exit(-1);
+			else
+				usage();
+		}
+	}
+
+	argc -= optind;
+	argv += optind;
+	if (argc < 0)
+		usage();
+
+	if (version_requested)
+		ret = do_version(argc, argv);
+	else
+		ret = cmd_select(commands, argc, argv, do_help);
+
+	if (json_output)
+		jsonw_destroy(&json_wtr);
+
+	return ret;
+}
diff --git a/tools/net/ynl/ynltool/.gitignore b/tools/net/ynl/ynltool/.gitignore
new file mode 100644
index 000000000000..f38848dbb0d3
--- /dev/null
+++ b/tools/net/ynl/ynltool/.gitignore
@@ -0,0 +1 @@
+ynltool
-- 
2.51.1


