Return-Path: <netdev+bounces-90394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 837758AE005
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 10:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5C311C22A86
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 08:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF0556B7E;
	Tue, 23 Apr 2024 08:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Lzk6mtXA"
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1ADF320E
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 08:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713861758; cv=none; b=mZRVIxTMv889cn6JquCPkQbhOv8L1wsBdO0XrNImNUnLnV6zviY63AFXcmDPhsPtoBU90wLdJSkcnaIuBL+6cI3Gom/RYjDGmqF1quhVK2eg0eB0RsYJAuGnJgwIe0brbiTop1JW+VV/+fwGo0yQqrlWBYTbUiKLQO59hIagqHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713861758; c=relaxed/simple;
	bh=81K02H3mGrqdlIRtS2o7bs/fPPMYf3j7mvLo88vIza8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h+eFnQYLVsHu6e73iNm9PE0DSwohjUKToxpbLH/vuaY4ZS874PypNp1mkffHcI07bzAQgZWu7ks3gf1qpLYBrfLuVvtX8w5oIvQvqTQ7hBXICjb/176eA0k5sNlVQX+cLH/GSHRTwNniXm/qsCBuXeNU2DKXipnEpejmJehxzI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Lzk6mtXA; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713861749; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=aaQQAXC49q37qIowIgNGklfhyY6GNb4kk/JfTIzkNOI=;
	b=Lzk6mtXAH0MK5YkY8cgI5O4+VAMuMMoN2RK4o/0GxUm16qhBrNAVg39LQv38TsOnmnuns3vS6nmNzRkMa6opxFjvnhC+yJ5Iaq4LcSU7HehG38d8OAlDz5BUpqShBgQDcfysk3dOuvBVHofQWjhjW77RK9y1YVTaAI2ZOGxMnm8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W58SinS_1713861746;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W58SinS_1713861746)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 16:42:28 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 0/2] virtio_net: support getting initial value of irq coalesce
Date: Tue, 23 Apr 2024 16:42:24 +0800
Message-Id: <20240423084226.25440-1-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 from Xuan: the virtnet cvq supports to get
result from the device.

Patch 2 reuses the VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET cmd to
get init coalesce value.

Heng Qi (1):
  virtio_net: get init coalesce value when probe

Xuan Zhuo (1):
  virtio_net: virtnet_send_command supports command-specific-result

 drivers/net/virtio_net.c | 92 ++++++++++++++++++++++++++++++++++------
 1 file changed, 78 insertions(+), 14 deletions(-)

-- 
2.32.0.3.g01195cf9f


