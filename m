Return-Path: <netdev+bounces-184788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CA6A972EA
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 18:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C908D3B40AE
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 16:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604B5293445;
	Tue, 22 Apr 2025 16:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tee2IogN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A95A28936D
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 16:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745340085; cv=none; b=dj9qv1YwCK2JvEY/VlmIH/iZ8oaikfmY91wqb2ikZZMeb7LuZwYlpeyrR2wkaZqSpzjadnaQ8IA8VRMOXxzdsKB7TFeV1wt3it83yxU4r950KMecwb0s8dA6xjMT38bhnr4t2y8SjsLLSrXHZtbyZWTeW2qlBCFka7fFO8hd2y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745340085; c=relaxed/simple;
	bh=6n/1kSWKqfIHM3olYgk2R4VxdQGpR5nZksTL+JLMvWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D0AoVm3qEB3vg75KATaYTy+AVjYFx63PZ0szW8Qckld5LUuikA/H9cyZpq6s7Bq/yixga86qNeS3lb6pXGhHYympCMCQTRtlOg9d1YJbquZmqioofiUrY5qcf1ThVniuiKzpjYxR/jROAw4b9++zOxpgJ4RY2zQm6PCIvxrQP+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tee2IogN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54206C4CEEB;
	Tue, 22 Apr 2025 16:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745340084;
	bh=6n/1kSWKqfIHM3olYgk2R4VxdQGpR5nZksTL+JLMvWA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tee2IogNLPohZhllRKxGI9YjngAWBGfVL0lC//Cwc5p53gAX0Oa3a/77/n7vwDi+g
	 F4jtnNOPryakYpCcmyQiTWkYPjeBe9wMU0KYq0urYSZ9IKqpwmjftwUWkd4cPA89pg
	 gNpQZdMcZ2o+18mfErpNTh0jGv1JrvovD8GGb8iOJ5qf7hgz87QmGoQ9X21LMm3PEZ
	 8FMsgCqCv4njxmM/pMLQXEobzCQFRiL4VT6HVORv1T7ROxHYzHhGCX04gGT+/rsrIM
	 qTtSK7tsXyr/xrB2dMeM3LaH9lfO+0A3w9IG4hnXZXPwtMYTHh/IiwrHLLMs0Ypd6D
	 08I7MfptJ6Luw==
Message-ID: <84a4b04f-492e-4004-8fb8-25464aea56e3@kernel.org>
Date: Tue, 22 Apr 2025 09:41:23 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] ip: load balance tcp connections to single
 dst addr and port
Content-Language: en-US
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, idosch@nvidia.com, kuniyu@amazon.com,
 Willem de Bruijn <willemb@google.com>
References: <20250420180537.2973960-1-willemdebruijn.kernel@gmail.com>
 <20250420180537.2973960-3-willemdebruijn.kernel@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250420180537.2973960-3-willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/20/25 12:04 PM, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Load balance new TCP connections across nexthops also when they
> connect to the same service at a single remote address and port.
> 
> This affects only port-based multipath hashing:
> fib_multipath_hash_policy 1 or 3.
> 
> Local connections must choose both a source address and port when
> connecting to a remote service, in ip_route_connect. This
> "chicken-and-egg problem" (commit 2d7192d6cbab ("ipv4: Sanitize and
> simplify ip_route_{connect,newports}()")) is resolved by first
> selecting a source address, by looking up a route using the zero
> wildcard source port and address.
> 
> As a result multiple connections to the same destination address and
> port have no entropy in fib_multipath_hash.
> 
> This is not a problem when forwarding, as skb-based hashing has a
> 4-tuple. Nor when establishing UDP connections, as autobind there
> selects a port before reaching ip_route_connect.
> 
> Load balance also TCP, by using a random port in fib_multipath_hash.
> Port assignment in inet_hash_connect is not atomic with
> ip_route_connect. Thus ports are unpredictable, effectively random.
> 

can the call to inet_hash_connect be moved up? Get an actual sport
assignment and then use it for routing lookups.



