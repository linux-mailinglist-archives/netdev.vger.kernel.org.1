Return-Path: <netdev+bounces-97710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 681828CCD44
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 09:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99D581C20F8D
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 07:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E57813CAB2;
	Thu, 23 May 2024 07:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pzmgM5Lj"
X-Original-To: netdev@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C6239FD6
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 07:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716450423; cv=none; b=J/Jz6Trnp7jUVEMw69YtC/Ri1DAZfYezFlhIXVMUOpXRbeHkg/5oLuW9wsnkebGV/BPtu2N20oFDWHuU+Q8pgfhHcc8V9xgSXjBIrZXZfEim6kkOdmozWQKVYl7xBw36Ywrp0HUu/Dtt3c6LxaL0icTd9reBfqvL0Z45r4fHabw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716450423; c=relaxed/simple;
	bh=uiw/KIo7ZzS5LrObk9p7ZQSl8SME5Wqkks2CezeF2pw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I5RIbNXJmfPYZ7SZKqj4yDhEQg6NST+Iy2OHsAilwAEw7GhEDYSAdYq6eE6E+xwdW5AH/QtZM/jI+yRl5OF6pWn1kkk5qlt4UFoaMsrgIjFYON4NYqvmPyXyZz5YkvwleuLBgcPzWeB7u6T1Z3emAFM36i4AXXBPP59HkPNiBi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pzmgM5Lj; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716450413; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=AqDQzHp4jZumxGfK3oZba/CK9i50zN0jYDJfmJs8+iY=;
	b=pzmgM5Lj69dDH7AaQ+z+s539EBFn4sQjUpjU/g6HQzdKbxmOKy4/cAY9JGDO3PdOBE/rVMo688mBcFCgOptUwn7u7/Hd819UNrhCxig7OBL1EcrHnLL07GJfuKweBr7woSV/wQKEPTCUg7D0xJnLQ5vXTF+y0knH8XCRNlSlSD8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W724Ck0_1716450411;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W724Ck0_1716450411)
          by smtp.aliyun-inc.com;
          Thu, 23 May 2024 15:46:52 +0800
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
	Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH net v2 0/2] virtio_net: fix lock warning and unrecoverable state
Date: Thu, 23 May 2024 15:46:49 +0800
Message-Id: <20240523074651.3717-1-hengqi@linux.alibaba.com>
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

Changelog
=======
v1->v2:
  Patch(2/2): rephase the commit log.

Heng Qi (2):
  virtio_net: fix possible dim status unrecoverable
  Revert "virtio_net: Add a lock for per queue RX coalesce"

 drivers/net/virtio_net.c | 55 ++++++++++------------------------------
 1 file changed, 13 insertions(+), 42 deletions(-)

-- 
2.32.0.3.g01195cf9f


