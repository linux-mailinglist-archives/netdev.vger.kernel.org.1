Return-Path: <netdev+bounces-82407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1055288DA1A
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 10:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 425EC1C2800C
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 09:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B0136B0D;
	Wed, 27 Mar 2024 09:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eqRGEHNK"
X-Original-To: netdev@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972ED29D03
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 09:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711531154; cv=none; b=faSv9uhqUyaYnDmfEKC3IHGEyqtnS++fs27yi4/qFsa6nbXNoZ4LcNKpW0REHcNyS0FYXX9/CHqlstmIUGHzMjvdbGlm0lwJapXMY28zPDQ2JjLkttr0CeOkMb73pJzLme3mmLcPKdf1luzQFpBhIMhjGfWFiZrKin5oFpNNWLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711531154; c=relaxed/simple;
	bh=nb7c9SiilOMqAqiwWgmHtYVlWZyyqVEfixLoYgK9Wnc=;
	h=From:To:Subject:Date:Message-Id; b=bIT1prrAE54s39bYI3UstfKJtzA+u7kcIIFR6jMPOeM7JaVJwOQ2axZFTAoxHyZWyy93yOGy7T0KRZzc3T/0tSBvgU/yAs4lASJhvLQJoYa+Iv/Tmz8FiJyfg0rhF6SyXWeE0GBv9q1ojhbT9ToA4/8zOVs3kyV5fDIbCTetjXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eqRGEHNK; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711531148; h=From:To:Subject:Date:Message-Id;
	bh=fUcSxF/49QyMZsw6YZ0epMjIc/Xqrf4Qup0EyVWY1eg=;
	b=eqRGEHNKqsFUUFc4QfczzxisWkPuIPvrCv9x54BUueDqgtmEsmAJtwuOM74W97C4RrIsxtmEg4eFQaLXWpjXbt6LjspaDN16NukIv9aW9VSW2YO/ghs36V7DUEpySS5UPaFAxSqRVxgM7spOnAvmUjO5Rk4upPeDKxSsfrMGGXI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W3OAk1X_1711531146;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W3OAk1X_1711531146)
          by smtp.aliyun-inc.com;
          Wed, 27 Mar 2024 17:19:07 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net-next v2 0/2] ethtool: provide the dim profile fine-tuning channel
Date: Wed, 27 Mar 2024 17:19:04 +0800
Message-Id: <1711531146-91920-1-git-send-email-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The NetDIM library provides excellent acceleration for many modern
network cards. However, the default profiles of DIM limits its maximum
capabilities for different NICs, so providing a way reusing "ethtool -C"
through which the NIC can be custom configured is necessary.

Please review, thank you very much!

Changelog
======
v1->v2:
  - Use ethtool tool instead of net-sysfs

V1 link:
https://lore.kernel.org/all/1710421773-61277-1-git-send-email-hengqi@linux.alibaba.com/#r

Heng Qi (2):
  ethtool: provide customized dim profile management
  virtio-net: support dim profile fine-tuning

 Documentation/networking/ethtool-netlink.rst |  8 +++++
 drivers/net/virtio_net.c                     | 54 ++++++++++++++++++++++++++--
 include/linux/dim.h                          |  7 ++++
 include/linux/ethtool.h                      | 16 ++++++++-
 include/uapi/linux/ethtool_netlink.h         |  4 +++
 lib/dim/net_dim.c                            |  6 ----
 net/ethtool/coalesce.c                       | 51 ++++++++++++++++++++++++--
 net/ethtool/netlink.h                        | 35 ++++++++++++++++++
 8 files changed, 170 insertions(+), 11 deletions(-)

-- 
1.8.3.1


