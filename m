Return-Path: <netdev+bounces-46292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9697E31B1
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 00:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D2E0B20A85
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 23:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A24F2FE26;
	Mon,  6 Nov 2023 23:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHDu7NE3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0C4DF6B
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 23:55:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEEBDC433C7;
	Mon,  6 Nov 2023 23:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699314944;
	bh=CBVsDjLpDh3DqO53Z7jB5PodqXv0dqoRE1VTibicHDk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tHDu7NE3mpkr1DOFckfUWx88lr1g8NMqtWJ6eVQjt6YtxEJtB3MzRhMAqpHUCOOnu
	 HERcGnFrYBktSD8DKkbyE8ek8H9VHw/wEzhcjIKOE9tdi5RIBdczye7+hnXGI4KJKu
	 S0rpAERxYf/jKoXVcPPVq6PuYBkI20g7/zRTur41oqPVeJXe+V/38zMNofUypZYzSp
	 O3mGYMyQzkQzdasVHQ+sN5vodbH7gZFWgfyYemzHaE/bdy2CusoZbtwSH6Pqk3dywZ
	 jimVApXC5UDwmcNUMEwKAOS0k67+Rh55jzHYDZxhXJeV0Yn4t1vShofBTTCgeHKn43
	 cIasqiU647M3A==
Message-ID: <93eb6a2b-a991-40ca-8f26-f520c986729a@kernel.org>
Date: Mon, 6 Nov 2023 16:55:43 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 10/12] tcp: RX path for devmem TCP
Content-Language: en-US
To: Stanislav Fomichev <sdf@google.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Arnd Bergmann
 <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Shakeel Butt <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-11-almasrymina@google.com>
 <ZUk0FGuJ28s1d9OX@google.com>
 <CAHS8izNFv7r6vqYR_TYqcCuDO61F+nnNMhsSu=DrYWSr3sVgrA@mail.gmail.com>
 <CAF=yD-+MFpO5Hdqn+Q9X54SBpgcBeJvKTRD53X2oM4s8uVqnAQ@mail.gmail.com>
 <ZUlp8XutSAScKs_0@google.com>
 <CAF=yD-JZ88j+44MYgX-=oYJngz4Z0zw6Y0V3nHXisZJtNu7q6A@mail.gmail.com>
 <CAKH8qBueYgpxQTvTwngOs6RNjy9yvLF92s1p5nFrobw_UprNMQ@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CAKH8qBueYgpxQTvTwngOs6RNjy9yvLF92s1p5nFrobw_UprNMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/23 4:32 PM, Stanislav Fomichev wrote:
>> The concise notification API returns tokens as a range for
>> compression, encoding as two 32-bit unsigned integers start + length.
>> It allows for even further batching by returning multiple such ranges
>> in a single call.
> 
> Tangential: should tokens be u64? Otherwise we can't have more than
> 4gb unacknowledged. Or that's a reasonable constraint?
> 

Was thinking the same and with bits reserved for a dmabuf id to allow
multiple dmabufs in a single rx queue (future extension, but build the
capability in now). e.g., something like a 37b offset (128GB dmabuf
size), 19b length (large GRO), 8b dmabuf id (lots of dmabufs to a queue).

