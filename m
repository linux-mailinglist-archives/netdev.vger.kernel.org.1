Return-Path: <netdev+bounces-224404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDE7B84578
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 13:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27A67584449
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 11:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD14030102A;
	Thu, 18 Sep 2025 11:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="IcGqtTU5"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CF4296BDA;
	Thu, 18 Sep 2025 11:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758194838; cv=none; b=N6rnXUx2RiGRiPtinkH4oTr58zzhJovPqnbYA2NPba/jcwkIpesBwL/GhpJ4njg7M9blq24ZxPwag8DO+rc9mzDUejIAa5ZQHlP0G+yugBNCTtnMoaRrUVUhQVdOTcrBJXfZHyJIVigdaEP/5jmOlZKEnFVSC2wLlxZlx3x0Lak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758194838; c=relaxed/simple;
	bh=23ktBBop4u/x7zNZgLlZ9TKFaiNhHwD9+DMajpKh+NY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GH3X2/3m6S39LPFHJuZazFYmf7X71BMGLakOkr9SoP0v1XGDuJOS6z/5/36fT9x4BXpqtF/oR7GjXEc1HhqkXGt2sjNLxjp97rCV+HQXo4sunuJvZ5rHj0zdIyMOlK15hrsehjuku0E7NvWcIW1zL/tpxvQqSGFc38R63QedDEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=IcGqtTU5; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I9JcxK016305;
	Thu, 18 Sep 2025 04:27:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=JdMj8B8nXgt0VBenxcRLktJ
	uo4S96i7ypAqb9pDdydU=; b=IcGqtTU5YUnBns/DgYnwCfv9uJ21QbaWV2TzTma
	ZG3Hj3UX4FRyScfSxSsAT+q3mbSNFcwdCDIh6NF4aUqFkOXX0iy4AvBCLNzRb81j
	kmZKLeFO1x1n1OnsA9ZXKGBadEwRU/1wm99jgbABlXvNDPj3VVyJH8YVEcJ56x5C
	U2+ehiovtKttHpJFv9SMwjVGjnGBySXtrTNI8MH4QtX59V8nfCgSppdASpRm+fU0
	8/oa0zG0dFFxb1ln9isaFdedcYQ2ZgGgETdVO/jewTtyw62YmI81MUwm9MYugU6Y
	0i2nAPnAvSTY29sZ2QAufkDjSWeXlsCpHlQX0mFbdkdM6bQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 498fbng9cj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 04:27:06 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 18 Sep 2025 04:27:12 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 18 Sep 2025 04:27:12 -0700
Received: from sburla-PowerEdge-T630.sclab.marvell.com (unknown [10.106.27.217])
	by maili.marvell.com (Postfix) with ESMTP id E5EE73F7061;
	Thu, 18 Sep 2025 04:27:04 -0700 (PDT)
From: Sathesh B Edara <sedara@marvell.com>
To: <linux-kernel@vger.kernel.org>, <sburla@marvell.com>, <vburru@marvell.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>, <hgani@marvell.com>,
        <andrew@lunn.ch>, <srasheed@marvell.com>
CC: <sedara@marvell.com>
Subject: [net PATCH v1 0/2] Add support to retrieve hardware channel information
Date: Thu, 18 Sep 2025 04:26:50 -0700
Message-ID: <20250918112653.29253-1-sedara@marvell.com>
X-Mailer: git-send-email 2.36.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: JuOYkI82JSnOMknpkRQWXCavChDI5Vc1
X-Authority-Analysis: v=2.4 cv=Pa7/hjhd c=1 sm=1 tr=0 ts=68cbec8a cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=yJojWOMRYYMA:10 a=PlYhftpBkXA4JvsghnwA:9
X-Proofpoint-GUID: JuOYkI82JSnOMknpkRQWXCavChDI5Vc1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE4MDA4NSBTYWx0ZWRfX8l98kXElYnby on0WflCNdKZ5nXr62o+A1L95FwLP6YyedVlO6UfBM1rL+BvXhKcGrjYwgsXBJ8AfstROKMgxgRr k4C2ByBt1HM1JOWr7TClZWyhLDQRzxJl0Zh6z4pu1RhqUu7jcc0Q1AMm3SJtR/P8HHschD8Yv2p
 Xz18Bk3BScQPYfaF14rH6uaefgQS0bTpczI5Nt0lJXgSQATbcWe1A8rkby/SeQRBB6aDUK9WJF2 fYRJRTkTXYkO2p8T48qYzbpkGEq5cVwigkPajWUO+DWpSLdUF+WK0QHJvluHnVDRoDNcMKyg94K zVQmBfQSEsYFMYCTE9s0LrRUwBEfU67hQ0RI+P23Zu5Dy1Nq5s38jY5mbe2Dfz0oZazg8SKEaz/ qjHAiGKj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_02,2025-03-28_01

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


