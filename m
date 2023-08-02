Return-Path: <netdev+bounces-23697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8D876D2DA
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 17:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F164281AE6
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 15:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387C6C8E9;
	Wed,  2 Aug 2023 15:50:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D27F79FF
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 15:50:26 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5576A3C11
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 08:50:04 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372FNWYe003068;
	Wed, 2 Aug 2023 08:49:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=g7jHk0NMOeN0ZdspY30y7UfYFG9MbqMqEuNM9wVa6nE=;
 b=T1Ybro+NYgsFhez22a+7S8j/SKMpCXAmch/QD42up/ZY5X19Lnz0Zi2HnGyCOKdusuNR
 QTdGZEplfxboVfoVY47a5BDb6L8wDuhC+BCzieqkMrDxeFL1Avtm4t924I7r6q+A6x79
 7sdQSYLW7KZOCKExD5YQTrKdbtyIYhVSFmbe3YTfPBOvBW80Gyjcftre3kiFToD2eth6
 edu9UJELT9rmEvnLJrDgwEowYDW+4Y417MpjfYu3cdikrKL1itoobB0xSanaBDjUpXBZ
 SQly7AP3SMoPPe9EyBEpWl/wn0gIkk23KWdIchTFQFIMsqOVRbbgxjoIsKLELzxTLA46 pQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3s767n44k2-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Wed, 02 Aug 2023 08:49:50 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 2 Aug
 2023 08:49:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 2 Aug 2023 08:49:45 -0700
Received: from marvell-OptiPlex-7090.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 71F5E3F7086;
	Wed,  2 Aug 2023 08:49:43 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <dsahern@gmail.com>, <stephen@networkplumber.org>
CC: <netdev@vger.kernel.org>, Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH v1 iproute2-next] tc: Classifier support for SPI field
Date: Wed, 2 Aug 2023 21:19:41 +0530
Message-ID: <20230802154941.3743680-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 9gFpXiiHBQF4F3_oYV4gBiqEbAiHOYHi
X-Proofpoint-ORIG-GUID: 9gFpXiiHBQF4F3_oYV4gBiqEbAiHOYHi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_12,2023-08-01_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

tc flower support for SPI field in ESP and AH packets.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

---
ChangeLog

v0 -> v1 : Rebased the patch
---
 tc/f_flower.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/tc/f_flower.c b/tc/f_flower.c
index 737df199..53188f1c 100644
--- a/tc/f_flower.c
+++ b/tc/f_flower.c
@@ -60,7 +60,7 @@ static void explain(void)
 		"			ppp_proto [ ipv4 | ipv6 | mpls_uc | mpls_mc | PPP_PROTO ] |\n"
 		"			dst_mac MASKED-LLADDR |\n"
 		"			src_mac MASKED-LLADDR |\n"
-		"			ip_proto [tcp | udp | sctp | icmp | icmpv6 | l2tp | IP-PROTO ] |\n"
+		"			ip_proto [tcp | udp | sctp | icmp | icmpv6 | l2tp | esp | ah | IP-PROTO ] |\n"
 		"			ip_tos MASKED-IP_TOS |\n"
 		"			ip_ttl MASKED-IP_TTL |\n"
 		"			mpls LSE-LIST |\n"
@@ -68,6 +68,7 @@ static void explain(void)
 		"			mpls_tc TC |\n"
 		"			mpls_bos BOS |\n"
 		"			mpls_ttl TTL |\n"
+		"			spi SPI-INDEX  |\n"
 		"			l2tpv3_sid LSID |\n"
 		"			dst_ip PREFIX |\n"
 		"			src_ip PREFIX |\n"
@@ -437,6 +438,16 @@ static int flower_parse_ip_proto(char *str, __be16 eth_type, int type,
 		    eth_type != htons(ETH_P_IPV6))
 			goto err;
 		ip_proto = IPPROTO_L2TP;
+	} else if (!strcmp(str, "esp")) {
+		if (eth_type != htons(ETH_P_IP) &&
+		    eth_type != htons(ETH_P_IPV6))
+			goto err;
+		ip_proto = IPPROTO_ESP;
+	} else if (!strcmp(str, "ah")) {
+		if (eth_type != htons(ETH_P_IP) &&
+		    eth_type != htons(ETH_P_IPV6))
+			goto err;
+		ip_proto = IPPROTO_AH;
 	} else {
 		ret = get_u8(&ip_proto, str, 16);
 		if (ret)
@@ -655,6 +666,29 @@ static int flower_parse_icmp(char *str, __u16 eth_type, __u8 ip_proto,
 	return flower_parse_u8(str, value_type, mask_type, NULL, NULL, n);
 }
 
+static int flower_parse_spi(char *str, __u8 ip_proto, struct nlmsghdr *n)
+{
+	__be32 spi;
+	int ret;
+
+	if (ip_proto != IPPROTO_UDP && ip_proto != IPPROTO_ESP && ip_proto != IPPROTO_AH) {
+		fprintf(stderr,
+			"Can't set \"spi\" if ip_proto isn't ESP/UDP/AH\n");
+		return -1;
+	}
+
+	ret = get_be32(&spi, str, 16);
+	if (ret < 0) {
+		fprintf(stderr, "Illegal \"spi index\"\n");
+		return -1;
+	}
+
+	addattr32(n, MAX_MSG, TCA_FLOWER_KEY_SPI, spi);
+	addattr32(n, MAX_MSG, TCA_FLOWER_KEY_SPI_MASK, UINT32_MAX);
+
+	return 0;
+}
+
 static int flower_parse_l2tpv3(char *str, __u8 ip_proto,
 			       struct nlmsghdr *n)
 {
@@ -1936,6 +1970,11 @@ static int flower_parse_opt(struct filter_util *qu, char *handle,
 			ret = flower_parse_l2tpv3(*argv, ip_proto, n);
 			if (ret < 0)
 				return -1;
+		} else if (!strcmp(*argv, "spi")) {
+			NEXT_ARG();
+			ret = flower_parse_spi(*argv, ip_proto, n);
+			if (ret < 0)
+				return -1;
 		} else if (matches(*argv, "arp_tip") == 0) {
 			NEXT_ARG();
 			ret = flower_parse_arp_ip_addr(*argv, eth_type,
@@ -2257,8 +2296,12 @@ static void flower_print_ip_proto(__u8 *p_ip_proto,
 		sprintf(out, "icmpv6");
 	else if (ip_proto == IPPROTO_L2TP)
 		sprintf(out, "l2tp");
+	else if (ip_proto == IPPROTO_ESP)
+		sprintf(out, "esp");
+	else if (ip_proto == IPPROTO_AH)
+		sprintf(out, "ah");
 	else
-		sprintf(out, "%02x", ip_proto);
+		sprintf(out, "0x%02x", ip_proto);
 
 	print_nl();
 	print_string(PRINT_ANY, "ip_proto", "  ip_proto %s", out);
@@ -3017,6 +3060,14 @@ static int flower_print_opt(struct filter_util *qu, FILE *f,
 			   rta_getattr_be32(attr));
 	}
 
+	if (tb[TCA_FLOWER_KEY_SPI]) {
+		struct rtattr *attr = tb[TCA_FLOWER_KEY_SPI];
+
+		print_nl();
+		print_hex(PRINT_ANY, "spi", "  spi 0x%x",
+			   rta_getattr_be32(attr));
+	}
+
 	flower_print_ip4_addr("arp_sip", tb[TCA_FLOWER_KEY_ARP_SIP],
 			     tb[TCA_FLOWER_KEY_ARP_SIP_MASK]);
 	flower_print_ip4_addr("arp_tip", tb[TCA_FLOWER_KEY_ARP_TIP],
-- 
2.25.1


