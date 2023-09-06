Return-Path: <netdev+bounces-32282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D221793E21
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 15:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1499281597
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 13:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525F11078F;
	Wed,  6 Sep 2023 13:55:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447A53FE4
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 13:55:42 +0000 (UTC)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EBDD7;
	Wed,  6 Sep 2023 06:55:39 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VrU7-wc_1694008532;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VrU7-wc_1694008532)
          by smtp.aliyun-inc.com;
          Wed, 06 Sep 2023 21:55:37 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: kgraul@linux.ibm.com,
	wenjia@linux.ibm.com,
	jaka@linux.ibm.com
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	"D. Wythe" <alibuda@linux.alibaba.com>
Subject: [RFC net-next 0/2] Optimize the parallelism of SMC-R connections 
Date: Wed,  6 Sep 2023 21:55:28 +0800
Message-Id: <1694008530-85087-1-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

From: "D. Wythe" <alibuda@linux.alibaba.com>

This patchset attempts to optimize the parallelism of SMC-R connections
in quite a SIMPLE way, reduce unnecessary blocking on locks.

According to Off-CPU statistics, SMC worker's off-CPU statistics
as that: 

smc_listen_work 			(48.17%)
	__mutex_lock.isra.11 		(47.96%)

An ideal SMC-R connection process should only block on the IO events
of the network, but it's quite clear that the SMC-R connection now is
queued on the lock most of the time.

Before creating a connection, we always try to see if it can be
successfully created without allowing the creation of an lgr,
if so, it means it does not rely on new link group.
In other words, locking on xxx_lgr_pending is not necessary
any more.

Noted that removing this lock will not have an immediate effect
in the current version, as there are still some concurrency issues
in the SMC handshake phase. However, regardless, removing this lock
is a prerequisite for other optimizations.

If you have any questions or suggestions, please let me know.

D. Wythe (2):
  net/smc: refactoring lgr pending lock
  net/smc: remove locks smc_client_lgr_pending and
    smc_server_lgr_pending

 net/smc/af_smc.c   | 24 ++++++++++++------------
 net/smc/smc_clc.h  |  1 +
 net/smc/smc_core.c | 28 ++++++++++++++++++++++++++--
 net/smc/smc_core.h | 21 +++++++++++++++++++++
 4 files changed, 60 insertions(+), 14 deletions(-)

-- 
1.8.3.1


