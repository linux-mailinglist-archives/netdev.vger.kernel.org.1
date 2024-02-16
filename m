Return-Path: <netdev+bounces-72385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98506857D96
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 14:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5573D284AD2
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 13:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B67129A7C;
	Fri, 16 Feb 2024 13:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="KVrbIyro"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DC71292F4
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 13:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708089697; cv=none; b=rr1WF/eV4KsEB7oHR6jiGoxqclIl4KtH/4nbIzyenhCSXFnyrMT0VsBiZuTmC3mQvnNZeEEJRb2i2cBBfDMjMioUCEu65sztFklWQXnZF99ymDwDGeQ7KiLwNdmr9MkwQO/uu6Yt5ofX+pKyASS4UGVQQKKzvlmzLXk1D+B8PzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708089697; c=relaxed/simple;
	bh=OgF4aCM9udP+jQVjHy1Lopqloy8u3ulYgAGZ+P07+9M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iqeSLj2z66ROppl1ZxGx7181uuoryNEnTkbbwsm9iyeYKwlk3O5aUcfivp4/vfp9ifpvjw7v2egTso2LN5jnxUobwcN6rneM6ybwb0TNJ2UYT/Qrd2ganSvNNq05x3vxTD+ABik9Hb2L9qIo+Xw1WRoU8CsZHiEGyK+1Hn0tSFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=KVrbIyro; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 364528718A;
	Fri, 16 Feb 2024 14:21:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708089691;
	bh=cx1Tkohw7MR43RIHlKNBQnflQSMvDB/BofzUaMoe+uk=;
	h=From:To:Cc:Subject:Date:From;
	b=KVrbIyro1jgRuIn8NihG2bK28whmvSocj1WkD65JZAVuwch/CXaPIvKDo+TeqthHC
	 qPLNEuJPyq9GyfteILA7wa+bunIgQQaUiOAu/lAAsHOfhy3mAgXeoUyMOOmaYidcB5
	 igmSI2V0XcW7mBiVYrBld1iV47JXbj5fGTcrpP49pPvTJAfY7Mfop3AqAiEckRXtzu
	 fu4A6nnZph0vN0C/4kXMMmxnZCmcbbjp2zkCDH6eYaau7fujA7aRQGT807hoG79ULE
	 VN7t8+boA4mK5tHSGnkAwtaJnQ0kIIH+qVkkLGkXYbkxJvVBah62npDwgniS3F4mnG
	 ffOwX6c7wgy1g==
From: Lukasz Majewski <lukma@denx.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Stephen Hemminger <stephen@networkplumber.org>
Cc: Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH] ip link: hsr: Add support for passing information about INTERLINK device
Date: Fri, 16 Feb 2024 14:21:14 +0100
Message-Id: <20240216132114.2606777-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The HSR capable device can operate in two modes of operations -
Doubly Attached Node for HSR (DANH) and RedBOX.

The latter one allows connection of non-HSR aware device to HSR network.
This node is called SAN (Singly Attached Network) and is connected via
INTERLINK network device.

This patch adds support for passing information about the INTERLINK device,
so the Linux driver can properly setup it.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 include/uapi/linux/if_link.h |  1 +
 ip/iplink_hsr.c              | 22 +++++++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 41708e2..aa70ed6 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1122,6 +1122,7 @@ enum {
 	IFLA_HSR_PROTOCOL,		/* Indicate different protocol than
 					 * HSR. For example PRP.
 					 */
+	IFLA_HSR_INTERLINK,		/* HSR interlink network device */
 	__IFLA_HSR_MAX,
 };
 
diff --git a/ip/iplink_hsr.c b/ip/iplink_hsr.c
index da2d03d..1f048fd 100644
--- a/ip/iplink_hsr.c
+++ b/ip/iplink_hsr.c
@@ -25,12 +25,15 @@ static void print_usage(FILE *f)
 {
 	fprintf(f,
 		"Usage:\tip link add name NAME type hsr slave1 SLAVE1-IF slave2 SLAVE2-IF\n"
-		"\t[ supervision ADDR-BYTE ] [version VERSION] [proto PROTOCOL]\n"
+		"\t[ interlink INTERLINK-IF ] [ supervision ADDR-BYTE ] [ version VERSION ]\n"
+		"\t[ proto PROTOCOL ]\n"
 		"\n"
 		"NAME\n"
 		"	name of new hsr device (e.g. hsr0)\n"
 		"SLAVE1-IF, SLAVE2-IF\n"
 		"	the two slave devices bound to the HSR device\n"
+		"INTERLINK-IF\n"
+		"	the interlink device bound to the HSR network to connect SAN device\n"
 		"ADDR-BYTE\n"
 		"	0-255; the last byte of the multicast address used for HSR supervision\n"
 		"	frames (default = 0)\n"
@@ -86,6 +89,12 @@ static int hsr_parse_opt(struct link_util *lu, int argc, char **argv,
 			if (ifindex == 0)
 				invarg("No such interface", *argv);
 			addattr_l(n, 1024, IFLA_HSR_SLAVE2, &ifindex, 4);
+		} else if (matches(*argv, "interlink") == 0) {
+			NEXT_ARG();
+			ifindex = ll_name_to_index(*argv);
+			if (ifindex == 0)
+				invarg("No such interface", *argv);
+			addattr_l(n, 1024, IFLA_HSR_INTERLINK, &ifindex, 4);
 		} else if (matches(*argv, "help") == 0) {
 			usage();
 			return -1;
@@ -113,6 +122,9 @@ static void hsr_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 	if (tb[IFLA_HSR_SLAVE2] &&
 	    RTA_PAYLOAD(tb[IFLA_HSR_SLAVE2]) < sizeof(__u32))
 		return;
+	if (tb[IFLA_HSR_INTERLINK] &&
+	    RTA_PAYLOAD(tb[IFLA_HSR_INTERLINK]) < sizeof(__u32))
+		return;
 	if (tb[IFLA_HSR_SEQ_NR] &&
 	    RTA_PAYLOAD(tb[IFLA_HSR_SEQ_NR]) < sizeof(__u16))
 		return;
@@ -136,6 +148,14 @@ static void hsr_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 	else
 		print_null(PRINT_ANY, "slave2", "slave2 %s ", "<none>");
 
+	if (tb[IFLA_HSR_INTERLINK])
+		print_string(PRINT_ANY,
+			     "interlink",
+			     "interlink %s ",
+			     ll_index_to_name(rta_getattr_u32(tb[IFLA_HSR_INTERLINK])));
+	else
+		print_null(PRINT_ANY, "interlink", "interlink %s ", "<none>");
+
 	if (tb[IFLA_HSR_SEQ_NR])
 		print_int(PRINT_ANY,
 			  "seq_nr",
-- 
2.20.1


