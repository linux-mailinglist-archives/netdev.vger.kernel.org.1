Return-Path: <netdev+bounces-204413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFA9AFA5A8
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 16:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71D897AB891
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 14:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46B0F4E2;
	Sun,  6 Jul 2025 14:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m26BqOPy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2062E3700
	for <netdev@vger.kernel.org>; Sun,  6 Jul 2025 14:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751810549; cv=none; b=EVsgx0RC7g2S/XxLu8iikiX3gs+d+nFuQfKtjIGViogGkzgsa64YTie3024rxg19sxjrGaWWtv9cp7LqvBwja2y11RscntSgMDwczACoYXzCJjgYVzkzd8N/K/ZrylSWNRJpZe+TCjWWoyogrFjKn0tMeFZR9eWqS6j5rS2omV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751810549; c=relaxed/simple;
	bh=M13KugF1Ws0QBtUBcnC7d32T74BfCi8DqZTDRHjXYq0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=kVMmoXdmmeDIc3+5knaiD309ptZZ2CB+71jpnIMVubnKN99JiyXrTfsz/oW/RJTryB1O2TALs2ABZz8hzqV2I9l+CS+Ee4p/ORTzVJ0BYuqWJhhAyC7KIHlqSpK/NS1VVVIZPxBlHWhVxnbOXaJs89VZASdbTYahdJUChp0dQUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m26BqOPy; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e7387d4a336so1771377276.2
        for <netdev@vger.kernel.org>; Sun, 06 Jul 2025 07:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751810547; x=1752415347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QZ6wmwyGXii0Wu+TrRn9Ig1CfOT0Nay8M5P76inQEg=;
        b=m26BqOPyXBV/jpRO5PO66utNyR81K6PTp6tSeSu5meUqW8G2nJBRZq7/cAKznLFKzv
         2eZoAHGAMtg9sly0o9W9a1h3thATuxic7B1IYjrVuBemr+2wPvpVtgFRiRSbRpdok0Yy
         ypoU9IdM8diuO3VjznXahkl42dbmdG8AzbS+qrC+21LS55+g+b/C1hHeQ6xa0cB6ojep
         JBvCAuDHoVuN06h1esoo4GtZc7+VLMfmn6HhWaKDYrXxivgza94jBOXwrtdEdb70sIlk
         acWETzXrTfZiigyoZp0EzjaZSYY88hL83Be3Gncg+0M/FC/SrHhnS9i0Zpmm/2bJZUBA
         jdpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751810547; x=1752415347;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6QZ6wmwyGXii0Wu+TrRn9Ig1CfOT0Nay8M5P76inQEg=;
        b=V6BZWyTo3v5/A6NBUh2vEioaGI5zMvoAK/ZWxvgLCMgur3Gatq1kPyYlD0otZYBSEm
         SpZuhcWKOLpIhWUe54nB6mAloVt0QSAw+a9iUfa/bMIduGtrE5wFL/8dqKLOTnOV+FJB
         bx/EVYQgaDqet10HlzNVLCBXI3Rh+IdGY4TI248KjQaN+enJJUZs/BhSWb3YxIjxSNWW
         uyosqY6P6ARL5dZOL83LTRMb3bvNiEBIXSza4aZpPE1E58JiLUaZyJHp7K7Y4ZykuUlg
         kypL2klHw/xhLWU2JDDzZL82qRqZ5OIN1JwKQZatKCvGgT/AdX3kP1ef0KfQibWhPMaB
         mDtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxP1PTeQLDG+XtA8Npg1jWeQCcYKUvtFjy7XsUbTq+Cu8AW16MRypASBtdYmAkxqPfs7KU9Kk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMZ7y/AUsdNr4ggxc+633yc48LJM997Oq5rwKdLc5AfNLsNrhP
	yugD+HDrp5a5tcrSWplVALtfw/Q/q6zwkrI5W8Je13AoT7xZJ8wzOhDO
X-Gm-Gg: ASbGnctvtkhX6Fa+Qsd8KkticoAi5CpIaz58KVaELjdpfOYDHwaDcliWXwz+Lg8Eifo
	26LpH8bVo0/LnR7p9TifSp8x9FJoQ5wR7dO95SBn0rcwQZeOr5ySD2maNTOgShKo0mDNLWTGhNA
	AAfhD1tQz6Q3yCNTtfmlR0Ul75V/eaLwPadWwb5xgzkvdkW7hqbb7fOLIv1fW4JpEQe3kCaPUVI
	SFy3f4jn3lqOI0+/9ceJH6khT1D/CQo6MsYy/RXed1M9n1eCY5tk903V56OaYAcXiWqEwSbdSts
	bEId8/YUS51ze9NkBnErL/T6p6PG/BxBMqgGxH6Sk80YImPtPnTQ4l0q6URQziAJyBtDb+J2gmZ
	uVniha2uTUO1C0InbPQGk9sAuHzgUKcB7+pbESKPs2fITYQ7haQ==
X-Google-Smtp-Source: AGHT+IE0w14l3euFA51VKLaGtgpdpeYidtn0JopqpG9Oz/GuiHFLnI7VLxR9YN3Zq2ie1t6NzG3cmQ==
X-Received: by 2002:a05:6902:4585:b0:e8b:3e1c:14db with SMTP id 3f1490d57ef6-e8b3e1c1619mr3868367276.34.1751810546997;
        Sun, 06 Jul 2025 07:02:26 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e899c48f85asm2004240276.47.2025.07.06.07.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 07:02:26 -0700 (PDT)
Date: Sun, 06 Jul 2025 10:02:25 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Kuniyuki Iwashima <kuni1840@gmail.com>, 
 netdev@vger.kernel.org
Message-ID: <686a81f1ec754_3aa65429440@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250702223606.1054680-7-kuniyu@google.com>
References: <20250702223606.1054680-1-kuniyu@google.com>
 <20250702223606.1054680-7-kuniyu@google.com>
Subject: Re: [PATCH v1 net-next 6/7] af_unix: Introduce SO_INQ.
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
> We have an application that uses almost the same code for TCP and
> AF_UNIX (SOCK_STREAM).
> 
> TCP can use TCP_INQ, but AF_UNIX doesn't have it and requires an
> extra syscall, ioctl(SIOCINQ) or getsockopt(SO_MEMINFO) as an
> alternative.
> 
> Let's introduce the generic version of TCP_INQ.
> 
> If SO_INQ is enabled, recvmsg() will put a cmsg of SCM_INQ that
> contains the exact value of ioctl(SIOCINQ).  The cmsg is also
> included when msg->msg_get_inq is non-zero to make sockets
> io_uring-friendly.
> 
> Note that SOCK_CUSTOM_SOCKOPT is flagged only for SOCK_STREAM to
> override setsockopt() for SOL_SOCKET.
> 
> By having the flag in struct unix_sock, instead of struct sock, we
> can later add SO_INQ support for TCP and reuse tcp_sk(sk)->recvmsg_inq.
> 
> Note also that supporting custom getsockopt() for SOL_SOCKET will need
> preparation for other SOCK_CUSTOM_SOCKOPT users (UDP, vsock, MPTCP).
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> +static int unix_setsockopt(struct socket *sock, int level, int optname,
> +			   sockptr_t optval, unsigned int optlen)
> +{
> +	struct unix_sock *u = unix_sk(sock->sk);
> +	struct sock *sk = sock->sk;
> +	int val;
> +
> +	if (level != SOL_SOCKET)
> +		return -EOPNOTSUPP;
> +
> +	if (!unix_custom_sockopt(optname))
> +		return sock_setsockopt(sock, level, optname, optval, optlen);
> +
> +	if (optlen != sizeof(int))
> +		return -EINVAL;
> +
> +	if (copy_from_sockptr(&val, optval, sizeof(val)))
> +		return -EFAULT;
> +
> +	switch (optname) {
> +	case SO_INQ:
> +		if (sk->sk_type != SOCK_STREAM)
> +			return -EINVAL;

Sanity check, but technically not needed as SOCK_CUSTOM_SOCKOPT is
only set for SOCK_STREAM?

> +
> +		if (val > 1 || val < 0)
> +			return -EINVAL;
> +
> +		WRITE_ONCE(u->recvmsg_inq, val);
> +		break;
> +	default:
> +		return -ENOPROTOOPT;
> +	}
> +
> +	return 0;
> +}
> +


