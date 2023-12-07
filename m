Return-Path: <netdev+bounces-54698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E62807D7A
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 02:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EA1AB21038
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 01:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1E27F6;
	Thu,  7 Dec 2023 01:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DncELJY9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9AF7F3
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 01:00:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC1CC433C8;
	Thu,  7 Dec 2023 00:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701910799;
	bh=JTwLLTXz2XWUkXKsx1vFQNBXjRc2FG8wpB494W+qK7s=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=DncELJY9SqcPKhuX9g5OGAhQMqmhVVB7ktpYlOHZCn7j174VvwJbTdNxrUuSavRfi
	 l8sRuGnZLAjJKE8T/W2uaA6pv8ffDQMlN/jYiFwlBUkQw9JTDA3Wo88ueE4Wa62ldr
	 dy4RQ3RqgbKL9yyi/90lr1GR+Dfe7/kyDpEBMiBCcz2rmvmthSEI+KJl7A8aCMZu91
	 v+AIIQMHRwIOx5rxDuRMnnXlnCjRVyLXkWht34Nv2LTi/YNdxybhkODpKQHm8otygg
	 H0ArEaWMi57YHoxDkIrHLY7zNJJX6j82G78bGMWr/C2M10zUqX2uDklTVUMD10u9UZ
	 xgVS+K6IuPjPQ==
Date: Wed, 6 Dec 2023 16:59:58 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: David Laight <David.Laight@aculab.com>
cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
    Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
    "David S. Miller" <davem@davemloft.net>, 
    Stephen Hemminger <stephen@networkplumber.org>, 
    David Ahern <dsahern@kernel.org>, 
    "jakub@cloudflare.com" <jakub@cloudflare.com>, 
    Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2] Use READ/WRITE_ONCE() for IP
 local_port_range.
In-Reply-To: <4e505d4198e946a8be03fb1b4c3072b0@AcuMS.aculab.com>
Message-ID: <e9d546ac-dbcb-272e-f4c0-4ecd61f65c78@kernel.org>
References: <4e505d4198e946a8be03fb1b4c3072b0@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 6 Dec 2023, David Laight wrote:

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

The unsigned bit shift fixes look good to me, thanks David.

Acked-by: Mat Martineau <martineau@kernel.org>


