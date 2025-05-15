Return-Path: <netdev+bounces-190805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5443AB8E7A
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 20:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CADDA1BC5B76
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 18:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E51259C83;
	Thu, 15 May 2025 18:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYdO38ER"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF7E258CED
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 18:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747332429; cv=none; b=KWfHxVEGQL3ZDR5KIf+/n1D8U/R1z5C0+TXCKiY5fRGX5BgNXHjcQ7UbdiRPAbAGzxr+gbJ4dsoOWuD3GIz/EzVe20OiAOrxX9zIfFPzw2swhtalpB6T3+6efgKDble2wrbFdZEWiKNY+d5HqSPW2yQyZR9oIqawMXX6/yBQEFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747332429; c=relaxed/simple;
	bh=UfkRAC4qpgpaZfsCDo9L4vpZKdvv/ZofwvSx8Jxm7Zc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=gndwAHr4u9KsqoItTGYBpMTZj64yUgniBr3HRQ5spWY7NMD04LQ9398evlKzeoSWxyDaz6sQff789fVO75w1s5lOufqE9O5pMAUjRsT0fZIJX/eB81lQ+32h9Z3c+Vkqv44VEL248eO8R/9LE02SCpcx/uBCy5t1wXvv1iLJPLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYdO38ER; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-47692b9d059so18739261cf.3
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 11:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747332427; x=1747937227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RR7JrnS7mfr7qhFH8RRXZCc6PLy2j/Crv9ZkvGeQOgk=;
        b=dYdO38ERfWFuRmzu1xWKdUI+cBF2z50Tsi7uUddXOM2fSESQAus6feOlEnmjaeY1rW
         sojGhYrR386XHq1xPzXc0GXHBxokBjDBfsluOxeiN2ABwMvGJmrmIc45uT3Xft9iMitY
         EvFh+L+sqUl2fgWZkxL9Zrkx4zxlFEgt3uGuouBzQY2NOVlXNOSrS2/GxhmL6Nm5+mvl
         eKh52F6KehDU6pxd9xJQ1UyU6Si169+zAKCfmoqyj9KitEK300YY7tCgf3uXxBwRm5oK
         koTPp4oWBXbWZJrGi1pa+WAd40Q+F9EGwN21am6HWfP8CcQjJz1zeSmHaQJnROAXT4A3
         XXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747332427; x=1747937227;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RR7JrnS7mfr7qhFH8RRXZCc6PLy2j/Crv9ZkvGeQOgk=;
        b=uZQNlRLwaiy+T1UI1u6osWYJyDEtsWF7SX2PmyA13XK4e3pT+9HYN1ugVbrb+jWJhN
         Rwgb68hhgmrrlJwFevehIu6SUfZGK2a857db1r2YKuIkEoyfMg1jlgNlUlBY9ZMX5SXw
         0vq8QV8w7HPs2kEoMrSo0iIRdl1Pl/weKY5BSS9hjQtPw1YhUb87eqfYiMBQnjAhPDQj
         rwkc6GVHArfMZVF2L2vAreYJI0g3E+KRbjqBV6B18KxFps3ZHIj+IOVdrmFIyu2ruKQE
         0uNahWZzQcCaLtWuLEBtK1/mcQcsk8zJGzIW/a5tVdsl3W+kx9Kgj3zsQLPvgT55RJTm
         Inxg==
X-Forwarded-Encrypted: i=1; AJvYcCXSPVcl2j9UInOlCeITFdQnl7WQ2hRzt/1CXZIHuVRf9VNgaty6EicJ8YLhOyW1e281YTD9cUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwrpJcfZv6olYavrjo74qFUGQc1uI8qtrKxRq1fwTS7wfH6wBL
	MIFAzx8UCQTopaAceFPQoYfuxa162DpjJ7SgXz4ik2/l6hjcjI91tbQ8
X-Gm-Gg: ASbGnct93bXdARKklYL42dChTkEo2yxIJWYd9y06u2jlM1pwS1965UvnP6MgznIPdyP
	23S3lM7jdbk6ewyaLRU/lz8FpwUtkoiASP8MxdLHEaGAgo3GBB6etMlDjCgEppfvyb5+DZuqPpB
	3z6lGwsh3AJe8e+YJ9Yw/Wdi5Y1ttOEwWXAQmFJRWUlUgm2TbpLRGqgZ0AiZyXrxWf0Fv3DEACy
	7ocuHienkIIvZ7LNvVTbTXWdpnx/DOElUzhN0vCKEOPqLDNtRLwwtcZJtdMwyIdBUTy4xG9K0yi
	Iv6vyBQrP+DIjRarAFH35g6e/dRxQ9Gc54wKlSpnDi+Nx1+2NH5Y1apYDp9Mq/cx8DV4dTohewv
	Tjp2xRa6vAhzsGaKLi7llNt4=
X-Google-Smtp-Source: AGHT+IFhic3BbMv7NU/0fkBJr6GWELOAuzAJKbexx/LRz82xF//d47Uy6HV3WYMY8JiUZuNF7jOvMw==
X-Received: by 2002:a05:622a:1f16:b0:48a:3498:92f2 with SMTP id d75a77b69052e-494ae37fb71mr6505581cf.21.1747332426955;
        Thu, 15 May 2025 11:07:06 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7cd468b69dfsm13586185a.79.2025.05.15.11.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 11:07:06 -0700 (PDT)
Date: Thu, 15 May 2025 14:07:06 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: Simon Horman <horms@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Kuniyuki Iwashima <kuni1840@gmail.com>, 
 netdev@vger.kernel.org
Message-ID: <68262d4ab643_25ebe529488@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250514165226.40410-2-kuniyu@amazon.com>
References: <20250514165226.40410-1-kuniyu@amazon.com>
 <20250514165226.40410-2-kuniyu@amazon.com>
Subject: Re: [PATCH v3 net-next 1/9] af_unix: Factorise test_bit() for
 SOCK_PASSCRED and SOCK_PASSPIDFD.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kuniyuki Iwashima wrote:
> Currently, the same checks for SOCK_PASSCRED and SOCK_PASSPIDFD
> are scattered across many places.
> 
> Let's centralise the bit tests to make the following changes cleaner.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/unix/af_unix.c | 37 +++++++++++++++----------------------
>  1 file changed, 15 insertions(+), 22 deletions(-)
> 
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 2ab20821d6bb..464e183ffdb8 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -765,6 +765,14 @@ static void copy_peercred(struct sock *sk, struct sock *peersk)
>  	spin_unlock(&sk->sk_peer_lock);
>  }
>  
> +static bool unix_may_passcred(const struct sock *sk)
> +{
> +	struct socket *sock = sk->sk_socket;

Also const?

> +
> +	return test_bit(SOCK_PASSCRED, &sock->flags) ||
> +		test_bit(SOCK_PASSPIDFD, &sock->flags);
> +}

