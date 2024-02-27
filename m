Return-Path: <netdev+bounces-75213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C156868A57
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 09:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 956B71C20E24
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 08:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A79A55E68;
	Tue, 27 Feb 2024 08:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Kg1XSrUD"
X-Original-To: netdev@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C4254672
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 08:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709020991; cv=none; b=Jbcxe6DEmLrweSNNxILDERJ3saQ5RbrBOQeWv8GQvt0u9hrYrgt5wlAtjeom/3DoJ3ZBx2cRWd2KH9bRej0uHCJSjLz9N/s03xD8A6JWhYkvx1aBJ8obpDy7CwKCVuul9WtMpy8kJMx8qkaITWQxwq61wadQuXnQWlGz7ww722E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709020991; c=relaxed/simple;
	bh=l41UL7k20MTWTJPiOI4CdZzWlWejzxfsjB+ODfniRO8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VgoShf2vNCsImjdsWSkEiEUkXSB+OXQwmiTi7/etCKiZ/6PQE46xjZiWy699HPs1n7fjGKB4J9Sjp2Jo37Wm8+KcBEl45v+NuYmLpi1JUMfdgCupyYAIV36lxlFKBW+tQcz2vdJVZplXO7tJEc5iXlpwR5/uAi4GVVWx2OTKzeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Kg1XSrUD; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709020985; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=PeZDCQuPDHNV7xVX4SjX74E67tumQ0ULokf7j6r8IgY=;
	b=Kg1XSrUD5YkpXoPLsGgiEOGOtDzqGxXhTI7NNQI85auEJcAEG0Puff1R8VaBxH4pR5uWZBBLmyRoBsITbSZyIwJiLkMfhFJRgygmIUtNzg7SaSAsT0bGM9Cob81IlGVTYEahnQ0HtUdF1OBjNyZlNyo88FEG3SYhl7vVeyImbsU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W1LyZ7s_1709020983;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W1LyZ7s_1709020983)
          by smtp.aliyun-inc.com;
          Tue, 27 Feb 2024 16:03:04 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net-next v3 0/6] virtio-net: support device stats
Date: Tue, 27 Feb 2024 16:02:57 +0800
Message-Id: <20240227080303.63894-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: cacd048f99e7
Content-Transfer-Encoding: 8bit

As the spec:

https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82

The virtio net supports to get device stats.

Please review.

Thanks.

v3:
    1. rebase net-next

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


