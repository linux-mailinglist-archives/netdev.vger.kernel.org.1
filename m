Return-Path: <netdev+bounces-91730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E86A18B3A22
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 16:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4335FB221BC
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 14:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28382B2F2;
	Fri, 26 Apr 2024 14:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0efQvng"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEACA1EEE6
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 14:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714142147; cv=none; b=ZgPLpTfGD4rZ1xdbSpPs04FKwyDgK8B4KfueR6nOcHeJ69cnN+qZR+kbB1TNeqNcxZjP+hk0HS76BmY0LRUZIIzH25eDnSj3Nj9ZgQs8EsgMAMnAseVh3cN9LhGSKXFpHH3ZLBotIt8AmJ8GO6Ma6oJpMcwbPtBgos5D7pZ0klk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714142147; c=relaxed/simple;
	bh=5/nJy+lqzVSLz7WNzRNm42ZprwGbBXIrbaYp2tq6AgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SY88QaFfiHFyXblZsehSO1+bzdOxm1nvscht36NhD4Bmlhp15WbybaJT8xTqpdR70vW6jbr7KPSu0RidEqrGQoTjUGdGi20BZUHg5EwW1HhOD2zNuZSCePr6q6YnB4msjjtBEweVkOwwxgP02SuW0fsMcDpTGf7wtxVP0qGZRVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0efQvng; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4E3C113CD;
	Fri, 26 Apr 2024 14:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714142147;
	bh=5/nJy+lqzVSLz7WNzRNm42ZprwGbBXIrbaYp2tq6AgE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X0efQvngrzHtEnAIxQUl4qyhDJMWOqRzsVWI2Y8+Wqb59rLPyfDa5EWN4PXxAe3ZG
	 bFn3E6CPt4bDTmggqItt9BZEjvFnjfY4Tl+NoZs+Vwzpkun4Yp6mCOOGqFiK73v78E
	 TIOLxbIBhAceubuwXhAdWr7Ugy23wxyrL+vfLR4NMd24hT0WW1b/qfwm1PBjq157tR
	 pRVfasXS7v/iDwU3Wb+h7Ei7FtBWEZ/1ETDhktuf3nm1c/u1LSFZz0nTzaF/dlBTgk
	 lAGiufazN+FzFsUsxow+mP3iNQYB7X6i8vXpA+rwGMrB87Kq1ebrfDSNtxBGVDz6OB
	 8XHa5mwpV5JdQ==
Message-ID: <f356d4c2-f49d-4011-8413-8c6182e9b892@kernel.org>
Date: Fri, 26 Apr 2024 08:35:45 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] inet: use call_rcu_hurry() in inet_free_ifa()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20240426070202.1267739-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240426070202.1267739-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/26/24 1:02 AM, Eric Dumazet wrote:
> This is a followup of commit c4e86b4363ac ("net: add two more
> call_rcu_hurry()")
> 
> Our reference to ifa->ifa_dev must be freed ASAP
> to release the reference to the netdev the same way.
> 
> inet_rcu_free_ifa()
> 
> 	in_dev_put()
> 	 -> in_dev_finish_destroy()
> 	   -> netdev_put()
> 
> This should speedup device/netns dismantles when CONFIG_RCU_LAZY=y
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/devinet.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



