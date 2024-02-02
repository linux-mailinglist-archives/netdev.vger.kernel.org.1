Return-Path: <netdev+bounces-68256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6CA846532
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 02:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AD10B20F0B
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 01:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9CD5380;
	Fri,  2 Feb 2024 01:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkSwgzZt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAB45392
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 01:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706835735; cv=none; b=eukdDO0aqQ3e4vLr/aRBGtun++cHUStzdzeYkdjQPcxUGEluyC2r2dvhx+m7GNwzw6aP7qnxQgXjtioe6n82zvUPc2gMdRaQ10eXDcUKr4EFKp8ANxgqx/ggUyShd0UaXDGuRV5Un3dqkR0qyQPvfRZ/lL1X8w6ecKbijEdy4es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706835735; c=relaxed/simple;
	bh=OuDf+t88/ieB+2m5ormSvNCu+9kLfHxoamNATwH5aKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fi7oIll03CsHab+A+BXCt/yDYXDe1Y2/Gchul/VnT/07AplUUnEyVhz0ggJjElmzp2tv6N2n4HJFBs7l0o0kz4OUURN9p01b4jeH2I/m6/jBqoZXIxnyYrX4qRseW02S15V9csuzH7XiNB7+7ePlydZh0cKD9crMFVqzhZmom5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DkSwgzZt; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2960ec23910so1145401a91.2
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 17:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706835733; x=1707440533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tJS2zRVYQN8YznCOa9EEbEVTWNMlLz6L6iuyx6feh44=;
        b=DkSwgzZtfpoBURaGPw1WV1LF1lX1StW2EoWH9LECPL/bOPyMIe9ZIghaLa4eqEH+sP
         fnmVn47KrfyOc8T6vTn17EWJNi+v2IPZ85Tnr1ERM0AttGuZnii4G0fJFeUTuUWSpW8F
         89lVEKesyDdaKhNEDmKYVHTCek0+10FQXjF5KzB3s45EyMHCUuCJSCsSiOJjOZ+UBz4y
         A4lBAOmYRYAaKHPxmXyNWOU14PqLtrms2H0CRB5PcuJKIus3fPeonkKdD4et8gXXp/fp
         sXF/fgW/pSk5+6bTSYDXjgcdrTq6MZY5PJlcUZPAcURblNVMbK/JSXNSlhskTSddFarA
         36jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706835733; x=1707440533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tJS2zRVYQN8YznCOa9EEbEVTWNMlLz6L6iuyx6feh44=;
        b=cBX9g0VDcquufPSdVx1YnP4nc0DSaSmRADL/LFNFI0j06ncBSYHRt9QNXCuqbamGsv
         2C7942jmjZKCN0Dfd0Owq50+XYF0SpX1r4DeUvDx8pdNr8p15cRpfDzg5EMNqHcYk7Ce
         ahzI3+48J5cOXMrgtxMUuY/6kel+iQ/2g0Pa0iKYfgtV10UMS5JKcbMs+8Fj1vlILQGf
         xnztO+pXB5GsUzH/BBIvgU7hTdbMgDk9MVOgpSDxnaXhW93Sh9DL7wSejHzUfCMKDU+5
         Sa1xhqaAn5J0qNGh365oEETDddA598iM6oFXVuPbgcrUp/byNFQEYgHNPRJhCf8vOWUW
         mLNw==
X-Gm-Message-State: AOJu0YweFjTqTk0Xly+zy3Oe34OYauVSP3z+G3dA0rU8lcjZxA/o7KpO
	z19w0uMJTG8krMzMBkglkfPjgAfNLc4ZNtCd0NFCnIvqnf19ENxwsm6IwppY
X-Google-Smtp-Source: AGHT+IGgiU8YeP7Q9Oux9PjLZByvwUNajZy62iuTwEKeF9O2O/UkriTg6LJkH+fOxXfK6MoQt4m6jQ==
X-Received: by 2002:a17:902:680d:b0:1d9:7228:b345 with SMTP id h13-20020a170902680d00b001d97228b345mr170285plk.2.1706835732415;
        Thu, 01 Feb 2024 17:02:12 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXP5+lDN5na8RBWe7me9p0b56U5FsqeFnyPslGWlkj0pjy/5eVySsWMNri1Zn65AiVEdKr2wIZNwzUjgPXNiU5VCsQ4bSQ=
Received: from ocxma-dut.. ([153.126.233.61])
        by smtp.gmail.com with ESMTPSA id y3-20020a170902ed4300b001d94126da45sm411398plb.180.2024.02.01.17.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 17:02:12 -0800 (PST)
From: Takeru Hayasaka <hayatake396@gmail.com>
To: netdev@vger.kernel.org
Cc: mkubecek@suse.cz,
	Takeru Hayasaka <hayatake396@gmail.com>
Subject: [PATCH ethtool-next v3] ethtool: add support for rx-flow-hash gtp
Date: Fri,  2 Feb 2024 01:02:03 +0000
Message-Id: <20240202010203.1046074-1-hayatake396@gmail.com>
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
Resend as this link updates
https://lore.kernel.org/all/20240201033310.1028154-1-hayatake396@gmail.com/
 ethtool.c            | 71 ++++++++++++++++++++++++++++++++++++++++++--
 uapi/linux/ethtool.h | 48 ++++++++++++++++++++++++++++++
 2 files changed, 117 insertions(+), 2 deletions(-)

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


