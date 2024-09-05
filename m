Return-Path: <netdev+bounces-125479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BF296D43E
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 11:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8BD61C235B7
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 09:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E719C198A22;
	Thu,  5 Sep 2024 09:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="kl1P7WPa"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76624154BFF;
	Thu,  5 Sep 2024 09:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725529796; cv=none; b=H+Nve023fUomFROJkUa5s7yvmQ3iTxr86g+qtYUrIEGVCmCTnbY+oFWIHQteeuaRaNGyx73eQe/zCSvExJe2H07P+IO2vnnKjyGSIF1kzmj8IVLb2vwksVlgCe/i/cfOLT9pEZV50h5a37XkhVKU80AbTcXIpYR0UJoX+5wGQMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725529796; c=relaxed/simple;
	bh=0S0H83l6fC4Gq4loy2ushvxa4ICJQSblhpAJmXE+U64=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RQiOUVRlVNVmNd84PfWUxjyCIQIvWluwya0+gy8r0924TjXje/9ra5rM3uQlGoVYDoTuQmxTcYSLkv0UDNUs+kWryYLjXf1HBPpLOiGajBjB3mRZ+OYD6Ng4qkqP2GAZW4zO7WPDtNXj50V5Myvafrmw0yZ/twDql2h78G4rt7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=kl1P7WPa; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4856JncO009304;
	Thu, 5 Sep 2024 02:49:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=pw0O+nS6TwgD0Ch/iHXkW2k7R0FZpS0DWYRqNKU7pzQ=; b=kl1
	P7WPaemzkzx1uNb7r2qUJh2BBxe54naJwgjkEM8+gUc/LtSsKsqIoLTMpvXypHRc
	eyh5pbfwB/2yj1EeIqhr6VSnzjGdgNd5bVORdcsCa/E+/LDzsTpgIO7isC+n25kn
	5deDvJiLC3TrWpGqVUlx9laZxLFq/MsvQiKkp5KwXD7+D6Vl+li2mL2FTITMr8Mu
	OT/e7HCetfH26ee82mUha6i6NLRRxoPQJ8cbllMdPGnYIzZ0MbjjuxpOlG1P9Qf1
	OLVof2fDZu80pvF4cePGhdHg+06qm2NQYXWJgipEFSfnvtF6vTfj994CY1BxQw/5
	MU/SOpZPHL8VZM0UMug==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 41f79drrwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 02:49:41 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 5 Sep 2024 02:49:40 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 5 Sep 2024 02:49:40 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 939CB5B6928;
	Thu,  5 Sep 2024 02:49:36 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <jiri@resnulli.us>, <edumazet@google.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v2 0/4] Refactoring RVU NIC driver
Date: Thu, 5 Sep 2024 15:19:31 +0530
Message-ID: <20240905094935.26271-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: _Ns2sRkNmOPaXYS9rwbg0OlBi9RlKRMH
X-Proofpoint-GUID: _Ns2sRkNmOPaXYS9rwbg0OlBi9RlKRMH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_05,2024-09-04_01,2024-09-02_01

This is a preparation pathset for follow-up "Introducing RVU representors driver"
patches. The RVU representor driver creates representor netdev of each rvu device
when switch dev mode is enabled.
 
RVU representor and NIC have a similar set of HW resources(NIX_LF,RQ/SQ/CQ)
and implements a subset of NIC functionality.
This patch set groups hw resources and queue configuration code into single API 
and export the existing functions so, that code can be shared between NIC and
representor drivers.

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
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 238 +++++++++++-------
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |   5 +-
 4 files changed, 169 insertions(+), 95 deletions(-)

-- 
2.25.1


