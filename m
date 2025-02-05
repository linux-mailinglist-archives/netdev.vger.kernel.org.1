Return-Path: <netdev+bounces-163204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB20A2995D
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 19:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F8611883AC2
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 18:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFAD1FDA8A;
	Wed,  5 Feb 2025 18:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cW3L8Akq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E701FCFDA
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 18:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738781017; cv=none; b=E+xW4FgUa0sPfDL0M6ucIU0XkP8GOVJJWJuO+YRIAD/a4rzuH3/oKYPhgtLE3fPGDrl6L9ZIRwxuF+qBcTlFjYNAbl3aeN/AHEC7HiaWsDL7MfuJK5bRSOCGuR5Z2x/93M+t181upwFuFcLHKtfQ8+m4R5O4w8ToyPQj8/58/WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738781017; c=relaxed/simple;
	bh=zp9osJNoZyypSjqHQjKLAb37/Ztk3mYlSTKRNcbY4YM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ryBf9uN5llBJ2U3vzzZpt5+u6NY8U8XxF6ZTKu35YV0wr7OwRHT7j2pYy5jHALNt0VeT8abI5+PqANQhAYZCBaUoUYIA0DogtNaCA13iSijllPMuhV8kRjDvlduczymHJaQiYpxz021NZncQQaQBk4qBhi7FPGgGdpJ94P9K3sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cW3L8Akq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE53C4CED1;
	Wed,  5 Feb 2025 18:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738781017;
	bh=zp9osJNoZyypSjqHQjKLAb37/Ztk3mYlSTKRNcbY4YM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cW3L8AkqUcoeANkp50hHNdSU58tvekUXiDG8GH0FLHNHcfUYWD/nYtRXxgC50vR4n
	 hPpHNwohQQot4XxgdBC94VLvDavIaZYqIAbf2IjRa6l9wrfFYN4RasLWRj2iTrp4fe
	 UXCt4eXUIcf2zCaQdevZBGbE7iMzihr0r/DVXimkFrteKwMHGSu/KBWcVpX09lgDOq
	 ZO8/u3d11ohbBGXSxOtUL8NngWwxiKr99lRX4h2hi/DD7XCqkb8WcnHig6oKGUAgyx
	 xivAOxhIOShrgEsC5S/0EL4rP2tRpMzbPPZag4ybldv+uVaD248jf4aG6GbrQ7h/gQ
	 xfWLL7zVr+5Wg==
Message-ID: <807a8915-6c3b-495b-8b6b-529e696dff00@kernel.org>
Date: Wed, 5 Feb 2025 11:43:35 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 00/10] io_uring zero copy rx
Content-Language: en-US
To: David Wei <dw@davidwei.uk>, netdev@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Mina Almasry <almasrymina@google.com>,
 Stanislav Fomichev <stfomichev@gmail.com>, Joe Damato <jdamato@fastly.com>,
 Pedro Tammela <pctammela@mojatatu.com>
References: <20250204215622.695511-1-dw@davidwei.uk>
 <aa3f85be-a7d9-4f41-9fe3-d7d711697079@kernel.org>
 <da6b478a-065a-4f02-acd2-03c6d6dea9fa@davidwei.uk>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <da6b478a-065a-4f02-acd2-03c6d6dea9fa@davidwei.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/5/25 11:00 AM, David Wei wrote:
> On 2025-02-05 09:44, David Ahern wrote:
>> On 2/4/25 2:56 PM, David Wei wrote:
>>> We share netdev core infra with devmem TCP. The main difference is that
>>> io_uring is used for the uAPI and the lifetime of all objects are bound
>>> to an io_uring instance. Data is 'read' using a new io_uring request
>>> type. When done, data is returned via a new shared refill queue. A zero
>>> copy page pool refills a hw rx queue from this refill queue directly. Of
>>> course, the lifetime of these data buffers are managed by io_uring
>>> rather than the networking stack, with different refcounting rules.
>>
>> just to make sure I understand, working with GPU memory as well as host
>> memory is not a goal of this patch set?
> 
> Yes, this patchset is only for host memory.

And is GPU memory on the near term to-do list?

