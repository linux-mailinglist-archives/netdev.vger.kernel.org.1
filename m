Return-Path: <netdev+bounces-70836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B1B850B06
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 20:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CD2A281294
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 19:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA725C604;
	Sun, 11 Feb 2024 19:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJSQekr/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CDA5C5E8
	for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 19:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707678378; cv=none; b=U6rZiCzjKQxPpPwhZ78vSvbw22fsHXOON8oj8Vv9GG5uFVGk5QXRFIPX7oc8pLKne8oj/ZCTMXT4w1z7t4VPLYL1GKskGDtqIqZJQyaZaH5tCuZXDe2D6gCCZU3PhuSaXWsFbFVswVwWtzocK5y5v7XY+5AJGTcnEnbpxml8DH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707678378; c=relaxed/simple;
	bh=5u+RzxmrP0IIHNvb9P/J5qWOZYkdlPSqhbw/AtreTw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hYH9lkszvYDAvdT6VLgA+mlIVctVwbUsg6skIVKR7FvGsSwKXncw49DQM37bwLin5wKP0tqhaFvYaywUUyqsNvQofdzPEo6OHLfv88rPDB7hECNkGyJROkZ2eAXnoht/mSOG5QN9dqs4jedqGjDZPgxJ57p54rZO3V7OR+752DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJSQekr/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4FB8C433C7;
	Sun, 11 Feb 2024 19:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707678378;
	bh=5u+RzxmrP0IIHNvb9P/J5qWOZYkdlPSqhbw/AtreTw0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EJSQekr/zZnOgl0JdqnbxDYglqetdG9/4E6u+p4RTTNIvvQxAor2+WYIEasZEAKTS
	 r4xjdWHd1iPL24OUbEyiW0trA8b4AzFB9nlqj+l9SZjONG0Mjp8WQuTIoi3CkJuGzC
	 u1ExdgmImlwvfyVLP8luuaU0g5t/ctdkHIVRfg9kWua3oxbM9YP8nPOX5TAeZ64DSF
	 jXzMSFHOZZ2pudUvKyPBxXVsd4P9vTHcOyCso9ERDqV3nVbX0AyTyumwfgjZX69ghQ
	 LwL+RxS04ptYg8voETVoec+2ul08G1iFEtQmDUlSn9L26VlBbQOjI9RhY4/q9vUqux
	 DBNRfnu0J/xIQ==
Message-ID: <ac7ed21c-d698-4c53-8da3-21ba1587a97f@kernel.org>
Date: Sun, 11 Feb 2024 12:06:16 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/6] ipv4/fib: use synchronize_net() when holding
 RTNL
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20240209153101.3824155-1-edumazet@google.com>
 <20240209153101.3824155-5-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240209153101.3824155-5-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/9/24 8:30 AM, Eric Dumazet wrote:
> tnode_free() should use synchronize_net()
> instead of syncronize_rcu() to release RTNL sooner.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/fib_trie.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



