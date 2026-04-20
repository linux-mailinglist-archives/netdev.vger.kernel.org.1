Return-Path: <netdev+bounces-279697-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wP33A8YC5mmBqQEAu9opvQ
	(envelope-from <netdev+bounces-279697-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 12:41:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E059429683
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 12:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF47A302B20F
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 10:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A55839A067;
	Mon, 20 Apr 2026 10:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="nGdM8Fcc"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46FB214204;
	Mon, 20 Apr 2026 10:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776681666; cv=none; b=ia1ya0mE+ubTLwGkyXCrY6B5s0M2UpC8+17vgkiWbrdf/dsmKvnJ2tQRaJnOmokEii7RKF1kaLIW0NYK++5mKA3QkelgtU7WQHYWnLwC1eai+1CUnx9IJS1Qe1Ms97Eb+vFuRqju+yy1d8MfuCBQV9/VP4KElu2A0+eIpWBvUus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776681666; c=relaxed/simple;
	bh=Pf677KovmnUk65KEriz0KIpiNlnDgtwneJAk/RSS+7c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JG5yV15zPO2EXHe1DUeuSvJR7MD5srRay2SA0DrF+pUd+k2HN89SrJKmVIeGClXzU0pFkTBNkphaAnDnjXNozqQhbFIu3bcEFEWtbYWRjyHaw7oH0X463vI/Wpp6baKUOOhQLuAo3PkLMp6rjEdsrEnfikXyAMHjOyAGZgSy7bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=nGdM8Fcc; arc=none smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0122330.ppops.net [127.0.0.1])
	by mx0b-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K9fMe43923168;
	Mon, 20 Apr 2026 11:40:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=jan2016.eng; bh=WRwFF0ak/kYmOvxu8pvV8fXOqllXynyOp
	w9YqXc5VjU=; b=nGdM8FccvIJ6v9RStvTCMXQwV1wySOWOCN/jZIl5ne5ylrxv9
	FbmFA+fH5ZR/Lo8e36MG3e1HtdSHVvGGsgnZ1GSwIJcbRrPwyc20kePfLoVI5Jiw
	GpNhXJnVO2PO7SGIlh3+WBzYvmWIQhUG4DAifree+BO809CLkedi3tzWWHPSD0zo
	G5lt31C/ZB/gjaRNyRIdD0RxdSkWGh+7L7qHjiTRbzz51Os1Mz4d0XTZvXUVajlW
	wYKHsV+IGzGtddfep3McAdygLgj0EogzA/305yT/Aqj6nhirhdL5HMoktGOyzCUY
	m6T/UcdBcaJNHRR3LjcyLgXuw7Ib8OuH/icEg==
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61])
	by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 4dm1ktcgt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 11:40:54 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
	by prod-mail-ppoint6.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 63KAQhM3031228;
	Mon, 20 Apr 2026 06:40:54 -0400
Received: from prod-mail-relay02.akamai.com ([172.27.118.35])
	by prod-mail-ppoint6.akamai.com (PPS) with ESMTP id 4dm59tqd1q-1;
	Mon, 20 Apr 2026 06:40:53 -0400 (EDT)
Received: from muc-lhvdhd.munich.corp.akamai.com (muc-lhvdhd.munich.corp.akamai.com [172.29.0.147])
	by prod-mail-relay02.akamai.com (Postfix) with ESMTP id D1ED78A;
	Mon, 20 Apr 2026 10:40:52 +0000 (UTC)
From: Nick Hudson <nhudson@akamai.com>
To: bpf@vger.kernel.org, netdev@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        Martin KaFai Lau <martin.lau@linux.dev>
Cc: Nick Hudson <nhudson@akamai.com>, Max Tottenham <mtottenh@akamai.com>,
        Anna Glasgall <aglasgal@akamai.com>
Subject: [PATCH bpf-next v5 0/6] bpf: decap flags and GSO state updates
Date: Mon, 20 Apr 2026 11:40:45 +0100
Message-Id: <20260420104051.1528843-1-nhudson@akamai.com>
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
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 mlxscore=0 mlxlogscore=940 phishscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604070000 definitions=main-2604200101
X-Proofpoint-ORIG-GUID: MAsql27h9d6O5u7AoM0sQIHf7vhJbvDO
X-Authority-Analysis: v=2.4 cv=Eaj4hvmC c=1 sm=1 tr=0 ts=69e602b6 cx=c_pps
 a=WPLAOKU3JHlOa4eSsQmUFQ==:117 a=WPLAOKU3JHlOa4eSsQmUFQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=4xFXqd-_BHBjZVyr95gr:22 a=X7Ea-ya5AAAA:8 a=1oy85zK9C34BhurvvrYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDEwMyBTYWx0ZWRfXzc6zodESEFdH
 Xh9IxmcIa5B0Xyk/qSmCfazyFXO4HVhnVjzQY9+LrVc6kPXfBzIaPJ9lFp2yJd9SU1eUeSnpD5t
 mXDDJNMT80+fqNdvREEb74Mle7zKPUae+XZybbqz1ONWzuPlatr+cmPozWvhSeu0uEklHl+us9Y
 blDARmWazlJMFWTxEPB16eY1RbyHNDNqR9t1ukhrOAyQvpovKpy1uNCmPGVzRWasRm0cSGTNk8m
 jkyR9JSKK3fu7F4Eq5LjQuGVQ8XAY0K5oQF9J+tPMDTKNb2/7O2z4sBY4MKiZMyS7Zk2b9lobZN
 3aX0cbbNKsVESi4saBOrDaT1Sv3bQySYSelONDKpeI/dV1ioUgOZN6zJ981hgZi/8oDTYyfXnpx
 zeb7envKQG0Hw7MaByvEGaB0F7657TsKD6JlDqzTtlW7FS04oJ5p6B+0Nk7XYFFPwCAIkkwQCoM
 Df+AeEdsyn4xehnoKjg==
X-Proofpoint-GUID: MAsql27h9d6O5u7AoM0sQIHf7vhJbvDO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604170000 definitions=main-2604200103
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[akamai.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[akamai.com:s=jan2016.eng];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-279697-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[nhudson@akamai.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[akamai.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 1E059429683
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


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
- Implement decap GSO flag clearing.
- Add selftests to validate decap GSO state transitions.

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
  bpf: clear decap tunnel GSO state in skb_adjust_room
  selftests/bpf: tc_tunnel validate decap GSO state

 include/uapi/linux/bpf.h                      |  36 +++++-
 net/core/filter.c                             | 118 +++++++++++++++---
 tools/include/uapi/linux/bpf.h                |  36 +++++-
 .../selftests/bpf/progs/test_tc_tunnel.c      |  58 +++++++++
 4 files changed, 225 insertions(+), 23 deletions(-)

-- 
2.34.1


