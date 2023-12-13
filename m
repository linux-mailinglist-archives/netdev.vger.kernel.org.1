Return-Path: <netdev+bounces-57073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CE4812068
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 22:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98BC42815F7
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 21:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6426F7E571;
	Wed, 13 Dec 2023 21:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JA7dCLZ+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486AF2207D
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 21:08:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1AEC433C9;
	Wed, 13 Dec 2023 21:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702501688;
	bh=QSbOOGOaIMeM+ibCAHIj+X3KXcfCh6g+WLS87aj3bMo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JA7dCLZ+W7AiCDTH1Oiuq6TPjyb964qY7pslUSXmQ+K0QVSvMZHSEMteIPizpfNs3
	 BRUwvUNvKyK9B1UYwLK7J4LGBBzhM45LDvsBrFKYUiD1caaSB5v2EovnDXOx3A54Lq
	 qbhNWRdt7pDqKolOuHG+RiAIMZz+1z/nJtRr+dVmT2XCmqXBeHGpmvWZ66phx2klzr
	 KOEb9EZFDEZsi5eFzQ8Fk6VFOIUHAoBzX1uMq7sXH1hbCHnoxeOXt7J09Rvs9IyKkn
	 i/t0Xo5I6YX/ona6JfQFBQEw+j6LfOs9CFl4ksN4HIR4SuM0tlkSbnS3OIN93qe6bG
	 9L1NM+Dh6Hefw==
Date: Wed, 13 Dec 2023 13:08:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jamal Hadi Salim <hadi@mojatatu.com>, Eric Dumazet
 <edumazet@google.com>, Victor Nogueira <victor@mojatatu.com>,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
 pabeni@redhat.com, daniel@iogearbox.net, dcaratti@redhat.com,
 netdev@vger.kernel.org, kernel@mojatatu.com
Subject: Re: [PATCH net-next v3 2/3] net: sched: Make tc-related drop reason
 more flexible for remaining qdiscs
Message-ID: <20231213130807.503e1332@kernel.org>
In-Reply-To: <CAM0EoMk9cA0qCGNa181QkGjRHr=4oZhvfMGEWoTRS-kHXFWt7g@mail.gmail.com>
References: <20231205205030.3119672-1-victor@mojatatu.com>
	<20231205205030.3119672-3-victor@mojatatu.com>
	<20231211182534.09392034@kernel.org>
	<CAM0EoMkYq+qqO6pwMy_G58_+PCT6A6EGtpPJXPkvQ1=aVvY=Sw@mail.gmail.com>
	<CANn89i+-G0gTF=Vmr5NprYizdqXqpoQC5OvnXbc-7dA47tcdyQ@mail.gmail.com>
	<CAAFAkD8X-EXt4K+9Jp4P_f607zd=HxB6WCEF_4BGcCm_hSbv_A@mail.gmail.com>
	<CAM0EoMk9cA0qCGNa181QkGjRHr=4oZhvfMGEWoTRS-kHXFWt7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Dec 2023 13:36:31 -0500 Jamal Hadi Salim wrote:
> Putting this to rest:
> Other than fq codel, the others that deal with multiple skbs due to
> gso segments. So the conclusion is:  if we have a bunch in the list
> then they all suffer the same fate. So a single reason for the list is
> sufficient.

Alright.

I'm still a bit confused about the cb, tho.

struct qdisc_skb_cb is the state struct.
But we put the drop reason in struct tc_skb_cb.
How does that work. Qdiscs will assume they own all of
qdisc_skb_cb::data ?

Maybe some documentation about the lifetimes of these things
would clarify things?

