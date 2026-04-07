Return-Path: <netdev+bounces-275956-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEQgIsjq1GkjywcAu9opvQ
	(envelope-from <netdev+bounces-275956-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 13:30:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 995313ADB36
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 13:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 982EF300682E
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 11:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E286D3AD52D;
	Tue,  7 Apr 2026 11:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="BwHQtUyg"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFDE3AD522;
	Tue,  7 Apr 2026 11:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775561409; cv=none; b=apE0wk7A5DU19sxiNsqfMKIx+fLnX3pDu0aKXa0SgIzpBuZDeljkQAgx5gKS6vN/qVHIcSEwNOtD+JR6FJIuvsY8GkcE/Y304kmFV8LMfUtfncZgk5m2de0KJ6/ntMGD7ZKyvLcs9ibVkeLdwwxBGcOMUZWjxLSgTAmVKjQFvRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775561409; c=relaxed/simple;
	bh=KCKl5ztQqRvVLggW+dB1QE+I26Jh98Ml3MM3A41Du8I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FSXJoPLeYOClH+Bdg98DzCisSq3EWYB7uwpMZhWmuF0E1fQQ5PsBc3XLeiC3VCatPW2Cd0welJQdNnQSvNw6z0WCoh4tPrY5Xm9Oc6/BXyO1n33cGr0XK2T1VN9MhoND6RoaPFA+s/8W9KzrojVkCu+ZwXBx/ulTe5KbwWYJHx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=BwHQtUyg; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0409409.ppops.net [127.0.0.1])
	by m0409409.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id 6372FHPp536041;
	Tue, 7 Apr 2026 11:50:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=jan2016.eng; bh=Fm4QDEKMfHoElFxUNOQWeJg+0bZbYcXhJ
	UHvTev2Kjk=; b=BwHQtUygfm0Fv/n1vOERuJYH5Dkb8gTmvTbQs27I5+5MO3rEW
	Bjh8ZESvJKYtQI87LN0TRK1Oe9/MS6Y0ttFggQF+p0FjqUhHAoI9mCo6vvZSmCDF
	YQgdAF866BYPr6glCB4z974hyTpmRI8ysqWq78Y81Vn6xdepZwq5mU21tmN0RKvy
	uf0sMAEIpNNNzyI52MdGeUTtDWd/9DEUu0nbXxZ8G3MMbDWQrUwKzSbqnXTsle+u
	5M6eMi7E0rN1+Eq7fEaNqdx54Vobjnqi/INI5FGHayt2CW5VBnoXy2RnnNc6tNGy
	uP1Pst8bXw1hYZGFXx8iXmm0uGNXll4oSDRRA==
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60])
	by m0409409.ppops.net-00190b01. (PPS) with ESMTPS id 4dbbymrgce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 11:50:12 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
	by prod-mail-ppoint5.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 637AoB7B001156;
	Tue, 7 Apr 2026 03:50:11 -0700
Received: from prod-mail-relay01.akamai.com ([172.27.118.31])
	by prod-mail-ppoint5.akamai.com (PPS) with ESMTP id 4dcmehtbbs-1;
	Tue, 07 Apr 2026 03:50:11 -0700 (PDT)
Received: from muc-lhvdhd.munich.corp.akamai.com (muc-lhvdhd.munich.corp.akamai.com [172.29.0.147])
	by prod-mail-relay01.akamai.com (Postfix) with ESMTP id 9EE7780;
	Tue,  7 Apr 2026 10:50:08 +0000 (UTC)
From: Nick Hudson <nhudson@akamai.com>
To: bpf@vger.kernel.org, netdev@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        Martin KaFai Lau <martin.lau@linux.dev>
Cc: Nick Hudson <nhudson@akamai.com>, Max Tottenham <mtottenh@akamai.com>,
        Anna Glasgall <aglasgal@akamai.com>
Subject: [PATCH bpf-next v3 0/6] bpf: decap flags and GSO state updates
Date: Tue,  7 Apr 2026 11:49:59 +0100
Message-Id: <20260407105005.1639815-1-nhudson@akamai.com>
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
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604010000 definitions=main-2604070101
X-Authority-Analysis: v=2.4 cv=K+sS2SWI c=1 sm=1 tr=0 ts=69d4e164 cx=c_pps
 a=NpDlK6FjLPvvy7XAFEyJFw==:117 a=NpDlK6FjLPvvy7XAFEyJFw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=TTBIr9FR-UdC54aaq7Eb:22 a=X7Ea-ya5AAAA:8 a=1oy85zK9C34BhurvvrYA:9
X-Proofpoint-ORIG-GUID: ijNFZiXVfNJ-jGjMPJPGl-nydoVvelqL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA5OSBTYWx0ZWRfXy9nnJCfjpXMF
 CbRl83AwyEWMopRMw1A8RUNLl1Y6lSd1Odnl0VYLfG3DnLpq5G1r7kxA+4ejgUctVbbidyUA5wr
 jHMyHw4bxFsDRBPB9JoiiX1DaKDsXRTQbhJc/2NW0qhf0ChcnqgxTDYk43Yy9T5E4xLOoHUCaAi
 9cAGPhQKN/zGmh0VP9H7z70WTgGjIWua0M/u5svuI44lMsjLAsTIC6wvFXOaHL8AMg/WSx6tKOx
 YMoGampnqgEUU5g2Trbo3FDiY1wEYRaDwqZhTOsbxSqOn50yWz/UOHoSVyyxESePUMY0/vsTsqM
 BX8gQbGG9gCNaiAE5RKdtR9vwIhl4FHmw6xRvO/3Wa1Y5CjFO11JvvEnRJoHO3xauqqmGFLOqIq
 7Sh66UzeJXh41FSS0qQmNeFUtILruQj8F3mrkLovJ+ObEbZwmigKXVoDSwA7EH8TNIqHJUmzBoj
 cxGf5dLEQOrzyi0+8qw==
X-Proofpoint-GUID: ijNFZiXVfNJ-jGjMPJPGl-nydoVvelqL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070099
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[akamai.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[akamai.com:s=jan2016.eng];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-275956-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 995313ADB36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series extends bpf_skb_adjust_room() with decapsulation-specific
flags and tunnel GSO state updates for decap use cases.

Motivation
----------

When BPF decapsulates tunneled packets, skb GSO state needs to be updated
to match the removed tunnel layer. This includes clearing the corresponding
tunnel GSO type bits and resetting encapsulation state once no tunnel GSO
flags remain.

Series Overview
---------------

- Name the adjust_room flag enum for CO-RE lookups.
- Refactor adjust_room helper masks for maintainable validation logic.
- Add new DECAP flags to UAPI.
- Add guard rails for incompatible/invalid decap flag combinations.
- Implement decap GSO flag clearing.
- Add selftests to validate decap GSO state transitions.

Changes v2 -> v3:
- Add a new selftests patch to validate decap GSO state behavior.
- Reorder the series so helper-mask refactoring precedes UAPI DECAP flag additions.
- Refresh patch 2 and patch 3 split to keep refactoring behavior-neutral.
- Patch 5: add decap tunnel GSO-state checks in
  "bpf: clear decap tunnel GSO state in skb_adjust_room" (per Gemini/sashiko).

Changes v1 -> v2:
- Patch 3: decap flag acceptance intentionally remains L3-only while adding helper masks.
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
 net/core/filter.c                             | 120 +++++++++++++++---
 tools/include/uapi/linux/bpf.h                |  36 +++++-
 .../selftests/bpf/progs/test_tc_tunnel.c      |  58 +++++++++
 4 files changed, 227 insertions(+), 23 deletions(-)

-- 
2.34.1


