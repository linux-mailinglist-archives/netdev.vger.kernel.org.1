Return-Path: <netdev+bounces-101266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 503498FDE8F
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 08:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 621441C2340F
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 06:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C9651021;
	Thu,  6 Jun 2024 06:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QsPzAQJt"
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B485053368
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 06:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717654493; cv=none; b=Dxg4+fxA/VYLkAkFd2FuOSAXcAR1MiCi8GrHLkEoaIX6OTaUPBgHc3JE772RqGWooJwoGJrtXHqM1kwILYnUgqAiDw4LuDQurdJj/2nvJmcOUoZpQNULqQdohnnxYzKoqEcdjF14xTJhwJ63ANmdIfinm7ncODGXYkpeKH+pFJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717654493; c=relaxed/simple;
	bh=xrvHADKsDTHr7KPH2zQHSdBP1Ksjn7xRv9GNLh0HwHg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=seWr8mMUq/BTb3rCMVa8Hol31LQv1vAG+5chKYweEMPffYOxO2Qs4H9DmkO/aExOFpHvZcZ3pjaX+qRrTkj2SjVapdWe/UkA4nHVZEL4ozX+uzotGvi/IYMC6fnMYhE5zX1TUysry0ev3Se6PCg2nKy1vfdr8RlR7Ie4qyYele0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QsPzAQJt; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717654488; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=njTHRzo61ZtNWraSftp5SUzJXkxCSNlH1mu0tyHI/jY=;
	b=QsPzAQJtLvoafeqX8R02kMTXZDV9g8d6rNbHiJZlLYNON+g7vmelaZtYpHZYwEAQjTT/PkWFqUMzp4Jg9np/1jnoxVhz/wJG2l7AmA3MfLuUkMOL+KxH5AWJjO+vq9hR9b134LHGfjWtFklCT2kyH1l1x/q+NN6Tetc36GTxed0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W7xKi8x_1717654486;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W7xKi8x_1717654486)
          by smtp.aliyun-inc.com;
          Thu, 06 Jun 2024 14:14:47 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v3 0/4] virtio_net: enable the irq for ctrlq
Date: Thu,  6 Jun 2024 14:14:42 +0800
Message-Id: <20240606061446.127802-1-hengqi@linux.alibaba.com>
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
v2->v3:
  - Use the completion for dim cmds.

v1->v2:
  - Refactor the patch 1 and rephase the commit log.

Heng Qi (4):
  virtio_net: passing control_buf explicitly
  virtio_net: enable irq for the control vq
  virtio_net: change the command token to completion
  virtio_net: improve dim command request efficiency

 drivers/net/virtio_net.c | 274 +++++++++++++++++++++++++++++++++------
 1 file changed, 232 insertions(+), 42 deletions(-)

-- 
2.32.0.3.g01195cf9f


