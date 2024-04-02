Return-Path: <netdev+bounces-83980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 154CA8952A2
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 14:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45B0B1C21D61
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 12:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D065478274;
	Tue,  2 Apr 2024 12:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qM9wCsAA"
X-Original-To: netdev@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C4776F17
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 12:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712060000; cv=none; b=Z0HwOn3kYZyyAhb1WU1uYcRtg8Yo4Fb+TA2RsX22X/WY761wd4QgK6JUR8VUaXKDVZbv51IIW2DRqVEdOXO+UyrWnOs4SttGKoVUfL7fraf27fDSw0IuMNb+dqOyyggYQHC1jlFxOotyf7cO3fQqw1MNx68egJVE7WNp57CF9bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712060000; c=relaxed/simple;
	bh=XK4OTT6VC+B+XG7SIITThVz58AwJg8X2QabjnWlsH6A=;
	h=From:To:Cc:Subject:Date:Message-Id; b=d6/RPwEeB27hJYv9/zCz2bVP+thyoLwq0JPdK086pDrRbSkQXDP7eVB0b9P8MX58p8+kkbdgIsy39HORFdtNcXGzuaRNn268fkZLyibSDKxduLW7pWwfKgTt+QwRap7Ht+R5rnAHbO9kBBmQD1Yix1XrwbpMwT50JgrncskDn74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qM9wCsAA; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712059990; h=From:To:Subject:Date:Message-Id;
	bh=icRIIs4TR8+IsrlyXgj+2nMZMjoj3shYkTYVppy93Vs=;
	b=qM9wCsAAg5Ja5uVVNiDH4V9Coh+pTwKRvGCojZ0vA6j8mrgLTeSbZOnlG9q6DvQJAQxEBAELhz2z7tF4g48iOvLD9GBkAIGjGYVh9OWIweXtZcsEZBoaKc71lylk/AqtlS94D9DOEWKP17QgxA1kAA0O67EnkPBQjNuO+UIi2oA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W3oLGcp_1712059988;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W3oLGcp_1712059988)
          by smtp.aliyun-inc.com;
          Tue, 02 Apr 2024 20:13:09 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net-next v3 0/3] ethtool: provide the dim profile fine-tuning channel
Date: Tue,  2 Apr 2024 20:13:05 +0800
Message-Id: <1712059988-7705-1-git-send-email-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The NetDIM library provides excellent acceleration for many modern
network cards. However, the default profiles of DIM limits its maximum
capabilities for different NICs, so providing a way which the NIC can
be custom configured is necessary.

Currently, interaction with the driver is still based on the commonly
used "ethtool -C". The driver declares its supported parameters based
on .supported_coalesce_params, and implements driver-related custom
restrictions in .set_coalesce and .get_coalesce.

Please review, thank you very much!

Changelog
=====
v2->v3:
  - Break up the attributes to avoid the use of raw c structs.
  - Use per-device profile instead of global profile in the driver.

v1->v2:
  - Use ethtool tool instead of net-sysfs

V1 link:
https://lore.kernel.org/all/1710421773-61277-1-git-send-email-hengqi@linux.alibaba.com/#r

Heng Qi (3):
  ethtool: provide customized dim profile management
  virtio-net: refactor dim initialization/destruction
  virtio-net: support dim profile fine-tuning

 Documentation/netlink/specs/ethtool.yaml     |  29 +++++
 Documentation/networking/ethtool-netlink.rst |   8 ++
 drivers/net/virtio_net.c                     |  79 ++++++++++---
 include/linux/dim.h                          |   7 ++
 include/linux/ethtool.h                      |  16 ++-
 include/linux/virtio_net.h                   |  11 ++
 include/uapi/linux/ethtool_netlink.h         |  24 ++++
 lib/dim/net_dim.c                            |   6 -
 net/ethtool/coalesce.c                       | 159 ++++++++++++++++++++++++++-
 9 files changed, 317 insertions(+), 22 deletions(-)

-- 
1.8.3.1


