Return-Path: <netdev+bounces-98606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 046468D1DAC
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 15:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B336A2854A8
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 13:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC9516F85F;
	Tue, 28 May 2024 13:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="P3WICmjA"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2DF16F85A;
	Tue, 28 May 2024 13:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716904474; cv=none; b=icjzKg/82UxFgDFbXD5HgoIEkeohzkYzGy4w/g5YeqdIQ7oU4Fw+oVoLEBmnxxHsSML9j7KhbIaE3e6ztb3q+XKXw1r98B0SdB2sVkLy28lhkxraM6kq5YNonjEOCOIKOu1QwlRMQ0751SMLrB9oRcwFVmTxuHrHM/qT8TR5oNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716904474; c=relaxed/simple;
	bh=aTNitRTEq8LxWL9GsV6RBq6ctCaBr1C9Kqq0gYMZKTQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LlfQuiGBM5PW5wcBmAb5H5ELstrd/GA8usT9LBtbA0E0TnQqiBcp3SbuGw7QWvuMSPyXNRWptZ8UtCto5+j+hRmi/ctrXx3t4qhXni3XbkpSS9BGKv1sFsIlRhgTG5Du2EhEe48mFpUsGyWkKR2wTvm1W2Bb4srb9P4EejD1nY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=P3WICmjA; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44SCK9iG002508;
	Tue, 28 May 2024 06:54:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=lLzcGd0RY77b7ZieeDHsKT4
	tefb5KeLJao+qGnQBkxg=; b=P3WICmjAeLIeQrmUEhaM4HvpfKkaD7DLX2lO0Kb
	jomT4mTX1aZ9Wux0A8WY5GyQsUXmIOqho6ZW0xWPYfN8niVZrbvfL/+6fzki1Cvl
	EF6XfdZPi7V3JrNzKeG0zZMVGSG8tQ2utXpJtub3TuV0hMJ38ujRtZMcJGsKi9Qb
	dbW4kfY0oiD2WAtyHdxJ897QUtdEhS2vVbWxi9nrtlsPQqT5IZ9/e/x3RV57SPv3
	nGmZKowC2leZG7R+DTVgwgACquvZ99XlnhnsC880tMZdh/taST6Oru8kCOfMRgwp
	8zLoRX/ZCuo1XFf+A8yRwCujsMonTH8CqYCgQ1VHKx+f9ZQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yddn58pda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 06:54:01 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 28 May 2024 06:53:57 -0700
Received: from bharat-OptiPlex-3070.marvell.com (10.69.176.80) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server id
 15.2.1544.4 via Frontend Transport; Tue, 28 May 2024 06:53:52 -0700
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <jerinj@marvell.com>,
        <lcherian@marvell.com>, <richardcochran@gmail.com>
CC: <bbhushan2@marvell.com>
Subject: [net-next,v3 0/8] cn10k-ipsec: Add outbound inline ipsec support
Date: Tue, 28 May 2024 19:23:41 +0530
Message-ID: <20240528135349.932669-1-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 7azj7_d5ZmQZFnhDAFhtOxc4eZnjIotb
X-Proofpoint-ORIG-GUID: 7azj7_d5ZmQZFnhDAFhtOxc4eZnjIotb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_09,2024-05-28_01,2024-05-17_01

This patch series adds outbound inline ipsec support on Marvell
cn10k series of platform. One crypto hardware logical function
(cpt-lf) per netdev is required for inline ipsec outbound
functionality. Software prepare and submit crypto hardware
(CPT) instruction for outbound inline ipsec crypto mode offload.
The CPT instruction have details for encryption and authentication
Crypto hardware encrypt, authenticate and provide the ESP packet
to network hardware logic to transmit ipsec packet.
  
First patch makes dma memory writable for in-place encryption,
Second patch moves code to common file, Third patch disable
backpressure on crypto (CPT) and network (NIX) hardware.
Patch four onwards enables inline outbound ipsec.  

v2->v3:
 - Fix smatch and sparse erros (Comment from Simon Horman)
 - Fix build error with W=1 (Comment from Simon Horman)
   https://patchwork.kernel.org/project/netdevbpf/patch/20240513105446.297451-6-bbhushan2@marvell.com/
 - Some other minor cleanup as per comment
   https://www.spinics.net/lists/netdev/msg997197.html   

v1->v2:
 - Fix compilation error to build driver a module 
 - Use dma_wmb() instead of architecture specific barrier
 - Fix couple of other compilation warnings    

Bharat Bhushan (8):
  octeontx2-pf: map skb data as device writeable
  octeontx2-pf: Move skb fragment map/unmap to common code
  octeontx2-af: Disable backpressure between CPT and NIX
  cn10k-ipsec: Initialize crypto hardware for outb inline ipsec
  cn10k-ipsec: Add SA add/delete support for outb inline ipsec
  cn10k-ipsec: Process inline ipsec transmit offload
  cn10k-ipsec: Allow inline ipsec offload for skb with SA
  cn10k-ipsec: Enable outbound inline ipsec offload

 .../net/ethernet/marvell/octeontx2/af/mbox.h  |    4 +
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |   68 +-
 .../ethernet/marvell/octeontx2/nic/Makefile   |    1 +
 .../marvell/octeontx2/nic/cn10k_ipsec.c       | 1084 +++++++++++++++++
 .../marvell/octeontx2/nic/cn10k_ipsec.h       |  258 ++++
 .../marvell/octeontx2/nic/otx2_common.c       |   99 +-
 .../marvell/octeontx2/nic/otx2_common.h       |   25 +
 .../marvell/octeontx2/nic/otx2_dcbnl.c        |    3 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |   19 +-
 .../marvell/octeontx2/nic/otx2_txrx.c         |   65 +-
 .../marvell/octeontx2/nic/otx2_txrx.h         |    3 +
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |   10 +-
 12 files changed, 1585 insertions(+), 54 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h

-- 
2.34.1


