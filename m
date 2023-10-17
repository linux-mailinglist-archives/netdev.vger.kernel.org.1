Return-Path: <netdev+bounces-41917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D5E7CC36B
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 14:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2E3AB210C7
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 12:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2BF41E2F;
	Tue, 17 Oct 2023 12:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035623E467
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 12:42:43 +0000 (UTC)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDD4EA;
	Tue, 17 Oct 2023 05:42:40 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VuNiO21_1697546556;
Received: from localhost.localdomain(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0VuNiO21_1697546556)
          by smtp.aliyun-inc.com;
          Tue, 17 Oct 2023 20:42:38 +0800
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
To: kgraul@linux.ibm.com,
	wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: tonylu@linux.alibaba.com,
	alibuda@linux.alibaba.com,
	guwen@linux.alibaba.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 0/2] net/smc: correct the reason code in smc_listen_find_device when fallback
Date: Tue, 17 Oct 2023 20:42:32 +0800
Message-Id: <20231017124234.99574-1-guangguan.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The function smc_find_ism_store_rc is not only used for ism, so it is
reasonable to change the function name to smc_find_device_store_rc.

The ini->rc is used to store the last error happened when finding usable
ism or rdma device in smc_listen_find_device, and is set by calling smc_
find_device_store_rc. Once the ini->rc is assigned to an none-zero value,
the value can not be overwritten anymore. So the ini-rc should be set to
the error reason only when an error actually occurs.

When finding ISM/RDMA devices, device not found is not a real error, as
not all machine have ISM/RDMA devices. Failures after device found, when
initializing device or when initializing connection, is real errors, and
should be store in ini->rc.

SMC_CLC_DECL_DIFFPREFIX also is not a real error, as for SMC-RV2, it is
not require same prefix.

Guangguan Wang (2):
  net/smc: change function name from smc_find_ism_store_rc to
    smc_find_device_store_rc
  net/smc: correct the reason code in smc_listen_find_device when
    fallback

 net/smc/af_smc.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

-- 
2.24.3 (Apple Git-128)


