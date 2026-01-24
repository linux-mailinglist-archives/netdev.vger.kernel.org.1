Return-Path: <netdev+bounces-253113-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id nwlFBGBEdWmiDAEAu9opvQ
	(envelope-from <netdev+bounces-253113-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 23:14:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE81E7F1B8
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 23:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 425283002925
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 22:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115F727B359;
	Sat, 24 Jan 2026 22:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="WmnZuHmn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE3D2222A1
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 22:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769292890; cv=none; b=sd4q82GcdzLNwxruSiN/O/eNNqe3k265/IxHxCMoSbfVviBWxUxNHOr3gIFTUcxM/guswlad7UqHHYje4KbcLI1BPgr/XjVWtyFqgBv9PmDNzWQ4/lAxd499Ww8FoexN6R0/O+0O2ZUW7n4tf09MT+owHh052jgK3b/9iiFVzRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769292890; c=relaxed/simple;
	bh=2EIBNLUbE9CRTuil12pMZfUAL6Kk1N6bAruq34Jjqk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rQmYvqLng2PcqD7z0yGnMnvxk1eWOrsJZJsIyrDorAz+JbzCwPyfwtHje4+UUtUn0FgG/j2WqOGumOfXZwZDRmZh5L/k+Hjp9p8806qkfWjJEladYIkBDKhcO1gOC2mlerwAUb7eFJ0NvLnKFEiEwSIVfFVLLTd1nlLySgWGOHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=WmnZuHmn; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-432755545fcso2393394f8f.1
        for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 14:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769292885; x=1769897685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yGxrv3X6RvgA/2ZW7kHeoeczK4irSSU7Fp1RFXH6/5o=;
        b=WmnZuHmnfPtHJZcIYxBfjlxvbvRiM2qNpo2j3soBpeO7DqPUsl6TEW0c9n/AtBlyq7
         vcHszeF+g8QYNXQ1K1fGsP5Mj858tysHwcIdYrAF+5tgWLw4Rbul/jRDd0FSyr78BDs8
         8nRKarbDbD72WgaoARQmdFUmLwKmZCfWVGQK3nqKsxjYy4/BWbeV226U5X+4M2UyahKF
         DR4w2XnLgQiUlAApM2N3aDP1j/ukT9NE0yCcd1+5CLiHRdtnSnoK4LJan3QBlVThS7gU
         1URdrEzQ0CK4HggMCiPJymUJ6vIo4v26XK6XfCeNlSnPOywMLKWQs5bxE+q3LXAaBf12
         lkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769292885; x=1769897685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGxrv3X6RvgA/2ZW7kHeoeczK4irSSU7Fp1RFXH6/5o=;
        b=GsCdY0KXLEQHp47v49foq2T9Qt4VsWFO60yn+pLQa+KUwTwrfG5xHu0zJ8QO/3JCyK
         xU2v7O+YfWsieRyi7Sw7Zu+BuiQ4TBkzLVSL2cGODO1Z14umavvfjjNJPzeofeLTQZAC
         dz3sk1iaBGtiDKgiPex4J+iDLdVOyoMBqlFFFpW41AGCv2JjhzXenFgUzxicUjktrK7C
         GwZnFQ1Sr21TuJU+C7QePZfcrqmux11UZ4YKHw9s/wUItVMUjAQ8soSfPlC5k4Z7Oo4w
         CaaSXIFpPnkVEHPIbEeTLfctOU0BDSA0CZ8z8jc6eUQvq3XCd4FvRE5Dpw5dCwszBbrH
         qqdw==
X-Gm-Message-State: AOJu0YzcK5shEy1fjMeM0rujruPwieDWNuYq6Y8O/O8h9m9zfKGmNOPu
	xpwF7jCsCNsasi84RFkvr5nrk+ejHdB1Ddf48WccpnZzesjveX/K4WNyppOpZC05VKPS6rs0SAp
	aalDk2vo=
X-Gm-Gg: AZuq6aLujP4DcayVOVLvirrz4kUgEisYNFcChuhtRFwLa9d62iL0lWVpNkM8rm9RHqR
	sBIX1C1KwSLwOBAMWsQxZPiVMmt5dHZ1oQWrv9llbkNK0WrO18S2kHvjJsefA41CzVboiRarzCT
	Me6IFHuIKKVX3J5qM30Ltt4DcU+2I/7/cnqlXtm4dLQ3ZJ5d9+UMfhl9W18Mw0SKsgRgVDoiZ4j
	kSdRu4Tc7laYuz1dF7obvsRctdeVCbt/J7PHwEDfazKh7mAuFXZNpVZGcaL/8UIEyYvKCzPHyd1
	qu3UXBz/An8lQ822UdcEhCoK7CTc5rij3rHbWUL5knt84NJgyGCbIpToYtna470Ef3kjaSza6d6
	0cNmPijpdgRXfDXDzfxrx97g00AQEoM+HXzg8CColXbW8OR7lql+6LOJxASDRZW6rLatICZq+W/
	0haQpgdfBZem5xlU32hrnDqTiOtsS5lpZ9pcLsZ9ajdCIekECHnA==
X-Received: by 2002:a5d:5d0f:0:b0:432:84ef:756c with SMTP id ffacd0b85a97d-435b160e072mr11860760f8f.50.1769292884835;
        Sat, 24 Jan 2026 14:14:44 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f7b4d8sm16356233f8f.38.2026.01.24.14.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 14:14:43 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next] doc: add AGENTS.md for AI coding assistants
Date: Sat, 24 Jan 2026 14:14:27 -0800
Message-ID: <20260124221439.234122-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253113-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:mid,networkplumber.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,agents.md:url,networkplumber-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: DE81E7F1B8
X-Rspamd-Action: no action

I (and probably others) are experimenting with AI code review
and dumentation tools. It is worthwhile to have a baseline
reference for coding assistants (such as Claude, Copilot,
Cursor, etc.) when working with the iproute2 codebase.

This document is a first draft and covers:
- Coding style based on Linux kernel guidelines with iproute2-specific
  exceptions.
- JSON output requirements using print_XXX helpers with PRINT_ANY
- Command-line argument parsing (strcmp for new code, not matches())
- Kernel compatibility and uapi header update procedures
- Patch submission guidelines including DCO requirements

This helps ensure AI-generated contributions follow project conventions
and reduces review burden from style issues. Changes and revisions
are welcome and expected.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 AGENTS.md | 690 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 690 insertions(+)
 create mode 100644 AGENTS.md

diff --git a/AGENTS.md b/AGENTS.md
new file mode 100644
index 00000000..00349192
--- /dev/null
+++ b/AGENTS.md
@@ -0,0 +1,690 @@
+# AGENTS.md - AI Agent Guidelines for iproute2
+
+## Project Overview
+
+iproute2 is a collection of userspace utilities for controlling and monitoring
+networking in the Linux kernel. It includes tools like `ip`, `tc`, `ss`, `bridge`,
+and others. The project is tightly coupled with Linux kernel networking development.
+
+**Important**: iproute2 is userspace code, not kernel code. While the coding style
+is similar to the Linux kernel, some kernel-specific conventions do not apply.
+
+## Repository Information
+
+- **Stable repository**: `git://git.kernel.org/pub/scm/network/iproute2/iproute2.git`
+- **Development repository**: `git://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git`
+- **Mailing list**: `netdev@vger.kernel.org`
+- **Wiki**: https://wiki.linuxfoundation.org/networking/iproute2
+
+## Coding Style
+
+iproute2 follows Linux kernel coding style with some exceptions specific to
+userspace code. Reference: https://www.kernel.org/doc/html/latest/process/coding-style.html
+
+### Indentation
+
+- Use tabs for indentation (tabs are 8 characters)
+- Do not use spaces for indentation (except in continuation lines)
+- Switch and case labels are aligned in the same column:
+
+```c
+switch (suffix) {
+case 'G':
+case 'g':
+	mem <<= 30;
+	break;
+case 'M':
+case 'm':
+	mem <<= 20;
+	break;
+default:
+	break;
+}
+```
+
+### Line Length
+
+- Preferred limit: 100 columns
+- Longer lines are acceptable if breaking them reduces readability
+- Never break user-visible strings (e.g., error messages) - they must be grep-able
+
+### Braces
+
+**Functions**: Opening brace on a new line:
+
+```c
+int function(int x)
+{
+	body of function
+}
+```
+
+**Control structures** (if, switch, for, while, do): Opening brace on same line:
+
+```c
+if (x is true) {
+	we do y
+}
+```
+
+**Single statements**: Do not use braces where a single statement will do:
+
+```c
+if (condition)
+	action();
+```
+
+**Consistency rule**: If one branch needs braces, use braces on all branches:
+
+```c
+if (condition) {
+	do_this();
+	do_that();
+} else {
+	otherwise();
+}
+```
+
+### Spaces
+
+Use a space after these keywords:
+
+	if, switch, case, for, do, while
+
+Do NOT use a space after:
+
+	sizeof, typeof, alignof, __attribute__
+
+Examples:
+```c
+s = sizeof(struct file);      /* correct */
+s = sizeof( struct file );    /* WRONG */
+```
+
+Use one space around binary and ternary operators:
+```c
+=  +  -  <  >  *  /  %  |  &  ^  <=  >=  ==  !=  ?  :
+```
+
+No space after unary operators:
+```c
+&  *  +  -  ~  !  sizeof  typeof  alignof  __attribute__
+```
+
+No space around `.` and `->` structure member operators.
+
+### Pointer Declarations
+
+The `*` is adjacent to the variable name, not the type:
+
+```c
+char *linux_banner;                          /* correct */
+char* linux_banner;                          /* WRONG */
+unsigned long long memparse(char *ptr, char **retptr);
+```
+
+### Naming
+
+- Use lowercase with underscores for names: `count_active_users`
+- Do NOT use CamelCase or Hungarian notation
+- Global variables and functions need descriptive names
+- Local variables should be short: `i` for loop counter, `tmp` for temporary
+- Avoid `master/slave` and `blacklist/whitelist` terminology
+
+### File Headers
+
+Every source file must start with an SPDX license identifier:
+
+```c
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * filename.c		Brief description
+ *
+ * Authors:	Name <email@example.org>
+ */
+```
+
+### Comments
+
+Multi-line comments use this format:
+
+```c
+/*
+ * This is the preferred style for multi-line
+ * comments in iproute2 source code.
+ *
+ * Description: A column of asterisks on the left side,
+ * with beginning and ending almost-blank lines.
+ */
+```
+
+Comments should explain WHAT the code does, not HOW. Avoid comments inside
+function bodies - if needed, the function may be too complex.
+
+### Variable Declarations
+
+**Note**: Unlike the Linux kernel, iproute2 does NOT require "Christmas tree"
+(reverse Christmas tree / reverse fir tree) style for variable declarations.
+Variables do not need to be ordered by decreasing line length.
+
+Acceptable:
+```c
+int ret;
+struct nlmsghdr *answer;
+const char *filter_dev = NULL;
+__u32 filt_mask = IFLA_STATS_FILTER_BIT(IFLA_STATS_AF_SPEC);
+```
+
+Use one declaration per line to allow for comments on each item.
+
+### Structure Initialization
+
+Use designated initializers for structures:
+
+```c
+struct iplink_req req = {
+	.n.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg)),
+	.n.nlmsg_flags = NLM_F_REQUEST,
+	.i.ifi_family = preferred_family,
+};
+```
+
+### Functions
+
+- Functions should be short and do one thing
+- Limit local variables to 5-10 per function
+- Separate functions with one blank line
+- Use goto for centralized cleanup (see below)
+
+### Centralized Exit with goto
+
+Use goto for cleanup when a function has multiple exit points:
+
+```c
+int fun(int a)
+{
+	int result = 0;
+	char *buffer;
+
+	buffer = malloc(SIZE);
+	if (!buffer)
+		return -ENOMEM;
+
+	if (condition1) {
+		while (loop1) {
+			...
+		}
+		result = 1;
+		goto out_free_buffer;
+	}
+	...
+out_free_buffer:
+	free(buffer);
+	return result;
+}
+```
+
+Use descriptive label names like `out_free_buffer:` not `err1:`.
+
+### Macros
+
+- Macro names defining constants should be CAPITALIZED
+- Enums are preferred over #define for related constants
+- Prefer inline functions over function-like macros
+- Multi-statement macros must use do-while:
+
+```c
+#define MACROFUN(a, b, c)		\
+	do {				\
+		if (a == 5)		\
+			do_this(b, c);	\
+	} while (0)
+```
+
+### Error Messages
+
+Use `fprintf(stderr, ...)` for error messages. This is critical to avoid
+corrupting JSON output on stdout:
+
+```c
+fprintf(stderr, "Error: argument of \"%s\" must be \"on\" or \"off\", not \"%s\"\n",
+	msg, realval);
+```
+
+Do NOT use `printf()` or `fprintf(stdout, ...)` for error messages.
+
+## Command-Line Argument Parsing
+
+### Legacy Code vs New Code
+
+**Critical distinction for argument parsing:**
+
+- **Legacy code**: Uses `matches()` function which allows abbreviations
+- **New code**: Must use `strcmp()` for exact string comparison only
+
+The `matches()` function has caused problems with abbreviations in the past.
+For all new code, use only full string comparison:
+
+```c
+/* CORRECT - New code should use strcmp() */
+if (strcmp(*argv, "dev") == 0) {
+	NEXT_ARG();
+	/* ... */
+}
+
+/* LEGACY - matches() allows abbreviations, DO NOT use in new code */
+if (matches(*argv, "broadcast") == 0) {  /* matches "b", "br", "bro", etc. */
+	/* ... */
+}
+```
+
+### Argument Processing Macros
+
+Use the standard macros for argument iteration:
+
+```c
+NEXT_ARG();           /* Move to next argument, exit with error if none */
+NEXT_ARG_OK();        /* Check if next argument exists */
+PREV_ARG();           /* Move back one argument */
+```
+
+### Common Patterns
+
+```c
+while (argc > 0) {
+	if (strcmp(*argv, "dev") == 0) {
+		NEXT_ARG();
+		dev = *argv;
+	} else if (strcmp(*argv, "mtu") == 0) {
+		NEXT_ARG();
+		if (get_unsigned(&mtu, *argv, 0))
+			invarg("Invalid \"mtu\" value\n", *argv);
+	} else if (strcmp(*argv, "help") == 0) {
+		usage();
+	} else {
+		fprintf(stderr, "Unknown argument: %s\n", *argv);
+		exit(-1);
+	}
+	argc--; argv++;
+}
+```
+
+## JSON Output Support
+
+**All commands must support JSON output.** Use the helper functions from
+`json_print.h` to ensure consistent output in both regular and JSON modes.
+
+### Key Principles
+
+1. **Avoid special-casing JSON** - Let the library handle the differences
+2. **Use print_XXX helpers** - Do not use `fprintf(fp, ...)` directly for display output
+3. **Error messages to stderr** - Use `fprintf(stderr, ...)` for errors to avoid corrupting JSON
+4. **Pair open/close calls** - Every `open_json_object()` needs `close_json_object()`,
+   every `open_json_array()` needs `close_json_array()`
+
+### Initializing JSON Context
+
+```c
+#include "json_print.h"
+
+/* At the start of output */
+new_json_obj(json);      /* json is a global flag set by -json option */
+
+/* At the end of output */
+delete_json_obj();
+```
+
+### Correct Usage Pattern
+
+**Use `PRINT_ANY` to handle both JSON and text output in one call:**
+
+```c
+/* GOOD - single call handles both modes */
+print_uint(PRINT_ANY, "mtu", "mtu %u ", mtu);
+print_string(PRINT_ANY, "name", "%s ", name);
+
+/* BAD - do not special-case JSON and text separately */
+print_uint(PRINT_JSON, "foo", NULL, bar);
+print_uint(PRINT_FP, NULL, "foo %u", bar);
+```
+
+The correct pattern uses `PRINT_ANY` with both a JSON key and a format string,
+letting the library handle which output mode is active.
+
+### Color Support
+
+Use color variants for these value types to improve readability:
+
+- **Interface names** (e.g., "eth0", "enp0s3")
+- **MAC addresses** (e.g., "1a:0e:d4:cd:70:81")
+- **IPv4 addresses**
+- **IPv6 addresses**
+- **Operational state values**
+
+```c
+print_color_string(PRINT_ANY, COLOR_IFNAME, "ifname", "%s", ifname);
+print_color_string(PRINT_ANY, COLOR_MAC, "address", "%s ", mac_addr);
+print_color_string(PRINT_ANY, oper_state_color(state), "operstate", "%s ", state_str);
+```
+
+### Output Functions
+
+Use `PRINT_ANY` for output that works in both JSON and text modes:
+
+```c
+/* Simple values */
+print_string(PRINT_ANY, "name", "%s ", name);
+print_uint(PRINT_ANY, "mtu", "mtu %u ", mtu);
+print_u64(PRINT_ANY, "bytes", "%llu", bytes);
+print_bool(PRINT_ANY, "up", "%s", is_up);
+print_on_off(PRINT_ANY, "enabled", "%s ", enabled);
+```
+
+### JSON Objects and Arrays
+
+Objects and arrays must be properly paired:
+
+```c
+/* Objects - MUST pair open/close */
+open_json_object("linkinfo");
+print_string(PRINT_ANY, "kind", "    %s ", kind);
+close_json_object();  /* Required! */
+
+/* Arrays - MUST pair open/close */
+open_json_array(PRINT_ANY, is_json_context() ? "flags" : "<");
+print_string(PRINT_ANY, NULL, flags ? "%s," : "%s", "UP");
+close_json_array(PRINT_ANY, "> ");  /* Required! */
+```
+
+### Conditional Output
+
+For output that must differ between JSON and text modes (use sparingly):
+
+```c
+if (is_json_context()) {
+	print_uint(PRINT_JSON, "operstate_index", NULL, state);
+} else {
+	print_0xhex(PRINT_FP, NULL, "state %#llx", state);
+}
+```
+
+### Output Type Enum
+
+```c
+enum output_type {
+	PRINT_FP = 1,    /* Text output only */
+	PRINT_JSON = 2,  /* JSON output only */
+	PRINT_ANY = 4,   /* Both text and JSON (preferred) */
+};
+```
+
+### Available Print Functions
+
+From `json_print.h`:
+- `print_string()`, `print_uint()`, `print_int()`, `print_u64()`, `print_s64()`
+- `print_bool()`, `print_on_off()`, `print_null()`
+- `print_hex()`, `print_0xhex()`
+- `print_float()`, `print_rate()`, `print_tv()` (timeval)
+- `print_hu()` (unsigned short), `print_hhu()` (unsigned char)
+- `print_luint()` (unsigned long), `print_lluint()` (unsigned long long)
+- `print_nl()` - prints newline in non-JSON context only
+- Color variants: `print_color_string()`, `print_color_uint()`, etc.
+
+### Non-JSON Output Format
+
+The non-JSON (text) output format should be aligned with the command-line
+arguments. The output field names should match or closely correspond to
+the argument names users provide:
+
+```
+$ ip link show dev eth0
+2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP
+    link/ether 00:11:22:33:44:55 brd ff:ff:ff:ff:ff:ff
+```
+
+### Human-Readable vs Raw Values
+
+Commands that output rates, times, or byte counts should:
+
+- **Plaintext output**: Use existing helpers to format into human-readable terms
+- **JSON output**: Print raw numeric values (for script consumption)
+
+JSON output is intended for scripts and programmatic parsing, so raw values
+are more useful than formatted strings.
+
+Example:
+```
+$ tc qdisc show dev enp7s0
+qdisc fq_codel 0: parent :4 limit 10240p flows 1024 quantum 1514 target 5ms
+
+$ tc -j -p qdisc show dev enp7s0
+[ {
+        "kind": "fq_codel",
+        "handle": "0:",
+        "parent": ":4",
+        "options": {
+            "limit": 10240,
+            "flows": 1024,
+            "quantum": 1514,
+            "target": 4999,
+            "interval": 99999,
+            "memory_limit": 33554432,
+            "ecn": true,
+            "drop_batch": 64
+        }
+    } ]
+```
+
+Note how `target` shows as `5ms` in plaintext but `4999` (microseconds) in JSON.
+
+Use helpers like `print_rate()` which automatically handle this distinction.
+
+## Documentation
+
+### No Kernel Docbook Format
+
+iproute2 does **not** use the kernel's docbook documentation format.
+Function documentation should use simple C comments:
+
+```c
+/*
+ * Brief description of what the function does.
+ *
+ * Longer description if needed.
+ * Returns 0 on success, negative on failure.
+ */
+static int my_function(int argc, char **argv)
+```
+
+### Usage Functions
+
+Each command should have a `usage()` function that displays help:
+
+```c
+static void usage(void) __attribute__((noreturn));
+
+static void usage(void)
+{
+	fprintf(stderr,
+		"Usage: ip address {add|change|replace} IFADDR dev IFNAME\n"
+		"       ip address del IFADDR dev IFNAME\n"
+		"       ip address show [ dev IFNAME ]\n"
+		...);
+	exit(-1);
+}
+```
+
+## Submitting Patches
+
+### Patch Format
+
+Patches follow the Linux kernel patch submission guidelines:
+https://www.kernel.org/doc/html/latest/process/submitting-patches.html
+
+### Subject Line
+
+Use the appropriate prefix based on the target tree:
+
+```
+Subject: [PATCH iproute2] component: brief description
+Subject: [PATCH iproute2-next] component: brief description
+```
+
+Examples:
+```
+Subject: [PATCH iproute2-next] ip: fix syntax for rules
+Subject: [PATCH iproute2] tc: fix memory leak in filter parsing
+```
+
+### Commit Message
+
+- First line: brief summary (50 chars or less)
+- Blank line
+- Detailed description wrapped at 72 characters
+- Signed-off-by line
+
+```
+ip: add support for new feature
+
+Detailed explanation of what this patch does and why.
+Reference any relevant kernel commits if this adds support
+for new kernel features.
+
+Signed-off-by: Your Name <your.email@example.org>
+```
+
+### Signed-off-by and Developer Certificate of Origin
+
+The `Signed-off-by:` line certifies that you wrote the code or have the right
+to submit it, following the Developer's Certificate of Origin (DCO):
+https://developercertificate.org/
+
+By adding your Signed-off-by, you certify:
+- The contribution was created by you, or
+- It is based on previous work with a compatible license, or
+- It was provided to you by someone who certified the above
+
+Use `git commit -s` to automatically add your Signed-off-by line.
+
+### Sending Patches
+
+Send patches to the netdev mailing list:
+
+```
+git send-email --to=netdev@vger.kernel.org your-patch.patch
+```
+
+## Testing
+
+- Test both JSON and non-JSON output modes
+- Test with various kernel versions (features may not be available on older kernels)
+- Verify error handling with invalid inputs
+- Check for memory leaks with valgrind
+
+## Common Patterns
+
+### Netlink Request Structure
+
+```c
+struct {
+	struct nlmsghdr  n;
+	struct ifaddrmsg ifa;
+	char             buf[256];
+} req = {
+	.n.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifaddrmsg)),
+	.n.nlmsg_flags = NLM_F_REQUEST | flags,
+	.n.nlmsg_type = cmd,
+	.ifa.ifa_family = preferred_family,
+};
+```
+
+### Adding Netlink Attributes
+
+```c
+addattr_l(&req.n, sizeof(req), IFA_LOCAL, &addr.data, addr.bytelen);
+addattr32(&req.n, sizeof(req), IFA_RT_PRIORITY, metric);
+addattr_nest(&req.n, sizeof(req), IFLA_PROP_LIST | NLA_F_NESTED);
+addattr_nest_end(&req.n, proplist);
+```
+
+### Standard Error Helpers
+
+```c
+invarg("invalid value", *argv);     /* Invalid argument value */
+duparg("device", *argv);            /* Duplicate argument */
+duparg2("dev", *argv);              /* Duplicate argument variant */
+missarg("required argument");       /* Missing required argument */
+nodev(devname);                     /* Device not found */
+```
+
+## Kernel Compatibility
+
+iproute2 aims to be compatible across a wide range of kernel versions. A newer
+version of iproute2 will work with older kernels (though new features may not
+be available), and older iproute2 versions work with newer kernels (but cannot
+access new features).
+
+### Sanitized Kernel Headers (uapi)
+
+The `include/uapi/` directory contains sanitized kernel headers that define
+the userspace API for networking. These headers are specific to iproute2 and
+allow the tools to be built with support for features that may not yet be
+present in the build system's kernel headers.
+
+These headers are generated from the kernel source tree using:
+
+```
+make headers_install
+```
+
+**Important rules for uapi updates:**
+
+1. **Separate patches** - Updates to `include/uapi/` must be in a separate patch
+   from the new functionality that uses them
+
+2. **Upstream first** - Changes to uapi headers will only be accepted once the
+   corresponding kernel patch has been merged upstream. Do not submit iproute2
+   patches that depend on unmerged (or potentially rejected) kernel changes
+
+3. **Reference kernel commits** - When updating uapi headers, reference the
+   upstream kernel commit in your patch description
+
+When adding support for new kernel features:
+
+1. Wait for the kernel patch to be merged upstream
+2. Submit a patch updating the relevant headers in `include/uapi/`
+3. Submit a separate patch adding the iproute2 functionality
+4. The code should handle older kernels gracefully - new attributes sent to
+   older kernels may be silently ignored or return an error
+5. Test with both old and new kernel versions when possible
+
+### Runtime Feature Detection
+
+Since iproute2 may run on kernels older than what it was built against:
+
+- Check return values from netlink requests - `EOPNOTSUPP` or similar errors
+  indicate the kernel doesn't support a feature
+- Don't assume features exist - the kernel may silently ignore unknown attributes
+- Provide helpful error messages when features aren't available
+
+## Files and Directories
+
+- `ip/` - ip command and subcommands
+- `tc/` - traffic control utilities
+- `bridge/` - bridge control utilities
+- `misc/` - miscellaneous utilities
+- `lib/` - shared library code
+- `include/` - header files
+- `include/uapi/` - sanitized kernel headers (from `make headers_install`)
+
+## Security Considerations
+
+- Validate all user input
+- Be careful with buffer sizes
+- Check return values from system calls and library functions
+- See SECURITY.md for vulnerability reporting procedures
+
+## License
+
+iproute2 is licensed under GPL-2.0-or-later. Some files may have dual licensing
+(GPL-2.0 OR BSD-2-Clause) - check the SPDX identifier in each file.
-- 
2.51.0


