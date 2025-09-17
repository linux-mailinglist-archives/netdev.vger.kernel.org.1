Return-Path: <netdev+bounces-224119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41440B80FA0
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 18:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63ED81884AF0
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 16:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418DE34BA3C;
	Wed, 17 Sep 2025 16:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mcwilliam.dev header.i=@mcwilliam.dev header.b="E9lWw8RU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0495E34BA4A
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126321; cv=none; b=DQqLRloHsHHI99Q9tY9uXHiepayga15IAaChz1UT7ASp1+ex/2g0YFJtJiRPg/kylJQ6zzju/7/C4ltRx0LaB1sFggmzLKdL7CjXBcyIaU9xyAIgHNSF5g6lpVsGpTfo6GBaiblIDdfUkKUObIaoL18Tc0yVe5tMGEal2aZ+4tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126321; c=relaxed/simple;
	bh=bFm1BoyXRIBtQx5jMlwvz7lThv+agKm5LircuWHfLFw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Buh8iF8LA3uA6I47oMzjTR0oAxYwAZzOapKC8fuPyYhZiFy56lpuusbRjp3+FPsEVRWvluif6ZJHRQ1u3YMddcOWizaXSyH/RIio9LndNf2WH3nR3m0ePx+wwnMR+zhKVpIe4gVeuFiwBmpglwACPtYSP2Zkygt8taX9N+0BLRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mcwilliam.dev; spf=pass smtp.mailfrom=mcwilliam.dev; dkim=pass (2048-bit key) header.d=mcwilliam.dev header.i=@mcwilliam.dev header.b=E9lWw8RU; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mcwilliam.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mcwilliam.dev
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45b9a856dc2so43481725e9.0
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 09:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mcwilliam.dev; s=google; t=1758126317; x=1758731117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sUDDINSDHZPZlAb4GAsIIWBuEkwIrRQSuIxVCbtJv4w=;
        b=E9lWw8RU0Q2XW8Ph2qrW8GKGi6dSaxjQ2BYRA+lB0mLOV5k+kkzTLAS+ZLMr55flYa
         r5tZ+y+dQjUenzT4SQgcrSbvAoXE94o/+nyAVnJDB+Au5IulMx5gcM48K+tmrW+mr1dn
         16ceGH6/ugGBqyazG+pT/68amLJ2ArEBsRPJMBqM8neJ4gRxKnKx201K2kgxdhZk0aQy
         0S3unz/fPZTG5Ch/UDYPCHyhYuPSrQX/rXwGdUvuc3DqDumW9FHKcOATHxsfhiuzezSb
         73pwLp9UKdZx8ToMFKwhXbgy85swZ+97HLqwhVvkWIZs4jCZlFLOTJEOL5gOivqIjEdG
         a65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758126317; x=1758731117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sUDDINSDHZPZlAb4GAsIIWBuEkwIrRQSuIxVCbtJv4w=;
        b=SwMRo1WM5FRCvx7H4s3mNy3jPXPb3LARa0Bwd1racSagjZhT1xydBrgASogCoI9DCs
         MePHWUQMjwwT2xnc1/hAESX/MIpvXOQ2R22fHelYMVzdyprvL/PPBrc+pkXGXKHpyczj
         nyCYynxi9QXiQCwP3UYaRv5Iqs1DQNvdMQf8SLBBoFIGV5TqEQS7T/OqQt9kRZFBL+5l
         gVqwD2GBM9q83ABToHmujBkohPLrMjfxnWRLwCr3wVV8/zkzI5AYHr0qn3/oXelMGZH5
         xS8aAgUmjuYa5uqcVvmj44SBZKd6+kQ1wwNNndvANNDzoPAzAc9ZelxOINFVTXk5XdIn
         1QLQ==
X-Gm-Message-State: AOJu0Yxg08olvjZTCXWWSLSHd6gkjGhqY+HsYyhwGu8RHFN0VBc5zFOv
	CpN2Ia2DARU3tE57HgwOEQehqxaX8ki/u81R1Ib/qwI6gGaRKLfyu/tTtvUixJQ4pok=
X-Gm-Gg: ASbGncskmE/LEd/Wcxw9yz51eLi2IlXcCS4Sa3hFAkuGWfSDWdro0Q9JaE+fpLxrayV
	f7GotBxsSHfgqz9A8Rv365PRlp5PxSHEEV3aoJ2DQkCnm2LZv1JJBp4ckACMYj+kCieB+wqdGn4
	GpKFUGbzLiygXlug5+kazHX52uHpxMHcIFd6HWXZKrhBm4jnhbvC9x/LUeoOhSSkx64HDP5GjNS
	aopBQDGighOXB+yceqIIb0d08bZ5RbeZ5IrGYMy3qAomcgjegCT3y4CqXig62W7x51f3BYhqzug
	xYx9gcRbPpg4nYv8j2xT41MU2ptaH+Zt/AgTPj+axQ+/NSH2L1yU3QkrvU2iSRHdzSQY6G10/2G
	5wAzypJriIL1cy9IVZIyWFNVPn/a6
X-Google-Smtp-Source: AGHT+IGOgxePwWL4XTQHu3a5uDaNY/4pNTnxnmPHqTzQ5wiozqvQvedTovZZIwQOZY2ySILQnOP/Ug==
X-Received: by 2002:a05:600c:310a:b0:45f:2919:5e91 with SMTP id 5b1f17b1804b1-462037705d1mr33751645e9.16.1758126316889;
        Wed, 17 Sep 2025 09:25:16 -0700 (PDT)
Received: from el9-dev.local ([146.255.105.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464eadd7e11sm3146005e9.0.2025.09.17.09.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 09:25:16 -0700 (PDT)
From: Alasdair McWilliam <alasdair@mcwilliam.dev>
To: David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org,
	Alasdair McWilliam <alasdair@mcwilliam.dev>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH iproute2-next] ip: geneve: Add support for IFLA_GENEVE_PORT_RANGE
Date: Wed, 17 Sep 2025 17:24:49 +0100
Message-ID: <20250917162449.78412-1-alasdair@mcwilliam.dev>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IFLA_GENEVE_PORT_RANGE attribute was added in Linux kernel commit
e1f95b1992b8 ("geneve: Allow users to specify source port range") [0] to
facilitate programmatic tuning of the UDP source port range of geneve
tunnel interfaces.

This patch provides support for this attribute in iproute2 such that the
source port range can be set when adding new devices and queried on
existing devices. Implementation is consistent with VXLAN.

Example:

$ ip link add test_geneve type geneve id 100 dstport 6082 \
      remote 192.0.2.1 ttl auto srcport 32000 33000

$ ip -j -d link show dev test_geneve | jq -r '.[].linkinfo'
{
  "info_kind": "geneve",
  "info_data": {
    "id": 100,
    "remote": "192.0.2.1",
    "ttl": 0,
    "df": "unset",
    "port": 6082,
    "udp_csum": false,
    "udp_zero_csum6_rx": true,
    "port_range": {
      "low": 32000,
      "high": 33000
    }
  }
}

Link: https://lore.kernel.org/all/20250226182030.89440-1-daniel@iogearbox.net/ [0]
Signed-off-by: Alasdair McWilliam <alasdair@mcwilliam.dev>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
---
 ip/iplink_geneve.c    | 30 ++++++++++++++++++++++++++++++
 man/man8/ip-link.8.in |  7 +++++++
 2 files changed, 37 insertions(+)

diff --git a/ip/iplink_geneve.c b/ip/iplink_geneve.c
index 62c61bce..2ef72ab9 100644
--- a/ip/iplink_geneve.c
+++ b/ip/iplink_geneve.c
@@ -23,6 +23,7 @@ static void print_explain(FILE *f)
 		"		[ df DF ]\n"
 		"		[ flowlabel LABEL ]\n"
 		"		[ dstport PORT ]\n"
+		"		[ srcport MIN MAX ]\n"
 		"		[ [no]external ]\n"
 		"		[ [no]udpcsum ]\n"
 		"		[ [no]udp6zerocsumtx ]\n"
@@ -142,6 +143,22 @@ static int geneve_parse_opt(struct link_util *lu, int argc, char **argv,
 			    (uval & ~LABEL_MAX_MASK))
 				invarg("invalid flowlabel", *argv);
 			label = htonl(uval);
+		} else if (!matches(*argv, "port")
+			|| !matches(*argv, "srcport")) {
+			struct ifla_geneve_port_range range = { 0, 0 };
+
+			NEXT_ARG();
+			check_duparg(&attrs, IFLA_GENEVE_PORT_RANGE, "srcport",
+				     *argv);
+			if (get_be16(&range.low, *argv, 0))
+				invarg("min port", *argv);
+			NEXT_ARG();
+			if (get_be16(&range.high, *argv, 0))
+				invarg("max port", *argv);
+			if (range.low || range.high) {
+				addattr_l(n, 1024, IFLA_GENEVE_PORT_RANGE,
+					  &range, sizeof(range));
+			}
 		} else if (!matches(*argv, "dstport")) {
 			NEXT_ARG();
 			check_duparg(&attrs, IFLA_GENEVE_PORT, "dstport",
@@ -374,6 +391,19 @@ static void geneve_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 		print_bool(PRINT_ANY, "inner_proto_inherit",
 			   "innerprotoinherit ", true);
 	}
+
+	if (tb[IFLA_GENEVE_PORT_RANGE]) {
+		const struct ifla_geneve_port_range *r
+			= RTA_DATA(tb[IFLA_GENEVE_PORT_RANGE]);
+		if (is_json_context()) {
+			open_json_object("port_range");
+			print_uint(PRINT_JSON, "low", NULL, ntohs(r->low));
+			print_uint(PRINT_JSON, "high", NULL, ntohs(r->high));
+			close_json_object();
+		} else {
+			fprintf(f, "srcport %u %u ", ntohs(r->low), ntohs(r->high));
+		}
+	}
 }
 
 static void geneve_print_help(struct link_util *lu, int argc, char **argv,
diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index 7995943a..662f49d5 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -1408,6 +1408,8 @@ the following additional arguments are supported:
 ] [
 .BI dstport " PORT"
 ] [
+.BI srcport " MIN MAX "
+] [
 .RB [ no ] external
 ] [
 .RB [ no ] udpcsum
@@ -1458,6 +1460,11 @@ bit is not set.
 .BI dstport " PORT"
 - select a destination port other than the default of 6081.
 
+.sp
+.BI srcport " MIN MAX"
+- specifies the range of port numbers to use as UDP
+source ports to communicate to the remote tunnel endpoint.
+
 .sp
 .RB [ no ] external
 - make this tunnel externally controlled (or not, which is the default). This
-- 
2.47.3


