Return-Path: <netdev+bounces-223154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3D5B5811A
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 17:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDC671615AD
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 15:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1991A0B15;
	Mon, 15 Sep 2025 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZZqvdgP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBAC81ACA
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 15:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757950907; cv=none; b=eOJ0RPacbGlzQA28lmA+WRhK9Zci6uS4EvxVRiYGyh79pcW5chpmQna3Q7IIU25QvOOxltyLrvlfOGGKAuiW+1dDgrXSVLVglGplwYPPoXsJdPjIBLulDYae+00pxuWnvcgCPViZ/h9q5U2V4wJqBVwQJVuLC1gGpbL8KPwsvZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757950907; c=relaxed/simple;
	bh=uNkSAODj0LEQUYmWfJxWaW9KF6NTNV7Pgah/6HXSpz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i139f/G7+/S0DJyOqsByk4fptge+hGMpnwcZKvC0FyIkMoEXD34e08iif+2JF0bRpzlDy8H2s5zMgL8Ecd4vK6mahbKbTr/iH7k0gLojz7qkD/nzyAfUemU/kx5MvMnTGHKSJCm1Ja20htpS7k7LeZNKw79JuUkiCcKF2ie+QgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZZqvdgP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44DBDC4CEF1;
	Mon, 15 Sep 2025 15:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757950907;
	bh=uNkSAODj0LEQUYmWfJxWaW9KF6NTNV7Pgah/6HXSpz4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SZZqvdgPpawNgiArWWz9gwo5YsPvt5l1rVYXR5HCzi8QKt4RP6nD+OU2/NbY9phpz
	 dnjEq8ItnG0OClbgLFBW8Kcn7B3tMknyFlA70HVMnCRpUrEuiw+aNCr9EP2B8E0aV8
	 tJPlKiTxxnx8ZmfN9eduAlEibykUwTBQX5JlFKcXtKUf9Ab+mhMC/f3jSmLVNcCEbk
	 L/aWIciyq0VwdXBtAlYt2YfrSPVQGzi+i49jCMz1mJvegQYUAvsQeUjZrckDDQBC5/
	 Hx4IUp2QXYRGSXL9PiSb9sDiwitGE8+ccwwNTYXqbThUjtV43GLQQX+83LzdpJ6RE9
	 fBHvj4E0rK2KA==
Message-ID: <ad578caf-73d1-4f87-984c-63d6f2ea262e@kernel.org>
Date: Mon, 15 Sep 2025 09:41:45 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net: ipv4: make udp_v4_early_demux
 explicitly return drop reason
Content-Language: en-US
To: Antoine Tenart <atenart@kernel.org>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: netdev@vger.kernel.org
References: <20250915091958.15382-1-atenart@kernel.org>
 <20250915091958.15382-2-atenart@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250915091958.15382-2-atenart@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/15/25 3:19 AM, Antoine Tenart wrote:
> udp_v4_early_demux already returns drop reasons as it either returns 0
> or ip_mc_validate_source, which itself returns drop reasons. Its return
> value is also already used as a drop reason itself.
> 
> Makes this explicit by making it return drop reasons.
> 
> Signed-off-by: Antoine Tenart <atenart@kernel.org>
> ---
>  include/net/udp.h   |  2 +-
>  net/ipv4/ip_input.c |  2 +-
>  net/ipv4/udp.c      | 12 ++++++------
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



