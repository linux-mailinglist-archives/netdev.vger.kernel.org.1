Return-Path: <netdev+bounces-181674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E4DA860FB
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 16:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A60044C429F
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 14:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE901DE896;
	Fri, 11 Apr 2025 14:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="ZFWMKgWP"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6B0136A
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744382800; cv=none; b=uvMh6h3hF46bvV6m54RtgSAU8KL6HtdtEvVSThpVhb/5PYjfXUJ5lHbMf6Jx4i+hTVLW1UlraujtWUClT7TZ94FGiWLIul1uEQIB/gBX5q3+paYvrsJuNYW7JMPz3I3m/dluLz9Ob8ccUPggvzYmXlo423SQ8AC1wTcuAbhej9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744382800; c=relaxed/simple;
	bh=qqDf4vE8Jlrdw5uIZbXUKlMN/WijEt7Egx1NwUKsiwA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=L2tDhNQiMIkWMSZ9A6dV5gAr1el8PCYmthSp74z1MvhnN5aNUK8tbAkkIUDwVyLjc74USy8jBOF7u7lGlgE1a3TSmA7plzmZpVApFwCaa0+PgMpmGVnabcANjZzcAXMrYZ1T85wiVGcyUZJkMEuEEGVWApURRIaqdekDi+yJeoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=ZFWMKgWP; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1u3FeM-006GRA-H7; Fri, 11 Apr 2025 16:46:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=DzlRx388jjgSUECxtxgu4Ya7I0Ur05qU1L+e+YdIZOY=; b=ZFWMKgWPQ/Rb3JgQT58jjEfDbN
	R0RouX+k/Q1P+a2rvFGYZ9kL4xLBLNVcARgL0okhtID21d+y1IWeddpJNsUA+0vzHrsBL2W7ICs4h
	g3jedIfOsC5pamVmcfb3UR43uUOMAQ8kIFdEKDwgDfEudCQMIKNJy4nOpWR4aex0oZvCw5wZ+Gj5D
	ytjaM74dkfjlZ+pvg5RsxffzQ2hgG3xeB4GQbHIV6x1bHOJpE2g4THyOMN03prwfKDDf+m6fqHjFA
	BDIOn4zwnE5QpORis76YA/jV37R/RepJnBKDcDtgg02gLclQKl5gCx80NgcY3ZOEHC8T3thYYeS/e
	NDntdZaw==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1u3FeG-00061k-D8; Fri, 11 Apr 2025 16:46:28 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1u3Fdy-00DkoL-4I; Fri, 11 Apr 2025 16:46:10 +0200
Message-ID: <54481a3b-280f-4945-a513-f8a93b5568b4@rbox.co>
Date: Fri, 11 Apr 2025 16:46:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: connect() disconnects TCP_ESTABLISHED (was Re: [PATCH net 2/2]
 vsock/test: Add test for SO_LINGER null ptr deref)
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
References: <n3azri2tr3mzyo2ahwtrddkcwfsgyzdyuowekl34kkehk4zgf7@glvhh6bg4rsi>
 <5c19a921-8d4d-44a3-8d82-849e95732726@rbox.co>
 <vsghmgwurw3rxzw32najvwddolmrbroyryquzsoqt5jr3trzif@4rjr7kwlaowa>
 <df2d51fd-03e7-477f-8aea-938446f47864@rbox.co>
 <xafz4xrgpi5m3wedkbhfx6qoqbbpogryxycrvawwzerge3l4t3@d6r6jbnpiyhs>
 <f201fcb6-9db9-4751-b778-50c44c957ef2@rbox.co>
 <hkhwrfz4dzhaco4mb25st5zyfybimchac3zcqsgzmtim53sq5o@o4u6privahp3>
 <aa00af3b-2bb1-4c09-8222-edeec0520ae1@rbox.co>
 <cd7chdxitqx7pvusgt45p7s4s4cddyloqog2koases4ocvpayg@ryndsxdgm5ul>
 <7566fe52-23b7-46cc-95ef-63cbbd3071a1@rbox.co>
 <kiz4tjwsvauyupixpccqug5wt7tq7g3mld5yy5drpg5zxkmiap@3z625aedysx7>
Content-Language: pl-PL, en-GB
In-Reply-To: <kiz4tjwsvauyupixpccqug5wt7tq7g3mld5yy5drpg5zxkmiap@3z625aedysx7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/11/25 15:21, Stefano Garzarella wrote:
> On Fri, Apr 04, 2025 at 12:06:36AM +0200, Michal Luczaj wrote:
>> On 4/1/25 12:32, Stefano Garzarella wrote:
>>> On Tue, Mar 25, 2025 at 02:22:45PM +0100, Michal Luczaj wrote:
>>>> ...
>>>> That said, I may be missing a bigger picture, but is it worth supporting
>>>> this "signal disconnects TCP_ESTABLISHED" behaviour in the first place?
>>>
>>> Can you elaborate a bit?
>>
>> There isn't much to it. I just wondered if connect() -- that has already
>> established a connection -- could ignore the signal (or pretend it came too
>> late), to avoid carrying out this kind of disconnect.
> 
> Okay, I see now!
> 
> Yeah, I think after `schedule_timeout()`, if `sk->sk_state == 
> TCP_ESTABLISHED` we should just exit from the while() and return a
> succesful connection IMHO, as I fixed for closing socket.
>
> Maybe we should check what we do in other cases such as AF_UNIX,
> AF_INET.

OK, I suspect that would simplify things a lot (and solve the other issues
mentioned; the EINTR connect() issue and the elevated bytes_unsent issue).

Please feel free to tackle it, or let me do this once I'm done with the
backlog.

Thanks,
Michal

