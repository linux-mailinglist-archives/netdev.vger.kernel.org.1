Return-Path: <netdev+bounces-43458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFED7D3511
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 13:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 339521C208D0
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 11:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CB215EBF;
	Mon, 23 Oct 2023 11:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Qb9rj7BA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F1B15EA7
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 11:45:10 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEC410FB;
	Mon, 23 Oct 2023 04:45:08 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39MLx6W5018223;
	Mon, 23 Oct 2023 04:45:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=JZuj+TXpGcDe4yHZ3tY3RfIizoyIL6N2Au+s/0qKWKA=;
 b=Qb9rj7BAgFA/wSh1bdCFc8och2zyh+iT20JP4cbawlGygB+lW8ythF3aVWignGHzbFKT
 cnTnt1tu5WFce9UEYEmcTg/SBbO+c8Jnuhm9FZBHODC5RXmx7CETEYBkYU0zE1oL37+i
 36YtBjIzsYUT6du1u2PSLWuKV+Q1uKWLFwWBhRXraai8pVyZY+1/rSodZw5dCIO0U5ua
 pfFrT6v4XuF2EBOakT4u1eAdwd4qPa90afhWBcSwD5y8LB0kuYG1i3DWcN1F9HyPzRy8
 Mwu7gc3koT0/2WgORJACDf3WJaElL/y0IRE3jIfGfPTnNacv7QFHWDzb8cB3Opfls7M6 Hw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3tvc0qp113-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Mon, 23 Oct 2023 04:45:03 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 23 Oct
 2023 04:45:02 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 23 Oct 2023 04:45:02 -0700
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 395273F7044;
	Mon, 23 Oct 2023 04:45:01 -0700 (PDT)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <kuba@kernel.org>, <davem@davemloft.net>,
        Shinas Rasheed
	<srasheed@marvell.com>
Subject: [PATCH net-next 0/3] Cleanup and optimizations to transmit code
Date: Mon, 23 Oct 2023 04:44:45 -0700
Message-ID: <20231023114449.2362147-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: du1-BUYvZUFGhcxJZLcWYgghew067oG_
X-Proofpoint-GUID: du1-BUYvZUFGhcxJZLcWYgghew067oG_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_10,2023-10-19_01,2023-05-22_02

Cleanup dma sync calls, add xmit_more functionality and then further
remove atomic variable usage in the prior.

Shinas Rasheed (3):
  octeon_ep: remove dma sync in trasmit path
  octeon_ep: implement xmit_more in transmit
  octeon_ep: remove atomic variable usage in Tx data path

 .../ethernet/marvell/octeon_ep/octep_config.h |  3 +-
 .../ethernet/marvell/octeon_ep/octep_main.c   | 35 ++++++++++---------
 .../ethernet/marvell/octeon_ep/octep_main.h   |  9 +++++
 .../net/ethernet/marvell/octeon_ep/octep_tx.c |  5 +--
 .../net/ethernet/marvell/octeon_ep/octep_tx.h |  3 --
 5 files changed, 30 insertions(+), 25 deletions(-)

-- 
2.25.1


