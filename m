Return-Path: <netdev+bounces-149925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 703829E826A
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 23:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25E531884824
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 22:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7417315350B;
	Sat,  7 Dec 2024 22:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="kcL8aeKF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7496B22C6CD
	for <netdev@vger.kernel.org>; Sat,  7 Dec 2024 22:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733609190; cv=none; b=NuzfY7/N9OpuLYBup0otdXN/GC252f2IVVgT3Q2dxxtShbNbu/RFxo71Hux9+xKO44bymzfGhIbfmVX7aMkuFZ8a0ESixhHC9uXVB9+CiTwZ6HhVmS5EhqPxiLSG1JyurfKOHv75PXzKkAceDKeAnbwOQf5Ej4gvk2gfEsjYq+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733609190; c=relaxed/simple;
	bh=kCWnzjDgmnXfZMhOCbiFoAX0d8iZoouP12awiU1bX+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BgJ/Xke86HopUhJhqMX3ZiKLp55o8Nj2Hh3MZWoHqk6Dsi+c+filtAPtm5MgfDIY5sZq2AUN+kvbKeHXyJNSMWQh5FAEopAE+cqbHpunAOrnjNOmVdSnumpdiK+BSRNqE70MoR3YMW3OkEF0FuXLD3Nntx0fonU+9uIBmfPrBlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=kcL8aeKF; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa530a94c0eso628597166b.2
        for <netdev@vger.kernel.org>; Sat, 07 Dec 2024 14:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1733609185; x=1734213985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cv48r+Fj8y9l52nXHVpPxH4O5U2fyiQb+2TrK9dhOIw=;
        b=kcL8aeKFEn31vLT8MsxYXf1g0NceBS1Qbo/wahLVJL6wtjQue3wZgEVmBgqk823D/j
         jMIyPvaKlYAIfIe3bjKjHG2Z+aJQwWLWW03o1FtHh3vVOkU0wHUCtjEScM4Mduab+KVG
         wUfHzvPnvCNlzJef/wMgrBgGL0z7UmrMo2bCSfJTfYlkKGraHHg9oGO/NdvGwxgAf3JZ
         mVGe1GeTrEOd8P3YJgkpZldMxBkQA8Ym6RiVXAZA5C7fw/L0vemvpTx+FCbFIUGycukF
         vd1f3D6E3NC0femB871Hz+r1ekSYfn+WJw2g6t+tXz3ruadyfjep//FxrJKXaYO0v9+P
         qPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733609185; x=1734213985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cv48r+Fj8y9l52nXHVpPxH4O5U2fyiQb+2TrK9dhOIw=;
        b=J69tsBps4u2m58KVm7hceXlmJWNwzfKz1PsR2n2Fk/D05YjWNWf/hsbxokuYzJ2Qct
         5Mo5skg6xwnHJXO6vSlP8RuUUwFEOxD91v9kTZT1xc7eVRA93YZGfthAS5mqx/nJxrVf
         HLqtkftxblHcTzHbxQlkbHZScIQErHqqTYtS0T+ybRlUbNaa5QyRKVe933SRqESnw35J
         Hilhze6JUyXiAWQ9OgKYOpljXW+UqUl0NGHxYwBaR1q2WjSvtCGknVvUh/WlnJGO9tTC
         XW3x4kQiDOD28Kjzxw+7Ur3Ls6BgXYBmmIzBAu9np6TNE477TjpfPTHxqYjfcP1BUlCg
         +z7g==
X-Gm-Message-State: AOJu0YwKb0iZQ6pqtyOomkWASwXF33InflL7qFHu1KOLw6SuEjsm3TrI
	1fXHWiWV+OurshxZ6aYElP/SSKw8FKJlrvS0/KAV8Jm1QnBoxJOJ0QeKMY96hzojU44rJpG4zhK
	mwdvx1O6V48nTYHTyL+fR+DV/YPzboE949r8Jo//EB3mZbVUfJ8UkqE6mMSr2lHz+14uli+y+JU
	6K6oiuH0pszYomf6i0i51Xcwlkf1m10WBHOWVol2DnxA==
X-Gm-Gg: ASbGnct59T7bNuKjAMRPnq5zsHEvA5njTdE94gvdUlkJfIttr7LUGYEmvadN8VABNdg
	0JX5R2udmJxZa0J8M1EXU1ZozBfurUiwc6UhqZ6z3guX+fg7oeh4FZPCtsjqP3R2RCoqp1o/2tA
	Wb7sHririGHimpKJRgYh7qtv+1x1Ng1mvX9UKsvNIl9xNaBY4fUoGz1gBOYI4j9SiCGVUqybivy
	/OkLKLc63W/AB8DjU8Se6gbnp/7Cmj0ztOBMCs06E4ji/CAO4wYchTwtf7SrtFtZLRQnlAh8nDA
	jMnLX89SkA==
X-Google-Smtp-Source: AGHT+IEn8sfspBzJjXlTXy+egVZxR2pEiQYL8GFmJg6bux/hNbEf59nAwSQlrfdVz/ih19WbANH7CA==
X-Received: by 2002:a17:906:9555:b0:aa6:21ce:cddf with SMTP id a640c23a62f3a-aa63a131011mr738866466b.36.1733609184985;
        Sat, 07 Dec 2024 14:06:24 -0800 (PST)
Received: from fedora.. (cpe-109-60-83-93.zg3.cable.xnet.hr. [109.60.83.93])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aa66cc544c4sm67183266b.178.2024.12.07.14.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 14:06:24 -0800 (PST)
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
Subject: [iproute2-next v2] ip: link: rmnet: add support for flag handling
Date: Sat,  7 Dec 2024 23:05:15 +0100
Message-ID: <20241207220621.3279646-1-robert.marko@sartura.hr>
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
Changes in v2:
* Use strcmp() instead of matches()
* Fix disabling flags (Forgotten ~)
* Separate ingress and egress checksum flags
* Rename flags to more closely resemble their meaning.
For example add ingress when they only affect ingress, rename checksm
flags to mapv4/v5-checksum.

 ip/iplink_rmnet.c | 101 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 99 insertions(+), 2 deletions(-)

diff --git a/ip/iplink_rmnet.c b/ip/iplink_rmnet.c
index 1d16440c..b1fb9f03 100644
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
@@ -26,18 +32,79 @@ static void explain(void)
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
-		if (matches(*argv, "mux_id") == 0) {
+		if (strcmp(*argv, "mux_id") == 0) {
 			NEXT_ARG();
 			if (get_u16(&mux_id, *argv, 0))
 				invarg("mux_id is invalid", *argv);
 			addattr16(n, 1024, IFLA_RMNET_MUX_ID, mux_id);
-		} else if (matches(*argv, "help") == 0) {
+		} else if (strcmp(*argv, "ingress-deaggregation") == 0) {
+			NEXT_ARG();
+			flags.mask |= RMNET_FLAGS_INGRESS_DEAGGREGATION;
+			if (strcmp(*argv, "on") == 0)
+				flags.flags |= RMNET_FLAGS_INGRESS_DEAGGREGATION;
+			else if (strcmp(*argv, "off") == 0)
+				flags.flags &= ~RMNET_FLAGS_INGRESS_DEAGGREGATION;
+			else
+				return on_off("ingress-deaggregation", *argv);
+		} else if (strcmp(*argv, "ingress-commands") == 0) {
+			NEXT_ARG();
+			flags.mask |= RMNET_FLAGS_INGRESS_MAP_COMMANDS;
+			if (strcmp(*argv, "on") == 0)
+				flags.flags |= RMNET_FLAGS_INGRESS_MAP_COMMANDS;
+			else if (strcmp(*argv, "off") == 0)
+				flags.flags &= ~RMNET_FLAGS_INGRESS_MAP_COMMANDS;
+			else
+				return on_off("ingress-commands", *argv);
+		} else if (strcmp(*argv, "ingress-mapv4-checksum") == 0) {
+			NEXT_ARG();
+			flags.mask |= RMNET_FLAGS_INGRESS_MAP_CKSUMV4;
+			if (strcmp(*argv, "on") == 0)
+				flags.flags |= RMNET_FLAGS_INGRESS_MAP_CKSUMV4;
+			else if (strcmp(*argv, "off") == 0)
+				flags.flags &= ~RMNET_FLAGS_INGRESS_MAP_CKSUMV4;
+			else
+				return on_off("ingress-mapv4-checksum", *argv);
+		} else if (strcmp(*argv, "egress-mapv4-checksum") == 0) {
+			NEXT_ARG();
+			flags.mask |= RMNET_FLAGS_EGRESS_MAP_CKSUMV4;
+			if (strcmp(*argv, "on") == 0)
+				flags.flags |= RMNET_FLAGS_EGRESS_MAP_CKSUMV4;
+			else if (strcmp(*argv, "off") == 0)
+				flags.flags &= ~RMNET_FLAGS_EGRESS_MAP_CKSUMV4;
+			else
+				return on_off("egress-mapv4-checksum", *argv);
+		} else if (strcmp(*argv, "ingress-mapv5-checksum") == 0) {
+			NEXT_ARG();
+			flags.mask |= RMNET_FLAGS_INGRESS_MAP_CKSUMV5;
+			if (strcmp(*argv, "on") == 0)
+				flags.flags |= RMNET_FLAGS_INGRESS_MAP_CKSUMV5;
+			else if (strcmp(*argv, "off") == 0)
+				flags.flags &= ~RMNET_FLAGS_INGRESS_MAP_CKSUMV5;
+			else
+				return on_off("ingress-mapv5-checksum", *argv);
+		} else if (strcmp(*argv, "egress-mapv5-checksum") == 0) {
+			NEXT_ARG();
+			flags.mask |= RMNET_FLAGS_EGRESS_MAP_CKSUMV5;
+			if (strcmp(*argv, "on") == 0)
+				flags.flags |= RMNET_FLAGS_EGRESS_MAP_CKSUMV5;
+			else if (strcmp(*argv, "off") == 0)
+				flags.flags &= ~RMNET_FLAGS_EGRESS_MAP_CKSUMV5;
+			else
+				return on_off("egress-mapv5-checksum", *argv);
+		} else if (strcmp(*argv, "help") == 0) {
 			explain();
 			return -1;
 		} else {
@@ -48,11 +115,34 @@ static int rmnet_parse_opt(struct link_util *lu, int argc, char **argv,
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
 
@@ -64,6 +154,13 @@ static void rmnet_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
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


