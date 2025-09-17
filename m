Return-Path: <netdev+bounces-224108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF45B80CCB
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08DAC18918CA
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C420321289;
	Wed, 17 Sep 2025 15:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNrv3CHj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384C4321286
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 15:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758124548; cv=none; b=KCp7pmxCv5Ch1mArEZLIYVnXDK3scCI6ElsKioAFKRxK+YQpZa8ykYLk0TB85FaoPybTEDojfJ703QI/QtkXr+LVPunVATmB4Lqlp8mmMo/nCdUuHzLGRqsKfdOby1GuAyQHPwVC8uaEzaNp1B+3iIu4+MmxEmY+sWuOH9/GefQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758124548; c=relaxed/simple;
	bh=QR0O6FUaHOER+KcaHk7V35Lq4F4dvXh/VmDPplqqnm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fRF/1Hk0fcz3TRGk6tWwGgfj1Eng0UHH7HFoVbVHOLzpjtIny+KXUV5EnwYQnHPXoXhuytdgPyeej5TBjuxxSp/BsiQ6C6zL/t7ogG/lqVHfev1DtmenP0IWOeNq0Sj2m036L+cCXVFvSt86dzrCNyb/1UUpiq2tZN9QrdHHlvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNrv3CHj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4DFC4CEE7;
	Wed, 17 Sep 2025 15:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758124547;
	bh=QR0O6FUaHOER+KcaHk7V35Lq4F4dvXh/VmDPplqqnm4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lNrv3CHjiZcRkUlvi0SLpX3Gvoox1XqqjklM2BA2W3tEwMjjELR6DsqwT75xgEbzd
	 aX2aWSFyC2zkxBZwM+FQVCqzTMqfGldDFM/WGAKa2O8hso4gtzQduHIUx1txosEvCx
	 wnbpnAezQfcwUtGeDhlYdjaACURAzzbrxS4TFiIG/VeIaAx8c0U682CgbNISfx7fSz
	 v0YFAV44KFEWV/DiE0XvmHFUV4h9Rv+KEFY32xV5avW90o2WFR+9F9HIOjrM/m5q4B
	 llW//l6xVg6Gx3eg/w65tTfLHg0XBGrzO4tLsaLVmwG53zfp7oxVa+pwdAbH/iq78T
	 bzuN8BGI/6QCg==
Message-ID: <e0ca50a8-564a-42d9-a457-f06f7824b414@kernel.org>
Date: Wed, 17 Sep 2025 09:55:46 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/10] udp: use skb_attempt_defer_free()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20250916160951.541279-1-edumazet@google.com>
 <20250916160951.541279-11-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250916160951.541279-11-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/16/25 10:09 AM, Eric Dumazet wrote:
> Move skb freeing from udp recvmsg() path to the cpu
> which allocated/received it, as TCP did in linux-5.17.
> 
> This increases max thoughput by 20% to 30%, depending
> on number of BH producers.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/udp.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



