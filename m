Return-Path: <netdev+bounces-139787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5E69B4171
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 04:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBF011C20430
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 03:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E4E2010E8;
	Tue, 29 Oct 2024 03:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="AITu+Rjp"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F662010E0;
	Tue, 29 Oct 2024 03:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730174296; cv=none; b=Y7pUX+i7FKQmTeBMjZAY5tU9ru8vtJhyM2lCWDywwOiEXxK0WIFd9rHO6hzjoAyf2klpIr5heNo8iUH7pJSkzjy1H/HuXWVnUx0vKZNuc7qpgs5k4i3M27aDuCeSjlia7n7y3PpTgyF0vgYbY9EaLo7IeT/Nj+mK9t0/VoHJYS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730174296; c=relaxed/simple;
	bh=F2u3cl2SjWcs3OjghOgsxJYL8VpiRf/JhfUKtn4kDwQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ixoaW8PHqZyV1+vEMUozBxx/PtE+21srN3g5gMHeThVXR98HWM15PSnikxp/w9Zstp2lM9MDnkthck2BIjHU4rzi0/CTpa1JQ5JoHZ9zZywU72JN+O6MFn6lERz3s1dlrHdYtkKF7HbqJWSDDT+V8aEj5/W69MZc1n30/OBzz30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=AITu+Rjp; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49T0ABte014722;
	Mon, 28 Oct 2024 20:58:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=/
	sDZ1ethO15plh1blqFEQBc1mrttvUCmt9BDT2Yu4Rs=; b=AITu+RjpGFvVvxSAg
	djOXHk2QWpOILA2opgcg4Sx/Ar2PwtzDgrjDK81oMKKJp+78apCWIy5SZ6BQ9HAF
	ZCC1o0H4wG69/xKIXW7hvjmU22XyRuUJXkR/6WT6Vj2+J7wj2DG6br4uU2HNj8k0
	8oYe7VqMSOPChGAp4g7bdUNdLebl1TPnIFqK6YJpXR119frU7Xn90Vhc3buSsvdP
	Hxff5dxcFLL372azL8WDpbGofoguGWWfKVFKAg0jO+JQ68KPcX9+ml2MdkeuhXRX
	dLLIsCRbchdBXnJ9wVVbWBQszcoFYikj+0ObPva22wh+0XHBU7jXaJ9/+ascmf++
	F07/g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42jmx40ggd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Oct 2024 20:58:08 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 28 Oct 2024 20:58:07 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 28 Oct 2024 20:58:07 -0700
Received: from virtx40.. (unknown [10.28.34.196])
	by maili.marvell.com (Postfix) with ESMTP id 64A163F7054;
	Mon, 28 Oct 2024 20:58:03 -0700 (PDT)
From: Linu Cherian <lcherian@marvell.com>
To: <davem@davemloft.net>, <sgoutham@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>,
        <jerinj@marvell.com>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.comi>, <jiri@resnulli.us>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, Linu Cherian <lcherian@marvell.com>
Subject: [PATCH v4 net-next 3/3] devlink: Add documenation for OcteonTx2 AF
Date: Tue, 29 Oct 2024 09:27:39 +0530
Message-ID: <20241029035739.1981839-4-lcherian@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029035739.1981839-1-lcherian@marvell.com>
References: <20241029035739.1981839-1-lcherian@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: I-XO5X8Xjcx0pKkDNmzNJ-VE3Ac3rchC
X-Proofpoint-GUID: I-XO5X8Xjcx0pKkDNmzNJ-VE3Ac3rchC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Add documenation for the following devlink params
- npc_mcam_high_zone_percent
- npc_def_rule_cntr
- nix_maxlf

Signed-off-by: Linu Cherian <lcherian@marvell.com>
---
Changelog from v3:
Newly added patch

 Documentation/networking/devlink/octeontx2.rst | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/networking/devlink/octeontx2.rst b/Documentation/networking/devlink/octeontx2.rst
index d33a90dd44bf..7808ab361692 100644
--- a/Documentation/networking/devlink/octeontx2.rst
+++ b/Documentation/networking/devlink/octeontx2.rst
@@ -40,6 +40,21 @@ The ``octeontx2 AF`` driver implements the following driver-specific parameters.
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
+   * - ``nix_maxlf``
+     - u16
+     - runtime
+     - Use to set the maximum number of LFs in NIX hardware block. This would be useful
+       to increase the availability of default resources allocated to enabled LFs like
+       MCAM entries for example.
 
 The ``octeontx2 PF`` driver implements the following driver-specific parameters.
 
-- 
2.34.1


