Return-Path: <netdev+bounces-104023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7374B90AED7
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 15:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 017422874E2
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 13:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3839C197A7F;
	Mon, 17 Jun 2024 13:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vKbkJ7Xx"
X-Original-To: netdev@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8814A1E4B2
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 13:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630131; cv=none; b=rCOAHv8l82td6nq0Ni20wPzbR+Viqx25Ga/hk9R9HJLs1ZmzDO4DiGrXRMUzJvubC3nKf1Aih9UmpmnsyTlsFZmA6qipH/yMYwB22FfygX4ogq0iziEiWsBc1k51UddqaydEnOIXldeqvMQXs/2INyGCtdaHeL90QPoeKz/yXhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630131; c=relaxed/simple;
	bh=qHRPw/KBBbsAFqNkLz4ziuTxm5Rn/bpfahLjLpZ2/fA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZLqPW61NACgQ2GJXW6KVMZtPuiT3aeilCg0WwQKlmKx4WnNfOYApsgJWW6o5lTJ5ACYSWz/i2k4EEcm30Htkfhx+S0j9/FUY+c4P4EiTaMMEB1WYjp6ou3yE09xHIuuW4Wyf6HA+uu2FkrEG7K2yaW6IVg1ONTlSvJWUQOdgQgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vKbkJ7Xx; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718630125; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Ef4HQitn4WyyEIc0kKx7VbSRz//I5N1vzF0yMoWvwh8=;
	b=vKbkJ7Xx3oHoS6qHcFdMJxMzn21YGtyteWxs2YwwCkhsMANb8c5RqdI5TAhEoLy4H4ZtShoVEMcJo3ItuQCN80PuHU+W9HkIMQo85DRSXWW0sD9Wd8okFzPbf1cKcVavW7mIf9PAVBYg9mL87sTgFJjuuR7A4IAjTQ9xjXF3lz0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W8foG1G_1718630124;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W8foG1G_1718630124)
          by smtp.aliyun-inc.com;
          Mon, 17 Jun 2024 21:15:25 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Thomas Huth <thuth@linux.vnet.ibm.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH 0/2] virtio_net: fixes for checksum offloading and XDP handling
Date: Mon, 17 Jun 2024 21:15:22 +0800
Message-Id: <20240617131524.63662-1-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series of patches aim to address two specific issues identified in
the virtio_net driver related to checksum offloading and XDP processing of
fully checksummed packets.

The first patch corrects the handling of checksum offloading in the driver.
The second patch addresses an issue where the XDP program had no trouble
with fully checksummed packets.

Heng Qi (2):
  virtio_net: checksum offloading handling fix
  virtio_net: fixing XDP for fully checksummed packets handling

 drivers/net/virtio_net.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

-- 
2.32.0.3.g01195cf9f


