Return-Path: <netdev+bounces-160165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA27A189BA
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 02:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 222157A3F0B
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 01:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180B113C8F3;
	Wed, 22 Jan 2025 01:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9UPUD7p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E887313A3ED
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 01:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737511102; cv=none; b=QgeBVaImzQgjbgJ09iNQL7RVRktSjLyvQxXEKJ4oRnyTwZzhvkZeNJ0Ppm5zHkV8ezF+SwbxfzBpfWXTPJJgQsQD/Zms6rqmzjbVw/SQBLN46FLmp3OT7RKAw9JJC8LdZafD+va9sGo7r8b9PqBECGgTOxFTw82PxZqzPkm9jQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737511102; c=relaxed/simple;
	bh=9WjzxAP8kWbIspH9Ukb/GP0x4XMwGZiyCKGHct1xVK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fz/eOSdhgTj3QGCmNHGHaHOaWMA1HIpIyybH52s2+wQ6a5b0vWFrYARIEAQ/RaoaEqIS/bWD8iClpNTuVkPfBblYHC+nuP4ExRraUaM6zVF3pQlrgFmKc+eYRPxYpFukwg17QMcd63Af+D805J2X16ciSQIy/HUOAD7tXhbVtYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9UPUD7p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2488C4CEDF;
	Wed, 22 Jan 2025 01:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737511101;
	bh=9WjzxAP8kWbIspH9Ukb/GP0x4XMwGZiyCKGHct1xVK8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=G9UPUD7pY1b8FrvkHpCM0FYek5ak6EuAHB6wuvm/MOmVS1ryn1wJCzpKNtcH30KnW
	 AfWKc6Err2JnMfa8Ssf2ONAXyxD8L1DzmuKVY1y/kUTb4Srvn37Ii5FXnFIvD9q3h5
	 s9fOyA9n1cdKUAr54Ssl2C0pYN4w9LH1ibSGGWO+q44x22A1/O52rnuruHq06xotyf
	 4Vyfum2EljRNocci734TE62v6v5C4mCC4xb1x914AHQJYUAGdfTZEgLliEY46vXMbr
	 hBaPZiRZ3xH4/F7nXVWUqHI7bLUr4ptUEGT8oDNJ/w3W5q7IU9WtjYYh1MkszElHiq
	 O4VbIYin3oNbA==
Message-ID: <f76a142e-6d45-41b0-af94-98e819092589@kernel.org>
Date: Tue, 21 Jan 2025 18:58:20 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipmr: do not call mr_mfc_uses_dev() for unres entries
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 eric.dumazet@gmail.com, syzbot+5cfae50c0e5f2c500013@syzkaller.appspotmail.com
References: <20250121181241.841212-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250121181241.841212-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/21/25 11:12 AM, Eric Dumazet wrote:
> syzbot found that calling mr_mfc_uses_dev() for unres entries
> would crash [1], because c->mfc_un.res.minvif / c->mfc_un.res.maxvif
> alias to "struct sk_buff_head unresolved", which contain two pointers.
> 
> This code never worked, lets remove it.
> 
...

> Fixes: cb167893f41e ("net: Plumb support for filtering ipv4 and ipv6 multicast route dumps")
> Reported-by: syzbot+5cfae50c0e5f2c500013@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/678fe2d1.050a0220.15cac.00b3.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/ipmr_base.c | 3 ---
>  1 file changed, 3 deletions(-)
> 


Reviewed-by: David Ahern <dsahern@kernel.org>


