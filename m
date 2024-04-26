Return-Path: <netdev+bounces-91551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A15968B30DC
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 08:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CD871F21E2A
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 06:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1787213BC3C;
	Fri, 26 Apr 2024 06:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="la+sCBQK"
X-Original-To: netdev@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3975313AD29
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 06:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714114509; cv=none; b=aCD2nEGl9dcJGdfJQ3QvrVKQfIHiNr2mbMwcfAfEyqsNy2MtzbKzzHJmnhqH8Ik5TPx3mK5k44kkclkbHlagREJ0+CZxPUnR03JnGzVBivnZGsAi+i7Scj3QcZROWxLkYkWoX7QwFYNTX/mXpEncbpSU8Lf6cGJAqlUfIMptDAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714114509; c=relaxed/simple;
	bh=/6sjowak/lauryCfOTb5rKSmJVlKqeh6jTSIGcjwXC8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IsJTej8jVND6kQZxQMBxGhBpIztqGaDv+dft96N80IPOp+hWX4YMT6saHsBG3zXGT8EL5oJFb+HpHPli7b8jvn1LNf448r8vAHLGBomPskKZH44CK1cXo5W+kwGQaoBG3NEF0n4p+cvoW9D65WbKNZZevT+NQWzgvNj8FTfwBsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=la+sCBQK; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714114483; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=UN/CLV4Scst1cNxtfpCHdnfclV3O9TGy+78D8TsHLvg=;
	b=la+sCBQKw5cnLNreZDc4Nh3wloih8qwEro4MiO3V+iX/m2ZwdYIvWz/bmH9yCpE0fnN1YKGQ8rU5jd0mcFZX4WNliSbKEORqLmTyywsIF51SkkTrb5usTKQlTRKay55HSUXBV3AfmdoWlNfvzCZEcGefNmg57i3SiC586SO1vyg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W5ILuwH_1714114481;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W5ILuwH_1714114481)
          by smtp.aliyun-inc.com;
          Fri, 26 Apr 2024 14:54:42 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 0/2] virtio_net: support getting initial value of irq coalesce
Date: Fri, 26 Apr 2024 14:54:39 +0800
Message-Id: <20240426065441.120710-1-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 from Xuan: the virtnet cvq supports to get
result from the device.

Patch 2 reuses the VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET cmd to
get init coalesce value.

Changelog
==========
v1->v2:
  - Update patch1's commit log.

Heng Qi (1):
  virtio_net: get init coalesce value when probe

Xuan Zhuo (1):
  virtio_net: introduce ability to get reply info from device

 drivers/net/virtio_net.c | 92 ++++++++++++++++++++++++++++++++++------
 1 file changed, 78 insertions(+), 14 deletions(-)

-- 
2.32.0.3.g01195cf9f


