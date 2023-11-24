Return-Path: <netdev+bounces-50869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9877F76A0
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 15:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42F2828208B
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 14:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D499C25749;
	Fri, 24 Nov 2023 14:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EAA19AE;
	Fri, 24 Nov 2023 06:42:20 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0Vx1p5U7_1700836935;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Vx1p5U7_1700836935)
          by smtp.aliyun-inc.com;
          Fri, 24 Nov 2023 22:42:17 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: wintera@linux.ibm.com,
	wenjia@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kgraul@linux.ibm.com,
	jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	raspl@linux.ibm.com,
	schnelle@linux.ibm.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/7] net/smc: implement SMCv2.1 virtual ISM device support
Date: Fri, 24 Nov 2023 22:42:08 +0800
Message-Id: <1700836935-23819-1-git-send-email-guwen@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The fourth edition of SMCv2 adds the SMC version 2.1 feature updates for
SMC-Dv2 with virtual ISM. Virtual ISM are created and supported mainly by
OS or hypervisor software, comparable to IBM ISM which is based on platform
firmware or hardware.

With the introduction of virtual ISM, SMCv2.1 makes some updates:

- Introduce feature bitmask to indicate supplemental features.
- Reserve a range of CHIDs for virtual ISM.
- Support extended GIDs (128 bits) in CLC handshake.

So this patch set aims to implement these updates in Linux kernel. And it
acts as the first part of SMC-D virtual ISM extension & loopback-ism [1].

[1] https://lore.kernel.org/netdev/1695568613-125057-1-git-send-email-guwen@linux.alibaba.com/

v2->v1:
- Fix sparse complaint;
- Rebase to the latest net-next;

Wen Gu (7):
  net/smc: Rename some variable 'fce' to 'fce_v2x' for clarity
  net/smc: support SMCv2.x supplemental features negotiation
  net/smc: introduce virtual ISM device support feature
  net/smc: define a reserved CHID range for virtual ISM devices
  net/smc: compatible with 128-bits extend GID of virtual ISM device
  net/smc: disable SEID on non-s390 archs where virtual ISM may be used
  net/smc: manage system EID in SMC stack instead of ISM driver

 drivers/s390/net/ism.h     |  6 ---
 drivers/s390/net/ism_drv.c | 54 +++++++--------------------
 include/linux/ism.h        |  1 -
 include/net/smc.h          | 16 +++++---
 net/smc/af_smc.c           | 68 ++++++++++++++++++++++++++-------
 net/smc/smc.h              |  7 ++++
 net/smc/smc_clc.c          | 93 ++++++++++++++++++++++++++++++++--------------
 net/smc/smc_clc.h          | 22 +++++++----
 net/smc/smc_core.c         | 32 ++++++++++------
 net/smc/smc_core.h         |  8 ++--
 net/smc/smc_diag.c         |  7 +++-
 net/smc/smc_ism.c          | 57 ++++++++++++++++++++--------
 net/smc/smc_ism.h          | 31 +++++++++++++++-
 net/smc/smc_pnet.c         |  4 +-
 14 files changed, 270 insertions(+), 136 deletions(-)

-- 
1.8.3.1


