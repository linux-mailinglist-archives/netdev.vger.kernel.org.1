Return-Path: <netdev+bounces-183540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5449A90F3A
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 01:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A12FC7A940F
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 23:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E64322E41D;
	Wed, 16 Apr 2025 23:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMwHtmxL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ADA1F5821;
	Wed, 16 Apr 2025 23:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744845388; cv=none; b=SXQ/RbW59Abcb1mKqWJBwSVmBvfL7lXmw/O6Ct4joiB4H++je+dN9cXaiOdLKIFQKq6h6X3yQDgbaBEL3QCZq00NXRRl11TQn+nva9AKOsAX996vFlgIZu534uUSIZUfGEcg7WtfbYxJowXQlD8CgNSbzKYagkTfjAYevdZroZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744845388; c=relaxed/simple;
	bh=/imGibaR88ktLyzuee22RPnz39dzLlGvzXe1xo9rQR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KD1TJP+0UEOI7wOrq9y7UhOn5iPY/seT5NhkQZa0Pe93JcylCJE6IOWHG2aFo58mZfzCrzpmbXV+UwG24a+ThT9OGrJI7Sb5jBPK8gouQORuJJlIZFwWO4h4pC8R8TeczYAU5S8TTlRIi22CsJO6UQVQZnupHsew4x2CtEb6eZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMwHtmxL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242C1C4CEE2;
	Wed, 16 Apr 2025 23:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744845387;
	bh=/imGibaR88ktLyzuee22RPnz39dzLlGvzXe1xo9rQR0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VMwHtmxLLhU39Bqxtw2hPkrdsAY5IKdIlR8Ne/ZLHTWkdaTNPOpCy9clUp8SmcyB9
	 Hy0HE6rVBHz4lNqfzxdN/+SfQ9vPAa2qQ7935X9zXZxNTBbIl1lMzYaUfDzhESPwI7
	 iQjhpk0V62FzoRfzxEGYyC9Kec7jngq6o8cSIJJsptokl6tRJ706f/rLgaIZa355Td
	 J6smILfZ2J/rV9gBH8Es+FZBdXvnVKsoZnq9BVMxFMI3svjrbHUm3ShWT/QaAhJPdL
	 N+naq19tfKw+qvrEfs50F1ukaMc78FhCewe6CBySTT3+6YPCrGOKXVVLjlbwpqOZjE
	 WS5sMsMd2htwQ==
Message-ID: <4dd9504c-4bce-4acd-874c-8eed8c311a2f@kernel.org>
Date: Wed, 16 Apr 2025 16:16:26 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] udp: Add tracepoint for udp_sendmsg()
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, kuniyu@amazon.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, yonghong.song@linux.dev,
 song@kernel.org, kernel-team@meta.com
References: <20250416-udp_sendmsg-v1-1-1a886b8733c2@debian.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250416-udp_sendmsg-v1-1-1a886b8733c2@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/16/25 1:23 PM, Breno Leitao wrote:
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index f9f5b92cf4b61..8c2902504a399 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -1345,6 +1345,8 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  		connected = 1;
>  	}
>  
> +	trace_udp_sendmsg_tp(sk, msg);

why `_tp` suffix? the usual naming is trace_${func}



