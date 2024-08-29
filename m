Return-Path: <netdev+bounces-123183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA11963FA8
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 11:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A0521F25D60
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 09:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD1218CC14;
	Thu, 29 Aug 2024 09:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="VaFtXAgs"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB4914B075
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 09:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724922948; cv=none; b=JO4R+pDZhVZ35yeG/8AqXlu+CRLxkJ/7SIddv13zWOkx55FFX3LKCB3WBHLY9g5P9xPAW9jo6iuCoNPAcDXmJUhG3+zpVAEIFgwJKdyI/H3lMVXLYVPH+g3Ggii0An+tYoB6ozpyvtwirrQSTrr/iOz4e5HXhC225528ffkou/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724922948; c=relaxed/simple;
	bh=HoJMcwH998LfrVgwouN8bnvsRPOR7CLRL6uHCUlxtAE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JcB9WrOMlEvWYu5ZGLMOOW2J5I9/IWK1Tm4XIzyZng288bfLgj5nac5OeFnTUZpcKGUBngRoDs7VbeAX7aUUxqbjRnbDxH6cl2g/NagG4lxGH3tKDB196AhjuoG/7qY5LbgqZio3OJ7eEnhFaZ0AAypjDcU6mgwiKiZaPyOuPIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=VaFtXAgs; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from ubuntu.home (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 4E35A200A8CD;
	Thu, 29 Aug 2024 11:15:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 4E35A200A8CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1724922938;
	bh=MbxIE+79oSC/97t++/71bSmX9xHk3fLteLOTGWu/i+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VaFtXAgsFAYx3mYsuESwDbb0YAJvybLy6imgUCErI/2TSOpJILuM48bXVuHlePxG6
	 2loH861rT5yMt9HdImVDnAWh/7fLTc30/Eoac1LCEIKcMcfUs9LJBB1SsbS3k90nB7
	 u175TJ+RD3GEvaua5ikTpHasy7M3wIJDkTtshHsTzSQrjuTQRmX9YXaunmIr46x0Yc
	 RFFP64P9reqlv9L8DRG2v29ViYNpwfKhTaxPWYvoFJUJEvc1aeZT5alvwNDzTFhu7K
	 dp+ZCDUaiRqQ+bJgeUuQI4GclhIngmHPiehkKODerdYV/EbCYiqHKMGTikfcd+XzTP
	 bhSDle9OVjICA==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	justin.iurman@uliege.be
Subject: [PATCH iproute2-next v3 1/2] ip: lwtunnel: tunsrc support
Date: Thu, 29 Aug 2024 11:15:23 +0200
Message-Id: <20240829091524.8466-2-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829091524.8466-1-justin.iurman@uliege.be>
References: <20240829091524.8466-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for setting/getting the new "tunsrc" feature.

Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
 ip/iproute_lwtunnel.c | 47 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 8 deletions(-)

diff --git a/ip/iproute_lwtunnel.c b/ip/iproute_lwtunnel.c
index b4df4348..a7885dba 100644
--- a/ip/iproute_lwtunnel.c
+++ b/ip/iproute_lwtunnel.c
@@ -352,14 +352,25 @@ static void print_encap_ioam6(FILE *fp, struct rtattr *encap)
 	print_uint(PRINT_ANY, "freqn", "/%u ", freq_n);
 
 	mode = rta_getattr_u8(tb[IOAM6_IPTUNNEL_MODE]);
-	if (!tb[IOAM6_IPTUNNEL_DST] && mode != IOAM6_IPTUNNEL_MODE_INLINE)
+	if ((tb[IOAM6_IPTUNNEL_SRC] && mode == IOAM6_IPTUNNEL_MODE_INLINE) ||
+	    (!tb[IOAM6_IPTUNNEL_DST] && mode != IOAM6_IPTUNNEL_MODE_INLINE))
 		return;
 
 	print_string(PRINT_ANY, "mode", "mode %s ", format_ioam6mode_type(mode));
 
-	if (mode != IOAM6_IPTUNNEL_MODE_INLINE)
-		print_string(PRINT_ANY, "tundst", "tundst %s ",
-			     rt_addr_n2a_rta(AF_INET6, tb[IOAM6_IPTUNNEL_DST]));
+	if (mode != IOAM6_IPTUNNEL_MODE_INLINE) {
+		if (tb[IOAM6_IPTUNNEL_SRC]) {
+			print_color_string(PRINT_ANY, COLOR_INET6,
+					   "tunsrc", "tunsrc %s ",
+					   rt_addr_n2a_rta(AF_INET6,
+							   tb[IOAM6_IPTUNNEL_SRC]));
+		}
+
+		print_color_string(PRINT_ANY, COLOR_INET6,
+				   "tundst", "tundst %s ",
+				   rt_addr_n2a_rta(AF_INET6,
+						   tb[IOAM6_IPTUNNEL_DST]));
+	}
 
 	trace = RTA_DATA(tb[IOAM6_IPTUNNEL_TRACE]);
 
@@ -1111,11 +1122,12 @@ static int parse_encap_ioam6(struct rtattr *rta, size_t len, int *argcp,
 	int ns_found = 0, argc = *argcp;
 	__u16 trace_ns, trace_size = 0;
 	struct ioam6_trace_hdr *trace;
+	inet_prefix saddr, daddr;
 	char **argv = *argvp;
 	__u32 trace_type = 0;
 	__u32 freq_k, freq_n;
 	char buf[16] = {0};
-	inet_prefix addr;
+	bool has_src;
 	__u8 mode;
 
 	if (strcmp(*argv, "freq") != 0) {
@@ -1158,6 +1170,23 @@ static int parse_encap_ioam6(struct rtattr *rta, size_t len, int *argcp,
 		NEXT_ARG();
 	}
 
+	if (strcmp(*argv, "tunsrc") != 0) {
+		has_src = false;
+	} else {
+		has_src = true;
+
+		if (mode == IOAM6_IPTUNNEL_MODE_INLINE)
+			invarg("Inline mode does not need tunsrc", *argv);
+
+		NEXT_ARG();
+
+		get_addr(&saddr, *argv, AF_INET6);
+		if (saddr.family != AF_INET6 || saddr.bytelen != 16)
+			invarg("Invalid IPv6 address for tunsrc", *argv);
+
+		NEXT_ARG();
+	}
+
 	if (strcmp(*argv, "tundst") != 0) {
 		if (mode != IOAM6_IPTUNNEL_MODE_INLINE)
 			missarg("tundst");
@@ -1167,8 +1196,8 @@ static int parse_encap_ioam6(struct rtattr *rta, size_t len, int *argcp,
 
 		NEXT_ARG();
 
-		get_addr(&addr, *argv, AF_INET6);
-		if (addr.family != AF_INET6 || addr.bytelen != 16)
+		get_addr(&daddr, *argv, AF_INET6);
+		if (daddr.family != AF_INET6 || daddr.bytelen != 16)
 			invarg("Invalid IPv6 address for tundst", *argv);
 
 		NEXT_ARG();
@@ -1239,8 +1268,10 @@ static int parse_encap_ioam6(struct rtattr *rta, size_t len, int *argcp,
 	if (rta_addattr32(rta, len, IOAM6_IPTUNNEL_FREQ_K, freq_k) ||
 	    rta_addattr32(rta, len, IOAM6_IPTUNNEL_FREQ_N, freq_n) ||
 	    rta_addattr8(rta, len, IOAM6_IPTUNNEL_MODE, mode) ||
+	    (mode != IOAM6_IPTUNNEL_MODE_INLINE && has_src &&
+	     rta_addattr_l(rta, len, IOAM6_IPTUNNEL_SRC, &saddr.data, saddr.bytelen)) ||
 	    (mode != IOAM6_IPTUNNEL_MODE_INLINE &&
-	     rta_addattr_l(rta, len, IOAM6_IPTUNNEL_DST, &addr.data, addr.bytelen)) ||
+	     rta_addattr_l(rta, len, IOAM6_IPTUNNEL_DST, &daddr.data, daddr.bytelen)) ||
 	    rta_addattr_l(rta, len, IOAM6_IPTUNNEL_TRACE, trace, sizeof(*trace))) {
 		free(trace);
 		return -1;
-- 
2.34.1


