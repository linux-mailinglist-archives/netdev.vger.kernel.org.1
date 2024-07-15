Return-Path: <netdev+bounces-111620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A14931D32
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 00:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A7641F22148
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 22:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BFE3BBC2;
	Mon, 15 Jul 2024 22:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtsupMj6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3471CA80
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 22:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721082892; cv=none; b=aMnk28JnUGlE6NFQ7uSui+A91UwbobOKUxHv/HJoaXbf3M26pwCZWk4+Z4lMGJ7mkYJUAwfBoRMzOeJ4VGMZgPT7SFxAJjya0DE5hc8IksFJ7ziI2qPuBZunRYftGei0x72aw1spLKorRbOKzn8sdkJ1YY31U87m//TKtjIlZxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721082892; c=relaxed/simple;
	bh=PmAJMlYR9EVPMfDqGkgBuv80a0+w7+7N4fqOGRtjXY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rHNQqHn1r5x1iG2rX5MqKvPf89gpSteOqvRSCHw333QVFpVq0fAtMHoIwjwJqSQSk/qcbLY26p5ilsnmq0nbqo91uXqMk2oSze+VDtfeL28ppqMtKaOAu1HtGMNF6ZO8hd21kdNzk9Ls6tZo7BbbqM6P5e3ZP6TUfFNCiPoOk2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtsupMj6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C45C32782;
	Mon, 15 Jul 2024 22:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721082892;
	bh=PmAJMlYR9EVPMfDqGkgBuv80a0+w7+7N4fqOGRtjXY0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JtsupMj6hLdFg2oBYTPwK48CZ01FiqJdHKo6tlnCElVNUU3cJpGqC8l/bnOXsVKJZ
	 gayAao/6JuRrqVjUTiRnAXMl0O/4X7F21qw7Ko7Y8PfixksSmCWJycX9PRiyPVlagn
	 4eQCuCT9Xyb+l8D+t6yyyGBNKIx3QCMHjh/IKI+uPj4CyGgTsGKRbPZ4TSBjORkjK+
	 nZlvn64CykK+rh0VczS2Y3mYrAUWtKkLSTPDJipKcL92OPpLyydlqO+OkXD0Sbylbr
	 xbgaqxVi17OUNSqTG+1ihr4C915udPFJG6PFJ/VJFrRmMN4zs0gduoCsMtPWHk/4sS
	 QKEYqtIPftd4g==
Message-ID: <36936855-97be-4dda-b579-a3050704f874@kernel.org>
Date: Mon, 15 Jul 2024 15:34:51 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] ipv4: Fix incorrect TOS in fibmatch route get
 reply
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, gnault@redhat.com, roopa@cumulusnetworks.com
References: <20240715142354.3697987-1-idosch@nvidia.com>
 <20240715142354.3697987-3-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240715142354.3697987-3-idosch@nvidia.com>
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
>  # ip route get fibmatch 192.0.2.2 tos 0xfc
>  192.0.2.0/24 tos 0x1c dev dummy1 proto kernel scope link src 192.0.2.1
> 
> Fix by instead returning the DSCP field from the FIB result structure
> which was populated during the route lookup.
> 
> Output after the patch:
> 
>  # ip link add name dummy1 up type dummy
>  # ip address add 192.0.2.1/24 dev dummy1
>  # ip route get fibmatch 192.0.2.2 tos 0xfc
>  192.0.2.0/24 dev dummy1 proto kernel scope link src 192.0.2.1
> 
> Extend the existing selftests to not only verify that the correct route
> is returned, but that it is also returned with correct "tos" value (or
> without it).
> 
> Fixes: b61798130f1b ("net: ipv4: RTM_GETROUTE: return matched fib result when requested")
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/ipv4/route.c                         |  2 +-
>  tools/testing/selftests/net/fib_tests.sh | 24 ++++++++++++------------
>  2 files changed, 13 insertions(+), 13 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



