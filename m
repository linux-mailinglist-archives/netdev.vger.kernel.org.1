Return-Path: <netdev+bounces-141982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4EC9BCD28
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 13:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A003A1C21136
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 12:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2181D7E35;
	Tue,  5 Nov 2024 12:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="STTAPenN"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48561D6DA1;
	Tue,  5 Nov 2024 12:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730811414; cv=none; b=oZbn53Mr98+bYE9niEJ6xicqBSLPtk5du7yLWQo3zYxy0gPDPRbHxPM6uZ5zoq4Q5+D+zRdyNYXRocEkMDNwzppJevZWkI2iY/Y8GkFWPgKjTg6zfy6tsrCHsyTWX6g8VWwq0Plc0dDuKpMd6Rx/B//IgX3B9hkUo5qcGrqghao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730811414; c=relaxed/simple;
	bh=7syOqvfwqx0vnnI7vfbXvb3ZPt9ek1+5P/QhjDzBdJk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m5iQzi7/tSakSit81JyhPW+DZHAZqkpCTSLQQiJs+rVuJEk33rAD/Iqne4JyynGNxJkS/oRL3AII2LUfKesrcKmCL4nY+0Tt0rQ89f6LKJbuwwEGLvNFDkc6wpmRTd4E8Fmzvgc+tmMyBKUE3ZIzm2kJmujtVBpx5+9jfZauM50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=STTAPenN; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5BBbEk017502;
	Tue, 5 Nov 2024 04:56:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=N
	QHxVDUx9GyXa1oz2sAe8CixIRgY309C/OLRxKgAFsU=; b=STTAPenNdfm7hAZNV
	lzyBy38vR7J8ih27vuvPHi4rRzpQl0yBA0qM7+zV/Mt+P9Ps/XTWKsw1I8Nof6zZ
	nx4ZHDYIRIShEGkR+vyS+HGeIoIuPXkHF9121/DMzK81w0b6bKxBDpaGl0hea//S
	oQWm0X+sMF+6sZDoeqMlraazIeR+qUgFB/kux5ACHtmRHzsvcailrHRH/DvkVOKu
	x1RRbzqyGRfXt6MGGOsVDgnPjja+hAiwPW8fVF/iv7Sm6x5jqce+BywVGHl/piV6
	3/ABYarpfAoqMTEvLyt1pXWuSon8k8eW3861JFqDOyYRWlc25liX+R8cswlwj9Nx
	eb0Cg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42qj97g4s2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 04:56:40 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 5 Nov 2024 04:56:39 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 5 Nov 2024 04:56:39 -0800
Received: from virtx40.. (unknown [10.28.34.196])
	by maili.marvell.com (Postfix) with ESMTP id 385225C68E3;
	Tue,  5 Nov 2024 04:56:35 -0800 (PST)
From: Linu Cherian <lcherian@marvell.com>
To: <davem@davemloft.net>, <sgoutham@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>,
        <jerinj@marvell.com>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, Linu Cherian <lcherian@marvell.com>
Subject: [PATCH v5 net-next 3/3] devlink: Add documentation for OcteonTx2 AF
Date: Tue, 5 Nov 2024 18:26:20 +0530
Message-ID: <20241105125620.2114301-4-lcherian@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105125620.2114301-1-lcherian@marvell.com>
References: <20241105125620.2114301-1-lcherian@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: _wQHqliY693OPhGsuFYl6gdBNJnrjpzP
X-Proofpoint-ORIG-GUID: _wQHqliY693OPhGsuFYl6gdBNJnrjpzP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Add documentation for the following devlink params
- npc_mcam_high_zone_percent
- npc_def_rule_cntr
- nix_maxlf

Signed-off-by: Linu Cherian <lcherian@marvell.com>
---
Changelog from v4:
- Describe the behaviour when counters are not sufficient to meet all
  the enabled rules
- Add definition for default rules
- Add sample commands to read counters for default rules
- "Reviewed-by" from Simon not added due to above changes.

 .../networking/devlink/octeontx2.rst          | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/networking/devlink/octeontx2.rst b/Documentation/networking/devlink/octeontx2.rst
index d33a90dd44bf..84206537aedb 100644
--- a/Documentation/networking/devlink/octeontx2.rst
+++ b/Documentation/networking/devlink/octeontx2.rst
@@ -40,6 +40,27 @@ The ``octeontx2 AF`` driver implements the following driver-specific parameters.
      - runtime
      - Use to set the quantum which hardware uses for scheduling among transmit queues.
        Hardware uses weighted DWRR algorithm to schedule among all transmit queues.
+   * - ``npc_mcam_high_zone_percent``
+     - u8
+     - runtime
+     - Use to set the number of high priority zone entries in NPC MCAM that can be allocated
+       by a user, out of the three priority zone categories high, mid and low.
+   * - ``npc_def_rule_cntr``
+     - bool
+     - runtime
+     - Use to enable or disable hit counters for the default rules in NPC MCAM.
+       Its not guaranteed that counters gets enabled and mapped to all the default rules,
+       since the counters are scarce and driver follows a best effort approach.
+       The default rule serves as the primary packet steering rule for a specific PF or VF,
+       based on its DMAC address which is installed by AF driver as part of its initialization.
+       Sample command to read hit counters for default rule from debugfs is as follows,
+       cat /sys/kernel/debug/cn10k/npc/mcam_rules
+   * - ``nix_maxlf``
+     - u16
+     - runtime
+     - Use to set the maximum number of LFs in NIX hardware block. This would be useful
+       to increase the availability of default resources allocated to enabled LFs like
+       MCAM entries for example.
 
 The ``octeontx2 PF`` driver implements the following driver-specific parameters.
 
-- 
2.34.1


