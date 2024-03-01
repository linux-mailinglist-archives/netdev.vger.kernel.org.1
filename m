Return-Path: <netdev+bounces-76495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B6986DF46
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 11:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CFF1281D6E
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 10:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607802E842;
	Fri,  1 Mar 2024 10:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYYN1dmp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0D316FF46
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 10:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709289229; cv=none; b=QByvXVme9M9BeRWJ42L6DiXJRMG/I0TI0hJ/O/l8105G+l6zXxdPUGt9bDM+89M8dQ5WpDsTIkep6QYoCjmy9fj5vqIokkJ8lylc9igi2sMtY9FKBsDL8d1yyXxOjmP6OthkHvBY2LzOTA4/JCBNa2fsNk54ei1hdxdVsAOcgMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709289229; c=relaxed/simple;
	bh=acrL0owb1LKEQ9fuH71H0Yaa2wp47+hqfMOi6EkvQTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QljPIgQfnxxsYakyxZFCFN8W4w39V3DadNeCTiQfjrAiIuvxE/OP6BDEXS812YVkwobI11j4eFJMwcXxD/UE2RxeHEiflIWlXRHldYpcElfWlLm3E9wOQBBS+RJvy4+JgRk5zX+HkijP65lLx49dlZSOScvCF85Dh35CxHSgzb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYYN1dmp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D3EC433F1;
	Fri,  1 Mar 2024 10:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709289228;
	bh=acrL0owb1LKEQ9fuH71H0Yaa2wp47+hqfMOi6EkvQTs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tYYN1dmpGtlkeVkkGd5O0rHjPvJcGBF6uuQ8H2wH/z/JpbVLgZuPjjxdrVy2WJ3vI
	 MdbFg4pwOhXWy0Nat7i5/7aQeU9A1cAH7O5WCjk5qD5jjTpfNWLEwpwCaXi/6unyfq
	 NlziVMUpEK/ob2nJTnzxaLNdr7allENW+5DeWrNDvuCoQQiJ9Hs9mnVrPSLIdi7fGc
	 bwI14gtQAvHIYfo3eCWTz4YWu28FR5SY8fsQy/0t4197kLN79OjS4jQrgGC2/yNO9J
	 at9Icvtj6jxkCqpsElMQNi7gaYbGWmGRNDxvnPoX8ks8CX9io+mn1+KW++ROUso+b/
	 KOS7EeOf0qLCQ==
Message-ID: <d3047f5c-673e-4891-94b6-f2448c5385dd@kernel.org>
Date: Fri, 1 Mar 2024 11:33:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: page_pool: make page_pool_create inline
Content-Language: en-US
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 lorenzo.bianconi@redhat.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
References: <499bc85ca1d96ec1f7daff6b7df4350dc50e9256.1707931443.git.lorenzo@kernel.org>
 <20240214101450.25ee7e5d@kernel.org> <Zc0RIWXBnS1TXOnM@lore-desk>
 <CAC_iWj+5TMe8ixXrLM3DUS+RAmDu+gmb1rfcHiU04re8phQVDA@mail.gmail.com>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <CAC_iWj+5TMe8ixXrLM3DUS+RAmDu+gmb1rfcHiU04re8phQVDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 01/03/2024 11.27, Ilias Apalodimas wrote:
> 
> On Wed, 14 Feb 2024 at 21:14, Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>>
>>> On Wed, 14 Feb 2024 19:01:28 +0100 Lorenzo Bianconi wrote:
>>>> Make page_pool_create utility routine inline a remove exported symbol.
>>>
>>> But why? If you add the kdoc back the LoC saved will be 1.
>>
>> I would remove the symbol exported since it is just a wrapper for
>> page_pool_create_percpu()
> 
> I don't mind either. But the explanation above must be part of the
> commit message.

I hope my benchmark module will still work...

https://github.com/netoptimizer/prototype-kernel/blob/master/kernel/lib/bench_page_pool_simple.c#L181


--Jesper

