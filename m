Return-Path: <netdev+bounces-98414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2848D1588
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 09:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91D951F22357
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 07:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FBF7350C;
	Tue, 28 May 2024 07:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IfVYsl7Z"
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DBF73455
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 07:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716882758; cv=none; b=Rbv7Om4LyGNPhb/daZtIXVVn0Iz6wp7Jg9mCCIGOhmFDYSnoL+OtRuT4HWse79OxujjiO9CMyLiryJ/rA9RdtMoFv9GMZ69FSvZGoUeh/FuBVDypzhao5xOvWhMuaFIvg/mbfPuv626a4ftNSkDHVAgX9T0xmpXp3FnGIUaR28Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716882758; c=relaxed/simple;
	bh=BJeK8pNal+ymoDeUb5GiAw2UpebKyIVZgY3LE7Dm3V4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oXjbiANC/Ny/6D5iG1/K2xow5J+io4xW3q36TM3SapXFF1B0jVLItwK14Vw1yJv4tUspkik/JOh5ltDU0D692AYg8H411Zdk1G3jqpAKxsdHT/SeBORWJI02t5FX/Z43C3mY9DnsrpH8WqdEVo3Mi5RvG8jeNTKeFUd6iUG8zOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IfVYsl7Z; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716882748; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=JyHskfYfTKvgjtp2G+w/xD2Jh25UbX4GqTMTrxOtYt8=;
	b=IfVYsl7ZVjlV7+ESlsW/e6ZCwVw5laWx7v2cvV7u34kQH9m66tWiD79Gt0Jes9fDKIIpNlv759pRZNCROjhLOb7pzg1ePM8Tzij1YBB5rC4BLvZsZ865eRBuuBME9YKhXpWvi7Qco5LZLaPbKRyajXzTUB2ZqgvF/LtFnhG53xk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W7OuiB2_1716882746;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W7OuiB2_1716882746)
          by smtp.aliyun-inc.com;
          Tue, 28 May 2024 15:52:27 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net 0/2] virtio_net: fix race on control_buf
Date: Tue, 28 May 2024 15:52:24 +0800
Message-Id: <20240528075226.94255-1-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 did a simple rename, leaving 'ret' for patch 2.
Patch 2 fixed a race between reading the device response and the
new command submission.

Heng Qi (2):
  virtio_net: rename ret to err
  virtio_net: fix missing lock protection on control_buf access

 drivers/net/virtio_net.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

-- 
2.32.0.3.g01195cf9f


