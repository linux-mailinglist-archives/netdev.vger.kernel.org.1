Return-Path: <netdev+bounces-35395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A35C7A944B
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 14:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0902281AB0
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 12:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43988832;
	Thu, 21 Sep 2023 12:33:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD47193
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 12:33:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C28C32781;
	Thu, 21 Sep 2023 12:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695299592;
	bh=I2wdsC3bwatwPq1wviIFhcLzP9nRh4x476U8QpzzmYo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NC8H/ohiAWX3OutaLR4Cya1zHBgBXqp7c2GIxnn8JAcfcpw7xwjEjAdQaNzq0/YBS
	 FTUUhrz0vR+5jF2OmTX1zVZPdeyizSjanbALvylLLsr1qW5Ibw/JkdVBla0IMCaRwl
	 tmr+1t9d8u5l3stCZt2xmSWtBn5coDerTofphOvUytFzG3T2qkJZTGTasnW8ydIw8G
	 KsNMumgxh0LjKs8MFjhUYrBITMx88d3J0vLwsAAI/ilhVQEVOnxZq1aYlDj/v5jX6T
	 8XWNwoqKkdyMYiePha7rrNeU2+o2AkrH0FtDATXlenRLv1j0t3IJGKcXEBAXJbP1dO
	 jRrhZkKj49SXg==
Message-ID: <ab57c5d6-be1a-dca3-1629-4f81b07a3c19@kernel.org>
Date: Thu, 21 Sep 2023 06:33:10 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v15 01/20] net: Introduce direct data placement tcp
 offload
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, sagi@grimberg.me, hch@lst.de, kbusch@kernel.org,
 axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, imagedong@tencent.com
References: <20230912095949.5474-1-aaptel@nvidia.com>
 <20230912095949.5474-2-aaptel@nvidia.com>
 <4ae938a0-6331-f5d6-baa5-62eb8b07e63f@kernel.org>
 <253y1h0j7j6.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <253y1h0j7j6.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/21/23 1:43 AM, Aurelien Aptel wrote:
> David Ahern <dsahern@kernel.org> writes:
>> Not consolidating frags into linear is a requirement for any Rx ZC
>> solution (e.g., the gpu devmem RFC set and accompanying io_uring set for
>> userspace memory). Meaning, the bit can be more generic and less tied to
>> ulp_ddp.
> 
> In our view the ULP Direct Data Placement has a very specific design and
> avoiding skb coalescing is just one aspect of it.
> It would be hard to make it generic for any type of zero copy design. We
> can rename the bit to "ddp" or "zerocopy" if you prefer but it might end
> up being more misleading.

The number of single use case bits on sk_buff are piling up. In this
case, skb->ulp_ddp is only used to avoid skb_condense, so name it
accordingly. skb->no_condense for example.

