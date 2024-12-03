Return-Path: <netdev+bounces-148474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B119E1D95
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 14:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87730B63347
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 12:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4281EE02F;
	Tue,  3 Dec 2024 12:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="Ah+vLnvZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F241E7679
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 12:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733230170; cv=none; b=Kn/mNO59XPSyojUL+wZnVNXFFarXEuWNNeIDBlIB+zV0WTBoQzyI9UsLpQNHi99NdE4qFwqt16KgKGDosNIywn17zbfxsg4gI04iNESzaB0Tfg+HRQnbwMYa+mhDMJlzcHdCDal1YJnw5B19xAHqyqnopL/094gy9MlbZ0xSb84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733230170; c=relaxed/simple;
	bh=EzxVMfb5epJBDOEa0AqFUbqqvRq+M48yRLx5Ym8HyR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LzmqBJtxg9WTKZNfKjM8YdqGyPyW+rtY0qcy3Q0cEiHw50fuVtC8nsPzevlpsKcDNy92DHj5lJDGSK2mkgmpz0g6uPCjo6b/WOLgLmJ8F1ntIcxmEDeOVpKdIpm/wq2kCvWHnf+YNvTL/Rk6vNSXHV9kw/guQzuBBkSZYa7gtUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=Ah+vLnvZ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d0cfb9fecaso4531808a12.2
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 04:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1733230166; x=1733834966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=71T3Td0FsXpr7aNeMggizgEb7JGX4xYtxFKIbd6ecOM=;
        b=Ah+vLnvZO0CgfVrlUSkbbAzqp726QXxUVhX4d8/5QPfJjg7NegitWQchlaTk2BPEpa
         Ex6sJE7eQRQ9AgNj049yWAYzj++cTOJ8z5/unu0MSmTHksmWqQyiTmYWkmKbrfmSTCm/
         CzUfD+qu5qmQCBqJEqo/3c599LdYd2BkrQs/qefkzN+LJS3MLGbMQWi2smcXxW9fNJJo
         fDTQb2vQh7UagNtDzIL5I6v5aZiB0vxr2KXwKprgdupnVHwkF6E2avmgrCkY32CWHZ+8
         gbw6DsdrQjyxrujsxHSw6tFyNqEEKDRHANhMXLFI87gGo8tdarZMJeLasLmR3AHcIXvp
         2s5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733230166; x=1733834966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=71T3Td0FsXpr7aNeMggizgEb7JGX4xYtxFKIbd6ecOM=;
        b=wGKK39Ru6/4YqBenT5iFUxV6SCQgVQNmsrP0ax+sSK3LscQ9A8Vi5wDDWgkNZb4+iO
         cB9jf4aZCyO511WZUHmR9/k4yyQ23t6QyIAxgu3SYSxebhrRyhei/IZFbg+IP/3GLQvO
         fUm1+XsMscmGryPpWH107u1oKakEKXcYz8MtzimprFbmgduwZkpI9ZaXc9CkcocXS1rm
         GErd7UVVFumFBCyc4QSdfcqRaIpoKpJuYRTPH0KNQDZOdTnODrMnISCS5N6UjYOhwrQX
         EXsON8+7C9xOA7dKiRx87goOf+MAI9/wX3FapDQcNN+TLgim2i1qpDEm86Us0hmWVdsF
         +Y2w==
X-Gm-Message-State: AOJu0YwItZisizwmS3KhRDTIQufJ3tV0/+XDShlcZzGLF/gxg34CnxzV
	iDNnKjy4UIqwGMJTzh34+scvnpIvj85Q9vhPlxbYyY/VkU28P4TAtzYHTMjIWEpTyhh+Z8oIPX/
	DV0ZOI0moO0F4KnUutj74ZLhA4SmUGS18WmnIlISKX8Y/U+v/uzjXDsbCqDn1E+1x3phQtta/vR
	W7VUFzE2aqC8unNOe4sjkQbCa83EDGYkc5VqdYmcVfyg==
X-Gm-Gg: ASbGncsjvtOh+e/u7Po5uij+lN42n0MC0AXFS+NhufPyuEaAtBhShVrNuzfK6ifvlqG
	7o+xJBkTckeCd1JgquKkS2IjBC8QgsGarHDNxn1CjGZNIhrEwD1bVU8wPseam3pP14Of8Oxir+L
	F0uhIjLcCChv5YoAUutk3SZtjEA9L0v/EzKcCNx/V2LRwwKdPcv2FKwY9iWzv4n5MfJUwglktkD
	SdQG+AU5VvLyth3J/4uUsWEDFprqd6ftXAimYvVegEoQW36UaSTVzIpYBIwXUdwMHFIfPOgGlvs
	CUINQBChKQ==
X-Google-Smtp-Source: AGHT+IFRtDhE3+9bEyC4eIuTUxBQX+t/LQZONrANHtN0oq4RL1QcT2E9OQKULQTe5jBWk5yTIO1amQ==
X-Received: by 2002:a05:6402:5107:b0:5d0:eb2d:db97 with SMTP id 4fb4d7f45d1cf-5d10cb80219mr2092879a12.25.1733230165647;
        Tue, 03 Dec 2024 04:49:25 -0800 (PST)
Received: from fedora.. (cpezg-94-253-146-235-cbl.xnet.hr. [94.253.146.235])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d0b4813332sm5224581a12.3.2024.12.03.04.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 04:49:24 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: netdev@vger.kernel.org,
	stephen@networkplumber.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	dsahern@kernel.org,
	jiri@resnulli.us,
	andrew@lunn.ch
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [iproute2-next] ip: link: rmnet: add support for flag handling
Date: Tue,  3 Dec 2024 13:47:59 +0100
Message-ID: <20241203124921.200637-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the current rmnet support to allow enabling or disabling
IFLA_RMNET_FLAGS via ip link as well as printing the current settings.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 ip/iplink_rmnet.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/ip/iplink_rmnet.c b/ip/iplink_rmnet.c
index 1d16440c..49d487cc 100644
--- a/ip/iplink_rmnet.c
+++ b/ip/iplink_rmnet.c
@@ -16,6 +16,10 @@ static void print_explain(FILE *f)
 {
 	fprintf(f,
 		"Usage: ... rmnet mux_id MUXID\n"
+		"		[ deaggregate { on | off } ]\n"
+		"		[ commands { on | off } ]\n"
+		"		[ qmapv4 { on | off } ]\n"
+		"		[ qmapv5 { on | off } ]\n"
 		"\n"
 		"MUXID := 1-254\n"
 	);
@@ -26,9 +30,16 @@ static void explain(void)
 	print_explain(stderr);
 }
 
+static int on_off(const char *msg, const char *arg)
+{
+	fprintf(stderr, "Error: argument of \"%s\" must be \"on\" or \"off\", not \"%s\"\n", msg, arg);
+	return -1;
+}
+
 static int rmnet_parse_opt(struct link_util *lu, int argc, char **argv,
 			   struct nlmsghdr *n)
 {
+	struct ifla_rmnet_flags flags = { 0 };
 	__u16 mux_id;
 
 	while (argc > 0) {
@@ -37,6 +48,48 @@ static int rmnet_parse_opt(struct link_util *lu, int argc, char **argv,
 			if (get_u16(&mux_id, *argv, 0))
 				invarg("mux_id is invalid", *argv);
 			addattr16(n, 1024, IFLA_RMNET_MUX_ID, mux_id);
+		} else if (matches(*argv, "deaggregate") == 0) {
+			NEXT_ARG();
+			flags.mask |= RMNET_FLAGS_INGRESS_DEAGGREGATION;
+			if (strcmp(*argv, "on") == 0)
+				flags.flags |= RMNET_FLAGS_INGRESS_DEAGGREGATION;
+			else if (strcmp(*argv, "off") == 0)
+				flags.flags &= RMNET_FLAGS_INGRESS_DEAGGREGATION;
+			else
+				return on_off("deaggregate", *argv);
+		} else if (matches(*argv, "commands") == 0) {
+			NEXT_ARG();
+			flags.mask |= RMNET_FLAGS_INGRESS_MAP_COMMANDS;
+			if (strcmp(*argv, "on") == 0)
+				flags.flags |= RMNET_FLAGS_INGRESS_MAP_COMMANDS;
+			else if (strcmp(*argv, "off") == 0)
+				flags.flags &= RMNET_FLAGS_INGRESS_MAP_COMMANDS;
+			else
+				return on_off("commands", *argv);
+		} else if (matches(*argv, "qmapv4") == 0) {
+			NEXT_ARG();
+			flags.mask |= RMNET_FLAGS_INGRESS_MAP_CKSUMV4;
+			flags.mask |= RMNET_FLAGS_EGRESS_MAP_CKSUMV4;
+			if (strcmp(*argv, "on") == 0) {
+				flags.flags |= RMNET_FLAGS_INGRESS_MAP_CKSUMV4;
+				flags.flags |= RMNET_FLAGS_EGRESS_MAP_CKSUMV4;
+			} else if (strcmp(*argv, "off") == 0) {
+				flags.flags &= RMNET_FLAGS_INGRESS_MAP_CKSUMV4;
+				flags.flags &= RMNET_FLAGS_EGRESS_MAP_CKSUMV4;
+			} else
+				return on_off("qmapv4", *argv);
+		} else if (matches(*argv, "qmapv5") == 0) {
+			NEXT_ARG();
+			flags.mask |= RMNET_FLAGS_INGRESS_MAP_CKSUMV5;
+			flags.mask |= RMNET_FLAGS_EGRESS_MAP_CKSUMV5;
+			if (strcmp(*argv, "on") == 0) {
+				flags.flags |= RMNET_FLAGS_INGRESS_MAP_CKSUMV5;
+				flags.flags |= RMNET_FLAGS_EGRESS_MAP_CKSUMV5;
+			} else if (strcmp(*argv, "off") == 0) {
+				flags.flags &= RMNET_FLAGS_INGRESS_MAP_CKSUMV5;
+				flags.flags &= RMNET_FLAGS_EGRESS_MAP_CKSUMV5;
+			} else
+				return on_off("qmapv5", *argv);
 		} else if (matches(*argv, "help") == 0) {
 			explain();
 			return -1;
@@ -48,11 +101,34 @@ static int rmnet_parse_opt(struct link_util *lu, int argc, char **argv,
 		argc--, argv++;
 	}
 
+	if (flags.mask)
+		addattr_l(n, 1024, IFLA_RMNET_FLAGS, &flags, sizeof(flags));
+
 	return 0;
 }
+static void rmnet_print_flags(FILE *fp, __u32 flags)
+{
+	open_json_array(PRINT_ANY, is_json_context() ? "flags" : "<");
+#define _PF(f)	if (flags & RMNET_FLAGS_##f) {				\
+		flags &= ~RMNET_FLAGS_##f;				\
+		print_string(PRINT_ANY, NULL, flags ? "%s," : "%s", #f); \
+	}
+	_PF(INGRESS_DEAGGREGATION);
+	_PF(INGRESS_MAP_COMMANDS);
+	_PF(INGRESS_MAP_CKSUMV4);
+	_PF(EGRESS_MAP_CKSUMV4);
+	_PF(INGRESS_MAP_CKSUMV5);
+	_PF(EGRESS_MAP_CKSUMV5);
+#undef _PF
+	if (flags)
+		print_hex(PRINT_ANY, NULL, "%x", flags);
+	close_json_array(PRINT_ANY, "> ");
+}
 
 static void rmnet_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 {
+	struct ifla_rmnet_flags *flags;
+
 	if (!tb)
 		return;
 
@@ -64,6 +140,13 @@ static void rmnet_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 		   "mux_id",
 		   "mux_id %u ",
 		   rta_getattr_u16(tb[IFLA_RMNET_MUX_ID]));
+
+	if (tb[IFLA_RMNET_FLAGS]) {
+		if (RTA_PAYLOAD(tb[IFLA_RMNET_FLAGS]) < sizeof(*flags))
+			return;
+		flags = RTA_DATA(tb[IFLA_RMNET_FLAGS]);
+		rmnet_print_flags(f, flags->flags);
+	}
 }
 
 static void rmnet_print_help(struct link_util *lu, int argc, char **argv,
-- 
2.47.1


