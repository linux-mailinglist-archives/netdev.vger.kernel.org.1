Return-Path: <netdev+bounces-117200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 013ED94D0EA
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 15:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F9B9B22D65
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 13:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCEF19539F;
	Fri,  9 Aug 2024 13:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="uGkrEs2f"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0E3194C62
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 13:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723209272; cv=none; b=YYSWxn+0Xtg5l2ZdgPgAUh1dGpE4qz+3vQV8xVRqAM0JhQ1keXAWeo9muNGpZdVyVJ6BtSFumsAhLXc6/ibU1NERdU6WO3Pg/qhoLtd77CWxPrHDBsUYFf7XFvSWOVlhrnhs/Yh8KGJf9UY7RjV6K3Fi2sdiqxgCHzQRLeciXn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723209272; c=relaxed/simple;
	bh=FXgm0jPdjRz5aJthT2/oXv7RKfTjgUJFtusz6JcOeGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S8StO0g9sY1wrgEg1DVl1VnfMyVVMiKL/lUiu+VKkaKgVFMy5gTj6uzOzsFN47fF3V/LGCDbSbJk1961Ejz5KEE8aJ57IhcnTDCJJNI3J8FUhsh9Rvzf0M/OCgJP8rFqpTMvdIrWBEfAEDcsjkfQ9ZoVhYumpKcI6Oe98KEe5yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=uGkrEs2f; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id B29AB200CCF0;
	Fri,  9 Aug 2024 15:14:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be B29AB200CCF0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1723209268;
	bh=fREqxI9gSJIBGlM4uJEIlKc0lTk8GAJP0kbkGkjfLf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uGkrEs2fCriqMGN388aQK5NLfl8DPYwZ7c8UQHg7jVnJamZBF+5kNJYY/2vuVWhfc
	 Jqh19koTUR6Ok/PxtXw7TGo6lnppTIjOX4JA4WhF+Yf/Ng79juz2tnH1/l/n8VMC6e
	 l9HX5ss4rFWyE8L4p35eEKsxNtJLK8serQEAl58Nw7om2r/dQWK4loperhG+pi4rAh
	 7nbZ3qMj4FaNxp0TXqINwjMBpcOTL3qiVN6DjNR1nN0gV1TbyG4HkZduWEnf3iMiD9
	 6eg3C1EElPIElM1yWD+Aa/wBUcORhRKmtjkZUtOyST6g/7B5/gsyKRhfHIeggbsdSV
	 8bVThBo6OADkg==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH iproute2-next 2/3] ip: lwtunnel: tunsrc support
Date: Fri,  9 Aug 2024 15:14:18 +0200
Message-Id: <20240809131419.30732-3-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809131419.30732-1-justin.iurman@uliege.be>
References: <20240809131419.30732-1-justin.iurman@uliege.be>
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
 ip/iproute_lwtunnel.c | 40 ++++++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/ip/iproute_lwtunnel.c b/ip/iproute_lwtunnel.c
index b4df4348..009045cb 100644
--- a/ip/iproute_lwtunnel.c
+++ b/ip/iproute_lwtunnel.c
@@ -352,14 +352,22 @@ static void print_encap_ioam6(FILE *fp, struct rtattr *encap)
 	print_uint(PRINT_ANY, "freqn", "/%u ", freq_n);
 
 	mode = rta_getattr_u8(tb[IOAM6_IPTUNNEL_MODE]);
-	if (!tb[IOAM6_IPTUNNEL_DST] && mode != IOAM6_IPTUNNEL_MODE_INLINE)
+	if ((tb[IOAM6_IPTUNNEL_SRC] && mode == IOAM6_IPTUNNEL_MODE_INLINE) ||
+	    (!tb[IOAM6_IPTUNNEL_DST] && mode != IOAM6_IPTUNNEL_MODE_INLINE))
 		return;
 
 	print_string(PRINT_ANY, "mode", "mode %s ", format_ioam6mode_type(mode));
 
-	if (mode != IOAM6_IPTUNNEL_MODE_INLINE)
+	if (mode != IOAM6_IPTUNNEL_MODE_INLINE) {
+		if (tb[IOAM6_IPTUNNEL_SRC]) {
+			print_string(PRINT_ANY, "tunsrc", "tunsrc %s ",
+				     rt_addr_n2a_rta(AF_INET6,
+						     tb[IOAM6_IPTUNNEL_SRC]));
+		}
+
 		print_string(PRINT_ANY, "tundst", "tundst %s ",
 			     rt_addr_n2a_rta(AF_INET6, tb[IOAM6_IPTUNNEL_DST]));
+	}
 
 	trace = RTA_DATA(tb[IOAM6_IPTUNNEL_TRACE]);
 
@@ -1111,11 +1119,12 @@ static int parse_encap_ioam6(struct rtattr *rta, size_t len, int *argcp,
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
@@ -1158,6 +1167,23 @@ static int parse_encap_ioam6(struct rtattr *rta, size_t len, int *argcp,
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
@@ -1167,8 +1193,8 @@ static int parse_encap_ioam6(struct rtattr *rta, size_t len, int *argcp,
 
 		NEXT_ARG();
 
-		get_addr(&addr, *argv, AF_INET6);
-		if (addr.family != AF_INET6 || addr.bytelen != 16)
+		get_addr(&daddr, *argv, AF_INET6);
+		if (daddr.family != AF_INET6 || daddr.bytelen != 16)
 			invarg("Invalid IPv6 address for tundst", *argv);
 
 		NEXT_ARG();
@@ -1239,8 +1265,10 @@ static int parse_encap_ioam6(struct rtattr *rta, size_t len, int *argcp,
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


