Return-Path: <netdev+bounces-55208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DCE809D42
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 08:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47DD51F2112A
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 07:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED4A10780;
	Fri,  8 Dec 2023 07:41:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9364EDD;
	Thu,  7 Dec 2023 23:41:03 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0Vy2PAfL_1702021259;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Vy2PAfL_1702021259)
          by smtp.aliyun-inc.com;
          Fri, 08 Dec 2023 15:41:01 +0800
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
	guangguan.wang@linux.alibaba.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 0/9] net/smc: implement SMCv2.1 virtual ISM device support
Date: Fri,  8 Dec 2023 15:40:50 +0800
Message-Id: <1702021259-41504-1-git-send-email-guwen@linux.alibaba.com>
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

v5->v4:
- Patch #6: improve the comment of SMCD_CLC_MAX_V2_GID_ENTRIES;
- Patch #4: remove useless ini->feature_mask assignment;

v4->v3:
- Patch #6: use SMCD_CLC_MAX_V2_GID_ENTRIES to indicate the max gid
  entries in CLC proposal and using SMC_MAX_V2_ISM_DEVS to indicate the
  max devices to propose;
- Patch #6: use i and i+1 in smc_find_ism_v2_device_serv();
- Patch #2: replace the large if-else block in smc_clc_send_confirm_accept()
  with 2 subfunctions;
- Fix missing byte order conversion of GID and token in CLC handshake,
  which is in a separate patch sending to net:
  https://lore.kernel.org/netdev/1701882157-87956-1-git-send-email-guwen@linux.alibaba.com/
- Patch #7: add extended GID in SMC-D lgr netlink attribute;

v3->v2:
- Rename smc_clc_fill_fce as smc_clc_fill_fce_v2x;
- Remove ISM_IDENT_MASK from drivers/s390/net/ism.h;
- Add explicitly assigning 'false' to ism_v2_capable in ism_dev_init();
- Remove smc_ism_set_v2_capable() helper for now, and introduce it in
  later loopback-ism implementation;

v2->v1:
- Fix sparse complaint;
- Rebase to the latest net-next;

Wen Gu (9):
  net/smc: rename some 'fce' to 'fce_v2x' for clarity
  net/smc: introduce sub-functions for smc_clc_send_confirm_accept()
  net/smc: support SMCv2.x supplemental features negotiation
  net/smc: introduce virtual ISM device support feature
  net/smc: define a reserved CHID range for virtual ISM devices
  net/smc: compatible with 128-bits extended GID of virtual ISM device
  net/smc: support extended GID in SMC-D lgr netlink attribute
  net/smc: disable SEID on non-s390 archs where virtual ISM may be used
  net/smc: manage system EID in SMC stack instead of ISM driver

 drivers/s390/net/ism.h        |   7 --
 drivers/s390/net/ism_drv.c    |  57 +++------
 include/linux/ism.h           |   1 -
 include/net/smc.h             |  16 ++-
 include/uapi/linux/smc.h      |   2 +
 include/uapi/linux/smc_diag.h |   2 +
 net/smc/af_smc.c              |  66 ++++++++--
 net/smc/smc.h                 |  10 +-
 net/smc/smc_clc.c             | 278 +++++++++++++++++++++++++++---------------
 net/smc/smc_clc.h             |  26 ++--
 net/smc/smc_core.c            |  37 ++++--
 net/smc/smc_core.h            |  18 ++-
 net/smc/smc_diag.c            |   9 +-
 net/smc/smc_ism.c             |  50 +++++---
 net/smc/smc_ism.h             |  30 ++++-
 net/smc/smc_pnet.c            |   4 +-
 16 files changed, 400 insertions(+), 213 deletions(-)

-- 
1.8.3.1


