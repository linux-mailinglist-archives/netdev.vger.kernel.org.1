Return-Path: <netdev+bounces-29005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F38BE78161B
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 02:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24C4E281E28
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 00:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA772372;
	Sat, 19 Aug 2023 00:33:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB80360
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 00:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A427C433C8;
	Sat, 19 Aug 2023 00:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692405231;
	bh=vUjnQGhyaB0gt6Wc1RmtrTdJ8QP1mqq37z1ZCTcry0s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JILInZZ8ELM3axcA4Q+5QEP0KmEu1cVbJyyiWPc17emzdIm74MyM9tkHlogBeGMr3
	 +fSnKaYtpuBo36qbpBzL/7rXiWG5a1fPe0JEPDnk/BCRbzKZ1dREM5GzoZqG3UmJY6
	 nITEryFl8fsSKBJv+c7C1A8InF4zbUNIy5SUd7fUNxGjH8Tz1l/+gBaYNhR3NmD3hs
	 if6LBO3yQYg748X3w/wwdZAxpIYabwFO0aN5ou7QfeJG9CEXSkCMHX1OfPjrvf2Svz
	 PNv5/9/98FBPPqnvdnNyVM5TExkC5vjBAbzl85Q+Q+vsHxim6V5ihLK9vKj4Iy9ohZ
	 UX1vQ81cXPlCA==
Message-ID: <012be13c-b18c-b548-9d0a-f820a8ebfc8f@kernel.org>
Date: Fri, 18 Aug 2023 18:33:50 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCHv2 net-next] IPv4: add extack info for IPv4 address
 add/delete
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@idosch.org>
References: <20230818082523.1972307-1-liuhangbin@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230818082523.1972307-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/23 2:25 AM, Hangbin Liu wrote:
> Add extack info for IPv4 address add/delete, which would be useful for
> users to understand the problem without having to read kernel code.
> 
> No extack message for the ifa_local checking in __inet_insert_ifa() as
> it has been checked in find_matching_ifa().
> 
> Suggested-by: Ido Schimmel <idosch@idosch.org>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
> v2: Lowercase all ipv4 prefix. use one extack msg for ifa_valid checking.
> ---
>  net/ipv4/devinet.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
> index 5deac0517ef7..c3658b8755bc 100644
> --- a/net/ipv4/devinet.c
> +++ b/net/ipv4/devinet.c
> @@ -509,6 +509,7 @@ static int __inet_insert_ifa(struct in_ifaddr *ifa, struct nlmsghdr *nlh,
>  				return -EEXIST;
>  			}
>  			if (ifa1->ifa_scope != ifa->ifa_scope) {
> +				NL_SET_ERR_MSG(extack, "ipv4: Invalid scope value");

It's not necessarily an invalid scope, but rather it differs from other
configured addresses on the device. That check goes back to the
beginning of git history, and I do not really get why it matters.

Overall looks ok to me:

Reviewed-by: David Ahern <dsahern@kernel.org>


