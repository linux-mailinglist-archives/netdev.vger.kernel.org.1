Return-Path: <netdev+bounces-92064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 371DB8B542B
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 11:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A368C1F2063E
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 09:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536C720309;
	Mon, 29 Apr 2024 09:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="BJKdV3FQ"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEAC14A8C
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 09:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714382611; cv=none; b=tbc9sGMf7Cnfojr34U9vm+YLGFJGljMOALaaE/6U7xBLyYjDUnc2Gr+/m3euFLgrV6IXwumzNP6FKqmr+07TCnHQILkVWdKLWRLKKs+jSL/RGCoZobsnwh9VUKPWJLrKj/NO+3nzgqd8o0pXLx/rM47yAr5efRxHY5diw/WR568=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714382611; c=relaxed/simple;
	bh=11xJcqXs/4lGZCUC0RQ3qQyagOuh/WgiYUQZZYuYgmg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q7aQJSvUXuXsit3McyWrLahMishwsDRH8D3YM+YkXQPEFsupEZ4ntHiju89V+PuRVSklNc0uTTB9EXcPni4GA8T+ZsMlgBqkYYWbjLBgDwNYDuOlCKminyTyB5yXQXxWJEitB7Twy8+2ig1iJX3Ly/Z1OcFXSvsM8Va2K2S5ZIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=BJKdV3FQ; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id D78AE8893B;
	Mon, 29 Apr 2024 11:23:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714382607;
	bh=4T2Bd0LFeBidj/9CPE3DyWoSu6F/oVy08mv+xckHUbQ=;
	h=From:To:Cc:Subject:Date:From;
	b=BJKdV3FQ7Ki61PNoYazZu7k5nC9bigNFoOVBB9cKGbS96hQPjvRoeQNmUg+pn3gd1
	 LTiXk04YBqQ26xHngs47+fBhbaGhgaTOKaKnNbA/++gUDkG3/rKZyuEAS6d8cZtgPr
	 E2lUUpWiIZjyx0/S4yNmIDdsmM1czG6YDtQVi+VtQESpSmrMrcoJO8jYVBnra1Dpz1
	 NPZrCIQcqqJHik1PcOMHEliv1q4m5YlDkJ5obGmNQtcPEA5Wo9XrTZdqLMcMDEB6M4
	 YmQAnT0cDFKnWusVOk//qchS/P7hGSZNtnEgBWNFqeM7JiKJIlvxnfN69MnDLERUEc
	 aWCE/9ABwthpg==
From: Lukasz Majewski <lukma@denx.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Lukasz Majewski <lukma@denx.de>
Subject: [RESEND PATCH v3] ip link: hsr: Add support for passing information about INTERLINK device
Date: Mon, 29 Apr 2024 11:23:09 +0200
Message-Id: <20240429092309.2783208-1-lukma@denx.de>
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
Doubly Attached Node for HSR (DANH) and RedBOX (HSR-SAN).

The latter one allows connection of non-HSR aware device(s) to HSR
network.
This node is called SAN (Singly Attached Network) and is connected via
INTERLINK network device.

This patch adds support for passing information about the INTERLINK
device, so the Linux driver can properly setup it.

Signed-off-by: Lukasz Majewski <lukma@denx.de>

---
Changes for v2:

- Rebase the patch on top of iproute2-next/main repo
- Replace matches() with strcmp() when interlink
- Use print_color_string() instead of just print_string()

Changes for v3:
- Add proper description to ip/iplink.c and man/man8/ip-link.8.in
---
 ip/iplink.c           |  4 ++--
 ip/iplink_hsr.c       | 18 +++++++++++++++++-
 man/man8/ip-link.8.in |  5 +++++
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/ip/iplink.c b/ip/iplink.c
index 96f294a2..5b484a9c 100644
--- a/ip/iplink.c
+++ b/ip/iplink.c
@@ -40,8 +40,8 @@ void iplink_types_usage(void)
 	/* Remember to add new entry here if new type is added. */
 	fprintf(stderr,
 		"TYPE := { amt | bareudp | bond | bond_slave | bridge | bridge_slave |\n"
-		"          dsa | dummy | erspan | geneve | gre | gretap | gtp | ifb |\n"
-		"          ip6erspan | ip6gre | ip6gretap | ip6tnl |\n"
+		"          dsa | dummy | erspan | geneve | gre | gretap | gtp | hsr |\n"
+		"          ifb | ip6erspan | ip6gre | ip6gretap | ip6tnl |\n"
 		"          ipip | ipoib | ipvlan | ipvtap |\n"
 		"          macsec | macvlan | macvtap | netdevsim |\n"
 		"          netkit | nlmon | pfcp | rmnet | sit | team | team_slave |\n"
diff --git a/ip/iplink_hsr.c b/ip/iplink_hsr.c
index 76f24a6a..42adb430 100644
--- a/ip/iplink_hsr.c
+++ b/ip/iplink_hsr.c
@@ -21,12 +21,15 @@ static void print_usage(FILE *f)
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
+		"	the interlink device bound to the HSR network to connect SAN device(s)\n"
 		"ADDR-BYTE\n"
 		"	0-255; the last byte of the multicast address used for HSR supervision\n"
 		"	frames (default = 0)\n"
@@ -82,6 +85,12 @@ static int hsr_parse_opt(struct link_util *lu, int argc, char **argv,
 			if (ifindex == 0)
 				invarg("No such interface", *argv);
 			addattr_l(n, 1024, IFLA_HSR_SLAVE2, &ifindex, 4);
+		} else if (strcmp(*argv, "interlink") == 0) {
+			NEXT_ARG();
+			ifindex = ll_name_to_index(*argv);
+			if (ifindex == 0)
+				invarg("No such interface", *argv);
+			addattr_l(n, 1024, IFLA_HSR_INTERLINK, &ifindex, 4);
 		} else if (matches(*argv, "help") == 0) {
 			usage();
 			return -1;
@@ -109,6 +118,9 @@ static void hsr_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 	if (tb[IFLA_HSR_SLAVE2] &&
 	    RTA_PAYLOAD(tb[IFLA_HSR_SLAVE2]) < sizeof(__u32))
 		return;
+	if (tb[IFLA_HSR_INTERLINK] &&
+	    RTA_PAYLOAD(tb[IFLA_HSR_INTERLINK]) < sizeof(__u32))
+		return;
 	if (tb[IFLA_HSR_SEQ_NR] &&
 	    RTA_PAYLOAD(tb[IFLA_HSR_SEQ_NR]) < sizeof(__u16))
 		return;
@@ -132,6 +144,10 @@ static void hsr_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 	else
 		print_null(PRINT_ANY, "slave2", "slave2 %s ", "<none>");
 
+	if (tb[IFLA_HSR_INTERLINK])
+		print_color_string(PRINT_ANY, COLOR_IFNAME, "interlink", "interlink %s ",
+				   ll_index_to_name(rta_getattr_u32(tb[IFLA_HSR_INTERLINK])));
+
 	if (tb[IFLA_HSR_SEQ_NR])
 		print_int(PRINT_ANY,
 			  "seq_nr",
diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index b981ac91..534bb718 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -1626,6 +1626,8 @@ the following additional arguments are supported:
 
 .BI "ip link add link " DEVICE " name " NAME " type hsr"
 .BI slave1 " SLAVE1-IF " slave2 " SLAVE2-IF "
+.RB [ " interlink"
+.IR INTERLINK-IF " ] "
 .RB [ " supervision"
 .IR ADDR-BYTE " ] ["
 .BR version " { " 0 " | " 1 " } ["
@@ -1642,6 +1644,9 @@ the following additional arguments are supported:
 .BI slave2 " SLAVE2-IF "
 - Specifies the physical device used for the second of the two ring ports.
 
+.BI interlink " INTERLINK-IF"
+- The interlink device bound to the HSR network to connect SAN device(s).
+
 .BI supervision " ADDR-BYTE"
 - The last byte of the multicast address used for HSR supervision frames.
 Default option is "0", possible values 0-255.
-- 
2.20.1


