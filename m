Return-Path: <netdev+bounces-286086-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0P/iCxOb/mkMtwAAu9opvQ
	(envelope-from <netdev+bounces-286086-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 04:25:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B784FD9EF
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 04:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9F65302BE37
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 02:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A5B29BDBB;
	Sat,  9 May 2026 02:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLb0XVWZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A11E2C028F
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 02:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778293444; cv=none; b=CwfHpaFrA965UULaJ46msMrSNMy5AlPYR5QNfDN2hwtrv6Zpzg9RFSj0wcmcaflQ54IRnWVasZBAhLPjcFJLw5agC+tOccsTFeYTN9NiPS1zQIJJwL9fxMTJfXO+oytC5AX19jn1Me/jc9F/9ynsmVJV6Eh+iPSbbnnkLhLpJUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778293444; c=relaxed/simple;
	bh=f/hLWhEZTh9vQ8SfV+dt52XH5X5SToC+1COsZQ9ViSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1r8SsnzIkC9YfTB0UzLTRwKhH1FKmmkb+uswxotDU7sy0fuh+zfcYgaKtKbFaZ4IjuM3NXaSQY2591payY/ewNMcQBgSOh5qdmY3/VsJef3B93nS6fSaR2q9nrhP2UMiEI0i7Efxu33/UJ1x/n32gVkeRC/pLEMXtw5+08jTQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLb0XVWZ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4893940bb5eso15687815e9.3
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 19:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778293441; x=1778898241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1EsL9Ii2JypdJ2X6iK9dsmrJhwER5rgRhyHI0LIawM=;
        b=YLb0XVWZ6UUFCOHaRsPqzkTQOWVrL0J947d6QDuTnjK/mDRljBhTzOh8ZNsnywDLz4
         Hfxit03i54+aG7lr8L9sJS4Br3sT3KA4GFYlAjITtCLb28DrNPWpv7wClh9pAmgRKhIA
         eg2MWVFVy3p65SrOBZB8U+6+dO658eehWOG+TNGctP7gyhNYE3oObv9+jWj+oQ7n7I8T
         BbJMf+Z0eD/EBlyuYTC+fBwT3vKWSEggIPbacxkOcaBDk3oMPX2ILvgAQvch3J75Um0X
         Z50PbRFQRv3/T0DO4X1La28Cajeosr+kSd07TubKXFlXCQaselTGlt5jdbIsrEBOmmQ5
         yILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778293441; x=1778898241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h1EsL9Ii2JypdJ2X6iK9dsmrJhwER5rgRhyHI0LIawM=;
        b=mTUCO9ld99oWWKwcbmUkcGFSjkdLpN7d7K+Dz70GmV8L+1GVM1vuF45BJ0vf1btOXX
         uM2RSbdYI7EUWSKDWZue/p4fPfOy8MgvsIS/Abv6oMP2ULj7psY9NdonwfUeqKKPz9W8
         /7VsJvf+oKCfV8PC8Ik2YY7ttwL2YLdmF52vaYY+HBHXVOGz4EadyKRPuGY7G00vpOF+
         z+neErwjm/wtwqeOl77wd1QRQ+P7WUy18LBgjgel6c7UZRL0iWjrteNCok7dxKCEYcaW
         DQ+AipXCoxLZSSDmQvmPXHd1QkRjg+WeDqFtv22RkrfHz2K16REmzSIvTxyVIwROi1Ws
         dmIQ==
X-Gm-Message-State: AOJu0YxF3+cwRJUA7wYI+nLK/qcC0i9HtjjIl+2JCuXcUsn977CTQ3Nt
	N3/re5zgpA1JBA5j3VUl0XqILU7reRoS/r3Sk5zn7GZxuZdtHEEGIMlg9qUFWUri
X-Gm-Gg: AeBDietV5/OvX3jZ5kOCzvekAGsT8QWLpGm4Q12Gzcl5Dj4bU/NzbmUVkwbvoBAFY3d
	RXh5UuBNznMbNIwLq53VvVhjFpPv7cBJ12S3CB3TnZkFSjfK1nf8nzIOtSxabkbwwp7YHadKDER
	N2cW7H/t/qcS1B/hfFbxJkLP4LYIYVFwaRMrGIQ3tA36Epm9oHCmH0/xIpSoppfAScXpQK2kxFi
	RkHucZm9ZG2SFqeB0EZHgRsQoq7El1/W5k+LO4xfxAwznBsc8k2u1WfAm9wya2jHOLMGORgxq1F
	9hYpkrfLFL3YyfRFN4iSyoDevrIZ0Z6h9+ixgKrG2PUi0R6+uiA9zaisO9b2yBGwHanzPO+f0oB
	qz5XEZ4Bfkvxd/OEqhWLEm/FBzpitYk2tJ5Bj5ygkj04Bycpu5p3bxQNHr9h8GxRxHvg99HyQ+a
	IW4GCQGJCmT6cRDkDQW8Jm
X-Received: by 2002:a05:600c:4703:b0:488:936a:6220 with SMTP id 5b1f17b1804b1-48e676ac055mr76536305e9.21.1778293441011;
        Fri, 08 May 2026 19:24:01 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:5c::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6fff9ab8sm16839795e9.2.2026.05.08.19.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 19:24:00 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	ernis@linux.microsoft.com,
	mohsin.bashr@gmail.com
Subject: [PATCH iproute2-next v2 1/6] netshaper: Extract parse_scope() and parse_rate() helpers
Date: Fri,  8 May 2026 19:23:48 -0700
Message-ID: <20260509022353.3470738-2-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260509022353.3470738-1-mohsin.bashr@gmail.com>
References: <20260509022353.3470738-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A6B784FD9EF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-286086-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,redhat.com,linux.microsoft.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Mohsin Bashir <hmohsin@meta.com>

Add parse_scope() and parse_rate() helpers in preparation for
adding the group command which will need scope and rate parsing
at various places in the code. This patch will help to avoid
code duplication.

Verify that the tool works as before:
./netshaper set dev eth2 handle scope queue id 0 bw-max 100kbit
./netshaper delete dev eth2 handle scope queue id 0 bw-max 100kbit

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <hmohsin@meta.com>
---
 include/utils.h       |  1 +
 netshaper/netshaper.c | 63 ++++++++++++++++++++++---------------------
 2 files changed, 34 insertions(+), 30 deletions(-)

diff --git a/include/utils.h b/include/utils.h
index e4e318e2..f0d45bad 100644
--- a/include/utils.h
+++ b/include/utils.h
@@ -260,6 +260,7 @@ unsigned int print_name_and_link(const char *fmt,
 	__attribute__((format(printf, 1, 0)));
 
 
+#define BITS_PER_BYTE           8
 #define BIT(nr)                 (UINT64_C(1) << (nr))
 
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
diff --git a/netshaper/netshaper.c b/netshaper/netshaper.c
index 47fb805e..f90ceb11 100644
--- a/netshaper/netshaper.c
+++ b/netshaper/netshaper.c
@@ -47,6 +47,26 @@ static const char *net_shaper_scope_names[NET_SHAPER_SCOPE_MAX + 1] = {
 	"node"
 };
 
+static int parse_scope(const char *str)
+{
+	for (int i = 1; i <= NET_SHAPER_SCOPE_MAX; i++) {
+		if (strcmp(str, net_shaper_scope_names[i]) == 0)
+			return i;
+	}
+	return -1;
+}
+
+static int parse_rate(const char *str, __u64 *rate_bps)
+{
+	if (get_rate64(rate_bps, str)) {
+		fprintf(stderr, "Invalid rate value \"%s\"\n", str);
+		return -1;
+	}
+	/* get_rate64 returns bytes/sec, convert to bits/sec */
+	*rate_bps *= BITS_PER_BYTE;
+	return 0;
+}
+
 static void print_netshaper_attrs(struct nlmsghdr *answer)
 {
 	struct genlmsghdr *ghdr = NLMSG_DATA(answer);
@@ -117,12 +137,8 @@ static int do_cmd(int argc, char **argv, int cmd)
 			ifindex = ll_name_to_index(*argv);
 		} else if (strcmp(*argv, "bw-max") == 0) {
 			NEXT_ARG();
-			if (get_rate64(&bw_max_bps, *argv)) {
-				fprintf(stderr, "Invalid bw-max value\n");
+			if (parse_rate(*argv, &bw_max_bps))
 				return -1;
-			}
-			/* Convert Bps to bps */
-			bw_max_bps *= 8;
 		} else if (strcmp(*argv, "handle") == 0) {
 			handle_present = true;
 			NEXT_ARG();
@@ -134,34 +150,24 @@ static int do_cmd(int argc, char **argv, int cmd)
 			}
 			NEXT_ARG();
 
-			if (strcmp(*argv, "netdev") == 0) {
-				handle_scope = NET_SHAPER_SCOPE_NETDEV;
-				/* For netdev scope, id is optional - check if next arg is "id" */
+			handle_scope = parse_scope(*argv);
+			if (handle_scope < 0) {
+				fprintf(stderr, "Invalid scope \"%s\"\n", *argv);
+				return -1;
+			}
+
+			if (handle_scope == NET_SHAPER_SCOPE_NETDEV) {
+				/* For netdev scope, id is optional */
 				if (argc > 1 && strcmp(argv[1], "id") == 0) {
-					NEXT_ARG(); /* move to "id" */
-					NEXT_ARG(); /* move to id value */
+					NEXT_ARG();
+					NEXT_ARG();
 					if (get_unsigned(&handle_id, *argv, 10)) {
 						fprintf(stderr, "Invalid handle id\n");
 						return -1;
 					}
 				}
-			} else if (strcmp(*argv, "queue") == 0) {
-				handle_scope = NET_SHAPER_SCOPE_QUEUE;
-				/* For queue scope, id is required */
-				NEXT_ARG();
-				if (strcmp(*argv, "id") != 0) {
-					fprintf(stderr, "What is \"%s\"\n", *argv);
-					usage();
-					return -1;
-				}
-				NEXT_ARG();
-				if (get_unsigned(&handle_id, *argv, 10)) {
-					fprintf(stderr, "Invalid handle id\n");
-					return -1;
-				}
-			} else if (strcmp(*argv, "node") == 0) {
-				handle_scope = NET_SHAPER_SCOPE_NODE;
-				/* For node scope, id is required */
+			} else {
+				/* For queue/node scope, id is required */
 				NEXT_ARG();
 				if (strcmp(*argv, "id") != 0) {
 					fprintf(stderr, "What is \"%s\"\n", *argv);
@@ -173,9 +179,6 @@ static int do_cmd(int argc, char **argv, int cmd)
 					fprintf(stderr, "Invalid handle id\n");
 					return -1;
 				}
-			} else {
-				fprintf(stderr, "Invalid scope\n");
-				return -1;
 			}
 		} else {
 			fprintf(stderr, "What is \"%s\"\n", *argv);
-- 
2.53.0-Meta


