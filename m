Return-Path: <netdev+bounces-54248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0771E8065C9
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 04:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38FD41C20B10
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 03:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55D3D2F0;
	Wed,  6 Dec 2023 03:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SixnKGXj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996EED517
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 03:41:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4944C433C8;
	Wed,  6 Dec 2023 03:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701834063;
	bh=8ezYr81SA31316O3MGd+Zv62N56/5VhuDHegpjMihwI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SixnKGXjiBxgshYU7Bc7gOldSm2UrC2vQyw8NBbBVEbkJ3/jrWwd86gxjULZ+OTBB
	 be7EMDOhQ36btIsAtdJ5zTEQegXCZVOAdMlI+YHbFLkis6+VxdjpGo7rHhD4Kj78E7
	 n7SW6TyzD5yidPA88CyJqrPpcAiXAda1v1MsPXyJELjt06+uH+mblEDuMrKUOhavxd
	 JQIrVoFRN0G74bEPCylXNMdEgo8EGmwBinOc+BGO4tQz6m5/kkpAvKKBVmWkXElLdl
	 FHBwkJbXmv78Sizkmoe0TRL1wwO2ci7bIi9uTX2y+58LE/GL4jeb32z5Dl+qzSbkZR
	 uZ4LIT412peZw==
Message-ID: <ee557d3b-79f1-4851-9473-99f711a78f2b@kernel.org>
Date: Tue, 5 Dec 2023 20:41:02 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv6: add debug checks in fib6_info_release()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20231205173250.2982846-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231205173250.2982846-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/5/23 10:32 AM, Eric Dumazet wrote:
> Some elusive syzbot reports are hinting to fib6_info_release(),
> with a potential dangling f6i->gc_link anchor.
> 
> Add debug checks so that syzbot can catch the issue earlier eventually.
> 
> BUG: KASAN: slab-use-after-free in __hlist_del include/linux/list.h:990 [inline]
> BUG: KASAN: slab-use-after-free in hlist_del_init include/linux/list.h:1016 [inline]
> BUG: KASAN: slab-use-after-free in fib6_clean_expires_locked include/net/ip6_fib.h:533 [inline]
> BUG: KASAN: slab-use-after-free in fib6_purge_rt+0x986/0x9c0 net/ipv6/ip6_fib.c:1064
> Write of size 8 at addr ffff88802805a840 by task syz-executor.1/10057
> 

...

> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/ip6_fib.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>





