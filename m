Return-Path: <netdev+bounces-78515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87B387573D
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 20:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 156E21C20A26
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 19:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FF61369A4;
	Thu,  7 Mar 2024 19:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpvEbbxw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3879136666
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 19:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709839930; cv=none; b=WltbqaqsLj4xpS64ZLEvclYFa3hG0drnd7850Oq8q14DkmJrgqT2mljRQiPrsp9/0mnh4dvm/RltdeggMy7OepC+cb0wirciY/TbzEb5HjgpBYg/9Gt5n/UYTE//p6G2IqHo5W3CkBsLWdGAUd/ZnKoXOG3WBsJC7TplmpcbtjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709839930; c=relaxed/simple;
	bh=QHzINs8NzYSwc3irSU2YIgxC2fKHicdBJVqxWI2w56s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sjs4epR3Pw0PEvLtNlyux/npRu9AQYCoGx3uLk2eZTTA58zKVd/qHSOoRXrC+xK196cArJ80SIOxP35BbdUxuCHJKTWgItQfRdvGeEj0gpzj6vi3gHJ/v2mJmGCWXlish6LMHGUJEX4sqCE9wZg0ML6SDfQe0q2ls6fW4GThP3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpvEbbxw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3F5C433F1;
	Thu,  7 Mar 2024 19:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709839930;
	bh=QHzINs8NzYSwc3irSU2YIgxC2fKHicdBJVqxWI2w56s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IpvEbbxwjjeDx055PTdIaZ00MLbX4Vu/hHV+jNJbABl5csnPc+uuWjHgAxmMOWajk
	 T24R/YRPb6W0sOcCnpyihrJkT14lcltT314yG29jrM5CV5lyVXkWkCREXvbLvwZSgA
	 gZH9zFea64UlzCrsIMZIx7lT2oyoiB2srxoyA6noOyrMneENCP/zBLVFIWsE42Ouut
	 z8u3AsF7HB2YQ7qNWiip8KdEI/SPfwIiikN5J+keW2g1n03OUXhOBX1cyxbmpcIsNC
	 ZHpS1W2JirktzeMB+YMBfkGoJVZ8hxdEJ7/eiTwk6qt/l5pchmcktjpyXOnpS5ZlhB
	 KC7TKESrC8F2A==
Message-ID: <005fcd77-3830-44f7-a81e-9f4cad1b3d4b@kernel.org>
Date: Thu, 7 Mar 2024 12:32:09 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] netlink: let core handle error cases in dump
 operations
Content-Language: en-US
To: Simon Horman <horms@kernel.org>, Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, Ido Schimmel <idosch@nvidia.com>
References: <20240306102426.245689-1-edumazet@google.com>
 <20240307093530.GI281974@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240307093530.GI281974@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/7/24 2:35 AM, Simon Horman wrote:
> + Ido Schimmel, David Ahern
> 
> On Wed, Mar 06, 2024 at 10:24:26AM +0000, Eric Dumazet wrote:
>> After commit b5a899154aa9 ("netlink: handle EMSGSIZE errors
>> in the core"), we can remove some code that was not 100 % correct
>> anyway.
>>
>> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> Thanks Eric,
> 
> this looks like a nice clean-up in combination with the cited commit.

+1

> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



