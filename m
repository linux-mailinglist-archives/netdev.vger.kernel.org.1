Return-Path: <netdev+bounces-224105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C9BB80C6B
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AD8E162DC3
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64E1258ED7;
	Wed, 17 Sep 2025 15:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBVoTPiX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8271D341365
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 15:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758124369; cv=none; b=Ri10HhF6u16uq9Qj5LXetFyXXUTwdbZ9kjuaCXKjvzypxS+p0fgw0037cigWqPT7ozqKKNWIcEyxa/48htrlzIxfh9tG3DW/Cft/nYxqVgEeGRvyHVlta4uam4egQRY5bFobtU3/e4be2XNTxPjOIMiaQcMMwO+eJ12/Pvh8jKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758124369; c=relaxed/simple;
	bh=nB2PYIs0a0bfbo1QEAhtOlaQNCfiTPkeVjX7vMR//mI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MHac6wmDQ+pgZDakCgi2OmOcyEMTbUeqovMBraEQ80bnlwVwGl1DYndUs+odMWo1jCzb0dxf0bJc2xDddIP0N8aJSVQ9NtESb+5dZSMNiBh/yvtLVxeNYNXBPaj28FumD7p3LxZyPt96qs+gQJE8JULXU7p9qWtWLvPyhTN1S3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBVoTPiX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7256C4CEE7;
	Wed, 17 Sep 2025 15:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758124369;
	bh=nB2PYIs0a0bfbo1QEAhtOlaQNCfiTPkeVjX7vMR//mI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NBVoTPiXz+6NjDiXp9z6BZh5YMuFk7SfkyRp/fKuq3FzasF+LzR8hkOZ9JhPPxfj5
	 EW+PlH/e95KNKVJqBfbkrRlsbiM0Vls9GLaW4fbMV5j1KIuqOC0d8C7jRxD7AAPvAE
	 AU3Y1Z7kqyNOxWKQTu5PwZ+LVDKNvzlRX5kQaW88d0l0O4p+2LG2rDPctTJlCgb+L/
	 v5/vHfPLz31k6BPI+81+r4+xT28YUl2kTW+T/rnRrYbPD8NUkt17eNY4n4IkjwwDCZ
	 sk5CcBzIGlGkuNncIT0Yc0tzYgmxq4757KrVwtH6+hjDu4rOU1sRIiVtpKciuYbteF
	 x2ygivozNk0zQ==
Message-ID: <81e969f3-2736-424f-9745-106a7a792b35@kernel.org>
Date: Wed, 17 Sep 2025 09:52:48 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 09/10] udp: make busylock per socket
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20250916160951.541279-1-edumazet@google.com>
 <20250916160951.541279-10-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250916160951.541279-10-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/16/25 10:09 AM, Eric Dumazet wrote:
> While having all spinlocks packed into an array was a space saver,
> this also caused NUMA imbalance and hash collisions.
> 
> UDPv6 socket size becomes 1600 after this patch.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/linux/udp.h |  1 +
>  include/net/udp.h   |  1 +
>  net/ipv4/udp.c      | 20 ++------------------
>  3 files changed, 4 insertions(+), 18 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



