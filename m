Return-Path: <netdev+bounces-64468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 733F78334AB
	for <lists+netdev@lfdr.de>; Sat, 20 Jan 2024 14:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEFE8B215FD
	for <lists+netdev@lfdr.de>; Sat, 20 Jan 2024 13:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2479DEAE5;
	Sat, 20 Jan 2024 13:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lafranque.net header.i=@lafranque.net header.b="LpbD4rl9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4668F70
	for <netdev@vger.kernel.org>; Sat, 20 Jan 2024 13:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705755626; cv=none; b=CCO1q4fpsxTMLxFaglm7NC1F5PueetGTQFj2Wi08lXlMyL0c8ZgcWM/YNf4syWuXvW/5tMVva3aUVbCQEYL4N/fmgmenjX+h5AY46/0YiajlS0OD+6QaIukEAkPivLN8PCGxzVBPUPXGFzxQnN4113ienWiU/uYg5ns5k90c55M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705755626; c=relaxed/simple;
	bh=YzeFuMkMNZxDx2q+V5m5RV7sekMfXfc07JY8DxRNjEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NmXKQDFbJlP16aUS8IqdiBvbQiq7wjX9SObCocAdDfVmpyGuMeT2li6VXxlXHnCi3hmtnbaozCko45cNGujZlb3r3B36zfVPs5PTRxrHxjM+ZCTI5A8s71cV9N4UBQwqYK5fcLsII8P9hQEdY6RfZtRUTO6gxCE3SMpf7x/gxDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lafranque.net; spf=pass smtp.mailfrom=lafranque.net; dkim=pass (2048-bit key) header.d=lafranque.net header.i=@lafranque.net header.b=LpbD4rl9; arc=none smtp.client-ip=45.157.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lafranque.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lafranque.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4THGQK5jSyzMqpYq;
	Sat, 20 Jan 2024 13:44:25 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4THGQK0f3kzMpnPd;
	Sat, 20 Jan 2024 13:44:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lafranque.net;
	s=20240118; t=1705754665;
	bh=YzeFuMkMNZxDx2q+V5m5RV7sekMfXfc07JY8DxRNjEQ=;
	h=From:To:Cc:Subject:Date:From;
	b=LpbD4rl9mkeHEVmshG6AiPb9KzkN5oft8mJEkhb1TneJvKhtfmNWu2Tx7neI+z8ZC
	 uHPvm2G0iTzDt0azDMm/u90r8kMpU1Gfkp4woLw6O7/zxzBfPH69kaomHZbjoMFI2s
	 IIwXut3YJRGqJE7TVynbzE/PHzT5l9GJWbh7lgGlxIy/pfGJd1wuQIOmr/wxvm2mjj
	 00t5F09yUlBoK/ugHu81j9Y4hOJ0uTAQ/EB1eUQJ07ENP+iJv7TXwt7WzWzHdNnY2H
	 8swyH/spsq7VhiqC23mxHUdSORq1WQTmptCw6b6xs07luf0il2+mpwX55UZ4nn/seR
	 Qf3htsXDilkaw==
From: Alce Lafranque <alce@lafranque.net>
To: netdev@vger.kernel.org,
	stephen@networkplumber.org
Cc: Alce Lafranque <alce@lafranque.net>,
	Vincent Bernat <vincent@bernat.ch>
Subject: [PATCH iproute2] vxlan: add support for flowlab inherit
Date: Sat, 20 Jan 2024 06:44:18 -0600
Message-Id: <20240120124418.26117-1-alce@lafranque.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

By default, VXLAN encapsulation over IPv6 sets the flow label to 0, with
an option for a fixed value. This commits add the ability to inherit the
flow label from the inner packet, like for other tunnel implementations.
This enables devices using only L3 headers for ECMP to correctly balance
VXLAN-encapsulated IPv6 packets.

In relation to the commit "c6e9dba3be5e" ('vxlan: add support for
                                           flowlabel inherit)

```
$ ./ip/ip link add dummy1 type dummy
$ ./ip/ip addr add 2001:db8::2/64 dev dummy1
$ ./ip/ip link set up dev dummy1
$ ./ip/ip link add vxlan1 type vxlan id 100 flowlabel inherit remote 2001:db8::1 local 2001:db8::2
$ ./ip/ip link set up dev vxlan1
$ ./ip/ip addr add 2001:db8:1::2/64 dev vxlan1
$ ./ip/ip link set arp off dev vxlan1
$ ping -q 2001:db8:1::1 &
$ tshark -d udp.port==8472,vxlan -Vpni dummy1 -c1
[...]
Internet Protocol Version 6, Src: 2001:db8::2, Dst: 2001:db8::1
    0110 .... = Version: 6
    .... 0000 0000 .... .... .... .... .... = Traffic Class: 0x00 (DSCP: CS0, ECN: Not-ECT)
        .... 0000 00.. .... .... .... .... .... = Differentiated Services Codepoint: Default (0)
        .... .... ..00 .... .... .... .... .... = Explicit Congestion Notification: Not ECN-Capable Transport (0)
    .... 1011 0001 1010 1111 1011 = Flow Label: 0xb1afb
[...]
Virtual eXtensible Local Area Network
    Flags: 0x0800, VXLAN Network ID (VNI)
    Group Policy ID: 0
    VXLAN Network Identifier (VNI): 100
[...]
Internet Protocol Version 6, Src: 2001:db8:1::2, Dst: 2001:db8:1::1
    0110 .... = Version: 6
    .... 0000 0000 .... .... .... .... .... = Traffic Class: 0x00 (DSCP: CS0, ECN: Not-ECT)
        .... 0000 00.. .... .... .... .... .... = Differentiated Services Codepoint: Default (0)
        .... .... ..00 .... .... .... .... .... = Explicit Congestion Notification: Not ECN-Capable Transport (0)
    .... 1011 0001 1010 1111 1011 = Flow Label: 0xb1afb
```
```
$ ./ip/ip -d l l vxlan1
8: vxlan1: <BROADCAST,MULTICAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/ether 36:2c:83:91:53:9e brd ff:ff:ff:ff:ff:ff promiscuity 0 allmulti 0 minmtu 68 maxmtu 65535
    vxlan id 100 remote 2001:db8::1 local 2001:db8::2 srcport 0 0 dstport 8472 ttl auto flowlabel inherit ageing 300 [...]
```

```
$ ./ip/ip link set vxlan1 type vxlan flowlabel 10
$ ./ip/ip -d l l vxlan1
8: vxlan1: <BROADCAST,MULTICAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/ether 36:2c:83:91:53:9e brd ff:ff:ff:ff:ff:ff promiscuity 0 allmulti 0 minmtu 68 maxmtu 65535
    vxlan id 100 remote 2001:db8::1 local 2001:db8::2 srcport 0 0 dstport 8472 ttl auto flowlabel 0xa ageing 300 [...]
```

Signed-off-by: Alce Lafranque <alce@lafranque.net>
Co-developed-by: Vincent Bernat <vincent@bernat.ch>
Signed-off-by: Vincent Bernat <vincent@bernat.ch>
---
 ip/iplink_vxlan.c | 41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/ip/iplink_vxlan.c b/ip/iplink_vxlan.c
index 7781d60b..0b72a545 100644
--- a/ip/iplink_vxlan.c
+++ b/ip/iplink_vxlan.c
@@ -72,7 +72,7 @@ static void print_explain(FILE *f)
 		"	TOS	:= { NUMBER | inherit }\n"
 		"	TTL	:= { 1..255 | auto | inherit }\n"
 		"	DF	:= { unset | set | inherit }\n"
-		"	LABEL := 0-1048575\n"
+		"	LABEL   := { 0-1048575 | inherit }\n"
 	);
 }
 
@@ -214,10 +214,16 @@ static int vxlan_parse_opt(struct link_util *lu, int argc, char **argv,
 			NEXT_ARG();
 			check_duparg(&attrs, IFLA_VXLAN_LABEL, "flowlabel",
 				     *argv);
-			if (get_u32(&uval, *argv, 0) ||
-			    (uval & ~LABEL_MAX_MASK))
-				invarg("invalid flowlabel", *argv);
-			addattr32(n, 1024, IFLA_VXLAN_LABEL, htonl(uval));
+			if (strcmp(*argv, "inherit") == 0) {
+				addattr32(n, 1024, IFLA_VXLAN_LABEL_POLICY, VXLAN_LABEL_INHERIT);
+			} else {
+				if (get_u32(&uval, *argv, 0) ||
+				    (uval & ~LABEL_MAX_MASK))
+					invarg("invalid flowlabel", *argv);
+				addattr32(n, 1024, IFLA_VXLAN_LABEL_POLICY, VXLAN_LABEL_FIXED);
+				addattr32(n, 1024, IFLA_VXLAN_LABEL,
+					  htonl(uval));
+			}
 		} else if (!matches(*argv, "ageing")) {
 			__u32 age;
 
@@ -580,12 +586,25 @@ static void vxlan_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 			print_string(PRINT_ANY, "df", "df %s ", "inherit");
 	}
 
-	if (tb[IFLA_VXLAN_LABEL]) {
-		__u32 label = rta_getattr_u32(tb[IFLA_VXLAN_LABEL]);
-
-		if (label)
-			print_0xhex(PRINT_ANY, "label",
-				    "flowlabel %#llx ", ntohl(label));
+	enum ifla_vxlan_label_policy policy = VXLAN_LABEL_FIXED;
+	if (tb[IFLA_VXLAN_LABEL_POLICY]) {
+		policy = rta_getattr_u32(tb[IFLA_VXLAN_LABEL_POLICY]);
+	}
+	switch (policy) {
+	case VXLAN_LABEL_FIXED:
+		if (tb[IFLA_VXLAN_LABEL]) {
+			__u32 label = rta_getattr_u32(tb[IFLA_VXLAN_LABEL]);
+
+			if (label)
+				print_0xhex(PRINT_ANY, "label",
+					    "flowlabel %#llx ", ntohl(label));
+		}
+		break;
+	case VXLAN_LABEL_INHERIT:
+		print_string(PRINT_FP, NULL, "flowlabel %s ", "inherit");
+		break;
+	default:
+		break;
 	}
 
 	if (tb[IFLA_VXLAN_AGEING]) {
-- 
2.39.2


