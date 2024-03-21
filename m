Return-Path: <netdev+bounces-81020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1663885885
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 12:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F39841F22CC2
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 11:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD84F59141;
	Thu, 21 Mar 2024 11:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pxKMfqTh"
X-Original-To: netdev@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AAF1CA9A
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 11:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711021564; cv=none; b=f5UbtO5v1l2hXL2nIqHGDM0TJNuRWXYrLsSJOweHO8S6MyYjH2QpvJjGkxEhMrkqH6sxG6Bb6h3H7LN/fbEzyoTOcsdrFUpFkuObIeLsZ7HkTKaHm0X4vU8uTodEuf6VkvKDLwPK2pJfQqhBLPRsGS/khrov/vW1VQyzut1jaQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711021564; c=relaxed/simple;
	bh=5O7WNNslf0nX7o/AoQpWdNoBHoseOD1muBmBtp8S/K0=;
	h=From:To:Subject:Date:Message-Id; b=Zxm6sT8fNYhz2Gt4kPd4wZ8mj/xeXzF2p4ij5Fc1lHqDTMCVJoFgbuy0qHWrJbk92T4+dVJisKfVZJ/HslH3B79tIfjOs/YyoZndLRnOPO2sHPqfGTRxYWYgZ9NKYzrR+M3Js1PGyCv7pILV7u+EGJpM5zNXENAbkjz8YbvJ4lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pxKMfqTh; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711021559; h=From:To:Subject:Date:Message-Id;
	bh=eyxU+Ykn+rsyTS5XDgWNmGBASv39cwvgkp4EQrvLAPI=;
	b=pxKMfqThbP2yWX7rWVXkcoTARrqNE/RadwUT5EoQMOoI72dQ48HZaOaQYT+0HO3UvjzyGID1WwfirWUk2J6Tq+LwsAWFbR1D/K6RYRQByoezL82fB2cWLxcZvepJbIrMAClMuC+1j0UrTc1CbzmTnslbAClT8+Cj13ewqQgpwn8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W3-bpPH_1711021557;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W3-bpPH_1711021557)
          by smtp.aliyun-inc.com;
          Thu, 21 Mar 2024 19:45:58 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH 0/2] virtio-net: a fix and some updates for virtio dim
Date: Thu, 21 Mar 2024 19:45:55 +0800
Message-Id: <1711021557-58116-1-git-send-email-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Patch 1 fixes an existing bug. Belongs to the net branch.
Patch 2 attempts to modify the sending of dim cmds to an asynchronous way.

Heng Qi (2):
  virtio-net: fix possible dim status unrecoverable
  virtio-net: reduce the CPU consumption of dim worker

 drivers/net/virtio_net.c | 273 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 246 insertions(+), 27 deletions(-)

-- 
1.8.3.1


