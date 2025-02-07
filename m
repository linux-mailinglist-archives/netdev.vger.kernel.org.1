Return-Path: <netdev+bounces-164201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4411BA2CE68
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 21:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E5893AB0C2
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 20:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0DD194147;
	Fri,  7 Feb 2025 20:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NN2E9iMC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A0871747
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 20:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738961134; cv=none; b=UujK2tYN9Gpf0i66NJCEqQBbfoRA9Bci0j8Rl3bfcoQA0czMhKxPlVXW7aBtwTQ6viwyshlCV4r7iovKQ0MYpKFZqNR9aGknq/XfVI0d56eM6DXviOZfI55RPJPQvf5Xs/qAfN1lDB267uvR1qROoEyJf7DfPKWLQLUWaRUDen8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738961134; c=relaxed/simple;
	bh=vlvYbAsAEiMeMo5oOvyt+UTKg5akzjWvaYL/IFl99Zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oMhUJdUbuPCp0HuY7lJ3MfqzrMIN3dbc/G3ZW6I1wpd7eF5Kk7G/mQP/2LMF1l73RiL8e8isI6RBrDA9bJQqpmt9vuf9iXMERST6Dacr2G3mMSHdNjAJKdl2+gbF0TYm133q4jSX7S3Lk5Ov7Fbw+VBzwiJOm0/Vc5nc3b3dgI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NN2E9iMC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C499C4CED1;
	Fri,  7 Feb 2025 20:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738961134;
	bh=vlvYbAsAEiMeMo5oOvyt+UTKg5akzjWvaYL/IFl99Zk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NN2E9iMC4GLqtNsPH3eWKqdcZLl+KQq6UlLUK9JmhAdv9tDiKLuaRXWqF50SXlmWO
	 RCXaZLFzxhJm9Tf3eBhFYBhOfC/XjBGbhjfHH8g/pogPq45au63/RTGHdGuSD8nhhL
	 Hz/AOhRnDYwnyNAaVyP2EgoiprJDbTSBfOntDIGULh+hG+qxqHiLEEUAAAHdojbYP6
	 1GV7lpSweAhlh1kqjEQhvnIVAKFlaHqwZCzI2pxsWVH3WNa8aCpj1ZuhGNduQun1Je
	 h8H85A2FmcQ5tcByaFpQRCMr7grmg3Cc8HMi5hccTipReUthaaU8uRozcePBio1Lb0
	 exLrPaXobNEjQ==
Message-ID: <90a599d3-fb7e-4b99-b25b-dfbd44018f8b@kernel.org>
Date: Fri, 7 Feb 2025 13:45:33 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 6/8] vrf: use RCU protection in l3mdev_l3_out()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
References: <20250207135841.1948589-1-edumazet@google.com>
 <20250207135841.1948589-7-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250207135841.1948589-7-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/7/25 6:58 AM, Eric Dumazet wrote:
> l3mdev_l3_out() can be called without RCU being held:
> 
> raw_sendmsg()
>  ip_push_pending_frames()
>   ip_send_skb()
>    ip_local_out()
>     __ip_local_out()
>      l3mdev_ip_out()
> 
> Add rcu_read_lock() / rcu_read_unlock() pair to avoid
> a potential UAF.
> 
> Fixes: a8e3e1a9f020 ("net: l3mdev: Add hook to output path")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/l3mdev.h | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


