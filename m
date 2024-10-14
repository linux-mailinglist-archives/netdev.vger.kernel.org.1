Return-Path: <netdev+bounces-135209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F2499CCA2
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 16:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BD0E2810A0
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 14:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E44E1A76A5;
	Mon, 14 Oct 2024 14:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z08mEjPM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC011A0BE7
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 14:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728915644; cv=none; b=fGGaMk6T0siClyMB46W+StpJLojjhjjzz3sVubkoJcSdmYKoBWDYmgkQr3KM9obzvKpLeXjOLLhrOtaOU9TG8fXlQAeZ5we8Outj+a8Kvt4NRDgfCjn0qZ1/EVcUNIdXCxMOXO33ByBtKhFYUrxxaHmAHGRDEjWjJzk/Oz+ycUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728915644; c=relaxed/simple;
	bh=PniAvpkIvytnTkyjS5RTzw1RfgPwQT96+SxzQQBuTXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gl7mswwUg8XWa9VXt1BNhvTH3fgpLX06xDxHm5TMbodWSvbnbGTID0F0gT4uR2FQO9HXcJYzanPtIcQP4iV1nzW72xMkYavcvo8LAdTalV+SnbomYsZ2SwGs7euaFUClfgRD5O2YoNIGZBYvWQnfHXy+ZXUfyMPraXZripWywLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z08mEjPM; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6cbc28f8e1bso35922076d6.0
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 07:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728915642; x=1729520442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhktcoSgbFqwYLSJSA/nlzWnZy5S2Lbs/PZGLFtLvGk=;
        b=z08mEjPMXTdnB9WK4FO1p2NozzgU7Clbqhrv/aQDU+o89+VLxD+43+6Az72YUq6T9/
         TefdoCa/zOvhTsIk1THiLfZ2/newwzwro4WHfozuPPsEgXeSr8XlxXwv0dcDQ2fv4Nqu
         a0AeOuSKKBTY8YGhtLXLc7/x8eRZBbgHR48G9eYWBoHVFyY3YqvyoZVKM8zMe4jf2chg
         btYs2LgWBb6LycbzTnYJLpEaYVdCIe1qBGOI408Ys+fHTCbKybik2hrngSM3iyAVie5f
         2iBDb/0Kzm7wts3grDz/K26pjJzLW5Mrxs+SR6URpjNxkELFwqJkmsSPZNS6XrpeydDl
         IxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728915642; x=1729520442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FhktcoSgbFqwYLSJSA/nlzWnZy5S2Lbs/PZGLFtLvGk=;
        b=Oe33no8Ut7/UCHwVdRZw9dwJoSkLSVuWYhgEAHYvvXWEt+VFbyaF4GWqdActBfex9M
         99q4nCGk+7apqYW36jepl6xzWUBMA7aOpiGCnxndhJ5/Dn2KymxWTUPxDeGv3w8O30cd
         m3/Luk/k2Jnm7Hj8Pv6YcpL/qiyRfgzsJtro/BOMdSpjctFzEmHF8+TzRQ8NX9kh6ABg
         6dJWsPQu9uSsCU4RffnQJzEVdmkCyWsn6//1aTzqVQBUYmTgJs8ZBkEvRSmGjyeQZ1jE
         Xykuvs1cU5sdXfff+MdMBSKTryjf7Weni3TqNFYzUia2TpQrYb4z5M49A8TcsUbfPqWe
         /Ehg==
X-Forwarded-Encrypted: i=1; AJvYcCWEkj4ErCCQf8NIeUDMWqq9wQohL2wdIhja+lD2jJEQVBzBJtHTPKNecHph6yWFk+CafgEoOkM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7c9lJvlDDvcc1gu+CBjGaRSDdakv3VHYeEsObs6pgC7G49hCt
	cSbjFrMYYlHPp/GbJidpdVZaw6ysSoaOz8d/NoZDObb/iKl7rJvEcTddQ+CW8bQbbzcG49k5AbH
	p8Q2y9/Go7x5sRcSSvlGfu9aEBUG28ZE6mWx8
X-Google-Smtp-Source: AGHT+IFI8By2BMAp3qRh8zq9Lrx7uIsFNu41PGMrRi9X8aLIj7J+nMjyuYzxnUdCN75lx49SkFZgioS7HTBHTFNV4Pw=
X-Received: by 2002:a05:6214:4186:b0:6cc:221:9049 with SMTP id
 6a1803df08f44-6cc022193f6mr102580256d6.15.1728915641795; Mon, 14 Oct 2024
 07:20:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010174817.1543642-1-edumazet@google.com> <20241010174817.1543642-4-edumazet@google.com>
In-Reply-To: <20241010174817.1543642-4-edumazet@google.com>
From: Brian Vazquez <brianvv@google.com>
Date: Mon, 14 Oct 2024 10:20:28 -0400
Message-ID: <CAMzD94SwQhKO_-8Xi5axbjb7X+Hb6n99yvQFQkzHUMcyKhRFqg@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 3/5] net: add skb_set_owner_edemux() helper
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 1:48=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> This can be used to attach a socket to an skb,
> taking a reference on sk->sk_refcnt.
>
> This helper might be a NOP if sk->sk_refcnt is zero.
>
> Use it from tcp_make_synack().
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/sock.h    | 9 +++++++++
>  net/core/sock.c       | 9 +++------
>  net/ipv4/tcp_output.c | 2 +-
>  3 files changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 703ec6aef927337f7ca6798ff3c3970529af53f9..e5bb64ad92c769f3edb8c2dc7=
2cafb336837cabb 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1758,6 +1758,15 @@ void sock_efree(struct sk_buff *skb);
>  #ifdef CONFIG_INET
>  void sock_edemux(struct sk_buff *skb);
>  void sock_pfree(struct sk_buff *skb);
> +
> +static inline void skb_set_owner_edemux(struct sk_buff *skb, struct sock=
 *sk)
> +{
> +       skb_orphan(skb);

Is this skb_orphan(skb) needed? IIUC skb_set_owner_w is doing
skb_orphan too? and then calling this helper, but we do need the
skb_orphan is needed when called from the synack.

Can skb_set_owner_w try to orphan an skb twice?


> +       if (refcount_inc_not_zero(&sk->sk_refcnt)) {
> +               skb->sk =3D sk;
> +               skb->destructor =3D sock_edemux;
> +       }
> +}
>  #else
>  #define sock_edemux sock_efree
>  #endif
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 083d438d8b6faff60e2e3cf1f982eb306a923cf7..f8c0d4eda888cf190b87fb42e=
94eef4fb950bf1f 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2592,14 +2592,11 @@ void __sock_wfree(struct sk_buff *skb)
>  void skb_set_owner_w(struct sk_buff *skb, struct sock *sk)
>  {
>         skb_orphan(skb);
> -       skb->sk =3D sk;
>  #ifdef CONFIG_INET
> -       if (unlikely(!sk_fullsock(sk))) {
> -               skb->destructor =3D sock_edemux;
> -               sock_hold(sk);
> -               return;
> -       }
> +       if (unlikely(!sk_fullsock(sk)))
> +               return skb_set_owner_edemux(skb, sk);
>  #endif
> +       skb->sk =3D sk;
>         skb->destructor =3D sock_wfree;
>         skb_set_hash_from_sk(skb, sk);
>         /*
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 1251510f0e58da6b6403d2097b498f3e4cb6d255..4cf64ed13609fdcb72b3858ca=
9e20a1e65bd3d94 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -3731,7 +3731,7 @@ struct sk_buff *tcp_make_synack(const struct sock *=
sk, struct dst_entry *dst,
>
>         switch (synack_type) {
>         case TCP_SYNACK_NORMAL:
> -               skb_set_owner_w(skb, req_to_sk(req));
> +               skb_set_owner_edemux(skb, req_to_sk(req));
>                 break;
>         case TCP_SYNACK_COOKIE:
>                 /* Under synflood, we do not attach skb to a socket,
> --
> 2.47.0.rc1.288.g06298d1525-goog
>

