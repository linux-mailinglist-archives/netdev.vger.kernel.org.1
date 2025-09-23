Return-Path: <netdev+bounces-225543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC38B954AB
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 11:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27D153BF7B7
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 09:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391E2320CA3;
	Tue, 23 Sep 2025 09:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="fuKvRG3W"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0354320A1B;
	Tue, 23 Sep 2025 09:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758620508; cv=none; b=iRyD6/kJCMVMTpWr4p40JhsRG6u26hTig9j2Q5Pd2TnXG51TuFza3jQGr786qnWlUtn3hL+n6S9ADrCeoiTUz6JWzgCbSHr12CSM1b57Ijxbgzdbu1lLZTJ2lpyMNMQvjdaSyLI7rZAlztTKJnvADWgC5ow3Adj/Mo84rJg2Tag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758620508; c=relaxed/simple;
	bh=23ktBBop4u/x7zNZgLlZ9TKFaiNhHwD9+DMajpKh+NY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u4vNkMi+vK/3zZi57AUDk/nExBM3WIVZ9zW4f7ez+XQt2jVNQsu4oGTVYhoaJ07tgjWEtkLEMGaLpeL6vx1qlVq8Nhcd3NbeDtMtnrBYhJx7i/ECwmckrlH4snf0T9CiT1L/uwl7YACW/eqZTF20cw9PkietW0i/g5GvQVdMtgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=fuKvRG3W; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58N9POWb004909;
	Tue, 23 Sep 2025 02:41:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=JdMj8B8nXgt0VBenxcRLktJ
	uo4S96i7ypAqb9pDdydU=; b=fuKvRG3WXdkgKVdbyzP1hsRKyw5xNDjNTRz72U8
	uqd7/gyCz+6OQ5+c0v/sG29FKfzUTZV5dhU6iux1YoNrXYhMTZmQEeicHoP18FK9
	SzZ6rUG6imgVf9aDRDEYGaculb3Bgn8kQ7wO2pcb7bFow71M/5mZkSv9/P0dZaUT
	up6KRFHIsqIjePkbah7CQqWtf0QyKCCt5CF59kqJtAfhRYW/1+2tdD0I0wFiwQgo
	u1FtO3PEq+k2JFf/v6kRAM1HQVjeJqhcaJfXrUPL8x5DRJLUDfIcvIxx7ZUc0h2v
	04YSCL4Yt2t8v22+Nl4moqp01I66Xn+3XTIRoN0PuXZWGLw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49brw6019t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 02:41:25 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 23 Sep 2025 02:41:23 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 23 Sep 2025 02:41:23 -0700
Received: from sburla-PowerEdge-T630.sclab.marvell.com (unknown [10.106.27.217])
	by maili.marvell.com (Postfix) with ESMTP id 03E103F70E3;
	Tue, 23 Sep 2025 02:41:23 -0700 (PDT)
From: Sathesh B Edara <sedara@marvell.com>
To: <linux-kernel@vger.kernel.org>, <sburla@marvell.com>, <vburru@marvell.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>, <hgani@marvell.com>,
        <andrew@lunn.ch>, <srasheed@marvell.com>
CC: <sedara@marvell.com>
Subject: [net-next PATCH v1 0/2 RESEND] Add support to retrieve hardware channel information
Date: Tue, 23 Sep 2025 02:41:17 -0700
Message-ID: <20250923094120.13133-1-sedara@marvell.com>
X-Mailer: git-send-email 2.36.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: adqpub6dw1nwK2Iml_AyN_CqnSU3JuTd
X-Proofpoint-ORIG-GUID: adqpub6dw1nwK2Iml_AyN_CqnSU3JuTd
X-Authority-Analysis: v=2.4 cv=ZfQdNtVA c=1 sm=1 tr=0 ts=68d26b45 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=yJojWOMRYYMA:10 a=PlYhftpBkXA4JvsghnwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDA4NyBTYWx0ZWRfX1Ue+F6O3FIUP AAfw0TvfCbZLIjeEPkaPG95C2jcyp5kz11G8env2EywIPzm3XFIi9yZT9iGvPcF9VvrmGNAp1Ig CPHkK4fswnkZCw+nPcWHTBsrOESRQK6F/G/p2qOaTzzbKPaKXRJMK28JMELAdDUHRhMy8cainGL
 kPt+ezuyKjTLzrXlxuTchcRpLhhMxAy2iD3n0t0TKXYL/dJCg339AE9ppZtjXh5IhoQ9pAx89UM 2af1fPsVWbaMtQflbqoEQYjjRxf3z0udpiGJTFEZ5ERtJwgDJg+JN1rtHKjekUPj/6v37EzZBiJ +hD7p+elNDunnr7MaQ5/r4yxz2WcHjhoKrj6obumu3umVMmuH+3dkohF/64C1dPYb1Wt9GegSJz KeE0nSBI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_02,2025-09-22_05,2025-03-28_01

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


