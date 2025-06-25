Return-Path: <netdev+bounces-201143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6624CAE8425
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 15:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DEEE3A2A7C
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF800262FEC;
	Wed, 25 Jun 2025 13:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMQlUKrK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92616262FD3;
	Wed, 25 Jun 2025 13:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750857351; cv=none; b=hyqGNdcUUdlTj0x2VNY23NAV0+LD389TmhBjhXYO7dbsuejL75IV02WvMmdhU83zsH7XPwM6E2uNATfMd/x36QqRyQpeqwTz+ipZwyZnMMfjKsbN4ep7ouuHStpqLMGHcxQekxDz/zfwzNO96NLTr4hECsJqNyjfcUsi7n5DI7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750857351; c=relaxed/simple;
	bh=QT4Ls4Wox6hJ1R8TPcQdFcVFzO8CzbDCEi/cBTj/91g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=jkNElPX5atiSoOPx9/ngHujGAwl2HSESsdRrXTdWyu67pRnF0tix/E9sBaV9c1TRo8nwWey84CJPpVCFlTz83U9MxcSzCN5aaEzMIG0neBPk2ezCXlKYm9P+D8IaOW7eurvFabE8drg275swA5rNGcbghYNxbEfdnwoyZ3nGEV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMQlUKrK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A0CC4CEEA;
	Wed, 25 Jun 2025 13:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750857351;
	bh=QT4Ls4Wox6hJ1R8TPcQdFcVFzO8CzbDCEi/cBTj/91g=;
	h=From:To:Cc:Subject:Date:From;
	b=JMQlUKrK1jWsbryOHxePSEPvlIqL/2M4lOGuf8p6kfgSgiubupWLBwnd/8ucRJB2M
	 tnr3oO9W9gktF4txRMrp6FmTvAzJtt5IP49tObBfJlujbCRZJV/9PAULHULn9Nk2Nj
	 sldeH+VKMjCAGpu2KN7ElGFJjCwhCR5+3AJXp1MIu1YH9rlRS7OkUeAUlLA0waVqaD
	 tYCIBdpdoXs6Wmi0OXycazK9Yh5WT+QvGGhOghjnWNYzX2+rlGb0tY2thhW2OMEFSI
	 GN/cQDjrroJL0EkNMlO381we5zQuKhuEq2Q/wEHJlHC5/tdzAABYToEOe4SH/41NyQ
	 Af9ZRUsT30nfA==
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
Subject: [PATCH 0/5] vsock/virtio: SKB allocation improvements
Date: Wed, 25 Jun 2025 14:15:38 +0100
Message-Id: <20250625131543.5155-1-will@kernel.org>
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

We're using vsock extensively in Android as a channel over which we can
route binder transactions to/from virtual machines managed by the
Android Virtualisation Framework. However, we have been observing some
issues in production builds when using vsock in a low-memory environment
(on the host and the guest) such as:

  * The host receive path hanging forever, despite the guest performing
    a successful write to the socket.

  * Page allocation failures in the vhost receive path (this is a likely
    contributor to the above)

  * -ENOMEM coming back from sendmsg()

This series aims to improve the vsock SKB allocation for both the host
(vhost) and the guest when using the virtio transport to help mitigate
these issues. Specifically:

  - Avoid single allocations of order > PAGE_ALLOC_COSTLY_ORDER

  - Use non-linear SKBs for the transmit and vhost receive paths

  - Reduce the guest RX buffers to a single page

There are more details in the individual commit messages but overall
this results in less wasted memory and puts less pressure on the
allocator.

This is my first time looking at this stuff, so all feedback is welcome.

Patches based on v6.16-rc3.

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
Cc: netdev@vger.kernel.org 
Cc: virtualization@lists.linux.dev

--->8

Will Deacon (5):
  vhost/vsock: Avoid allocating arbitrarily-sized SKBs
  vsock/virtio: Resize receive buffers so that each SKB fits in a page
  vhost/vsock: Allocate nonlinear SKBs for handling large receive
    buffers
  vsock/virtio: Rename virtio_vsock_skb_rx_put() to
    virtio_vsock_skb_put()
  vhost/vsock: Allocate nonlinear SKBs for handling large transmit
    buffers

 drivers/vhost/vsock.c                   | 21 +++++++++------
 include/linux/virtio_vsock.h            | 36 +++++++++++++++++++------
 net/vmw_vsock/virtio_transport.c        |  2 +-
 net/vmw_vsock/virtio_transport_common.c |  9 +++++--
 4 files changed, 49 insertions(+), 19 deletions(-)

-- 
2.50.0.714.g196bf9f422-goog


