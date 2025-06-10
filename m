Return-Path: <netdev+bounces-196130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFC1AD39A8
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 15:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67D037A5B4A
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 13:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED6B298CD7;
	Tue, 10 Jun 2025 13:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5hoIjDR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4D1295DB8;
	Tue, 10 Jun 2025 13:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749563077; cv=none; b=c8F8wgGI6GPtT8iXgsyU7WsBLcRG1TccREdnxqmM7EM6UKQJ5+jGgVNuc07vsbgQTIrUbTkIFSbyrNrCvqQdkvbDmlzEwEEi8gD3TqgIAb+0yYk0jXY9J8tkWoJrFLrz1nWV3qVi7zIJUPVf/qbj1MQ7VSTCL/bZgWaeckYnFLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749563077; c=relaxed/simple;
	bh=w7M5NwK1oW70FzmJ4N9o8ocqtFY4hr9nTY/YFcp50cw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=JC0aHDwKGwbFm9disBDEMBuTy0nLcPzPM4lcRMbxtepKgjs4ZIggUXShEtYdF+YH8aX6a4NyTciSamdDD91vqeGMg2eRfKoOXW+Zuc2Oi5SIo1pz2aUJc38W5z78aFqDvflRBE3Bs+geuvw4yjl2DxINpVlY0KWJ3/Q+4rfRc4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5hoIjDR; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-70e5e6ab7b8so46449617b3.1;
        Tue, 10 Jun 2025 06:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749563074; x=1750167874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4DOsQjUocY5daIDK3F2b/9QA6tL/9CxUu9mmj4ytrU=;
        b=I5hoIjDR8L/iEItDUKFTxgHXnNjkNUPBgwbxqQHDklI7MPnHMwss5TcMin5F8i3m/2
         /hirKsL2TDIzGPOphWXNW6Rh9O8+0f35swUBsqVEl1QszczQsSPa86/fpTkn72V3V3KA
         9J8w4WfQBjy5lHOSjAPG2czrQkxSc756Mjwkv9ZJTgR5TxvMNFCLWBW9f4QjmrrdYT2o
         she2HY/W0zeJ7+zOnT0bL47IhK6gUyZ5pOjFUZWx2WOdUarXe1Q7w1mUTCRMsxYtqoN6
         5ONGJvqWY1nGthdoWY/6t84S4MJOJv7UVEa96SGlhE44dGIggnM7UjLX+WqNlED2Ljhm
         n3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749563074; x=1750167874;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K4DOsQjUocY5daIDK3F2b/9QA6tL/9CxUu9mmj4ytrU=;
        b=wL8xrczXUiuIigJlkBpospoIMNDD2LtB0nQboAdZTwP8JGzHe8opamj7EbVqmBwRxS
         WP/UBBgRQPSfvxN66XAfhVvUgMQp8quPsxVGtqUEwBWE3mQjWMBpJcOIcmR4THmPEIRg
         WoIlZ7qSs906fWbiwF6ZVpZpZcmhuG3dImoe+hkAF1e+/5Z+LobB6WPDSeTvtNH45GHE
         VYs8+9B8falzgrwjI3eDXIKOHRxYQYL/pNYrgzfUfvRJ+Ds/fYo7slq9p81wn6AYNP8v
         8DmFp6Fq+laX1YLno0kV4F9mlSOI04WZLzpOMvU+WcD0B5G76x73lGj2bZfJh4Rf4s7t
         LQeg==
X-Forwarded-Encrypted: i=1; AJvYcCUpBC6Zlm+MvriZYqA9MiHvmeoqOM3CpewfMhY8AvTGs87LwEdWg5uyRG93PP2oTB98LpgSuvm17kHtS20=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu9AmiEvvTpCz+vDO5sEi/OvclxlDX6SsRmKfd+V8xNv7BbQaz
	3upD7iRk48QMwUvu0uO4ehAcrLnvLaXtlCm6pHOYRutSSrgTAo6HKBY/1SVa9Q==
X-Gm-Gg: ASbGncu7hscBKfKC3odddaprf+8+YUZizjshz9Lxpm9DYvhtDLPITQV1ckGr0yM8e8S
	epPsNaKBW5tNaD3kQBJMFlWaIqIsRR5fARRQ+srbR8W9kas9DF+0XDRt4UBRKgIFk3/N3GcdSBD
	Vavmpjo6V3QBoA0rwK0ImNU+3OWXjKHDKyvUnEVOO4LfNi7MsbrfhHf3OH7Yp6XN6TMYR/MKJBX
	HG0NIA+Rz3XF5rwbvUcHlgHrmZOePIoEkkjm1cg4+/BjozmSVNp59bPOF+mRtTA57CP+zsGL9cn
	7wF+Va6qvznasI8O3ZAK/L7xvZzZWvSIvxIVighNvaIetWnexZDA0Mx459yOXKZqTpuwZbmJsF2
	lK0+OF5TST0HFLnMNR3b2RbtFFw9AyT2Ct+zGy+R10g==
X-Google-Smtp-Source: AGHT+IGKnySLHcUrwmA34XCYdq5IdoAaEH5mwmrVZvuwueGxiW8rDYv5z6WDZFWc1KlCVs+tIepGpg==
X-Received: by 2002:a05:690c:1c:b0:70e:87d2:c2cb with SMTP id 00721157ae682-710f777ff00mr243664687b3.31.1749563074354;
        Tue, 10 Jun 2025 06:44:34 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e81a403869asm2903305276.23.2025.06.10.06.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 06:44:33 -0700 (PDT)
Date: Tue, 10 Jun 2025 09:44:32 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Michal Luczaj <mhal@rbox.co>, 
 Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Michal Luczaj <mhal@rbox.co>, 
 cong.wang@bytedance.com
Message-ID: <684836c0591e3_3cd66f29487@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250609-skisreadable-toctou-v1-1-d0dfb2d62c37@rbox.co>
References: <20250609-skisreadable-toctou-v1-1-d0dfb2d62c37@rbox.co>
Subject: Re: [PATCH net] net: Fix TOCTOU issue in sk_is_readable()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Michal Luczaj wrote:
> sk->sk_prot->sock_is_readable is a valid function pointer when sk resides
> in a sockmap. After the last sk_psock_put() (which usually happens when
> socket is removed from sockmap), sk->sk_prot gets restored and
> sk->sk_prot->sock_is_readable becomes NULL.

e.g., through

  psock_update_sk_prot
  tcp_bpf_update_proto
    sock_replace_proto
 
> This makes sk_is_readable() racy, if the value of sk->sk_prot is reloaded
> after the initial check. Which in turn may lead to a null pointer
> dereference.
> 
> Ensure the function pointer does not turn NULL after the check.

This is similar to the existing READ_ONCE in sk_clone_lock introduced
in commit b8e202d1d1d0 ("net, sk_msg: Annotate lockless access to
sk_prot on clone")

> 
> Fixes: 8934ce2fd081 ("bpf: sockmap redirect ingress support")
> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
>  include/net/sock.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 92e7c1aae3ccafe3a806dcee07ec77a469c0f43d..4c37015b7cf71e4902bdf411cfa57528a5d16ab3 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -3010,8 +3010,11 @@ int sock_ioctl_inout(struct sock *sk, unsigned int cmd,
>  int sk_ioctl(struct sock *sk, unsigned int cmd, void __user *arg);
>  static inline bool sk_is_readable(struct sock *sk)
>  {
> -	if (sk->sk_prot->sock_is_readable)
> -		return sk->sk_prot->sock_is_readable(sk);
> +	const struct proto *prot = READ_ONCE(sk->sk_prot);
> +
> +	if (prot->sock_is_readable)
> +		return prot->sock_is_readable(sk);
> +
>  	return false;
>  }
>  #endif	/* _SOCK_H */
> 
> ---
> base-commit: 82cbd06f327f3c2ccdee990bd356c9303ae168f9
> change-id: 20250525-skisreadable-toctou-382c42ffb685
> 
> Best regards,
> -- 
> Michal Luczaj <mhal@rbox.co>
> 



