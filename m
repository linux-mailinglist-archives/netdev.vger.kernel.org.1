Return-Path: <netdev+bounces-114930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4326E944B42
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74E111C2196E
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 12:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B321A00F7;
	Thu,  1 Aug 2024 12:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sGorMisd"
X-Original-To: netdev@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD89187FF8
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 12:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722515265; cv=none; b=uPjT7Zbrr8Di0YmZMIQZAEdhKBqCZUsokd5GdcYYDHCWYrwdV40ouU6V4KDP3of6pIdvuUv8fWak6pwPEVdPkG11Gfn+/QusanDZzp9Qm3HA+QLgCwva5JnuaD832d1L2zDBGcIzY8ZHSFWgG1kMQeX3Z1fe04Wuldc3A/l4BdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722515265; c=relaxed/simple;
	bh=SxDemmGaN3st80uf3+JBuqcgoUpXJWdaS/PqrX0QwrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=itrYR+lL9MbTPN/YoB35EZbJXdjcizGfXmCA9vuiFcZznBJZVfcmisaXMbuu6zAEC/KnvSxTKNwEht6sNj22QUMab9YTlrlzfl/ht9OTMwhU7bUm6mHRS86ynXpCqoe2DfOcoVWJ8WK7Th76SJAUeTJfaEu7FwAHghJbmMZWYXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sGorMisd; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722515260; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=7hyKvqh5Dm/qJywKT8SxFRy4+uoyGMo/T8N8S928GPo=;
	b=sGorMisdvavJv810/svpY5uBc3LLKdndeuoLPsqluPkWYJxuREnqicjZV2Nezcb3B0qNpvYPzRBFHXocX5G8qfgqzWLAZ8WX7hw3XWaKxAoabr58TWfX38LLHg8itSDF48/SoDgZOrudaxnDPUIFs5KiPSD+DJ3ViaJ6KZSv5Hs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0WBtjk1e_1722515259;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0WBtjk1e_1722515259)
          by smtp.aliyun-inc.com;
          Thu, 01 Aug 2024 20:27:40 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net v3 0/2] virtio-net: unbreak vq resizing if vq coalescing is not supported
Date: Thu,  1 Aug 2024 20:27:37 +0800
Message-Id: <20240801122739.49008-1-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, if the driver does not negotiate the vq coalescing feature
but supports vq resize, the vq resize action, which could have been
successfully executed, is interrupted due to the failure in configuring
the vq coalescing parameters. This issue needs to be fixed.

Changelog
=========
v2->v3:
  - Break out the feature check and the fix into separate patches.

v1->v2:
  - Rephrase the subject.
  - Put the feature check inside the virtnet_send_{r,t}x_ctrl_coal_vq_cmd.

Heng Qi (2):
  virtio-net: check feature before configuring the vq coalescing command
  virtio-net: unbreak vq resizing when coalescing is not negotiated

 drivers/net/virtio_net.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

-- 
2.32.0.3.g01195cf9f


