Return-Path: <netdev+bounces-18655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AC1758387
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 19:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04D001C20D4F
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 17:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60C9154AE;
	Tue, 18 Jul 2023 17:32:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CF4101ED
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 17:32:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B41EC433C8;
	Tue, 18 Jul 2023 17:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689701556;
	bh=5sr+yjwLVU6f+lqMOfWoGq5NUJvs6qsaMrWv5HRb0zE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=idOxW7Wfi/M22qWhbX0ZuMGzGLMpVBG26F9PGqW02cBDx+a8kPduaXPCNyv2gJLAO
	 YIOzIg2DhjzuNdLVitTUITjJC45H8l1WtTyq8YlyoDV2wLe9w+3JKxi6+JhB5+ZsKZ
	 9wq43VR+kOlkL3WhN7OM8HWIv3hpicw2TuPpxSe7Nbwo9qllmCwRpgp+ILSXD1jsQ3
	 LuBZYWJJMChc1JlbmkOyU1EVCZhj+II1qEFbMJMMf/l+EmZIulzA5dxUNwwo+q+91y
	 93fOXY6mg7tjd6adh1mHOcqT/q72z1++d3bJbyeWA/p6lEm9COrpwzKTq+VKWBFhOg
	 DU4JRoJhnIYPQ==
Date: Tue, 18 Jul 2023 10:32:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: Mina Almasry <almasrymina@google.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, netdev@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, Sumit Semwal
 <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Arnd Bergmann <arnd@arndb.de>, David Ahern
 <dsahern@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, jgg@ziepe.ca
Subject: Re: [RFC PATCH 00/10] Device Memory TCP
Message-ID: <20230718103234.711d7e4f@kernel.org>
In-Reply-To: <12393cd2-4b09-4956-fff0-93ef3929ee37@kernel.org>
References: <20230710223304.1174642-1-almasrymina@google.com>
	<12393cd2-4b09-4956-fff0-93ef3929ee37@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 16 Jul 2023 19:41:28 -0700 Andy Lutomirski wrote:
> I'm wondering if a more capable if somewhat higher latency model could 
> work where the NIC stores received packets in its own device memory. 
> Then userspace (or the kernel or a driver or whatever) could initiate a 
> separate DMA from the NIC to the final target *after* reading the 
> headers.  Can the hardware support this?

No, no, that's impossible. SW response times are in 100s of usec (at
best) which at 200Gbps already means megabytes of data _per-queue_. 
Way more than the amount of buffer NICs will have.

The Rx application can bind to a IP addr + Port and then install
a one-sided-3-tuple (dst IP+proto+port) rule in the HW. Worst case
a full 5-tuple per flow.

Most NICs support OvS offloads with 100s of thousands of flows.
The steering should be bread and butter.

It does require splitting flows into separate data and control channels,
but it's the right trade-off - complexity should be on the SW side.

