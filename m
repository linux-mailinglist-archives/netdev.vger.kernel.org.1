Return-Path: <netdev+bounces-129353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E4797EFF0
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 19:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA9841C2139A
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 17:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB1219F12F;
	Mon, 23 Sep 2024 17:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nyHirkum"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCBE101DE
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 17:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727113718; cv=none; b=JApRfkywon/rO/HEQ9vsU19cmjo8+zm9nhmLHr1C7YjUc58q4CvmTn3QfqIwhiAr16via+CUZRPFWZZPZARTn/FIf796OuSdaj2apqUqrt0+Zth1AzXsFRS8LCpwWj08QWLDh4qr9IbjnQ54jox2q5gocBzlsDr87QVNa9MDDBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727113718; c=relaxed/simple;
	bh=gEjV/uYwwjYrOgwHF7XZdtEY5bjZDG9Xhyk6DNE7sTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KehguChKFmhouS6MrDd1dqIrEhpPhAkKt4b2kzVP0nig26AokN+BRVtROC4ExrLzkr3LsJSrc6DS9tQfhmL1xX7wtcyMjG8HoDCtq9kEB/jPWFhg2Khep470IeFEDeXTiYEUz6fko/dlUbEBgppCcztGVJ9yCeYEnuK8AY+lbNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nyHirkum; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-207349fa3d7so15565ad.1
        for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 10:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727113716; x=1727718516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFyak5RnuT875Gp2ABr6RPpPBsWc25+OkSd6B0cXYlQ=;
        b=nyHirkum55aoq9fKMrXTSi542ZZ0WHvDcjs5K/rzkze2jPe3KLOMI0juTDo5AgH+Aa
         GouO4e6Hx2evKcIJ3c1AWtyScILmFBZIKIU9d8Dy8RSjH09oYCm1jl6g0ifYqVXsLI2L
         fflewr6xOGQcYR4sIbnISC36k1qFNJ67CyyYS25xyGp/IT3bzsHAZhdcYxGgJWh3Rrm8
         N8MOK9fl2F860Y5xUYdXJ6yt3VUXVfOCSDO/Ono5FBaWSbMuYdOKSGi1CL76YlJPXUVu
         hgKs6tfgUUP7PBM3ZrDr2JUOZ4iY4+J7xDKJFDhOU+1yA1Ay1W471RuaucN6Bga4ywaA
         NRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727113716; x=1727718516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OFyak5RnuT875Gp2ABr6RPpPBsWc25+OkSd6B0cXYlQ=;
        b=WJTH5F4qgcaivSfBt0i6FQJypU6dNPcTwBOB/7HP78wrqfF4jVSm7DPWR/WsUoSKpb
         ccKyO2iaM9A04tCnRVRTvNB8JF99LTRIll1c3oQd1tuIQTRvQGoWlJzjGQS9MSDfreCM
         qq8wTl7HvkbNIg/w+/AgIOj1BMbd+EE0n2ZLyTJat0NLlitVhazNfsdTWwapQLEZYQ7B
         rRCXVM+5eEkeCuwH44iXWbyNxOKB37N2KZCddhvdp/bVGzLXEgH0FOto+3qBumLoju9r
         AKSIplkL0KvaSqwEs+N6jDj6IKUbatINb5FxIE0PxNCiKw4Jyp9F34Fg6D9ib6S3wB2W
         xcow==
X-Forwarded-Encrypted: i=1; AJvYcCUQGGlpuThCrqCgDoG3rcBUJZjWKQg/Of3cI9fT+LcoM8t0NqkLZ322PP5eHIZLOQ/2O6yX5To=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZtOjayAKf3IpP5Lhf6i1PYx9sIS2KL08GyDdlOWtECVE9S/mJ
	KOF0FzT9R8mr5AaGgYPZPRbVB+EK9y20Ic+eRLY5uVvJLxI2uBZ4M0YqMFG8aAcvFOSU18TpT6I
	BICVp8bLPVcgsFKbUEIQ9YNF3jeYOpY5c/N8/
X-Google-Smtp-Source: AGHT+IEtT7F95SSD33AgHpKxActzXDvqW17UGL/+EnJe2fHFx2Wj2kTC0kvo7SHJ2GAUMaal4ePtwVD+FlTZUK/hv3U=
X-Received: by 2002:a17:902:d4c7:b0:200:97b5:dc2b with SMTP id
 d9443c01a7336-208e3b5172amr3269765ad.15.1727113715946; Mon, 23 Sep 2024
 10:48:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923170322.535940-1-sahandevs@gmail.com>
In-Reply-To: <20240923170322.535940-1-sahandevs@gmail.com>
From: Jordan Rife <jrife@google.com>
Date: Mon, 23 Sep 2024 10:48:24 -0700
Message-ID: <CADKFtnS7JRHz1eg8M3V52MAcJUW3bVch2siaoqQSqMPW7ZrfUg@mail.gmail.com>
Subject: Re: [PATCH] net: expose __sock_sendmsg() symbol
To: Sahand <sahandevs@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Should this be backported? I'm wondering if this needs a "Fixes" tag.

-Jordan

On Mon, Sep 23, 2024 at 10:03=E2=80=AFAM Sahand <sahandevs@gmail.com> wrote=
:
>
> From: Sahand Akbarzadeh <sahandevs@gmail.com>
>
> Commit 86a7e0b69bd5b812e48a20c66c2161744f3caa16 ("net: prevent rewrite
> of msg_name in sock_sendmsg()") moved the original implementation of
> sock_sendmsg() to __sock_sendmsg() and made sock_sendmsg() a wrapper
> with extra checks. However, __sys_sendto() still uses __sock_sendmsg()
> directly, causing BPF programs attached to kprobe:sock_sendmsg() to not
> trigger on sendto() calls.
>
> This patch exposes the __sock_sendmsg() symbol to allow writing BPF
> programs similar to those for older kernels.
>
> Signed-off-by: Sahand Akbarzadeh <sahandevs@gmail.com>
> ---
>  include/linux/net.h | 1 +
>  net/socket.c        | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/net.h b/include/linux/net.h
> index b75bc534c..983be8a14 100644
> --- a/include/linux/net.h
> +++ b/include/linux/net.h
> @@ -258,6 +258,7 @@ int sock_create_kern(struct net *net, int family, int=
 type, int proto, struct so
>  int sock_create_lite(int family, int type, int proto, struct socket **re=
s);
>  struct socket *sock_alloc(void);
>  void sock_release(struct socket *sock);
> +int __sock_sendmsg(struct socket *sock, struct msghdr *msg);
>  int sock_sendmsg(struct socket *sock, struct msghdr *msg);
>  int sock_recvmsg(struct socket *sock, struct msghdr *msg, int flags);
>  struct file *sock_alloc_file(struct socket *sock, int flags, const char =
*dname);
> diff --git a/net/socket.c b/net/socket.c
> index 8d8b84fa4..5c790205d 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -737,7 +737,7 @@ static inline int sock_sendmsg_nosec(struct socket *s=
ock, struct msghdr *msg)
>         return ret;
>  }
>
> -static int __sock_sendmsg(struct socket *sock, struct msghdr *msg)
> +int __sock_sendmsg(struct socket *sock, struct msghdr *msg)
>  {
>         int err =3D security_socket_sendmsg(sock, msg,
>                                           msg_data_left(msg));
> --
> 2.43.0
>

