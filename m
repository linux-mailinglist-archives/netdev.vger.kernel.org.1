Return-Path: <netdev+bounces-218009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1766BB3AD3B
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 00:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D236C16BC7F
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 22:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E060B2253EB;
	Thu, 28 Aug 2025 22:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/gQn5/1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC12A13FEE
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 22:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756418487; cv=none; b=QikcVpbTstq9dHpbrhE0UeTjyBYoNQrky8HDRe+vglfwTSiutdxIoy7V5HHJ7SVnerRk5K8RiWN8P6dMXevZUok6vqJXK0p0ArM/m9d0TKZzS/70d9d8dzDI5nOJtTiPoGpJNxOfv56+Gy7HMq1B0zpDzHAJbfksSrjI0e5y2kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756418487; c=relaxed/simple;
	bh=I+AmU5l1hL6+3BmuBZKp/kFDa/4nqW8mtQX0WGfHtOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YAwoOeeFAY8bdtO2VRy00pRgkrcWSqKGeXyBkmSzQjROvSjwPzs1qmAlWNDbFYoJcBfBWXxYuPv8HZP0FFimf6I6ZNyq0OeEKap8C1xgcGL4uUPF9j8AF76q/XZxkzyA4yLLQWuNY4NaW8UqoP6eYMXou945X9rhaNPxoM7/AfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/gQn5/1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7C1C4CEEB;
	Thu, 28 Aug 2025 22:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756418487;
	bh=I+AmU5l1hL6+3BmuBZKp/kFDa/4nqW8mtQX0WGfHtOo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d/gQn5/193UXpp6XSPEkDsNiD7QEQgwc2ivwgvyoc1aPIMsCAH/OWwFxdp1ywGR52
	 h4nauAbbb0Q2SsGDQiaKR4uGJivaz+e9AHuFv7GsSIe6+oDWT6dz5f3s2L7Mipn4gL
	 qxl56qG37k0SNL1u7ehRLwVyDSbt322sK5DpqRLFqqhkY6rDuLJT10ZyDhY7XPNmRj
	 ngliNf+1aNeX7RXz/UnbUETEntSOPzAL3wgRQLOKciMDg/jWkyGeSdl5v91GmZr9j/
	 q6pJ9FRmgBzssM+66hSu74mfQmonajrXmV1i7IDrnz13mpSJ6dwK9t7cHf+qtiEi7i
	 BuMXxulUmmaiw==
Message-ID: <197f245e-a5cf-485c-a3d1-bafc8dc00137@kernel.org>
Date: Thu, 28 Aug 2025 16:01:26 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/8] ipv6: use RCU in ip6_output()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20250828195823.3958522-1-edumazet@google.com>
 <20250828195823.3958522-5-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250828195823.3958522-5-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/25 1:58 PM, Eric Dumazet wrote:
> Use RCU in ip6_output() in order to use dst_dev_rcu() to prevent
> possible UAF.
> 
> We can remove rcu_read_lock()/rcu_read_unlock() pairs
> from ip6_finish_output2().
> 
> Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv6/ip6_output.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



