Return-Path: <netdev+bounces-135204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 367E399CC21
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 16:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8E4C1F2329F
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 14:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8E01D555;
	Mon, 14 Oct 2024 14:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G8NvRtRz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207FA18035
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 14:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728914503; cv=none; b=N9eRdeIqPgxb8QnteSYPA5odaDDE4bWr6YJirHe3eQVoojqFsivdp0cg8QfEjQ0JE68kWgtycC88kiWIRVgDIkByCmhpd7b304CU2KNmFL0McBt8+/100ZCk9B8YdU/ZUKmrj75YiqcPtQVfuEX9iSs7oLhm1lQAugDrhwyGpqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728914503; c=relaxed/simple;
	bh=v4hELI/EdJC2BAqjYIUZwnSQs05guozsGjIA3sTiodk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GbPgfeEh2oGcZxCmvvWPk8WFROhie1YS32wWuHoEj8BWY0FtFZ1NICNGs8OlzD/FpBK37yz0IQvtBbXj9pl41f+N166OjTed/lwjGpgRcP4jQX1IwI8hDWzrdPkFByPt2QsTRurWuRhVDzFHqg7A2I/1zgpPhLMXoNHsZDM1Xp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G8NvRtRz; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6cbe3e99680so21245356d6.3
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 07:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728914501; x=1729519301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uHef+4p7zJ9jSbkBJRKSzjiN829sE9ua1uFGURLxQo=;
        b=G8NvRtRzzZcXphfLj/sb+/a0jH9U+TXMW7v2HvnVzkslYWlOkvnQzFmcpYYQRDAl/B
         JQ/6x7z+H/Q7+7jjvH3/aKy7RL1w6NBIdTBYrXS/IJSJl7uiJSVugUbIbAGt3qrpDbw0
         ptJL7nVh7KmM3byQu/1gN01ZUIw21iSEvfQ5xSGirRDbAuhTgkC0co2YmVJh9MHdzAKW
         fWWeokUtlmDbRAP219WMipUvulFaWkn/1vbu2afVXR54bcg1P4wvJ8wEqOZv9j2e9VgF
         Q9OMtLtV4bbcLgLmalx4F9hWLGUZzdaeETwvPStBVxJa8fPiaCT5vAJtfLJaZoX3WUeW
         5NUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728914501; x=1729519301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4uHef+4p7zJ9jSbkBJRKSzjiN829sE9ua1uFGURLxQo=;
        b=xM4HKUIJrRGTIVEU3w62pj2UkN98KE1aE48xGD2sn7gj09TRkMUt7ObqbVxpJoyPZi
         8uGua/cajhDQ8qwtlMjpxFuHOkDqiIsjlGOjCE3sXR4YGIHcnOIK3mW7NRsqKU7OOupf
         7xG6MHHZCTXyZDy1EWEMkKEbRjy8zw6sEBzySkK8RDxSvZhDvVYgaAMmCVPn5IMCI3QX
         8Q1aTvnm/SZ+8vGlPj7Bbii8lD40AvCS19gaeMm1AlvuHHeWpmM0eD74OL2zrvScfv1w
         xMP4pPwH6sDkgxDljyC2eXju9Ym7yPMZx/8EgBvWn05CVcPhbG2ooo8QzmT1L2yP8DVd
         2PpA==
X-Forwarded-Encrypted: i=1; AJvYcCVQSd75LZBalCIL3xeHSu0Tlx7LW0NzfDa0EdEFj4nUoU4QqXk6e6NnYRiTzsGIT2Jvh2aawFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL0TVwtlRtR2rWq/g7jWtDTNREn9KDrOHq7Og3Zyd46YcEHVIo
	d3ywBb3c8jhVPfW3rNjMvUThx8G2u9llSEvHWVHszwcxJQ1jfaq7dIpHmniDefv9gGphz+PGSAA
	h10XS5N/r0xzOy6mETccWLmeJs+wphG2cV2h8
X-Google-Smtp-Source: AGHT+IF/gC2+jmdHtwLYfTBw9tKidwU3Vdob82+fpIf/FlW9NfSz/Kc7yLaU9Q8XouxMYQSa2zHdI9gRXK/JtJ5u6HY=
X-Received: by 2002:a0c:f408:0:b0:6cb:cc5e:1bcf with SMTP id
 6a1803df08f44-6cbeffe59b8mr152128516d6.21.1728914500572; Mon, 14 Oct 2024
 07:01:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010174817.1543642-1-edumazet@google.com> <20241010174817.1543642-2-edumazet@google.com>
In-Reply-To: <20241010174817.1543642-2-edumazet@google.com>
From: Brian Vazquez <brianvv@google.com>
Date: Mon, 14 Oct 2024 10:01:27 -0400
Message-ID: <CAMzD94TWJfWbVPEowP3fLvC3GEuYO=+XvTA=3uqMw_XXFEFgWw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 1/5] net: add TIME_WAIT logic to sk_to_full_sk()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Eric for the patch series!  I left some comments inline


On Thu, Oct 10, 2024 at 1:48=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> TCP will soon attach TIME_WAIT sockets to some ACK and RST.
>
> Make sure sk_to_full_sk() detects this and does not return
> a non full socket.
>
> v3: also changed sk_const_to_full_sk()
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/linux/bpf-cgroup.h | 2 +-
>  include/net/inet_sock.h    | 8 ++++++--
>  net/core/filter.c          | 6 +-----
>  3 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index ce91d9b2acb9f8991150ceead4475b130bead438..f0f219271daf4afea2666c4d0=
9fd4d1a8091f844 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -209,7 +209,7 @@ static inline bool cgroup_bpf_sock_enabled(struct soc=
k *sk,
>         int __ret =3D 0;                                                 =
        \
>         if (cgroup_bpf_enabled(CGROUP_INET_EGRESS) && sk) {              =
      \
>                 typeof(sk) __sk =3D sk_to_full_sk(sk);                   =
        \
> -               if (sk_fullsock(__sk) && __sk =3D=3D skb_to_full_sk(skb) =
&&        \
> +               if (__sk && __sk =3D=3D skb_to_full_sk(skb) &&           =
  \
>                     cgroup_bpf_sock_enabled(__sk, CGROUP_INET_EGRESS))   =
      \
>                         __ret =3D __cgroup_bpf_run_filter_skb(__sk, skb, =
        \
>                                                       CGROUP_INET_EGRESS)=
; \
> diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
> index f01dd273bea69d2eaf7a1d28274d7f980942b78a..56d8bc5593d3dfffd5f94cf7c=
6383948881917df 100644
> --- a/include/net/inet_sock.h
> +++ b/include/net/inet_sock.h
> @@ -321,8 +321,10 @@ static inline unsigned long inet_cmsg_flags(const st=
ruct inet_sock *inet)
>  static inline struct sock *sk_to_full_sk(struct sock *sk)
>  {
>  #ifdef CONFIG_INET
> -       if (sk && sk->sk_state =3D=3D TCP_NEW_SYN_RECV)
> +       if (sk && READ_ONCE(sk->sk_state) =3D=3D TCP_NEW_SYN_RECV)
>                 sk =3D inet_reqsk(sk)->rsk_listener;
> +       if (sk && READ_ONCE(sk->sk_state) =3D=3D TCP_TIME_WAIT)
> +               sk =3D NULL;
>  #endif
>         return sk;
>  }
> @@ -331,8 +333,10 @@ static inline struct sock *sk_to_full_sk(struct sock=
 *sk)
>  static inline const struct sock *sk_const_to_full_sk(const struct sock *=
sk)
>  {
>  #ifdef CONFIG_INET
> -       if (sk && sk->sk_state =3D=3D TCP_NEW_SYN_RECV)
> +       if (sk && READ_ONCE(sk->sk_state) =3D=3D TCP_NEW_SYN_RECV)
>                 sk =3D ((const struct request_sock *)sk)->rsk_listener;
> +       if (sk && READ_ONCE(sk->sk_state) =3D=3D TCP_TIME_WAIT)
> +               sk =3D NULL;
>  #endif
>         return sk;
>  }
> diff --git a/net/core/filter.c b/net/core/filter.c
> index bd0d08bf76bb8de39ca2ca89cda99a97c9b0a034..202c1d386e19599e9fc6e0a0d=
4a95986ba6d0ea8 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -6778,8 +6778,6 @@ __bpf_sk_lookup(struct sk_buff *skb, struct bpf_soc=
k_tuple *tuple, u32 len,
>                 /* sk_to_full_sk() may return (sk)->rsk_listener, so make=
 sure the original sk
>                  * sock refcnt is decremented to prevent a request_sock l=
eak.
>                  */
> -               if (!sk_fullsock(sk2))
> -                       sk2 =3D NULL;

IIUC, we still want the condition above since sk_to_full_sk can return
the request socket in which case the helper should return NULL, so we
still need the refcnt decrement?

>                 if (sk2 !=3D sk) {
>                         sock_gen_put(sk);
>                         /* Ensure there is no need to bump sk2 refcnt */
> @@ -6826,8 +6824,6 @@ bpf_sk_lookup(struct sk_buff *skb, struct bpf_sock_=
tuple *tuple, u32 len,
>                 /* sk_to_full_sk() may return (sk)->rsk_listener, so make=
 sure the original sk
>                  * sock refcnt is decremented to prevent a request_sock l=
eak.
>                  */
> -               if (!sk_fullsock(sk2))
> -                       sk2 =3D NULL;

Same as above.

>                 if (sk2 !=3D sk) {
>                         sock_gen_put(sk);
>                         /* Ensure there is no need to bump sk2 refcnt */
> @@ -7276,7 +7272,7 @@ BPF_CALL_1(bpf_get_listener_sock, struct sock *, sk=
)
>  {
>         sk =3D sk_to_full_sk(sk);
>
> -       if (sk->sk_state =3D=3D TCP_LISTEN && sock_flag(sk, SOCK_RCU_FREE=
))
> +       if (sk && sk->sk_state =3D=3D TCP_LISTEN && sock_flag(sk, SOCK_RC=
U_FREE))
>                 return (unsigned long)sk;
>
>         return (unsigned long)NULL;
> --
> 2.47.0.rc1.288.g06298d1525-goog
>

