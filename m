Return-Path: <netdev+bounces-267809-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NlWIVyhtWk02wAAu9opvQ
	(envelope-from <netdev+bounces-267809-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:56:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0250628E4A7
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A715F30ACBF0
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5833C33F582;
	Sat, 14 Mar 2026 17:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="N5E4TprN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59A133F36B
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 17:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773510719; cv=none; b=Vh6cfoIOHZVeWnWnb1PLYyEVYU6JA1QqwfaacOu9MLkty2Z8swSYWFm3f7G11aRJ69ad0ige25UPhihoezIvsv1yZJtOZ8KgF7L+beGUreRaz7dM6Hm4czUlOWk5+py0KyLeRHWITIfwtvbN5wARqsmPHvnu4NznqVWgbTgriPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773510719; c=relaxed/simple;
	bh=tAp/O3bEeMV0iUDq/Wiq2PbIBCLHQKAo5YEvTeB7v1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IRoBMFETe5ZMPoNQ7WNnFkSDgsMR1N6XXZJX/DMNYuKwTH2eNGfebM3lOoDWOVxTjU3ch6MMgWneToxsbd+D0Zjy0cXDEqrN9Jz1YY+DYIUgNRGsTmFdldzirqYwoK04g0GiMowbPC7DqXcpFyAZEflcFmbPn08XVE/FR6pvu5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=N5E4TprN; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-126ea4e9694so1517204c88.1
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 10:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1773510717; x=1774115517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gknWCUbu4rGCx2qSBonrFvur9BBT38u1zHM4kwic0d8=;
        b=N5E4TprN9ta1Gf/cF9SAFVQM6AfmJy2JPHOlIWa/8WpiQtanNlBxHFeNKttWCykdeu
         FB7QQvFicailucH1OHzeMLZMb016FUZsIvxLTJMwjKNk7UqBqKRphKJsneDHoJ6JOiHr
         0YLS7rQhQY/wP10ISlPXpYhh4w7RxqMI7AKeNcoIuCxKJBA/MOsv1I7aSaceppRUgP5o
         ydCRV4Oi6XHDIaNZZSmrfjUDCiaDttPvYeyg3oW/yn0yQcficmUALyW84O5q4dlUIWbP
         sapbl8qEZU5T1GqHY2X8o9laYPecltqK5ZSzbpxmmuz5iWJGWrRQv8C7qL4kdVXA+jSz
         /64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773510717; x=1774115517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gknWCUbu4rGCx2qSBonrFvur9BBT38u1zHM4kwic0d8=;
        b=kdeu5GKySJLAOsz8TWDtMI4yUMsEWeo5hde0eH2OpjDCqdr0/bCswx+8ukgl4Rp5b7
         vD+rwfDGGBA8X+4/JyL73tBhO5AS/grr+Q1M2ukqZng8w1k5psDV66lpfZt7185c15e1
         hHxPyxu7xWN3lm958+6zA3FFFzXm9LxDPF6T0YHT0yLF0jC2ept5MdZ2c3oJjaaS60tE
         LBZHKGfkidYEpCi9CAzgaILdeXhdZ7eOAgmM3RR2f4J6ToroDR6rg36RCPurV5GVGyQQ
         5HAQ+LLPgrrU7yyxKFF8TJh/Gprpkw4i5s04BJYqNnc+UQaraLN49tpJKlo0qBfAjNAO
         PtAA==
X-Forwarded-Encrypted: i=1; AJvYcCUyVLEPLzGPrS9LNcDd7g7mPJtZoJmB63Q++u0lVtWIEdPtEvu3kaO5SFeIJMTaDC/48eAQecQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeUd3sSW9xhlFUpVmGF8ClLvwdIjJdemOQ2Rg/WE8mARwLlrb/
	57vGh9B3ioZIsUyp5qF8piRqxSnF9I+c988GVCbgxG5ulaD5eaGZsRKKEnlo9t+2CQ==
X-Gm-Gg: ATEYQzy0GHOehpranMAOI1GyeQXueOwyEMrut8hD4yPmtPALI2WWkDd0RjTuDFurPCb
	O1PBv0y2rRth4Ero04GIqL6l+ZZ8W+VhOjWZC6gLA9AGtTEFH7HZLmd0kqDWFPgcrvk7WtACJMO
	ytO8/A5df4kcO2q1MKXXMATk1rvajpu6lf1C7fxgdX9pulRviw9wb4TZQB6EenBoeiXccfqNO1W
	SBtz3HZPwI5Iv+DClzT/sCImaXHutuoluzUgTTBwwJYdwfeKnhzShoXMdWX5J71sQEe6CjWgcod
	nn3obrHH3qydU5+scpQH1V8lmoGGIql1RQTErXf+2vg/v7S9Foz+3iI9cJN0FA43hBm3oWBp6gq
	a7GdtAyNbn8L+xsGfml8vkdHKEbX2aEu5O7LeSDYOzeCcd4KLJVhDiKURIh+d8KbnltRu7i+ySN
	dKFwke7vArsYaKNz27EOdwSj/2tRpRlTCtnMc2EDT2LBFmEZeAXNbB1G0pVfR5Wzo9FWHhQQ==
X-Received: by 2002:a05:7022:6613:b0:128:d793:5bb0 with SMTP id a92af1059eb24-128f3e2aa64mr4078264c88.37.1773510716955;
        Sat, 14 Mar 2026 10:51:56 -0700 (PDT)
Received: from pong.herbertland.com ([2601:646:8980:b330:eb38:94c4:209f:a764])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f6384f6csm5917206c88.9.2026.03.14.10.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 10:51:56 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v9 08/10] test: Add proto_nums.py in networking selftests
Date: Sat, 14 Mar 2026 10:51:22 -0700
Message-ID: <20260314175124.47010-9-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260314175124.47010-1-tom@herbertland.com>
References: <20260314175124.47010-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[herbertland.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,vger.kernel.org,uliege.be,gmail.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-267809-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tom@herbertland.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[herbertland.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,herbertland.com:dkim,herbertland.com:email,herbertland.com:mid,proto_nums.py:url]
X-Rspamd-Queue-Id: 0250628E4A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add proto_nums.py that contains various python definitions of
common protocol constants

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 tools/testing/selftests/net/proto_nums.py | 231 ++++++++++++++++++++++
 1 file changed, 231 insertions(+)
 create mode 100644 tools/testing/selftests/net/proto_nums.py

diff --git a/tools/testing/selftests/net/proto_nums.py b/tools/testing/selftests/net/proto_nums.py
new file mode 100644
index 000000000000..dc775164dacc
--- /dev/null
+++ b/tools/testing/selftests/net/proto_nums.py
@@ -0,0 +1,231 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# Various protocol constant definitions
+
+from enum import Enum
+
+# IP protocol numbers
+class IP_Proto(Enum):
+    IP_PROTO_HOPOPT = 0
+    IP_PROTO_ICMP = 1
+    IP_PROTO_IGMP = 2
+    IP_PROTO_GGP = 3
+    IP_PROTO_IPv4 = 4
+    IP_PROTO_ST = 5
+    IP_PROTO_TCP = 6
+    IP_PROTO_CBT = 7
+    IP_PROTO_EGP = 8
+    IP_PROTO_IGP = 9
+    IP_PROTO_BBN_RCC_MON = 10
+    IP_PROTO_NVP_II = 11
+    IP_PROTO_PUP = 12
+    IP_PROTO_ARGUS = 13
+    IP_PROTO_EMCON = 14
+    IP_PROTO_XNET = 15
+    IP_PROTO_CHAOS = 16
+    IP_PROTO_UDP = 17
+    IP_PROTO_MUX = 18
+    IP_PROTO_DCN_MEAS = 19
+    IP_PROTO_HMP = 20
+    IP_PROTO_PRM = 21
+    IP_PROTO_XNS_IDP = 22
+    IP_PROTO_TRUNK_1 = 23
+    IP_PROTO_TRUNK_2 = 24
+    IP_PROTO_LEAF_1 = 25
+    IP_PROTO_LEAF_2 = 26
+    IP_PROTO_RDP = 27
+    IP_PROTO_IRTP = 28
+    IP_PROTO_ISO_TP4 = 29
+    IP_PROTO_NETBLT = 30
+    IP_PROTO_MFE_NSP = 31
+    IP_PROTO_MERIT_INP = 32
+    IP_PROTO_DCCP = 33
+    IP_PROTO_3PC = 34
+    IP_PROTO_IDPR = 35
+    IP_PROTO_XTP = 36
+    IP_PROTO_DDP = 37
+    IP_PROTO_IDPR_CMTP = 38
+    IP_PROTO_TP_PLUS_PLUS = 39
+    IP_PROTO_IL = 40
+    IP_PROTO_IPv6 = 41
+    IP_PROTO_SDRP = 42
+    IP_PROTO_IPv6_Route = 43
+    IP_PROTO_IPv6_Frag = 44
+    IP_PROTO_IDRP = 45
+    IP_PROTO_RSVP = 46
+    IP_PROTO_GRE = 47
+    IP_PROTO_DSR = 48
+    IP_PROTO_BNA = 49
+    IP_PROTO_ESP = 50
+    IP_PROTO_AH = 51
+    IP_PROTO_I_NLSP = 52
+    IP_PROTO_SWIPE = 53
+    IP_PROTO_NARP = 54
+    IP_PROTO_Min_IPv4 = 55
+    IP_PROTO_TLSP = 56
+    IP_PROTO_SKIP = 57
+    IP_PROTO_IPv6_ICMP = 58
+    IP_PROTO_IPv6_NoNxt = 59
+    IP_PROTO_IPv6_Opts = 60
+    IP_PROTO_any_1 = 61
+    IP_PROTO_CFTP = 62
+    IP_PROTO_any_2 = 63
+    IP_PROTO_SAT_EXPAK = 64
+    IP_PROTO_KRYPTOLAN = 65
+    IP_PROTO_RVD = 66
+    IP_PROTO_IPPC = 67
+    IP_PROTO_any_3 = 68
+    IP_PROTO_SAT_MON = 69
+    IP_PROTO_VISA = 70
+    IP_PROTO_IPCV = 71
+    IP_PROTO_CPNX = 72
+    IP_PROTO_CPHB = 73
+    IP_PROTO_WSN = 74
+    IP_PROTO_PVP = 75
+    IP_PROTO_BR_SAT_MON = 76
+    IP_PROTO_SUN_ND = 77
+    IP_PROTO_WB_MON = 78
+    IP_PROTO_WB_EXPAK = 79
+    IP_PROTO_ISO_IP = 80
+    IP_PROTO_VMTP = 81
+    IP_PROTO_SECURE_VMTP = 82
+    IP_PROTO_VINES = 83
+    IP_PROTO_IPTM = 84
+    IP_PROTO_NSFNET_IGP = 85
+    IP_PROTO_DGP = 86
+    IP_PROTO_TCF = 87
+    IP_PROTO_EIGRP = 88
+    IP_PROTO_OSPFIGP = 89
+    IP_PROTO_Sprite_RPC = 90
+    IP_PROTO_LARP = 91
+    IP_PROTO_MTP = 92
+    IP_PROTO_AX_25 = 93
+    IP_PROTO_IPIP = 94
+    IP_PROTO_MICP = 95
+    IP_PROTO_SCC_SP = 96
+    IP_PROTO_ETHERIP = 97
+    IP_PROTO_ENCAP = 98
+    IP_PROTO_any_4 = 99
+    IP_PROTO_GMTP = 100
+    IP_PROTO_IFMP = 101
+    IP_PROTO_PNNI = 102
+    IP_PROTO_PIM = 103
+    IP_PROTO_ARIS = 104
+    IP_PROTO_SCPS = 105
+    IP_PROTO_QNX = 106
+    IP_PROTO_A_N = 107
+    IP_PROTO_IPComp = 108
+    IP_PROTO_SNP = 109
+    IP_PROTO_Compaq_Peer = 110
+    IP_PROTO_IPX_in_IP = 111
+    IP_PROTO_VRRP = 112
+    IP_PROTO_PGM = 113
+    IP_PROTO_any_5 = 114
+    IP_PROTO_L2TP = 115
+    IP_PROTO_DDX = 116
+    IP_PROTO_IATP = 117
+    IP_PROTO_STP = 118
+    IP_PROTO_SRP = 119
+    IP_PROTO_UTI = 120
+    IP_PROTO_SMP = 121
+    IP_PROTO_SM = 122
+    IP_PROTO_PTP = 123
+    IP_PROTO_ISIS = 124
+    IP_PROTO_FIRE = 125
+    IP_PROTO_CRTP = 126
+    IP_PROTO_CRUDP = 127
+    IP_PROTO_SSCOPMCE = 128
+    IP_PROTO_IPLT = 129
+    IP_PROTO_SPS = 130
+    IP_PROTO_PIPE = 131
+    IP_PROTO_SCTP = 132
+    IP_PROTO_FC = 133
+    IP_PROTO_RSVP_E2E_IGNORE = 134
+    IP_PROTO_Mobility = 135
+    IP_PROTO_UDPLite = 136
+    IP_PROTO_MPLS_in_IP = 137
+    IP_PROTO_manet = 138
+    IP_PROTO_HIP = 139
+    IP_PROTO_Shim6 = 140
+    IP_PROTO_WESP = 141
+    IP_PROTO_ROHC = 142
+    IP_PROTO_Ethernet = 143
+    IP_PROTO_AGGFRAG = 144
+    IP_PROTO_NSH = 145
+    IP_PROTO_Homa = 146
+    IP_PROTO_BIT_EMU = 147
+
+# Hop-by-Hop and Destination Options numbers
+class HBHDst_Types(Enum):
+    HBHDST_TYPE_PAD1 = 0x0
+    HBHDST_TYPE_PADN = 0x1
+    HBHDST_TYPE_JUMBO = 0xc2
+    HBHDST_TYPE_RPL = 0x23
+    HBHDST_TYPE_RPL_DEPRECATED = 0x63
+    HBHDST_TYPE_TNL_ENCAP_LIMIT = 0x4
+    HBHDST_TYPE_ROUTER_ALERT = 0x5
+    HBHDST_TYPE_QUICK_START = 0x26
+    HBHDST_TYPE_CALIPSO = 0x7
+    HBHDST_TYPE_SMF_DPD = 0x8
+    HBHDST_TYPE_HAO = 0xc9
+    HBHDST_TYPE_ENDPOINT_ID = 0x8a
+    HBHDST_TYPE_ILNP_NONCE = 0x8b
+    HBHDST_TYPE_LINE_ID = 0x8c
+    HBHDST_TYPE_DEPRECATED = 0x4d
+    HBHDST_TYPE_MPL = 0x6d
+    HBHDST_TYPE_DFF = 0xee
+    HBHDST_TYPE_PDM = 0x0f
+    HBHDST_TYPE_MIN_PATH_MTU = 0x30
+    HBHDST_TYPE_IOAM_NO_CHNG = 0x11
+    HBHDST_TYPE_IOAM_CHNG = 0x31
+    HBHDST_TYPE_ALT_MARK = 0x12
+    HBHDST_TYPE_RFC3692_1 = 0x1e
+    HBHDST_TYPE_RFC3692_2 = 0x3e
+    HBHDST_TYPE_RFC3692_3 = 0x5e
+    HBHDST_TYPE_RFC3692_4 = 0x7e
+    HBHDST_TYPE_RFC3692_5 = 0x9e
+    HBHDST_TYPE_RFC3692_6 = 0xbe
+    HBHDST_TYPE_RFC3692_7 = 0xde
+
+# Routing header types
+class RoutingTypes(Enum):
+    ROUTING_TYPE_SRC_RT = 0
+    ROUTING_TYPE_NIMROD = 1
+    ROUTING_TYPE_2 = 2
+    ROUTING_TYPE_RPL = 3
+    ROUTING_TYPE_SRH = 4
+    ROUTING_TYPE_CRH16 = 5
+    ROUTING_TYPE_CRH32 = 6
+    ROUTING_TYPE_RFC3692_1 = 253
+    ROUTING_TYPE_RFC3692_2 = 254
+
+# Canonical extension header order
+class EH_Order(Enum):
+    IPV6_EXT_HDR_ORDER_HOP = 1 << 0
+    IPV6_EXT_HDR_ORDER_DEST_BEFORE_RH = 1 << 1
+    IPV6_EXT_HDR_ORDER_ROUTING = 1 << 2
+    IPV6_EXT_HDR_ORDER_FRAGMENT = 1 << 3
+    IPV6_EXT_HDR_ORDER_AUTH = 1 << 4
+    IPV6_EXT_HDR_ORDER_ESP = 1 << 5
+    IPV6_EXT_HDR_ORDER_DEST = 1 << 6
+
+# ICMPv6 types
+class ICMP6_Type(Enum):
+    ICMPV6_DEST_UNREACH = 1
+    ICMPV6_PKT_TOOBIG = 2
+    ICMPV6_TIME_EXCEED = 3
+    ICMPV6_PARAMPROB = 4
+    ICMPV6_ECHO_REQUEST = 128
+    ICMPV6_ECHO_REPLY = 129
+    ICMPV6_MGM_QUERY = 130
+    ICMPV6_MGM_REPORT = 131
+    ICMPV6_MGM_REDUCTION = 132
+    ICMPV6_NI_QUERY = 139
+    ICMPV6_NI_REPLY = 140
+    ICMPV6_MLD2_REPORT = 143
+    ICMPV6_DHAAD_REQUEST = 144
+    ICMPV6_DHAAD_REPLY = 145
+    ICMPV6_MOBILE_PREFIX_SOL = 146
+    ICMPV6_MOBILE_PREFIX_ADV = 147
+    ICMPV6_MRDISC_ADV = 151
+    ICMPV6_MRDISC_SOL = 152
-- 
2.43.0


