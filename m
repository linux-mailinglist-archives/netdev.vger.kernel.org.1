Return-Path: <netdev+bounces-98582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EDE8D1D44
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 15:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DAA61F2294A
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 13:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7330516F0EF;
	Tue, 28 May 2024 13:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DOdE9ziJ"
X-Original-To: netdev@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E310017C7F
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 13:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716903683; cv=none; b=kbxvi67LxLa5eO4hnTZ3E1cMJKUnKDQ/oTNQdTQjs2KnlF0PNu9qH9RD6i1SYeD6IvmJfLxT/u7cvMg58kUYSrOdwjPk3/g9JcUudR90lX2fWq4GG7E6Q0D0mjYECC3q9uX/trPx7JJJ9/qKl10mcwObORbSj3meH9qP6Nf/eXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716903683; c=relaxed/simple;
	bh=4JwkwNBRz7L0UaHG0UDCH3rSnAThYksnUd+AhfFNUpU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T469TeL+3dj3GH+FvyGO6c38zE6dQdagaIlkV1w4yCx4waqs1JBSS3rTzaKZBBcaHwkPpSEDo/Qm3pfC0DutX4jSa1ysFK16qSW6xmF6IJxWnlhLKseA4px5lftU2V5TO55Ydw2iDuvHLUeMgv8pU4rG5dOj4XLuu6CW9rPNFdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DOdE9ziJ; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716903678; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=uU5lQpSZOUHuKyUxt8pMsCKUNNEniBWpJNvML8B57u8=;
	b=DOdE9ziJ3mS0TMf+NJuBROem6IKlb/8AWA9X0kYd85buHFJHUQSloQk0N1Ke6tTrnnNezI0/05zk1BJHzP0ffpXpHvsD50DZShycYMe2qtAM7kc7v/yOutqPocHGjx85CXaW0TzlH//4rOLO2ArtLE7IVcGOAHadh9LR01ATG8g=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W7PjPho_1716903676;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W7PjPho_1716903676)
          by smtp.aliyun-inc.com;
          Tue, 28 May 2024 21:41:17 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net v3 0/2] virtio_net: fix lock warning and unrecoverable state
Date: Tue, 28 May 2024 21:41:14 +0800
Message-Id: <20240528134116.117426-1-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 describes and fixes an issue where dim cannot return to
normal state in certain scenarios.

Patch 2 attempts to resolve lockdep's complaints that holding many
nested locks.

Changelog
=======
v2->v3:
  Patch(2/2): Refactor code instead of revert the patch.

v1->v2:
  Patch(2/2): rephase the commit log.

Heng Qi (2):
  virtio_net: fix possible dim status unrecoverable
  virtio_net: fix a spurious deadlock issue

 drivers/net/virtio_net.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

-- 
2.32.0.3.g01195cf9f


