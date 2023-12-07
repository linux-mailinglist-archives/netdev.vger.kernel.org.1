Return-Path: <netdev+bounces-55000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EDD809240
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 21:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DAE71C20492
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 20:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1740C5026F;
	Thu,  7 Dec 2023 20:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvF7TWnb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3E94E61E
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 20:25:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E33C433C7;
	Thu,  7 Dec 2023 20:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701980759;
	bh=r6pNC5v7QT5EdXzchmdJJF2GJJSUXK92g5ieduPietg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DvF7TWnboRelWsdXnyEGz9NOCjYeNibagMjtM92jygcoq/k9i+DSyzK3jMYLs4cgU
	 PsafU7SE84XUI6qw6vySUqGUwANXIxtkot8rUzd3rJXr39PxYHAwThL6OEeeQ7lilF
	 3RPOBL4HV5FQT4qIvaSXgdezJ0kpR5IIyEOAIxZ2brRqPieJZnVXbFH2Ebc6z9RClB
	 WnLfELScPwJ9LYES29MfthFrhTW8D6iFSky/TZblBI1NBC1x9OaSpUaOo03jbjPHBd
	 DSR+2MuGPi2L/ER4Th1nC2vi8jNSe90UbXybQOXWnrW8PqeXtxAlFco31uIZsA8rv6
	 uPVcPm4NPcBbg==
Message-ID: <c76916fb-4d92-442a-b72a-516aa9236d73@kernel.org>
Date: Thu, 7 Dec 2023 13:25:58 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv6: do not check fib6_has_expires() in
 fib6_info_release()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+c15aa445274af8674f41@syzkaller.appspotmail.com,
 Kui-Feng Lee <thinker.li@gmail.com>
References: <20231207201322.549000-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231207201322.549000-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/7/23 1:13 PM, Eric Dumazet wrote:
> My prior patch went a bit too far, because apparently fib6_has_expires()
> could be true while f6i->gc_link is not hashed yet.

yes, and I got distracted by that stack trace and avoiding errors in the
create function. The diff I sent does not solve any corruption with list
since the newly allocated f6i is not linked (and gc-link is initialized).

Kui-Feng: no need to send that patch again since it is not really
changing anything. Let's see if the other warn on triggers.

> 
> fib6_set_expires_locked() can indeed set RTF_EXPIRES
> while f6i->fib6_table is NULL.
> 
> Original syzbot reports were about corruptions caused
> by dangling f6i->gc_link.
> 
> Fixes: 5a08d0065a91 ("ipv6: add debug checks in fib6_info_release()")
> Reported-by: syzbot+c15aa445274af8674f41@syzkaller.appspotmail.com
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  include/net/ip6_fib.h | 1 -
>  1 file changed, 1 deletion(-)
> 


Reviewed-by: David Ahern <dsahern@kernel.org>


