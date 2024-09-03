Return-Path: <netdev+bounces-124580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CACE96A0D4
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 16:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F7051C239F5
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 14:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAFC13D625;
	Tue,  3 Sep 2024 14:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzGyhi74"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EDE13CF86
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725374360; cv=none; b=ZyPb6nXqNVincvmTcTc38puMeXxv8hKdGGyqDHb5jqi8YATc+2d6Ki1Y74JggOGladYV1pQdxKbzcQgDqAOaVSnEdA81EwthFG2H8FXeC2X1w+ffOsX03o3XagW/blawEyPfXQTkGMYyG2usZcuRyArSylPgBv5AVvb0nPQ7wWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725374360; c=relaxed/simple;
	bh=ojmi4hbUSncobem9AetUsG58C6GwCKRTybSMcjq5k88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uKxYodSMc1G+BAcvlrnkvntadMlSuhvLrAeET1thNV/9JJFkvOGzGUOlPAJfrirBbE1B3135wha3NffvoPJzeio2n9Yon+L1ZP7nedoRa6QX2r+SxAz05Tu/DE00RshxcKCrjoVM/yQ2XvJPtpYZkrZ6BboAr+xZntLSHd7u/Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzGyhi74; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B98C4CEC4;
	Tue,  3 Sep 2024 14:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725374359;
	bh=ojmi4hbUSncobem9AetUsG58C6GwCKRTybSMcjq5k88=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZzGyhi74TZanTzW4lK0VSjv/T0gRSVTAT2MTuBU7Etnsem30175zc3xPkCXtmZbRn
	 VeuXrse7zB5x4P4jQP4Tatp/kF5t0uNEhZycWNI1q0KJp8r1TBpp6FbXPSN1lwvngP
	 lsLp1T9MurPo7tjKTsCpyg5rRND4LmuYbJZ17O4nqf6V6DJRCO5jcZk6ogPX+c4sGk
	 PkH1zlRL/YlNVovuOJQVXEjIDkAWAYOP5wSxDvj/gZFWh0twpP0WaacpU8Eg8O8Vkn
	 12z96gzaFossnK+TGVoSet5iQuTJP9xz9LNMlyteE+wcvMOxZy2wRmy71sOQNOJuRK
	 vyT+Fx5I09gZw==
Message-ID: <8f5fe74a-277c-4b9c-b1fa-7e47fcd6a253@kernel.org>
Date: Tue, 3 Sep 2024 08:39:18 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv4: Fix user space build failure due to header
 change
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, gnault@redhat.com
References: <20240903133554.2807343-1-idosch@nvidia.com>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240903133554.2807343-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/24 7:35 AM, Ido Schimmel wrote:
> RT_TOS() from include/uapi/linux/in_route.h is defined using
> IPTOS_TOS_MASK from include/uapi/linux/ip.h. This is problematic for
> files such as include/net/ip_fib.h that want to use RT_TOS() as without
> including both header files kernel compilation fails:
> 

...

> 
> Fix by changing include/net/ip_fib.h to include linux/ip.h. Note that
> usage of RT_TOS() should not spread further in the kernel due to recent
> work in this area.
> 
> Fixes: 1fa3314c14c6 ("ipv4: Centralize TOS matching")
> Reported-by: David Ahern <dsahern@kernel.org>
> Closes: https://lore.kernel.org/netdev/2f5146ff-507d-4cab-a195-b28c0c9e654e@kernel.org/
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  include/net/ip_fib.h          | 1 +
>  include/uapi/linux/in_route.h | 2 --
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


Thanks, Ido.


