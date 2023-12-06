Return-Path: <netdev+bounces-54503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3367807550
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 17:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95C6A281E5F
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 16:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBA546442;
	Wed,  6 Dec 2023 16:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6L2EpCm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224C547770
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 16:39:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5485AC433C8;
	Wed,  6 Dec 2023 16:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701880747;
	bh=1NFQvaeqPQy74Jp+IPaGkTgA8ipB7fhgOLgtT7FAh9g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=O6L2EpCmKd2/rLii38fu4e0BoU4Q6mGcZE63GKAFq+tyM1lYZ/p1rTyep7/5xQYgo
	 IdH6FKHC7VU6ltiXpxtk55AX1qzGmwZf7U8Ei+UX6AAtNYAlCGKXuCMWK7OeKEiBSe
	 THAsqO+rU2QhMAJMRM+lBn7Zu8Maz/bCVB1TGSaafKWLc1fq5ebNNJdRz0KvpCYVNA
	 k0ppuF0ct1hrDmbKHj5dY4a0yEnRhcDo/UAr7uWTPq/+VhoaI6g7rbB8UKaFIyoChv
	 9XyXWyQ4D0kcKf2Z3qg+QEOvdm7U8dGLXDJpHhfvcXbntNiyxCmQtXuJw5vuiBskK8
	 7OqMKZ9YlISew==
Message-ID: <f9d3e1dd-133a-45de-827e-c2f152b619b8@kernel.org>
Date: Wed, 6 Dec 2023 09:39:06 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] Use READ/WRITE_ONCE() for IP
 local_port_range.
Content-Language: en-US
To: David Laight <David.Laight@ACULAB.COM>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Stephen Hemminger <stephen@networkplumber.org>,
 "jakub@cloudflare.com" <jakub@cloudflare.com>,
 Eric Dumazet <edumazet@google.com>, 'Mat Martineau' <martineau@kernel.org>
References: <4e505d4198e946a8be03fb1b4c3072b0@AcuMS.aculab.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <4e505d4198e946a8be03fb1b4c3072b0@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/6/23 6:44 AM, David Laight wrote:
> Commit 227b60f5102cd added a seqlock to ensure that the low and high
> port numbers were always updated together.
> This is overkill because the two 16bit port numbers can be held in
> a u32 and read/written in a single instruction.
> 
> More recently 91d0b78c5177f added support for finer per-socket limits.
> The user-supplied value is 'high << 16 | low' but they are held
> separately and the socket options protected by the socket lock.
> 
> Use a u32 containing 'high << 16 | low' for both the 'net' and 'sk'
> fields and use READ_ONCE()/WRITE_ONCE() to ensure both values are
> always updated together.
> 
> Change (the now trival) inet_get_local_port_range() to a static inline
> to optimise the calling code.
> (In particular avoiding returning integers by reference.)
> 
> Signed-off-by: David Laight <david.laight@aculab.com>
> ---
> Changes for v2:
> - minor layout changes.
> - remove unlikely() from comparisons when per-socket range set.
> - avoid shifts of signed values that generate unsigned 32bit results.
> I fiddled with the code that validates the argument to IP_LOCAL_PORT_RANGE
> then decided to leave it (mostly) unchanged because it is also moved.
> (There is a 'u16 x = int_val >> 16' which is required to move bit 31 to
> bit 15 and is probably undefined behaviour - but will be ok on all sane cpu.)
> 
>  include/net/inet_sock.h         |  5 +----
>  include/net/ip.h                |  8 +++++++-
>  include/net/netns/ipv4.h        |  3 +--
>  net/ipv4/af_inet.c              |  4 +---
>  net/ipv4/inet_connection_sock.c | 29 ++++++++++-------------------
>  net/ipv4/ip_sockglue.c          | 33 ++++++++++++++++-----------------
>  net/ipv4/sysctl_net_ipv4.c      | 18 +++++++-----------
>  7 files changed, 43 insertions(+), 57 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



