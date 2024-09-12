Return-Path: <netdev+bounces-127688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 523329761AD
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 08:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F06111F230DB
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 06:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CF418BB80;
	Thu, 12 Sep 2024 06:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="jS7uQ8Ha"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7458741C6A;
	Thu, 12 Sep 2024 06:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726123247; cv=none; b=rHEnJorsxA3wKgx5fQeCHU7+f1D5CDovO3sEFUA1ty2lXiXvuHew3K1tSR3CSg7JTc4LGC984k7oyguaNAwTVIy4KfZqJNwK/9fNz0PnKP5K5YPgfYgHrWmBk9GjWOhRP2+3L+OWKQPe3BNEiwKIyW8y8Vs2Aw06zXTGngaryLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726123247; c=relaxed/simple;
	bh=AqWLE5+0NYRRTaiNlo6tyNw3bUt5zK8c+awqkiZ2ckU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CEtjtbexg2CejOv+Xwx6zJHIJP2mYIDIin8nArb1pv7gNg51Oa1mnwuwpRhSuHwPwq/jEYB/CxEbXB7WsJUxMjIxBATDecuSQRELkxg+B+t/gsgMjA9VB22o0u7KMdeWWb0or+YIU1qoMWM+1ORxVb4XYFFfpNvExGrY8iTEiIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=jS7uQ8Ha; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48C4P6Bi001869;
	Wed, 11 Sep 2024 23:40:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=J2T9vIltLcTng/7Df1IVdkRpN82k81FwaKV5i6/k9KA=; b=jS7
	uQ8HaK9uh2PV9egVyTRci6cFJOppPNjDs23FiJFA3LwAAsrK+EmNx7O3CCwjKrWC
	8w4l6G/aJ47D1PxjUVlHRD9wOTBjuO4RqorniseZWyQnDrX7VqEb4p1JegPwIhvA
	kYgM0F1CL4ZI6vnznEuPECcsELddifFXaqLfOMDy1Up3T5IO3nmGxupwYZE7vcRd
	Q33zsyzFKpfMAOCoqyfJOnvEn7rSE/95bBDTXRTCprRiBpa9V7bWIMI6pLA6EEZF
	aeaUvD0KzEyT4VY2SQ5wzYN9/7obb58N3XNA+zB8TjLPYC/4j1p+QukXsWLGB7WD
	ZUy+mObMjTY/glRXHsQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 41ks8prd1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 23:40:23 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 11 Sep 2024 23:40:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 11 Sep 2024 23:40:21 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 5E6485E6864;
	Wed, 11 Sep 2024 23:40:18 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <jiri@resnulli.us>, <edumazet@google.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v3 0/4] Refactoring RVU NIC driver
Date: Thu, 12 Sep 2024 12:10:13 +0530
Message-ID: <20240912064017.4429-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: qajUHMWJksgurw-r6UXyI54rLIgvlg8O
X-Proofpoint-GUID: qajUHMWJksgurw-r6UXyI54rLIgvlg8O
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

v2-v3:
 - Added review tags.

v1-v2:
- Removed unwanted variable.
- Dropped unrelated changes from patch4.

Geetha sowjanya (4):
  octeontx2-pf: Define common API for HW resources configuration
  octeontx2-pf: Add new APIs for queue memory alloc/free.
  octeontx2-pf: Reuse PF max mtu value
  octeontx2-pf: Export common APIs

 .../marvell/octeontx2/nic/otx2_common.c       |   6 +-
 .../marvell/octeontx2/nic/otx2_common.h       |  15 ++
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 239 +++++++++++-------
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |   5 +-
 4 files changed, 170 insertions(+), 95 deletions(-)

-- 
2.25.1


