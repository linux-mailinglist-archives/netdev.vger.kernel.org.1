Return-Path: <netdev+bounces-29509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF84783872
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 05:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07418280FC4
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 03:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94115111F;
	Tue, 22 Aug 2023 03:19:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFCF7F
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 03:19:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30967C433C8;
	Tue, 22 Aug 2023 03:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692674388;
	bh=2r3suyvcvQkyDG+OrfD6flChPa5pj7JbcjYn/2h6/mE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=t12waQRPevfJ3cmcPUVa36tvPvveRAnrbdKul0v82lSPOxSx/KYzf5mIZrvsWVd8f
	 cvpnC3QFLaAUeHRl0nDgBd5ittRHpDVLOzIGdDv+BfuvqshnMI1L/T4L0FhnWXVrrf
	 4XR/Bu0+hTaUBzdFF7HXPFLai7GBgL4Iyf8tHFMe6IJ3C2OPTEpx7zoqg0TjO3Zs8C
	 LtLNDRB8FxsQv216gdPusDRPmzTnNadw208HUYtnAg6Z8/MKqbv+3cLU4ea7haPEoy
	 D9yvyaPpS7j95PMEIbYBLvw1P2eXuzxk9dGydlruMiTaPYG2nO42ihQlBRsRZ0gbEp
	 GZoXMIbjR6paw==
Message-ID: <462ccad0-867e-3ef3-ca78-59d8a6e451b3@kernel.org>
Date: Mon, 21 Aug 2023 20:19:47 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [RFC PATCH v2 02/11] netdev: implement netlink api to bind
 dma-buf to netdevice
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Mina Almasry <almasrymina@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>, sdf@google.com,
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
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
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CAF=yD-KgNDzv3-MhOMOTe2bTw4T73t-M7D65MpeG6vDBqHzrtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/19/23 8:18 AM, Willem de Bruijn wrote:
> That may be an incentive for vendors to support per-queue
> start/stop/alloc/free. Maybe the ones that support RDMA already do?

I looked at most of the H/W RDMA in-tree kernel drivers today, and all
of them hand-off create_qp to firmware. I am really surprised by that
given that many of those drivers work with netdev. I am fairly certain
mlx5 and ConnectX 5-6, for example, can be used to achieve the
architecture we proposed at netdev [1], so I was expecting a general
queue management interface.

Between that and a skim of the providers (userspace side of it), the IB
interface may be a dead-end from the perspective of the goals here.

[1]
https://netdevconf.info/0x16/slides/34/netdev-0x16-Merging-the-Networking-Worlds-slides.pdf,
slide 14.

