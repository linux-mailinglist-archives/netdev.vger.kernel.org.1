Return-Path: <netdev+bounces-27965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAE577DC51
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 10:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9352281950
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 08:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1671C2DF;
	Wed, 16 Aug 2023 08:33:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D6717F7
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 08:33:52 +0000 (UTC)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2782D70;
	Wed, 16 Aug 2023 01:33:35 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VpvH8jJ_1692174810;
Received: from localhost.localdomain(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0VpvH8jJ_1692174810)
          by smtp.aliyun-inc.com;
          Wed, 16 Aug 2023 16:33:32 +0800
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
To: wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	kgraul@linux.ibm.com,
	tonylu@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	alibuda@linux.alibaba.com,
	guwen@linux.alibaba.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/6] net/smc: several features's implementation for smc v2.1
Date: Wed, 16 Aug 2023 16:33:22 +0800
Message-Id: <20230816083328.95746-1-guangguan.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch set implement several new features in SMC v2.1(https://
www.ibm.com/support/pages/node/7009315), including vendor unique
experimental options, max connections per lgr negotiation, max links
per lgr negotiation.

I have removed the RFC tag and changed the patch series to formal
patch series from this version.

RFC v2 - v1:
 - more description in commit message
 - modify SMC_CONN_PER_LGR_xxx and SMC_LINKS_ADD_LNK_xxx
   macro defination and usage
 - rename variable release_ver to release_nr
 - remove redundant release version check in client
 - explicitly set the rc value in smc_llc_cli/srv_add_link

RFC v1 - RFC v2:
 - Remove ini pointer NULL check and fix code style in
   smc_clc_send_confirm_accept.
 - Optimize the max_conns check in smc_clc_xxx_v2x_features_validate.

Guangguan Wang (6):
  net/smc: support smc release version negotiation in clc handshake
  net/smc: add vendor unique experimental options area in clc handshake
  net/smc: support smc v2.x features validate
  net/smc: support max connections per lgr negotiation
  net/smc: support max links per lgr negotiation in clc handshake
  net/smc: Extend SMCR v2 linkgroup netlink attribute

 include/uapi/linux/smc.h |   2 +
 net/smc/af_smc.c         |  83 ++++++++++++++++------
 net/smc/smc.h            |   5 +-
 net/smc/smc_clc.c        | 150 ++++++++++++++++++++++++++++++++-------
 net/smc/smc_clc.h        |  53 ++++++++++++--
 net/smc/smc_core.c       |  13 +++-
 net/smc/smc_core.h       |  25 +++++++
 net/smc/smc_llc.c        |  25 +++++--
 8 files changed, 301 insertions(+), 55 deletions(-)

-- 
2.24.3 (Apple Git-128)


