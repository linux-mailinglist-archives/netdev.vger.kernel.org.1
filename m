Return-Path: <netdev+bounces-138397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF439AD526
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 21:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91A6C1F211E8
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 19:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160DA14A62A;
	Wed, 23 Oct 2024 19:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AvPnixrD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CBA1531E2
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 19:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729712744; cv=none; b=LBYnlGZrut1A10ZLhNbQ1SzpjeYDuXoqVfQ9xrCBdOFHU98b43OQFct7jo+sOc0sjEKWQhEhUPqwb8BbU0MBhLQvsSJku5aiTzDCp1BJLi064cgI8J/nmYKpzBo2Q0ZMxLWLBNOPUqlf1AFNaCPmCsIxUt3l9f00/iVsr0L1OCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729712744; c=relaxed/simple;
	bh=+MV49VNRw8B0TjjckLQd05cv65UXlZOBtiNKoFzcK5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UtFpXvC2Xb5kB/VxI18itNiM65KnHEH8qdB2AJfdyYqgrrQHD/FCz0QjsWBWlPqdYM10KgVuerCAYowrPMNWcnJwTQIMAhODPotcuklt0Jw1JLPhbSH9/QtTtbdebjGE4OYq21xd6bg/CG27b7n6ODO24JaaJGuWg34psnznJrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AvPnixrD; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5cb72918bddso168207a12.3
        for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 12:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729712741; x=1730317541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QQTFMVzhcND8juE7Qy8sY5sQfMWCLjXl6WwfGdao68=;
        b=AvPnixrDN41ZB4d1kIdZHgQzBcfgxN/QjkJBnG0EPBcLOPaW7QRz4/MXub0rfHXR/U
         yjcxiywK/ULpCyQz7b9v3tp0TKfvQW0cuhUhGJMYu8fvtKXrDXzqN7kAawKz/PXgQfl1
         5sK+lD4LGT0ZNKBjRMMoYTuPWd9NDf3Q7K44TlWjh7reNpvsDxAP4mAwZPdqbuh1ALF1
         Wy4RnP2GI85mRJQS1BjLX10mZMQ/DVKhzAFGb6W9CYTmd0kdb1IN3piUqpbZvSIaqVRt
         aJQPoDB8I79NzxJae6GXVoW//ZdNOJZn0OFp2QesDXU7fmuR3ez50pI2WV/PyVM3ubOu
         Oq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729712741; x=1730317541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7QQTFMVzhcND8juE7Qy8sY5sQfMWCLjXl6WwfGdao68=;
        b=hJmXgdRAuDyBTcgPnRBCKoK+EJskccDlTEJfgdJ0y5yYIOz6D0jTRQddrHa+ZRU5NJ
         HbvojRLx35xxNVd2q8jNd7tvBgR5jxkTHdP5HTxVXYneAGVhkd2CgR8nt65O+oUzbEpS
         R76IMs/iBkDshcgBH08MqUU5MvvdG92D03sOQFSp/Q9gNO6CIPpBjLsnmx+37oC/dS39
         WulmyngGCBmWVI39sO9TOeZHqGsd050Q+M5flVrk2h1Zu9BEQldftPlN1HNUobQoLxlf
         lNQD8CnuoM3Ew73/L9V15VjJOwpSdSjqCpLk9d0a7QIsSRnpHXxHT3oR1Sc3XkAtuS4B
         jJTw==
X-Forwarded-Encrypted: i=1; AJvYcCUYb3SUac7Khh7SNnPa4/Pm9Yitx2dUZF1P11YxKiEgxDKVcRO0TgiJkPm49qA0muUCO2oJDcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKgpI0ICxS0rnnJNRla8N7eOeZXUCcvX0w5If7hLwpUThtNDb0
	izKq03gJNIfEI0hH3phvtxWZWdiji1WSh8rVzcnDdqsSMEppD21zjjXgNmC2dFmrTjp5MTTEjZJ
	ZigmQTksaDi7TSslZd6H2Clxx+jVeGNVBlYqg
X-Google-Smtp-Source: AGHT+IGtHmyKClzsoYyTrKaavw474Mpnq8stE8apB89/3zvO4wmoU+rcg3mGvWIdD9+ajKKp++qD4KqGweauchkrIUI=
X-Received: by 2002:a17:907:7294:b0:a99:4d67:eac1 with SMTP id
 a640c23a62f3a-a9abf96eb78mr331172366b.52.1729712740306; Wed, 23 Oct 2024
 12:45:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023191757.56735-1-kuniyu@amazon.com>
In-Reply-To: <20241023191757.56735-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 23 Oct 2024 21:45:26 +0200
Message-ID: <CANn89iLEvu-bkrDWZnzG66vcbQbb2NS=U0XqH-iwa=ONE3tiQA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next] socket: Print pf->create() when it does not
 clear sock->sk on failure.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Ignat Korchagin <ignat@cloudflare.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 9:18=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> I suggested to put DEBUG_NET_WARN_ON_ONCE() in __sock_create() to
> catch possible use-after-free.
>
> But the warning itself was not useful because our interest is in
> the callee than the caller.
>
> Let's define DEBUG_NET_WARN_ONCE() and print the name of pf->create()
> and the socket identifier.
>
> While at it, we enclose DEBUG_NET_WARN_ON_ONCE() in parentheses too
> to avoid a checkpatch error.
>
> Note that %pf or %pF were obsoleted and later removed as per comment
> in lib/vsprintf.c.
>
> Link: https://lore.kernel.org/netdev/202410231427.633734b3-lkp@intel.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  include/net/net_debug.h | 4 +++-
>  net/socket.c            | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/net_debug.h b/include/net/net_debug.h
> index 1e74684cbbdb..9fecb1496be3 100644
> --- a/include/net/net_debug.h
> +++ b/include/net/net_debug.h
> @@ -149,9 +149,11 @@ do {                                                =
               \
>
>
>  #if defined(CONFIG_DEBUG_NET)
> -#define DEBUG_NET_WARN_ON_ONCE(cond) (void)WARN_ON_ONCE(cond)
> +#define DEBUG_NET_WARN_ON_ONCE(cond) ((void)WARN_ON_ONCE(cond))
> +#define DEBUG_NET_WARN_ONCE(cond, format...) ((void)WARN_ONCE(cond, form=
at))
>  #else
>  #define DEBUG_NET_WARN_ON_ONCE(cond) BUILD_BUG_ON_INVALID(cond)
> +#define DEBUG_NET_WARN_ONCE(cond, format...) BUILD_BUG_ON_INVALID(cond)
>  #endif
>
>  #endif /* _LINUX_NET_DEBUG_H */
> diff --git a/net/socket.c b/net/socket.c
> index 9a8e4452b9b2..da00db3824e3 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -1578,7 +1578,9 @@ int __sock_create(struct net *net, int family, int =
type, int protocol,
>                 /* ->create should release the allocated sock->sk object =
on error
>                  * and make sure sock->sk is set to NULL to avoid use-aft=
er-free
>                  */
> -               DEBUG_NET_WARN_ON_ONCE(sock->sk);
> +               DEBUG_NET_WARN_ONCE(sock->sk,
> +                                   "%pS must clear sock->sk on failure, =
family: %d, type: %d, protocol: %d\n",

%ps would be more appropriate, the offset should be zero, no need to
display a full 'symbol+0x0/0x<size>'

