Return-Path: <netdev+bounces-110512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D08E92CC46
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 09:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DD5D1C22F71
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 07:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F73284A36;
	Wed, 10 Jul 2024 07:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="TpTboUc2"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CC15CB8;
	Wed, 10 Jul 2024 07:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720598022; cv=none; b=n2r5+bSrp2bdIwEnvuvQbN8VFYYcLECzuCUbG27aog3TyYR8WKvRqqlBoLbdSaqOt5Ut5aLv9N0OnrW9oW33D3XxTKv7VVDcOxBDZDSDiM/f6hGh412OyEZRzq58SXeoOOa3t7C5aJ59UstIPO5gLS2cfvLX+r8PQztpijGYJA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720598022; c=relaxed/simple;
	bh=z+M+w1EjrOsMpQ0c7ARWpLvveG+iJC0ITyQx8aamhXQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VSbEN8ZXoEElbto3G2QYAWjCi+jhEolcUWVHaeSL6RxjgfvDvKaXn88zkpQgUysv6fuTgAv14O5G7CkslZuv9MZthyI2v+zwtJB7inopqpM161Rn3XIjkimpdNJmvPs8RtK2EiLgfIR7rhQgehCKStX+7lC6tWp4v1SAHJdQf2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=TpTboUc2; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469MPZGT021946;
	Wed, 10 Jul 2024 00:53:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=Cv4znu/u3vG5DtSV0M5c1ln
	aufVMKH31TxEAtQiDsjA=; b=TpTboUc264GsjkK4rRrNiZNhzZkY3QN9Td5bbTg
	kwv5v/ukNKbawCTNeENrBMiG3F4ECVkotgB2r+nvN+4w/PIxCcLcjHw+/c1HdkGY
	3uIrcZEB12XMhBRA0zag+65RGFVe2AD5wsIJZxTjJW6HWzLknbEGswo5jiZifLKu
	y6ns23/vZNikkc8BM62YD/f+0ICE135aBK7/YG9UgWes9XNYmK1KhNyLHdETmAJR
	bncxW/WVZDW0rvEG27fkx7+5y9qPjOfVzaJg9kAGC3jVbOdmXTbywQUr6VOEE1G2
	0+Z2gsJHIOTpO8Tnj7Vv+3xk/vUas92CSLkXPgDgAwHekIQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 409e061p7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 00:53:35 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 10 Jul 2024 00:51:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 10 Jul 2024 00:51:32 -0700
Received: from localhost.localdomain (unknown [10.28.36.175])
	by maili.marvell.com (Postfix) with ESMTP id 0840B3F705E;
	Wed, 10 Jul 2024 00:51:27 -0700 (PDT)
From: Srujana Challa <schalla@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <hkelam@marvell.com>,
        <sbhatta@marvell.com>, <ndabilpuram@marvell.com>,
        <schalla@marvell.com>
Subject: [PATCH net,v2,0/5] Fixes for CPT and RSS configuration
Date: Wed, 10 Jul 2024 13:21:22 +0530
Message-ID: <20240710075127.2274582-1-schalla@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: eXwRxScGd2DaGCXX_oW5e3oFM-8Y1Wxx
X-Proofpoint-GUID: eXwRxScGd2DaGCXX_oW5e3oFM-8Y1Wxx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_04,2024-07-09_01,2024-05-17_01

This series of patches fixes various issues related to CPT
configuration and RSS configuration.

v1->v2:
- Excluded the patch "octeontx2-af: reduce cpt flt interrupt vectors for
  cn10kb" to submit it to net-next.
- Addressed the review comments.

Kiran Kumar K (1):
  octeontx2-af: Fix issue with IPv6 ext match for RSS

Michal Mazur (1):
  octeontx2-af: fix detection of IP layer

Nithin Dabilpuram (1):
  octeontx2-af: replace cpt slot with lf id on reg write

Satheesh Paul (1):
  octeontx2-af: fix issue with IPv4 match for RSS

Srujana Challa (1):
  octeontx2-af: fix a issue with cpt_lf_alloc mailbox

 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  2 +-
 .../net/ethernet/marvell/octeontx2/af/npc.h   |  8 +++++--
 .../ethernet/marvell/octeontx2/af/rvu_cpt.c   | 23 +++++++++++++------
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 12 ++++++----
 4 files changed, 31 insertions(+), 14 deletions(-)

-- 
2.25.1


