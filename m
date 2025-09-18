Return-Path: <netdev+bounces-224467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A601EB855A5
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 16:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCD29545475
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 14:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33ED22DFA2D;
	Thu, 18 Sep 2025 14:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="d/eBPYQj"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53AA2D322C;
	Thu, 18 Sep 2025 14:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758206964; cv=none; b=VMKoIEtY/U+wY0XPwtlLzfpNYhUnNabWOt00tHsdTa87bo2UHJgTJD5Pf05Kb5BNCZJkVYgZD23AVTh0m8pSaKgIK2igIuGT6omFeMHnTV1ogFnZ7oe0NC0oll2OexrUjLdBhM947wEPpQgvKxj/2Tdni+jUAUuKDViGQmgIfW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758206964; c=relaxed/simple;
	bh=23ktBBop4u/x7zNZgLlZ9TKFaiNhHwD9+DMajpKh+NY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nlHCMbzXJscDTPmPwd+zrOHT8UtAQWp7AwclmG+O9IlCPYc7JTOdMK8YuR0p5rJVs3VbLC5k0bWphkJxSOM84mLoFvl0fnoPskNRdreuRqDzWIZFeBDSjri2Uid5TiaXbaqa4iM9OeL9otyZ8zmFa8sfUtyxSo6L3JELepZR4/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=d/eBPYQj; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I9JcEX016305;
	Thu, 18 Sep 2025 07:49:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=JdMj8B8nXgt0VBenxcRLktJ
	uo4S96i7ypAqb9pDdydU=; b=d/eBPYQjMHf7poCQ0UdJsW5XJsykuWj6VjiLM+P
	/K+AyM/cL0HRgAuA0OlCc0K5d5SW1meJX7I2yaB7mvmatf9OyNm9IFgRf1Uns4CV
	oFVl/zoYa2MREAnIoK/lw2kbvmUoikSTJjvgp4AJPaBQhUvBWN/uEP7yLeMMTYcl
	fb+bWIRY4vgCuMW9V4H4vZ3zVPzC66lkJRrd9QTC6NzOgwIuGl84tNTgwWc/Ab0A
	TywbSXvZtxtIv9jE/VprJjGgn5RbtCait6zoZJkF6k8IvvxO0XDmIn+9vaZQPbRb
	8aAni++k1OSqGVBuCLZzyF4r3uTO69CxLDaAwC4ZWgzyx2g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 498fbngs3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 07:49:02 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 18 Sep 2025 07:49:09 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 18 Sep 2025 07:49:09 -0700
Received: from sburla-PowerEdge-T630.sclab.marvell.com (unknown [10.106.27.217])
	by maili.marvell.com (Postfix) with ESMTP id 951355C68E7;
	Thu, 18 Sep 2025 07:49:01 -0700 (PDT)
From: Sathesh B Edara <sedara@marvell.com>
To: <linux-kernel@vger.kernel.org>, <sburla@marvell.com>, <vburru@marvell.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>, <hgani@marvell.com>,
        <andrew@lunn.ch>, <srasheed@marvell.com>
CC: <sedara@marvell.com>
Subject: [net-next PATCH v1 0/2] Add support to retrieve hardware channel information
Date: Thu, 18 Sep 2025 07:48:56 -0700
Message-ID: <20250918144858.29960-1-sedara@marvell.com>
X-Mailer: git-send-email 2.36.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: VDocRr0QENXIGds8MxRRUiNdod3OBNeJ
X-Authority-Analysis: v=2.4 cv=Pa7/hjhd c=1 sm=1 tr=0 ts=68cc1bde cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=yJojWOMRYYMA:10 a=PlYhftpBkXA4JvsghnwA:9
X-Proofpoint-GUID: VDocRr0QENXIGds8MxRRUiNdod3OBNeJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE4MDA4NSBTYWx0ZWRfXwCq4n301Gre0 ufclvzlf9A/1EI2HpScBxtl4XYDVonA7rQ/pMvxtK+5LEKq1hwfMYQ/gA6vVrRheplnIHVdA7Ov MG4vxNm7gNg8zTR24fbNa2laM7QP2Ktdhj4ZjFwg5dgKRp61lwwCtkum3upIrNfzz2lanWGFZZa
 Xx8ErwDY0UH1L0uo3YE58MQxN/mCU6mCS7d5AXkaPkYga0Omc2f2PDmHHxCIQjRmpSF5y3sIoPu aROr5Yj7wqIA1NPXttshHS72+itAU7ZuL3oWAMDvQP75ARtr+zjO3QxFG6LqXpQejQYxqCh+i0E epQ9aL93yXwchvFEMy/s7TS1E9jk9jXoDNEG7ayVeZD5tz69ExbTnw1w4lLFQDAGabSFIDNQCYh P5bhNS8G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_01,2025-09-18_02,2025-03-28_01

This patch series introduces support for retrieving hardware channel
configuration through the ethtool interface for both PF and VF.

Sathesh B Edara (2):
  octeon_ep: Add support to retrieve hardware channel information
  octeon_ep_vf: Add support to retrieve hardware channel information

 .../net/ethernet/marvell/octeon_ep/octep_ethtool.c   | 12 ++++++++++++
 .../ethernet/marvell/octeon_ep_vf/octep_vf_ethtool.c | 12 ++++++++++++
 2 files changed, 24 insertions(+)

-- 
2.36.0


