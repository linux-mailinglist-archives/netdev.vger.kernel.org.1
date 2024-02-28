Return-Path: <netdev+bounces-75536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B31486A6EF
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 03:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B9CEB24B29
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 02:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAD01BC27;
	Wed, 28 Feb 2024 02:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+Dzudex"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64C71CD0F
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 02:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709088719; cv=none; b=Om+/4EjMcnIIxIHHgWRsIUsv7uS3kXU2yiZ5Ds4FEqLouLc6MzmUH+X/gOQwrSikS6+4wWPI2KAzisDcDHE83W64CSGWG2573+4KR2Yg1HEZjZGFg/IDpLtYXjqistoESply4fN8Ks7eIPtNHxIcoHteKkCpjN2zoGkPp6q9hEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709088719; c=relaxed/simple;
	bh=G4hCSIQCON/QMh3+hKfs3cprDcdEDuBYjWnI8xFrYog=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C+95eG10L3R6nG4h7DnN09GXCnnfGdxtFA/H6674zn6MAxSkkOe7yRbAbhbitA8aXy5DbBm2QCgEXkcznL80abTYYaTzorWUzNyG86QdL3DWT6vdQ8qc7hiDRP41fbgnq3UynVvBJn7zE5F1HFmcV6CdZCeWr+Tz0+shJxqpenM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+Dzudex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66ABC433F1;
	Wed, 28 Feb 2024 02:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709088719;
	bh=G4hCSIQCON/QMh3+hKfs3cprDcdEDuBYjWnI8xFrYog=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W+Dzudexik8XNzi93GBpZGEhGSBBwhuWyb0xsV9WaorCloclFRxOIGjmo0+oEL8yj
	 s4j9gv9e9fTIIJe+O0wbJgwnFK4rRi6B61v+CbATrDqqI/+aWQoezuWiXSGXUcQG1c
	 Vn1tbRCodXdW9lI/fQVuJ4FSDsFnaDuIXWd1EcouhALNhwI69+3LxZfCIQap7tpIGV
	 ELYvZC29N4rygGTVlZbZihcmy5coXIQWfnqmqmkB1M5/J8Dporu/KbAZkJKQ0zPoBj
	 Y93euXomiCfY+YBn6NjRN3qm0cIENibxB3BEfQCE1Iisad9JwFz4NHJ4421uBqs+i9
	 juWO2QwsB5A1g==
Date: Tue, 27 Feb 2024 18:51:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Jiri Pirko
 <jiri@nvidia.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 03/15] ipv6: addrconf_disable_ipv6()
 optimizations
Message-ID: <20240227185157.37355343@kernel.org>
In-Reply-To: <20240227150200.2814664-4-edumazet@google.com>
References: <20240227150200.2814664-1-edumazet@google.com>
	<20240227150200.2814664-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Feb 2024 15:01:48 +0000 Eric Dumazet wrote:
> +	if (p == &net->ipv6.devconf_dflt->disable_ipv6) {
> +		WRITE_ONCE(*p, newf);
> +		return 0;
> +	}
> +
>  	if (!rtnl_trylock())
>  		return restart_syscall();
>  
> -	net = (struct net *)table->extra2;
>  	old = *p;
>  	WRITE_ONCE(*p, newf);
>  
> -	if (p == &net->ipv6.devconf_dflt->disable_ipv6) {
> -		rtnl_unlock();
> -		return 0;
> -	}
> -
> -	if (p == &net->ipv6.devconf_all->disable_ipv6) {
> -		WRITE_ONCE(net->ipv6.devconf_dflt->disable_ipv6, newf);

Why is this line going away? We pulled up the handling of devconf_all
not devconf_dflt

> +	if (p == &net->ipv6.devconf_all->disable_ipv6)
>  		addrconf_disable_change(net, newf);

