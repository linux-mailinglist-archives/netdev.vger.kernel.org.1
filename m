Return-Path: <netdev+bounces-84004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D56628953D7
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 14:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 054001C20FE2
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 12:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7129E82886;
	Tue,  2 Apr 2024 12:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="dQWYdpT3"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE747A13A
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 12:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712062185; cv=none; b=ZiKX6sniTVKLIpCwaV6rc8nl/qgJWhZe6iLjmi5kTTHd64vg0svwI42k4NLH1l2sREX35QWKo9mnJBa3iGpjaSAnDLbEGtiKbcp7p2K318/Kiu5hMlx4HNwGmNmvRd+j0OVYaiXZNdo8phnGmwnIejv5xM73oAwQhy5xcZxxeps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712062185; c=relaxed/simple;
	bh=v+oTTNESWicjDBR0yqs5CnJXAYHlssslWQYYtzE8F9I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IpznKLPMSMqsk1nffK393V0qb8z+AiHcbEn+K9asr8GufdOtFKR97YmxKUmYcfXqYQYMyWWLV9RLsJU3r2ZYfo9B2nU6tZe4Ys9sr7u5NSNbzRALBc90Sp0+0qnzbq5y4JWvpVYf7JgWEWNPvKs/H15MASET9oKKps2LEu+OwlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=dQWYdpT3; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 41D3187FAC;
	Tue,  2 Apr 2024 14:49:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1712062174;
	bh=oazjyrVpBxNemhUFO7ObiQTTN3vjVSzh7odG5U7chAw=;
	h=From:To:Cc:Subject:Date:From;
	b=dQWYdpT3TGzlZGihqdQ565lODC+yVC6zoiaOpa/MTRfvy4g6rOjNYyvVvAge5LhNF
	 U4LaF+pYlcaoJJOPHTEWPMwp2xkcPDkU/HTpEZQC+kZQlucHJ/zK9pqABlNgihL81a
	 7DpG89HGreIV94WHY/EU0wtSO2ahbtLaqE+IufOuJ7GIbEQVdB583sOuTEO0BsjtxE
	 tVepzdHbcPxUKt4/dTXz223Y4xoi4oyapyE1L51aR/Lz4L/41evwkXNDEVfNONStkS
	 Jrn12004XXCk2jeLjaYLbuegUbixIp0keP0WfocWqAO8fcRkHC5ZunpuVsFkq4ACNE
	 FSye8OaOLqNDQ==
From: Lukasz Majewski <lukma@denx.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Stephen Hemminger <stephen@networkplumber.org>
Cc: Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v3] ip link: hsr: Add support for passing information about INTERLINK device
Date: Tue,  2 Apr 2024 14:49:08 +0200
Message-Id: <20240402124908.251648-1-lukma@denx.de>
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
index 95314af5..bca365ce 100644
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
 		"          netkit | nlmon | rmnet | sit | team | team_slave |\n"
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
index 31e2d7f0..8aab29bf 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -1621,6 +1621,8 @@ the following additional arguments are supported:
 
 .BI "ip link add link " DEVICE " name " NAME " type hsr"
 .BI slave1 " SLAVE1-IF " slave2 " SLAVE2-IF "
+.RB [ " interlink"
+.IR INTERLINK-IF " ] "
 .RB [ " supervision"
 .IR ADDR-BYTE " ] ["
 .BR version " { " 0 " | " 1 " } ["
@@ -1637,6 +1639,9 @@ the following additional arguments are supported:
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


