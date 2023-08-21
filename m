Return-Path: <netdev+bounces-29444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 786007834C1
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 23:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74DCF280F2F
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 21:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FA0125B5;
	Mon, 21 Aug 2023 21:17:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB8FF9C1
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 21:17:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEBD1C433C8;
	Mon, 21 Aug 2023 21:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692652621;
	bh=Y9E2N54YOnSyLmA8cUBSyoIdwrsu0HH3mfSS8q0CrHY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Do+xTxYvnimA8Jk4dpu83D/ETfCUx3fVzj1AR6UlUE8Y4SjigoUmcJ5zTfuuxfkdt
	 TC0ns877pilP/k0KzSqWRwASQG5IQQHjxjwxwpZPIK/1Ibb7M/uut5vVDgrSFKmGmO
	 e3snt+m8IMfwsKA0IAV/wq32S4I8uV71ps58hHWN0gUVbsIUGhwW0hBDIOdVP3ESNI
	 BFtxqniKo/69bFdAPuJa34qewsCc7yQrReI9QVU+InmVnk3/KBzcdr+KVURMPv5U9K
	 hGg46szH+g3f1/cCwFODGqNogbsi6vugEHGeyPgGPxIj522pHmRLD2v2ZIwUlckTpd
	 qLotq6rQ4Cb2g==
Date: Mon, 21 Aug 2023 14:16:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Mina Almasry <almasrymina@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>, netdev@vger.kernel.org, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Magnus Karlsson <magnus.karlsson@intel.com>,
 sdf@google.com, Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang
 <kaiyuanz@google.com>
Subject: Re: [RFC PATCH v2 02/11] netdev: implement netlink api to bind
 dma-buf to netdevice
Message-ID: <20230821141659.5f0b71f7@kernel.org>
In-Reply-To: <CAF=yD-KgNDzv3-MhOMOTe2bTw4T73t-M7D65MpeG6vDBqHzrtA@mail.gmail.com>
References: <20230810015751.3297321-1-almasrymina@google.com>
	<20230810015751.3297321-3-almasrymina@google.com>
	<7dd4f5b0-0edf-391b-c8b4-3fa82046ab7c@kernel.org>
	<20230815171638.4c057dcd@kernel.org>
	<64dcf5834c4c8_23f1f8294fa@willemb.c.googlers.com.notmuch>
	<c47219db-abf9-8a5c-9b26-61f65ae4dd26@kernel.org>
	<20230817190957.571ab350@kernel.org>
	<CAHS8izN26snAvM5DsGj+bhCUDjtAxCA7anAkO7Gm6JQf=w-CjA@mail.gmail.com>
	<7cac1a2d-6184-7cd6-116c-e2d80c502db5@kernel.org>
	<20230818190653.78ca6e5a@kernel.org>
	<38a06656-b6bf-e6b7-48a1-c489d2d76db8@kernel.org>
	<CAF=yD-KgNDzv3-MhOMOTe2bTw4T73t-M7D65MpeG6vDBqHzrtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Aug 2023 10:18:57 -0400 Willem de Bruijn wrote:
> Right. Many devices only allow bringing all queues down at the same time.
> 
> Once a descriptor is posted and the ring head is written, there is no
> way to retract that. Since waiting for the device to catch up is not
> acceptable, the only option is to bring down the queue, right? Which
> will imply bringing down the entire device on many devices. Not ideal,
> but acceptable short term, imho.
> 
> That may be an incentive for vendors to support per-queue
> start/stop/alloc/free. Maybe the ones that support RDMA already do?

Are you talking about HW devices, or virt? I thought most HW made 
in the last 10 years should be able to take down individual queues :o

