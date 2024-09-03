Return-Path: <netdev+bounces-124527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1546969DE4
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 14:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C34C1F21A41
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 12:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B6A1C986E;
	Tue,  3 Sep 2024 12:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="TcdzggaV"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C759A1C9877;
	Tue,  3 Sep 2024 12:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725367272; cv=none; b=a4Sj6dTTMkBeTe/iOXIMnBgsLLOHGh3wl98qR6eUUSyIHg2jAKtQsjloQeuuPqFnqExRxxJ/+2ESrUmj/qigB/4/wwIEN4LkARr/CstHO9V9CtFcFqFtCCXFVUTl7wWlTmUD5sRll3F/5oFOjqguthQ7nilT7tWOWHBHfGfBxPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725367272; c=relaxed/simple;
	bh=AQYdmJdDgYkJn/nh6mIFu3YUEUbQAdOF+44RQPCsM0E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fRkMZ2JI895UYMTmEf+/TwdIxWm35ZqUcNd01OpHtBJK7T49VdeScO8bO8PY8uNM4nQeOx2Z6QR5zc5wS2NptuqD4EdGWfFSJMNtaVdNx1ABssZr4GyotviJzfS3HGkhPDXaFUbt4j5o3+d6GId3xD/X7mkESheCJZOTz+ZReaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=TcdzggaV; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48396VMw018964;
	Tue, 3 Sep 2024 05:40:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=xtbZYNGKPgKz/doSc5biPZlq2ihrSY8nR/2kFpyzKas=; b=Tcd
	zggaV6Mr+WBXBkbrLqKC/OSKoItpQGtC66sECmN4iwyDicgT6wvvzRYNOl4I6rrj
	Fx625QzgH5PHCgj3lerKybxYQpI6nEoJdya9otJKA8CTMIXGNqIERcjgaiXxGIIL
	GQNkn2OEL8u9eT5VNK/B+Y3q74chEnm76UH97DhBB7Ek+YfSpvfphB0klDZy+dQ4
	6B2RhxNxsh5s2Az0idAafTBJTtRA2b40NJFBQICis3+J1Gi545keValklR1xRDte
	ytfYD4dC/4di6prhHA1SkK8lsLTL3fCgUTCLmWXN1CzFl07Rajbs0YICOFjLAEzi
	1/0+tvoQbWMmbJaafsQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 41dyhmrkuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 05:40:54 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Sep 2024 05:40:53 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 3 Sep 2024 05:40:53 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 850F83F70E7;
	Tue,  3 Sep 2024 05:40:49 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <jiri@resnulli.us>, <edumazet@google.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH 0/4] Refactoring RVU NIC driver
Date: Tue, 3 Sep 2024 18:10:44 +0530
Message-ID: <20240903124048.14235-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: jHDgE0zV_MZ1Hz9NmNRB7jB4Qhg12I0U
X-Proofpoint-GUID: jHDgE0zV_MZ1Hz9NmNRB7jB4Qhg12I0U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-02_06,2024-09-03_01,2024-09-02_01

This is a preparation pathset for follow-up "Introducing RVU representors driver"
patches. The RVU representor driver creates representor netdev of each rvu device
when switch dev mode is enabled.
 
RVU representor and NIC have a similar set of HW resources(NIX_LF,RQ/SQ/CQ)
and implements a subset of NIC functionality.
This patchset groups hw resources and queue configuration code into separate
APIs and export the existing functions so, that code can be shared between
NIC and representor drivers.


These patches are part of "Introduce RVU representors" patchset. 
https://lore.kernel.org/all/ZsdJ-w00yCI4NQ8T@nanopsycho.orion/T/
As suggested by "Jiri Pirko", submitting as separate patchset.

Geetha sowjanya (4):
  octeontx2-pf: Defines common API for HW resources configuration
  octeontx2-pf: Add new APIs for queue memory alloc/free.
  octeontx2-pf: Reuse max mtu value
  octeontx2-pf: Export common APIs

 .../marvell/octeontx2/nic/otx2_common.c       |   6 +-
 .../marvell/octeontx2/nic/otx2_common.h       |  15 ++
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 243 +++++++++++-------
 .../marvell/octeontx2/nic/otx2_txrx.c         |  17 +-
 .../marvell/octeontx2/nic/otx2_txrx.h         |   3 +-
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |   7 +-
 6 files changed, 186 insertions(+), 105 deletions(-)

-- 
2.25.1


