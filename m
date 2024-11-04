Return-Path: <netdev+bounces-141439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D94909BAECC
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 09:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161C01C20BA3
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 08:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0EC1AD3F6;
	Mon,  4 Nov 2024 08:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iO89sIld"
X-Original-To: netdev@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551B91AB6D4;
	Mon,  4 Nov 2024 08:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730710632; cv=none; b=pwA+Zc/HGn0rAUzM+zwnalz99wvjTWoVELB9mnr4whpFO3cct5betE+ypFvJM3MfHBreKT5H4/wx4BGFxi1cotoe8yDVYzUnI0zvCNUNS1SZ1nLTk8y701086KkLuYgYO3F+sRYlc1nSsyp0yZTlIHoSK4f2aXaL/DayDlV07zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730710632; c=relaxed/simple;
	bh=f7BTja9oKOZtYZkvpN8Dt89RsQJtgfIyZkdIpLDN0KY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LA555DRrh2LDa9F5f39XlcV2VyhidocvuJqViBOKJJM2TvSH1plTHahaID5WgtxsJ3KnF+NHDwmAShom3aUUMqMP3SIbmnB9RYmxJnaDu0xDJTMySzsIFSmC3SME6rxpUgwa4GEMcamFb693uy+mlf2FOSSxgiGONdMWCI3GgMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iO89sIld; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730710627; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=9T27x571qL2VW+tYc6sKeCTtuwJS10Bq4YWjUFrRQ4w=;
	b=iO89sIld6WBRFdrhbf4GUl9uNApGsQvkwYRw/+8R9TMx3dHx9f1BZawEbW/8wuK1BGrAJae7SFcapzCu90bbTvwaRHajwSgCf8gU7x0zWUApC55WUV2KRZl/lRIs1X5mmBSBd3P3FYd2vQ/UaVDsxCWqkWlmOKpW5EbCDSaOnnE=
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WIdkVm2_1730710626 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 04 Nov 2024 16:57:07 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@daynix.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/4] virtio_net: Make RSS interact properly with queue number
Date: Mon,  4 Nov 2024 16:57:02 +0800
Message-Id: <20241104085706.13872-1-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With this patch set, RSS updates with queue_pairs changing:
- When virtnet_probe, init default rss and commit
- When queue_pairs changes _without_ user rss configuration, update rss
  with the new queue number
- When queue_pairs changes _with_ user rss configuration, keep rss as user
  configured

Patch 1 and 2 fix possible out of bound errors for indir_table and key.
Patch 3 and 4 add RSS update in probe() and set_queues().

Please review, thanks.

Philo Lu (4):
  virtio_net: Support dynamic rss indirection table size
  virtio_net: Add hash_key_length check
  virtio_net: Sync rss config to device when virtnet_probe
  virtio_net: Update rss when set queue

 drivers/net/virtio_net.c | 119 ++++++++++++++++++++++++++++++++-------
 1 file changed, 100 insertions(+), 19 deletions(-)

--
2.32.0.3.g01195cf9f


