Return-Path: <netdev+bounces-102316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D2C9025DA
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 17:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20AA9B2DA36
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 15:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DD5137747;
	Mon, 10 Jun 2024 15:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="th/ONnBQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9066A12FB34
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 15:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718033410; cv=none; b=kFsuzyRZKl7JdALTR7D5g/K8ioXf1n2b4sJyILTpXtLHF72bVylSGuTqVGp8sEU24n74ZtliXCz+8AS5yDUJ1+L7Lo/t2UpMqIgpN13TV3XQ0b9nAQoZAKo/WiFY3zCldfakm7giGmYLAzavP8hcZs3qp5RryAldTL+zEQJ49BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718033410; c=relaxed/simple;
	bh=M0zD/QABCewA709z0OEV4h/f7zo6w9P0d7rCbrKqa7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WFf2PeAAwZh6WySw2Bl9CgdcYOXMUHcw9HC3HJwPflsXWEzFovL3Ad9BFUjVdDUw8MjJB+mFvVD2Jz1yO854r4GFO6u4Z/lejYBD1WOM2ajAoI1zPWyXFeILKfmB/qa8T3jeGpLeJGIm8H/HtbRNW0arjGfJ53KnrWMHwgeQCzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=th/ONnBQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1DE8C2BBFC;
	Mon, 10 Jun 2024 15:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718033410;
	bh=M0zD/QABCewA709z0OEV4h/f7zo6w9P0d7rCbrKqa7c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=th/ONnBQ5G6K+DiO0E8/EPfe3HO0gsPc/x9p5AK6C/q2WdJ8Wkror8Q/7X8hnPdYC
	 A68H21L+vZGu2ao2ERjty4m/2K1/d1UadpRzAsS0Lir4zX5h9t4U75ZupyY6IeNDlm
	 6jzMROw1gqm8KYo2lZ0uX7+/A+cZLQyd4kLjaRpLCvVMfGl40gST2Ja6oSsfCeMnUf
	 PAdR8KNcWvgKkJhTjEpRa5/0uypwBJVwe9EXNqvCD1NzT89ZU3LY4Q5sK1AyjZxUP/
	 Ruvj4iyAP6lLKW2t5f4hjM98lnWRmNrPD1TPfHdoihrW0IAQ37ti5tkY2LLp/33diw
	 eoBVKv9hsaA5g==
Message-ID: <503e65af-1cc7-4893-8569-632790171de8@kernel.org>
Date: Mon, 10 Jun 2024 09:30:08 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tcp: fix race in tcp_v6_syn_recv_sock()
Content-Language: en-US
To: Simon Horman <horms@kernel.org>, Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Neal Cardwell <ncardwell@google.com>, eric.dumazet@gmail.com
References: <20240606154652.360331-1-edumazet@google.com>
 <20240608132544.GF27689@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240608132544.GF27689@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/8/24 7:25 AM, Simon Horman wrote:
> + David Ahern
> 
> On Thu, Jun 06, 2024 at 03:46:51PM +0000, Eric Dumazet wrote:
>> tcp_v6_syn_recv_sock() calls ip6_dst_store() before
>> inet_sk(newsk)->pinet6 has been set up.
>>
>> This means ip6_dst_store() writes over the parent (listener)
>> np->dst_cookie.
>>
>> This is racy because multiple threads could share the same
>> parent and their final np->dst_cookie could be wrong.
>>
>> Move ip6_dst_store() call after inet_sk(newsk)->pinet6
>> has been changed and after the copy of parent ipv6_pinfo.
>>
>> Fixes: e994b2f0fb92 ("tcp: do not lock listener to process SYN packets")
>> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
>> ---
>>  net/ipv6/tcp_ipv6.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>

Reviewed-by: David Ahern <dsahern@kernel.org>



