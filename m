Return-Path: <netdev+bounces-44730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D89D7D9793
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 14:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29369282389
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 12:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F7F19BB8;
	Fri, 27 Oct 2023 12:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="B9FACaBg"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA0D18646
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 12:16:57 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB83128;
	Fri, 27 Oct 2023 05:16:56 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39R5Tuq9012500;
	Fri, 27 Oct 2023 05:16:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=Y6xTKIJSNSycWXwHzIPirKaKql9lBW7UOSjD7UTcWio=;
 b=B9FACaBgUcdszqiQz669apVjPGmlM37xLlA+cBhM0d4jWa1Zzsp477VTzwa5AGrM4v7x
 SWSTQanuFQObOznb/wZbZm6wkPpN0WmRfpUy0pRJOqMhhmamLx/DJjBSoXvLvBVzg8If
 aD7Fra67U5OrucLUuCxiBr8uT+f03Jm8VDGizkwcfkU8mWAAFkwraFJZzAXFz4f0OlaD
 VHxYHXiPuYa9GiqoYkbE5e4aDD4B4TOVCTNvnAauTnF7ZJRvBB37x65wVmc8ydcUVTm7
 XvpUHRwDDmSX62odFEBNbphLSHJpBL3/Lg10lRQc3fkIw5ISpNLRbEhLRlnrpqsQdxlK Aw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3tywr83b23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Fri, 27 Oct 2023 05:16:51 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 27 Oct
 2023 05:16:49 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 27 Oct 2023 05:16:49 -0700
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 597073F7050;
	Fri, 27 Oct 2023 05:16:49 -0700 (PDT)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <kuba@kernel.org>, <davem@davemloft.net>, <wizhao@redhat.com>,
        <konguyen@redhat.com>, Shinas Rasheed <srasheed@marvell.com>
Subject: [PATCH net-next v3 0/4] Cleanup and optimizations to transmit code
Date: Fri, 27 Oct 2023 05:16:35 -0700
Message-ID: <20231027121639.2382565-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Gg8ZBtEi-m6sgKEgmOSJILCTcSgEbTCb
X-Proofpoint-ORIG-GUID: Gg8ZBtEi-m6sgKEgmOSJILCTcSgEbTCb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_10,2023-10-27_01,2023-05-22_02

Pad small packets to ETH_ZLEN before transmit, cleanup dma sync calls,
add xmit_more functionality and then further remove atomic
variable usage in the prior.

Changes:
V3:
  - Stop returning NETDEV_TX_BUSY when ring is full in xmit_patch.
    Change to inspect early if next packet can fit in ring instead of
    current packet, and stop queue if not.
  - Add smp_mb between stopping tx queue and checking if tx queue has
    free entries again, in queue full check function to let reflect
    IQ process completions that might have happened on other cpus.
  - Update small packet padding patch changelog to give more info.
V2: https://lore.kernel.org/all/20231024145119.2366588-1-srasheed@marvell.com/
  - Added patch for padding small packets to ETH_ZLEN, part of
    optimization patches for transmit code missed out in V1
  - Updated changelog to provide more details for dma_sync remove patch
  - Updated changelog to use imperative tone in add xmit_more patch
V1: https://lore.kernel.org/all/20231023114449.2362147-1-srasheed@marvell.com/

Shinas Rasheed (4):
  octeon_ep: add padding for small packets
  octeon_ep: remove dma sync in trasmit path
  octeon_ep: implement xmit_more in transmit
  octeon_ep: remove atomic variable usage in Tx data path

 .../ethernet/marvell/octeon_ep/octep_config.h |  3 +-
 .../ethernet/marvell/octeon_ep/octep_main.c   | 55 +++++++++++--------
 .../ethernet/marvell/octeon_ep/octep_main.h   |  9 +++
 .../net/ethernet/marvell/octeon_ep/octep_tx.c |  5 +-
 .../net/ethernet/marvell/octeon_ep/octep_tx.h |  3 -
 5 files changed, 45 insertions(+), 30 deletions(-)

-- 
2.25.1


