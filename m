Return-Path: <netdev+bounces-104946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DE890F3E2
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 18:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 757F3B22F6B
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 16:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBC8153814;
	Wed, 19 Jun 2024 16:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VweBqLjn"
X-Original-To: netdev@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F640153573
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 16:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718813959; cv=none; b=Opo4ujSYGf2Xy814R3cRj+0hemcJYA6oZSmd5LRCUB9IyMbBzDUi5rqWVEIgvC1YqnDd/J8tN16irKJyb0vogzUBVStTuaSmj9SngpR/WIvOq0IywvrvAVt6KJsSrL1p9YROaSWHpiBk4FCI+kRPNNHMXY7B4APCViqvfVOMCVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718813959; c=relaxed/simple;
	bh=RqHFDtHtQE9Grerc9O5k5bpYaEdw/SFIbPS03zp2pJo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qEhsj766bpAIG0Eax6Ldeg1vstYWcU3tgCj1L/f49MVSMVfFoyowm4WlRbCGG38Hnd88kQ4opn5evGwYEURLibWHRYFXOSD7Y4mxah4sA1jKYNRkIJYItTBqzSxfRomLhdunf62VugdombsU3sIfvlwO2Kx0JbrVwMJvU/SvXDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VweBqLjn; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718813949; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=HIT6NKrwkLUJi2AMHNNv5UDY3B4A5R1UQJX3u/TaLLU=;
	b=VweBqLjnYTA80hRn8Lfn9GRFc63fUT4qZOiktoLsl/Hz/qBKFqVqBmLLX0+Zwm8nqI9pvfNUxaHLO9EpQe8lOS8WMZ2NEz2I1cxchZ+/SfcAeBScI5Ln1CdIYCQuvOZDcVRB8lefaOivlbJ2mqu7fE3KdEFeTwdQkbrMZ3N00HY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W8olDoZ_1718813948;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W8olDoZ_1718813948)
          by smtp.aliyun-inc.com;
          Thu, 20 Jun 2024 00:19:08 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v4 0/5] virtio_net: enable the irq for ctrlq
Date: Thu, 20 Jun 2024 00:19:03 +0800
Message-Id: <20240619161908.82348-1-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ctrlq in polling mode may cause the virtual machine to hang and
occupy additional CPU resources. Enabling the irq for ctrlq
alleviates this problem and allows commands to be requested
concurrently.

Changelog
=========
v3->v4:
  - Turn off the switch before flush the get_cvq work.
  - Add interrupt suppression.

v2->v3:
  - Use the completion for dim cmds.

v1->v2:
  - Refactor the patch 1 and rephase the commit log.

Heng Qi (5):
  virtio_net: passing control_buf explicitly
  virtio_net: enable irq for the control vq
  virtio_net: change the command token to completion
  virtio_net: refactor command sending and response handling
  virtio_net: improve dim command request efficiency

 drivers/net/virtio_net.c | 309 ++++++++++++++++++++++++++++++++-------
 1 file changed, 260 insertions(+), 49 deletions(-)

-- 
2.32.0.3.g01195cf9f


