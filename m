Return-Path: <netdev+bounces-219810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DA7B43179
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 07:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A7BE7ACA75
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 05:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C9B23C51D;
	Thu,  4 Sep 2025 05:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJCLTkN9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0941E33E7
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 05:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756962248; cv=none; b=gWHuFpOcRO3ZwZoccpbQWUVuG/xCZoc+o6jwiC4nzMPh8bU3b4XYTtxVky6SWxA/xM1xY/uDd9+ViqcA1kWydQR+j17PzUNmdVGnjVv9l3Z1ESURP09zTfyE0xRWCHhVALyh3vUfDLn74dKhftV+xJgWTb9OppruZTIy08fd/lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756962248; c=relaxed/simple;
	bh=iBIsPR5+rR+6fbG/cbI7VrPM80xyW1sRiQ1wjvwptiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fTjtXxU7gIw5UIMNAo5i6KsUwv2XEP1m6rO2hO31tAvWWF8bwb/XdACRYKkrb5ODTQsKI/ef+lN8xoDu43rsQlzkY08Dyv05tFsnBKrFucPwReREdWNOEL7rgYpHnvtQ9z4ZkErPr8Vhhtyzn/76vbsfbuSRig9bibW78Vu65Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJCLTkN9; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3f33ecb34c0so7424595ab.0
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 22:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756962246; x=1757567046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bJP4Ng9i9EDEvrfb8FPdis/y6jwkG7FSSgCfJ1CVoA=;
        b=eJCLTkN92a2qVEs9ZY4rbnZJgOpa4fLMMhEdXLOe+rtqilxQ+b0vtdCPWPWOM3MGox
         GK6/OVOKHqzrHGUV2Jqlf0mWW+dveNmsfLrDGLYpPhOw1cgTXT2uiIvIol8M3Th07tv3
         8aZfxiTWzkYDJ7BtxdJsMzK8mzptzTCb2nkQSy0CqY0VTZjHU+1PbDYdmPGREzPsOHx0
         iEuzIXjvK1bLQSr9q78YvxU5mnuoO6p/4ZqUweuo2r+CcLJ1SXYCO6u5dLFLd69tXMbK
         K+BLAUjK7IYoyN1QJVPcUWTWG6G0JDnL7FAoEekCraZY/mAug393kZQdZB+v2cw7tWVo
         hUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756962246; x=1757567046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9bJP4Ng9i9EDEvrfb8FPdis/y6jwkG7FSSgCfJ1CVoA=;
        b=C/yFvTTrNNSbzuuOrPap7UpohQIz8wq0KSCr68pIgvvufbVOY2bRsa/nN1iifdMDNI
         EiZ6qYcVSC68C65+q4Otfh3SpHcxJrvIZIRUPuUo0h6tCMiAaWY9aArQXhbERHfKSRsR
         kbwbdVK8m1Azr7JRxm0F6dPOnkQW4sww0ZRldZOBFSbtgxv7B/F7phvPzumT5A0lWQdW
         3eBSgKiBuB08ygwh4bZwcxbZaHVTsrP4kvl+Ob/r0ww37bYgQNSE0PCvg7cS51Iz61NE
         s2CvSPe11HIckE6DmVaCKtTpLSPCswdXKGN+sXGt1cX5+Wq4nJHaZ/Ggi2VQqBlQ9fTY
         5mtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeuntCznm+7jBhHckZGPRIG9DrI5XUzakj4K5WFwCFcGZbqlcjFAZsmLSYRfwTPwdRCGBkzAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiJuD5suA4I/MJobmv+e47xx31qKVNReVliY88257Gt3evSk5I
	uEgUig0qbn5eq9sby3MqaCabzEOmNhaPfLpLDzhSJcNYGAxUtwfr/8Q4669l30tGToZMoAHLCHL
	mFINsZ1h7WF4QRZL2tDydC3uOqLKqyvo=
X-Gm-Gg: ASbGncusPe3ntSUFzOlDL9rO2gUAmhFs1KseDmOHupBr8ZFEGQnperkWE8EbVKG3l3l
	KxdGQ5SyYabhw4aT9AFcHbclZhpMJIPGRfERx/MewdqykO3CdWFmKEq57oblt+sDS5ltJ9CZ/9a
	uR3vtGKe0oiGoaT+N6oY9B3bGIkhrrNigFlUzG3lanW0ORaiTvZozMRJN4JtvXwr83jKrLiOx+6
	wywWSc=
X-Google-Smtp-Source: AGHT+IGWrbnQLKITkrdWv992PAsTAlothAPdruwZjYiQCVo1ZX5ICd7ZlCuDMTN185a++9sRKhcUecQS8M+gdcCPJ6s=
X-Received: by 2002:a92:ca4a:0:b0:3eb:87a2:aead with SMTP id
 e9e14a558f8ab-3f401bee16dmr336156675ab.18.1756962246037; Wed, 03 Sep 2025
 22:04:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903084720.1168904-1-edumazet@google.com> <20250903084720.1168904-2-edumazet@google.com>
In-Reply-To: <20250903084720.1168904-2-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 4 Sep 2025 13:03:28 +0800
X-Gm-Features: Ac12FXwdqxbOUXlGpEdlFAMJAVJE4JvSxFmTEgm7ln4FsooL2oOyzsL1hvTBxY8
Message-ID: <CAL+tcoCqey97QW=7n_S8V9t-haSe=mu9iE1sAaDmPPJ+1BkysA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] tcp: fix __tcp_close() to only send RST when required
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 4:47=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> If the receive queue contains payload that was already
> received, __tcp_close() can send an unexpected RST.
>
> Refine the code to take tp->copied_seq into account,
> as we already do in tcp recvmsg().
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

Sorry, Eric. I might be wrong, and I don't think it's a bugfix for now.

IIUC, it's not possible that one skb stays in the receive queue and
all of the data has been consumed in tcp_recvmsg() unless it's
MSG_PEEK mode. So my understanding is that the patch tries to cover
the case where partial data of skb is read by applications and the
whole skb has not been unlinked from the receive queue yet. Sure, as
we can learn from tcp_sendsmg(), skb can be partially read.

As long as 'TCP_SKB_CB(skb)->end_seq - TCP_SKB_CB(skb)->seq' has data
len, and the skb still exists in the receive queue, it can directly
means some part of skb hasn't been read yet. We can call it the unread
data case then, so the logic before this patch is right.

Two conditions (1. skb still stays in the queue, 2. skb has data) make
sure that the data unread case can be detected and then sends an RST.
No need to replace it with copied_seq, I wonder? At least, it's not a
bug.

Thanks,
Jason




> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/tcp.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 40b774b4f587..39eb03f6d07f 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -3099,8 +3099,8 @@ bool tcp_check_oom(const struct sock *sk, int shift=
)
>
>  void __tcp_close(struct sock *sk, long timeout)
>  {
> +       bool data_was_unread =3D false;
>         struct sk_buff *skb;
> -       int data_was_unread =3D 0;
>         int state;
>
>         WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
> @@ -3119,11 +3119,12 @@ void __tcp_close(struct sock *sk, long timeout)
>          *  reader process may not have drained the data yet!
>          */
>         while ((skb =3D __skb_dequeue(&sk->sk_receive_queue)) !=3D NULL) =
{
> -               u32 len =3D TCP_SKB_CB(skb)->end_seq - TCP_SKB_CB(skb)->s=
eq;
> +               u32 end_seq =3D TCP_SKB_CB(skb)->end_seq;
>
>                 if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN)
> -                       len--;
> -               data_was_unread +=3D len;
> +                       end_seq--;
> +               if (after(end_seq, tcp_sk(sk)->copied_seq))
> +                       data_was_unread =3D true;
>                 __kfree_skb(skb);
>         }
>
> --
> 2.51.0.338.gd7d06c2dae-goog
>
>

