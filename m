Return-Path: <netdev+bounces-189886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8867EAB44D1
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 21:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2690189E7D0
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 19:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFF1298256;
	Mon, 12 May 2025 19:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHFn25QF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092CF23C4E5
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 19:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747077658; cv=none; b=BDCL/I9R4W35vxtGqzKtp736wgcbZiNn+Npv8/uxq0cPWDcpPPQnHThvloX3lNNBXphKIWeR8JXHVS5MWDixslp5HZ8DUJp3ujX3TpnssNb6DdOEq3HQLlDzLJpXpMc3/cT/0v71grYwS1hPTs0ovLNfw7GwCLkUaiH6KxV+bs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747077658; c=relaxed/simple;
	bh=1Xj+dW+UpEAxDo1Rez3S+2IOwJwRzdbg88zo4Vr3eiU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=WnneFfrVnEDF0F//Lo8HfL3LoG1c4bp+d06gSd/T/FX0wq29LosjBqm6W2J0Fct5kMXNwWcnfvWGA+PLFlBylP01Rmh0K9TOS4XOZdm852t6hSIeflwTieR6vKkZKikYl1h/7bETkuZlMGvbu0vG2SthplpUiPimmd9+6+3tDzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHFn25QF; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c5a88b34a6so527005985a.3
        for <netdev@vger.kernel.org>; Mon, 12 May 2025 12:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747077656; x=1747682456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjUyFzvHznaAqLr564GzzjYcfhQQWLiVl5ZtURQrBZ0=;
        b=HHFn25QFKQ2pavSw3xIml7CVstPoee3S5gadps42Z8tOWfSMgA7c3SyDMIuIGMM1eA
         6c5zwGdfmUBShz0l98oU8YCIhB1i99JBek2NI0ojeCkRs8Kt3J/Fo4QLY64E/L60kx0h
         fnvwjaLgFH4kF3Rh1xBHO+uukmnhPJ+E7zT7FhRaDsUsQyiNIZ+1KvWxT0zJHn2vkqvk
         FC/LvMhzdyMU2mDIUetVkwu50EnKMes8WJxriT0Owb/k4B1Z6gVWB4J/7XEGMzeHlv9C
         gxEp8Cybzb7f3ZS5ZyXKL3i2SzMZY5reyAd76n8ggoshbOl6ftWZMaDUYkukQ9+TolAK
         QHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747077656; x=1747682456;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mjUyFzvHznaAqLr564GzzjYcfhQQWLiVl5ZtURQrBZ0=;
        b=oXrnXdVgdu5CiXYtal4QjYAbb/tPSsDY2edzDZd84wZCRgPAKWZCBERkkjKRP+V3bc
         WdWVzl7pYC50k0bls734DjLwZvj/Dv/PAatOteVevkt1a2DlnX45Q3Dk40EPnOjc18u0
         mdaKsoTxcZ9WXbIfhJ7BPIvqjMvJj5tPwT6wSXUOdfIgJaqn1EDQ1O16tLAShzm8YQse
         2qDdspp2sBcFsXBkdDP4DFd/wVWn9G5I8rlMgCQGgrr8lE4Iygl3/cxPzmLDEhY9ETCb
         7gsFMT/LiOsYakRpqOENvB37t0IqiOCiwadqPYPTh8uhvn2fJsmRUr+Jvs5M67TUc5G2
         ZX1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXCY913aBgoD6ecUt5BiIxdnPoUhWOmNzi1Ih7EFF7kx+lItXg4JaHfrmPvbmODinzuKbl5JWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRhDodb1EfomkPgmuZ5IaFVj83FE4AJ3YkMyX023laMwTUC67L
	aJSYmTD5VqbG9DPDZnd5hXpmPF/oa25wxvSjcJ4llROyEAvIVW7K
X-Gm-Gg: ASbGncvHIYhrt83HD+i5SXizZkvg6/6D4PZyzGD7uCWLdiLf+Mm/JTcESzfShWRI9y6
	oz8/KKeihfkXV464Y1zMrRaHsGb07pXXuY2zR+KEQrwdYCHfELiHqBegBDXytkyJnuLOY5t90Oi
	SH5eP3OfDMqXIdXx5SPrSX44oqSQRijrq5bonZ33bt/wYIoOcbNpTphvfO9SBDVgZF0VUod0/39
	4RmTzZPKjJuuRIIDfBbBfNBrhPe9nMlsLT4WCVW8CV/XCO4rOPK0vT1T5LufF+JcQBvEntWwS2p
	QGLTPshL5k2LgmH8SDqoDb2k8PwyxvEsv7q4ScXfeafohhxStl5Fxq7aBOChcRa7elJg2lbq8ak
	kArxNhiTqTHcp66wES0rmMOY=
X-Google-Smtp-Source: AGHT+IH7UKbO/biwgQ5CT99u8uBc3TLVxTCYrMLGVvFskgb9PglGdxjo3J8LVOx2ty0IGOsDPudLkQ==
X-Received: by 2002:a05:620a:4511:b0:7c5:5fa0:4617 with SMTP id af79cd13be357-7cd0113916fmr2946461285a.40.1747077655684;
        Mon, 12 May 2025 12:20:55 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7cd00fdc5besm588665085a.89.2025.05.12.12.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 12:20:55 -0700 (PDT)
Date: Mon, 12 May 2025 15:20:54 -0400
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
Message-ID: <68224a16ebe11_e985e29446@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250510015652.9931-7-kuniyu@amazon.com>
References: <20250510015652.9931-1-kuniyu@amazon.com>
 <20250510015652.9931-7-kuniyu@amazon.com>
Subject: Re: [PATCH v2 net-next 6/9] af_unix: Move SOCK_PASS{CRED,PIDFD,SEC}
 to struct sock.
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
> As explained in the next patch, SO_PASSRIGHTS would have a problem
> if we assigned a corresponding bit to socket->flags, so it must be
> managed in struct sock.
> 
> Mixing socket->flags and sk->sk_flags for similar options will look
> confusing, and sk->sk_flags does not have enough space on 32bit system.
> 
> Also, as mentioned in commit 16e572626961 ("af_unix: dont send
> SCM_CREDENTIALS by default"), SOCK_PASSCRED and SOCK_PASSPID handling
> is known to be slow, and managing the flags in struct socket cannot
> avoid that for embryo sockets.
> 
> Let's move SOCK_PASS{CRED,PIDFD,SEC} to struct sock.
> 
> While at it, other SOCK_XXX flags in net.h are grouped as enum.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

> diff --git a/net/core/sock.c b/net/core/sock.c
> index 1ab59efbafc5..9540cbe3d83e 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1224,19 +1224,19 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
>  		if (!sk_may_scm_recv(sk))
>  			return -EOPNOTSUPP;
>  
> -		assign_bit(SOCK_PASSSEC, &sock->flags, valbool);
> +		sk->sk_scm_security = valbool;

Is it safe to switch from atomic to non-atomic updates?

Reads and writes can race. Especially given that these are bit stores, so RMW.

>  		return 0;
>  	case SO_PASSCRED:
>  		if (!sk_may_scm_recv(sk))
>  			return -EOPNOTSUPP;
>  
> -		assign_bit(SOCK_PASSCRED, &sock->flags, valbool);
> +		sk->sk_scm_credentials = valbool;
>  		return 0;
>  	case SO_PASSPIDFD:
>  		if (!sk_is_unix(sk))
>  			return -EOPNOTSUPP;
>  
> -		assign_bit(SOCK_PASSPIDFD, &sock->flags, valbool);
> +		sk->sk_scm_pidfd = valbool;
>  		return 0;
>  	case SO_TYPE:
>  	case SO_PROTOCOL:
> @@ -1865,14 +1865,14 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
>  
>  	case SO_PASSCRED:
>  		if (sk_may_scm_recv(sk))
> -			v.val = !!test_bit(SOCK_PASSCRED, &sock->flags);
> +			v.val = sk->sk_scm_credentials;
>  		else
>  			v.val = 0;
>  		break;
>  
>  	case SO_PASSPIDFD:
>  		if (sk_is_unix(sk))
> -			v.val = !!test_bit(SOCK_PASSPIDFD, &sock->flags);
> +			v.val = sk->sk_scm_pidfd;
>  		else
>  			v.val = 0;
>  		break;
> @@ -1972,7 +1972,7 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
>  
>  	case SO_PASSSEC:
>  		if (sk_may_scm_recv(sk))
> -			v.val = !!test_bit(SOCK_PASSSEC, &sock->flags);
> +			v.val = sk->sk_scm_security;
>  		else
>  			v.val = 0;
>  		break;

