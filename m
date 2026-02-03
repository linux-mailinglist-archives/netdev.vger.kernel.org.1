Return-Path: <netdev+bounces-256050-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJ0cKNtGgWnNFAMAu9opvQ
	(envelope-from <netdev+bounces-256050-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 01:52:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F24BFD3273
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 01:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19B61305B0A2
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 00:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4751E98EF;
	Tue,  3 Feb 2026 00:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="N+C+2v5R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D95207DF7
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 00:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770079774; cv=none; b=e0WlJ/GxSuFe3B2/9OnmQYkbJhGV5TL+xNqIng6udBV6yOtkOaAjqQ2t9fqkCPkgvClyPa+oT2NNnohQLh4o5y/Wca+2E4CKk/EpxixDN3pQJ+6aOUH3nmksA6AZgq7N24QEmSIoKVffSpIoOy6F7i7EeEr3dU1fYBYOK3icIAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770079774; c=relaxed/simple;
	bh=sZfNnOkKPrbxwlUVkDFqY+YzcFTrgP8rbBPGwP3JVm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UoAKPguzg9/4CO8gBxm/Y9+NNuOSpFJ1xB9GT3K004dyXGQyCy9+Evqd2CLjaZduLyu/Mn6m/hmqOVtEwhxRkPTVuYVpItnYuOQ+8B8OZgbd1Xs+pRqBGhWbsouRsXd1RAUKfu/dD/WLObCtf8jRvLEOU5NkyRhuuMA3T0u5N/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=N+C+2v5R; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2b71515d8adso5049887eec.1
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 16:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1770079772; x=1770684572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mUTcFik0lAYGRu5XN3bc3aqN9ecQO0U1mOAc2KqK9k=;
        b=N+C+2v5REiBSKI0lZcR2HZgmqB7YYPKSUDBIklXthJgRQKhB5XeTVvQBVLuzK2v8OZ
         7MKQ0hEQcBy3/ERD4kxtJeaedYfuloadBNeATBy/w6kcipa4223WDIruMB8BcAj7wTt6
         EKLr72HFrr7gzdieywHjXfWyJMIGRNk+9Edc+//XPiQNyrvYjnPuua9Umi7kofwyamcB
         eOCFQ8+MsvGne0Tw7PpKrw/t++s6px6tw/3CX1QpVdhW4DPdcdjZa0Set9kMnEXX7wyj
         1wiwpUjdItJOz6x4quCpy4xX6fqU2/+S3yJzHFpnMh5OsjsrYIIjjK0q1sAKUR5ab6+9
         L2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770079772; x=1770684572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/mUTcFik0lAYGRu5XN3bc3aqN9ecQO0U1mOAc2KqK9k=;
        b=BJNi5kimYOSPnuO7nLSbgTcRA6QRx5ELrIvEE0Z9twRg/SEGCRyi2BKRvKoh+qZA+f
         8jVg0K0kjxz/XpCf/wDbdRN4AsefDskxjA/mdLXOtU315vl/YBNRH/kqqlFEg2nYZc3B
         Xa6DmrX1mR7Awr4CyPexvgT12rPpYWHCsG7DXgAf15DrwFmEApsWxNMXMwwAlTiU0RXG
         5z1QM8PGNFQgYHbq306HTC1jXQ34AtWDxZ93KRs70qaJMamU+WuIHdaGbqpXAQJjK3Ea
         zvNfNYeMHuBS8pIOjalrjI4BSaJRXlC8c31oC+CitlEacV95oQDYN1bGU1NPTLTWwAUS
         jVOA==
X-Forwarded-Encrypted: i=1; AJvYcCWFaGBm7xzt6plt7roCczKk0m75NUoo1U2NFWrBs3pRtWyYmXo5lR9aUiC1NU+7KN8R34v0Bp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMxVehbJKajvJfkCD0tQqrK9QZxCeAq5Ip9Hi1GnjP2ZYjGbqq
	VuXKJtGiCiDbOONL+Vr7JogmYyN/5EIj3kfX7J0gMG+tRrCEBx7sHrtV1hid8fjnkA==
X-Gm-Gg: AZuq6aKqXptViQcHcIfjOR9ip1CKyd+EhLRy6mfp8GBl/J5zWzizEa56TJfkxZG7FPH
	QWZc/Zpeg6S/MQt+R3u+qYZ2yqJCIlOn/uVRJCDqQfaDemblJ6AbxGdkhv52LAkDbVU0uD4oq+d
	QErJB5OOm51weELlf/6gm0pYiqEKbu3+3gy7+65c29G1t1jIvJ44OitL3jFe1bfKvn/jOBQ543D
	JW/iwF0eIk3s5if1eYwNzDPwjxFOJVuz69a4Bk258k1unM6fNNasL2pUYKqU4nGwmVueaHqyP6R
	3ESRU9uIF5uXDrhMBPkF7szERIiZoCkHP/a9cg/O8UhBAVQAgGRbSkZ5MhVEX+7Q8d/6O6rWKKc
	6qN8eFjhQEqk/vxrMvTaBl1Cnor+nnFXdjSNOYYU0EW66wdSehAu9f0D8r4Sta9qMHgR2os7aFu
	rc2LYCZ1kqLdWdQJh0W04QYr1HL/23ZO9YlogKsDYYldAYhA7eapceFWtrs3LiqdUq9jg=
X-Received: by 2002:a05:7300:e7ab:b0:2b4:706d:4e23 with SMTP id 5a478bee46e88-2b7c851d467mr4729510eec.0.1770079772541;
        Mon, 02 Feb 2026 16:49:32 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:d7c2:35ea:5a4f:74f9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1abe92dsm21017016eec.17.2026.02.02.16.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 16:49:32 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be,
	willemdebruijn.kernel@gmail.com
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v6 08/10] test: Add proto_nums.py in networking selftests
Date: Mon,  2 Feb 2026 16:48:51 -0800
Message-ID: <20260203004853.94438-9-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203004853.94438-1-tom@herbertland.com>
References: <20260203004853.94438-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[herbertland.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,vger.kernel.org,uliege.be,gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256050-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tom@herbertland.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[herbertland.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[herbertland.com:email,herbertland.com:dkim,herbertland.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,proto_nums.py:url]
X-Rspamd-Queue-Id: F24BFD3273
X-Rspamd-Action: no action

Add proto_nums.py that contains various python definitions of
common protocol constants

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 tools/testing/selftests/net/proto_nums.py | 231 ++++++++++++++++++++++
 1 file changed, 231 insertions(+)
 create mode 100644 tools/testing/selftests/net/proto_nums.py

diff --git a/tools/testing/selftests/net/proto_nums.py b/tools/testing/selftests/net/proto_nums.py
new file mode 100644
index 000000000000..d9dd71176af4
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
+	IP_PROTO_HOPOPT = 0
+	IP_PROTO_ICMP = 1
+	IP_PROTO_IGMP = 2
+	IP_PROTO_GGP = 3
+	IP_PROTO_IPv4 = 4
+	IP_PROTO_ST = 5
+	IP_PROTO_TCP = 6
+	IP_PROTO_CBT = 7
+	IP_PROTO_EGP = 8
+	IP_PROTO_IGP = 9
+	IP_PROTO_BBN_RCC_MON = 10
+	IP_PROTO_NVP_II = 11
+	IP_PROTO_PUP = 12
+	IP_PROTO_ARGUS = 13
+	IP_PROTO_EMCON = 14
+	IP_PROTO_XNET = 15
+	IP_PROTO_CHAOS = 16
+	IP_PROTO_UDP = 17
+	IP_PROTO_MUX = 18
+	IP_PROTO_DCN_MEAS = 19
+	IP_PROTO_HMP = 20
+	IP_PROTO_PRM = 21
+	IP_PROTO_XNS_IDP = 22
+	IP_PROTO_TRUNK_1 = 23
+	IP_PROTO_TRUNK_2 = 24
+	IP_PROTO_LEAF_1 = 25
+	IP_PROTO_LEAF_2 = 26
+	IP_PROTO_RDP = 27
+	IP_PROTO_IRTP = 28
+	IP_PROTO_ISO_TP4 = 29
+	IP_PROTO_NETBLT = 30
+	IP_PROTO_MFE_NSP = 31
+	IP_PROTO_MERIT_INP = 32
+	IP_PROTO_DCCP = 33
+	IP_PROTO_3PC = 34
+	IP_PROTO_IDPR = 35
+	IP_PROTO_XTP = 36
+	IP_PROTO_DDP = 37
+	IP_PROTO_IDPR_CMTP = 38
+	IP_PROTO_TP_PLUS_PLUS = 39
+	IP_PROTO_IL = 40
+	IP_PROTO_IPv6 = 41
+	IP_PROTO_SDRP = 42
+	IP_PROTO_IPv6_Route = 43
+	IP_PROTO_IPv6_Frag = 44
+	IP_PROTO_IDRP = 45
+	IP_PROTO_RSVP = 46
+	IP_PROTO_GRE = 47
+	IP_PROTO_DSR = 48
+	IP_PROTO_BNA = 49
+	IP_PROTO_ESP = 50
+	IP_PROTO_AH = 51
+	IP_PROTO_I_NLSP = 52
+	IP_PROTO_SWIPE = 53
+	IP_PROTO_NARP = 54
+	IP_PROTO_Min_IPv4 = 55
+	IP_PROTO_TLSP = 56
+	IP_PROTO_SKIP = 57
+	IP_PROTO_IPv6_ICMP = 58
+	IP_PROTO_IPv6_NoNxt = 59
+	IP_PROTO_IPv6_Opts = 60
+	IP_PROTO_any_1 = 61
+	IP_PROTO_CFTP = 62
+	IP_PROTO_any_2 = 63
+	IP_PROTO_SAT_EXPAK = 64
+	IP_PROTO_KRYPTOLAN = 65
+	IP_PROTO_RVD = 66
+	IP_PROTO_IPPC = 67
+	IP_PROTO_any_3 = 68
+	IP_PROTO_SAT_MON = 69
+	IP_PROTO_VISA = 70
+	IP_PROTO_IPCV = 71
+	IP_PROTO_CPNX = 72
+	IP_PROTO_CPHB = 73
+	IP_PROTO_WSN = 74
+	IP_PROTO_PVP = 75
+	IP_PROTO_BR_SAT_MON = 76
+	IP_PROTO_SUN_ND = 77
+	IP_PROTO_WB_MON = 78
+	IP_PROTO_WB_EXPAK = 79
+	IP_PROTO_ISO_IP = 80
+	IP_PROTO_VMTP = 81
+	IP_PROTO_SECURE_VMTP = 82
+	IP_PROTO_VINES = 83
+	IP_PROTO_IPTM = 84
+	IP_PROTO_NSFNET_IGP = 85
+	IP_PROTO_DGP = 86
+	IP_PROTO_TCF = 87
+	IP_PROTO_EIGRP = 88
+	IP_PROTO_OSPFIGP = 89
+	IP_PROTO_Sprite_RPC = 90
+	IP_PROTO_LARP = 91
+	IP_PROTO_MTP = 92
+	IP_PROTO_AX_25 = 93
+	IP_PROTO_IPIP = 94
+	IP_PROTO_MICP = 95
+	IP_PROTO_SCC_SP = 96
+	IP_PROTO_ETHERIP = 97
+	IP_PROTO_ENCAP = 98
+	IP_PROTO_any_4 = 99
+	IP_PROTO_GMTP = 100
+	IP_PROTO_IFMP = 101
+	IP_PROTO_PNNI = 102
+	IP_PROTO_PIM = 103
+	IP_PROTO_ARIS = 104
+	IP_PROTO_SCPS = 105
+	IP_PROTO_QNX = 106
+	IP_PROTO_A_N = 107
+	IP_PROTO_IPComp = 108
+	IP_PROTO_SNP = 109
+	IP_PROTO_Compaq_Peer = 110
+	IP_PROTO_IPX_in_IP = 111
+	IP_PROTO_VRRP = 112
+	IP_PROTO_PGM = 113
+	IP_PROTO_any_5 = 114
+	IP_PROTO_L2TP = 115
+	IP_PROTO_DDX = 116
+	IP_PROTO_IATP = 117
+	IP_PROTO_STP = 118
+	IP_PROTO_SRP = 119
+	IP_PROTO_UTI = 120
+	IP_PROTO_SMP = 121
+	IP_PROTO_SM = 122
+	IP_PROTO_PTP = 123
+	IP_PROTO_ISIS = 124
+	IP_PROTO_FIRE = 125
+	IP_PROTO_CRTP = 126
+	IP_PROTO_CRUDP = 127
+	IP_PROTO_SSCOPMCE = 128
+	IP_PROTO_IPLT = 129
+	IP_PROTO_SPS = 130
+	IP_PROTO_PIPE = 131
+	IP_PROTO_SCTP = 132
+	IP_PROTO_FC = 133
+	IP_PROTO_RSVP_E2E_IGNORE = 134
+	IP_PROTO_Mobility = 135
+	IP_PROTO_UDPLite = 136
+	IP_PROTO_MPLS_in_IP = 137
+	IP_PROTO_manet = 138
+	IP_PROTO_HIP = 139
+	IP_PROTO_Shim6 = 140
+	IP_PROTO_WESP = 141
+	IP_PROTO_ROHC = 142
+	IP_PROTO_Ethernet = 143
+	IP_PROTO_AGGFRAG = 144
+	IP_PROTO_NSH = 145
+	IP_PROTO_Homa = 146
+	IP_PROTO_BIT_EMU = 147
+
+# Hop-by-Hop and Destination Options numbers
+class HBHDst_Types(Enum):
+	HBHDST_TYPE_PAD1 = 0x0
+	HBHDST_TYPE_PADN = 0x1
+	HBHDST_TYPE_JUMBO = 0xc2
+	HBHDST_TYPE_RPL = 0x23
+	HBHDST_TYPE_RPL_DEPRECATED = 0x63
+	HBHDST_TYPE_TNL_ENCAP_LIMIT = 0x4
+	HBHDST_TYPE_ROUTER_ALERT = 0x5
+	HBHDST_TYPE_QUICK_START = 0x26
+	HBHDST_TYPE_CALIPSO = 0x7
+	HBHDST_TYPE_SMF_DPD = 0x8
+	HBHDST_TYPE_HAO = 0xc9
+	HBHDST_TYPE_ENDPOINT_ID = 0x8a
+	HBHDST_TYPE_ILNP_NONCE = 0x8b
+	HBHDST_TYPE_LINE_ID = 0x8c
+	HBHDST_TYPE_DEPRECATED = 0x4d
+	HBHDST_TYPE_MPL = 0x6d
+	HBHDST_TYPE_DFF = 0xee
+	HBHDST_TYPE_PDM = 0x0f
+	HBHDST_TYPE_MIN_PATH_MTU = 0x30
+	HBHDST_TYPE_IOAM_NO_CHNG = 0x11
+	HBHDST_TYPE_IOAM_CHNG = 0x31
+	HBHDST_TYPE_ALT_MARK = 0x12
+	HBHDST_TYPE_RFC3692_1 = 0x1e
+	HBHDST_TYPE_RFC3692_2 = 0x3e
+	HBHDST_TYPE_RFC3692_3 = 0x5e
+	HBHDST_TYPE_RFC3692_4 = 0x7e
+	HBHDST_TYPE_RFC3692_5 = 0x9e
+	HBHDST_TYPE_RFC3692_6 = 0xbe
+	HBHDST_TYPE_RFC3692_7 = 0xde
+
+# Routing header types
+class RoutingTypes(Enum):
+	ROUTING_TYPE_SRC_RT = 0
+	ROUTING_TYPE_NIMROD = 1
+	ROUTING_TYPE_2 = 2
+	ROUTING_TYPE_RPL = 3
+	ROUTING_TYPE_SRH = 4
+	ROUTING_TYPE_CRH16 = 5
+	ROUTING_TYPE_CRH32 = 6
+	ROUTING_TYPE_RFC3692_1 = 253
+	ROUTING_TYPE_RFC3692_2 = 254
+
+# Canonical extension header order
+class EH_Order(Enum):
+	IPV6_EXT_HDR_ORDER_HOP = (1 << 0)
+	IPV6_EXT_HDR_ORDER_DEST_BEFORE_RH = (1 << 1)
+	IPV6_EXT_HDR_ORDER_ROUTING = (1 << 2)
+	IPV6_EXT_HDR_ORDER_FRAGMENT = (1 << 3)
+	IPV6_EXT_HDR_ORDER_AUTH = (1 << 4)
+	IPV6_EXT_HDR_ORDER_ESP = (1 << 5)
+	IPV6_EXT_HDR_ORDER_DEST = (1 << 6)
+
+# ICMPv6 types
+class ICMP6_Type(Enum):
+	ICMPV6_DEST_UNREACH = 1
+	ICMPV6_PKT_TOOBIG = 2
+	ICMPV6_TIME_EXCEED = 3
+	ICMPV6_PARAMPROB = 4
+	ICMPV6_ECHO_REQUEST = 128
+	ICMPV6_ECHO_REPLY = 129
+	ICMPV6_MGM_QUERY = 130
+	ICMPV6_MGM_REPORT = 131
+	ICMPV6_MGM_REDUCTION = 132
+	ICMPV6_NI_QUERY = 139
+	ICMPV6_NI_REPLY = 140
+	ICMPV6_MLD2_REPORT = 143
+	ICMPV6_DHAAD_REQUEST = 144
+	ICMPV6_DHAAD_REPLY = 145
+	ICMPV6_MOBILE_PREFIX_SOL = 146
+	ICMPV6_MOBILE_PREFIX_ADV = 147
+	ICMPV6_MRDISC_ADV = 151
+	ICMPV6_MRDISC_SOL = 152
-- 
2.43.0


