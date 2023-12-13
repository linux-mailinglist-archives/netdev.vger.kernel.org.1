Return-Path: <netdev+bounces-57033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E8C811AD5
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 18:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5EC4B21185
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 17:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FFA5677B;
	Wed, 13 Dec 2023 17:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGj7+RlF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32D054BDF
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 17:22:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAFD6C433C7;
	Wed, 13 Dec 2023 17:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702488157;
	bh=AxLzdOwROKaBy4vKWwMVdF4dPNPs2AaXJsUH4oqw274=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TGj7+RlFD4NS9fKb1HhoSJoU/nclrZkxpyQRv4ToOAJiI6OqZMvg4JY9lKmgSaI8A
	 ySG0vGbWszj94XyMuw55rgqS8mK/pCxcVAWXAyZm73ha/TSc2R44Xa441IvsfDrKbB
	 +9zklQ6JhsUIu94uwKROKjF9r5o8QW5l2XIdDj5rN32SuVhlgzRjToUyhfJh3wW47u
	 oJCxv6Wicq7mEYFxSr8tgForsEw11NE+b7I2GXV4OgZSUCkSpz1/MpraJSi9AN5fN5
	 kEArXuPBR7roMlr0Y165YI9Qz+ywV2QqV0I6jxThYEj6f4DEARpC0ffUQkgosxVPtC
	 Cr5uGI787oWWw==
Message-ID: <deb7d2b6-1314-4d39-aa6f-2930e5de8d82@kernel.org>
Date: Wed, 13 Dec 2023 09:22:36 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/2] Fix dangling pointer at f6i->gc_link.
Content-Language: en-US
To: thinker.li@gmail.com, netdev@vger.kernel.org, martin.lau@linux.dev,
 kernel-team@meta.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
Cc: sinquersw@gmail.com, kuifeng@meta.com
References: <20231208194523.312416-1-thinker.li@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231208194523.312416-1-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/8/23 12:45 PM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> According to a report [1], f6i->gc_link may point to a free block
> causing use-after-free. According the stacktraces in the report, it is
> very likely that a f6i was added to the GC list after being removed
> from the tree of a fib6_table. The reason this can happen is the
> current implementation determines if a f6i is on a tree in a wrong
> way. It believes a f6i is on a tree if f6i->fib6_table is not NULL.
> However, f6i->fib6_table is not reset when f6i is removed from a tree.
> 
> The new solution is to check if f6i->fib6_node is not NULL as well.
> f6i->fib6_node is set/or reset when the f6i is added/or removed from
> from a tree. It can be used to determines if a f6i is on a tree
> reliably.
> 
> The other change is to determine if a f6i is on a GC list.  The
> current implementation relies on RTF_EXPIRES on fib6_flags. It needs
> to consider if a f6i is on a tree as well. The new solution is
> checking hlist_unhashed() on f6i->gc_link, a clear evidence, instead.
> 
> [1] https://lore.kernel.org/all/20231205173250.2982846-1-edumazet@google.com/
> 

Eric: can you release the syzbot report for the backtrace listed in [1].
I would like to make "very likely that a f6i was added to the GC list
after being removed from the tree of a fib6_table" more certain. Thanks,

