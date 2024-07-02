Return-Path: <netdev+bounces-108442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7303923D42
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 14:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EF731F2317F
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 12:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6CC16B390;
	Tue,  2 Jul 2024 12:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="ykJKPOqu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C66C15D5B3
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 12:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719922116; cv=none; b=figIMdNiWyglc9lAj18Ie+yFjAxBTGZlgh7d64FZ+0KfzaB5Fqym3DPeSZZJOD+IAGEF6YeiKoETrJeTe55o/8Chtb6ta6Bgh5VInhhl52ekAr3VxfFffQb0DgGL/UxPtGdYqlaSvMohChvTgSirP9JfX+fwkinYyyk9qqv+w/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719922116; c=relaxed/simple;
	bh=hsftkSP2BDiz9TglzlG9ee1wDJWfkHJpC75tpg0xtkg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AOJIbBHl+FpmGB/ZYojtZKvTs3EiPugXxK1HqkXx0AoOm8DJm/hcgoEawRlHFQlkGeqLq47mO//4BF6JkM5YGkI5+4MF7mKleTlCT4+ZzT2VVMO8e11ZRucF8shb2yWxQ+Xw8d05jUhDjBoSfmdK52bgqi9C/2wb7hjrVAbz7Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=ykJKPOqu; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52cdb0d816bso4050658e87.1
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 05:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1719922112; x=1720526912; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8j4YJnckxoKym+ZcM9ZDthFzWyUhM2Uf5fbtBbrDdx4=;
        b=ykJKPOqu7DueqzQ2GrhFUbFJ+wGCpY9ihKUoGAOsenKmD8ZGEvFBmq9Jqo1LNqO0tj
         iIq/emaFr914xAr7OvllebgeiK45MZatc+7aaIs1c5TsjDchRm/61M93EhsXjJp+4jLV
         M3boSQWKHT8g45XTWbO3fAB1p9Y1wxcdtmS2OK2VnrLfHJc9fAUwumggQMr1lDJCesE1
         rKq3Xr2Dq3gOCcSf71szUz3iGDzGsktRuxXBqkIw7A0erW7tTT5x55Q5KgYe7xY5o8la
         F1EigN0MQsgTqnUjQEK4mlKD9TFqBhaQ35u2Uasrvs0/uYDaTQF92ZXwPYBC6Y7qXuip
         gy6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719922112; x=1720526912;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8j4YJnckxoKym+ZcM9ZDthFzWyUhM2Uf5fbtBbrDdx4=;
        b=fwOD1D6azn1/7QMFde17iOZ4RYD/cqfUwfBYXZCQrHB+77KUs1bcxZDLj27IQCOzve
         OJ2wjxd7cJ/NanpaWcL2Bs9JE2rWlf5njc5KPGjjCxg8wwtv3BEfYesye2Bfndx+eNq0
         gr7tLdx6JIT0owYyK7eYjQUcJ7wnZsfmYsHRei3lFwrbiatlEyaE3m86jt13CB9bDyjy
         t3xYwG9dIlJNjrNz21RknJu3hIDj3DVHFRghjrRc+FeJeOklU7M/C1lZpXE8DwWDJCtQ
         4hEBSaA/bLvxpV3UdDpLmuMd6fFu8CGOvlJO63c8ej1xXGGM+1iLoJBCYzzoWiupm9Z0
         LSSA==
X-Forwarded-Encrypted: i=1; AJvYcCXfFg9AF2jkrEjNEdlw+jQW3dpU0aMQruHbIwAwEaOQ1SD4f1knvSH1hTlhXiOOqDuOOeEc7yXfRxisRTV2xRTQReOo0lTY
X-Gm-Message-State: AOJu0Yz8asPDNwtx9pgpOiAmetqTHjym89Db2bXHiPyZ8mTClL56+ex/
	5ySm3ELPlsiDIqLm9BwHjs0G8eedMgiVK7kS9OnrcLV9QHXSL8Je0LJ7hyH1ktg=
X-Google-Smtp-Source: AGHT+IGr4wQPv5afUFDcinzrJ0DCOrcAewoDqVAFuxi9J7/AILw78OE4VOEWMCvm39t77WUoK8ZTEA==
X-Received: by 2002:a05:6512:3e0c:b0:52c:ca8d:d1c with SMTP id 2adb3069b0e04-52e825976ecmr2619228e87.2.1719922112246;
        Tue, 02 Jul 2024 05:08:32 -0700 (PDT)
Received: from wkz-x13.addiva.ad (h-176-10-146-181.NA.cust.bahnhof.se. [176.10.146.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab1064asm1799414e87.103.2024.07.02.05.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 05:08:31 -0700 (PDT)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: stephen@networkplumber.org,
	dsahern@kernel.org,
	roopa@nvidia.com,
	razor@blackwall.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org
Cc: liuhangbin@gmail.com
Subject: [PATCH v3 iproute2 2/4] bridge: Remove duplicated textification macros
Date: Tue,  2 Jul 2024 14:08:03 +0200
Message-Id: <20240702120805.2391594-3-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240702120805.2391594-1-tobias@waldekranz.com>
References: <20240702120805.2391594-1-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

include/utils.h already provides textify(), which is functionally
equivalent to __stringify().

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 bridge/vlan.c | 41 +++++++++++++++++++----------------------
 bridge/vni.c  | 15 ++++++---------
 2 files changed, 25 insertions(+), 31 deletions(-)

diff --git a/bridge/vlan.c b/bridge/vlan.c
index 0a7e6c45..70f01aff 100644
--- a/bridge/vlan.c
+++ b/bridge/vlan.c
@@ -28,9 +28,6 @@ enum vlan_show_subject {
 
 #define VLAN_ID_LEN 9
 
-#define __stringify_1(x...) #x
-#define __stringify(x...) __stringify_1(x)
-
 static void usage(void)
 {
 	fprintf(stderr,
@@ -579,7 +576,7 @@ static void open_vlan_port(int ifi_index, enum vlan_show_subject subject)
 {
 	open_json_object(NULL);
 	print_color_string(PRINT_ANY, COLOR_IFNAME, "ifname",
-			   "%-" __stringify(IFNAMSIZ) "s  ",
+			   "%-" textify(IFNAMSIZ) "s  ",
 			   ll_index_to_name(ifi_index));
 	open_json_array(PRINT_JSON,
 			subject == VLAN_SHOW_VLAN ? "vlans": "tunnels");
@@ -643,7 +640,7 @@ static void print_vlan_tunnel_info(struct rtattr *tb, int ifindex)
 			opened = true;
 		} else {
 			print_string(PRINT_FP, NULL,
-				     "%-" __stringify(IFNAMSIZ) "s  ", "");
+				     "%-" textify(IFNAMSIZ) "s  ", "");
 		}
 
 		open_json_object(NULL);
@@ -716,13 +713,13 @@ static void print_vlan_flags(__u16 flags)
 
 static void __print_one_vlan_stats(const struct bridge_vlan_xstats *vstats)
 {
-	print_string(PRINT_FP, NULL, "%-" __stringify(IFNAMSIZ) "s    ", "");
+	print_string(PRINT_FP, NULL, "%-" textify(IFNAMSIZ) "s    ", "");
 	print_lluint(PRINT_ANY, "rx_bytes", "RX: %llu bytes",
 		     vstats->rx_bytes);
 	print_lluint(PRINT_ANY, "rx_packets", " %llu packets\n",
 		     vstats->rx_packets);
 
-	print_string(PRINT_FP, NULL, "%-" __stringify(IFNAMSIZ) "s    ", "");
+	print_string(PRINT_FP, NULL, "%-" textify(IFNAMSIZ) "s    ", "");
 	print_lluint(PRINT_ANY, "tx_bytes", "TX: %llu bytes",
 		     vstats->tx_bytes);
 	print_lluint(PRINT_ANY, "tx_packets", " %llu packets\n",
@@ -776,7 +773,7 @@ static void print_vlan_stats_attr(struct rtattr *attr, int ifindex)
 			found_vlan = true;
 		} else {
 			print_string(PRINT_FP, NULL,
-				     "%-" __stringify(IFNAMSIZ) "s  ", "");
+				     "%-" textify(IFNAMSIZ) "s  ", "");
 		}
 		print_one_vlan_stats(vstats);
 	}
@@ -822,7 +819,7 @@ static void print_vlan_router_ports(struct rtattr *rattr)
 	int rem = RTA_PAYLOAD(rattr);
 	struct rtattr *i;
 
-	print_string(PRINT_FP, NULL, "%-" __stringify(IFNAMSIZ) "s    ", "");
+	print_string(PRINT_FP, NULL, "%-" textify(IFNAMSIZ) "s    ", "");
 	open_json_array(PRINT_ANY, is_json_context() ? "router_ports" :
 						       "router ports: ");
 	for (i = RTA_DATA(rattr); RTA_OK(i, rem); i = RTA_NEXT(i, rem)) {
@@ -834,7 +831,7 @@ static void print_vlan_router_ports(struct rtattr *rattr)
 			print_nl();
 			/* start: IFNAMSIZ + 4 + strlen("router ports: ") */
 			print_string(PRINT_FP, NULL,
-				     "%-" __stringify(IFNAMSIZ) "s    "
+				     "%-" textify(IFNAMSIZ) "s    "
 				     "              ",
 				     "");
 		}
@@ -872,11 +869,11 @@ static void print_vlan_global_opts(struct rtattr *a, int ifindex)
 		vlan_rtm_cur_ifidx = ifindex;
 	} else {
 		open_json_object(NULL);
-		print_string(PRINT_FP, NULL, "%-" __stringify(IFNAMSIZ) "s  ", "");
+		print_string(PRINT_FP, NULL, "%-" textify(IFNAMSIZ) "s  ", "");
 	}
 	print_range("vlan", vid, vrange);
 	print_nl();
-	print_string(PRINT_FP, NULL, "%-" __stringify(IFNAMSIZ) "s    ", "");
+	print_string(PRINT_FP, NULL, "%-" textify(IFNAMSIZ) "s    ", "");
 	if (vtb[BRIDGE_VLANDB_GOPTS_MCAST_SNOOPING]) {
 		vattr = vtb[BRIDGE_VLANDB_GOPTS_MCAST_SNOOPING];
 		print_uint(PRINT_ANY, "mcast_snooping", "mcast_snooping %u ",
@@ -1012,12 +1009,12 @@ static void print_vlan_opts(struct rtattr *a, int ifindex)
 		vlan_rtm_cur_ifidx = ifindex;
 	} else {
 		open_json_object(NULL);
-		print_string(PRINT_FP, NULL, "%-" __stringify(IFNAMSIZ) "s  ", "");
+		print_string(PRINT_FP, NULL, "%-" textify(IFNAMSIZ) "s  ", "");
 	}
 	print_range("vlan", vinfo->vid, vrange);
 	print_vlan_flags(vinfo->flags);
 	print_nl();
-	print_string(PRINT_FP, NULL, "%-" __stringify(IFNAMSIZ) "s    ", "");
+	print_string(PRINT_FP, NULL, "%-" textify(IFNAMSIZ) "s    ", "");
 	print_stp_state(state);
 	if (vtb[BRIDGE_VLANDB_ENTRY_MCAST_ROUTER]) {
 		vattr = vtb[BRIDGE_VLANDB_ENTRY_MCAST_ROUTER];
@@ -1155,8 +1152,8 @@ static int vlan_show(int argc, char **argv, int subject)
 		}
 
 		if (!is_json_context()) {
-			printf("%-" __stringify(IFNAMSIZ) "s  %-"
-			       __stringify(VLAN_ID_LEN) "s", "port",
+			printf("%-" textify(IFNAMSIZ) "s  %-"
+			       textify(VLAN_ID_LEN) "s", "port",
 			       "vlan-id");
 			printf("\n");
 		}
@@ -1183,8 +1180,8 @@ static int vlan_show(int argc, char **argv, int subject)
 		}
 
 		if (!is_json_context()) {
-			printf("%-" __stringify(IFNAMSIZ) "s  %-"
-			       __stringify(VLAN_ID_LEN) "s", "port",
+			printf("%-" textify(IFNAMSIZ) "s  %-"
+			       textify(VLAN_ID_LEN) "s", "port",
 			       "vlan-id");
 			if (subject == VLAN_SHOW_TUNNELINFO)
 				printf("  tunnel-id");
@@ -1207,7 +1204,7 @@ static int vlan_show(int argc, char **argv, int subject)
 		}
 
 		if (!is_json_context())
-			printf("%-" __stringify(IFNAMSIZ) "s  vlan-id\n",
+			printf("%-" textify(IFNAMSIZ) "s  vlan-id\n",
 			       "port");
 
 		if (rtnl_dump_filter(&rth, print_vlan_stats, stdout) < 0) {
@@ -1269,8 +1266,8 @@ static int vlan_global_show(int argc, char **argv)
 	}
 
 	if (!is_json_context()) {
-		printf("%-" __stringify(IFNAMSIZ) "s  %-"
-		       __stringify(VLAN_ID_LEN) "s", "port",
+		printf("%-" textify(IFNAMSIZ) "s  %-"
+		       textify(VLAN_ID_LEN) "s", "port",
 		       "vlan-id");
 		printf("\n");
 	}
@@ -1318,7 +1315,7 @@ static void print_vlan_info(struct rtattr *tb, int ifindex)
 			opened = true;
 		} else {
 			print_string(PRINT_FP, NULL, "%-"
-				     __stringify(IFNAMSIZ) "s  ", "");
+				     textify(IFNAMSIZ) "s  ", "");
 		}
 
 		open_json_object(NULL);
diff --git a/bridge/vni.c b/bridge/vni.c
index e1f981fc..57b04c8c 100644
--- a/bridge/vni.c
+++ b/bridge/vni.c
@@ -27,9 +27,6 @@ static unsigned int filter_index;
 /* max len of "<start>-<end>" */
 #define VXLAN_ID_LEN 17
 
-#define __stringify_1(x...) #x
-#define __stringify(x...) __stringify_1(x)
-
 static void usage(void)
 {
 	fprintf(stderr,
@@ -153,7 +150,7 @@ static void open_vni_port(int ifi_index)
 {
 	open_json_object(NULL);
 	print_color_string(PRINT_ANY, COLOR_IFNAME, "ifname",
-			   "%-" __stringify(IFNAMSIZ) "s  ",
+			   "%-" textify(IFNAMSIZ) "s  ",
 			   ll_index_to_name(ifi_index));
 	open_json_array(PRINT_JSON, "vnis");
 }
@@ -174,7 +171,7 @@ static void print_vnifilter_entry_stats(struct rtattr *stats_attr)
 			   RTA_PAYLOAD(stats_attr), NLA_F_NESTED);
 
 	print_nl();
-	print_string(PRINT_FP, NULL, "%-" __stringify(IFNAMSIZ) "s    RX: ",
+	print_string(PRINT_FP, NULL, "%-" textify(IFNAMSIZ) "s    RX: ",
 		     "");
 
 	if (stb[VNIFILTER_ENTRY_STATS_RX_BYTES]) {
@@ -195,7 +192,7 @@ static void print_vnifilter_entry_stats(struct rtattr *stats_attr)
 	}
 
 	print_nl();
-	print_string(PRINT_FP, NULL, "%-" __stringify(IFNAMSIZ) "s    TX: ",
+	print_string(PRINT_FP, NULL, "%-" textify(IFNAMSIZ) "s    TX: ",
 		     "");
 
 	if (stb[VNIFILTER_ENTRY_STATS_TX_BYTES]) {
@@ -327,7 +324,7 @@ int print_vnifilter_rtm(struct nlmsghdr *n, void *arg)
 			open_vni_port(tmsg->ifindex);
 			opened = true;
 		} else {
-			print_string(PRINT_FP, NULL, "%-" __stringify(IFNAMSIZ) "s  ", "");
+			print_string(PRINT_FP, NULL, "%-" textify(IFNAMSIZ) "s  ", "");
 		}
 
 		print_vni(t, tmsg->ifindex);
@@ -373,8 +370,8 @@ static int vni_show(int argc, char **argv)
 	}
 
 	if (!is_json_context())
-		printf("%-" __stringify(IFNAMSIZ) "s  %-"
-		       __stringify(VXLAN_ID_LEN) "s  group/remote\n", "dev",
+		printf("%-" textify(IFNAMSIZ) "s  %-"
+		       textify(VXLAN_ID_LEN) "s  group/remote\n", "dev",
 		       "vni");
 
 	ret = rtnl_dump_filter(&rth, print_vnifilter_rtm, NULL);
-- 
2.34.1


