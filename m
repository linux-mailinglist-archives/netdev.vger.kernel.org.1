Return-Path: <netdev+bounces-207218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 104F2B064CC
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 19:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44A9B1AA5A85
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 17:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769A327FD6E;
	Tue, 15 Jul 2025 17:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="DQw3ZyOd"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50D127F003
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 17:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752598949; cv=none; b=WgbR3vQ/cApwNdx11ea59v2P7MvnvJS7FlkkoNO3SjWFG5fUCTnkHh8xR+9FyI0sSuHa5skVWgE68ELOj7EoCuCIsjQRdC8JiXOClBOT8O1KBTvByXCP+rNeAUZwTdhpzWEUlaNZe9W3VJh9eb4tNwa4KKx1MmxRQ+ugXNiIAl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752598949; c=relaxed/simple;
	bh=g2Xa+K6XjkNtLzSDHICGzjVMAiXOwveZLkqSKlgXY8I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TjX66kmkLgEweYHXyprW2qq5XgDDgayDvh7U+dogz8e+rEdwlXlh/D1h+nXEmTDVJO4waCLI8SCCO5DFpq89Bs+d5CjrKROD7ED4k6BpuSJW6iX4Wunn6ewReU9vrtY8RNzNmrXOXAteJCn9M7DVGFu7niomOz17hTQNFe+y1h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=fail (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=DQw3ZyOd reason="signature verification failed"; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FBng0a032125;
	Tue, 15 Jul 2025 10:02:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=xdNeaE8MBYFMc0aFFDCT9HfgmrTi3DwS/k7gR5crN2I=; b=DQw
	3ZyOdJ8sYwG+FUKnBURpKbY2OxAFdafCDRac+bZ+BZ9wh0CY6VhMmyabABSvU2TM
	GEXq/IQrE/iGn1d16yMYBAKN4w9NzLFm6ObI0kbbMTUBP8vGqHbjZdx9EAnH8QK0
	+AN74bRxt4b27pgie5qBsdIn40VrtAu1llipJbVxz3EFB6+xX9lXKL/cc1x68I3u
	mYvjrjJ+4eGRtdyJywIBA+bOdqDvlrvQdMy4JW5S2gcCXrVeX0C+zsU2FKLyZSDy
	YmtplksjwMOTce967u1sn8oc9PYDkYCKpZs4SZTZw3XN5+YEf5m6dWr4bN/5bHZ+
	CfuEYPikEMFEpFjpJRw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47wpevgqyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 10:02:20 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 15 Jul 2025 10:02:19 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 15 Jul 2025 10:02:19 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 6CC875B692E;
	Tue, 15 Jul 2025 10:02:15 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, pabeni4redhat.com@mx0b-0016f401.pphosted.com,
        <horms@kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <bbhushan2@marvell.com>,
        <jerinj@marvell.com>, <lcherian@marvell.com>, <sgoutham@marvell.com>,
        <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next PATCH v2 00/11] Add CN20K NIX and NPA contexts
Date: Tue, 15 Jul 2025 22:31:53 +0530
Message-ID: <1752598924-32705-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: xTETavelcuEwpPZCDwL9pCkQTOddQz32
X-Proofpoint-ORIG-GUID: xTETavelcuEwpPZCDwL9pCkQTOddQz32
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE1NiBTYWx0ZWRfX8bOZ7VwK7gDi PZIy7qkC4t0uGQ1iwa7X8lbxWycP061yt3Fdaf/NEgbmGtsmkTjFEiWmLmxPM7el8QAopwwkPzE VcpfZKrK3PFcwXo/MM192SyZDSnWF9xvU5OXxAa6IwXy0KN9a8ZnSbK3F4uL0Krf+coxc/CT48/
 UFFdDPgc35TseYk9JKruPig42HxOBGmKy01tt7YPvGbb92BQHL0K9k2juojNDt3MDqf1w2MF8SR P0B34fICSnSGvLudYT7jlY7r+Bftq9kA7Eg6SlQG+q78F9VkosjS0priUmCQgZ87oybgZu/cJRw f/5xA2M8FXb/HCNiy0eoNNp73+MQEe3kkyJdLmQoPDDWLtAnxqhMUHoe4CBYqvPxXZfapanybxC
 NTHWS2bllmog9W+hWSOGl46DnQfd79vy0JNy1xsvWwI2ti+TgqJszbwALPYUMZJF86b86mWx
X-Authority-Analysis: v=2.4 cv=Pav/hjhd c=1 sm=1 tr=0 ts=6876899c cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=Wb1JkmetP80A:10 a=lrQ1NdiutdG-QJFGSGwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_04,2025-07-15_02,2025-03-28_01

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

v2 changes:
 Fixed string fortifier warnings by padding structures

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
 .../marvell/octeontx2/af/rvu_struct.h         |  13 +-
 .../ethernet/marvell/octeontx2/nic/cn10k.c    |  10 +
 .../ethernet/marvell/octeontx2/nic/cn20k.c    | 212 +++++++++++-
 .../marvell/octeontx2/nic/otx2_common.c       |  14 +
 .../marvell/octeontx2/nic/otx2_common.h       |  10 +
 16 files changed, 1032 insertions(+), 54 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/nix.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/npa.c

-- 
2.34.1


