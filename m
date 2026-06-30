Return-Path: <netdev+bounces-302984-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sWooOQBhQ2qLXgoAu9opvQ
	(envelope-from <netdev+bounces-302984-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 08:24:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 428206E0B87
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 08:24:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=kUtTuBdq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302984-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302984-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51DE0303FDC7
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 06:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750DE3CC314;
	Tue, 30 Jun 2026 06:22:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41E73E6385;
	Tue, 30 Jun 2026 06:22:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782800550; cv=none; b=uCDD6rTl2xmPCrdWHlEyi2JNaoqCJa3zmnUK62V6GaOowt5g4X8GnIUsGzCl4oN+d1O6bpgDtqam9dlwg7BADFzF+0JYE1fhDikouvJDiCS3SPrUCm5+/aM0aU8hhN18ytkcfo0lOiE4BdaeurT9LENIYv5PIqL6JYufLNO1xHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782800550; c=relaxed/simple;
	bh=barWliMWn7GD560kAYcTsy1VJInvXDivBF/9OA78ejk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s8cJr3j1+9cml+4nxpVo9JbBqDejPRZgcv511x7mWIy/3UA28MKfdcNY9QlhxEBH1RxvJAOM+yXOcRFSjTc3hWMxdakqFdeNkstK261M0eSnFdSRjiEPECXOcPY+w75usLZDE12g26xEwFBQU34+PvAS1vkUm5FUsfB1K1VtEww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=kUtTuBdq; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U5d8b83954376;
	Mon, 29 Jun 2026 23:22:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=m
	vS2OYZ8YFMh0kFbSk41ihRsmSk4pKd4V9IygirL5zY=; b=kUtTuBdqV+l05nOJg
	jtdIuSGcc4QNieyY059dMKJK1MglvyUPOeXlgeRQSGvYOrbbsyMZTpDLuWPjOfLo
	9K1x94u5kz7xYADYf4s6slbcsTxSzWFjGnz7Rw+MZTtU37DCWiwy1q1fYM+GSmPh
	PeaqnC+QS7erkQSzZ6rD7Pv4+mOJKZURDHQ1ww6cqq6h8IXbIO2E9Ntga/CC/nki
	k3CBKs2dDhERee2I2Q/ekyzypHbzF6/crfhEM+qFEQtUi/HGf79O+caeNYwINeoW
	Rpjp7fbKmjgajwzQvcMQoLpANaoCrhsRXYioRBIsjdy0vUATDQmsUchBokOkMeA+
	ErXFg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4f3uwfajmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 23:22:17 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 29 Jun 2026 23:22:17 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 29 Jun 2026 23:22:17 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id 8EE7E3F7068;
	Mon, 29 Jun 2026 23:22:12 -0700 (PDT)
From: <nshettyj@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <lcherian@marvell.com>, <gakula@marvell.com>,
        <hkelam@marvell.com>, <sbhatta@marvell.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, Kiran Kumar K <kirankumark@marvell.com>,
        Nitin Shetty J
	<nshettyj@marvell.com>
Subject: [PATCH v2 2/2] octeontx2-af: Add RSS hashing support based on RoCEv2 header
Date: Tue, 30 Jun 2026 11:51:45 +0530
Message-ID: <20260630062145.2533816-3-nshettyj@marvell.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260630062145.2533816-1-nshettyj@marvell.com>
References: <20260630062145.2533816-1-nshettyj@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: LeIZPV5xVfehmN02l3x1NRyh13m90jVD
X-Authority-Analysis: v=2.4 cv=WNJPmHsR c=1 sm=1 tr=0 ts=6a43609a cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=cXRBxlROMJ_9lSWe8g4A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: _eJb9EaRd7_5ohx56cexWfT9hkVdShnf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA1MiBTYWx0ZWRfXzBveQjNIUdQQ
 5bOg4BxRDtyq+V+MUrrA57yXLxOlf7qcFy3FNYRBH3gu/KgNivUQ8eiorDLbuuW0o3Fuug3a4DF
 QjOw1ErTxinSW9FUX2hetQ+Y3AAVsPg0odFueHuC5iQWqQBXvUT8tvCUWATF1R4gmcP8BYS0K5M
 Z+4NSWdBDkD1F4QAkDEV4nQhFdq6BeDIPDzPTtTPgyOFCY96t1oCiJ0mryODYNPR8w3QEq+GYIW
 6N0OgreQH9InNXv4RU2Z8s2oQIjZnT8qK8lSiv/wt9DOCOdMe8BjSDzrz0ANN8uV/wWULpInyNZ
 xd07GgGKY5cRW61hCQu4TYh5ZPf04fqDbyae3tGoKAxjJ1GVyjVgzuK9X51xDCTLmDzCUAXF7Fq
 digp4Hw0RAXLFdK3qnP5XENzq4yeCA2whmx9ghenCEc/XOsZv6EjQtiRAXlWjUSbzymIcEDdM9E
 cySUavJ7jotTyGFbsOQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA1MiBTYWx0ZWRfX+pvuL+Guc27M
 BpR91ilfq+/wTh8Z7AIyA8UO/aeEfaYOQStyQVwBh1+pc+3HvmQafB+SXiTbWfWX9O6nk2zGqfH
 xkFwQZlQQ3ebWpNlUS/9lMzBjyvgaL4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_02,2026-06-26_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302984-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[nshettyj@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sgoutham@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:kirankumark@marvell.com,m:nshettyj@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,marvell.com:email,marvell.com:mid,marvell.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nshettyj@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 428206E0B87

From: Kiran Kumar K <kirankumark@marvell.com>

Add NIX_FLOW_KEY_TYPE_ROCEV2 flow key type to support RSS hashing on
the RoCEv2 destination Queue Pair (QP) field, allowing RoCEv2 traffic
to be distributed across receive queues.

Signed-off-by: Kiran Kumar K <kirankumark@marvell.com>
Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
---
v2:
- Fixed coding style.
---
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h    | 1 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 83f0da3a93fb..f87cdf1b971d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1268,6 +1268,7 @@ struct nix_rss_flowkey_cfg {
 #define NIX_FLOW_KEY_TYPE_IPV4_PROTO	BIT(21)
 #define NIX_FLOW_KEY_TYPE_AH		BIT(22)
 #define NIX_FLOW_KEY_TYPE_ESP		BIT(23)
+#define NIX_FLOW_KEY_TYPE_ROCEV2	BIT(24)
 #define NIX_FLOW_KEY_TYPE_L4_DST_ONLY BIT(28)
 #define NIX_FLOW_KEY_TYPE_L4_SRC_ONLY BIT(29)
 #define NIX_FLOW_KEY_TYPE_L3_DST_ONLY BIT(30)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 144076e161c6..8e3bb47eb3ba 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -4305,6 +4305,13 @@ static int set_flowkey_fields(struct nix_rx_flowkey_alg *alg, u32 flow_cfg)
 				keyoff_marker = false;
 			}
 			break;
+		case NIX_FLOW_KEY_TYPE_ROCEV2:
+			field->hdr_offset = 5;
+			field->bytesm1 = 2; /* Destination QP */
+			field->ltype_mask = 0xF;
+			field->lid = NPC_LID_LE;
+			field->ltype_match = NPC_LT_LE_ROCEV2;
+			break;
 		}
 		field->ena = 1;
 
-- 
2.48.1


