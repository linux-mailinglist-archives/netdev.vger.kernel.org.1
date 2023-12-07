Return-Path: <netdev+bounces-55107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B89809681
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 00:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AABF61F211D5
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 23:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A2950247;
	Thu,  7 Dec 2023 23:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QglD+0qA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FA2840C0
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 23:20:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6A1C433C7;
	Thu,  7 Dec 2023 23:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701991240;
	bh=TxNizk/xsjo0U5cml2LRcW12DIQQRVlOuZgPuO1MbLQ=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=QglD+0qA1REdGzVh10PihoIj4CZO9k3ZKq9wB59UUKrNPPxBSl1epeJkGgy6zGk2b
	 uKq338aSnGpo4z6TjFb/ncAs9GpH7B5sSWvsooAw5HEx6hYPYMRbEbAExZ63rfjnro
	 eoK65BCaxNraRrH6hyoQLYDJJ+dEnkCZpGxtLoKdK2PCIX9RvWvzMZQrbdMQKVZ1o3
	 SDJA+t+uEc6aH/wYcGYJHbJna7jKJ27DGHw6oQ97leoNwQNifC7tfCcqWpe8YOGX4H
	 PTLe0KApXaJ0C+q6VxAvYv4JRsnxrU5nerQv2cO8rw9lUP1BLsTMbaBWMbwVHA4yYB
	 pKYoHJ47CXF3A==
Message-ID: <4eebd408-ee47-4ef0-bb72-0c7abad3eecf@kernel.org>
Date: Thu, 7 Dec 2023 16:20:39 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/ipv6: insert the fib6 gc_link of a fib6_info
 only if in fib6.
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
To: thinker.li@gmail.com, netdev@vger.kernel.org, martin.lau@linux.dev,
 kernel-team@meta.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
Cc: sinquersw@gmail.com, kuifeng@meta.com,
 syzbot+c15aa445274af8674f41@syzkaller.appspotmail.com
References: <20231207221627.746324-1-thinker.li@gmail.com>
 <8f44514b-f5b4-4fd1-b361-32bb10ed14ad@kernel.org>
In-Reply-To: <8f44514b-f5b4-4fd1-b361-32bb10ed14ad@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/7/23 4:17 PM, David Ahern wrote:
> On 12/7/23 3:16 PM, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> Check f6i->fib6_node before inserting a f6i (fib6_info) to tb6_gc_hlist.
> 
> any place setting expires should know if the entry is in a table or not.
> 
> And the syzbot report contains a reproducer, a kernel config and other
> means to test a patch.
> 

Fundamentally, the set and clear helpers are doing 2 things; they need
to be split into separate helpers.

