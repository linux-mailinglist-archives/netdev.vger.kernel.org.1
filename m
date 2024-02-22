Return-Path: <netdev+bounces-74083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5DE85FDE0
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 17:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11E0DB29BA0
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 16:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9C214F9F6;
	Thu, 22 Feb 2024 16:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okQbafiB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134591474A2
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 16:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708618573; cv=none; b=pXC5EgW0w/uKVbW1dRUR/l3vz0qzmEg3lZ9ojzSgmCVXnRPVXR2rH2jTRk0Y60wJf6B/rk3RhEBDWqzRnNYv6xfRkWfpVLKnkDEACWH+RXEJN6M/QTH45OuEADyIRgfxXVjEWSua5gxWC+o0FbUzjACihtA+KPFJmHOYODEwfDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708618573; c=relaxed/simple;
	bh=uZmeI5JnKLRXuOhc0+p+WY2rWr4FiRCY/lPyQbg9t3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kFwrHIg5DBloR+T5YM8OCm0J/vIqEDn5UbYM+xJv4pWlpKhwQ7VhKwlSTfnWlbftFeQSLdlK5UuwOCQ1PJwXGt1AoUHFc1lgQQf1n+rsKayiL2qyPdHPbmCQq89Mx4RC4aJqKpdXuWwUftn4b4iqRqk5Whxl2B//IKKDhGN/nNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okQbafiB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471B7C43390;
	Thu, 22 Feb 2024 16:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708618572;
	bh=uZmeI5JnKLRXuOhc0+p+WY2rWr4FiRCY/lPyQbg9t3M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=okQbafiBInu43+2Of/gIT5WRGL5c3wYhxMPgLbS/VcqSTX7Rm7vIG0QEHKBw/yQbK
	 J4G3dnM0lQgqm+qIM1FEnLqniieLPsCLZEwSmssmujJq2ybI+Nf2ZpcTawsdJKC/Tm
	 7QS8U3TU4g+MyVSSZGyu/9P+GPtVQqsjudnNKwPIF9+a8RIwgmWkvwCLB2+BD0DRo/
	 /OUfvylQDRqhmKBXj5IDMYnbaOEoUpQPlcsSY2iAC2FUM1RxvmuQVZ0CyRb0oRqPlu
	 qrZujot/9CEhvURU1zFpDk7SIYJc4VAtB4zxI7YpaRdlvDTuPLBMdbcbqrDLyHN3zv
	 JuJRZbQorMB5Q==
Message-ID: <eac4294f-f7af-45bf-95f9-0163c67716e9@kernel.org>
Date: Thu, 22 Feb 2024 09:16:11 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: fix potential "struct net" leak in
 inet6_rtm_getaddr()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Christian Brauner <brauner@kernel.org>
References: <20240222121747.2193246-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240222121747.2193246-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/22/24 5:17 AM, Eric Dumazet wrote:
> It seems that if userspace provides a correct IFA_TARGET_NETNSID value
> but no IFA_ADDRESS and IFA_LOCAL attributes, inet6_rtm_getaddr()
> returns -EINVAL with an elevated "struct net" refcount.
> 
> Fixes: 6ecf4c37eb3e ("ipv6: enable IFA_TARGET_NETNSID for RTM_GETADDR")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: David Ahern <dsahern@kernel.org>
> ---
>  net/ipv6/addrconf.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



