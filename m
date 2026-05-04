Return-Path: <netdev+bounces-283798-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AP1ZOuh/+GmXwAIAu9opvQ
	(envelope-from <netdev+bounces-283798-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 13:15:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 497CB4BC467
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 13:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BED1C301991E
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 11:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4728C391E45;
	Mon,  4 May 2026 11:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="etnPPRaE"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF3E168BD;
	Mon,  4 May 2026 11:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777893343; cv=none; b=aUygSPMjegtI74U3M+RQDyl0UMjjADkOmwCX/woMf/aqJwL4Isk/IwpXvt5cWE4QL+6Cr3Ud36GXCamd6QI/UoJZpbLb9gVtO13sLj3h7U8fGbWMddwOguC4e3gq1v+JUlG8Te/vo0EMs/LUPYkJLf179Qsrj3pxtXArS6nxqrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777893343; c=relaxed/simple;
	bh=4osoaC9ULRt+4TLmPswqg2KcCVPsZe/vyQEqG0SoY1U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uQfcJAKW99S7vYBk/D+uMN0cfoPKsenbbEW2Jz+ho/+6mi3jFzJ5CcCH6dzUuj8GkNLYF7nxnKHqMoKnbLWrKOXwlr7AatSIWV/EnGiuDO7xIrT3bxOEv6Az3KH/viTDeR0TTbbaECTNCOO93Bs7dZT//n0YWUCd959zTf1fxG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=etnPPRaE; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
	by m0050093.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id 643MqLk02006127;
	Mon, 4 May 2026 11:18:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=jan2016.eng; bh=pvoGKj2RPkl+IEzPTmKy0HEr6NZA0fp/3
	u8yXbIUFOw=; b=etnPPRaEaRAALa0gxqZLGS1byuCzA3bkCT+CrjcIm8RLO3e/t
	lT7vtJ319g1wf4ZR1r0OteqKrgIE6VQzWA9fK0pD62rYazcOC7EXvVeC+w6fkgY4
	akvZ+5BJg+/l+WtSH6q+IgEH18v86YT3gDkzVwTgTa7Bxsq4k+BNW8iQV0Ey84Ym
	0cXzUcvgq4M/NaoE2OHoz/V90MpyQkYEKiXnBMb6pD4eaYChtMziFMv23Qn1fdoH
	8iefVFC3RA3gkNdLSWQbR9FTOZ9PYHb8kws7gYCz1+xzmPjYYRI8cAcq+4yfrtqz
	Zib1GniI4cw/qpOugrUE0QmVCvTk9d5AW8ttw==
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61])
	by m0050093.ppops.net-00190b01. (PPS) with ESMTPS id 4dw8hp8vd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 11:18:03 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
	by prod-mail-ppoint6.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 644ACCZm014212;
	Mon, 4 May 2026 06:18:02 -0400
Received: from prod-mail-relay01.akamai.com ([172.27.118.31])
	by prod-mail-ppoint6.akamai.com (PPS) with ESMTP id 4dwckxf3fu-1;
	Mon, 04 May 2026 06:18:02 -0400 (EDT)
Received: from muc-lhvdhd.munich.corp.akamai.com (muc-lhvdhd.munich.corp.akamai.com [172.29.0.147])
	by prod-mail-relay01.akamai.com (Postfix) with ESMTP id 5113984;
	Mon,  4 May 2026 10:18:01 +0000 (UTC)
From: Nick Hudson <nhudson@akamai.com>
To: bpf@vger.kernel.org, netdev@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        Martin KaFai Lau <martin.lau@linux.dev>
Cc: Nick Hudson <nhudson@akamai.com>, Max Tottenham <mtottenh@akamai.com>,
        Anna Glasgall <aglasgal@akamai.com>
Subject: [PATCH bpf-next v6 0/6] bpf: decap flags and GSO state updates
Date: Mon,  4 May 2026 11:17:53 +0100
Message-Id: <20260504101759.3319427-1-nhudson@akamai.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=785 suspectscore=0 spamscore=0 phishscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2604200000
 definitions=main-2605040108
X-Authority-Analysis: v=2.4 cv=Z8fc2nRA c=1 sm=1 tr=0 ts=69f8725b cx=c_pps
 a=WPLAOKU3JHlOa4eSsQmUFQ==:117 a=WPLAOKU3JHlOa4eSsQmUFQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=d4nn1RXdvEacMIURMw2s:22 a=X7Ea-ya5AAAA:8 a=g1FTZKP8ERfPk9Mz4Y4A:9
X-Proofpoint-ORIG-GUID: HldOv0ZmmUBAEeajCSKNNNl7l0Wnxj4r
X-Proofpoint-GUID: HldOv0ZmmUBAEeajCSKNNNl7l0Wnxj4r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDEwOSBTYWx0ZWRfX+UviPLXiPnkD
 fsvAgZdwzQfzHm6qn9xQOjP+XKUh7Plr9b83Z9QELBrunks8Ra9Kc5oAKyOd9rXlrGDMt2HCYg6
 ok+8zJMj2FghDHEztixRtsJUwFUzBs5oG1215ODs1LNuQkuzvfvUEX3bYXUpidNg4o0W1L3oXkF
 /zzAJ4ZvpAnzQTlGTn0wfVSojpP6pTvfNTO9uspKzfiF6npfU+5ttdKkjqziqTJfv7Ie6R0Ba6q
 dcqmGzngPirxiBcXY1JgiWPji4CCcP480Y5D00ZtUH8ieJVmH2X5q473nJzQO4wXd9mxo/16bQn
 OisaRE5MlwLL6uKVPvWz3Xk78AKsVkTEmY5rg2d3oOfO3FMnkJrAgfvI6aNT7m8vmZR5BFxKZGZ
 pHNpvRnDj5phFxfNDVf7Vu39gwhTFFGLgDGPMtpHn5Yfp1RqvCHV6a1drRzqpm21aoOBlbH44Oa
 S01QZqqhvNAYehNfvlw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 phishscore=0 clxscore=1015 adultscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040109
X-Rspamd-Queue-Id: 497CB4BC467
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[akamai.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[akamai.com:s=jan2016.eng];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283798-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,akamai.com:email,akamai.com:dkim,akamai.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nhudson@akamai.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[akamai.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]


This series extends bpf_skb_adjust_room() with decapsulation-specific
flags and tunnel GSO state updates for decap use cases.

Motivation
----------

When BPF decapsulates tunneled packets, skb GSO state needs to be
updated to match the removed tunnel layer. This includes clearing the
corresponding tunnel GSO type bits and resetting encapsulation state
once no tunnel GSO flags remain.

Series Overview
---------------

- Name the adjust_room flag enum for CO-RE lookups.
- Refactor adjust_room helper masks for maintainable validation logic.
- Add new DECAP flags to UAPI.
- Add guard rails for incompatible/invalid decap flag combinations.
- Implement decap GSO state clearing on shrink.
- Add selftests to validate decap GSO and encapsulation state.

Changes v5 -> v6:
- Patch 5: extend decap-state handling for the new L4/IPXIP decap
  flags to non-GSO packets as well: when decapsulation is requested
  on a non-GSO skb, clear skb->encapsulation directly so behavior is
  consistent with the GSO path.
- Patch 6: broaden tc_tunnel coverage to exercise and validate both
  GSO and non-GSO decapsulation paths. This includes selecting
  IPXIP decap flags from the outer tunnel header family, adding
  explicit post-decap encapsulation checks for non-GSO packets,
  and removing forced TSO disable so GSO cases are exercised in
  the test harness.

Changes v4 -> v5:
- Patch 5: Remove explicit clearing of encap_hdr_csum and
  remcsum_offload on UDP decap, per review feedback.
- Patch 6: Remove SKB_GSO_TUNNEL_REMCSUM from SKB_GSO_UDP_TUNNEL_MASK
  in selftests, and minor test improvements.

Changes v3 -> v4:
- Patch 5: drop SKB_GSO_TUNNEL_REMCSUM handling from this series.
- Patch 5: clear encap_hdr_csum and remcsum_offload directly on UDP
  decap.

Changes v2 -> v3:
- Add a new selftests patch to validate decap GSO state behavior.
- Reorder the series so helper-mask refactoring precedes UAPI DECAP
  flag additions.
- Refresh patch 2 and patch 3 split to keep refactoring
  behavior-neutral.
- Patch 5: add decap tunnel GSO-state checks in "bpf: clear decap
  tunnel GSO state in skb_adjust_room" (per Gemini/sashiko).

Changes v1 -> v2:
- Patch 3: decap flag acceptance intentionally remains L3-only while
  adding helper masks.
- Patch 4: decap with L4/IPXIP support enabled with guard rails.

Co-developed-by: Max Tottenham <mtottenh@akamai.com>
Signed-off-by: Max Tottenham <mtottenh@akamai.com>
Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Nick Hudson <nhudson@akamai.com>

Nick Hudson (6):
  bpf: name the enum for BPF_FUNC_skb_adjust_room flags
  bpf: refactor masks for ADJ_ROOM flags and encap validation
  bpf: add BPF_F_ADJ_ROOM_DECAP_* flags for tunnel decapsulation
  bpf: allow new DECAP flags and add guard rails
  bpf: clear decap state on skb_adjust_room shrink path
  selftests/bpf: tc_tunnel - validate decap GSO and encapsulation state

 include/uapi/linux/bpf.h                                |  36 ++++++++++-
 net/core/filter.c                                       | 119 ++++++++++++++++++++++++++++++-----
 tools/include/uapi/linux/bpf.h                          |  36 ++++++++++-
 tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c |   1 -
 tools/testing/selftests/bpf/progs/test_tc_tunnel.c      |  91 ++++++++++++++++++++++++---
 5 files changed, 252 insertions(+), 31 deletions(-)

-- 
2.34.1


