Return-Path: <netdev+bounces-138349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F69C9ACFF0
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 18:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6BDFB21908
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 16:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5F81CACCA;
	Wed, 23 Oct 2024 16:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Lq3oufyg"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4804436E;
	Wed, 23 Oct 2024 16:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729700340; cv=none; b=fLNuRCGgZYgBMNa3YkaO3nwj1aSF2D7drqfWLbfa2qgY0VKoL4xel15ug2bIlTxM0Pr8wHU8pzh1RaQ94E+ZpOvszR4Eu7Wr1TtQE0gdBjmzgnZjNK8SMHrgedFj2RWlF/+KlZeqQhRdXIbxEi+p+z8yN5VA+AnrhcD7DOz1Uz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729700340; c=relaxed/simple;
	bh=uLEJ/y2RkqKdBijf3EFGvkFx4SQNLQYjt9ZQDP8PI2Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V++gkfgXg4QVLoTHy+TUpbE4oFGVrxIApqNuVh3Tbwjf1ISTPzuxdVC7In9VlbnNyhxa7H9bA4Pli4hME9pSuO61mmWVrEazdCkU6+rZddwdCUfPWvylE/KnYIb1emm9jTHWA1BhVWxcdZLWJjJRpV4tySRXPeO62mZS8L0Jd/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Lq3oufyg; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NDGie6027863;
	Wed, 23 Oct 2024 09:18:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=Mcgiw8VCbgyPtoTIeelgP+CvEhuYaan+gfQOgnSitog=; b=Lq3
	oufyg/o4ms/zsm803Bka/SYJDyglPmNzzkTrf5PT0uRPIYXHD7D2LYYTSlbeLiTK
	VFfNMA0qrVMcE76K7dyXDWBsVQaEOthotAoWEFWK6spNeQBJWQ9c648yXVv0IZNQ
	wkduszXJc82amsh0RFtfUmsGk3Jl9j8QhtqyPdL4SjlNVC7RBV4gj1+DeRlZjYrh
	Kkd9xUIhIL5L7gBpggoyy1+hFLYF9mkWZ97RbQxg7R4Eli56nLr879o5D0iG4I6T
	0IJHJmpREANnmMHk/m8VIsBpb3h+4/gskhd3z/9eHQXwVW5QlpfegaK0QE4C5bBx
	6cfkIgt1imduIv9NpjQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42f1vsges5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 09:18:49 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 23 Oct 2024 09:18:48 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 23 Oct 2024 09:18:48 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 1BC403F706B;
	Wed, 23 Oct 2024 09:18:44 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <jiri@resnulli.us>, <edumazet@google.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v4 0/4] Refactoring RVU NIC driver
Date: Wed, 23 Oct 2024 21:48:39 +0530
Message-ID: <20241023161843.15543-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: _mdtAgJ-dKeQva2bgQwxI8bki_vE3M6O
X-Proofpoint-GUID: _mdtAgJ-dKeQva2bgQwxI8bki_vE3M6O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

This is a preparation pathset for follow-up "Introducing RVU representors driver"
patches. The RVU representor driver creates representor netdev of each rvu device
when switch dev mode is enabled.
 
RVU representor and NIC have a similar set of HW resources(NIX_LF,RQ/SQ/CQ)
and implements a subset of NIC functionality.
This patch set groups hw resources and queue configuration code into single API 
and export the existing functions so, that code can be shared between NIC and
representor drivers.

These patches are part of "Introduce RVU representors" patchset. 
https://lore.kernel.org/all/ZsdJ-w00yCI4NQ8T@nanopsycho.orion/T/
As suggested by "Jiri Pirko", submitting as separate patchset.

v3-v4:
 - Removed Export symbols as there is no in-tree caller.
   (Suggested by "Jakub Kicinski").
 - Fixed patch4 commit message.

v2-v3:
 - Added review tags.

v1-v2:
- Removed unwanted variable.
- Dropped unrelated changes from patch4.

Geetha sowjanya (4):
  octeontx2-pf: Define common API for HW resources configuration
  octeontx2-pf: Add new APIs for queue memory alloc/free.
  octeontx2-pf: Reuse PF max mtu value.
  octeontx2-pf: Move shared APIs to header file.

 .../marvell/octeontx2/nic/otx2_common.c       |   6 +-
 .../marvell/octeontx2/nic/otx2_common.h       |  15 ++
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 239 +++++++++++-------
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |   5 +-
 4 files changed, 170 insertions(+), 95 deletions(-)

-- 
2.25.1


