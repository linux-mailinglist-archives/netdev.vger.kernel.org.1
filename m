Return-Path: <netdev+bounces-177196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE737A6E3B5
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 20:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87F6E188C1F9
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 19:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7A819E7F8;
	Mon, 24 Mar 2025 19:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYTffdHX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A653C19ABBB
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 19:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742845129; cv=none; b=Ckph+2OY/u67a+6sBRqN0O+futvByISZLE2Vyzz4dePwj+QME3PnZfigPFKYiiFxv+g35m+hfyfVUsp9E0AGELB+TKbGZoml4zvuhEufZ8JVf/6CefRurzrEYX7b9idQqkqOHNcOJ2gbOsxmuCh2IQIcci0sVAiRa0/VRbs+P9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742845129; c=relaxed/simple;
	bh=Kyugr7NgKmU1PvpCzhJBEnY3Ed4iZbjHOgqJWrAcBZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MrfSEf66F+01rzI5HhkMxQPzSvycKm4lAF2JEMKggWAygMxDYbcwTRKSr75cr5dUaWd/igdNOWtbOGQBGmGMdq1k0uKqX46sXVQxJRmiqDByS+w9PoviExXrG7UHQsMU9ytQRWysUAyR865WYifJ5vXkbjHh9Sq4i/a6FhyTNpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYTffdHX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA72C4CEDD;
	Mon, 24 Mar 2025 19:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742845129;
	bh=Kyugr7NgKmU1PvpCzhJBEnY3Ed4iZbjHOgqJWrAcBZ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BYTffdHXIPDr4DS+aip6UGKkfLn3jZT/FNXnCcDGYN8C4GWfFbHHP/4mlkOjHECNY
	 vjz6RxVZb+efAnNC/coS/HjuKz1e6y0gQzJ5BscX71AbBVTcw5bxFWZgGU9PjWTfbh
	 +hIzpPg5/pelwLVmf6IgSN6vrWc+Q8t5/v0vLZFPL4jLLYQf7DOwtN4Xk9tN1Qy3Kh
	 DrTL33lBoKQCUewxa49HsCYhnTYkngGUt6P08AVLWNSXZa9V2VEg1xXD5WOjab8tW0
	 P6kA4VDYKIgR9cjAi4N9r3VZo7sE2fkiscrHk5f4StRQfn7SUcQoz2LbI3y/fqYAI7
	 RAn1fuM9TWeKw==
Date: Mon, 24 Mar 2025 12:38:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, Kuniyuki
 Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 2/2] tcp/dccp: remove icsk->icsk_ack.timeout
Message-ID: <20250324123841.58ece0e8@kernel.org>
In-Reply-To: <20250318154359.778438-3-edumazet@google.com>
References: <20250318154359.778438-1-edumazet@google.com>
	<20250318154359.778438-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Mar 2025 15:43:59 +0000 Eric Dumazet wrote:
> diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
> index 018118da0ce15c5ba5e3b7fcc1b36425794ec9a1..597f2b98dcf565a8512e815d9eae2b521bac7807 100644
> --- a/include/net/inet_connection_sock.h
> +++ b/include/net/inet_connection_sock.h
> @@ -117,7 +117,6 @@ struct inet_connection_sock {
> 				  lrcv_flowlabel:20, /* last received ipv6 flowlabel	   */
> 				  dst_quick_ack:1, /* cache dst RTAX_QUICKACK		   */
> 				  unused:3;
> -		unsigned long	  timeout;	 /* Currently scheduled timeout		   */
> 		__u32		  lrcvtime;	 /* timestamp of last received data packet */
> 		__u16		  last_seg_size; /* Size of last incoming segment	   */
> 		__u16		  rcv_mss;	 /* MSS used for delayed ACK decisions	   */

I get the same errors as Simon, something ate the leading spaces 
in the patch.
-- 
pw-bot: cr

