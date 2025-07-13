Return-Path: <netdev+bounces-206431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4875CB031C0
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 17:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C45F17BB3F
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 15:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BAC27E1D5;
	Sun, 13 Jul 2025 15:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="PMaO7L4A"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA27E27A139
	for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 15:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752420707; cv=none; b=IUOU11+koq4FzBGpoUz8MQ/ktIXPM0+QmKPg6AzWNktEwlSGvGBLQO+MP6bsJ6dRDQOFumYxPDjcmgivyVRD1ZL36etY6FRJq2riRHXwg64ld75SOex3O2jQrj4+K4vX9waXDoB+JoZOS4sNiAwBoAle4JqPPjHUYsrLRq+YHX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752420707; c=relaxed/simple;
	bh=BjLDopJ6h3kLamMz6XPzbEBW69MaAZl9/Hb7nWXFlNY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dV6oOvFM5H7Sd+YO43/xcjPRx7aIzUAWZ/85WJTanwUQznsFi25b6GnRUC6QDJ2U1ZzPIEueg+t8zsn3UaBMQOuGM8e2yV+1pXgcbIeKRBZHvBuB4VkcNI/V2HlCK3Ydb+QQkO5gnFyhAvl9jY3uEdn5e/isobVyL37gA9MxRmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=PMaO7L4A; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DF0Mxg001880;
	Sun, 13 Jul 2025 08:31:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=IDRWh51VYRKUBjphinEQAEkmPR821hyUC3MrhtfOyFg=; b=PMa
	O7L4AZB5HXJoHVaBvyw3N1hjYdtxSR3o4UKneiu/baAevX75R9PdFNLgHaLVaaNR
	4GtAFUIUOPIWefhYG80gGjCdNgapQINEZQQjvMNtJO399v0C/AnElBKoJK/sFK0V
	0gas0TsXpbgGLgHv55ksIJcAaEtsysH36BJYUTc9Zv09L53DCzKcq52C6pfHk1uW
	fYsHVImkA/DR1CdCZgJMgiKKWrXopDwyH0o4dMNjs0gDV6DhkbgW8jdpRh84FZjB
	QM8FUQv+2gfVkl1rW2V3PdduJRi8xMFwtfeSxlhnY9Tr8nehQVTxuIcMxmUzxSla
	LQp03LztAQMbNtIys5g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47v1dpgvc9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Jul 2025 08:31:20 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 13 Jul 2025 08:31:18 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 13 Jul 2025 08:31:18 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 6286E5B694A;
	Sun, 13 Jul 2025 08:31:15 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <bbhushan2@marvell.com>,
        <jerinj@marvell.com>, <lcherian@marvell.com>, <sgoutham@marvell.com>,
        <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next PATCH 00/11] Add CN20K NIX and NPA contexts
Date: Sun, 13 Jul 2025 21:00:58 +0530
Message-ID: <1752420669-2908-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEzMDEwOCBTYWx0ZWRfX1HWXinPUneeB YGuc4D5P43g/pc8ktjPhF7lj5frzBOawsaGJUwKkthVTmxdqNFrecJ0DkASI7CJadiBC9V0tVlk yOqnKHVx5cmnJOcE3mpSiE+uaQ5EB6ssc3UhayuQhOsTyPZNWttXNQdAzLt0a7U7C9ATns1GuXA
 MvZl4jysuA3J/FQ0uYBam/9gaI4F25216MHAivjRJJKojkpEW7j+W2m5Wsdp8EGt67m2I1bcCFJ 1pQ6C3VU2EwgqSVA1voLSxUn7VJ0M+OyuZDEkKKUoG7dKqP5FWgtaI4+B9T98w6+evbuGRuQM9y 4l8s176X7Wew2S07TV24bPFt7cW3RfUnwcKh7MVdT3zHz8BZu+qDuCT17jk7HLXFu6PN04x+qqu
 xtIr2rrKqHNm7wD3SWsqbpLgO+Xx6hHJXIvm4hmn+SMPK1Hvls0m5O7IhWgdq6/7SKCaVYFL
X-Authority-Analysis: v=2.4 cv=Y8j4sgeN c=1 sm=1 tr=0 ts=6873d148 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=Wb1JkmetP80A:10 a=lrQ1NdiutdG-QJFGSGwA:9
X-Proofpoint-ORIG-GUID: 4jHxY037eWwo6ulC9qPOxYpK3-1lV6oF
X-Proofpoint-GUID: 4jHxY037eWwo6ulC9qPOxYpK3-1lV6oF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-13_01,2025-07-09_01,2025-03-28_01

The hardware contexts of blocks NIX and NPA in CN20K silicon are
different than that of previous silicons CN10K and CN9XK. This
patchset adds the new contexts of CN20K in AF and PF drivers.
A new mailbox for enqueuing contexts to hardware is added.

Patch 1 simplifies context writing and reading by using max context
size supported by hardware instead of using each context size.
Patch 2 and 3 adds NIX block contexts in AF driver and extends
debugfs to display those new contexts
Patch 4 and 5 adds NPA block contexts in AF driver and extends
debugfs to display those new contexts
Patch 6 omits NDC configuration since CN20K NPA does not use NDC
for caching its contexts
Patch 7 and 8 uses the new NIX and NPA contexts in PF/VF driver.
Patch 9, 10 and 11 are to support more bandwidth profiles present in
CN20K for RX ratelimiting and to display new profiles in debugfs

Linu Cherian (4):
  octeontx2-af: Add cn20k NPA block contexts
  octeontx2-af: Extend debugfs support for cn20k NPA
  octeontx2-af: Skip NDC operations for cn20k
  octeontx2-pf: Initialize cn20k specific aura and pool contexts

Subbaraya Sundeep (7):
  octeontx2-af: Simplify context writing and reading to hardware
  octeontx2-af: Add cn20k NIX block contexts
  octeontx2-af: Extend debugfs support for cn20k NIX
  octeontx2-pf: Initialize new NIX SQ context for cn20k
  octeontx2-af: Accommodate more bandwidth profiles for cn20k
  octeontx2-af: Display new bandwidth profiles too in debugfs
  octeontx2-pf: Use new bandwidth profiles in receive queue

 .../ethernet/marvell/octeontx2/af/Makefile    |   3 +-
 .../marvell/octeontx2/af/cn20k/debugfs.c      | 216 ++++++++++++
 .../marvell/octeontx2/af/cn20k/debugfs.h      |  28 ++
 .../ethernet/marvell/octeontx2/af/cn20k/nix.c |  20 ++
 .../ethernet/marvell/octeontx2/af/cn20k/npa.c |  21 ++
 .../marvell/octeontx2/af/cn20k/struct.h       | 326 ++++++++++++++++++
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  73 ++++
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   3 +
 .../marvell/octeontx2/af/rvu_debugfs.c        |  39 ++-
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  69 ++--
 .../ethernet/marvell/octeontx2/af/rvu_npa.c   |  29 +-
 .../marvell/octeontx2/af/rvu_struct.h         |   6 +-
 .../ethernet/marvell/octeontx2/nic/cn10k.c    |  10 +
 .../ethernet/marvell/octeontx2/nic/cn20k.c    | 212 +++++++++++-
 .../marvell/octeontx2/nic/otx2_common.c       |  14 +
 .../marvell/octeontx2/nic/otx2_common.h       |  10 +
 16 files changed, 1026 insertions(+), 53 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/nix.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/npa.c

-- 
2.34.1


