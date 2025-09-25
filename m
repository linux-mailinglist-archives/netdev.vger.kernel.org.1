Return-Path: <netdev+bounces-226352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BCCB9F5B5
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 14:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73BDA3B112E
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 12:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2998C1E7C03;
	Thu, 25 Sep 2025 12:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="SLxFpjDp"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C2C1DF979;
	Thu, 25 Sep 2025 12:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758804715; cv=none; b=V3O9tj8N3HzzCjRqs74h1tWQUL2iBmKHDiIpNQbh061r9/F7g+YusiHAS/f9rH5yQqgUxju53LBRxmm6eA5qoXceXffiqXKtLj9RCgrYVXQ5R2OCmZg3vfAhZJQJvCLaUghvdIHgQMC+IWIRn2rvj9VYqOM4asQqf5KrjFt9Hio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758804715; c=relaxed/simple;
	bh=0oKGHYWyAMVkFfkN4CphbsNXX0lCYuXfk3CFspImQTk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SaSEtXEUkWffYvC/4QQ/9Mp+nbuevYXmrbcrxCuCl4XNi3mC9VKhwsizgIhBMo7UsOq5vXJJPnH6WCd3VjqPCLhiyVXRyooXLdsY+W6zYwNQ9l5CKhePvL54AbhM9rowXVM/SQtYYIWcX6/UyEln7+TrLc+t++olbLDjreejCcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=SLxFpjDp; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PBN406008262;
	Thu, 25 Sep 2025 05:51:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=qhC9nuF/E36QxvciCK22cHK
	aklsWI1zOOWPbsfGRKl0=; b=SLxFpjDpUyOiONE4P27jlzHF/nTen31cqr/UDVu
	HZ+Dzb/pBZ21HdPySOdRgiatGu/vWPp7YvrlUtncI3/kuqz5It/11dr28g1wm4ib
	KwLHnDKVJVSxiblZdNutEEdKQr/YB/Uq45TczkVykMyZCKpTFmN76Po9VEWYocZF
	ppvDADON2DJeH3V0BMh/2en6s3XmgCiGw0h1HbdMKY5PhFX33Rkqhbp77rmm4Y3b
	OdUqrXCqk/odSFVQUab1TfFyRred/wn2eBN9rbbeqvxG0Zwl3k2DCDRJpsdlXEK+
	yKlTJz2BJGSZRu3VtnoNJjib+7Z3x/PUa7qZZTEespdQo6g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49d4thr5k7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 05:51:39 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 25 Sep 2025 05:51:37 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 25 Sep 2025 05:51:37 -0700
Received: from sburla-PowerEdge-T630.sclab.marvell.com (unknown [10.106.27.217])
	by maili.marvell.com (Postfix) with ESMTP id 30EA13F7043;
	Thu, 25 Sep 2025 05:51:37 -0700 (PDT)
From: Sathesh B Edara <sedara@marvell.com>
To: <linux-kernel@vger.kernel.org>, <sburla@marvell.com>, <vburru@marvell.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>, <hgani@marvell.com>,
        <andrew@lunn.ch>, <srasheed@marvell.com>
CC: <sedara@marvell.com>
Subject: [net-next PATCH v2 0/2] Add support to retrieve hardware channel information
Date: Thu, 25 Sep 2025 05:51:32 -0700
Message-ID: <20250925125134.22421-1-sedara@marvell.com>
X-Mailer: git-send-email 2.36.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: aEVG3Q6B6FfYSFfsTlE7tXONk319J5rl
X-Authority-Analysis: v=2.4 cv=L+0dQ/T8 c=1 sm=1 tr=0 ts=68d53adb cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=PlYhftpBkXA4JvsghnwA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: aEVG3Q6B6FfYSFfsTlE7tXONk319J5rl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDEwNyBTYWx0ZWRfX3J1yfTDoaHIW Hw2zLJKGMd+GqkElZlh0Itu14xYca4nHWhwU49nTnF0Z917GJMH3XmzVSPZLawo737Ynb6Pvhbl n6ZZx4mbJWro6fDjhY/q022NaoVkDXW8OC5tQ4W8vxBlkRwCJGQVsOd9Z4yz2dZLKgws6W5WjQ6
 LY4xhkPZeBoZW+EbwNYbVNoi9AJNwOB4/ZMTpcfGmRQMtpUEVq9mkoH2Nk4C1lXEgY3yql6lbje yaj92jbclgpgcuva5AVu+DcSLKIkhZ98QuiDXHpzzojLOYCjdJXfnVBr+R8ufF/GMkGZ8VHTSeW X4g2qUn9c7KNWojTz0is/Hr/h9go+1gLkCPVam2zOcNLILvmVpcFiDDCSvYVbF5PkYrv9habjIz uY2+sZsX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01

This patch series introduces support for retrieving hardware channel
configuration through the ethtool interface for both PF and VF.

Sathesh B Edara (2):
  octeon_ep: Add support to retrieve hardware channel information
  octeon_ep_vf: Add support to retrieve hardware channel information

 drivers/net/ethernet/marvell/octeon_ep/octep_ethtool.c | 10 ++++++++++
 .../ethernet/marvell/octeon_ep_vf/octep_vf_ethtool.c   | 10 ++++++++++
 2 files changed, 20 insertions(+)

Find V1 here:
https://lore.kernel.org/netdev/20250923094120.13133-1-sedara@marvell.com/

V2:
- Corrected channel counts to combined.

-- 
2.36.0


