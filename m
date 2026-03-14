Return-Path: <netdev+bounces-267793-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFAHNsWetWms2gAAu9opvQ
	(envelope-from <netdev+bounces-267793-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:45:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDC428E2EC
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B76FD300E1A7
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1452FE07D;
	Sat, 14 Mar 2026 17:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="IgUw4Qk8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE86D313E03
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 17:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773510269; cv=none; b=F+4brBp7Iwv4h/w/jSmAvqwIkT/DEInTzCfNb19s9OIIAyQp17UQg14I33uM6wavwk6AsnnZO+UHaIoM+f4V7LuUbsHFvrl6JkDrVur06nXeXic1pxk2rVuaxR6Qfp1+Nr+SRFpcN0thelzt40gQUeFHxo6OgnhFTwgnH0Baokg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773510269; c=relaxed/simple;
	bh=tAp/O3bEeMV0iUDq/Wiq2PbIBCLHQKAo5YEvTeB7v1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qNODQ0j6XpkfHI0YKsMmod+8lS7PWS5zkcTpQp8oFDQHvMLxUtbH5bk5/pKVac/9YuUe1nRc0WrcwyDnOGBXLGU6oEMhkoiRrPCP7Rk0I8Ht8w6MXOzPDVgKbbl7eaBQr+mDn+ql2N2CpPNaNdSIH75hzBFb282kzff99OrzciE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=IgUw4Qk8; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-128b9b7e3edso1770788c88.0
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 10:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1773510267; x=1774115067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gknWCUbu4rGCx2qSBonrFvur9BBT38u1zHM4kwic0d8=;
        b=IgUw4Qk8En9yRN5Xscg1q3uY2czopTu04lstPCyZBaTpqb7BS+/XqX3q0FbRZsYD3u
         bBobWOpIEpzyYvWOd/mt92qhWto7dPk56GG7mB2c603IgTKoj1On9+IK04cBs2y+BO0y
         yyVKqDxx8VWdXPZzWkUDhRUHqqNO73nGlbbrQTsJOQ2s5PCI19LgN/khTIoNYuxFiiMC
         iV/BWRCTA18UkEiVXfc3LKblLlK3vd9A5mR5VztJ8BVh99qwgj2cvTPSgXnu12p6oJtz
         fkxS9t/+W5ft2USXU5/LVBdSG0Sb07CdATaoStLZGOMmK8u37imr1vYSr9XjZgA2B6Og
         Ep5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773510267; x=1774115067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gknWCUbu4rGCx2qSBonrFvur9BBT38u1zHM4kwic0d8=;
        b=GS4ZYdm3CSjDl0hRA/nHFnlV8VleNRI/CV9VOc5gxUrbLJQKBd8KElllXxn6mQvR8x
         WVQUBHfhnzN2jNNZiQX4T7qthKRweC5atSuHny372vREcyizBhcdM5HDT/cytgy2pt4f
         +29Cjp3E1BSWO1EKNZtyfqpin2rVR2rkidXNNFkIRmxzvYamm7o53rUQTqDsMfAfXTTc
         hYVoiLFsFED1B7z4OMZ8Ns7PTr2SoltuXQHcX4EewbZQnv5Ldvisy7hdtA16nbkvmxN9
         Uel/X7AAMqSpu6tORT7hkUnV29Se59wWaCKuxzJSloM/LCPG8eQQqkEALFvmo3emSdmr
         PnHA==
X-Forwarded-Encrypted: i=1; AJvYcCV4GktucCtkqt62kxZb95H0wMPPzYBLhQo3smgyM5EeVtVyttN1q1aYaGCqGN+xmujCT/KRSgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZxs2JkmgmwraeHN37imcMhOVc6U9HFrAcL95UQsMMlceKqHoi
	7v8KcwmxGQKmDWtVbBVLbkJ4dDakW0x3cx1CKaiQbzYz8H4ZppVNoupgQeZaUKroXQ==
X-Gm-Gg: ATEYQzyUJfSbVnH7xgwoMrawkTHrON/p7Tl3tTBSwF+Pit6Q3fZRGEvQQ9uZspmxn12
	ipjonm3/ih/P3sS2XvhLsvXEzOr72relBgYGr5CSlFblf8xxcXpyKkwk4CH85eA1kt4+LtfcsAx
	Qu4/xURcbKgWLZT3uTxszn2TuRF+EQ8p2cALb5SVNiF+IKoDqZCvMt8Alv8piRNF27F3ftHi8+u
	G534BrRWQ+t+kt+gi1MPMdmN8d25RgZ5PtpZ8RAOMN5qvCpZmXHL9B+kQg7phnxySWJyf+lz4aa
	GjtlHjv9BRP9IAMvBWSWvdvP3asXE3FrY+B3q+jh1/nlQvLWqkvOwz9zYfRo930vNtQg1ed/RCk
	VzvNjjf9S9fkW1XpcltkSDSGnH/7SOW//5YlJ0d/a1H8jwwACYJ6Mf1rtIxYU7ZbVCyxi0Dlsql
	kUwCwD5MzxG2/wKG45qYAHANnNanQFkqzfmKP7la5ReiROJfi0s1MIbcy1rPvJmoh6OwNoPj927
	HaxB96Z
X-Received: by 2002:a05:7022:4a1:b0:128:bb45:35b2 with SMTP id a92af1059eb24-128f3d24df3mr3943136c88.12.1773510266990;
        Sat, 14 Mar 2026 10:44:26 -0700 (PDT)
Received: from pong.herbertland.com ([2601:646:8980:b330:eb38:94c4:209f:a764])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f62837ccsm8326734c88.3.2026.03.14.10.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 10:44:26 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com
Cc: Tom Herbert <tom@herbertland.com>
Subject: [net-next v8 08/10] test: Add proto_nums.py in networking selftests
Date: Sat, 14 Mar 2026 10:43:31 -0700
Message-ID: <20260314174333.46406-9-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260314174333.46406-1-tom@herbertland.com>
References: <20260314174333.46406-1-tom@herbertland.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,vger.kernel.org,uliege.be,gmail.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-267793-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,herbertland.com:dkim,herbertland.com:email,herbertland.com:mid]
X-Rspamd-Queue-Id: DDDC428E2EC
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


