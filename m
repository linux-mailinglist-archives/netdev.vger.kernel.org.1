Return-Path: <netdev+bounces-18420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8843D756D6B
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 21:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42EE82813F8
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 19:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82750C159;
	Mon, 17 Jul 2023 19:35:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7779F253CD
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 19:35:51 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD3FF94;
	Mon, 17 Jul 2023 12:35:49 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1004)
	id 47DE521C79F7; Mon, 17 Jul 2023 12:35:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 47DE521C79F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1689622549;
	bh=bRJBnZIyqX5lWmieXAT5ZWBktdQw7iN0MiN86gS1bd0=;
	h=From:To:Cc:Subject:Date:From;
	b=FSes38XLYRvwpgBOLXqCMKTllE5Fn+meWS17Z7wLy4WuBJ2bJZ3G+l6hAcXCJ3F25
	 azrdSglq7K4YZOdoKS3vngSVIaD4GS6ZIofZXh254RVWJAibOqPV2C+dLX4bDL6zfB
	 IYQ7LEUPISs1Xzs+/vopNwzUNYYimufW4X8f+q/8=
From: longli@linuxonhyperv.com
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Leon Romanovsky <leon@kernel.org>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Shachar Raindel <shacharr@microsoft.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-rdma@vger.kernel.org,
	Long Li <longli@microsoft.com>
Subject: [PATCH net-next v5 0/2] net: mana: Fix doorbell access for receive queues
Date: Mon, 17 Jul 2023 12:35:37 -0700
Message-Id: <1689622539-5334-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

This patchset fixes the issues discovered during 200G physical link
tests. It fixes doorbell usage and WQE format for receive queues.

Long Li (2):
  net: mana: Batch ringing RX queue doorbell on receiving packets
  net: mana: Use the correct WQE count for ringing RQ doorbell

 drivers/net/ethernet/microsoft/mana/gdma_main.c |  5 ++++-
 drivers/net/ethernet/microsoft/mana/mana_en.c   | 10 ++++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

-- 
2.34.1


