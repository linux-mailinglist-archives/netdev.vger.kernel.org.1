Return-Path: <netdev+bounces-206722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 954FDB043A2
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 17:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8880816257D
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 15:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91AA260565;
	Mon, 14 Jul 2025 15:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZzpjDQy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCB51E1DF0;
	Mon, 14 Jul 2025 15:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506472; cv=none; b=cGe/j/0JNQbU1JWgc4O2fv/hLIAQsqFi3gnBhgl83VeJOhTNXyoijyQzWjw8y0uTVo9UZgAA4eTWpY6ycdeRx+C0nSl6rR80p7GF+xUImtTVBjh+8nO+eKCOgPXVZfIDW0ItLw6qAfAVAkvD19D8ojMpI8erCPWlQUGLkY9LRjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506472; c=relaxed/simple;
	bh=EXw+4q6ryjNblxNUNSKpxNGIL/z6m/pmY7l+XtJzUoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=o84Hu9h4wRC0sEc94QkAZeuZTyqJEYVgnQK6Ud9NFmkV4IEDDuInfW5T53z7FKtrZHJJDcjoVotFq75dHTWV8K6wnWW8QmZKWUd2174ODi1h3ftNy+PhjRh57II0H9pfimDS/ImItPrYLS4qNQpjbp06U5UA0CveLVcQHpqnIy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZzpjDQy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7C2C4CEED;
	Mon, 14 Jul 2025 15:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752506472;
	bh=EXw+4q6ryjNblxNUNSKpxNGIL/z6m/pmY7l+XtJzUoQ=;
	h=From:To:Cc:Subject:Date:From;
	b=EZzpjDQyqbiy4i0c5Y4vl+xULGF9BFsypL/omCv+FDXSmzC3ZIOk4/Skqj9rNLd/4
	 h52eQj2ckCuSIt1/TSNUZcynZIPeD4W7eF+1N4hoBSKTaRxheG28Z0RkZMruxLuc9Y
	 jRwB2xeS7Np9o5XmNN6KSf1t6LAhcdArPX6XRHsQkblxrWKidWuiF5rF5fu8hi0TVu
	 oh3lpyGNSC6rhF0RlHNKKc/ZwChB1uV7275mXUHwnvzUoBKvxtPgTvPzHkj7wDx21K
	 FO3c+dNIr7/r9iLVRPgk0qlVpT6xRng9BlOZkFcj+MfPL6nzVIri3qTu9R3u2ehnyg
	 f59s+herVBlfg==
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
Subject: [PATCH v3 0/9] vsock/virtio: SKB allocation improvements
Date: Mon, 14 Jul 2025 16:20:54 +0100
Message-Id: <20250714152103.6949-1-will@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi folks,

Here is version three of the patches I previously posted here:

  v1: https://lore.kernel.org/r/20250625131543.5155-1-will@kernel.org
  v2: https://lore.kernel.org/r/20250701164507.14883-1-will@kernel.org

Changes since v2 include:

  * Pass payload length as a parameter to virtio_vsock_skb_put()

  * Reinstate VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE based on a 4KiB total
    allocation size

  * Split movement of bounds check into a separate patch

Thanks again to Stefano for all the review feedback so far.

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


