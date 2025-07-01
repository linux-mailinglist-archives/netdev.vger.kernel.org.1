Return-Path: <netdev+bounces-202979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0921AF007A
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 18:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7ED6488092
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 16:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7312F27FD52;
	Tue,  1 Jul 2025 16:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQn8m6WV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E7827F01B;
	Tue,  1 Jul 2025 16:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751388315; cv=none; b=DDuY060GrL89fiqNTVypFzRTUGolwk4Qua84A7QeG1UNlNpsf1Syf73i6Ki0QzemWPiYwIs5+D29q/2Be0Gnq5fxaS3P+ljnA5L5j6aECxxA2QlOLtQS7/J1o6/ZqjbUGp7fs60UdpUIIiTXVbc3plT9m3rneK+eU5yhz2dTke0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751388315; c=relaxed/simple;
	bh=bxI5qbwmKxZE1pRGbFIvQ8nrVkIao+568lXrN4xQxSM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=cu3pbAuZ7nzH8iwEU6aNyHg3xyymRSNBpiBef2BazkQbng63Yho4EGo4ntoYMPyBfgxCPh0CDYROIT+onX6xOX7qd51ntaOAE8adLGnmiQKn28Fhu/Qq4ZqYbbflg4Q+LqrSyHr6JjVnQisNm1JPuBGPDvnHd3Kxb38O3gWZLfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQn8m6WV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD5B9C4CEF1;
	Tue,  1 Jul 2025 16:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751388315;
	bh=bxI5qbwmKxZE1pRGbFIvQ8nrVkIao+568lXrN4xQxSM=;
	h=From:To:Cc:Subject:Date:From;
	b=HQn8m6WVXBPUHMF0G0fk6gAKLg9QzbQRzvJGura4rtZsXjTz1c8/v9aZZPrjrWS9O
	 BF7XLwBY+Ln3dezfssuajShLP5BCv95w0/l26n7im/kOL2xTWU6WNQePrABdKc3gnC
	 Pv228FVyqH9L7bJgstW0xmTZQyMZYkNzkxX6CoFwNaFUflG1zY60+qOQtQygRR+yu9
	 dZHSKilzCBT68+LzkZIJACEmD0Nf6O48T4CA6urdeBQYLn0piFkmRtqTgUsXRnNlkD
	 weUkQ2HW9bQkAJV0hEh3KUl79yCNdTyIbDpibWRp+ao5IzDb5DuuQbB67PXDxFtly2
	 qWyZaI7C05nnw==
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
Subject: [PATCH v2 0/8] vsock/virtio: SKB allocation improvements
Date: Tue,  1 Jul 2025 17:44:59 +0100
Message-Id: <20250701164507.14883-1-will@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello again,

Here is version two of the patches I previously posted here:

  https://lore.kernel.org/r/20250625131543.5155-1-will@kernel.org

Changes since v1 include:

  * Remove virtio_vsock_alloc_skb_with_frags() and instead push decision
    to allocate nonlinear SKBs into virtio_vsock_alloc_skb()

  * Remove VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE and inline its definition
    along with a comment

  * Validate the length advertised by the packet header on the guest
    receive path

  * Minor tweaks to the commit messages and addition of stable tags

Thanks to Stefano for all the review feedback so far.

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

Will Deacon (8):
  vhost/vsock: Avoid allocating arbitrarily-sized SKBs
  vsock/virtio: Validate length in packet header before skb_put()
  vsock/virtio: Move length check to callers of
    virtio_vsock_skb_rx_put()
  vsock/virtio: Resize receive buffers so that each SKB fits in a page
  vsock/virtio: Add vsock helper for linear SKB allocation
  vhost/vsock: Allocate nonlinear SKBs for handling large receive
    buffers
  vsock/virtio: Rename virtio_vsock_skb_rx_put() to
    virtio_vsock_skb_put()
  vsock/virtio: Allocate nonlinear SKBs for handling large transmit
    buffers

 drivers/vhost/vsock.c                   | 15 +++++-----
 include/linux/virtio_vsock.h            | 37 +++++++++++++++++++------
 net/vmw_vsock/virtio_transport.c        | 25 +++++++++++++----
 net/vmw_vsock/virtio_transport_common.c |  3 +-
 4 files changed, 59 insertions(+), 21 deletions(-)

-- 
2.50.0.727.gbf7dc18ff4-goog


