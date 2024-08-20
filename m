Return-Path: <netdev+bounces-120179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C44958804
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 15:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13844282738
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 13:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A6618DF91;
	Tue, 20 Aug 2024 13:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lx1NJNkV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA32519066E
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 13:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724160874; cv=none; b=NYNrmLIDNXxDW0m2fKM4BI33voUe19uyfbhnuudbwOUtc0ZkI8SfBYeJM4aBFsAaVva7iWqgGi0ec1G9Ac4Xm5317MfZihXTZjl4GUZFxoFrQlLJGKL4a6leOa7AzsJb/J5NBB7qFVc4iWytcUsScyXSrevLwayEyw0KzL4zg0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724160874; c=relaxed/simple;
	bh=4rAOebSkYQWUT0B8ZOvcRecB1bHaU0M9qrG/anKfliQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g31DqNKzswcSbbqU77/WylCev/EzdVaAejL0lLwBcfqJ0HZwH+xCkm+3Hyq7fzUobmfOhYRK/25B0N7kYg/TJy635xbNuwV2PQ7BWYVxgPEXI0XXsU3t+9DVVGCjDP2omD05B9FaHqfFvOc1eRwndArupwWEF/w+lmTW5mpwmjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lx1NJNkV; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8384008482so581990266b.2
        for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 06:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724160871; x=1724765671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DmZRuVIyzJtzre6hzz/PcxvSlDgzRjvRMuB8GOjZgwQ=;
        b=lx1NJNkVs5Ihif7z4UbhFA+nCXeb1sPwSAwCyNsNjX/cgcIVDLJwcc+QYssBkRY612
         TwrLcF2noKN11zlCtjUFb/tgnG5+ri68ROCqFMm+LomOX5GuXgz9vd7lb9PGajNd1tdK
         /1R+s2+nLBkmTHrdTDeBJWO+iymmjasC1EVP2gCVCOg45iJJ5bABBrMq7u1rHAj8t+mk
         u93B9dh7FGqC8AG3h8ql151gt3e44g7Db4POdH9+pf1MspK4/k8c4BPIGfcw/1/a2tLg
         bip3JPbjkf6RMm3DRFSoR4G83BPNKeSv4VZ/4T1DqSAGXtaMWP9xEERxjALytv4xROC1
         1hnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724160871; x=1724765671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DmZRuVIyzJtzre6hzz/PcxvSlDgzRjvRMuB8GOjZgwQ=;
        b=NLJP+UKLSc6unVXnIOjLBUw4zFVEHkTy3k/ScZ5lNWisEOG98eMThVlGiHYjf5WaHA
         idWgXkt9P2Om7pOd0G5PRtNLnJK1hRLJdwMbuTH9rbn4WaYBQlpLwBpjAvpFt1+/Shyc
         5zMskl/VbAs+h90SqcmQffImqO6OxjmJPnEpy9kCOkw4o5fjoSuVyPoAWT6R0EEzCuxe
         R45Ov+51CN/+DDBtesxrWHqdTkdTkjb/T4CYD7ReDKkgcgrdEWHOzaXeT8SF02PjDqru
         at86+tUPLFdwif0VAKrX/twHbFNYQGfdvpyAsMF1dhoBi31kbKljGIY7i0YQlqoVRpmY
         Iaow==
X-Forwarded-Encrypted: i=1; AJvYcCWHCjm2fNsuUcm94i1gipZ7ZjBEk0tR3wdv2VYCaU5uXWDjNprHTRADr+axvwUewNdZ1HJrrLNh2aOUHsUWeAQudGgczRpN
X-Gm-Message-State: AOJu0YwVLPS0tpJ6j6yiJsWtulloduhApxAEB8X2ZjQduEd2qYdOqc1i
	1yp5SgJujyUj1yt0zspqCnhl4Pwh795HGHo60SNhOtxGRLwCYLRW7LUOdVR6Z425BE8wr2xn3+A
	aY2mbW7WynQ+Dk9LomX3cwaA1SwE50tbV/pWX
X-Google-Smtp-Source: AGHT+IGrqzEjg0mXwGTvo0DxGM61h1zcgtHtwvobdt+IhN6pvMNacHx/EAEX0coKj8on2sWHUyU5ONhGfyhKRUpqQHs=
X-Received: by 2002:a17:907:2d2b:b0:a72:7d5c:ace0 with SMTP id
 a640c23a62f3a-a864795d21amr169791466b.11.1724160870204; Tue, 20 Aug 2024
 06:34:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820034920.77419-1-takamitz@amazon.co.jp> <20240820034920.77419-2-takamitz@amazon.co.jp>
In-Reply-To: <20240820034920.77419-2-takamitz@amazon.co.jp>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Aug 2024 15:34:15 +0200
Message-ID: <CANn89iLqWG_YWKq+Fvg+REWG=cFnNyZ8w+bV-V-xbh+bes3_Bw@mail.gmail.com>
Subject: Re: [PATCH v1 net 1/2] tcp: Don't drop head OOB when queuing new OOB.
To: Takamitsu Iwai <takamitz@amazon.co.jp>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 5:50=E2=80=AFAM Takamitsu Iwai <takamitz@amazon.co.=
jp> wrote:
>
> If OOB is not at the head of recvq, it's not dropped when a new OOB is
> queued.
>
> OTOH, as commit f5ea0768a255 ("selftest: af_unix: Add
> non-TCP-compliant test cases in msg_oob.c.") points out, TCP drops OOB
> data at the head of recvq when queuing a new OOB data subsequently.
>
> This behavior has been introduced in tcp_check_urg() by deleting
> preceding skb when next MSG_OOB data is received. This process is
> weird OOB handling, and the comment also says this is wrong.
>
> We remove this code block for appropriate OOB handling.
>
> Now TCP works exactly the same way as AF_UNIX, so this patch enables
> kernel to pass the test when removing tcp_incompliant braces.
>
>  #  RUN           msg_oob.no_peek.inline_ex_oob_drop ...
>  #            OK  msg_oob.no_peek.inline_ex_oob_drop
>  ok 18 msg_oob.no_peek.inline_ex_oob_drop
>  #  RUN           msg_oob.peek.ex_oob_drop ...
>  #            OK  msg_oob.peek.ex_oob_drop
>  ok 28 msg_oob.peek.ex_oob_drop
>  #  RUN           msg_oob.peek.ex_oob_drop_2 ...
>  #            OK  msg_oob.peek.ex_oob_drop_2
>  ok 29 msg_oob.peek.ex_oob_drop_2
>
> Fixes tag refers to the commit of Linux-2.6.12-rc2, but this code was
> written at v2.4.4 which is older than this version.
>
> This is a long-standing bug since then, and technically the patch
> slightly changes uAPI, but RFC 6091, published in 2011, suggests TCP
> urgent mechanism should not be used for newer applications in 2011.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Takamitsu Iwai <takamitz@amazon.co.jp>
> ---
>  net/ipv4/tcp_input.c                          | 25 ---------
>  tools/testing/selftests/net/af_unix/msg_oob.c | 55 ++++++++-----------
>  2 files changed, 22 insertions(+), 58 deletions(-)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index e37488d3453f..648d0f3ade78 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -5830,31 +5830,6 @@ static void tcp_check_urg(struct sock *sk, const s=
truct tcphdr *th)
>         /* Tell the world about our new urgent pointer. */
>         sk_send_sigurg(sk);
>
> -       /* We may be adding urgent data when the last byte read was
> -        * urgent. To do this requires some care. We cannot just ignore
> -        * tp->copied_seq since we would read the last urgent byte again
> -        * as data, nor can we alter copied_seq until this data arrives
> -        * or we break the semantics of SIOCATMARK (and thus sockatmark()=
)
> -        *
> -        * NOTE. Double Dutch. Rendering to plain English: author of comm=
ent
> -        * above did something sort of  send("A", MSG_OOB); send("B", MSG=
_OOB);
> -        * and expect that both A and B disappear from stream. This is _w=
rong_.
> -        * Though this happens in BSD with high probability, this is occa=
sional.
> -        * Any application relying on this is buggy. Note also, that fix =
"works"
> -        * only in this artificial test. Insert some normal data between =
A and B and we will
> -        * decline of BSD again. Verdict: it is better to remove to trap
> -        * buggy users.
> -        */
> -       if (tp->urg_seq =3D=3D tp->copied_seq && tp->urg_data &&
> -           !sock_flag(sk, SOCK_URGINLINE) && tp->copied_seq !=3D tp->rcv=
_nxt) {
> -               struct sk_buff *skb =3D skb_peek(&sk->sk_receive_queue);
> -               tp->copied_seq++;
> -               if (skb && !before(tp->copied_seq, TCP_SKB_CB(skb)->end_s=
eq)) {
> -                       __skb_unlink(skb, &sk->sk_receive_queue);
> -                       __kfree_skb(skb);
> -               }
> -       }
> -

My opinion is that we should not touch this code.

No one sane uses OOB and TCP, otherwise this issue would have been
discussed a long time ago.

If anyone is using it, then your change will change the behavior.

Fact that you changed tools/testing/selftests/net/af_unix/msg_oob.c
should speak by itself.

Note that OOB has been added to AF_UNIX recently, it should have
followed TCP behavior.
Honestly we should not have accepted OOB on AF_UNIX, this was a real mistak=
e.

