Return-Path: <netdev+bounces-207775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA71FB088B8
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 11:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46F08189DE2B
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 09:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BFA288516;
	Thu, 17 Jul 2025 09:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5HsNl+Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6F3283128;
	Thu, 17 Jul 2025 09:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752742883; cv=none; b=nRgGYRVZ5cdkDiHWpVDUZICLuSBCsnpI1PRQJGW/WiRyKhQhVnqHbZ0baAKHnm7kMQ65S/GDg4CI8we+uUyAKd2tfHl8LWKP3S98OqWY4y5vxAG4BParSuRf2efc0kqkX06S2HvnHgXD4o/Q/lCJ19qr7mJGi3zq076LCsoeJZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752742883; c=relaxed/simple;
	bh=VrjqMhuxSNPKShrpTJDxPztORNSNWIlNmf8BnKhuq2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ug2O4gkSCgqnySTWnpW4ht+zkmIn7DyJdzFsrbGLgFhtYhevCN9d6+X6J/lUjQEkjhDrmSTXmvxvMFb/xNR59pPKDUFVzEC6pdUb/TaL3PYqBN/CtfJtp1qQsovEMrVXI8ZRtVAZNG9itsxlFqW+hq1x2H2bnO1a5/sgIJVQMzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5HsNl+Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0ACC4CEE3;
	Thu, 17 Jul 2025 09:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752742883;
	bh=VrjqMhuxSNPKShrpTJDxPztORNSNWIlNmf8BnKhuq2Y=;
	h=From:To:Cc:Subject:Date:From;
	b=A5HsNl+QTUvYP1zmvxgOd2/dU7P39nog3xQjGk2RY0ir0A61KaiIMWRzSWoQ3AvLo
	 UV+JlUYLZTN9DHkmFvrADEs+ZV0PEl7whviCZLxTbyAP5Ec/hNiGvrEHjRmB7YQR1j
	 ZZbKtKIYLmNRV8VJqNAC8/V7qAVaLCdntfTfTHPY8moMU6m129ATjAbY9V+RZDw7bN
	 VOIO5ySnpDG+QwFtPnL8/SVqjMts36/5QtzvlGQ0thXektPAocGds/uGT0r/NvdvSK
	 E6AFokQiL3L6l90/ajAJiwPAeCFdMsjeQ0xh0LanwYfbIomZ3+SrMiOrQIfD95uPug
	 5db4bKbMUnqlw==
From: Will Deacon <will@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Will Deacon <will@kernel.org>,
	Keir Fraser <keirf@google.com>,
	Steven Moreland <smoreland@google.com>,
	Frederick Mayle <fmayle@google.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v4 0/9] vsock/virtio: SKB allocation improvements
Date: Thu, 17 Jul 2025 10:01:07 +0100
Message-Id: <20250717090116.11987-1-will@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

Here is version four of the patches I previously posted here:

  v1: https://lore.kernel.org/r/20250625131543.5155-1-will@kernel.org
  v2: https://lore.kernel.org/r/20250701164507.14883-1-will@kernel.org
  v3: https://lore.kernel.org/r/20250714152103.6949-1-will@kernel.org

There are only two minor changes since v3:

  * Use unlikely() in payload length check on the virtio rx path

  * Add R-b tags from Stefano

Cheers,

Will

Cc: Keir Fraser <keirf@google.com>
Cc: Steven Moreland <smoreland@google.com>
Cc: Frederick Mayle <fmayle@google.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: "Eugenio Pérez" <eperezma@redhat.com>
Cc: linux-kernel@vger.kernel.org 
Cc: netdev@vger.kernel.org 
Cc: virtualization@lists.linux.dev

--->8

Will Deacon (9):
  vhost/vsock: Avoid allocating arbitrarily-sized SKBs
  vsock/virtio: Validate length in packet header before skb_put()
  vsock/virtio: Move length check to callers of
    virtio_vsock_skb_rx_put()
  vsock/virtio: Resize receive buffers so that each SKB fits in a 4K
    page
  vsock/virtio: Rename virtio_vsock_alloc_skb()
  vsock/virtio: Move SKB allocation lower-bound check to callers
  vhost/vsock: Allocate nonlinear SKBs for handling large receive
    buffers
  vsock/virtio: Rename virtio_vsock_skb_rx_put()
  vsock/virtio: Allocate nonlinear SKBs for handling large transmit
    buffers

 drivers/vhost/vsock.c                   | 15 ++++----
 include/linux/virtio_vsock.h            | 46 +++++++++++++++++++------
 net/vmw_vsock/virtio_transport.c        | 20 ++++++++---
 net/vmw_vsock/virtio_transport_common.c |  3 +-
 4 files changed, 60 insertions(+), 24 deletions(-)

-- 
2.50.0.727.gbf7dc18ff4-goog


