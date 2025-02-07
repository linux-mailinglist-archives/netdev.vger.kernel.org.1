Return-Path: <netdev+bounces-164198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C06AA2CE55
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 21:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABD91188F569
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 20:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49EC1DE3D8;
	Fri,  7 Feb 2025 20:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzuu8czv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE541DE3D7
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 20:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738960899; cv=none; b=M7+x7VejG131948ZXfRaXOBnzDTs4kapKBK1VwPD+7n8MmpiFCGnAO14deW15FYQEe26UxeMyn43dqz4i2gEAMxi1fZSoPFfsYcHEL0UJzigwhBDxSvk7ECG6mdsc9gS+wZzy5OfuO6ZjMqTPQoPw/xLGJw/UZUNJyFGc1PPGG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738960899; c=relaxed/simple;
	bh=EQmWSN3GUB87GGGWeFaKRUVw3NTW82dnOWZrVr+GMOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kb8NhF0/hCb7O4vqu+qx/Rs9/ETA1k9Bul6tYi0QO5oklDCiiPFP0AmmDuybn1G31KGL80h4SwGhYvfnh39jqOoBNEZ5HHyeCHAwCEABG7E+uDuMuFh5hIG9aHOl7WK6hlfxC/iHqNiVHX8xDxPd8ZATGut9lpMvN6cwyrJy7Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tzuu8czv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2724C4CED1;
	Fri,  7 Feb 2025 20:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738960899;
	bh=EQmWSN3GUB87GGGWeFaKRUVw3NTW82dnOWZrVr+GMOA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tzuu8czvDBTZQ3FD0dL1f/z+77jM6GdrRT49g3bC1WfHpDPUEzYfcw+7QtNeTFhRH
	 fwyhq9H+iL2fg95si37u3/VGKSTv1KZSOs/WcDv7xvGEO4DrfXf/cykl/zQLYc4fZm
	 zXFCB3xKYYg3VE/FqUPY6+7aJH14SVX572xIWyTy8ijwWBX/NUwfxqxuQbGZBTTd6d
	 4NYlrckxLlid1iwHavgMWgeK7ctKghvlmZRaw8quVbHal0ZWviExOM2FU7h8SA0HeF
	 1avZ2Tuqy9BVsvHrST7Mse8bB4GgNSdTmZdTpIJ2rRqESmNUEo70LhYd740toyDH8v
	 99Nb+cJm8PaEg==
Message-ID: <285e43ed-d908-4383-9b18-8921400707f2@kernel.org>
Date: Fri, 7 Feb 2025 13:41:38 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/8] ndisc: use RCU protection in ndisc_alloc_skb()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
References: <20250207135841.1948589-1-edumazet@google.com>
 <20250207135841.1948589-3-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250207135841.1948589-3-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/7/25 6:58 AM, Eric Dumazet wrote:
> ndisc_alloc_skb() can be called without RTNL or RCU being held.
> 
> Add RCU protection to avoid possible UAF.
> 
> Fixes: de09334b9326 ("ndisc: Introduce ndisc_alloc_skb() helper.")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv6/ndisc.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



