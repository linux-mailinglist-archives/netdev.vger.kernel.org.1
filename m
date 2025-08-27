Return-Path: <netdev+bounces-217334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DC2B3858F
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 16:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 702A93A8B39
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 14:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D902472B6;
	Wed, 27 Aug 2025 14:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvlG0lg+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E496E201269
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 14:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756306629; cv=none; b=u7dYMAueKKgDFoP3UOgySjT3jVPxmQQPnBBZ9oRAqHHz5rcXnu+GtuNM50RLcTZ2+8DPoPHkvT2NWiIKc4Eq1hXHkAYJrPcBjw9jl9XaLVQc25vr4BaxFROTC3SkoyBREblO75WU6yK4EegymLqL5qqj1cgjbTL7vrscPRe71c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756306629; c=relaxed/simple;
	bh=bDk40krWULpcO8Max4q5h/s0FL9OgGiGzhA6sAGscKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zoief3vOp9/Sa0E6VPkN/Ja/uBj9cWbfOejbgcckVooeVhgDRIZj6I66M6Xh8HHetfvimICRzhNuQdjPByKyvthDRO/hEOUQ24lIkV95dBFzSWGCU7nOdI3A29mLJkwBuiCCPHDiKn2kQpbHr+B8szeUZZAQihZkmlu4v357fd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvlG0lg+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B16CC4CEEB;
	Wed, 27 Aug 2025 14:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756306628;
	bh=bDk40krWULpcO8Max4q5h/s0FL9OgGiGzhA6sAGscKE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PvlG0lg+Ntkx1o81Dx/LSl+DBnhrTa8ewPgfeEZp8Na3zROQYRZlUr66yEykk4xIB
	 O9kBHFTYVC+v0VGU7mvKQBDahuH+sgcTnoQm5nk7AL13vAr+uS6y5hkgwVmPKi8kcJ
	 UWKqekFWb7k/B1H/XJfW+l0i0Z5T0AA4PK3DfjIeZ1pAKV8GxZoldaMm5EOnXdnvrg
	 KstyTQzs8SF6dyJlzw9599iZQIz7COjLXthwVBPyh2khF08fX9AzxYVZjDjd2UlGHD
	 JcNj0ucP223wW4DDESXPZsg/jc4zOng/DNrCE0yV40t6YqFJgsh1QcCfmAsEk2AYO3
	 LXIhcoFJ/FneA==
Message-ID: <8f2d8a47-4531-4d3b-9a64-cf9477b7b41f@kernel.org>
Date: Wed, 27 Aug 2025 08:57:07 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] inet: ping: make ping_port_rover per netns
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20250827120503.3299990-1-edumazet@google.com>
 <20250827120503.3299990-4-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250827120503.3299990-4-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/25 6:05 AM, Eric Dumazet wrote:
> @@ -84,12 +82,12 @@ int ping_get_port(struct sock *sk, unsigned short ident)
>  	isk = inet_sk(sk);
>  	spin_lock(&ping_table.lock);
>  	if (ident == 0) {
> +		u16 result = net->ipv4.ping_port_rover + 1;
>  		u32 i;
> -		u16 result = ping_port_rover + 1;
>  
>  		for (i = 0; i < (1L << 16); i++, result++) {
>  			if (!result)
> -				result++; /* avoid zero */
> +				continue; /* avoid zero */
>  			hlist = ping_hashslot(&ping_table, net, result);
>  			sk_for_each(sk2, hlist) {
>  				if (!net_eq(sock_net(sk2), net))
> @@ -101,7 +99,7 @@ int ping_get_port(struct sock *sk, unsigned short ident)
>  			}
>  
>  			/* found */
> -			ping_port_rover = ident = result;
> +			net->ipv4.ping_port_rover = ident = result;

READ_ONCE above and WRITE_ONCE here?



