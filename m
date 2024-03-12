Return-Path: <netdev+bounces-79357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F49878D7A
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 04:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9672728242F
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 03:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20471AD2C;
	Tue, 12 Mar 2024 03:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncTK9V7O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E968F51
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 03:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710213967; cv=none; b=Y+t4RnwOQYeU0XgZE7W2x3nX9wmJ71E1659MEDGGkKmjIOP93aV88q8hU02Dw4/iBHz1ugy5QePK+t5IMMFyb+hinF6Xq+I0yxqkOxFZ6ZMA8cQzuf9qbvMkH4MU9qfaXShygf8uoOZBfYExZTZvoXwMAOId35rmvxZplT8V+h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710213967; c=relaxed/simple;
	bh=t8qGmXaal2n4Z/b9X2EgdKUjWir0xz1rkZUyiIervKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gk7NPmSBE7pcu1jxDseDBCOsSiZNKv79jUdyL+3pi3M0ButankSUETKBd1n3TmBwlrsbSKPpMa1wT8m3TAqpmSgto/WBCyZuhtaBJwXXP/cA6iEuM07ldVNYlKG03hnhXKgRF1vQIy1bO5OCZqqrZRjwACqlFljEx+XisfcE7yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncTK9V7O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA5DC433F1;
	Tue, 12 Mar 2024 03:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710213966;
	bh=t8qGmXaal2n4Z/b9X2EgdKUjWir0xz1rkZUyiIervKM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ncTK9V7O7ySrbFJcdEYrj8n38o4vl9JzinZ6Hhxb92IqdvMmZ21TtXkw/rwH9gQ9M
	 YX3RVZKpFVemIo0fl12jJWGboRZbYnDXtqH/Shudz/DPDJ2FkeixxbPwYeyZPB4fpp
	 CJ4tGnReSOEUBVPlgWwab4xlSKheX6mgmsD/bOm/GXclmkZol74iYVHN8j3yWbRRlR
	 l9hzW1tn03l/yXnODHBguE08M8Pj3YqPQ+IeFzkxlxlINWCcK2j31EdzOOltkS8bHV
	 vea52tl+txDdw8sGi74P8p/mBdCOaD1Xi4ebfPqumzfzQ57k3MKYhRFJ9ypxN0bm4q
	 QpmBlz0QPK4aQ==
Message-ID: <8f0f8208-6103-40e3-a66f-ad6fdc17950f@kernel.org>
Date: Mon, 11 Mar 2024 21:26:04 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/4] nexthop: Only parse NHA_OP_FLAGS for get
 messages that require it
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, petrm@nvidia.com
References: <20240311162307.545385-1-idosch@nvidia.com>
 <20240311162307.545385-2-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240311162307.545385-2-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/24 10:23 AM, Ido Schimmel wrote:
> The attribute is parsed into 'op_flags' in nh_valid_get_del_req() which
> is called from the handlers of three message types: RTM_DELNEXTHOP,
> RTM_GETNEXTHOPBUCKET and RTM_GETNEXTHOP. The attribute is only used by
> the latter and rejected by the policies of the other two.
> 
> Pass 'op_flags' as NULL from the handlers of the other two and only
> parse the attribute when the argument is not NULL.
> 
> This is a preparation for a subsequent patch.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
>     v2:
>     * New patch
> 
>  net/ipv4/nexthop.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



