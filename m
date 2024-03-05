Return-Path: <netdev+bounces-77368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A08887172F
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 08:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1066D285F31
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 07:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C667E773;
	Tue,  5 Mar 2024 07:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXK6/yKw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772AA7E0E8
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 07:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709624639; cv=none; b=beVKBr9xPQCXRcG+Ows4jWH+ARBGqYpS9KiNOHbsqN1uu+KVimkLeafO8vah5eeaC7N/QvOpTWeo0WV4VBAu/kKr+i+WKQA6xiHT1mQ7Jw4JUHyG+guo7kPWK+3tM0ZQIutTyFY55RDHGXSxQ8VzPTADlRK50bKSNymxXQ9Qg2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709624639; c=relaxed/simple;
	bh=71M1yQjBSF6nrzJK6W9bgyvTqfMDxUEHXLQx8C0GIHc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UQIhDgwZQH7BKeEtj0at0J1OM4eTbVjSztdfEArxLlWTGqFSLxwJBZe9J/c4pZ97Nwa30UgtQHrvcV6hUiG9VgCihSR3lps9UD0x8iH2bLRmdfeWKyTny8vgShN0ftni5m92E5yqBYATa0lgxbj+PXP37Js24QxUGqKwebRotKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXK6/yKw; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-29b31254820so1820277a91.0
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 23:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709624636; x=1710229436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dUq1CD0OW0+haTQNCUoDU2N3lPdjhlvxo25FshjWac4=;
        b=nXK6/yKw496ytAhfQNZd1rXfcMCFbrKvlnEnpAP4yI3P1vaTCk0AiAj8dHZlCzsH1B
         sev6466W+OK4n1MZFwQgV9lmwPe8Gp8mBL6s68wUj/egaTGBtqPCMRWha8srtt4cJQd/
         WHuMF6LjzlKyYGqrK8QA2v84rRkTIJdwv2ngkg42N5jdElMrKib0WtxDFwdFEWR6cYCH
         M4zv3hzCO95c0AxJ/i5WpLz21sZDI1s9t1inOYvmwaka10zan4hFIPmJnhoDInS3BZQS
         nqhxZN8wizCEcAJHrgSduV0U0uXBh6uWin601jlqSzlMHSl3iRRo0W5nXpA3ESAhpcSf
         gdPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709624636; x=1710229436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dUq1CD0OW0+haTQNCUoDU2N3lPdjhlvxo25FshjWac4=;
        b=XuAdnEvV2Bd2zg27OY4s1KHebQXa9LIeKGHCDaqXDAlFxGrR89qlk6kjoploKh3LS8
         IF9a1zuqsYiVQPQTjHNH6zsGQZp9E6dhQ5CXVguoNjXjSZmrKnDlUTgZH0bogn7P/DxS
         kv05NvRhcX03Lt1Pkjkh7z7X38MMGWdpPSs5JB/MEEy1w9VGAcCQYbpp+xUJc4nwrgsV
         06nxlVqiag3sChiR+As5Iz7VJgY8j1EGG+6ur0XkXRZLJkGxdVSWkZFAORF9CNN6ku3D
         1mAzKafUN4BHi92ocYFpO+tX/Vtof8MlNSLMmxScg40x6oZgpn89KA3Ds9O6owUAO1Nl
         lAEw==
X-Gm-Message-State: AOJu0YwUIUL7R41GGgXlM0FrujewiRMcQwCC5VI4pGAF9P4POiA7YsWA
	y8aeiqnlf8oLorLb4QvovBaowOXPW1j5LIeG8mDHHToRWE7aLpmWkQa4/GT4
X-Google-Smtp-Source: AGHT+IETFafmCbSQAOVGA0JTc3iGietGZ6dP/vBvXZL1GpLvka3sPHqJf29iiN8ajddZUMBr7d2BXw==
X-Received: by 2002:a17:90b:4388:b0:299:d43b:9092 with SMTP id in8-20020a17090b438800b00299d43b9092mr8291550pjb.15.1709624636423;
        Mon, 04 Mar 2024 23:43:56 -0800 (PST)
Received: from ocxma-dut.. ([153.126.233.62])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090aa00e00b0029b32b85d3dsm5369475pjp.29.2024.03.04.23.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 23:43:56 -0800 (PST)
From: Takeru Hayasaka <hayatake396@gmail.com>
To: netdev@vger.kernel.org
Cc: mkubecek@suse.cz,
	Takeru Hayasaka <hayatake396@gmail.com>
Subject: [PATCH ethtool-next v5] ethtool: add support for rx-flow-hash gtp
Date: Tue,  5 Mar 2024 07:43:50 +0000
Message-Id: <20240305074350.533622-1-hayatake396@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GTP Flow hash was added to the ice driver.
By executing "ethtool -N <dev> rx-flow-hash gtpu4t sde", RSS can include
not only the IP's src/dst but also the TEID of GTP packets.
Additionally, options <e> have been support.
These allow specification to include TEID in the hash computation.

Signed-off-by: Takeru Hayasaka <hayatake396@gmail.com>
---
v1->v2,v2->v3: minor bug fixes
v3->v4: Add tab completion for rsshash gtp flow type
v4->v5: condtion bug fix
 ethtool.c                     | 71 ++++++++++++++++++++++++++++++++++-
 shell-completion/bash/ethtool |  6 ++-
 uapi/linux/ethtool.h          | 48 +++++++++++++++++++++++
 3 files changed, 121 insertions(+), 4 deletions(-)

diff --git a/ethtool.c b/ethtool.c
index 3ac15a7..aa87f68 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -360,6 +360,18 @@ static int rxflow_str_to_type(const char *str)
 		flow_type = AH_ESP_V4_FLOW;
 	else if (!strcmp(str, "sctp4"))
 		flow_type = SCTP_V4_FLOW;
+	else if (!strcmp(str, "gtpc4"))
+		flow_type = GTPC_V4_FLOW;
+	else if (!strcmp(str, "gtpc4t"))
+		flow_type = GTPC_TEID_V4_FLOW;
+	else if (!strcmp(str, "gtpu4"))
+		flow_type = GTPU_V4_FLOW;
+	else if (!strcmp(str, "gtpu4e"))
+		flow_type = GTPU_EH_V4_FLOW;
+	else if (!strcmp(str, "gtpu4u"))
+		flow_type = GTPU_UL_V4_FLOW;
+	else if (!strcmp(str, "gtpu4d"))
+		flow_type = GTPU_DL_V4_FLOW;
 	else if (!strcmp(str, "tcp6"))
 		flow_type = TCP_V6_FLOW;
 	else if (!strcmp(str, "udp6"))
@@ -370,6 +382,18 @@ static int rxflow_str_to_type(const char *str)
 		flow_type = SCTP_V6_FLOW;
 	else if (!strcmp(str, "ether"))
 		flow_type = ETHER_FLOW;
+	else if (!strcmp(str, "gtpc6"))
+		flow_type = GTPC_V6_FLOW;
+	else if (!strcmp(str, "gtpc6t"))
+		flow_type = GTPC_TEID_V6_FLOW;
+	else if (!strcmp(str, "gtpu6"))
+		flow_type = GTPU_V6_FLOW;
+	else if (!strcmp(str, "gtpu6e"))
+		flow_type = GTPU_EH_V6_FLOW;
+	else if (!strcmp(str, "gtpu6u"))
+		flow_type = GTPU_UL_V6_FLOW;
+	else if (!strcmp(str, "gtpu6d"))
+		flow_type = GTPU_DL_V6_FLOW;
 
 	return flow_type;
 }
@@ -1010,6 +1034,9 @@ static int parse_rxfhashopts(char *optstr, u32 *data)
 		case 'n':
 			*data |= RXH_L4_B_2_3;
 			break;
+		case 'e':
+			*data |= RXH_GTP_TEID;
+			break;
 		case 'r':
 			*data |= RXH_DISCARD;
 			break;
@@ -1042,6 +1069,8 @@ static char *unparse_rxfhashopts(u64 opts)
 			strcat(buf, "L4 bytes 0 & 1 [TCP/UDP src port]\n");
 		if (opts & RXH_L4_B_2_3)
 			strcat(buf, "L4 bytes 2 & 3 [TCP/UDP dst port]\n");
+		if (opts & RXH_GTP_TEID)
+			strcat(buf, "GTP TEID\n");
 	} else {
 		sprintf(buf, "None");
 	}
@@ -1559,6 +1588,24 @@ static int dump_rxfhash(int fhash, u64 val)
 	case SCTP_V4_FLOW:
 		fprintf(stdout, "SCTP over IPV4 flows");
 		break;
+	case GTPC_V4_FLOW:
+		fprintf(stdout, "GTP-C over IPV4 flows");
+		break;
+	case GTPC_TEID_V4_FLOW:
+		fprintf(stdout, "GTP-C (include TEID) over IPV4 flows");
+		break;
+	case GTPU_V4_FLOW:
+		fprintf(stdout, "GTP-U over IPV4 flows");
+		break;
+	case GTPU_EH_V4_FLOW:
+		fprintf(stdout, "GTP-U and Extension Header over IPV4 flows");
+		break;
+	case GTPU_UL_V4_FLOW:
+		fprintf(stdout, "GTP-U PSC Uplink over IPV4 flows");
+		break;
+	case GTPU_DL_V4_FLOW:
+		fprintf(stdout, "GTP-U PSC Downlink over IPV4 flows");
+		break;
 	case AH_ESP_V4_FLOW:
 	case AH_V4_FLOW:
 	case ESP_V4_FLOW:
@@ -1573,6 +1620,24 @@ static int dump_rxfhash(int fhash, u64 val)
 	case SCTP_V6_FLOW:
 		fprintf(stdout, "SCTP over IPV6 flows");
 		break;
+	case GTPC_V6_FLOW:
+		fprintf(stdout, "GTP-C over IPV6 flows");
+		break;
+	case GTPC_TEID_V6_FLOW:
+		fprintf(stdout, "GTP-C (include TEID) over IPV6 flows");
+		break;
+	case GTPU_V6_FLOW:
+		fprintf(stdout, "GTP-U over IPV6 flows");
+		break;
+	case GTPU_EH_V6_FLOW:
+		fprintf(stdout, "GTP-U and Extension Header over IPV6 flows");
+		break;
+	case GTPU_UL_V6_FLOW:
+		fprintf(stdout, "GTP-U PSC Uplink over IPV6 flows");
+		break;
+	case GTPU_DL_V6_FLOW:
+		fprintf(stdout, "GTP-U PSC Downlink over IPV6 flows");
+		break;
 	case AH_ESP_V6_FLOW:
 	case AH_V6_FLOW:
 	case ESP_V6_FLOW:
@@ -5834,7 +5899,8 @@ static const struct option args[] = {
 		.func	= do_grxclass,
 		.help	= "Show Rx network flow classification options or rules",
 		.xhelp	= "		[ rx-flow-hash tcp4|udp4|ah4|esp4|sctp4|"
-			  "tcp6|udp6|ah6|esp6|sctp6 [context %d] |\n"
+			  "gtpc4|gtpc4t|gtpu4|gtpu4e|gtpu4u|gtpu4d|tcp6|udp6|ah6|esp6|sctp6|"
+			  "gtpc6|gtpc6t|gtpu6|gtpu6e|gtpu6u|gtpu6d [context %d] |\n"
 			  "		  rule %d ]\n"
 	},
 	{
@@ -5842,7 +5908,8 @@ static const struct option args[] = {
 		.func	= do_srxclass,
 		.help	= "Configure Rx network flow classification options or rules",
 		.xhelp	= "		rx-flow-hash tcp4|udp4|ah4|esp4|sctp4|"
-			  "tcp6|udp6|ah6|esp6|sctp6 m|v|t|s|d|f|n|r... [context %d] |\n"
+			  "gtpc4|gtpc4t|gtpu4|gtpu4e|gtpu4u|gtpu4d|tcp6|udp6|ah6|esp6|sctp6"
+			  "|gtpc6|gtpc6t|gtpu6|gtpu6e|gtpu6u|gtpu6d m|v|t|s|d|f|n|r|e... [context %d] |\n"
 			  "		flow-type ether|ip4|tcp4|udp4|sctp4|ah4|esp4|"
 			  "ip6|tcp6|udp6|ah6|esp6|sctp6\n"
 			  "			[ src %x:%x:%x:%x:%x:%x [m %x:%x:%x:%x:%x:%x] ]\n"
diff --git a/shell-completion/bash/ethtool b/shell-completion/bash/ethtool
index 99c5f6f..f7d6aed 100644
--- a/shell-completion/bash/ethtool
+++ b/shell-completion/bash/ethtool
@@ -79,6 +79,8 @@ _ethtool_flow_type()
 	local types='ah4 ah6 esp4 esp6 ether sctp4 sctp6 tcp4 tcp6 udp4 udp6'
 	if [ "${1-}" != --hash ]; then
 		types="$types ip4 ip6"
+	else
+		types="gtpc4 gtpc6 gtpc4t gtpc6t gtpu4 gtpu6 gtpu4e gtpu6e gtpu4u gtpu6u gtpu4d gtpu6d $types"
 	fi
 	COMPREPLY=( $( compgen -W "$types" -- "$cur" ) )
 }
@@ -171,7 +173,7 @@ _ethtool_change()
 			return ;;
 		wol)
 			# $cur is a set of wol type characters.
-			_ethtool_compgen_letterset p u m b a g s f d
+			_ethtool_compgen_letterset p u m b a g s f d e
 			return ;;
 		xcvr)
 			COMPREPLY=( $( compgen -W 'internal external' -- "$cur" ) )
@@ -483,7 +485,7 @@ _ethtool_config_nfc()
 					_ethtool_flow_type --hash
 					return ;;
 				5)
-					_ethtool_compgen_letterset m v t s d f n r
+					_ethtool_compgen_letterset m v t s d f n r e
 					return ;;
 				6)
 					COMPREPLY=( $( compgen -W context -- "$cur" ) )
diff --git a/uapi/linux/ethtool.h b/uapi/linux/ethtool.h
index 70f2b90..4d74ba0 100644
--- a/uapi/linux/ethtool.h
+++ b/uapi/linux/ethtool.h
@@ -2021,6 +2021,53 @@ static __inline__ int ethtool_validate_duplex(__u8 duplex)
 #define	IPV4_FLOW	0x10	/* hash only */
 #define	IPV6_FLOW	0x11	/* hash only */
 #define	ETHER_FLOW	0x12	/* spec only (ether_spec) */
+
+/* Used for GTP-U IPv4 and IPv6.
+ * The format of GTP packets only includes
+ * elements such as TEID and GTP version.
+ * It is primarily intended for data communication of the UE.
+ */
+#define GTPU_V4_FLOW 0x13	/* hash only */
+#define GTPU_V6_FLOW 0x14	/* hash only */
+
+/* Use for GTP-C IPv4 and v6.
+ * The format of these GTP packets does not include TEID.
+ * Primarily expected to be used for communication
+ * to create sessions for UE data communication,
+ * commonly referred to as CSR (Create Session Request).
+ */
+#define GTPC_V4_FLOW 0x15	/* hash only */
+#define GTPC_V6_FLOW 0x16	/* hash only */
+
+/* Use for GTP-C IPv4 and v6.
+ * Unlike GTPC_V4_FLOW, the format of these GTP packets includes TEID.
+ * After session creation, it becomes this packet.
+ * This is mainly used for requests to realize UE handover.
+ */
+#define GTPC_TEID_V4_FLOW 0x17	/* hash only */
+#define GTPC_TEID_V6_FLOW 0x18	/* hash only */
+
+/* Use for GTP-U and extended headers for the PSC (PDU Session Container).
+ * The format of these GTP packets includes TEID and QFI.
+ * In 5G communication using UPF (User Plane Function),
+ * data communication with this extended header is performed.
+ */
+#define GTPU_EH_V4_FLOW 0x19	/* hash only */
+#define GTPU_EH_V6_FLOW 0x1a	/* hash only */
+
+/* Use for GTP-U IPv4 and v6 PSC (PDU Session Container) extended headers.
+ * This differs from GTPU_EH_V(4|6)_FLOW in that it is distinguished by
+ * UL/DL included in the PSC.
+ * There are differences in the data included based on Downlink/Uplink,
+ * and can be used to distinguish packets.
+ * The functions described so far are useful when you want to
+ * handle communication from the mobile network in UPF, PGW, etc.
+ */
+#define GTPU_UL_V4_FLOW 0x1b	/* hash only */
+#define GTPU_UL_V6_FLOW 0x1c	/* hash only */
+#define GTPU_DL_V4_FLOW 0x1d	/* hash only */
+#define GTPU_DL_V6_FLOW 0x1e	/* hash only */
+
 /* Flag to enable additional fields in struct ethtool_rx_flow_spec */
 #define	FLOW_EXT	0x80000000
 #define	FLOW_MAC_EXT	0x40000000
@@ -2035,6 +2082,7 @@ static __inline__ int ethtool_validate_duplex(__u8 duplex)
 #define	RXH_IP_DST	(1 << 5)
 #define	RXH_L4_B_0_1	(1 << 6) /* src port in case of TCP/UDP/SCTP */
 #define	RXH_L4_B_2_3	(1 << 7) /* dst port in case of TCP/UDP/SCTP */
+#define	RXH_GTP_TEID	(1 << 8) /* teid in case of GTP */
 #define	RXH_DISCARD	(1 << 31)
 
 #define	RX_CLS_FLOW_DISC	0xffffffffffffffffULL
-- 
2.34.1


