Return-Path: <netdev+bounces-128405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 711EA97975A
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 17:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEC18B2111F
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 15:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2E61C9DE4;
	Sun, 15 Sep 2024 15:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IR3yhZfU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B1E1C7B92;
	Sun, 15 Sep 2024 15:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726412420; cv=none; b=qtwigf9nlVtzlD6HowHG/kMJEDGaxGEuSF17p72ZSPLHLfk85qKraP2XVkPLzdk49BYt7E3syBztBBGbOJVHleZN1zhuzZYVZuJXRbGhP07NPntwHtxgJWhRP3L0e2fzp/LGYRC7iosenEfyBdHRKxVlsCoj98x1W8JDTZeQF9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726412420; c=relaxed/simple;
	bh=5lqAidBeFXwkgP4aL5zofqFGJ3KGjuWFXCgfugv9iow=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RLHN6jXMBzn6I+Cm9t41yR/AB1Vm6i0yKH8fFW+V4n+gZU4kz6B5UbGDfzlCMR/6yEQkk9Za12vnnJDPriM1ugRs/lV1E08+VeaP59luNr2CUA2QsFlBlRYbOkonMiRrvTxG2F5H6zC5wZiXm6VadtYhKAqGwTgAeHJLGRxyLvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IR3yhZfU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF78C4CEC3;
	Sun, 15 Sep 2024 15:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726412420;
	bh=5lqAidBeFXwkgP4aL5zofqFGJ3KGjuWFXCgfugv9iow=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IR3yhZfUxtKkpr2fo+Itw9nG7UFez+rLowgC4LnQYa3E9H6YYt8e8vLG0bbxkxumy
	 /o7Pf5L+UDLLF3eva/vvBhXt5DTQQEVZxChTJtaBAwctnw6U4pLSCZALM+K5nFem80
	 1TcBvdIafQPG2HW7LH/h6KfWXjS7sKRSlCNh8ivQjUiPNiuVa/5XoIzzRrPQ+jH0VO
	 +5UsQKi8tSrXOP9oB7g7wHYYbDnT0E8YvdO5NBLz5GeQR5RmelPzIeg9wSLiKmymaz
	 6e1SrtoIPv1Brsm4SzqyArg1VjeBr0JPbrNYqWCLOWrwaYmOggxlWD275f3vhL0eX7
	 ToZPlC7ujy48A==
Date: Sun, 15 Sep 2024 17:00:10 +0200
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 thepacketgeek@gmail.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, davej@codemonkey.org.uk, vlad.wing@gmail.com,
 max@kutsevol.com
Subject: Re: [PATCH net-next v3 06/10] net: netconsole: track explicitly if
 msgbody was written to buffer
Message-ID: <20240915170010.55840e27@kernel.org>
In-Reply-To: <20240910100410.2690012-7-leitao@debian.org>
References: <20240910100410.2690012-1-leitao@debian.org>
	<20240910100410.2690012-7-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Sep 2024 03:04:01 -0700 Breno Leitao wrote:
> @@ -1128,6 +1128,7 @@ static void send_msg_fragmented(struct netconsole_target *nt,
>  	 */
>  	while (offset < body_len) {
>  		int this_header = header_len;
> +		bool msgbody_written = false;
>  		int this_offset = 0;
>  		int this_chunk = 0;
>  
> @@ -1146,12 +1147,22 @@ static void send_msg_fragmented(struct netconsole_target *nt,
>  			this_offset += this_chunk;
>  		}
>  
> +		if (offset + this_offset >= msgbody_len)
> +			/* msgbody was finally written, either in the previous
> +			 * messages and/or in the current buf. Time to write
> +			 * the userdata.
> +			 */
> +			msgbody_written = true;

nit: this could be:

		msgbody_written |= offset + this_offset >= msgbody_len;

?

