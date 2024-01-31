Return-Path: <netdev+bounces-67416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA9D84341D
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 03:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A135A1C214B9
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 02:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6055DF70;
	Wed, 31 Jan 2024 02:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JAo9tWTn"
X-Original-To: netdev@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAF7DF6E
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 02:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706669166; cv=none; b=pALQSxKaGtQhYF1vEu3Yoz27Ha0bALrfU0zsQN1iPMNVjAOkGxua4oE16s9T98bEFH/Zd/qXnEa1fPVEko8rWu0y67p0r7cWoB+6YWRUtWOqrE9TPMGmQauCHUEQrbC5VcVNIQbZxdsSfRq0T3zivsda9+0dpxsRxnRGF0/Z0mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706669166; c=relaxed/simple;
	bh=LqNTI0RdHPb+OTAOKc6/qTP+mOuVq6DWwO3owjjfP/0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ae0b411zwwyTExDtQ6jJa7JWPBqzi8ehdIY1HfegZ2Db1uDS91OR1W28jhWC8julewQfZt4GPeTEf+okf4CzZtNsjNnVY0JMw1OUubYY2M6oP5vPSD1QIunWEMoDlgryra9kqgCxtzXvnJIv8dDzjbnQPeU+IV2rQY8fegxD18M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JAo9tWTn; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706669160; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=IzQD3tMg1mXC5+7/I9iCORFUJC8bBiJ6iN1YWqN42M8=;
	b=JAo9tWTnyHSFUm8+uOvdFglA3pvcu9YvOntHJ3++rtaVe8+b2Zd4tQ6auCi37MetPfiJn2K3YtgA2q8vScx3aRESaclf7XsReBiVhEB1VqdVBQVSDcoyBe6S4TEjzNXlc7PJyOlLB1riQgxh139pK8MdnK4siHKEsre9lmk+W10=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W.hnzCY_1706669159;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.hnzCY_1706669159)
          by smtp.aliyun-inc.com;
          Wed, 31 Jan 2024 10:46:00 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v2 0/6] virtio-net: support device stats
Date: Wed, 31 Jan 2024 10:45:53 +0800
Message-Id: <20240131024559.63572-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 80d9c8e6c6fe
Content-Transfer-Encoding: 8bit

As the spec:

https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82

The virtio net supports to get device stats.

Please review.

Thanks.

v2:
    1. fix the usage of the leXX_to_cpu()
    2. add comment to the structure virtnet_stats_map

v1:
    1. fix some definitions of the marco and the struct



Xuan Zhuo (6):
  virtio_net: introduce device stats feature and structures
  virtio_net: virtnet_send_command supports command-specific-result
  virtio_net: support device stats
  virtio_net: stats map include driver stats
  virtio_net: add the total stats field
  virtio_net: rename stat tx_timeout to timeout

 drivers/net/virtio_net.c        | 536 ++++++++++++++++++++++++++++----
 include/uapi/linux/virtio_net.h | 137 ++++++++
 2 files changed, 613 insertions(+), 60 deletions(-)

--
2.32.0.3.g01195cf9f


