Return-Path: <netdev+bounces-224097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C06B80B1F
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85A107BA8AA
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56F434135E;
	Wed, 17 Sep 2025 15:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCMljDv9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3E9341360
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 15:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123571; cv=none; b=Cx/yqmr0OjHK+KlZ8O9yu0VFJzRrJUcixr94VtT/Kx36ueYkEx6lLPTqRs18fKzp45YMvzppxmkiQvcA88AG/PAY19rwX10rFqGXFVilXFbfmbrHSKEauADK8LeOCkI4FQ1DYgLM8VEgakc03m1SzVNtQhPIJXuWMF6zEZdONIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123571; c=relaxed/simple;
	bh=az/OFVz230XFrSks6xi2HFyjTWpfolow49KvdHiw9/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uPX+DqFQXfEp0cNqSo0peFG+3cYWCqOmqA5HUjKNIUuXaNTIH8LY+aK/nagUECQMccPkYbJPzekUFRCdtxW7inE2mlKT63ySu6bYBrI6VWetYrQJrzQONnE/0WeNQ8qb/VORlh0tgXw8fe4d7BkmQUUXHof2LP0htuxJuRc3LfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCMljDv9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF350C4CEE7;
	Wed, 17 Sep 2025 15:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758123571;
	bh=az/OFVz230XFrSks6xi2HFyjTWpfolow49KvdHiw9/Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RCMljDv956cLY0VUTSA/XUGm/U14izZiktQAp8QAlHM2Rhovm4FnIjpAjTC1Ppjb0
	 +D+fFbdoUpp61QEiTyft0Ll65SWIgk8YpUCGWe/yINJZQm4KisMDm1J3KdHLtNKlru
	 UWPLZpc99sO7YgaOsn6gkwjxCCUlrdfRbqNAEJrPa1Dr8Pokk5Xo/yuDzs8phd5NJL
	 W94seUd55n4N7BFqwqnqijQqvWXup2H3DFgtEN1kZ/bl3ORrhsl03FRIPIzs9IuZZZ
	 H/OHy8C1ybqwXTLxoS7NDJwwm1hOT7pVDGdFUOXzM/M4eel6iklaXZ9iHROoVNbFI4
	 i5UoXJ3FQC3wg==
Message-ID: <c9cd9193-d0cd-4cc8-88cd-4fcc205bbeba@kernel.org>
Date: Wed, 17 Sep 2025 09:39:30 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 05/10] udp: refine __udp_enqueue_schedule_skb()
 test
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20250916160951.541279-1-edumazet@google.com>
 <20250916160951.541279-6-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250916160951.541279-6-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/16/25 10:09 AM, Eric Dumazet wrote:
> Commit 5a465a0da13e ("udp: Fix multiple wraparounds
> of sk->sk_rmem_alloc.") allowed to slightly overshoot
> sk->sk_rmem_alloc, when many cpus are trying
> to feed packets to a common UDP socket.
> 
> This patch, combined with the following one reduces
> false sharing on the victim socket under DDOS.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/udp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



