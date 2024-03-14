Return-Path: <netdev+bounces-79809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B738C87B9C1
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 09:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 218B32832EA
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 08:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD8A6BB48;
	Thu, 14 Mar 2024 08:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="R7ST0AUg"
X-Original-To: netdev@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEF543ADD;
	Thu, 14 Mar 2024 08:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710406506; cv=none; b=Z3BnLa6+ao97G4ryxdOZaJmG1KXK91/JSb7C0qgAWVTrDVx8NqVnZ7008YeBi+mZsnB4XFjgwHe/PzqbY2pi8VxN7a5wtSZPBk9+f5lZYr5EheppurLcB4VhhjGKcabEh615zXfG3RfBxM6lcLGc3Ov7SiprvNoBhbTzgVzZDG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710406506; c=relaxed/simple;
	bh=g7MDnwJa4sMN0bQaStBd6SvmxSktKfjJRuOwAzBq5eQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q5tJanDDsLop+VxTENBAzusKu27G83pBVTHz7uFJxzktVmD+0v8+U6gZN2a2GipesxDugw73C1FGJ8EMll7hkq+10GFSekDKmgpKqU+nyzEnrg7QVnhH3c0OY+3zYf+In7WEBAnk2yjnD/hx3R0RaKko+qJ0HeWClnTbWs/jPQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=R7ST0AUg; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710406501; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=v5R56GJm1wCv4DzgzfQDshrevtSBDuWhu6Ql2bvSzys=;
	b=R7ST0AUg5whcHAUkVhz1RcSmTaFtG1D/r4Yh97Xzja9LrWaq6AyIyRHyPwk1iw6ubdmcdpq0L0POlm/PGfnOXim/r1a3zS8kly9+n8AM1TqnvJAPTZih9eF+G6fZG9BBKFImtPGEyMWKki/+xaajOlXj9Fj6xp6vzTpprtRt/Ao=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W2S1OCB_1710406499;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W2S1OCB_1710406499)
          by smtp.aliyun-inc.com;
          Thu, 14 Mar 2024 16:55:00 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@google.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next v4 0/8] virtio-net: support device stats
Date: Thu, 14 Mar 2024 16:54:51 +0800
Message-Id: <20240314085459.115933-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 76259b0090f3
Content-Transfer-Encoding: 8bit

As the spec:

https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82

The virtio net supports to get device stats.

Please review.

Thanks.


v4:
    1. Support per-queue statistics API
    2. Fix some small problems in last version

v3:
    1. rebase net-next

v2:
    1. fix the usage of the leXX_to_cpu()
    2. add comment to the structure virtnet_stats_map

v1:
    1. fix some definitions of the marco and the struct





Xuan Zhuo (8):
  virtio_net: introduce device stats feature and structures
  virtio_net: virtnet_send_command supports command-specific-result
  virtio_net: support device stats
  virtio_net: stats map include driver stats
  virtio_net: add the total stats field
  virtio_net: rename stat tx_timeout to timeout
  netdev: add queue stats
  virtio-net: support queue stat

 Documentation/netlink/specs/netdev.yaml | 105 ++++
 drivers/net/virtio_net.c                | 708 +++++++++++++++++++++---
 include/net/netdev_queues.h             |  27 +
 include/uapi/linux/netdev.h             |  20 +
 include/uapi/linux/virtio_net.h         | 137 +++++
 net/core/netdev-genl.c                  |  23 +-
 tools/include/uapi/linux/netdev.h       |  19 +
 7 files changed, 962 insertions(+), 77 deletions(-)

--
2.32.0.3.g01195cf9f


