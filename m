Return-Path: <netdev+bounces-50234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 523B47F4FAE
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 19:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E686281514
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 18:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A779658AD8;
	Wed, 22 Nov 2023 18:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="c/Ibi1n+"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A31D50;
	Wed, 22 Nov 2023 10:34:51 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMIT5KW019590;
	Wed, 22 Nov 2023 10:34:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=0GqnSZpL4E/OI68ZnBo58kjUaFbXjIqAqR9BlWTLW7g=;
 b=c/Ibi1n+X3/JmOHutygyBnb1iitVpUMCXTlGzyxZBU73au8WxltZRRk4IiKgU8K+K11W
 Bh/HiQ0zXZ395CcASz3D8AHjhOVmh1VZ0zv12WyUpzvfchu6nkJRFsBhr4aAOpexCHAu
 pcH2rKuAe5U5xOjrnts5rbvPFhR3p4s465Fc9uzLSZpxJ+vTyq8EuL1gf044LlVgT1B4
 QJx9HkGYr9HEO62FeSfZYez7pUo9ENZBOXbiG+gLomzUSVU699+BC8zstyKuRrcrethZ
 ZkzSY9Ugi19tUvq9kr5RSrXjIRfXa5IRbA9LraywLpc4Tj0cBsQFS0ae+Z2NhNC2H/O9 PQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3uhpxn00ut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Wed, 22 Nov 2023 10:34:42 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 22 Nov
 2023 10:34:39 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 22 Nov 2023 10:34:39 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 8B3203F7040;
	Wed, 22 Nov 2023 10:34:39 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <kuba@kernel.org>, <davem@davemloft.net>, <wizhao@redhat.com>,
        <konguyen@redhat.com>, <jesse.brandeburg@intel.com>,
        <sumang@marvell.com>, Shinas Rasheed <srasheed@marvell.com>
Subject: [PATCH net-next v2 0/2] Get max rx packet length and solve
Date: Wed, 22 Nov 2023 10:34:33 -0800
Message-ID: <20231122183435.2510656-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: QKQM7XTY9JWB2nlUHbrxiNRER0mQ8uvK
X-Proofpoint-GUID: QKQM7XTY9JWB2nlUHbrxiNRER0mQ8uvK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_13,2023-11-22_01,2023-05-22_02

Patchsets which resolve observed style issues in control net
source files, and also implements get mtu control net api
to fetch max mtu value from firmware

Changes:
V2:
  - Introduced a patch to resolve style issues as mentioned in V1
  - Removed OCTEP_MAX_MTU macro, as it is redundant.

V1: https://lore.kernel.org/all/20231121191224.2489474-1-srasheed@marvell.com/

Shinas Rasheed (2):
  octeon_ep: Solve style issues in control net files
  octeon_ep: get max rx packet length from firmware

 .../ethernet/marvell/octeon_ep/octep_config.h |   2 -
 .../marvell/octeon_ep/octep_ctrl_net.c        |  42 ++++--
 .../marvell/octeon_ep/octep_ctrl_net.h        | 125 +++++++++++-------
 .../ethernet/marvell/octeon_ep/octep_main.c   |  10 +-
 4 files changed, 113 insertions(+), 66 deletions(-)

-- 
2.25.1


