Return-Path: <netdev+bounces-13895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FCC73DB14
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 11:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C5101C204FA
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 09:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DAC6FA1;
	Mon, 26 Jun 2023 09:17:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0009F63DC
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 09:17:45 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16ADC198A;
	Mon, 26 Jun 2023 02:17:44 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1099)
	id 609A621C3F2C; Mon, 26 Jun 2023 02:17:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 609A621C3F2C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1687771063;
	bh=rOKa5FGhb2DtzgJz+qz23ZNtLP6CMkP1uTRy0DPG8qg=;
	h=From:To:Cc:Subject:Date:From;
	b=JPMkNncr0F9+kMGbGy3r+uJw6J5PmxpUkfNh75rAVDhqIn94+OaL/rYidImL7t5kd
	 XDk3QI158Q0CzvAJkiILrBXFQE4RFN0Bvm7UNoqZwFzC7VU6LQVDaa+Xtw2LAB46rU
	 2dU7ysn4L57YNwJ/jh6a59rKn13kHmWRRYbYNwAA=
From: souradeep chakrabarti <schakrabarti@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	longli@microsoft.com,
	sharmaajay@microsoft.com,
	leon@kernel.org,
	cai.huoqing@linux.dev,
	ssengar@linux.microsoft.com,
	vkuznets@redhat.com,
	tglx@linutronix.de,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: stable@vger.kernel.org,
	schakrabarti@microsoft.com,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Subject: [PATCH 0/2 V3 net] net: mana: Fix MANA VF unload when host is unresponsive
Date: Mon, 26 Jun 2023 02:17:38 -0700
Message-Id: <1687771058-26634-1-git-send-email-schakrabarti@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>

VF unload gets stuck in MANA driver, when the host is not responding.
The function mana_dealloc_queues() tries to clear the inflight packets,
and gets stuck in while loop. Another problem in this scenario is the
timeout from hwc send request.
These patch add fix for the same.
In mana driver we are adding a timeout in the while loop, to fix it.
Also we are adding a new attribute in mana_context, which gets set when
mana_hwc_send_request() hits a timeout because of host unresponsiveness.

Souradeep Chakrabarti (2):
  net: mana: Fix MANA VF unload when host is unresponsive
  net: mana: Fix MANA VF unload when host is unresponsive

 .../net/ethernet/microsoft/mana/gdma_main.c   |  4 +++-
 .../net/ethernet/microsoft/mana/hw_channel.c  | 12 +++++++++++-
 drivers/net/ethernet/microsoft/mana/mana_en.c | 19 +++++++++++++++++--
 include/net/mana/mana.h                       |  2 ++
 4 files changed, 33 insertions(+), 4 deletions(-)

-- 
2.34.1


