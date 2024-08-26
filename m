Return-Path: <netdev+bounces-121910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BE395F34E
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 15:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92F5E2826D9
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 13:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19490186608;
	Mon, 26 Aug 2024 13:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="JNRvqrzb"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BDE3D71
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 13:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724680373; cv=none; b=k74ou6Dhdd3SiKY8zw02Tx1n4IXKGnMx7fmIAeGApn+54e14EDXnGiQTB28txMsd8ItCFnNI8ZD8fbOiyUDn2UxT4VQCrdHvqdVeeVgVHRUlgOfEMKiiUFh77uQX3D5BtlOQ7YEyhYlHNCEviG4ceQNBaegwBqe5IH8+a34NXuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724680373; c=relaxed/simple;
	bh=FXgm0jPdjRz5aJthT2/oXv7RKfTjgUJFtusz6JcOeGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KjZk2pcsMAnyKRwjgUvQ3y5RG5Zf0AP8xfBVyOfJJOwcPRCKk/vicMDomJyX/2c7Eio1amtrH4gmx8rcEaw0ZU0u+97CblMAASf4tvV1bsTCJUzHuCYDoPnj2ceC4kftCt5gNpL+uu4CNTPBQFjXpdETx+IP/YvJXe374R4/auQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=JNRvqrzb; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 79606200BE72;
	Mon, 26 Aug 2024 15:52:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 79606200BE72
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1724680363;
	bh=fREqxI9gSJIBGlM4uJEIlKc0lTk8GAJP0kbkGkjfLf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JNRvqrzbnJ15ovyvEvmWijUvycXg2TDxNZJuCqzRqMR47muFcsZJbGzx5tmP16pic
	 izp5N6dzpFsoAfeMcSW1rwRIhjsAjdSR8rpcUMSAaEHLJoQ1GIxBARk0ryYAUfF8SK
	 uKFnm0CFFZGhUX4r5OedaVxzVAoKZxArjVy2rL1UmC4H0HRhNccZvpO+ZwSbtK4llX
	 LFBLta5T6D1O+/vC4MECL2i+4XeM0qrrGyKZdg/BcckIsvUKuI+UqKqfWtIEcwbzJ/
	 sYjk4WhdRnP+1lR1U6ZKwYnd2YdVDGxBXvjw3ds1uAmRi2oOqiD6/pRiluiXPbODUv
	 QjuL5HCea7ieg==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH iproute2-next v2 1/2] ip: lwtunnel: tunsrc support
Date: Mon, 26 Aug 2024 15:52:28 +0200
Message-Id: <20240826135229.13220-2-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826135229.13220-1-justin.iurman@uliege.be>
References: <20240826135229.13220-1-justin.iurman@uliege.be>
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


