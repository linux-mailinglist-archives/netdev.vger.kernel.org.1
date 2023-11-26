Return-Path: <netdev+bounces-51157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D737F95DE
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 23:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8ECA1C20445
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 22:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC6F14F6D;
	Sun, 26 Nov 2023 22:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TX8xd2iW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E791426A
	for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 22:43:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF55C433C8;
	Sun, 26 Nov 2023 22:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701038582;
	bh=2/TIuJ8i2Ec6W/NnOlqVE/hhJF/TnCLKXHPzUunPx3c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TX8xd2iWi8ZaV5O8TNTqMEOt4UOKPkIr8MnJobGU8WMqRIVm8U5bddo7XYcyt0m6K
	 Vs7dWcLQlKnRO+e7l4w7Hf6I3N58eYrs+fQWQfbs3KFeijIfC7jcs7ej4bLHfVaH/5
	 OZYceXtOAZBxqWdFj8hRh94J8iT1yQISpme0VmqbX4Vs0zIMZeYLvEnYWp77DFiYp6
	 frCdNgRqhrUaLwr3NGYbgWzCklTuNvZliU7Cf5KupdptoyEKpfM/jdIDcJoNcuEVCM
	 O7CxGXgJpdqHx/kptHnLkH+M4+bk+lrQKNe3i/NWqHtR14qwCd3JLoJmgIZcWaGf2z
	 yS3WL6NY3EF+A==
Date: Sun, 26 Nov 2023 14:43:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Shakeel Butt <shakeelb@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, almasrymina@google.com, hawk@kernel.org,
 ilias.apalodimas@linaro.org, dsahern@gmail.com, dtatulea@nvidia.com,
 willemb@google.com
Subject: Re: [PATCH net-next v3 00/13] net: page_pool: add netlink-based
 introspection
Message-ID: <20231126144300.18a05ea7@kernel.org>
In-Reply-To: <20231125205724.wkxkpnuknj5bf6c4@google.com>
References: <20231122034420.1158898-1-kuba@kernel.org>
	<20231125205724.wkxkpnuknj5bf6c4@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 25 Nov 2023 20:57:24 +0000 Shakeel Butt wrote:
> > $ ./page-pool
> >     eth0[2]	page pools: 10 (zombies: 0)
> > 		refs: 41984 bytes: 171966464 (refs: 0 bytes: 0)
> > 		recycling: 90.3% (alloc: 656:397681 recycle: 89652:270201)  
> 
> Hi Jakub, I am wondering if you considered to expose these metrics
> through meminfo/vmstat as well, is that a bad idea or is this/netlink
> more of a preference?

If that's net-namespaced we can add the basics there. We'll still need
the netlink interface, tho, it's currently per-interface and per-queue
(simplifying a bit). But internally the recycling stats are also
per-CPU, which could be of interest at some stage.

