Return-Path: <netdev+bounces-213807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2352B26CDD
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 18:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E3693A63E3
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 16:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04FD2DECD3;
	Thu, 14 Aug 2025 16:44:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E74B21B9FE;
	Thu, 14 Aug 2025 16:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755189857; cv=none; b=Kl94SFi9f4W4wPsnE3GBtMShnB+AIgfYlau1S/oN9a01LV2nBuIJvtpa/qfq6UhnghRXXATzcXib+LVXUB+rCvpAvxBFNTCOCN9zdaseXEuBofA9Vi5X2CBVbsVAvy9YLxXoxH2mDblxRgxOW6PnxB0QjtYJTuhJGZR1t00FXIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755189857; c=relaxed/simple;
	bh=Pi12NCjVNa0Ym+EGtm5xt0Js6GSAC2n7/7dVT3rMZoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gmBsSbftWrk35w+iu8cxrLZmNodInk2gJerEkUVbeKuDd9KZUAK8nKETmw/mvuLxdlzPGCHJ+E3meKo6Kg2mmsb7FX6kKjysDRMk4mBq+ac+utX8Us/CXaLX3OaN8N/j3CZ5FSJbeR9pteh4n+O2vtWd8FavcljUzwiqqKXPviU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-323266d2d9eso1019621a91.0;
        Thu, 14 Aug 2025 09:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755189854; x=1755794654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n6Ds2V8iI29lENVwGkMXUhsBybo0WpVnyyaXg0iPlVc=;
        b=W+t5I/xpTpXvvkstmhGzTCR0X6z/Je8rKE8JNDagkEvNmM6Et2ah5+8xrZP9SjEYIu
         3pls2LlqArW5BDI0Y/9T98c9T5i2q1gl+V4ukafW5SKKLu+M1g1ljPv7dcnF2gQ/JDE8
         zUQcMjyukRLewCRY7cPdT/JCIwvlBJUOOUORmtqrzAtMFe6SIsE6A7+HpqibPxTDqz2r
         0GavYUHsk0N9tUYCfvjKhBjP/jNcVxacsH6NwIhoE6jh9Oj2NM2PG2d9S4/T9vg1O1RD
         icndY4XS2skykSZZQbY1rnOKnfPuiABzT4D3+PitEkK+e/28RAkKYVbFXA7H6gqWvOxt
         JJYA==
X-Forwarded-Encrypted: i=1; AJvYcCVZP0IfP+Sej9NZNhQSuRKpeh7yUz3b/TLYzVOEmzyUUQUij+qexQ3qM3fyhoQbaY2YPPY7kxuTNrC9saQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxds0PY0YcxCUog5HvinyvVD3m1bemsfzoRtLNmOWM2MfRl5TN0
	o3c2E4cV2qJ8oizNh60/E2E9sTo+1z9XMXOCXR1NCSv3+71iSWZy5vnlu2Ih
X-Gm-Gg: ASbGncsQMjlH3PhvpGY+JyeGIXE/dxDRT+Khww21yLiRj/qwu0w/XCoqyn54vKVl693
	+VIbPfQ8FmY83xeEzHAvOLe0sfjXiKp1dFp55+Uc6+UY3UGD7HnkirxZEaV8CB3hx+TZgp5Kscc
	/8c0aBlncqH0h5SgvCn9jOY3f46VcsiN8J/PQWhSgL2qRK+hMXCV2DU5GFPFjcgv/SQXoywOJ+s
	173SHeXb+82ZRs43Kq/QLxQi8X2FL221lRp6tZdUA6K0OYOtacT4rKvZKM+oah5JeulTM/NRqB9
	6rUbzWiI1T4q53m1QT9MYqhZSj7SxxkXVhNP9YquBceyfJPc/wCRjZjuK4JMcSjpiSP6IHG/ms7
	/8KdYtuNbuLpwdD7Rh03lOhkwJtqyNa2BBKbW5dYAu0RZ+9EpqffWwiBtw2k=
X-Google-Smtp-Source: AGHT+IEfWn7TjnKHS0RiH5DoZStYJK0DFqD4OC/pvUjtCfhkz0jsuZUx0Us7RAkcm9ZX0vY7n2Ukwg==
X-Received: by 2002:a17:90b:1f85:b0:31f:867:d6b4 with SMTP id 98e67ed59e1d1-323279c8531mr6918867a91.10.1755189854415;
        Thu, 14 Aug 2025 09:44:14 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3232ae14f6dsm1029231a91.6.2025.08.14.09.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 09:44:14 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	horms@kernel.org,
	jstancek@redhat.com,
	sdf@fomichev.me,
	jacob.e.keller@intel.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] tools: ynl: make ynl.c more c++ friendly
Date: Thu, 14 Aug 2025 09:44:13 -0700
Message-ID: <20250814164413.1258893-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compiling ynl.c in a C++ code base requires invoking C compiler and
using extern "C" for the headers. To make it easier, we can add
small changes to the ynl.c file to make it palatable to the native
C++ compiler. The changes are:
- avoid using void* pointer arithmetic, use char* instead
- avoid implicit void* type casts, add c-style explicit casts
- avoid implicit int->enum type casts, add c-style explicit casts
- avoid anonymous structs (for type casts)
- namespacify cpp version, this should let us compile both ynl.c
  as c and ynl.c as cpp in the same binary (YNL_CPP can be used
  to enable/disable namespacing)

Also add test_cpp rule to make sure ynl.c won't break C++ in the future.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/net/ynl/lib/Makefile   |  5 +++-
 tools/net/ynl/lib/ynl-priv.h | 11 ++++++-
 tools/net/ynl/lib/ynl.c      | 58 +++++++++++++++++++++---------------
 tools/net/ynl/lib/ynl.h      | 19 +++++++++---
 4 files changed, 63 insertions(+), 30 deletions(-)

diff --git a/tools/net/ynl/lib/Makefile b/tools/net/ynl/lib/Makefile
index 4b2b98704ff9..94f8dc4a31d1 100644
--- a/tools/net/ynl/lib/Makefile
+++ b/tools/net/ynl/lib/Makefile
@@ -11,7 +11,7 @@ OBJS=$(patsubst %.c,%.o,${SRCS})
 
 include $(wildcard *.d)
 
-all: ynl.a
+all: ynl.a test_cpp
 
 ynl.a: $(OBJS)
 	@echo -e "\tAR $@"
@@ -23,6 +23,9 @@ ynl.a: $(OBJS)
 distclean: clean
 	rm -f *.a
 
+test_cpp: ynl.c
+	$(COMPILE.cpp) -DYNL_CPP -o ynl.cc.o $<
+
 %.o: %.c
 	$(COMPILE.c) -MMD -c -o $@ $<
 
diff --git a/tools/net/ynl/lib/ynl-priv.h b/tools/net/ynl/lib/ynl-priv.h
index 824777d7e05e..1dbb14e760e6 100644
--- a/tools/net/ynl/lib/ynl-priv.h
+++ b/tools/net/ynl/lib/ynl-priv.h
@@ -6,6 +6,10 @@
 #include <stddef.h>
 #include <linux/types.h>
 
+#if defined(__cplusplus) && defined(YNL_CPP)
+namespace ynl_cpp {
+#endif
+
 struct ynl_parse_arg;
 
 /*
@@ -224,7 +228,7 @@ static inline void *ynl_attr_data_end(const struct nlattr *attr)
 
 #define ynl_attr_for_each_payload(start, len, attr)			\
 	for ((attr) = ynl_attr_first(start, len, 0); attr;		\
-	     (attr) = ynl_attr_next(start + len, attr))
+	     (attr) = ynl_attr_next((char *)start + len, attr))
 
 static inline struct nlattr *
 ynl_attr_if_good(const void *end, struct nlattr *attr)
@@ -467,4 +471,9 @@ ynl_attr_put_sint(struct nlmsghdr *nlh, __u16 type, __s64 data)
 	else
 		ynl_attr_put_s64(nlh, type, data);
 }
+
+#if defined(__cplusplus) && defined(YNL_CPP)
+} // namespace ynl_cpp
+#endif
+
 #endif
diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index 2a169c3c0797..9155b4d5b9f9 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -11,6 +11,10 @@
 
 #include "ynl.h"
 
+#if defined(__cplusplus) && defined(YNL_CPP)
+namespace ynl_cpp {
+#endif
+
 #define ARRAY_SIZE(arr)		(sizeof(arr) / sizeof(*arr))
 
 #define __yerr_msg(yse, _msg...)					\
@@ -23,13 +27,13 @@
 		}							\
 	})
 
-#define __yerr_code(yse, _code...)		\
-	({					\
-		struct ynl_error *_yse = (yse);	\
-						\
-		if (_yse) {			\
-			_yse->code = _code;	\
-		}				\
+#define __yerr_code(yse, _code...)				 \
+	({                                                       \
+		struct ynl_error *_yse = (yse);                  \
+								 \
+		if (_yse) {                                      \
+			_yse->code = (enum ynl_error_code)_code; \
+		}                                                \
 	})
 
 #define __yerr(yse, _code, _msg...)		\
@@ -149,7 +153,7 @@ ynl_err_walk(struct ynl_sock *ys, void *start, void *end, unsigned int off,
 		return n;
 	}
 
-	data_len = end - start;
+	data_len = (char *)end - (char *)start;
 
 	ynl_attr_for_each_payload(start, data_len, attr) {
 		astart_off = (char *)attr - (char *)start;
@@ -192,7 +196,7 @@ ynl_err_walk(struct ynl_sock *ys, void *start, void *end, unsigned int off,
 
 	off -= sizeof(struct nlattr);
 	start =  ynl_attr_data(attr);
-	end = start + ynl_attr_data_len(attr);
+	end = (char *)start + ynl_attr_data_len(attr);
 
 	return n + ynl_err_walk(ys, start, end, off, next_pol,
 				&str[n], str_sz - n, nest_pol);
@@ -325,12 +329,12 @@ ynl_ext_ack_check(struct ynl_sock *ys, const struct nlmsghdr *nlh,
 static int
 ynl_cb_error(const struct nlmsghdr *nlh, struct ynl_parse_arg *yarg)
 {
-	const struct nlmsgerr *err = ynl_nlmsg_data(nlh);
+	const struct nlmsgerr *err = (struct nlmsgerr *)ynl_nlmsg_data(nlh);
 	unsigned int hlen;
 	int code;
 
 	code = err->error >= 0 ? err->error : -err->error;
-	yarg->ys->err.code = code;
+	yarg->ys->err.code = (enum ynl_error_code)code;
 	errno = code;
 
 	hlen = sizeof(*err);
@@ -348,7 +352,7 @@ static int ynl_cb_done(const struct nlmsghdr *nlh, struct ynl_parse_arg *yarg)
 
 	err = *(int *)NLMSG_DATA(nlh);
 	if (err < 0) {
-		yarg->ys->err.code = -err;
+		yarg->ys->err.code = (enum ynl_error_code)-err;
 		errno = -err;
 
 		ynl_ext_ack_check(yarg->ys, nlh, sizeof(int));
@@ -366,7 +370,7 @@ int ynl_attr_validate(struct ynl_parse_arg *yarg, const struct nlattr *attr)
 	unsigned int type, len;
 	unsigned char *data;
 
-	data = ynl_attr_data(attr);
+	data = (unsigned char *)ynl_attr_data(attr);
 	len = ynl_attr_data_len(attr);
 	type = ynl_attr_type(attr);
 	if (type > yarg->rsp_policy->max_attr) {
@@ -463,7 +467,7 @@ int ynl_submsg_failed(struct ynl_parse_arg *yarg, const char *field_name,
 
 static void ynl_err_reset(struct ynl_sock *ys)
 {
-	ys->err.code = 0;
+	ys->err.code = YNL_ERROR_NONE;
 	ys->err.attr_offs = 0;
 	ys->err.msg[0] = 0;
 }
@@ -643,8 +647,8 @@ ynl_get_family_info_mcast(struct ynl_sock *ys, const struct nlattr *mcasts)
 	if (!ys->n_mcast_groups)
 		return 0;
 
-	ys->mcast_groups = calloc(ys->n_mcast_groups,
-				  sizeof(*ys->mcast_groups));
+	ys->mcast_groups = (struct ynl_sock_mcast *)calloc(
+		ys->n_mcast_groups, sizeof(*ys->mcast_groups));
 	if (!ys->mcast_groups)
 		return YNL_PARSE_CB_ERROR;
 
@@ -741,7 +745,8 @@ ynl_sock_create(const struct ynl_family *yf, struct ynl_error *yse)
 	int sock_type;
 	int one = 1;
 
-	ys = malloc(sizeof(*ys) + 2 * YNL_SOCKET_BUFFER_SIZE);
+	ys = (struct ynl_sock *)malloc(sizeof(*ys) +
+				       2 * YNL_SOCKET_BUFFER_SIZE);
 	if (!ys)
 		return NULL;
 	memset(ys, 0, sizeof(*ys));
@@ -878,7 +883,7 @@ static int ynl_ntf_parse(struct ynl_sock *ys, const struct nlmsghdr *nlh)
 	} else {
 		struct genlmsghdr *gehdr;
 
-		gehdr = ynl_nlmsg_data(nlh);
+		gehdr = (struct genlmsghdr *)ynl_nlmsg_data(nlh);
 		cmd = gehdr->cmd;
 	}
 
@@ -888,7 +893,7 @@ static int ynl_ntf_parse(struct ynl_sock *ys, const struct nlmsghdr *nlh)
 	if (!info->cb)
 		return YNL_PARSE_CB_ERROR;
 
-	rsp = calloc(1, info->alloc_sz);
+	rsp = (struct ynl_ntf_base_type *)calloc(1, info->alloc_sz);
 	rsp->free = info->free;
 	yarg.data = rsp->data;
 	yarg.rsp_policy = info->policy;
@@ -933,7 +938,8 @@ int ynl_ntf_check(struct ynl_sock *ys)
 
 /* YNL specific helpers used by the auto-generated code */
 
-struct ynl_dump_list_type *YNL_LIST_END = (void *)(0xb4d123);
+struct ynl_dump_list_type *YNL_LIST_END =
+	(struct ynl_dump_list_type *)(void *)(0xb4d123);
 
 void ynl_error_unknown_notification(struct ynl_sock *ys, __u8 cmd)
 {
@@ -962,7 +968,7 @@ ynl_check_alien(struct ynl_sock *ys, const struct nlmsghdr *nlh, __u32 rsp_cmd)
 			return -1;
 		}
 
-		gehdr = ynl_nlmsg_data(nlh);
+		gehdr = (struct genlmsghdr *)ynl_nlmsg_data(nlh);
 		if (gehdr->cmd != rsp_cmd)
 			return ynl_ntf_parse(ys, nlh);
 	}
@@ -973,7 +979,7 @@ ynl_check_alien(struct ynl_sock *ys, const struct nlmsghdr *nlh, __u32 rsp_cmd)
 static
 int ynl_req_trampoline(const struct nlmsghdr *nlh, struct ynl_parse_arg *yarg)
 {
-	struct ynl_req_state *yrs = (void *)yarg;
+	struct ynl_req_state *yrs = (struct ynl_req_state *)yarg;
 	int ret;
 
 	ret = ynl_check_alien(yrs->yarg.ys, nlh, yrs->rsp_cmd);
@@ -1006,7 +1012,7 @@ int ynl_exec(struct ynl_sock *ys, struct nlmsghdr *req_nlh,
 static int
 ynl_dump_trampoline(const struct nlmsghdr *nlh, struct ynl_parse_arg *data)
 {
-	struct ynl_dump_state *ds = (void *)data;
+	struct ynl_dump_state *ds = (struct ynl_dump_state *)data;
 	struct ynl_dump_list_type *obj;
 	struct ynl_parse_arg yarg = {};
 	int ret;
@@ -1015,7 +1021,7 @@ ynl_dump_trampoline(const struct nlmsghdr *nlh, struct ynl_parse_arg *data)
 	if (ret)
 		return ret < 0 ? YNL_PARSE_CB_ERROR : YNL_PARSE_CB_OK;
 
-	obj = calloc(1, ds->alloc_sz);
+	obj = (struct ynl_dump_list_type *)calloc(1, ds->alloc_sz);
 	if (!obj)
 		return YNL_PARSE_CB_ERROR;
 
@@ -1066,3 +1072,7 @@ int ynl_exec_dump(struct ynl_sock *ys, struct nlmsghdr *req_nlh,
 	yds->first = ynl_dump_end(yds);
 	return -1;
 }
+
+#if defined(__cplusplus) && defined(YNL_CPP)
+} // namespace ynl_cpp
+#endif
diff --git a/tools/net/ynl/lib/ynl.h b/tools/net/ynl/lib/ynl.h
index db7c0591a63f..47a8652f056f 100644
--- a/tools/net/ynl/lib/ynl.h
+++ b/tools/net/ynl/lib/ynl.h
@@ -9,6 +9,10 @@
 
 #include "ynl-priv.h"
 
+#if defined(__cplusplus) && defined(YNL_CPP)
+namespace ynl_cpp {
+#endif
+
 enum ynl_error_code {
 	YNL_ERROR_NONE = 0,
 	__YNL_ERRNO_END = 4096,
@@ -56,6 +60,11 @@ struct ynl_family {
 	unsigned int ntf_info_size;
 };
 
+struct ynl_sock_mcast {
+	unsigned int id;
+	char name[GENL_NAMSIZ];
+};
+
 /**
  * struct ynl_sock - YNL wrapped netlink socket
  * @err: YNL error descriptor, cleared on every request.
@@ -71,10 +80,7 @@ struct ynl_sock {
 	__u16 family_id;
 
 	unsigned int n_mcast_groups;
-	struct {
-		unsigned int id;
-		char name[GENL_NAMSIZ];
-	} *mcast_groups;
+	struct ynl_sock_mcast *mcast_groups;
 
 	struct ynl_ntf_base_type *ntf_first;
 	struct ynl_ntf_base_type **ntf_last_next;
@@ -140,4 +146,9 @@ static inline bool ynl_has_ntf(struct ynl_sock *ys)
 struct ynl_ntf_base_type *ynl_ntf_dequeue(struct ynl_sock *ys);
 
 void ynl_ntf_free(struct ynl_ntf_base_type *ntf);
+
+#if defined(__cplusplus) && defined(YNL_CPP)
+} // namespace ynl_cpp
+#endif
+
 #endif
-- 
2.50.1


