Return-Path: <netdev+bounces-303928-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jkwwM5PXRWrlFwsAu9opvQ
	(envelope-from <netdev+bounces-303928-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 05:14:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C4C6F32C8
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 05:14:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=KOVj9rf6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303928-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303928-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC733300D855
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 03:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C628E30F94D;
	Thu,  2 Jul 2026 03:14:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CE530DD00;
	Thu,  2 Jul 2026 03:14:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782962057; cv=none; b=SRoDKRb4Nv+lJBvf5MdjmQzwzDJz+gIzYOovO22/QCXhJbyMWUqqpvraXhzR7zvyWvkphu7gtHNd3h/XtN5JJQ0EuEmPKG6DA0WYxr0LBd63nGv+cnIa9Y/OqdUZ0UJdFhyxFvLNHBk8DTZ+3K6mu3I0FZtzTdwmj46QYIEFEqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782962057; c=relaxed/simple;
	bh=PpjczfdvNQ++KWK7VVMtY2XrBWlDxNBzlE3Qq6oZTUM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jJjo+WH/RU0doN8RoYrcf9ZgfNglmZkbH39UCXAJvGOHM+fcFwgrc/by0gzOnrbHhF+Rsb2DSphRO/sg1MoGYKZtvBuKd9PwCL48aslfKw6Cfit+EUSg1cLNCVJUoIMggH1hTqNb86zK1vO3B4y56ifbcq4nULbRHg2jv+ANHJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=KOVj9rf6; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6621N0S6570361;
	Wed, 1 Jul 2026 20:14:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=tBZKuXFbiwzkDLJPxwaYAri
	AnwfFmyeZqJCQl9rUooU=; b=KOVj9rf6gpvCK75FeO84zKbR5RnNcKNY8G00XpA
	5DHrDso3v6Wp4VcKeD7IPst5YGG3t1h/jv8TloR3IuO38qf0WGQWYP4R55mgQoIj
	Ffvsk7G7VEA9Vs4lw/P2fHxbbqTPjtHb521TrrDRxqLJC7PHeRT5ehaEyPVBRdzo
	Ot3oU1ro+XPPrB2HrTDJtQGzik50hDJXZo2VCwaI4Nvo1tZ8DfeY6WgiO/tU0W5p
	iJjEpSmuPg3Qp5z/jSKM2AtQAeyZ0ab3f1m5KvyBYMdYIAztbi2XnCEVCf5VyPKu
	jiPGWj6GLE49JTQNt1lNiI5xat85z0UZjAhwrpLwG8LIA1g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4f5b990stx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 20:14:06 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 1 Jul 2026 20:14:05 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 1 Jul 2026 20:14:05 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 328FA3F708A;
	Wed,  1 Jul 2026 20:14:01 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <stephen@networkplumber.org>, <dsahern@kernel.org>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <rkannoth@marvell.com>, <andrew+netdev@lunn.ch>, <edumazet@google.com>,
        <pabeni@redhat.com>, <jiri@resnulli.us>
Subject: [PATCH iproute2-next v4 0/2] devlink: support u64-array devlink parameters
Date: Thu, 2 Jul 2026 08:43:57 +0530
Message-ID: <20260702031359.2392868-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: WF-tlBbJiQXB6nB41k_AprL3mDJ4wEga
X-Authority-Analysis: v=2.4 cv=GPk41ONK c=1 sm=1 tr=0 ts=6a45d77e cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=snJZ9v3O13RfP-hfMHkA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: WF-tlBbJiQXB6nB41k_AprL3mDJ4wEga
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAyOSBTYWx0ZWRfX+BNLSU9hURMM
 j9HtvLvkD9zC7p74Nt+wGInhC1qF+tKOl4pSPSaV+5uefdzU4nO9wNARLVsLXbuKp6qI5ML0qo7
 lazBHgOEFBkyVjsJZHMfof8T68AM4hWEzqYCs1fbJ3dcwPAf9Vmn9+7iobgPcG20+OkWlLuHFod
 bzEEW6DXXWOLRO2uHP9Fj3jtETwooWHx1wUBF42wlNwGSBd2cBz7GKUBwbvgxUkJ3SA/3xOHjS2
 Fa6XnAhyekhyOCc39vOCxcfva68+CJ58EPeOyGOfjYZ8az18JtEL3CQulCKE2XbQjzLkvpo7mOC
 UL72Llu725CswAlQ/h7Eyrj5bkwkZau0hP97F4kjho0KvnmJPbYnJFZZZFQbdpARdf2/82XCsSx
 nj+HMSAoGRTvWKQUkUrCHX/iOqVH1JRFFfSo+ZcYjJIJgZFQfJQc3BqGP54u0AEc//fSQUlVlwF
 CGWUcnxbt2pLuI2KRrA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAyOSBTYWx0ZWRfX/DDodMlaLKhi
 wdeFhKGjytre5JbJWXpnwKPkO/jTOsL9OUB/je+9nS/4qWCxagvi6wjsjj/Di5Inc3Vdf0CYZgY
 CGXWqnCwPOVfi9lG8yWjCupUia5nKrQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303928-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stephen@networkplumber.org,m:dsahern@kernel.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:rkannoth@marvell.com,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:pabeni@redhat.com,m:jiri@resnulli.us,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,marvell.com:mid,marvell.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 07C4C6F32C8

The kernel gained support for devlink parameters of type
DEVLINK_VAR_ATTR_TYPE_U64_ARRAY.  These parameters carry a variable-length
list of u64 values encoded as multiple DEVLINK_ATTR_PARAM_VALUE_DATA
attributes.  This is used by drivers that need to expose ordered lists of
configuration values, such as the Marvell CN20K npc_srch_order parameter.

This series updates the devlink tool to handle the new UAPI and adds
show/set support for u64-array parameters on both device and port params.

Patch 1 switches devlink param show/set to use DEVLINK_VAR_ATTR_TYPE_*
constants instead of generic MNL_TYPE_* values when interpreting
DEVLINK_ATTR_PARAM_TYPE.  The kernel now reports param types using
devlink_var_attr_type, so userspace must use the matching symbols.

Patch 2 adds parsing, display, and configuration support for
DEVLINK_VAR_ATTR_TYPE_U64_ARRAY.  Values are shown as a space-separated
list of u64 elements.  Setting accepts a space- or comma-separated list
and emits one DEVLINK_ATTR_PARAM_VALUE_DATA attribute per element.

Tested on CN20K hardware with npc_srch_order:

  # show search order
  devlink dev param show pci/0002:01:00.0 name npc_srch_order
  pci/0002:01:00.0:
    name npc_srch_order type driver-specific
      values:
        cmode runtime value  value  0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31

  # set search order
  devlink dev param set pci/0002:01:00.0 name npc_srch_order \
    value 31,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30 \
    cmode runtime

Ratheesh Kannoth (2):
  devlink: use DEVLINK_VAR_ATTR_TYPE_* in param show/set
  devlink: support u64-array values in devlink param show/set

 devlink/devlink.c            | 178 ++++++++++++++++++++++++++++++++---
 include/uapi/linux/devlink.h |   1 +
 2 files changed, 164 insertions(+), 15 deletions(-)

--
v3 -> v4: Addressed David comments
	https://lore.kernel.org/netdev/20260701031359.839221-1-rkannoth@marvell.com/

v2 -> v3: Addressed David comments
	https://lore.kernel.org/netdev/akSCBN0N_7ug1-Fy@rkannoth-OptiPlex-7090/

v1 -> v2: Addressed David comments
	https://lore.kernel.org/netdev/20260615041042.549715-1-rkannoth@marvell.com/

2.43.0

