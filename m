Return-Path: <netdev+bounces-19416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8F775A98C
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 10:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BF151C213D9
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 08:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1522E199E4;
	Thu, 20 Jul 2023 08:38:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A815361
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 08:38:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F7926AC
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 01:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689842330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uD8lCSCMjSGZH3wOzVWgkovAsvnWHdzdpIGokpNxVkQ=;
	b=S9P1ZoXXpFvB/BZiS4LGw8U8lQnx8/s2PKdpNHj+i2nGmsmaaV3sxNVSccTdN5CEhxHFY0
	j/0rG2Bg0tIeJifGdqy0NlwxBBMb+4OY5DxqDBrK34eJErJYEezDJjjjXq8NtLy/S2OfOH
	iErBBpJisaCgeHfqFDfykPfd4UIbLFY=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-227-MUO2sSHNPdOz-BhsdqPtqg-1; Thu, 20 Jul 2023 04:38:47 -0400
X-MC-Unique: MUO2sSHNPdOz-BhsdqPtqg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4532E1C04B62;
	Thu, 20 Jul 2023 08:38:46 +0000 (UTC)
Received: from dell-per430-12.lab.eng.pek2.redhat.com (dell-per430-12.lab.eng.pek2.redhat.com [10.73.196.55])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DAEEBF6CD8;
	Thu, 20 Jul 2023 08:38:41 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alvaro.karsz@solid-run.com,
	maxime.coquelin@redhat.com
Subject: [PATCH net-next v4 0/2] virtio-net: don't busy poll for cvq command
Date: Thu, 20 Jul 2023 04:38:37 -0400
Message-Id: <20230720083839.481487-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi all:

The code used to busy poll for cvq command which turns out to have
several side effects:

1) infinite poll for buggy devices
2) bad interaction with scheduler

So this series tries to use cond_resched() in the waiting loop. Before
doing this we need first make sure the cvq command is not executed in
atomic environment, so we need first convert rx mode handling to a
workqueue.

Note that, this doesn't try to solve the case that a malicous device
may block networking stack (RTNL) or break freezer which requries more
thought to gracefully exit and resend the commands.

Please review.

Changes since V3:

- Tweak the comments
- Tweak the changelog to explain the rx mode lost after resuming.
- No functional changes

Changes since V2:

- Don't use interrupt but cond_resched()

Changes since V1:

- use RTNL to synchronize rx mode worker
- use completion for simplicity
- don't try to harden CVQ command

Changes since RFC:

- switch to use BAD_RING in virtio_break_device()
- check virtqueue_is_broken() after being woken up
- use more_used() instead of virtqueue_get_buf() to allow caller to
  get buffers afterwards
- break the virtio-net device when timeout
- get buffer manually since the virtio core check more_used() instead

Jason Wang (2):
  virtio-net: convert rx mode setting to use workqueue
  virtio-net: add cond_resched() to the command waiting loop

 drivers/net/virtio_net.c | 59 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 4 deletions(-)

-- 
2.39.3


