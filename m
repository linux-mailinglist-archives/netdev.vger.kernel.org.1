Return-Path: <netdev+bounces-207964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D17B092D9
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 19:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B063416CFE0
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 17:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533102F94AF;
	Thu, 17 Jul 2025 17:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="NiSmRnE0"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964BA149C6F
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 17:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752772197; cv=none; b=Y0jvckN9lwyLQim81cCl+lL2KMiYAbYioBD17HZyd7mVvp31pbE41KGRhFhj0I8rwmcNpg8uIzGYPCaJuIdeoZr6viaI3Dla9sMGn5CJH8Ec4syHjFPsHCWnbBPkwdtj0GuEHuilecgEQ3UCeQ/DWMAr5Dx4zzVi65mSjOgfVS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752772197; c=relaxed/simple;
	bh=XVjSXiN74gS6WGbl2bnhCkDcLGTo2S9JWJurSow44Oc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Iqm0zaAd5/CQTNjP+e2a1EX3Ndu+EU23a8AseN/Z+3lTn2ZSj1xrp4K12m+oTWJ685L1KWTUxWyXxlznuGDBacNFRjLPiWcPfh0TrGAOvUkoPxAoNIvujSg41r7buWZHalimp8SKW4MckdcWw5WbSs1GbKqWzU+mWch3qf8MUAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=NiSmRnE0; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H9e7IL019754;
	Thu, 17 Jul 2025 10:09:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=jH+tkKRTcksK+481hjLrYVCvFCq5KqPLWW+9RBxwaq8=; b=NiS
	mRnE0QuHErwUvcSj0L/D+yC0sWe+xlHZHaRXTaWMAP5olJt6zzwbHg/pkMUaRO1P
	mSYLOpNdyP8LdAC3T5P8TJRQQntqOBrVpls7Qb3sd8F0NbskUc1oynPNTQCaBVE1
	JznGoyXqg5oTAbGrJ4bqqOIlgRa55aVEnt16NKd5Y29I4/5AKQoxyPNHpOPYzuTh
	IrOoHz805aQSnyF8TerVUwghjN/MNVjf72UV/j54ir1kK7PEg+cRxJvELIOuAK2o
	a563ScQAIJOY5uW32dbyWH42QADFoGHgCzqu0LDwT/MfjI8O4cowMlrRNUrkPdiH
	26Mxb3OchuZ+Ft/oA1Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47xvpc96rt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 10:09:32 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 17 Jul 2025 10:09:31 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 17 Jul 2025 10:09:31 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 398B43F7044;
	Thu, 17 Jul 2025 10:09:26 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <bbhushan2@marvell.com>,
        <jerinj@marvell.com>, <lcherian@marvell.com>, <sgoutham@marvell.com>,
        <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next PATCH v3 00/11] Add CN20K NIX and NPA contexts
Date: Thu, 17 Jul 2025 22:37:32 +0530
Message-ID: <1752772063-6160-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=U8ySDfru c=1 sm=1 tr=0 ts=68792e4c cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=Wb1JkmetP80A:10 a=lrQ1NdiutdG-QJFGSGwA:9
X-Proofpoint-GUID: UU7E5MOJ3oA6zz8-sEPIvG9k1xjZzxJX
X-Proofpoint-ORIG-GUID: UU7E5MOJ3oA6zz8-sEPIvG9k1xjZzxJX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE1MSBTYWx0ZWRfX/EGXr5kpWKgl 4IX606k4kaIewng25jbwCix2O9vtdqKFybXWKg76V2dcjq959GYJcOkQOfarpfExu1o+AzF4PVs 6u+r/I0QAhlEWUF1jeF9M0t+C3JId5Qg88n4oY/M3LJ4M4v2ZgKukO4gX5edqcxKYsX8zefWZsZ
 EXr1nBRvGovfuno/aLrT4n5oJemcV/uvgdBHLPfliaDzuTYsE3zqh2t16AAdXEvJe6gvaitGfrm GGdVyAEzW4y48EMSS0aYgzrtErOwSjjV2AWSwtkms5VSnq2VN82X176ci8goTZv1VVSlAZ+IxEy vcQFb2325x6/5nUfjZe+lUu1GxSs2xRKL8Ym5r9g8J+Hin6s3baMzyeYp/KGfMaJ6hJ6RIiQQ8s
 AU/iII5XiIeNQ0HGuWT7D+0Kf91qfRdr6GjwfblUipO43Gi72ln6nJF2ffBdOEWl06GkyVa8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01

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

v3 changes:
 Added static_assert as suggested by Michal Swiatkowski
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
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  67 ++--
 .../ethernet/marvell/octeontx2/af/rvu_npa.c   |  29 +-
 .../marvell/octeontx2/af/rvu_struct.h         |  21 +-
 .../ethernet/marvell/octeontx2/nic/cn10k.c    |  10 +
 .../ethernet/marvell/octeontx2/nic/cn20k.c    | 212 +++++++++++-
 .../marvell/octeontx2/nic/otx2_common.c       |  14 +
 .../marvell/octeontx2/nic/otx2_common.h       |  10 +
 16 files changed, 1038 insertions(+), 54 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/nix.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/npa.c

-- 
2.34.1


