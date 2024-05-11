Return-Path: <netdev+bounces-95641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C01D28C2E99
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 03:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F15781C216E0
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 01:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA1312B95;
	Sat, 11 May 2024 01:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S50YeItq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9745B12B8B
	for <netdev@vger.kernel.org>; Sat, 11 May 2024 01:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715392169; cv=none; b=VCk+nuPaXecqYP+QJvT6A6ZyXG5PjV34ZVlsvHWjgDG3Q6lr145wUlnvy3XrIPQM2E5FuARzFuAjQJIK85EpXNoFllWo7Ne7mtfrZ4aE1Dp6UV3E1P1nU20MmniaCMMyBmSy5pmva6k0SkB0jA23jEEV2u64hD0pL2cWN/28/Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715392169; c=relaxed/simple;
	bh=56qxI39ySMVPPtSqBZYuVtmtr1Q77aG5TSA7z+wMJIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ONs//LPVhg/dbMre0wHsxvxsnNGwZALVJ9xNLpmsU6W+mwh5QwDnQh+bKrIL08iSjCSAp64dzQCzXGaee77/hufsx03mXTRJh6lq24jw0aOUGKPDnZn05ZVh4tNr59ILfJ9e3yt8shGg0A6qieRC4jRLghz0X8y2+i/BjTdkbNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S50YeItq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55213C2BD10;
	Sat, 11 May 2024 01:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715392169;
	bh=56qxI39ySMVPPtSqBZYuVtmtr1Q77aG5TSA7z+wMJIs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S50YeItqpiTB86kU9DCG9y8DOpkDzuTjNnyk71GsMlfrPkFi9+B5SJw7c3k+jMUxN
	 hpbPOPZddoGFcpvPMq9tI/TlNxNPLAhYeTja77utdcomL6FcG/XINADpZPQ7CXV71a
	 lGMsSngGCuavXFbawz7xUMa/gLIvMK00kl08tvTPkMEEH30Pu0Zgptj/JI/S1wyuiP
	 RJYGYuzPcHFmjEFtEQJe1PY4oxOPEFdcx6kG6oJI5O03BEhel4wQHAgs3ElJLhOON5
	 uGR7Rf/273HXwFI5H/lw+BJWF51HwzV+uqAZFhocs/xTORzGEpcLkG6qbAfP24RCRm
	 pdtYcbboX9jrA==
Message-ID: <fd9d9cf9-b615-4d95-9f38-38071b0182f2@kernel.org>
Date: Fri, 10 May 2024 19:49:28 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 net 2/3] ipv6: sr: fix incorrect unregister order
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Vasiliy Kovalev <kovalev@altlinux.org>,
 Sabrina Dubroca <sd@queasysnail.net>, Guillaume Nault <gnault@redhat.com>,
 Simon Horman <horms@kernel.org>, David Lebrun <david.lebrun@uclouvain.be>
References: <20240509131812.1662197-1-liuhangbin@gmail.com>
 <20240509131812.1662197-3-liuhangbin@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240509131812.1662197-3-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/24 7:18 AM, Hangbin Liu wrote:
> Commit 5559cea2d5aa ("ipv6: sr: fix possible use-after-free and
> null-ptr-deref") changed the register order in seg6_init(). But the
> unregister order in seg6_exit() is not updated.
> 
> Fixes: 5559cea2d5aa ("ipv6: sr: fix possible use-after-free and null-ptr-deref")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  net/ipv6/seg6.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


