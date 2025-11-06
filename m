Return-Path: <netdev+bounces-236464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D0FC3C938
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 17:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE56C625E18
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 16:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E396534FF5D;
	Thu,  6 Nov 2025 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZYi/bPQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99A734FF62
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 16:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762447031; cv=none; b=O3I38S0hBHmJTmGWr1FXZ4aEW4VsMIXZkDhHKm7shVSgso81wve0830+vg0lRGIgBd1fJ+tLYkA3LQgcb0Tl9GJB9fSw2Jgxw61Jlegna7B/p/YU5ToUg65koZY3besSyTfC+WMCEkwMAJLP+64mq3rvKD+TE7HZ+YExru9TUP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762447031; c=relaxed/simple;
	bh=Qy0TQczLc7wOegyg+z1qipWR0l12G1hC97Js614k1ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVt3jyVoh6G4L6xntXISht6/NgDNLBI4P7i3xIfypg3cjIeRkXZLC+dA19SFObNVos29+DVc0Zw6Y7vEh4PG8y8YDKqYMi8fLLF+mkf6cneMeZIEBi4iZqE41W+Gp10UGd1vX5ze/JaBJbxDCbMPBB6DhzErYdZubW8UGFKkj0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZYi/bPQ; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b9ab6cdf64bso978461a12.0
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 08:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762447029; x=1763051829; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jKzVrGfgyyZyJlS0+UH02xR9yF1ngBn4XiZkaxil87A=;
        b=LZYi/bPQmwEg0rOcjCL1wmviyaGHkSquh8lR8+ES4ZwCeXUZlJEnrdM1Z4LiVxe6Af
         Giq6qZwTnz0TXrHIz5pZTxPiMxKXNokAFRjIB1SieiUq7y8OqtFxyPQ9KlIIsX4UYKCm
         MvpVoI+HEoXmzrMnivC/KmY/czBvVvsXUi29UU4H+TA2q6QsDFH08BKVIg/nkWRL1kHP
         tPXUOMz2C8gc286e0x/4LneFCU2wwHdi5RNf+woh8oWzJFgnRQe3N/tc7u0R7aCHJYnS
         8zLf6MQV7OCYlRYXghVn97z9GrN46IFhLIpkko8JZywWXI4Btk/ThLx3qxYXkOqcKwFR
         Lv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762447029; x=1763051829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jKzVrGfgyyZyJlS0+UH02xR9yF1ngBn4XiZkaxil87A=;
        b=IeRHuw0GuMoxNZZ978DU7mDxzr2OdPNipRLneABABCXtReodVHXRdzAtpl+7vUHrKg
         ivKIR7HPX82zQ7vt/+QM8iqPC+QpYtH15UQq4a/ds7TcTHhJ0LsyxGJWSjqyeW1woFEC
         azABE5XKjn0De7oeZ1/TDQMPZxdYVF+6t/vl0WXkoRZ1LSfFK8ZWrJ2+10bI7MXkp2cE
         HnAiwoekAiVtCB2e/W4pDrqN4E1He+7sChh0kDsnFBH4yylBXg8mxO/1NaUWy5lD2Hx9
         3JG3XpwC6tlOfDEXLzWSjfDpSV3JRDxJUR1e1venkKLbpZmSvzh2wVHWnZ7pZ0Ddjmf1
         Wapw==
X-Forwarded-Encrypted: i=1; AJvYcCWQqrQk4xPLhsLDUoDgeCe5sYnDRLaKwhoLiBKemKOnBnpZX/mZFo4A6G7ZXLxQHE20Tie7e00=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlXx+ZtmjKyadKerNmN8BQqBlAfQ7TZsyc/vJOfYorLhCpy62W
	jOpKnoA+WSOKBAxnqUOylaI4ZhDACsZDVlde6DWHpFKK8MPbG1aIEK+AJ2xk
X-Gm-Gg: ASbGncsDiOS1SZwfyiu6pN5XCdWgprmkTQzfESApNaU3lB8/en045jyjZq2PCvfR51x
	iICyYEPLYtTJVBR7Cqtkec47MJbE7uaiSqf8HDJKnr9WFObJAq0DZ4uKmo3LGwZzwk3vtR68DFh
	KuWYT7oL4oqgOy7Fea41ZFpvRY3PD5/d2YoEnuHSNja+VA08ZgdBEUMftpsHLQC0qclkAg2r6x+
	IlMN0u+JS3n9axb9rG3MLaDxs9FqgelU4lKpXGfKsVqzzoovZENoTiFwaarr+Kgy73tZEd7borE
	8026EDgXpADe4NGy3NG4BY1a0yeK+QYGIsPVIgNjBMw0XNUPN8haWZ2tLhUAIHQOTmIu14uA0Bj
	PqoHeuylqaA8QvEmq2QkpKhvwIkXbqCoseNgBTXMv+lTu4kzMFbAP9cF9PxPXu4g9C9xDkgTrzm
	EEP1se/kBI2O3vGlKFHHGnQSwRIqHcIBMiG48mIi1VPxLwi/TZZtHM8tQ/7GQzF7Pa+wEbUP0Jg
	L5ZY2OqQMOjL4aad6HjfAx8gDt5BMrWqZ87u3Z+hUDIjvv1fyrlRlKq
X-Google-Smtp-Source: AGHT+IF5JCtklD0Z5nhX2pv4gb9c84HisVgH12UrMW1XlhYUWATu7FlxOV2cH4d/NH1MRjy+R96MSw==
X-Received: by 2002:a17:902:ce12:b0:295:592f:9496 with SMTP id d9443c01a7336-297c00dc1acmr1933505ad.20.1762447028516;
        Thu, 06 Nov 2025 08:37:08 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650968269sm33056875ad.17.2025.11.06.08.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:37:08 -0800 (PST)
Date: Thu, 6 Nov 2025 08:37:07 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, donald.hunter@gmail.com, netdev@vger.kernel.org,
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
	horms@kernel.org, sdf@fomichev.me, joe@dama.to, jstancek@redhat.com
Subject: Re: [PATCH net-next 2/5] tools: ynltool: create skeleton for the C
 command
Message-ID: <aQzOs-0tFbGJOwgL@mini-arch>
References: <20251104232348.1954349-1-kuba@kernel.org>
 <20251104232348.1954349-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251104232348.1954349-3-kuba@kernel.org>

On 11/04, Jakub Kicinski wrote:
> Based on past discussions it seems like integration of YNL into
> iproute2 is unlikely. YNL itself is not great as a C library,
> since it has no backward compat (we routinely change types).
> 
> Most of the operations can be performed with the generic Python
> CLI directly. There is, however, a handful of operations where
> summarization of kernel output is very useful (mostly related
> to stats: page-pool, qstat).
> 
> Create a command (inspired by bpftool, I think it stood the test
> of time reasonably well) to be able to plug the subcommands into.
> 
> Link: https://lore.kernel.org/1754895902-8790-1-git-send-email-ernis@linux.microsoft.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/net/ynl/Makefile              |   3 +-
>  tools/net/ynl/ynltool/Makefile      |  44 +++++
>  tools/net/ynl/ynltool/json_writer.h |  75 ++++++++
>  tools/net/ynl/ynltool/main.h        |  62 ++++++
>  tools/net/ynl/ynltool/json_writer.c | 288 ++++++++++++++++++++++++++++
>  tools/net/ynl/ynltool/main.c        | 240 +++++++++++++++++++++++
>  tools/net/ynl/ynltool/.gitignore    |   1 +
>  7 files changed, 712 insertions(+), 1 deletion(-)
>  create mode 100644 tools/net/ynl/ynltool/Makefile
>  create mode 100644 tools/net/ynl/ynltool/json_writer.h
>  create mode 100644 tools/net/ynl/ynltool/main.h
>  create mode 100644 tools/net/ynl/ynltool/json_writer.c
>  create mode 100644 tools/net/ynl/ynltool/main.c
>  create mode 100644 tools/net/ynl/ynltool/.gitignore
> 
> diff --git a/tools/net/ynl/Makefile b/tools/net/ynl/Makefile
> index 211df5a93ad9..31ed20c0f3f8 100644
> --- a/tools/net/ynl/Makefile
> +++ b/tools/net/ynl/Makefile
> @@ -12,10 +12,11 @@ endif
>  libdir  ?= $(prefix)/$(libdir_relative)
>  includedir ?= $(prefix)/include
>  
> -SUBDIRS = lib generated samples
> +SUBDIRS = lib generated samples ynltool
>  
>  all: $(SUBDIRS) libynl.a
>  
> +ynltool: | lib generated libynl.a
>  samples: | lib generated
>  libynl.a: | lib generated
>  	@echo -e "\tAR $@"
> diff --git a/tools/net/ynl/ynltool/Makefile b/tools/net/ynl/ynltool/Makefile
> new file mode 100644
> index 000000000000..ce27dc691ffe
> --- /dev/null
> +++ b/tools/net/ynl/ynltool/Makefile
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +include ../Makefile.deps
> +
> +INSTALL	?= install
> +prefix  ?= /usr
> +
> +CC := gcc
> +CFLAGS := -Wall -Wextra -Werror -O2
> +ifeq ("$(DEBUG)","1")
> +  CFLAGS += -g -fsanitize=address -fsanitize=leak -static-libasan
> +endif
> +CFLAGS += -I../lib
> +
> +SRCS := $(wildcard *.c)
> +OBJS := $(patsubst %.c,$(OUTPUT)%.o,$(SRCS))
> +
> +YNLTOOL := $(OUTPUT)ynltool
> +
> +include $(wildcard *.d)
> +
> +all: $(YNLTOOL)
> +
> +$(YNLTOOL): $(OBJS)
> +	@echo -e "\tLINK $@"
> +	@$(CC) $(CFLAGS) -o $@ $(OBJS)
> +
> +%.o: %.c main.h json_writer.h
> +	@echo -e "\tCC $@"
> +	@$(COMPILE.c) -MMD -c -o $@ $<
> +
> +clean:
> +	rm -f *.o *.d *~
> +
> +distclean: clean
> +	rm -f $(YNLTOOL)
> +
> +bindir ?= /usr/bin
> +
> +install: $(YNLTOOL)
> +	install -m 0755 $(YNLTOOL) $(DESTDIR)$(bindir)/$(YNLTOOL)
> +
> +.PHONY: all clean distclean
> +.DEFAULT_GOAL=all
> diff --git a/tools/net/ynl/ynltool/json_writer.h b/tools/net/ynl/ynltool/json_writer.h
> new file mode 100644
> index 000000000000..0f1e63c88f6a
> --- /dev/null
> +++ b/tools/net/ynl/ynltool/json_writer.h
> @@ -0,0 +1,75 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Simple streaming JSON writer
> + *
> + * This takes care of the annoying bits of JSON syntax like the commas
> + * after elements
> + *
> + * Authors:	Stephen Hemminger <stephen@networkplumber.org>
> + */
> +
> +#ifndef _JSON_WRITER_H_
> +#define _JSON_WRITER_H_
> +
> +#include <stdbool.h>
> +#include <stdint.h>
> +#include <stdarg.h>
> +#include <stdio.h>
> +
> +/* Opaque class structure */
> +typedef struct json_writer json_writer_t;
> +
> +/* Create a new JSON stream */
> +json_writer_t *jsonw_new(FILE *f);
> +/* End output to JSON stream */
> +void jsonw_destroy(json_writer_t **self_p);
> +
> +/* Cause output to have pretty whitespace */
> +void jsonw_pretty(json_writer_t *self, bool on);
> +
> +/* Reset separator to create new JSON */
> +void jsonw_reset(json_writer_t *self);
> +
> +/* Add property name */
> +void jsonw_name(json_writer_t *self, const char *name);
> +
> +/* Add value  */
> +void __attribute__((format(printf, 2, 0))) jsonw_vprintf_enquote(json_writer_t *self,
> +								 const char *fmt,
> +								 va_list ap);
> +void __attribute__((format(printf, 2, 3))) jsonw_printf(json_writer_t *self,
> +							const char *fmt, ...);
> +void jsonw_string(json_writer_t *self, const char *value);
> +void jsonw_bool(json_writer_t *self, bool value);
> +void jsonw_float(json_writer_t *self, double number);
> +void jsonw_float_fmt(json_writer_t *self, const char *fmt, double num);
> +void jsonw_uint(json_writer_t *self, uint64_t number);
> +void jsonw_hu(json_writer_t *self, unsigned short number);
> +void jsonw_int(json_writer_t *self, int64_t number);
> +void jsonw_null(json_writer_t *self);
> +void jsonw_lluint(json_writer_t *self, unsigned long long int num);
> +
> +/* Useful Combinations of name and value */
> +void jsonw_string_field(json_writer_t *self, const char *prop, const char *val);
> +void jsonw_bool_field(json_writer_t *self, const char *prop, bool value);
> +void jsonw_float_field(json_writer_t *self, const char *prop, double num);
> +void jsonw_uint_field(json_writer_t *self, const char *prop, uint64_t num);
> +void jsonw_hu_field(json_writer_t *self, const char *prop, unsigned short num);
> +void jsonw_int_field(json_writer_t *self, const char *prop, int64_t num);
> +void jsonw_null_field(json_writer_t *self, const char *prop);
> +void jsonw_lluint_field(json_writer_t *self, const char *prop,
> +			unsigned long long int num);
> +void jsonw_float_field_fmt(json_writer_t *self, const char *prop,
> +			   const char *fmt, double val);
> +
> +/* Collections */
> +void jsonw_start_object(json_writer_t *self);
> +void jsonw_end_object(json_writer_t *self);
> +
> +void jsonw_start_array(json_writer_t *self);
> +void jsonw_end_array(json_writer_t *self);
> +
> +/* Override default exception handling */
> +typedef void (jsonw_err_handler_fn)(const char *);
> +
> +#endif /* _JSON_WRITER_H_ */
> diff --git a/tools/net/ynl/ynltool/main.h b/tools/net/ynl/ynltool/main.h
> new file mode 100644
> index 000000000000..f4a70acf2085
> --- /dev/null
> +++ b/tools/net/ynl/ynltool/main.h
> @@ -0,0 +1,62 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/* Copyright (C) 2017-2018 Netronome Systems, Inc. */
> +/* Copyright Meta Platforms, Inc. and affiliates */
> +
> +#ifndef __YNLTOOL_H
> +#define __YNLTOOL_H
> +
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE
> +#endif
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <errno.h>
> +#include <string.h>
> +
> +#include "json_writer.h"
> +
> +#define NEXT_ARG()	({ argc--; argv++; if (argc < 0) usage(); })
> +#define NEXT_ARGP()	({ (*argc)--; (*argv)++; if (*argc < 0) usage(); })
> +#define BAD_ARG()	({ p_err("what is '%s'?", *argv); -1; })
> +#define GET_ARG()	({ argc--; *argv++; })
> +#define REQ_ARGS(cnt)							\
> +	({								\
> +		int _cnt = (cnt);					\
> +		bool _res;						\
> +									\
> +		if (argc < _cnt) {					\
> +			p_err("'%s' needs at least %d arguments, %d found", \
> +			      argv[-1], _cnt, argc);			\
> +			_res = false;					\
> +		} else {						\
> +			_res = true;					\
> +		}							\
> +		_res;							\
> +	})
> +
> +#define HELP_SPEC_OPTIONS						\
> +	"OPTIONS := { {-j|--json} [{-p|--pretty}] }"
> +
> +extern const char *bin_name;
> +
> +extern json_writer_t *json_wtr;
> +extern bool json_output;
> +extern bool pretty_output;
> +
> +void __attribute__((format(printf, 1, 2))) p_err(const char *fmt, ...);
> +void __attribute__((format(printf, 1, 2))) p_info(const char *fmt, ...);
> +
> +bool is_prefix(const char *pfx, const char *str);
> +int detect_common_prefix(const char *arg, ...);
> +void usage(void) __attribute__((noreturn));
> +
> +struct cmd {
> +	const char *cmd;
> +	int (*func)(int argc, char **argv);
> +};
> +
> +int cmd_select(const struct cmd *cmds, int argc, char **argv,
> +	       int (*help)(int argc, char **argv));
> +
> +#endif /* __YNLTOOL_H */
> diff --git a/tools/net/ynl/ynltool/json_writer.c b/tools/net/ynl/ynltool/json_writer.c
> new file mode 100644
> index 000000000000..c8685e592cd3
> --- /dev/null
> +++ b/tools/net/ynl/ynltool/json_writer.c
> @@ -0,0 +1,288 @@
> +// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
> +/*
> + * Simple streaming JSON writer
> + *
> + * This takes care of the annoying bits of JSON syntax like the commas
> + * after elements
> + *
> + * Authors:	Stephen Hemminger <stephen@networkplumber.org>
> + */
> +
> +#include <stdio.h>
> +#include <stdbool.h>
> +#include <stdarg.h>
> +#include <assert.h>
> +#include <malloc.h>
> +#include <inttypes.h>
> +#include <stdint.h>
> +
> +#include "json_writer.h"
> +
> +struct json_writer {
> +	FILE		*out;
> +	unsigned	depth;
> +	bool		pretty;
> +	char		sep;
> +};
> +
> +static void jsonw_indent(json_writer_t *self)
> +{
> +	unsigned i;
> +	for (i = 0; i < self->depth; ++i)
> +		fputs("    ", self->out);
> +}
> +
> +static void jsonw_eol(json_writer_t *self)
> +{
> +	if (!self->pretty)
> +		return;
> +
> +	putc('\n', self->out);
> +	jsonw_indent(self);
> +}
> +
> +static void jsonw_eor(json_writer_t *self)
> +{
> +	if (self->sep != '\0')
> +		putc(self->sep, self->out);
> +	self->sep = ',';
> +}
> +
> +static void jsonw_puts(json_writer_t *self, const char *str)
> +{
> +	putc('"', self->out);
> +	for (; *str; ++str)
> +		switch (*str) {
> +		case '\t':
> +			fputs("\\t", self->out);
> +			break;
> +		case '\n':
> +			fputs("\\n", self->out);
> +			break;
> +		case '\r':
> +			fputs("\\r", self->out);
> +			break;
> +		case '\f':
> +			fputs("\\f", self->out);
> +			break;
> +		case '\b':
> +			fputs("\\b", self->out);
> +			break;
> +		case '\\':
> +			fputs("\\\\", self->out);
> +			break;
> +		case '"':
> +			fputs("\\\"", self->out);
> +			break;
> +		default:
> +			putc(*str, self->out);
> +		}
> +	putc('"', self->out);
> +}
> +
> +json_writer_t *jsonw_new(FILE *f)
> +{
> +	json_writer_t *self = malloc(sizeof(*self));
> +	if (self) {
> +		self->out = f;
> +		self->depth = 0;
> +		self->pretty = false;
> +		self->sep = '\0';
> +	}
> +	return self;
> +}
> +
> +void jsonw_destroy(json_writer_t **self_p)
> +{
> +	json_writer_t *self = *self_p;
> +
> +	assert(self->depth == 0);
> +	fputs("\n", self->out);
> +	fflush(self->out);
> +	free(self);
> +	*self_p = NULL;
> +}
> +
> +void jsonw_pretty(json_writer_t *self, bool on)
> +{
> +	self->pretty = on;
> +}
> +
> +void jsonw_reset(json_writer_t *self)
> +{
> +	assert(self->depth == 0);
> +	self->sep = '\0';
> +}
> +
> +static void jsonw_begin(json_writer_t *self, int c)
> +{
> +	jsonw_eor(self);
> +	putc(c, self->out);
> +	++self->depth;
> +	self->sep = '\0';
> +}
> +
> +static void jsonw_end(json_writer_t *self, int c)
> +{
> +	assert(self->depth > 0);
> +
> +	--self->depth;
> +	if (self->sep != '\0')
> +		jsonw_eol(self);
> +	putc(c, self->out);
> +	self->sep = ',';
> +}
> +
> +void jsonw_name(json_writer_t *self, const char *name)
> +{
> +	jsonw_eor(self);
> +	jsonw_eol(self);
> +	self->sep = '\0';
> +	jsonw_puts(self, name);
> +	putc(':', self->out);
> +	if (self->pretty)
> +		putc(' ', self->out);
> +}
> +
> +void jsonw_vprintf_enquote(json_writer_t *self, const char *fmt, va_list ap)
> +{
> +	jsonw_eor(self);
> +	putc('"', self->out);
> +	vfprintf(self->out, fmt, ap);
> +	putc('"', self->out);
> +}
> +
> +void jsonw_printf(json_writer_t *self, const char *fmt, ...)
> +{
> +	va_list ap;
> +
> +	va_start(ap, fmt);
> +	jsonw_eor(self);
> +	vfprintf(self->out, fmt, ap);
> +	va_end(ap);
> +}
> +
> +void jsonw_start_object(json_writer_t *self)
> +{
> +	jsonw_begin(self, '{');
> +}
> +
> +void jsonw_end_object(json_writer_t *self)
> +{
> +	jsonw_end(self, '}');
> +}
> +
> +void jsonw_start_array(json_writer_t *self)
> +{
> +	jsonw_begin(self, '[');
> +}
> +
> +void jsonw_end_array(json_writer_t *self)
> +{
> +	jsonw_end(self, ']');
> +}
> +
> +void jsonw_string(json_writer_t *self, const char *value)
> +{
> +	jsonw_eor(self);
> +	jsonw_puts(self, value);
> +}
> +
> +void jsonw_bool(json_writer_t *self, bool val)
> +{
> +	jsonw_printf(self, "%s", val ? "true" : "false");
> +}
> +
> +void jsonw_null(json_writer_t *self)
> +{
> +	jsonw_printf(self, "null");
> +}
> +
> +void jsonw_float_fmt(json_writer_t *self, const char *fmt, double num)
> +{
> +	jsonw_printf(self, fmt, num);
> +}
> +
> +void jsonw_float(json_writer_t *self, double num)
> +{
> +	jsonw_printf(self, "%g", num);
> +}
> +
> +void jsonw_hu(json_writer_t *self, unsigned short num)
> +{
> +	jsonw_printf(self, "%hu", num);
> +}
> +
> +void jsonw_uint(json_writer_t *self, uint64_t num)
> +{
> +	jsonw_printf(self, "%"PRIu64, num);
> +}
> +
> +void jsonw_lluint(json_writer_t *self, unsigned long long int num)
> +{
> +	jsonw_printf(self, "%llu", num);
> +}
> +
> +void jsonw_int(json_writer_t *self, int64_t num)
> +{
> +	jsonw_printf(self, "%"PRId64, num);
> +}
> +
> +void jsonw_string_field(json_writer_t *self, const char *prop, const char *val)
> +{
> +	jsonw_name(self, prop);
> +	jsonw_string(self, val);
> +}
> +
> +void jsonw_bool_field(json_writer_t *self, const char *prop, bool val)
> +{
> +	jsonw_name(self, prop);
> +	jsonw_bool(self, val);
> +}
> +
> +void jsonw_float_field(json_writer_t *self, const char *prop, double val)
> +{
> +	jsonw_name(self, prop);
> +	jsonw_float(self, val);
> +}
> +
> +void jsonw_float_field_fmt(json_writer_t *self,
> +			   const char *prop,
> +			   const char *fmt,
> +			   double val)
> +{
> +	jsonw_name(self, prop);
> +	jsonw_float_fmt(self, fmt, val);
> +}
> +
> +void jsonw_uint_field(json_writer_t *self, const char *prop, uint64_t num)
> +{
> +	jsonw_name(self, prop);
> +	jsonw_uint(self, num);
> +}
> +
> +void jsonw_hu_field(json_writer_t *self, const char *prop, unsigned short num)
> +{
> +	jsonw_name(self, prop);
> +	jsonw_hu(self, num);
> +}
> +
> +void jsonw_lluint_field(json_writer_t *self,
> +			const char *prop,
> +			unsigned long long int num)
> +{
> +	jsonw_name(self, prop);
> +	jsonw_lluint(self, num);
> +}
> +
> +void jsonw_int_field(json_writer_t *self, const char *prop, int64_t num)
> +{
> +	jsonw_name(self, prop);
> +	jsonw_int(self, num);
> +}
> +
> +void jsonw_null_field(json_writer_t *self, const char *prop)
> +{
> +	jsonw_name(self, prop);
> +	jsonw_null(self);
> +}
> diff --git a/tools/net/ynl/ynltool/main.c b/tools/net/ynl/ynltool/main.c
> new file mode 100644
> index 000000000000..c5047fad50cf
> --- /dev/null
> +++ b/tools/net/ynl/ynltool/main.c
> @@ -0,0 +1,240 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/* Copyright (C) 2017-2018 Netronome Systems, Inc. */
> +/* Copyright Meta Platforms, Inc. and affiliates */
> +
> +#include <ctype.h>
> +#include <errno.h>
> +#include <getopt.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <stdarg.h>
> +
> +#include "main.h"
> +
> +const char *bin_name;
> +static int last_argc;
> +static char **last_argv;
> +static int (*last_do_help)(int argc, char **argv);
> +json_writer_t *json_wtr;
> +bool pretty_output;
> +bool json_output;
> +
> +static void __attribute__((noreturn)) clean_and_exit(int i)
> +{
> +	if (json_output)
> +		jsonw_destroy(&json_wtr);
> +
> +	exit(i);
> +}
> +
> +void usage(void)
> +{
> +	last_do_help(last_argc - 1, last_argv + 1);
> +
> +	clean_and_exit(-1);
> +}
> +
> +static int do_help(int argc __attribute__((unused)),
> +		   char **argv __attribute__((unused)))
> +{
> +	if (json_output) {
> +		jsonw_null(json_wtr);
> +		return 0;
> +	}
> +
> +	fprintf(stderr,
> +		"Usage: %s [OPTIONS] OBJECT { COMMAND | help }\n"
> +		"       %s version\n"
> +		"\n"
> +		"       OBJECT := { }\n"
> +		"       " HELP_SPEC_OPTIONS "\n"
> +		"",
> +		bin_name, bin_name);
> +
> +	return 0;
> +}
> +
> +static int do_version(int argc __attribute__((unused)),
> +		      char **argv __attribute__((unused)))
> +{
> +	if (json_output) {
> +		jsonw_start_object(json_wtr);
> +		jsonw_name(json_wtr, "version");
> +		jsonw_printf(json_wtr, "\"0.1.0\"");

Any reason not to start with something like commit 4bfe3bd3cc35
("tools/bpftool: use version from the kernel source tree") here?
Otherwise I doubt 0.1.0 will be changed ever.

