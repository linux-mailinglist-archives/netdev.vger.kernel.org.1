Return-Path: <netdev+bounces-181319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5340A846DD
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 16:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A14F3B3A86
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 14:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EA128CF6A;
	Thu, 10 Apr 2025 14:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lblWHTXQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D69F28CF66
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 14:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744296369; cv=none; b=HJpzgiYuF3LVVhmeYGvOQoo2w7EYalBuASdfbYm1mQ/cEYvJ/TtyOP5PtkfkA2R2onJHCzrCdSXzA140/3dqO7ieT29a7vRds39j86N5YHdTF/vHRcRc4RTlFbDeWayr0MMacYYguLPCOtboNPK6xxi8wOwtdGRUl3+eOopkWaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744296369; c=relaxed/simple;
	bh=H+sFb4nSMqzo0Az07VpAlmhDe0Mav7XDp0oRSWVHraU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N24MjG/OQ4Rjx+4NVsqcxomlinSvSD5IQIq20lICF94S3tpZD+E2n1Rkv/6eEDfr4wqz0KlJAY0aQ5XlzddN4cFrc1hZN86VG6aURr1G6U0zzI8Jo+M074tcnNH74QqeiZFsjhQONBrqM4GBunHTkwb//L2VDg9uoXkyQrwUArY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lblWHTXQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE44C4CEDD;
	Thu, 10 Apr 2025 14:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744296368;
	bh=H+sFb4nSMqzo0Az07VpAlmhDe0Mav7XDp0oRSWVHraU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lblWHTXQXRbUtOIW+UMLe/wJ1ljrtPYFlgtzP0LVgViKCoqsKNo5EnEXHIZOyALuk
	 jzYGaC4Nov9GGVgkyyREfod4Mic2MekPXULZIMHtY0huLjYs56ScmwexMFewF/f9tf
	 ZSEznpaFTAu943eMJ+9R1IAO/akYavbfL/rIx/J1gDyHcjr0qAHvsWCiKCR55qm340
	 w+wy+G1IpIV3fw/uU0YQPAcSbDHKK9bJquAUx1OnwOI7TomYr3WIDOGhJAS2DrWdcC
	 5bvkprfkyYo1sFOGeA9QLisRixUPOZDg5D32wfUbqcOx+4GkOpRizNVEUwlwu9s0wW
	 C0jDK+sI5ifCA==
Message-ID: <5f939ce9-6d82-4a94-8adc-aab21c330fa0@kernel.org>
Date: Thu, 10 Apr 2025 08:46:07 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 06/14] ipv4: ip_tunnel: Convert
 ip_tunnel_delete_nets() callers to ->exit_rtnl().
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
References: <20250410022004.8668-1-kuniyu@amazon.com>
 <20250410022004.8668-7-kuniyu@amazon.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250410022004.8668-7-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/9/25 8:19 PM, Kuniyuki Iwashima wrote:
> ip_tunnel_delete_nets() iterates the dying netns list and performs the
> same operations for each.
> 
> Let's export ip_tunnel_destroy() as ip_tunnel_delete_net() and call it
> from ->exit_rtnl().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
> Cc: David Ahern <dsahern@kernel.org>
> Cc: Steffen Klassert <steffen.klassert@secunet.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> ---
>  include/net/ip_tunnels.h |  7 +++----
>  net/ipv4/ip_gre.c        | 27 ++++++++++++---------------
>  net/ipv4/ip_tunnel.c     | 25 +++++++------------------
>  net/ipv4/ip_vti.c        |  9 ++++-----
>  net/ipv4/ipip.c          |  9 ++++-----
>  5 files changed, 30 insertions(+), 47 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



