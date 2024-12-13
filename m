Return-Path: <netdev+bounces-151762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEB19F0CB9
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 13:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB6F281EF5
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA671CF7A2;
	Fri, 13 Dec 2024 12:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="RSJew3Ih"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E566B640
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 12:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734094306; cv=none; b=sZ61ZHQhReCkQa34L1GJfquWmJf6I9Z8QrIb1F83xzpt7qR/WtodaH8jYAB8Ed67l4jptUTqpDf5QkrTWUOdJSnBG8f7R+aUH9TkSewuv6u0M2lHNgsClUb6z7jAQjYRr59ArlqC0AT5qI/OuQ3IKU9E8rQ9OhHIeTklOL9VcO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734094306; c=relaxed/simple;
	bh=8o73yXLfR1LStQv/NJe6NDYPITlAxXCS66O0VuLcA+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kZp9X16HU/m1neoh3oQwH96SXYNrNU7gu+UCa+ii5lJWm9WrsD0mXiYrFoN35WEBLaBm9uRqAg0IzlUjB5QFZsWMe5Glla9xib80k/MJ8KvVwPjkBe2DFMCKXkyot8bv6RQBZi2b33uZDh6zvJTM5eSg/jbmjd+X1glaZpX7SPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=RSJew3Ih; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa6c0d1833eso292259966b.1
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 04:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1734094302; x=1734699102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DmK4ciQ8X3wOVnRZJtrxhIpLn8W+EsbHXQWjDvNDlvc=;
        b=RSJew3IhkDmy/MEbWMOVd9NJ8+Zd2oZqgGZaPN4iuuZ1Aih6ScAnlY/S2p9CQI4hUT
         k84/I4Xr3XAkcQUybgS08aDgEJRR/XpBkwQTGVuG0Sh0AZkV+vLGODC3NKBo+Ps20z+h
         TqxXWh4TH/RRg+cDGc+b0pIz0/Gm5u1VuYm6JVB29EC8sT/FiCXGlfjEdEJAIN0tOWeV
         oYnwp2KcFUfBGoCuLxkhkViX5Pu+0VyRbYz3fiHWboJD4QaIRcZuQlVzxWNyeVdpXeSo
         a4ztrtoWsUCuX4O7unw9TrtDwP/mOhTiX9gk4X1sL3fUojyeEeP8csYVJJ+bqOKZ33T6
         rYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734094302; x=1734699102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DmK4ciQ8X3wOVnRZJtrxhIpLn8W+EsbHXQWjDvNDlvc=;
        b=LDISam+Z9rpzlYBlyxQYrhvMNXHA5DmPxJc0idHVyV/cCxLhpvsZpk6k2Gm10yTefp
         Itaz1w4KgvWIyXzVoIgXuVZIDcKN5HFEXhMfcoNH+kwtpLq3/wXXjMFJA6vLzYlQBjWF
         ec9DaOPlbpETkzq9+dHb+sMfSb280UX/Dfv2UvXc5w8WGF1FsJBQSducnqPHNIgsEt3R
         K5K3UNSkT/l2TH3ei6qwFAklbvw6XAauiWA5Al+Oi3/nJVXjbpmHMJhu+Y4bHMwGz4pc
         Dvj0BLhpG5lcgj7wfxNFqLQtK2gVH6AZg5Hv0bX/LWs4FC9cHRSb+kdux8P9qyvtOrYb
         H5ZQ==
X-Gm-Message-State: AOJu0YynoCZWuw1lxghttchJgv+039HKk4xXgU8/j+J1yHJWyj/VhpWD
	oYGiUs6W75dl0onQqltnWHXbhT9+PRBRNzhnfMcqHl8RgAxPSD8xNws+fRLkSboEb2qwPnnmr0W
	OmS0Z4ZZbswp80nC3+zm/8M2Lbf+UKHXxycij8FUxLuSRQEgaDoTdpfUdz/MldVnoU0j5NpdwcZ
	QRueXBdZE/lpwIe4pRY1sFX4YhpuLFpK+jF92dc5Mk5g==
X-Gm-Gg: ASbGncvWyYHhUvr9i0raSn3CnkFYITASfpnCw9ZQOkekssmoJrB7Lx/k2OIEb9ZC4io
	Bn0WO0L7L1yXtArJguaOQdZs1J39F11n8zf8APhTmtorR4O4AguvjUiPTqTmc3fDM7HbuU8KLgm
	kc4NkJMQaoYa8btkkKcdcVXLBXXWajHSfHj98MGALeZfc211W9BEsPwvKsyKQLP/2j9PEF+yzhp
	8oLcIonkK/TgupyxHuQwUTBfHGPk0Y4thxEsFqTLmv9K8RvjUywhmcK1eWA6BaTfboE67dz5sKD
	ifHYJMpxuK2dJZ6O92Y=
X-Google-Smtp-Source: AGHT+IHRyQfgTa1/ztKak0nbnuC8cq6nxpCHreKuybFqjWksYVyDKIzt1nVhQo9w1sedshxpzyQrww==
X-Received: by 2002:a17:907:9722:b0:aa6:950c:ae0e with SMTP id a640c23a62f3a-aab77ec4347mr316751466b.51.1734094302144;
        Fri, 13 Dec 2024 04:51:42 -0800 (PST)
Received: from fedora.. (cpe-109-60-82-197.zg3.cable.xnet.hr. [109.60.82.197])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aa68c4b52b8sm671371066b.52.2024.12.13.04.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 04:51:41 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: netdev@vger.kernel.org,
	stephen@networkplumber.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	dsahern@kernel.org,
	iri@resnulli.us,
	andrew@lunn.ch
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [iproute2-next v3] ip: link: rmnet: add support for flag handling
Date: Fri, 13 Dec 2024 13:51:00 +0100
Message-ID: <20241213125139.733201-1-robert.marko@sartura.hr>
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
Changes in v3:
* Use parse_on_off() instead of hand-coding
* Drop on_off() error message printing

Changes in v2:
* Use strcmp() instead of matches()
* Fix disabling flags (Forgotten ~)
* Separate ingress and egress checksum flags
* Rename flags to more closely resemble their meaning.
For example add ingress when they only affect ingress, rename checksm
flags to mapv4/v5-checksum.

 ip/iplink_rmnet.c | 120 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 118 insertions(+), 2 deletions(-)

diff --git a/ip/iplink_rmnet.c b/ip/iplink_rmnet.c
index 1d16440c..d7596b2b 100644
--- a/ip/iplink_rmnet.c
+++ b/ip/iplink_rmnet.c
@@ -16,6 +16,12 @@ static void print_explain(FILE *f)
 {
 	fprintf(f,
 		"Usage: ... rmnet mux_id MUXID\n"
+		"		[ ingress-deaggregation { on | off } ]\n"
+		"		[ ingress-commands { on | off } ]\n"
+		"		[ ingress-mapv4-checksum { on | off } ]\n"
+		"		[ egress-mapv4-checksum { on | off } ]\n"
+		"		[ ingress-mapv5-checksum { on | off } ]\n"
+		"		[ egress-mapv5-checksum { on | off } ]\n"
 		"\n"
 		"MUXID := 1-254\n"
 	);
@@ -29,15 +35,95 @@ static void explain(void)
 static int rmnet_parse_opt(struct link_util *lu, int argc, char **argv,
 			   struct nlmsghdr *n)
 {
+	struct ifla_rmnet_flags flags = { 0 };
 	__u16 mux_id;
+	int ret;
 
 	while (argc > 0) {
-		if (matches(*argv, "mux_id") == 0) {
+		if (strcmp(*argv, "mux_id") == 0) {
 			NEXT_ARG();
 			if (get_u16(&mux_id, *argv, 0))
 				invarg("mux_id is invalid", *argv);
 			addattr16(n, 1024, IFLA_RMNET_MUX_ID, mux_id);
-		} else if (matches(*argv, "help") == 0) {
+		} else if (strcmp(*argv, "ingress-deaggregation") == 0) {
+			bool deaggregation;
+
+			NEXT_ARG();
+			deaggregation = parse_on_off("ingress-deaggregation", *argv, &ret);
+			if (ret)
+				return ret;
+
+			flags.mask |= RMNET_FLAGS_INGRESS_DEAGGREGATION;
+			if (deaggregation)
+				flags.flags |= RMNET_FLAGS_INGRESS_DEAGGREGATION;
+			else
+				flags.flags &= ~RMNET_FLAGS_INGRESS_DEAGGREGATION;
+		} else if (strcmp(*argv, "ingress-commands") == 0) {
+			bool commands;
+
+			NEXT_ARG();
+			commands = parse_on_off("ingress-commands", *argv, &ret);
+			if (ret)
+				return ret;
+
+			flags.mask |= RMNET_FLAGS_INGRESS_MAP_COMMANDS;
+			if (commands)
+				flags.flags |= RMNET_FLAGS_INGRESS_MAP_COMMANDS;
+			else
+				flags.flags &= ~RMNET_FLAGS_INGRESS_MAP_COMMANDS;
+		} else if (strcmp(*argv, "ingress-mapv4-checksum") == 0) {
+			bool mapv4_checksum;
+
+			NEXT_ARG();
+			mapv4_checksum = parse_on_off("ingress-mapv4-checksum", *argv, &ret);
+			if (ret)
+				return ret;
+
+			flags.mask |= RMNET_FLAGS_INGRESS_MAP_CKSUMV4;
+			if (mapv4_checksum)
+				flags.flags |= RMNET_FLAGS_INGRESS_MAP_CKSUMV4;
+			else
+				flags.flags &= ~RMNET_FLAGS_INGRESS_MAP_CKSUMV4;
+		} else if (strcmp(*argv, "egress-mapv4-checksum") == 0) {
+			bool mapv4_checksum;
+
+			NEXT_ARG();
+			mapv4_checksum = parse_on_off("egress-mapv4-checksum", *argv, &ret);
+			if (ret)
+				return ret;
+
+			flags.mask |= RMNET_FLAGS_EGRESS_MAP_CKSUMV4;
+			if (mapv4_checksum)
+				flags.flags |= RMNET_FLAGS_EGRESS_MAP_CKSUMV4;
+			else
+				flags.flags &= ~RMNET_FLAGS_EGRESS_MAP_CKSUMV4;
+		} else if (strcmp(*argv, "ingress-mapv5-checksum") == 0) {
+			bool mapv5_checksum;
+
+			NEXT_ARG();
+			mapv5_checksum = parse_on_off("ingress-mapv5-checksum", *argv, &ret);
+			if (ret)
+				return ret;
+
+			flags.mask |= RMNET_FLAGS_INGRESS_MAP_CKSUMV5;
+			if (mapv5_checksum)
+				flags.flags |= RMNET_FLAGS_INGRESS_MAP_CKSUMV5;
+			else
+				flags.flags &= ~RMNET_FLAGS_INGRESS_MAP_CKSUMV5;
+		} else if (strcmp(*argv, "egress-mapv5-checksum") == 0) {
+			bool mapv5_checksum;
+
+			NEXT_ARG();
+			mapv5_checksum = parse_on_off("egress-mapv5-checksum", *argv, &ret);
+			if (ret)
+				return ret;
+
+			flags.mask |= RMNET_FLAGS_EGRESS_MAP_CKSUMV5;
+			if (mapv5_checksum)
+				flags.flags |= RMNET_FLAGS_EGRESS_MAP_CKSUMV5;
+			else
+				flags.flags &= ~RMNET_FLAGS_EGRESS_MAP_CKSUMV5;
+		} else if (strcmp(*argv, "help") == 0) {
 			explain();
 			return -1;
 		} else {
@@ -48,11 +134,34 @@ static int rmnet_parse_opt(struct link_util *lu, int argc, char **argv,
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
 
@@ -64,6 +173,13 @@ static void rmnet_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
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


