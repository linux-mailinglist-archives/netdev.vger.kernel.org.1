Return-Path: <netdev+bounces-97487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7DE8CB9EC
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 05:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AA90282CCE
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 03:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485873B2BB;
	Wed, 22 May 2024 03:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DaatzEFr"
X-Original-To: netdev@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575D11103
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 03:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716349556; cv=none; b=G4NvhNkE+8EEfwAjpNsijK8/QwYTpRdP9LwZ1GO5vA03NRtb//LkXqrhkY7i1yZMaC7vZy9/eB/wbtuWv/idXEAfrIDXgPUchIhHN2pCRGWeaekWV6gazl7OBVLHXmeLe9SSscJ6OEaVyueu/thj5NL0Tk7MODzy44rQ04V6dvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716349556; c=relaxed/simple;
	bh=fj28zLV0cyC3gCv41/tt+bGVfoW1qBQetpQHpDRptU0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N2/HsXGsN02wruLpBrxIRbB/dHaxkN+x95ED9vwV6o2tKh4ayxvf+td/0ZSqJNbIQe2ULuQ5p9afKb39lN5ZAYGO2/wW/3z/PAk8cjn4rWPMckGbgPyXzssO/lUSiFUbAS4LRzXxZ65Lz+gKQsmr1UXo2Zras4DmeXd2AA4FWF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DaatzEFr; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716349550; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=AMGX0af6ZOTVD+jIX9wGqw68iZttX4BJbQ9DJvsjByQ=;
	b=DaatzEFrZN/7d8baUqbBqpYG2xczJeRTuYmyrptk7DkAPEkf3NggQXehtDr3f1EgPG+oc/MH9/1Kk5KWB9R31o3UvxdjKxkfkKw8DuRHTfe/gJcjuYwtn2G78Yd7uFuTqRrZgKRquaG3bSHOjb9mXhz6Fao8eJufniDKO6grc0M=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W6zl.xR_1716349549;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W6zl.xR_1716349549)
          by smtp.aliyun-inc.com;
          Wed, 22 May 2024 11:45:50 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net 0/2] virtio_net: fix lock warning and unrecoverable state
Date: Wed, 22 May 2024 11:45:46 +0800
Message-Id: <20240522034548.58131-1-hengqi@linux.alibaba.com>
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
nested locks and when there is a maximum number of queues may also
be problematic, so try to remove the dim_lock.

Heng Qi (2):
  virtio_net: fix possible dim status unrecoverable
  Revert "virtio_net: Add a lock for per queue RX coalesce"

 drivers/net/virtio_net.c | 55 ++++++++++------------------------------
 1 file changed, 13 insertions(+), 42 deletions(-)

-- 
2.32.0.3.g01195cf9f


