Return-Path: <netdev+bounces-62288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4442826718
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 02:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B7B6B20A5B
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 01:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13257E2;
	Mon,  8 Jan 2024 01:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GO25aDfY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B811379C2
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 01:24:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47BBC433C7;
	Mon,  8 Jan 2024 01:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704677066;
	bh=IdonqUeAmGri45EX25OCj5L8WYm9ErnaaUI48KFw58g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GO25aDfYpa2jgpSwuDtY9rTaho7rrkTxlPmlNwb00TO2UVQcYMRymH0Yza93xfGl1
	 ZUrmD/5h09BDkxI7UGKRwn/DIseAauFpM9x5wijw9oXzh17vyDuQ4C3TkSYfw7JUJX
	 m9MA0kL42zT5PZzvMqncCGpa6PHg+Xvuluzf6GmlHEv6oK9qElA13aRBs5bHa33t37
	 rzOYFJ+dRKzTdB9h2gTW5KogQl4w54bYID3LDHvyLJH6IsA8TvMlRWL+NI5kFFrf9A
	 hiVMlJS9JOdH4XeSGoNUJ0P9mVlEpRfcREnmE+Lqd00460rfd1IDko0t0XskY7CpTV
	 x9hzzeB80nMOg==
Message-ID: <39238ffc-45d8-4f10-a9be-0e4e572f9c7c@kernel.org>
Date: Sun, 7 Jan 2024 18:24:24 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] fib: rules: use memcmp to simplify code in
 rule_exists
Content-Language: en-US
To: Zhengchao Shao <shaozhengchao@huawei.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: weiyongjun1@huawei.com, yuehaibing@huawei.com
References: <20240108011131.83295-1-shaozhengchao@huawei.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240108011131.83295-1-shaozhengchao@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/7/24 6:11 PM, Zhengchao Shao wrote:
> In the fib_rule structure, the member variables 'pref' to 'oifname' are
> consecutive. In addition, the newly generated rule uses kzalloc to
> allocate memory, and all allocated memory is initialized to 0. Therefore,
> the comparison of two fib_rule structures from 'pref' to 'oifname' can be
> simplified into the comparison of continuous memory.
> 
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
>  net/core/fib_rules.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
> 

This is control path, and I think the readability of the existing code
is better.


