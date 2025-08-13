Return-Path: <netdev+bounces-213346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32429B24A8D
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 15:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E1B5161B47
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 13:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E0B2E62C4;
	Wed, 13 Aug 2025 13:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="LHu7edKu"
X-Original-To: netdev@vger.kernel.org
Received: from r3-20.sinamail.sina.com.cn (r3-20.sinamail.sina.com.cn [202.108.3.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DA414EC5B
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 13:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755091574; cv=none; b=J2tUOuozKkstHc3omEEdLMBbcrr7y/cJVYi9HeC3MNz0PNa1ivvk1NxbdXoswWBWcrAjniT0o5lRD+1DpQZrvfMo3rRJrLEZ5NLcynjsxNSplRi7uqCuQzXbD3APgum2G2+dwwkPHntxylXfDY7saghdGWC8PQANN1+5FiD3f8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755091574; c=relaxed/simple;
	bh=Uq9n0I9N5l8mMnseAxwMTJToi2ytaZfBB0V8c7fEYoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lPbQLh4IOvrN9+7UNSgUl96q/yT3uVMQF6gK9DYmMwKRQ6EqNG7FdNUmqOC/i7zpVBVbjxh57PCkQvwaZyi15ovHshAw7BJS2qzkWmlfSdWE1bggyzTy/hZkB4le35wOE1LjoheOHasrV7AZZ95u/TYZIMcHaChaHXKPrjeOcfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=LHu7edKu; arc=none smtp.client-ip=202.108.3.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1755091570;
	bh=D2wtmkC5cRwj57r9Km0rnHswAsCqKsDcHe53mfuX6aA=;
	h=From:Subject:Date:Message-ID;
	b=LHu7edKuOMSHs0jF8NB5EfKai3C4BtD6z6/8H1Kl3L0lS55RH5hh9vL7j9miW8muh
	 IYPyBgYnx56I2g6jlx53PZLlNSdZOZOusmuph29V5rwfg+CY/9v+upKa7uOcLf7E1k
	 M/Rim/vE3tTUniGI2FcJM3I4gBlLlHUwWIKVG9z4=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 689C926B0000478F; Wed, 13 Aug 2025 21:26:06 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4862744456671
X-SMAIL-UIID: F3A7C21EFC92444F91B50E695AC80BA3-20250813-212606-1
From: Hillf Danton <hdanton@sina.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v4 9/9] vsock/virtio: Allocate nonlinear SKBs for handling large transmit buffers
Date: Wed, 13 Aug 2025 21:25:53 +0800
Message-ID: <20250813132554.4508-1-hdanton@sina.com>
In-Reply-To: <20250812112226-mutt-send-email-mst@kernel.org>
References: <20250717090116.11987-1-will@kernel.org> <20250717090116.11987-10-will@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 13 Aug 2025 04:41:09 -0400 "Michael S. Tsirkin" wrote:
> On Thu, Jul 17, 2025 at 10:01:16AM +0100, Will Deacon wrote:
> > When transmitting a vsock packet, virtio_transport_send_pkt_info() calls
> > virtio_transport_alloc_linear_skb() to allocate and fill SKBs with the
> > transmit data. Unfortunately, these are always linear allocations and
> > can therefore result in significant pressure on kmalloc() considering
> > that the maximum packet size (VIRTIO_VSOCK_MAX_PKT_BUF_SIZE +
> > VIRTIO_VSOCK_SKB_HEADROOM) is a little over 64KiB, resulting in a 128KiB
> > allocation for each packet.
> > 
> > Rework the vsock SKB allocation so that, for sizes with page order
> > greater than PAGE_ALLOC_COSTLY_ORDER, a nonlinear SKB is allocated
> > instead with the packet header in the SKB and the transmit data in the
> > fragments. Note that this affects both the vhost and virtio transports.
> > 
> > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> > Signed-off-by: Will Deacon <will@kernel.org>
> 
> So this caused a regression, see syzbot report:
> 
> https://lore.kernel.org/all/689a3d92.050a0220.7f033.00ff.GAE@google.com
> 
> I'm inclined to revert unless we have a fix quickly.
> 
Because recomputing skb len survived the syzbot test [1], Will looks innocent.

[1] https://lore.kernel.org/lkml/689c8d08.050a0220.7f033.014a.GAE@google.com/

