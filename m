Return-Path: <netdev+bounces-145531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 703B69CFBE4
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 01:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4951B20C14
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 00:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8019E184E;
	Sat, 16 Nov 2024 00:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="XTStq81d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1729B846F
	for <netdev@vger.kernel.org>; Sat, 16 Nov 2024 00:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731718761; cv=none; b=XV34D2ZhwOHQHUSN2G7AM+U46UT11AOG9M63fzn87tWN7Rr7BdSUtpoMfDK/glbWimt7DC1e+EF5CVlqmG6VOe3jdtvbJlETEhRI91YzzvIQudhImNUCzUU3+Eh/U0VN9bwvPofabQWKDONoe9u9TYPD8nuCyaa6CAuuMFceZgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731718761; c=relaxed/simple;
	bh=dvD0hKQXuAc6G67gWLjt1nhZyW29a1C2X3NQA33HeR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ikS5luxDZAGMqISHV1s908iuSlvJmp4qLMiNFqF5g7YKuvZPXwVMuCnwle/AP5WjVoeJ47FdkOqk6ZLA6ovuxp3j37JoOxavZqBLX05/0Pnbu3UmRQOebwMnvs6WaUozftDvFerbD9jCG/EgJmo9O1SMTjZysj6MZxcMSPkH1IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=XTStq81d; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-72041ff06a0so133002b3a.2
        for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 16:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1731718759; x=1732323559; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z0COtCpxXPmcydvtIOZbiJQIN65FajXQuXUIvSDmfP8=;
        b=XTStq81duJqj1UUI74+mUL31E9NQ3D4Z7G4INCJwD7DMiY/+LFgS/AIAwkJOE9Ipqg
         iA3XN8MSOICq7Ny8U8U11FWe0zkflgJnaoLkHDGnoA70ZUuGuRVjIzVleTH4E6iWgqrt
         dKMyJ52TV4AfanUBBHlNCSKdmkGEAtCA/jaZvs8BcpgzjaRSc+/qlvf1Cz0u59y0hLLj
         Zu0A15rKKE7rUFTa0cV9IGoNQ2PuoZ/vwtm1lDNp430GJj4xQfxVzaQbaZgm1iAu7u02
         JzDn9K6Q/BuXqy1tZ2dY/l9F5MZAcmcvbRcra0DGKdyl75FS1JZ3w2oDkr92WORJqhyr
         BHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731718759; x=1732323559;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0COtCpxXPmcydvtIOZbiJQIN65FajXQuXUIvSDmfP8=;
        b=POMTNIW1tkhDSzB55IBo7cp4nk714gV5MbxOdyysgG4K3RRFsGr7Z10cAWzuiRQxFD
         EpMP4usDQ+s5vQ0ZsSYyn5bnie/zoDnZqNXaJGiQlaWRspsgTsQ7klCNJoK3ltEjUqSJ
         WUP3frMpiGjN+h2GvfLz84uYCJMjHU0ZgFDEqd5xAa4I6xVYTtN+GvSadyveoAwLFDDg
         4BQ+zDfnkNfFekTURCvJmIFlurlnYBtRW/mqw6llpMbSrpIU2eB1k5wDWIWfBEVsmWP1
         UN0kJBQcJbvPfQCnwyJdusIU//PHuaUpyXvjMmdpAysBmiipCv4rk7bVoJPjv7/gPjzP
         P7+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBzfNNxi8bSPco7OJpXAHREGf/UluvyWjpfemBohYXW4pZF3BOvNIxLKz6Mj2QdYfm3MZKp2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG+HbZ38Aq/zWIZ5cImjEqcKUAXYX64Tr8wtQ+n8LH9vqkyoUL
	mbfIT2alKEiCaF150W1uZQdcRmPDXtQvZvNGc/+B9ONr682oFl5c2ByLbJs9tHE=
X-Google-Smtp-Source: AGHT+IGtxObPJ6gJ6RNKsEBFXvORdYFbtVM6yAWK+WhBXrNUGxJxbkOBSpwitGd986AzhoQ24ld42w==
X-Received: by 2002:a05:6a00:3a18:b0:724:680d:d12c with SMTP id d2e1a72fcca58-72476bbab62mr6093027b3a.12.1731718759365;
        Fri, 15 Nov 2024 16:59:19 -0800 (PST)
Received: from [192.168.1.10] (71-212-14-56.tukw.qwest.net. [71.212.14.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724770ee8c6sm2024622b3a.4.2024.11.15.16.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 16:59:18 -0800 (PST)
Message-ID: <84e5987e-ff03-4fab-a042-679f76f341e9@davidwei.uk>
Date: Fri, 15 Nov 2024 16:59:17 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/4] llc: Improve setsockopt() handling of
 malformed user input
Content-Language: en-GB
To: Michal Luczaj <mhal@rbox.co>, Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-afs@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>
References: <20241115-sockptr-copy-fixes-v2-0-9b1254c18b7a@rbox.co>
 <20241115-sockptr-copy-fixes-v2-2-9b1254c18b7a@rbox.co>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20241115-sockptr-copy-fixes-v2-2-9b1254c18b7a@rbox.co>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-11-15 05:21, Michal Luczaj wrote:
> copy_from_sockptr()'s non-zero result represents the number of bytes that
> could not be copied. Turn that into EFAULT.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
>  net/llc/af_llc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
> index 4eb52add7103b0f83d6fe7318abf1d1af533d254..711c8a7a423f1cf1b03e684a6e23c8eefbab830f 100644
> --- a/net/llc/af_llc.c
> +++ b/net/llc/af_llc.c
> @@ -1096,12 +1096,12 @@ static int llc_ui_setsockopt(struct socket *sock, int level, int optname,
>  	int rc = -EINVAL;
>  
>  	lock_sock(sk);
> -	if (unlikely(level != SOL_LLC || optlen != sizeof(int)))
> +	if (unlikely(level != SOL_LLC || optlen != sizeof(opt)))
>  		goto out;
> -	rc = copy_from_sockptr(&opt, optval, sizeof(opt));
> -	if (rc)
> +	if (copy_from_sockptr(&opt, optval, sizeof(opt))) {
> +		rc = -EFAULT;
>  		goto out;
> -	rc = -EINVAL;
> +	}
>  	switch (optname) {
>  	case LLC_OPT_RETRY:
>  		if (opt > LLC_OPT_MAX_RETRY)
> 

Can copy_from_sockptr() be deprecated here in favour of
copy_safe_from_sockptr()?

