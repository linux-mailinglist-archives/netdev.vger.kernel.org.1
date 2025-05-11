Return-Path: <netdev+bounces-189507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2E9AB26AF
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 06:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75C41189CE99
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 04:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D04718CBFC;
	Sun, 11 May 2025 04:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="WOTghqUa"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04DD13AD1C
	for <netdev@vger.kernel.org>; Sun, 11 May 2025 04:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746938451; cv=none; b=sCT9DW9c+AedrM03QjrhrgLzO0admDeME0OgRr6sqwMaSh67A6Lt0r09MNkmfy+KfbeYIYA+cZb8OBkR0MG5b1M830HhC9AALhhyb0+Qs96rGJHDaDY+kEJU56hmvX0K1A6U2VIGl+UHN3Aksn7sCuob1E5iglRQlFzke14rroA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746938451; c=relaxed/simple;
	bh=g/AvqtJ6RI0mSkEAUcNUky8m1elBRkpsXVngbFSEPi8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=INTI/3xpEsvF+2RH7MjPqpqWegEhlbfOkIP0YRKVhwiyxGalHhJUiFXyS3ReYJyJmwKQLNzFnpjU7H7dqrkd2QMKA96i2sZJZuCRD0qXorAvRTwaj4N3ZY5PT60nGa2qwk8jO2NIE8Yzjr/V06buQh8ih5+MWRULvcqySSGnRSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=WOTghqUa; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54B4dFMC032750;
	Sat, 10 May 2025 21:40:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=fOwhlpBN2pSqueLvydRjr3fFtnpE4/ki12GjOJSh284=; b=WOT
	ghqUaRW0kliFn78XQXlNsbusGdBYBWa6eT4ibkhoWDQcwWhEkaB5F/jXSntKWEIS
	+fYd/MRgLy95VjRRzd14duy5AI89/rJfVqt0fgb4GpOpWN7+lcUOdrdfD/sFS+x6
	h6+9GWdYsenLevUSsMF2ZYTCjg0iA3Bfi2EwlnCd1GLtxw9nCbaP0brtBSLt8yJ4
	nwedCIhEW60xmDVSjLcTaTbDIrvbJ7EjjD7svGRfq+/fnpvyAATLt3wXTWFfUBUG
	n4aJfDUwzEj4RfEMf1yZOByvCVTVqF/wwXPeVeiKbgqPYovMXQtJNmXlML07bVF8
	bI3tKmBlW5S62gX9z2g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46j6aj8ufp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 10 May 2025 21:40:25 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 10 May 2025 21:40:24 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 10 May 2025 21:40:24 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id B6D703F7045;
	Sat, 10 May 2025 21:40:19 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <bbhushan2@marvell.com>, <jerinj@marvell.com>
CC: <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net PATCH 0/2] octeontx2-pf: Do not detect MACSEC block based on silicon
Date: Sun, 11 May 2025 10:10:01 +0530
Message-ID: <1746938403-6667-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=ALcjjCp/ c=1 sm=1 tr=0 ts=68202a39 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=dt9VzEwgFbYA:10 a=Vyz-oGtGZ4BesLdMQXsA:9
X-Proofpoint-ORIG-GUID: 01a1F0IJzLsC7VXoXUT07LQp9XGs1Qhm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTExMDA0NCBTYWx0ZWRfX3ZMbz3w2VEJv piIMCD8tZKWFA2ZxS128d9nQDZuLfSnfyDgSGP0OZelkCyI9zxGflxZVCq7bS5BfM0k6RkswUnt uI2hgE7dKywTZk8SVITZa5DNV/JwJ52rMBARWPdmzOyyLybDk3dlMmiMKkbhTO3J8AZuWlq96FV
 xYwNUnqQSJZ2nOcZbKQrhZz+4FL9rYINx1Z+LsVcPPmp75sjBatTQEv1A6Rf4Yn5zgOBkaW7R/l yZngpXhUDavl/wxO5S2P3sPEn20CvKiXFoN/jWJbO43JV/KyhmWYTJcdX3KQjhFjD/CxXqRZSPb buxNlJYbSoeDhU0FvfVDafcgoxrDCmupwMyT7/CU2tWQQE+y8AxJvJ2aaLeCVm3Io62sRR54fs6
 JtzIxepuzuGfEGu9B7e8pmDoX/fw6+ekVbTd+zyGCLYw6EMxm5+QvokcFg1fgnuyvjvv59Lt
X-Proofpoint-GUID: 01a1F0IJzLsC7VXoXUT07LQp9XGs1Qhm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-11_01,2025-05-09_01,2025-02-21_01

Out of various silicon variants of CN10K series some have hardware
MACSEC block for offloading MACSEC operations and some do not.
AF driver already has the information of whether MACSEC is present
or not on running silicon. Hence fetch that information from
AF via mailbox message.

Subbaraya Sundeep (2):
  octeontx2-af: Add MACSEC capability flag
  octeontx2-pf: macsec: Get MACSEC capability flag from AF

 drivers/net/ethernet/marvell/octeontx2/af/mbox.h   |  2 ++
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c    |  3 ++
 .../ethernet/marvell/octeontx2/nic/otx2_common.c   | 37 ++++++++++++++++++++++
 .../ethernet/marvell/octeontx2/nic/otx2_common.h   |  4 +--
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |  2 ++
 5 files changed, 45 insertions(+), 3 deletions(-)

-- 
2.7.4


