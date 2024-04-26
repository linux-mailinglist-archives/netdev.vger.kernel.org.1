Return-Path: <netdev+bounces-91729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AA78B3A13
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 16:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2D071C23E90
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 14:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859701DDD6;
	Fri, 26 Apr 2024 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDcHVFp3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FC8125AC
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714141897; cv=none; b=puaboeCOgDUc3z/YN1A8of4vcVHGbFFF4DIHHGDSABugz5nt5tKZf410Xyb3H9wvhIP7QKhm5/xlac32H09x9H/id5ekL0SNA3DmVq/eVH06aYpbQqIEVTGAw3vwU2XlayAIgQdlyKP9lbB/E/VKUb1Au1NubbG0+pxA0P7iBWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714141897; c=relaxed/simple;
	bh=rgkqJ5mvH2QgnN2CM3eJRpiR203+IXYxMA0Q5OzBFCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PfSBb3SRdJ7BHx2qPcgaSMFXiCD47R0NU73VZq7TDkr6wPX05U+pY+v+85UC2eMffiDpd71IB4bHOZBTjTIzljfByRqXSHdTx4xnXtjtDIwfgb3Xw4q0LCzCrPwDhE2KWD/sUYQGOgKmjKJJzv46keIQIShIwiZTnbKh/yC/nfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDcHVFp3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81876C113CD;
	Fri, 26 Apr 2024 14:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714141896;
	bh=rgkqJ5mvH2QgnN2CM3eJRpiR203+IXYxMA0Q5OzBFCo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KDcHVFp3CtSUFVf4wd5weHtVGYRp2VnG/CB3qW72R89DIjqNVKp/bUOPk9bLYaNp5
	 4TQmDFIAoJy4o1Wq6Ea+aLW1+KONn2/IbeW+nT4FeHjBqKt3+1FRdiytXCPw79g+rw
	 VBkgzaX6Khy7knykrw9LrnU00+yKwvK1Q/hE8z5IjIAq+eIorFHlTBUaJfprNwe+0w
	 buhPvCfGl2Bll7nUXuGL0QvfO3lW0J07/guHS5fmt3N+YFjl2mbR9t1i+IWto2QJS+
	 J1eZFDJe3jh9Ow2rDb9pArGyISIeN+XQswMAVUELiAGwtqiLBb8BnEF2QW1/8uH9g1
	 H1fT4dupdmGWQ==
Message-ID: <6637f6f4-6cdf-4a5b-b464-bd99ae93f6a7@kernel.org>
Date: Fri, 26 Apr 2024 08:31:35 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv6: use call_rcu_hurry() in
 fib6_info_release()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20240426104722.1612331-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240426104722.1612331-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/26/24 4:47 AM, Eric Dumazet wrote:
> This is a followup of commit c4e86b4363ac ("net: add two more
> call_rcu_hurry()")
> 
> fib6_info_destroy_rcu() is calling nexthop_put() or fib6_nh_release()
> 
> We must not delay it too much or risk unregister_netdevice/ref_tracker
> traces because references to netdev are not released in time.
> 
> This should speedup device/netns dismantles when CONFIG_RCU_LAZY=y
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/ip6_fib.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 


Reviewed-by: David Ahern <dsahern@kernel.org>


