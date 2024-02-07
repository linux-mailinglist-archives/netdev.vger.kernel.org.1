Return-Path: <netdev+bounces-69915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E40CD84D03E
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 18:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80F241F25E11
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 17:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC4882C76;
	Wed,  7 Feb 2024 17:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SskFRwHc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8768289F
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 17:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328637; cv=none; b=bDH7/o31MBy4piBBWzk/aq+8E3YBcKleN7jsVN7yO+wv7pxFHzI2YG5cmlMU4p175Ierlz44uFiOFMP8HbeDu7WvgZB+qv9tjGNsQ4iiCcInwGXIJWGPtG8mAsmem1RbtaMpH7gxO7MddXeEA5uwNvBWbo4OGicBP34T4Aww+VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328637; c=relaxed/simple;
	bh=5RDwJU43burdlSh0mnZ0tNlMaFUQZEutczM4zMD5lS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ds9i427lrtj+Sbd/R79YspVTxYVOizMGDx6j1NgzmhodvO6yuX6apqKrrxuQTlMiDID1ghIKIQO7sZBmENe+3g2owhsrPpbaonYWu47m9k6++u+8LjyWPVC/eQQsENex5U4R3PEq2BcFew3TLn5PUhvBYuh+h0sRBzXHUcjNbHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SskFRwHc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A17C433C7;
	Wed,  7 Feb 2024 17:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707328636;
	bh=5RDwJU43burdlSh0mnZ0tNlMaFUQZEutczM4zMD5lS0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SskFRwHc/QGa4J18Hvimhc2nlOOWZlaVVGiGnTcqft1RqDxTtqLmvNuSRyKsne9gT
	 wr4VtUtFkgPyrinVqX4CnmZ5truCCY6Z1f5cvwIS2ajEVK6hcTKjAfFNZAEZ9A3s3b
	 ZTLd0mvsKdI7i7wLCYMxjqfud+ko56m8ddn3f5DTE+WNJjSKLQXNRNtzMlJLvMGmMp
	 +AXVVWFsRWVvGRSXFxJct0Vn/nE4ttHTEJ3thxn1gyn2KPHBt8tCGOa+238V1Bc9mC
	 DIFAphq2DSwPy6d8SgbPVhnUbTJgbcfc0pUUXoI5UKx1gHkRKUTkmvZ5nVoOuoXBJQ
	 CnYIQqk5ubpRQ==
Message-ID: <d9c9490f-eed1-4999-8779-4f7f0581935b@kernel.org>
Date: Wed, 7 Feb 2024 10:57:15 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 02/15] nexthop: convert nexthop_net_exit_batch
 to exit_batch_rtnl method
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Antoine Tenart <atenart@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20240206144313.2050392-1-edumazet@google.com>
 <20240206144313.2050392-4-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240206144313.2050392-4-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/6/24 7:42 AM, Eric Dumazet wrote:
> exit_batch_rtnl() is called while RTNL is held.
> 
> This saves one rtnl_lock()/rtnl_unlock() pair.
> 
> We also need to create nexthop_net_exit()
> to make sure net->nexthop.devhash is not freed too soon,
> otherwise we will not be able to unregister netdev
> from exit_batch_rtnl() methods.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/nexthop.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



