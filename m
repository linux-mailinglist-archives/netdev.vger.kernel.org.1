Return-Path: <netdev+bounces-144619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A686F9C7F0C
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 00:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB6D6B21BFB
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 23:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9D818E029;
	Wed, 13 Nov 2024 23:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="iG8JpD0Q"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-7.cisco.com (alln-iport-7.cisco.com [173.37.142.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE6C189916;
	Wed, 13 Nov 2024 23:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731542284; cv=none; b=YxIfN4SpqEq7+IEY705oVoqpPfAClMg1kjuTvZOIeCQu8Iu7B8ngfi9z/O5o/4Hl+LoAtwV1QlnReU3bewXqJGtPgduoR4XUJTdDFPazpdx/MTFfr5SkBf7MtvMdxENyUrGkmWzvD1ZvqK2v5wLXWM3AfTjWL9tclJVdVmvIT+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731542284; c=relaxed/simple;
	bh=C/Pb0O9EV/ymqhuOoiX9O7mCGREp+63wZqJY1vKc9RU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iXgd3vmjIgReAtWec/mEpTGDPL7GMMaxbhYf44UHlvnqE8byDZO4K198ZFrznt5H/tIpR3ZVXAq1AkD4jrtpNXrgs57dJ8POCys9O/OGNEoaFmSUZAehIILrKe39nLH0aQ4wSKJNMQXtmEOP+bVcdfNXhNUf6lUtDcluFww2XFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=iG8JpD0Q; arc=none smtp.client-ip=173.37.142.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2246; q=dns/txt; s=iport;
  t=1731542282; x=1732751882;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=skuzlisS0FC9ZQmZMUTiNDgGcP7HKSZAqNh3ym7e9a0=;
  b=iG8JpD0QFzTK/yvuOwnrpqM40VYvS56IJjfX+N0aNXemvIFvHuFqZhjT
   VzwmPEBLH1Y8vCkLaXB7AndUHKXsqckGtDfh8jG07L73mCFLjlandYfmU
   C6x7cpb/y+hR1dS8ZlAAbNNpPuAqOBnV1AaVzzIemMNkUbBvnIrEHsGfG
   A=;
X-CSE-ConnectionGUID: ocq09MqTSWKh2w57c2uXdw==
X-CSE-MsgGUID: M8ekLbFaQtu13aC6Layrlw==
X-IPAS-Result: =?us-ascii?q?A0ADAADHOzVnj5MQJK1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAQGDP1pCSIRViB2HMIIhi3WSIxSBEQNWDwEBA?=
 =?us-ascii?q?Q87CQQBAYUHikcCJjQJDgECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBAQECA?=
 =?us-ascii?q?QcFFAEBAQEBATkFDjuFew1JARABhgInVjUCJgItGxYBEoMBAYJkAgERBrBPe?=
 =?us-ascii?q?oEygQGEe9k4gWcGgRouAYhLAYFsg307hDwnG4FJRIEUAYIoUW+EGw6DdYJpB?=
 =?us-ascii?q?IEQhk4liReRDogbCT+BBRwDWSERAVUTDQoLBwVjVzwDIm9qXHorgQ6BFzpDg?=
 =?us-ascii?q?TuBIi8bIQtcgTeBGhQGFQSBDkY/gkppSzoCDQI2giQkWYJPhRqEbYRmglQvH?=
 =?us-ascii?q?UADCxgNSBEsNQYOGwY9AW4HnmQBRoMxAQGBDisgMDV/EDaTGoNrjT6ha4Qkj?=
 =?us-ascii?q?BaVRjOEBJQBkkiYdyKNXZVjhUKBZzqBWzMaCBsVgyITPxkPjjqIdYoqAbY/Q?=
 =?us-ascii?q?zUCATgCBwsBAQMJhkiDfYQIgXwBAQ?=
IronPort-Data: A9a23:poUozqp8M0qxgwgVvWCTgyIX5Y1eBmKNZRIvgKrLsJaIsI4StFCzt
 garIBnQMq2DajamLYglbYW1/RgCsMTSx4dlQFdsrnw9FnhDpOPIVI+TRqvS04x+DSFioGZPt
 Zh2hgzodZhsJpPkjk7zdOCn9T8kiPngqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvV0
 T/Ji5OZYQXNNwJcaDpOt/va8Ug355wehRtB1rAATaET1LPhvyF94KI3fcmZM3b+S49IKe+2L
 86r5K255G7Q4yA2AdqjlLvhGmVSKlIFFVHT4pb+c/HKbilq/kTe4I5iXBYvQRs/ZwGyojxE4
 I4lWapc5useFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpfh660GMa04AWEX0uF8GDkf0
 OUkEw8ubkqc2r29mq+LRvY506zPLOGzVG8eknhkyTecCbMtRorOBvySo9RZxzw3wMtJGJ4yZ
 eJANmEpN0qGOkMJYwtIYH49tL/Aan3XdTBVs1mSr6Mf6GnIxws327/oWDbQUofVFJQIzhfD/
 goq+UzcUhwZENaxwAOZ7yv3j8SRuSrqQoYNQejQGvlC2wDLmTdJV3X6T2CTrfCnh0uWV9tBJ
 kkQ/SQy664/6CSDQ9XgWhSqrWKssRkbVN5dVeY97Wmlyq3O5h2xBWUeSDNFLts8u6ceRiEg3
 3eKksnvCDgpt6eaIVqU8LuOoCzxPyUJIWIcTSsZSw1D6NmLiJk6hB/JT/55HaK1h8GzEjb1q
 xiOrS4jl/AQgNQN2qGT41/KmXSvq4LPQwpz4R/YNkqj4x91aZCNeYOl8x7Y4OxGIYLfSUOO1
 EXogOCX6OQISJXInyuXTaBURPei5u2ON3vXhlsH84QdGyqF/HW6JdF1+Q1FG2RpaNlZJjSzf
 X/fplYEjHNMB0eCYahyaoO3Ls0ly6n8CNjoPsw4iPIQPvCdkyfZoUlTiV6s4oz7rKQ7fUgC1
 XannSSEUSZy5UdPlWbeqwIhPVkDnX5WKYT7HsyT8vhf+eDCDEN5sJ9cWLd0Usg37bmfvCLe+
 MtFOs2Bxn13CbKlO3SNq9BDfQ1TdxDX4KwaTeQKKIZvxSI7SQkc5wP5mOJJl3FNxv4Mz7yZp
 BlRpGcDmAOk2xUr1jlmmlg4NeuwBswgxZ7KFSctJl2vk2Myepqi6bxXdp08O9EaGB9Lk5ZJo
 w0+U5zYWJxnE22fkxxENMWVhNI5LnyD21nRVxdJlRBjJPaMsSSVoYe8JmMCNUAmUkKKiCfJi
 +bwil2AGcFcGFUK4QS/QKvH8m5ddEM1wIpaN3Yk6PEKEKkw2OCG8xDMs8I=
IronPort-HdrOrdr: A9a23:LDaS5K4hLJH2FZy+4wPXwPjXdLJyesId70hD6qkXc20sTiX4rb
 HWoB1/73XJYVkqOU3I9eruBED4ewK6yXct2/h2AV7AZniFhILLFvAH0WKK+VSJdxEWkNQttp
 uIG5IUNDSaNzZHZKjBgDVQQ+xM/DHEmJrY4Nvj8w==
X-Talos-CUID: 9a23:JeWMQ2/GZ6zpUdsytLyVv0kfA5h0V2Th90jzIxWnVDliEqClRUDFrQ==
X-Talos-MUID: 9a23:ua8hKwsD7ihpYnpUAs2noWFvN+Niza2XFF1Uypwt5e2NJDZ0JGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,152,1728950400"; 
   d="scan'208";a="379958930"
Received: from alln-l-core-10.cisco.com ([173.36.16.147])
  by alln-iport-7.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 13 Nov 2024 23:56:54 +0000
Received: from neescoba-vicdev.cisco.com (neescoba-vicdev.cisco.com [171.70.41.192])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-10.cisco.com (Postfix) with ESMTPS id 4CC311800026E;
	Wed, 13 Nov 2024 23:56:53 +0000 (GMT)
Received: by neescoba-vicdev.cisco.com (Postfix, from userid 412739)
	id C164ECC128B; Wed, 13 Nov 2024 23:56:52 +0000 (GMT)
From: Nelson Escobar <neescoba@cisco.com>
Subject: [PATCH net-next v4 0/7] enic: Use all the resources configured on
 VIC
Date: Wed, 13 Nov 2024 23:56:32 +0000
Message-Id: <20241113-remove_vic_resource_limits-v4-0-a34cf8570c67@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALA8NWcC/33OwWrDMAwG4FcpPs/Flt0m7WnvMUqwFbkVLHGxU
 9NR8u4zYbDQQ05C/Oj79RKZElMW591LJCqcOY51sR87gTc3XklyX3cBCqxWYGSiIRbqCmOXKMd
 HQuq+eeApS3LuaMOJjofgRQXuiQI/F/xLjDTJkZ6TuNTkxnmK6WdpLXrJ/wpAWd2oZg+NVSChn
 lDG6N0ncp17jMMCFFgf2a2vCkgllTn5Fh0dQt+/U+af0qrdpEyljHetBuMxBFxT8zz/Asdcub5
 OAQAA
X-Change-ID: 20241023-remove_vic_resource_limits-eaa64f9e65fb
To: John Daley <johndale@cisco.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nelson Escobar <neescoba@cisco.com>, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731542212; l=2306;
 i=neescoba@cisco.com; s=20241023; h=from:subject:message-id;
 bh=C/Pb0O9EV/ymqhuOoiX9O7mCGREp+63wZqJY1vKc9RU=;
 b=K+ynWfctiRpYxZoer6Bvkt2aQ5PqEv4HAbO63HVTGqBM9N1FYKPQ8ss6AK36HivlVRiyKYT1G
 xCS7f88kFZTC8ZsoUZTQ9/FSa1RcLHb3RVzx1xBretEGPK2OJvwFE7u
X-Developer-Key: i=neescoba@cisco.com; a=ed25519;
 pk=bLqWB7VU0KFoVybF4LVB4c2Redvnplt7+5zLHf4KwZM=
X-Outbound-SMTP-Client: 171.70.41.192, neescoba-vicdev.cisco.com
X-Outbound-Node: alln-l-core-10.cisco.com

Allow users to configure and use more than 8 rx queues and 8 tx queues
on the Cisco VIC.

This series changes the maximum number of tx and rx queues supported
from 8 to the hardware limit of 256, and allocates memory based on the
number of resources configured on the VIC.

Signed-off-by: Nelson Escobar <neescoba@cisco.com>
---
Changes in v4:
- Followed Vadim Fedorenko's suggestions for re-arranging enic_wq and
  adding ____cacheline_aligned to the new structs.
- Link to v3: https://lore.kernel.org/r/20241108-remove_vic_resource_limits-v3-0-3ba8123bcffc@cisco.com

Changes in v3:
- Per Jakub's suggestions, split commit 5 into smaller commits and use
  net_get_num_default_rss_queues() to set the number of RQs used.
- Fixed an issue with commit 2 caught during testing with a missing
  changed needed in enic_init_vnic_resources().
- Link to v2: https://lore.kernel.org/r/20241024-remove_vic_resource_limits-v2-0-039b8cae5fdd@cisco.com

Changes in v2:
- Followed Kalesh's suggestions: removed redundant NULL assigments,
  returning -ENOMEM directly
- Reviewed-by tag for Simon Horman <horms@kernel.org>
- Marked Satish Kharat and John Daley as co-developers to better reflect
  their role in this patch set
- Link to v1: https://lore.kernel.org/r/20241022041707.27402-2-neescoba@cisco.com

---
Nelson Escobar (7):
      enic: Create enic_wq/rq structures to bundle per wq/rq data
      enic: Make MSI-X I/O interrupts come after the other required ones
      enic: Save resource counts we read from HW
      enic: Allocate arrays in enic struct based on VIC config
      enic: Adjust used MSI-X wq/rq/cq/interrupt resources in a more robust way
      enic: Move enic resource adjustments to separate function
      enic: Move kdump check into enic_adjust_resources()

 drivers/net/ethernet/cisco/enic/enic.h         |  62 ++--
 drivers/net/ethernet/cisco/enic/enic_ethtool.c |   8 +-
 drivers/net/ethernet/cisco/enic/enic_main.c    | 386 +++++++++++++++----------
 drivers/net/ethernet/cisco/enic/enic_res.c     |  42 +--
 4 files changed, 299 insertions(+), 199 deletions(-)
---
base-commit: 6f07cd8301706b661776074ddc97c991d107cc91
change-id: 20241023-remove_vic_resource_limits-eaa64f9e65fb

Best regards,
-- 
Nelson Escobar <neescoba@cisco.com>


