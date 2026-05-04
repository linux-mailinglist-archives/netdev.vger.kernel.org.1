Return-Path: <netdev+bounces-284013-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kH1CHlLr+Gmi3AIAu9opvQ
	(envelope-from <netdev+bounces-284013-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 20:54:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E13A44C2CAC
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 20:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49AF830387A0
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 18:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C8D3E7141;
	Mon,  4 May 2026 18:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="gCsXPRR7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F623E63B1
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 18:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777920787; cv=none; b=YQBzz9sVMhk2Vp+F9b4Ch4PFIyGR4Bh+F4JDzCCXBNVim9eqSMehmnwuVELyoxDNzOF8mdKXoDPiKyXUF1ndq9LY5S5f41aHEmh1uhJ1luXsu+FjUiYrUfh1CuWqnBFIrcfOHqznUqTisd3J9rsvBzQDQZ6kVeG2c1gAE75tSng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777920787; c=relaxed/simple;
	bh=ZtOC5ms5Vw3wN4Ct4+uGxTLbzcX+dHTDwStfrM5iKkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AV7sMDNZR/JWNsRbinfOIZDT4a9zg9yfRk09rsv2j9+Gyqkbf3GlDgGSJ1c1Pj73grKCgApV+qfMBzqwDC49Bf5uWJmcEO0O8uLIFPdH/tKkBuzjUudcBsS4+5EfyF62y4YsPBlmvUa6w2xGR6itpjbJjT6xk0L6ZVk5dRhE2Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=gCsXPRR7; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2ee1054627bso2980693eec.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 11:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1777920785; x=1778525585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2RLuVRTNjnVEux/2W9Ys/cIEt28eGUDB9bvJlM3qvQ=;
        b=gCsXPRR7OR6FKlUbJxfYUX+9tagZISWmITnvbx5GBl8QALujq9dse2o7/l2TPq8elL
         VYO/zH99W6hC14rohuA5rU6JnBMu9HMAl02+i4FYpxWPQ8iWSNYTUUuuhJFhJTDeS4mZ
         MTR5Z1MC+rUnH9HwgXCzaoCRJ7RnlxaDI85n/KLqeo9dbiJgyYaSm1D78skn26h68Vjp
         6+ryoyK37mIGPBVoUCUz3tRc1M7vwtVGmWw5wXcvukB/L0NgOed9jjiKJBy2oOytFsN1
         0kfX4SJ8lJZMYar8Dy3XynXA2XQlHCyfI39Ip2DADI0hqB9MiXDNpJw03tY9tZHaxzJi
         V5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777920785; x=1778525585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r2RLuVRTNjnVEux/2W9Ys/cIEt28eGUDB9bvJlM3qvQ=;
        b=sibKSFt3F6682k0qsv8LzJqef+TSLdE8RoqfPyFts5gAhu9qEZhhDcPHzU8r4wIyXU
         JInA5ndGQDj4+wNLjYf8kgH3jQsNjYRLLDA4xWdKNFECLB0JI/+k+p7kOEEi2of4C/Sc
         sbcTx+Io3+aD/LDi99LXbOGWYsWdn+oPuUSVb/ePlesbh2tTVSZE/lkL8CcYrqM5AhDX
         QYfU7ZfTsMv0lp7qrNHCYF+enaIcS/Ge17XQE0I4QeZbpqJlUp6h3eKcWsyjcL/z7qcg
         bc2dXkpXpDAv8525X/qvMAo35l3cJ16byGdFpffb1KE3T2Jmo1578qc65EDjPtIRkPkb
         Ab2w==
X-Forwarded-Encrypted: i=1; AFNElJ9gv3Z0xJZ/q0b6BeSXr4MVbaAOQ7AxEkhqFZCeLjGEZykHhExe9LxqG2TMC2vUfpH5cKzwtXs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy61nTjTexX5ai3wvRDgaiDqZDDJf+IaL1enyw134pjbd/Xln06
	m7j94a2UeP5upzvRsplBWtlByM9mRWAqflSqk0H5IOO9A5SjSCCC6oSD+1EijSKLKQ==
X-Gm-Gg: AeBDieuOYkZZDVYGFLnmlqJbldt2vuGgPMubkU6vLskKwXyNSPpfmxGDjxZTEKJKqeI
	DOMpoXiTWoE0a2RFb1G7Uw2exwRtiwkAY3vakJeWm8NTU9JymtgqhRaHII0bNPWGG2dlJeutchR
	CaFYJ9TVBtcOzG8oPg7Mik6vKhiIMFVEygAGf+Rf6RJKts5b4FBi/edIRJdOKnrOc69CAnRRasP
	nxgY2yShGyl+Fm18p/v+LTV/nlXjwhYpjJtYRWKPnp5xcCXoDnQvbImW4JgwE8tFA2ruRV/SfwA
	7ED2ZzoD5ExmICvrDtKsUAUBzOnz3cd5ez/mfde+u3k8RQQZ2+Eambj+w2T/2N5TBZ6RTsB475g
	47ShLuJassDiTcqZq+/z4GRwh2UoPKcXfH9EnXXHPO8tM/b/EAfR2GG1PZBAQPGffzAQYQEJdIo
	D+bn9NVyqDK2nFsSa+23RLCjFGrzeU7eRo/CPZEu9Vbhx+pBNU/UU73+Tl/LGik1ze/lHBn7ZM
X-Received: by 2002:a05:7301:4586:b0:2f3:5d44:eeba with SMTP id 5a478bee46e88-2f3ceaea156mr358670eec.6.1777920784610;
        Mon, 04 May 2026 11:53:04 -0700 (PDT)
Received: from pong.herbertland.com ([2601:646:8980:b330:8e62:719f:fc3d:b6ad])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3889d657sm17186262eec.4.2026.05.04.11.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 11:53:04 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
X-Google-Original-From: Tom Herbert <tom@xdpnet.ai>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com,
	horms@kernel.org
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v10 08/10] test: Add proto_nums.py in networking selftests
Date: Mon,  4 May 2026 11:51:20 -0700
Message-ID: <20260504185122.50642-9-tom@xdpnet.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260504185122.50642-1-tom@xdpnet.ai>
References: <20260504185122.50642-1-tom@xdpnet.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E13A44C2CAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[herbertland.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284013-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,vger.kernel.org,uliege.be,gmail.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[tom@herbertland.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[herbertland.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,xdpnet.ai:mid,herbertland.com:dkim,herbertland.com:email,proto_nums.py:url]

From: Tom Herbert <tom@herbertland.com>

Add proto_nums.py that contains various python definitions of
common protocol constants

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 tools/testing/selftests/net/Makefile      |   1 +
 tools/testing/selftests/net/proto_nums.py | 231 ++++++++++++++++++++++
 2 files changed, 232 insertions(+)
 create mode 100644 tools/testing/selftests/net/proto_nums.py

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index a275ed584026..21897ee81916 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -69,6 +69,7 @@ TEST_PROGS := \
 	nl_netdev.py \
 	nl_nlctrl.py \
 	pmtu.sh \
+	proto_nums.py \
 	psock_snd.sh \
 	reuseaddr_ports_exhausted.sh \
 	reuseport_addr_any.sh \
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


