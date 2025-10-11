Return-Path: <netdev+bounces-228585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA16BCF334
	for <lists+netdev@lfdr.de>; Sat, 11 Oct 2025 11:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29C854252D1
	for <lists+netdev@lfdr.de>; Sat, 11 Oct 2025 09:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C4B2459C5;
	Sat, 11 Oct 2025 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FPGVTCke"
X-Original-To: netdev@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A750242D92
	for <netdev@vger.kernel.org>; Sat, 11 Oct 2025 09:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760175682; cv=none; b=Bt+RXEcP1724o1jw7d9kijr+ZmQkGTePaOjJEjHCkaukUI8jCSyO8uqpeOd0kWLBVu9/IwtxK+Atn5Js1tx8q/XUdrPZFKxnIGxkqPPGFghcfxfo2A4CpYy5kyUly8gMG4CjH2PHkqI3rSxZbwMUG6BwgwWxPH/WeHQ08hvnfW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760175682; c=relaxed/simple;
	bh=JQeci8kKFhUqNqSiKukDhGQ1oMGj2u2fkEVG4LJqWeE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CkuhsrbhxCsuO9JMApLVK+wF9IgLQ/2syaAxUhS4F/ceAG6cV210z0tTqLXjgDiQakTRIQ3qGBlQJItpj6aRNlT85+38IAvG4S8N0sTAu6Jc0N3odi6P3jMdCl2Zn5ku7cvnsiAI4n95ISEjO1qQ2MbPLNerDoJCFYVox54Jxfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FPGVTCke; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760175668; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=0KMzj+miCiTqLWcLN1eA5YLqErPlKnWHSP2dVaYTGYY=;
	b=FPGVTCkevAMrqE9HcNogKgNRqmG5IdIHODK2j1pLlqUVr+n9Yjfsu/d2nZt+nd5g6PHwfHSkhGKUC4cn6wsYR2uGQUySnzNOxPThT+I3OxwGRq+/c9u/oa/x3nUTF5CKb0FvSWs3W1aQVQDzZy7be2GuxoqsMmkksiCMD+oSG1I=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Wpw8kFU_1760175667 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 11 Oct 2025 17:41:08 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	Heng Qi <hengqi@linux.alibaba.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net v1 0/3] fixes two virtio-net related bugs.
Date: Sat, 11 Oct 2025 17:41:04 +0800
Message-Id: <20251011094107.16439-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 94b35d9b48af
Content-Transfer-Encoding: 8bit

As discussed in http://lore.kernel.org/all/20250919013450.111424-1-xuanzhuo@linux.alibaba.com
Commit #1 Move the flags into the existing if condition; the issue is that it introduces a
small amount of code duplication.

Commit #3 is new to fix the hdr len in tunnel gso feature.

Hi @Paolo Abenchi,
Could you please test commit #3? I don't have a suitable test environment, as
QEMU doesn't currently support the tunnel GSO feature.

Thanks.

Xuan Zhuo (3):
  virtio-net: fix incorrect flags recording in big mode
  virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
  virtio-net: correct hdr_len handling for tunnel gso

 drivers/net/virtio_net.c   | 16 ++++++++-----
 include/linux/virtio_net.h | 46 ++++++++++++++++++++++++++++++++------
 2 files changed, 50 insertions(+), 12 deletions(-)

--
2.32.0.3.g01195cf9f


