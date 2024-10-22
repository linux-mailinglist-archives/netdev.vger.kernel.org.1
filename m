Return-Path: <netdev+bounces-137712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7E59A97B7
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 06:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 481182846CB
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 04:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF504EB38;
	Tue, 22 Oct 2024 04:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="CUHNQOQv"
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-3.cisco.com (rcdn-iport-3.cisco.com [173.37.86.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001A28BFC
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 04:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729570668; cv=none; b=MIKxHXbU9mAweM6dZQTZoWmluyq6+7Tu4+b+hcskbsWHTWoS3NWTBeSx9wxAqOJw7cphGupzcO3Nkv6JYjv4rYfFKTBd0mRNh6U0B3AQ0aQAA1FlsLut6Dr7y70RoH3aq3TTb1xR5Pc7VMBgIqd5IvRGb1BWBEBXCLfXFJ6fv50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729570668; c=relaxed/simple;
	bh=7W4kP37Tm5JYRpfxvvn3SOhD/eZ5S6BSsskO6+JLf1w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qFUfMTOeXllcCsc4WYUPTnOnUpuBMVASTIsZWcsIHvTqBtOzS6D2PutT7z/K5zKwlZcB4wsAt9O3icvuAX4pR/3nOE1UBCo8Lc/3PcVz2vClg6vlJ2c1t1TWYYFvuQKBSti9yhZ8XKqHPwZnRfw1/eKsEu0aJl7xgOfFeJXr+6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=CUHNQOQv; arc=none smtp.client-ip=173.37.86.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=912; q=dns/txt; s=iport;
  t=1729570666; x=1730780266;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BTHVqtQirpuL/afoUZDNQmUSyvcxduIZloq7CQcK4yk=;
  b=CUHNQOQvwooTuqhCVeOawxiBf7yteulOSvojeg7FFgc2V3bp6E+NSq1C
   j2LlKCMciKwM/EyBshl5ISbK++yoY6NZUYssJmm5SwbqDAEgPwZzoFLJx
   V/ryoA0AV9+RiH6s1eDrnD1MLpTXjH5YfEOLsvm4IFNyT5HOlPlY4aNK4
   s=;
X-CSE-ConnectionGUID: FglPbgC5SICpfyVxwgbNBg==
X-CSE-MsgGUID: ZY8W+5eGTkmptvGhTiRebQ==
X-IPAS-Result: =?us-ascii?q?A0BeAABGJhdn/5P/Ja1aHQEBAQEJARIBBQUBggAHAQsBg?=
 =?us-ascii?q?kqBT0OOGYhyi3WSIoF+DwEBAQ9EBAEBhQeKJQImNQgOAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQEBAQ0BAQUBAQECAQcFgQ4ThgiGXTYBRoEMg0WCZQOvW4IsgQGEe9k4g?=
 =?us-ascii?q?WyBSAGNRXCEdycbgUlEgRSCeoUKdYV3BJ1vJYk9kXZIgSEDWSECEQFVEw0KC?=
 =?us-ascii?q?wkFiTWDJimBa4EIgwiFJYFnCWGIR4EHLYERgR86ggOBNkqFN0c/gk9qTjcCD?=
 =?us-ascii?q?QI3giSBAIJRhkdAAwsYDUgRLDUUGwY+bgewJoEPgTB/RqUhoH6EJKE/GjOEB?=
 =?us-ascii?q?ZQBkkaYd6Q6hGaBaQI4gVkzGggbFYMjURkP2wEmbQIHCwEBAwmMLIF8AQE?=
IronPort-Data: A9a23:ETFw/6NLsTF24PPvrR3ilsFynXyQoLVcMsEvi/4bfWQNrUp03zJSn
 2cdWmyFa/+NYzb3e4h2YY23oB4Ov5LVzt5jT3M5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCdap1yFDmE/0fF3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZh6mJTqYb/WlrlV
 e/a+ZWFZAb9gWQsawr41orawP9RlKWq0N8nlgRWicBj5Df2i3QTBZQDEqC9R1OQapVUBOOzW
 9HYx7i/+G7Dlz91Yj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnBaPpIACRYpQRw/ZwNlMDxG4
 I4lWZSYEW/FN0BX8QgXe0Ew/ypWZcWq9FJbSJSymZT78qHIT5fj69thCHk8MqZFwcdcGW9fy
 +wHJzorRB/W0opawJrjIgVtrt4oIM+uOMYUvWttiGiBS/0nWpvEBa7N4Le03h9p2ZsIRqmYP
 ZdEL2MzM3wsYDUXUrsTIJQzkfyjgXP2WzZZs1mS46Ew5gA/ySQrj+exYYSLKoLiqcN9rHfIm
 SGb8kvFARQCKMKwyQaEyH+mv7qa9c/8cMdIfFGizdZsjUGfy3I7FhIbTx24rOO/h0r4XMhQQ
 3H44QI0pqQ0sUjuRd7nUljh+DiPvwUXXJxbFOhSBByx95c4Kj2xXgAsJgOtovR/3CPqbVTGD
 mO0ou4=
IronPort-HdrOrdr: A9a23:h59AY6nyHIcEeMy9DTEtvnPvLafpDfIn3DAbv31ZSRFFG/FwWf
 rAoB19726QtN9/YhAdcLy7VZVoIkmsl6Kdn7NwAV7KZmCP0wGVxepZg7cKrQeNJ8SHzJ8/6U
 +lGJIOb+EZyjNB/KLH3DU=
X-Talos-CUID: =?us-ascii?q?9a23=3AfnzZuWqDpesWM7PiZpVIjxfmUe4qdkXXw1yNGG6?=
 =?us-ascii?q?TEWh4dq2KRlW20qwxxg=3D=3D?=
X-Talos-MUID: 9a23:4Tw2zQirrv+qFfstDIoDaMMpBvY43OfzBW8xkpAep9erNRBxATqXtWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,222,1725321600"; 
   d="scan'208";a="277496686"
Received: from rcdn-l-core-10.cisco.com ([173.37.255.147])
  by rcdn-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 22 Oct 2024 04:17:39 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-10.cisco.com (Postfix) with ESMTP id 985C218000263;
	Tue, 22 Oct 2024 04:17:38 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 412739)
	id 5F32E20F2003; Mon, 21 Oct 2024 21:17:38 -0700 (PDT)
From: Nelson Escobar <neescoba@cisco.com>
To: netdev@vger.kernel.org
Cc: satishkh@cisco.com,
	johndale@cisco.com,
	Nelson Escobar <neescoba@cisco.com>
Subject: [Patch net-next 0/5] Use all the resources configured on VIC
Date: Mon, 21 Oct 2024 21:17:02 -0700
Message-Id: <20241022041707.27402-1-neescoba@cisco.com>
X-Mailer: git-send-email 2.35.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-l-core-10.cisco.com

Allow users to configure and use more than 8 rx queues and 8 tx queues
on the Cisco VIC.

This series changes the maximum number of tx and rx queues supported
from 8 to the hardware limit of 256, and allocates memory based on the
number of resources configured on the VIC.

Nelson Escobar (5):
  enic: Create enic_wq/rq structures to bundle per wq/rq data
  enic: Make MSI-X I/O interrupts come after the other required ones
  enic: Save resource counts we read from HW
  enic: Allocate arrays in enic struct based on VIC config
  enic: Adjust used MSI-X wq/rq/cq/interrupt resources in a more robust
    way

 drivers/net/ethernet/cisco/enic/enic.h        |  62 ++-
 .../net/ethernet/cisco/enic/enic_ethtool.c    |   8 +-
 drivers/net/ethernet/cisco/enic/enic_main.c   | 415 +++++++++++-------
 drivers/net/ethernet/cisco/enic/enic_res.c    |  33 +-
 4 files changed, 312 insertions(+), 206 deletions(-)

-- 
2.35.2


