Return-Path: <netdev+bounces-86099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BD689D8C6
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 14:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22A2B283963
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 12:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7A912BEAC;
	Tue,  9 Apr 2024 12:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tyJTKwbz"
X-Original-To: netdev@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FD512A171
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 12:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712664213; cv=none; b=h68LCg3tlrDeam6RPanNvcL/SuY0dCpnyqmCpFtWoeZd/5VGJsKUomRtsGneHOrOwlMrjewR0iTOklIlC+NcrshUrP+Xg0baxmyNPi4C857Kjvqg4q07qyOO/GufV/YlTwen6br6ofKK1NCmK9Lpu9LX9AIoqgdndh39+ZZ/od0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712664213; c=relaxed/simple;
	bh=NB2Ik+IT/LX3n0oEUH2mUD/DRjiv4bwnANBVWYCCcuo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=CpxAxjw7m9rVeWEq5K8rZU6P2TrDtGAO7qeQxPM9WpfnF2OtYCx+v4tN4k9q3SKItPvEARy4+UMKCrBN8ELb/eC7RLTB4Uu/KB3jB7XCRPg6OYLai9YZZVdLCpBsAoth7bkJ6/mrSyj98B6Gs8UjpRphGpaIGSTybkglRwQkCUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tyJTKwbz; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712664205; h=From:To:Subject:Date:Message-Id;
	bh=+4cg4XZ/7lUfV+Czo+JlkdDx39ShI/3XveZMjCcdaIs=;
	b=tyJTKwbzCunhjZWE2cGL5JJ7ToqaDlEEMjoaVpUSVE1D+tNbe4kqNMTr/1FTW7i2f0rVX1euHD0qfej8jRbCpsXxxEoG+6niGM29gbCef74yJSkpPaHNRmLqKwtQx0cJqZ3gQtcOvudw/3Dng0tS2cRzKpinHSV/ofILAAa8vl8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W4EdXWf_1712664204;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W4EdXWf_1712664204)
          by smtp.aliyun-inc.com;
          Tue, 09 Apr 2024 20:03:25 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net-next v5 0/4] ethtool: provide the dim profile fine-tuning channel
Date: Tue,  9 Apr 2024 20:03:20 +0800
Message-Id: <1712664204-83147-1-git-send-email-hengqi@linux.alibaba.com>
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
v4->v5:
  - Update some snippets from Kuba, Thanks.

v3->v4:
  - Some tiny updates and patch 1 only add a new comment.

v2->v3:
  - Break up the attributes to avoid the use of raw c structs.
  - Use per-device profile instead of global profile in the driver.

v1->v2:
  - Use ethtool tool instead of net-sysfs

V1 link:
https://lore.kernel.org/all/1710421773-61277-1-git-send-email-hengqi@linux.alibaba.com/#r

Heng Qi (4):
  ethtool: provide customized dim profile management
  linux/dim: move profiles from .c to .h file
  virtio-net: refactor dim initialization/destruction
  virtio-net: support dim profile fine-tuning

 Documentation/netlink/specs/ethtool.yaml     |  33 +++++
 Documentation/networking/ethtool-netlink.rst |   8 ++
 drivers/net/virtio_net.c                     |  78 ++++++++++--
 include/linux/dim.h                          |  45 +++++++
 include/linux/ethtool.h                      |  16 ++-
 include/uapi/linux/ethtool_netlink.h         |  24 ++++
 lib/dim/net_dim.c                            |  44 -------
 net/ethtool/coalesce.c                       | 172 ++++++++++++++++++++++++++-
 8 files changed, 360 insertions(+), 60 deletions(-)

-- 
1.8.3.1


