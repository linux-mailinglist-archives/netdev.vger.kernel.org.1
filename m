Return-Path: <netdev+bounces-143445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB3B9C2732
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 22:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAB151F2169E
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 21:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2C51F26FF;
	Fri,  8 Nov 2024 21:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="Bxqo0csO"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-1.cisco.com (alln-iport-1.cisco.com [173.37.142.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CAD1A9B2D;
	Fri,  8 Nov 2024 21:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731102623; cv=none; b=Ca137ravl2SbgdIW+6ORJAhRz6y1kJdrN1GtMUrqDFl+i7Yh2hKOzASC4HXHhqWcGdhzjBMip6jbGXWv1SmloO9KwXf/YT1yoUYegGp55TR4pmzLHSYAhobpvbNQxTG0aPlLnvcDv7pQDI1UhFQqtZ/clIhlMArTv8sKjvXRdeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731102623; c=relaxed/simple;
	bh=3A1L0HHEqpMfeJKngItpZdzI83gx05iVuj6DC+bc5+I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uLjbM9UnIiiJM4llv7cn+7am7swENFa8w8LhqQ4L/IpHkPYE62mrZWTQicdu/TJVR4us9Ko95ZD3pqtsGkzc59Mr3+SgD6N9GbM+b9kN8MVGaJRo/alV/QmJbdyfVA0vP7bG988viziEpjwLGJUP2hEmKgm2sOCz/1ntYse1l/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=Bxqo0csO; arc=none smtp.client-ip=173.37.142.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2001; q=dns/txt; s=iport;
  t=1731102622; x=1732312222;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=jfqAreFpTMynXtLhUSqXAhZwUxQL8NmxVpTHRoCWs+g=;
  b=Bxqo0csO522w8ZPhqi8ujwB+mBKMhQaP6zvXrB9Of23fcmf0U+ihCRrG
   sTctVNMwKQkxML8Dp9MWiFyyhaykx86q3lN5yrIIqNk5MYJfyNHMIDbZR
   2kFXf2FFcWGnafIUWKAnmDJgqiQp+d0FZZbNmgTFvU8/OhnhJsRjuzYn5
   w=;
X-CSE-ConnectionGUID: HmNyFI7fSZevZgiJLHGB5Q==
X-CSE-MsgGUID: n9huobjpRoSY6z7SflP1bg==
X-IPAS-Result: =?us-ascii?q?A0AJAAA5hi5nj5D/Ja1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPwYBAQELAQGDP1pCSIRViB2HMIIhi3WSIxSBEQNWDwEBAQ87CQQBA?=
 =?us-ascii?q?YUHijwCJjQJDgECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFFAEBA?=
 =?us-ascii?q?QEBATkFSYV7DUkBEAGGAidWNQImAi0bFgESgwEBgmQCAREGsEN6gTKBAYR72?=
 =?us-ascii?q?TiBZwaBGi4BiEsBgWyDfTuEPCcbgUlEgRQBgihRb4QbDoN1gmkEgRCGUiWJF?=
 =?us-ascii?q?ZBEiA4JP4EFHANZIREBVRMNCgsHBWNYPgMib2lceiuBDoEXOkOBO4EiLxshC?=
 =?us-ascii?q?1yBOIEaFAYVBIEOQT+CSmlLNwINAjaCJCRZgk+FHYRvhGiCEh1AAwsYDUgRL?=
 =?us-ascii?q?DUGDhsGPQFuB54oAUaDLAEBgQ4rIDA1fxA2kxiDaY09oWuEJIwWlUMzhASUA?=
 =?us-ascii?q?ZJImHcijV2VYlyEZoFnOoFbMxoIGxWDIhM/GQ+OOoh1iioBtTpDNQIBOAIHC?=
 =?us-ascii?q?wEBAwmGSIUbhDqBfAEB?=
IronPort-Data: A9a23:u37leajDPc91SCpjBRdKfMB+X1619BAKZh0ujC45NGQN5FlHY01je
 htvDGuGafjfZjb8Ktt3boy//RsGucWDyt81HgBu/C1kEixjpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+FH1dOCn9SQkvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRW2thg
 vus5ZSFULOZ82QsaD5NsvrT8E8HUMna4Vv0gHRvPZing3eG/5UlJMp3Db28KXL+Xr5VEoaSL
 87fzKu093/u5BwkDNWoiN7TKiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JAAatjsAhlqvgqo
 Dl7WTNcfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQqflO0q8iCAn3aMqU4/8BmL0AR+
 8cqJS4/YRGho8KZ6u+CH7wEasQLdKEHPasFsX1miDWcBvE8TNWbHOPB5MRT23E7gcUm8fT2P
 pVCL2EwKk6dPlsWZgt/5JEWxI9EglH5fjBDo1WfrII84nPYy0p6172F3N/9IYzQGJ8Ewx/Fz
 o7A12KoAgwdPt6H8z2+wyy+2dTBmRuiUo1HQdVU8dYx3QXMnTZMYPEMbnO3qOe0j2ayUsxSL
 kgT9DZoq6UunGSmQsT4Vg+1vFaLuRkTX9cWGOo/gCmNzbDR+C6aC3ICQzoHb8Yp3Oc1WDYj/
 lyEhdXkAXpoqrL9YXub+q2ZsnC0NDQZIHEqYTICS00O47HLuIg5gxTOZsxuHK68kpv+HjSY6
 zSLqjUuwrYel8gG042l8l3dxTGhvJ7ESkgy/Aq/dmSo8g90eqa7aIGyr1vW9/BNKMCeVFbpg
 ZQfs9KV4OZLCdSGkzaABb1SWrqo/P2CdjbbhDaDAqXN6RyN/liyU6EP7gpMKVlbPccmXR/GS
 hLq7FY5CIBoAFOmaqp+YoSUAssszLT9GdmNahwyRoQTCnSWXFHblByCdXKtM3bRfF/AeJzT2
 Kt3k+7xVR726ow+kFJaotvxN5dwmUjSIkuIGvjGI+yPi+b2WZJsYe5t3KGyRu449riYhw7e7
 sxSMcCHoz0GD7anOnGLq99LfQhXRZTeOXwQg5IPHgJkClc2cFzN99eInNvNhqQ8xf0MzbaSl
 p1DchUFkgCi7ZE4Fel6Qis+MOy0B8kXQYMTNi03NlHgwGk4fYuq9+8ecZBxFYTLB8Q9pcOYu
 8ItIp3aatwWE2yv021EPfHV8tc4HDz13l3mAsZQSGRkF3KWb1CSooe8FuYunQFSZheKWTwW+
 O36j1+CGsJTGWyPzq/+MZqS8r94hlBF8MoaYqcCCoA7lJnEmGSyFxHMsw==
IronPort-HdrOrdr: A9a23:soURcaOGo4BNAcBcTjSjsMiBIKoaSvp037Dk7TEXdfUzSL36qy
 nOppQmPHDP5wr5NEtMpTniAsi9qA3nm6KdiLN5VdzJYOCMggeVxe9ZnO/f6gylMHC7y/VU36
 VhdKYWMqyTMXFKyez66A63H5IB7bC8gcWVrNab4ntzQQRtcq16qyV0Gm+gYzVLbTgDKJYnGJ
 +b/8Zd4wChd3Mec9ihChA+LpH+TqXw5fTbidpsPW9c1OFI5gnYk4LHLw==
X-Talos-CUID: 9a23:BR2isGMKgXu+l+5DeCxB5WA1Rc4eQHDD/njRAWuYJkw0cejA
X-Talos-MUID: 9a23:3JQRtQW8o4Ctennq/Dm9hCxlPsVw2aOVOR4fzq4Iv/HdPyMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,139,1728950400"; 
   d="scan'208";a="382529515"
Received: from rcdn-l-core-07.cisco.com ([173.37.255.144])
  by alln-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 08 Nov 2024 21:49:13 +0000
Received: from neescoba-vicdev.cisco.com (neescoba-vicdev.cisco.com [171.70.41.192])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-07.cisco.com (Postfix) with ESMTPS id 8130F18000231;
	Fri,  8 Nov 2024 21:49:12 +0000 (GMT)
Received: by neescoba-vicdev.cisco.com (Postfix, from userid 412739)
	id EB1A0CC128B; Fri,  8 Nov 2024 21:49:11 +0000 (GMT)
From: Nelson Escobar <neescoba@cisco.com>
Subject: [PATCH net-next v3 0/7] enic: Use all the resources configured on
 VIC
Date: Fri, 08 Nov 2024 21:47:46 +0000
Message-Id: <20241108-remove_vic_resource_limits-v3-0-3ba8123bcffc@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAKHLmcC/32OQQqDMBREryJZNxK/UWtXvUcpEuNP/VBNSWywi
 HdvCF246moYhnkzG/PoCD27ZBtzGMiTnaMpTxnTo5ofyGmInoEAWQgoucPJBuwC6c6ht2+nsXv
 SRIvnqFQtTYt1ZXoWAS+HhtYEv7EZFz7jurB7TEbyi3WftBqKlP8GQMiiEU0OjRTAIVbQa9urq
 6aoubZTAgQ4luS/VwG44KJs+7NWWJlhOKL2ff8CykIAmgMBAAA=
X-Change-ID: 20241023-remove_vic_resource_limits-eaa64f9e65fb
To: John Daley <johndale@cisco.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nelson Escobar <neescoba@cisco.com>, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731102551; l=2060;
 i=neescoba@cisco.com; s=20241023; h=from:subject:message-id;
 bh=3A1L0HHEqpMfeJKngItpZdzI83gx05iVuj6DC+bc5+I=;
 b=HC77eS4f+G02hXkr/SHl805qFOp8Kc18126zaw7L17XOtXYMKQDKEdU2SNyA7JQ42JI4Jw3O4
 KLaSX+03q0DDE+I2ZR+kUt6dMIT/rNJmq004Ni6toUH/kKXhK0R8aPj
X-Developer-Key: i=neescoba@cisco.com; a=ed25519;
 pk=bLqWB7VU0KFoVybF4LVB4c2Redvnplt7+5zLHf4KwZM=
X-Outbound-SMTP-Client: 171.70.41.192, neescoba-vicdev.cisco.com
X-Outbound-Node: rcdn-l-core-07.cisco.com

Allow users to configure and use more than 8 rx queues and 8 tx queues
on the Cisco VIC.

This series changes the maximum number of tx and rx queues supported
from 8 to the hardware limit of 256, and allocates memory based on the
number of resources configured on the VIC.

Signed-off-by: Nelson Escobar <neescoba@cisco.com>
---
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


