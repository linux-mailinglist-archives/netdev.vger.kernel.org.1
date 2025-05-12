Return-Path: <netdev+bounces-189883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B665AB44C9
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 21:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37ADE19E7D92
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 19:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00472298C01;
	Mon, 12 May 2025 19:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/B1dZSX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E85D2561BD
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 19:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747077496; cv=none; b=k5hmjbE5Y16h0ZhL1qFQNoU7dG6SppE0hma28BY0G91lUGxlT8wfwT9hqMJsCOETQGPjCH+5Qfi3x+Vova3gbM2stlqR5qFNLaRJgegDzxVLZK9aKpF26jybEfnKsY3iJggaWzuIrBJNFTpfb0v/CZKN7F8t5R2xlx5J/Kz3By8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747077496; c=relaxed/simple;
	bh=8C4E//naIxKKxzqDpOiSP7npJgU6Um6jEGkClVSyESc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Wv6T5D6q8ufbNQ7s4+15eEtpRbC7AMtDHDU4mMt965EAbN5EVtxUdWtm2CofXsxSG622M5dMPK34f7uAhyT0DkU9C052m6s0W5UitAL45Y4zlznTIXA6NevnmLVkQoIxQ/LmxD6Cww/jvgFtmgR3TZgc80xEZtmAlHuI6lnf/6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/B1dZSX; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c5e1b40f68so587865085a.1
        for <netdev@vger.kernel.org>; Mon, 12 May 2025 12:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747077494; x=1747682294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/YJomC9U333BJ7oyNNCXWzlYzuRAMJRXKhnCrAr2iU=;
        b=T/B1dZSXC8hFLMVflp5IWjYKp1kanl8eIlVg0vAXaFtZkKp8L5+quE83DbROtGGyM6
         ycdF2j+N4dLQM5OSgBtjEE9yxzpP4q4Io8Nan9X+zWhmUWw/MdQRje9udVjueZxeZVec
         MMb4l9zeo1HROd7EL9NP8zdh8lwRY0vvTyMrl6fu3MaZLyvTmsrwG3eE8WNf4SQ/s/h4
         8VEspOv9t/j3oDOIEIp82wzg1j5r8Ln4tp1DE6gPpe11o6dD2+iwyHaaJdlQq94V6O15
         OaQqAKpWbS/07vLED4TTIfo51cnCbWvOhiBjlmzEyIak9AM292bE7zwnaklrHnL3FtG1
         mVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747077494; x=1747682294;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y/YJomC9U333BJ7oyNNCXWzlYzuRAMJRXKhnCrAr2iU=;
        b=uVHrGlu+UNw5BOVlHCS69ZE7TvGxI/NsSKJoDGVHXVBZq8DqSxQYKME4nl75zlwLAK
         sKDs3cLaKJjf2jfcL2UHlTEweuxfPiif4TbX/u/4Mo1vPH9qFYDef8R/G1h6zwW6ye5I
         ReiGEXC3FEa1r1uTqeyt6kNwBuJaVsHdNGPicnnywjrznSirpOm+MuECk7LQ5sKrnmfk
         NBOV6fx4M6zVHIYPsdEz3RgJtXhwhiPFa0LmS8ay2FGX6FSWDF8ZP41l7/unYTkFeWEx
         lqifS+lKkSzWTjr8POgEvPbfiAusDkzDHF4rxJsR85EnEunc3ftk+HBy9p8C9NHVreg5
         oOHg==
X-Forwarded-Encrypted: i=1; AJvYcCWwCoRtY6nD+V6FpAz8CYS7JAZVP1jn6YkmzDqPdVBJfD3Kd+rJJ19PbZ94nORKkORcIIM8+Pc=@vger.kernel.org
X-Gm-Message-State: AOJu0YznJEspchlWyTZ453p2VTmM8g0rOe3rJGvqfzG0aMsL8mXFrO5n
	QO21AgFBZB6Gqpi9UM/Wi/mq7+YSBge8wWiscu8+G2u1vM35S9XY
X-Gm-Gg: ASbGncsTfm5BZPbjSaC3+9bdZMcySw3FsQC3dpv8n2fIU1qKsr2VDP+GTFlMCeSlKSv
	zSXBfxjsBQbIaWBFWW+UzRPpqA/DFn5e/5LctjzSTTbvQviWbnvDcCWQr4gwGE1oLZoUKXqHceQ
	pFJaUCwLyieIOZS70wmQjrajHmPdrbS5aOJKKSxgQwxIR1yqnR0Ql48FmzcgtIwMbpUnRuEgSx9
	1HnUbChY59NBJNN2BmTgAiSOv+QwzLKmVVftGdRi/goUmtkdNYeMqqanICQ5ZMoiuztw+sxnUiQ
	cE7Y/YJujHPzileGnjOeT0kF30CGxl1ZfApMF5/pfftYtQ6GuuYdDeKO3yK3Gw1EuZu5pCY0Skn
	J0UguHy60JgsQnLoXCEHgzTk=
X-Google-Smtp-Source: AGHT+IEFqJ00+z9tFRz1AMs3sPaNK3++PSWW2QTikzwD2fGK39L67N0gatKjwkgnS7XouD+OqTEsgw==
X-Received: by 2002:a05:620a:290b:b0:7c5:50cc:51b3 with SMTP id af79cd13be357-7cd0110802dmr1894281885a.33.1747077494002;
        Mon, 12 May 2025 12:18:14 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7cd00ff106dsm587084485a.117.2025.05.12.12.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 12:18:13 -0700 (PDT)
Date: Mon, 12 May 2025 15:18:12 -0400
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
Message-ID: <68224974de7ed_e985e294b5@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250510015652.9931-5-kuniyu@amazon.com>
References: <20250510015652.9931-1-kuniyu@amazon.com>
 <20250510015652.9931-5-kuniyu@amazon.com>
Subject: Re: [PATCH v2 net-next 4/9] tcp: Restrict SO_TXREHASH to TCP socket.
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
> sk->sk_txrehash is only used for TCP.
> 
> Let's restrict SO_TXREHASH to TCP to reflect this.
> 
> Later, we will make sk_txrehash a part of the union for other
> protocol families, so we set 0 explicitly in getsockopt().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/core/sock.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/sock.c b/net/core/sock.c
> index b64df2463300..5c84a608ddd7 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1276,6 +1276,8 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
>  		return 0;
>  		}
>  	case SO_TXREHASH:
> +		if (!sk_is_tcp(sk))
> +			return -EOPNOTSUPP;
>  		if (val < -1 || val > 1)
>  			return -EINVAL;
>  		if ((u8)val == SOCK_TXREHASH_DEFAULT)
> @@ -2102,8 +2104,11 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
>  		break;
>  
>  	case SO_TXREHASH:
> -		/* Paired with WRITE_ONCE() in sk_setsockopt() */
> -		v.val = READ_ONCE(sk->sk_txrehash);
> +		if (sk_is_tcp(sk))
> +			/* Paired with WRITE_ONCE() in sk_setsockopt() */
> +			v.val = READ_ONCE(sk->sk_txrehash);
> +		else
> +			v.val = 0;

Here and in the following getsockopt calls: should the call fail with
EOPNOTSUPP rather than return a value that is legal where the option
is supported (in TCP).


