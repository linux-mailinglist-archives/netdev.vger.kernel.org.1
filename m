Return-Path: <netdev+bounces-71455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D0E853517
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 16:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2B23283ECD
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 15:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A155EE80;
	Tue, 13 Feb 2024 15:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gqk8vw0q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655435DF3A
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 15:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839397; cv=none; b=FneUsFZyx2NLi8akug4NVgCr0S4wXHzjFsLm7wE8mg9/Y2+djntybtCpstl7wxnlfZrLU7xxgAOpwUCuSzLNHuAdbMvjvs0WQFLpZdgimlsVXG2n1kcOpCI5pkVBq3FbwQylv+7o3YEVqQPKUzUCwJfB8cNxBWrJQlQ8GTzqmPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839397; c=relaxed/simple;
	bh=/Pp6KjAM0+Fe5kAZ8BQEzkCu3dpNT0AYM97+TxZu0Nk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a2waCge3H32sob4hpyq2RZosx41RZuLDJ1nw/TRh/kHpBGHBX4xMeR23mDj9r1kaNHF4hzmxPJ4lZ7+GZoDUslaXaEdSD1s9ri8K/aeLptBOJ+oWs0dTxlVYuXf00I7zomS0iBMY5mR9FNiOqpwfnqsgPQp8jjzW9v2xZqlj7jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gqk8vw0q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672A0C433C7;
	Tue, 13 Feb 2024 15:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707839396;
	bh=/Pp6KjAM0+Fe5kAZ8BQEzkCu3dpNT0AYM97+TxZu0Nk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Gqk8vw0qv8mxWwdNwCArHKxT+sCklcjbtgvvs7lpkIJyWlJ3yqPLufHHQOceoSTqz
	 Sc/jXCzRJHKJ5x9DsWXIa9zkWN8D0EQTHNajuvsoo/fBdrnU1nm8TRSX+qJdr/A2y7
	 VK7tTw30uUr77Gw8pDDFawK39tOdxMLWptQYvOU1fQs7w8/FJFEIXgnzuwXDrjh8lg
	 dKZNWC4win/4TBaLMQrqgCVYeK4Yd+RUBmVKato6UgZ7HIrDXQSAxDN7cXIu82c/pz
	 mWfRedTPncCoXfscObyUwsjR1bdt2s7Yery414CPyrQ0udXeZp5OUC7nyUgRgN0R6c
	 ZwUzESpfjzb4Q==
Message-ID: <3a495358-4c47-4a9f-b116-5f9c8b44e5ab@kernel.org>
Date: Tue, 13 Feb 2024 08:49:55 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/6] tcp: introduce another three dropreasons
 in receive path
Content-Language: en-US
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, kuniyu@amazon.com
Cc: netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20240213140508.10878-1-kerneljasonxing@gmail.com>
 <20240213140508.10878-2-kerneljasonxing@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240213140508.10878-2-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/13/24 7:05 AM, Jason Xing wrote:
> diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
> index 065caba42b0b..19ba900eae0e 100644
> --- a/include/net/dropreason-core.h
> +++ b/include/net/dropreason-core.h
> @@ -31,6 +31,7 @@
>  	FN(TCP_AOFAILURE)		\
>  	FN(SOCKET_BACKLOG)		\
>  	FN(TCP_FLAGS)			\
> +	FN(TCP_ABORTONDATA)			\

for readability, how about TCP_ABORT_ON_DATA (yes, I know the MIB entry
is LINUX_MIB_TCPABORTONDATA; we can improve readability with new changes).



