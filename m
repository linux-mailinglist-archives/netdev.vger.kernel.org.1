Return-Path: <netdev+bounces-18689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D9C7584C8
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 20:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B11B01C20DB2
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 18:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FC4168B9;
	Tue, 18 Jul 2023 18:29:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4580415AE6
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 18:29:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0789CC433C7;
	Tue, 18 Jul 2023 18:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689704981;
	bh=mZVev6Chb/FEkhGNNxmMJ4Z4XBKzCjBKm3JCVUTRO9w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W+I2qLxnV2nwCe87SLiOEw1Jweg0OeZD2j/yRxQDVNt+14Rkac1VIizQXx4i7k1N5
	 JJdwT1mpdkgkgjv+Ir/3tfmttDP0b6kit9SFW571v7DByXjGPkrXy8Ykc2SVE+anJm
	 3dswwmPZu1wb0OaUflN6gL8hAq2rntRM7gbj42WAHOUFfXQsunJ2AUzJr3XQJjpGZt
	 DTC4uKP7RBUU6jrpn+QuQlkeRHQZ5oSsJ9PyggwH7aPORRAfp1blBskG12UY7BpibD
	 RfIKKGf+dvfNZ5/X+eVvGF46ewYCWaMr/DK1htsGhNS0jcZe6MOxxl9FBOBiKVdvqK
	 Kwj+Z7IDVEvXw==
Date: Tue, 18 Jul 2023 11:29:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Mina Almasry <almasrymina@google.com>,
 Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, netdev@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, Sumit Semwal
 <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [RFC PATCH 00/10] Device Memory TCP
Message-ID: <20230718112940.2c126677@kernel.org>
In-Reply-To: <35f3ec37-11fe-19c8-9d6f-ae5a789843cb@kernel.org>
References: <20230710223304.1174642-1-almasrymina@google.com>
	<12393cd2-4b09-4956-fff0-93ef3929ee37@kernel.org>
	<CAHS8izNPTwtk+zN7XYt-+ycpT+47LMcRrYXYh=suTXCZQ6-rVQ@mail.gmail.com>
	<ZLbUpdNYvyvkD27P@ziepe.ca>
	<20230718111508.6f0b9a83@kernel.org>
	<35f3ec37-11fe-19c8-9d6f-ae5a789843cb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jul 2023 12:20:59 -0600 David Ahern wrote:
> On 7/18/23 12:15 PM, Jakub Kicinski wrote:
> > On Tue, 18 Jul 2023 15:06:29 -0300 Jason Gunthorpe wrote:  
> >> netlink feels like a weird API choice for that, in particular it would
> >> be really wrong to somehow bind the lifecycle of a netlink object to a
> >> process.  
> > 
> > Netlink is the right API, life cycle of objects can be easily tied to
> > a netlink socket.  
> 
> That is an untuitive connection -- memory references, h/w queues, flow
> steering should be tied to the datapath socket, not a control plane socket.

There's one RSS context for may datapath sockets. Plus a lot of the
APIs already exist, and it's more of a question of packaging them up 
at the user space level. For things which do not have an API, however,
netlink, please.

