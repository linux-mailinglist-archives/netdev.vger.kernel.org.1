Return-Path: <netdev+bounces-111619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 074EA931D30
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 00:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8819AB210FE
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 22:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5BB13B585;
	Mon, 15 Jul 2024 22:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXcSBYMT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAED51CAB3
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 22:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721082811; cv=none; b=bpIPa+rJ61ciVEgZU5mk2Nors4V3s0Ad5ECGnCxISy0ppNoca7Cb7/yGyc44dFwrsXhFsGyDU+a8JtWphKbiWEiIxLOaIGe147wnPCTQsj/BfY4Z2Kypb8LkRgo6+PW/SUTD/M0qBNtQ2mp9cw/R+d7Lq2bH/Mjggo9x+MATx4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721082811; c=relaxed/simple;
	bh=+jCnDLjuYhIiJh73YqbqXQHt/RMlxjCbNmh3U0//rxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qi4gs2/xs2CCqaPvcyjV9jpv60/ofO62WNEvlSAzn79trMIZcea4//MSedzqxgmMdGvBXLaG0eRyyNCZQDtkTo7M96ovwD+qGvg5acTEU6lPP02IPQzSQwrXJZcDXv5x6wuMWBl7LwmlXHQIJrmORoQ2fOpU4Lgh8iGmBnFPTrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXcSBYMT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DEA8C32782;
	Mon, 15 Jul 2024 22:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721082810;
	bh=+jCnDLjuYhIiJh73YqbqXQHt/RMlxjCbNmh3U0//rxs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hXcSBYMT/NJNVmw8T/h5Ai1ccQjns6/h41Vj0YfUppqix/qWtiotUWRPgHiTcIwwT
	 zepjLif8zBFjcBmUidip1GO/tCkIeeaKtLvleicTicn27FD60G2ig5HqBe2LBLq4Og
	 2eWrxIQQCgYr1owolAz4JuxnW0UtYiUiOCSs7LSuf0GIwHMxTsRRo+LWwYb6O1ahox
	 fR3JjbjdFYoSL+wNm93+wfSNUPgGcxNlD4Ku/Drhp59j/uvqA0Sf90Ejxni8DIjZ5c
	 W5Pke0B5WG8uGtLrdB+oZclz/4O+wr9wSaeFvCrjmhh5heP4N8Lk7yU46G4Snd9Br4
	 RF9cPTV/nhm7w==
Message-ID: <91e2fa95-1db1-47a0-947a-82d7fcd762fe@kernel.org>
Date: Mon, 15 Jul 2024 15:33:29 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] ipv4: Fix incorrect TOS in route get reply
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, gnault@redhat.com, roopa@cumulusnetworks.com
References: <20240715142354.3697987-1-idosch@nvidia.com>
 <20240715142354.3697987-2-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240715142354.3697987-2-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/15/24 7:23 AM, Ido Schimmel wrote:
> The TOS value that is returned to user space in the route get reply is
> the one with which the lookup was performed ('fl4->flowi4_tos'). This is
> fine when the matched route is configured with a TOS as it would not
> match if its TOS value did not match the one with which the lookup was
> performed.
> 
> However, matching on TOS is only performed when the route's TOS is not
> zero. It is therefore possible to have the kernel incorrectly return a
> non-zero TOS:
> 
>  # ip link add name dummy1 up type dummy
>  # ip address add 192.0.2.1/24 dev dummy1
>  # ip route get 192.0.2.2 tos 0xfc
>  192.0.2.2 tos 0x1c dev dummy1 src 192.0.2.1 uid 0
>      cache
> 
> Fix by adding a DSCP field to the FIB result structure (inside an
> existing 4 bytes hole), populating it in the route lookup and using it
> when filling the route get reply.
> 
> Output after the patch:
> 
>  # ip link add name dummy1 up type dummy
>  # ip address add 192.0.2.1/24 dev dummy1
>  # ip route get 192.0.2.2 tos 0xfc
>  192.0.2.2 dev dummy1 src 192.0.2.1 uid 0
>      cache
> 
> Fixes: 1a00fee4ffb2 ("ipv4: Remove rt_key_{src,dst,tos} from struct rtable.")
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  include/net/ip_fib.h |  1 +
>  net/ipv4/fib_trie.c  |  1 +
>  net/ipv4/route.c     | 14 +++++++-------
>  3 files changed, 9 insertions(+), 7 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



