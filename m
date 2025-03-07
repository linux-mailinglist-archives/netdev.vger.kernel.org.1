Return-Path: <netdev+bounces-172782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6867A55EBE
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 04:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 829FF3B5317
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 03:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797E1198E65;
	Fri,  7 Mar 2025 03:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7+0oWVs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F9A194A66
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 03:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741318589; cv=none; b=VHBlFDoAQk9Xz6Lw8ekR2g9PAMWxfZR4uhlcKEjaMcLAqnrj3Nqu7N5+aqi632yT+VJvyQwzEP3lcdyov1GrcsCeKRaTlCWMiRP1bPtENe/UJg0esm3hZIcnlfzyvQxBXy2QLgRpB0kF+y6tNGRcGFWetkvs3/x8O09QqNZBfKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741318589; c=relaxed/simple;
	bh=WbK6+6SUrxvSfG7PKZyJJbtLua8PwtOGKuwMIHIvRX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G0sqGwuZ8IzDC2ZA364Hg2EoiCvLtgLfJ+ZooXOfTUSsvYwTVAVOi1YiDUPJKW9yd4YhI6xNDo+SGo2Sq7J/VCyyI8bbfgPB/Yv0RKBwDLb/jLTof/5ubhmUh/nAPEw9Xq/S8F7G6mDGeroX4QimAKvH3Qoxyt+hp77fgycuWdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7+0oWVs; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e8fb83e137so8118586d6.0
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 19:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741318586; x=1741923386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hvOlbfnK+oYf7GNQWvVi9A0q+hidiiMQXBwWziDpvo=;
        b=W7+0oWVso0tA8bJr30OtEXQ67zOLG+yms8bvZgpXEveIv3l9qwRN9GQrhxpxREigI2
         DqigafVCKhem14gRNgBw0Omn1edwwtlwdeETfQiSoJv5eSfRItKm2Q9TYXGd3p9G/MQe
         hL7P+9G4hed1LRkVLN4oZPxANXNeOcB5HP/hTOsQ1/PW9q5nl2tZEGQK0K27ZY6ksSkb
         3vDp2LnfxrsraDrztUSH1iqayxTrI6Pd3nLG9P0CaKQ8IlsnoQlP5CDSaCgoBrESAdgW
         YV3Z5JdDt2A02KCluyBo7pqv+G/gZiedUY7NRtyEPQN9NeRb52soPPBXeR5RC1/O7RXy
         DGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741318586; x=1741923386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hvOlbfnK+oYf7GNQWvVi9A0q+hidiiMQXBwWziDpvo=;
        b=ao1WU0XS6GP0dShovPgACjx4i5HR0518mh6ktrq0CBIS9z1osn8ZVmxGN4QPd8fNfF
         LudJA4MFJ8Bba4vaPeWfa/txmnmq8yHmKNmTUHk/Xa/WLYj9ekj8w19eQ6JBAFMhtdns
         1Dh6D4SdhA0NP9B3U1un96oqjbG6nwXU0aeN+JV4xKaCzTvFqLRFFaGFKXuWpI8ANLyQ
         271dTmXhzodbQ8Acy1KjgbZoUSPdNXVlSjlhi0zKJUw1ePXzXojxQqkplho7Aw1BnaI6
         yUSV5YtJ/s4pyVxDxUbOE6EikUN0GeBzPlBc4Zt5ka4wm/3a7ZzZ4ejbZ4Nrk2HJjER/
         Fohg==
X-Gm-Message-State: AOJu0YwiqSqHhvoRkEvTLF6AWdRZd1WcilW1rxIN8FFA+Z3umiU2Fwnc
	SXpQykJSZWsqF/lxyB2t/10b4w9OG4Ia9bxiSbZcKeAXu3ZCEXSPKlMotg==
X-Gm-Gg: ASbGncspW8pUItA9OwvD8q191PuhrYqNpISYJlqOd2WTFoBFU5e/W6OE5HpVvYYvPIV
	DA7Ok/0SiNkj5xC6HfOWrpYfUWOT7J1Rx4X9pdPwNWAbEqWvI2ugfQWiU6+FWMz0iTUnLt9carc
	wV3ssbel5dS1XdiyKjzqaNjlr0J9BUPlQo55d+Ywyfq2Ijbb0hxKqE8sfbAXkBcEw6eNomr5vJG
	zzn18DMvndbQKEaVY/dSAQSVx6c0/ynKkBZIutYbInLgv/eqcTLUImAhisp2nHSedwpY9siKmtF
	/tCw3vSxc6FS3yquhISJDEvVQXxJTEQwvmYUJ3R0mWTrN8iJPkBoQx6u5N9aixzVbtuUxb8lPXf
	lZOxSyETSNfW88ZQMP4S+7CPKsvHNLqjI75KNfryH3uhN
X-Google-Smtp-Source: AGHT+IEGlMyW+haW3YwOYBwPO7AzSRDSy17gBj1hlDoZwVYlg4+O1PCPcg67BwFj3dJVTZ6PmlV4rQ==
X-Received: by 2002:a05:6214:2622:b0:6e6:6506:af59 with SMTP id 6a1803df08f44-6e9005ea3cemr23438696d6.15.1741318586410;
        Thu, 06 Mar 2025 19:36:26 -0800 (PST)
Received: from willemb.c.googlers.com.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f71727d1sm14528946d6.117.2025.03.06.19.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 19:36:25 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	horms@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 3/3] selftests/net: expand cmsg_ip with MSG_MORE
Date: Thu,  6 Mar 2025 22:34:10 -0500
Message-ID: <20250307033620.411611-4-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
In-Reply-To: <20250307033620.411611-1-willemdebruijn.kernel@gmail.com>
References: <20250307033620.411611-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

UDP send with MSG_MORE takes a slightly different path than the
lockless fast path.

For completeness, add coverage to this case too.

Pass MSG_MORE on the initial sendmsg, then follow up with a zero byte
write to unplug the cork.

Unrelated: also add two missing endlines in usage().

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 tools/testing/selftests/net/cmsg_ip.sh    | 11 +++++++----
 tools/testing/selftests/net/cmsg_sender.c | 24 ++++++++++++++++++-----
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/cmsg_ip.sh b/tools/testing/selftests/net/cmsg_ip.sh
index 2a52520aca32..b55680e081ad 100755
--- a/tools/testing/selftests/net/cmsg_ip.sh
+++ b/tools/testing/selftests/net/cmsg_ip.sh
@@ -50,8 +50,9 @@ check_result() {
 # IPV6_DONTFRAG
 for ovr in setsock cmsg both diff; do
     for df in 0 1; do
-	for p in u i r; do
+	for p in u U i r; do
 	    [ $p == "u" ] && prot=UDP
+	    [ $p == "U" ] && prot=UDP
 	    [ $p == "i" ] && prot=ICMP
 	    [ $p == "r" ] && prot=RAW
 
@@ -81,8 +82,9 @@ test_dscp() {
     ip $IPVER -netns $NS route add table 300 prohibit any
 
     for ovr in setsock cmsg both diff; do
-	for p in u i r; do
+	for p in u U i r; do
 	    [ $p == "u" ] && prot=UDP
+	    [ $p == "U" ] && prot=UDP
 	    [ $p == "i" ] && prot=ICMP
 	    [ $p == "r" ] && prot=RAW
 
@@ -134,8 +136,9 @@ test_ttl_hoplimit() {
     local -r LIM=4
 
     for ovr in setsock cmsg both diff; do
-	for p in u i r; do
+	for p in u U i r; do
 	    [ $p == "u" ] && prot=UDP
+	    [ $p == "U" ] && prot=UDP
 	    [ $p == "i" ] && prot=ICMP
 	    [ $p == "r" ] && prot=RAW
 
@@ -166,7 +169,7 @@ test_ttl_hoplimit -4 $TGT4 ttl
 test_ttl_hoplimit -6 $TGT6 hlim
 
 # IPV6 exthdr
-for p in u i r; do
+for p in u U i r; do
     # Very basic "does it crash" test
     for h in h d r; do
 	$NSEXE ./cmsg_sender -p $p -6 -H $h $TGT6 1234
diff --git a/tools/testing/selftests/net/cmsg_sender.c b/tools/testing/selftests/net/cmsg_sender.c
index 19bd8499031b..a825e628aee7 100644
--- a/tools/testing/selftests/net/cmsg_sender.c
+++ b/tools/testing/selftests/net/cmsg_sender.c
@@ -33,6 +33,7 @@ enum {
 	ERN_RECVERR,
 	ERN_CMSG_RD,
 	ERN_CMSG_RCV,
+	ERN_SEND_MORE,
 };
 
 struct option_cmsg_u32 {
@@ -46,6 +47,7 @@ struct options {
 	const char *service;
 	unsigned int size;
 	unsigned int num_pkt;
+	bool msg_more;
 	struct {
 		unsigned int mark;
 		unsigned int dontfrag;
@@ -94,7 +96,8 @@ static void __attribute__((noreturn)) cs_usage(const char *bin)
 	       "\t\t-S      send() size\n"
 	       "\t\t-4/-6   Force IPv4 / IPv6 only\n"
 	       "\t\t-p prot Socket protocol\n"
-	       "\t\t        (u = UDP (default); i = ICMP; r = RAW)\n"
+	       "\t\t        (u = UDP (default); i = ICMP; r = RAW;\n"
+	       "\t\t         U = UDP with MSG_MORE)\n"
 	       "\n"
 	       "\t\t-m val  Set SO_MARK with given value\n"
 	       "\t\t-M val  Set SO_MARK via setsockopt\n"
@@ -109,8 +112,8 @@ static void __attribute__((noreturn)) cs_usage(const char *bin)
 	       "\t\t-l val  Set TTL/HOPLIMIT via cmsg\n"
 	       "\t\t-L val  Set TTL/HOPLIMIT via setsockopt\n"
 	       "\t\t-H type Add an IPv6 header option\n"
-	       "\t\t        (h = HOP; d = DST; r = RTDST)"
-	       "");
+	       "\t\t        (h = HOP; d = DST; r = RTDST)\n"
+	       "\n");
 	exit(ERN_HELP);
 }
 
@@ -133,8 +136,11 @@ static void cs_parse_args(int argc, char *argv[])
 			opt.sock.family = AF_INET6;
 			break;
 		case 'p':
-			if (*optarg == 'u' || *optarg == 'U') {
+			if (*optarg == 'u') {
 				opt.sock.proto = IPPROTO_UDP;
+			} else if (*optarg == 'U') {
+				opt.sock.proto = IPPROTO_UDP;
+				opt.msg_more = true;
 			} else if (*optarg == 'i' || *optarg == 'I') {
 				opt.sock.proto = IPPROTO_ICMP;
 			} else if (*optarg == 'r') {
@@ -531,7 +537,7 @@ int main(int argc, char *argv[])
 	cs_write_cmsg(fd, &msg, cbuf, sizeof(cbuf));
 
 	for (i = 0; i < opt.num_pkt; i++) {
-		err = sendmsg(fd, &msg, 0);
+		err = sendmsg(fd, &msg, opt.msg_more ? MSG_MORE : 0);
 		if (err < 0) {
 			if (!opt.silent_send)
 				fprintf(stderr, "send failed: %s\n", strerror(errno));
@@ -542,6 +548,14 @@ int main(int argc, char *argv[])
 			err = ERN_SEND_SHORT;
 			goto err_out;
 		}
+		if (opt.msg_more) {
+			err = write(fd, NULL, 0);
+			if (err < 0) {
+				fprintf(stderr, "send more: %s\n", strerror(errno));
+				err = ERN_SEND_MORE;
+				goto err_out;
+			}
+		}
 	}
 	err = ERN_SUCCESS;
 
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


