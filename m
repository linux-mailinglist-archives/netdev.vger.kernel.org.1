Return-Path: <netdev+bounces-241906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DBFC8A191
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 14:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26F003ADBFC
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 13:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FB131195B;
	Wed, 26 Nov 2025 13:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="L54HNVll"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1058023536B
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 13:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764165074; cv=none; b=lUAzh7saxPc8qdiG6I/Jlvr4COUX6Kqw4t3OOm8bKRq7JvvQ81UupyLHSpLAcYhN2ZThKSJHS/+AWdnLezXMABk3olWkpnOecpf5lgh9cBFo13ryxh9EAYzeeNLaBTLNFe/0YkCM3WTStVU+k9diV1/bxUbjSsYoYyhSrOAs5Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764165074; c=relaxed/simple;
	bh=w3RYlQJ1WpXOJpJT0jQN/FGmaoqCASem/ZElxtK3qDw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kj2a1sPAxCCwD3NdPxaZqpO2epzx8saESsh8+RU9+4mcTTEjNDeu3+v3fwPXeQLZgXqeK0za1f83smcJajQJqqonXUpmkBqs7M7Zw+fdDpkhVZmvWe5hhf0E5ajD8uMnT12y7JS/g+kWE5tnqN1ZZCtr9uOSc4/Y+vTgWf6C/AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=L54HNVll; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight@runbox.com>)
	id 1vOFvD-009bTF-Ta; Wed, 26 Nov 2025 14:51:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date;
	bh=XjxnvYPFUpJAyRoasaFasHxe6lesQWqp35E5VvsQy2o=; b=L54HNVllVBDX3jZaUG4XNMHWqY
	lgs722FHjM8gLfp1vRp0gRU1VnXfhyM5EX1ZRkdcvJcBCvWpY6JHKkZiGjYaRsGhFlzEf4TmEoSgM
	8dcOibXbrI5UwDPNiJPvQO6kqnLoX2aHyIfgeNur5CKjmFTiNod54LUeiQP/cdKhu8r8vhhomotKf
	kJUhz8l2D/lxjKiFd/vWyVGcnIWtX51ELYaewupJW8Oh142lrSJrM2NBuE50EzrFL1qNliz+6MWXU
	xQRH3Ns2T9KVJH3IJcTS2KRHazL+cWGOeZLfRNeKuhFmKF6CmLxfimg+IqGICiQf+oycooULrgG02
	/0EsBdaQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight@runbox.com>)
	id 1vOFvC-0007FS-NN; Wed, 26 Nov 2025 14:51:03 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vOFuu-00EvLe-S7; Wed, 26 Nov 2025 14:50:45 +0100
Date: Wed, 26 Nov 2025 13:50:42 +0000
From: david laight <david.laight@runbox.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: ipconfig: Replace strncpy with
 strscpy_pad in ic_proto_name
Message-ID: <20251126135042.06c1422b@pumpkin>
In-Reply-To: <20251126111358.64846-1-thorsten.blum@linux.dev>
References: <20251126111358.64846-1-thorsten.blum@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Nov 2025 12:13:58 +0100
Thorsten Blum <thorsten.blum@linux.dev> wrote:

> strncpy() is deprecated [1] for NUL-terminated destination buffers since
> it does not guarantee NUL termination. Replace it with strscpy_pad() to
> ensure NUL termination of the destination buffer while retaining the
> NUL-padding behavior of strncpy().
> 
> Even though the identifier buffer has 252 usable bytes, strncpy()
> intentionally copied only 251 bytes into the zero-initialized buffer,
> implicitly relying on the last byte to act as the terminator. Switching
> to strscpy_pad() removes the need for this trick and avoids using magic
> numbers.
> 
> The source string is also NUL-terminated and satisfies the
> __must_be_cstr() requirement of strscpy_pad().
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  net/ipv4/ipconfig.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
> index 22a7889876c1..27cc6f8070b7 100644
> --- a/net/ipv4/ipconfig.c
> +++ b/net/ipv4/ipconfig.c
> @@ -1690,7 +1690,8 @@ static int __init ic_proto_name(char *name)
>  			*v = 0;
>  			if (kstrtou8(client_id, 0, dhcp_client_identifier))
>  				pr_debug("DHCP: Invalid client identifier type\n");
> -			strncpy(dhcp_client_identifier + 1, v + 1, 251);
> +			strscpy_pad(dhcp_client_identifier + 1, v + 1,
> +				    sizeof(dhcp_client_identifier) - 1);

Wrong change...
There is no reason to pad the destination, and the correct alternative
is to bound 'v - client_id' and then use memcpy().
Then you don't need to modify the input buffer.

Although you might want to worry about the 'strange' strlen(dhcp_client_identifier + 1)
where the string is used.

	David

>  			*v = ',';
>  		}
>  		return 1;


