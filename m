Return-Path: <netdev+bounces-55480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B4E80AFCE
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 23:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 957A91C208D4
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 22:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E625731D;
	Fri,  8 Dec 2023 22:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/QkwhKJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3461FDC
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 22:43:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E4A5C433C8;
	Fri,  8 Dec 2023 22:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702075419;
	bh=4dk0wB0ntBuE9qKmRgOx/kLpNWsUmXN375Y8A2keUoY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M/QkwhKJR0AIuK7YvoNb2KtB7CPluRug0UBJ1Na7P1uiQIAr3peCUR1ZVFCHF91KP
	 kq/zjHeG3IyVmukNPo9rYU41E7Q6qvalxfimfA97sHrkgl5kBcFZyGnVfWMYaJUQBh
	 UBN6JKqpQTvvKkw5tfcndMe7cyAgFE3I6os7Qe59FaBq0fo7F7RYpAkwsVlnjlF8Wj
	 hQWxEYlcCELD2ysjH/E/08/F0Gnqmc7gtkKYZ+IITdJ5u/wf2a+jS96rDvv0IxkBZQ
	 fERfNwTUtE7wPEMow+ozO3sX1x6na5u0thkkVUgLRN1qZFjJRO4Oz4IFjLHvPDw5o1
	 lu4vW38Q9ucSQ==
Message-ID: <353fc304-389b-4c16-b78f-20128d688370@kernel.org>
Date: Fri, 8 Dec 2023 15:43:38 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] net/ipv6: insert a f6i to a GC list only
 if the f6i is in a fib6_table tree.
Content-Language: en-US
To: thinker.li@gmail.com, netdev@vger.kernel.org, martin.lau@linux.dev,
 kernel-team@meta.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
Cc: sinquersw@gmail.com, kuifeng@meta.com,
 syzbot+c15aa445274af8674f41@syzkaller.appspotmail.com
References: <20231208194523.312416-1-thinker.li@gmail.com>
 <20231208194523.312416-2-thinker.li@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231208194523.312416-2-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/8/23 12:45 PM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Check f6i->fib6_node and hlist_unhashed(&f6i->gc_link) before inserting a
> f6i (fib6_info) to tb6_gc_hlist.
> 
> The current implementation checks if f6i->fib6_table is not NULL to
> determines if a f6i is on a tree, however it is not enough. When a f6i is
> removed from a fib6_table, f6i->fib6_table is not reset. However, fib6_node
> is always reset when a f6i is removed from a fib6_table and is set when a
> f6i is added to a fib6_table. So, f6i->fib6_node is a reliable way to
> determine if a f6i is on a tree.

Which is an indication that the table is not the right check but neither
is the fib6_node. If expires is set on a route entry, add it to the
gc_list; if expires is reset on a route entry, remove it from the
gc_list. If the value of expires is changed while on the gc_list list,
just update the expires value.


