Return-Path: <netdev+bounces-85358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD90E89A5EA
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 23:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 730752835E5
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 21:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8C8174EEC;
	Fri,  5 Apr 2024 21:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VvRLXW37"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B8C17279D
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 21:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712351210; cv=none; b=EeBbYtcnq8yzZkUTPgs/WCHyN7i3SUUzD0o+N2KKUMDsSHciPS9+4/VQwutMMa988FQBDAiY5uygI4UuNBbzwxUEvzz2zRmepysOTP1N3ZuxrahFTywWjK4JyV7/nkdJ5dOaCoaZYLzWR18jaiD4yMrRtGG8Q2QUubV17JDovpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712351210; c=relaxed/simple;
	bh=F/hVe/fmOOuo0o6CNbkfgO4cW4jlV2LebeUs36oQ4jU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iojBlr+sv3/PnMH8KjNRUL2Tq0uxTLNdeqLimzXTp+DWs22aJ9eyRYPHwNZMHpCOg3ux/T4Pnl2BeZyEYVVJ3cMWxoU+boKO4BeNWNpa1+ciTmKJh2Dhh4GYSAATB/sE5qxctZ/rRudm6GtQ0t+S5PXLWaayU2jaLb7ogfifMWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VvRLXW37; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56beb6e68aeso1222a12.1
        for <netdev@vger.kernel.org>; Fri, 05 Apr 2024 14:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712351206; x=1712956006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0cxei4ORlfPQCmegMyRswRYodv9cfdwuAGjxFKELSY=;
        b=VvRLXW37ASiGPelSwPaT1uNPzpY5HjfbxK1y48V/JrI4kiVUVvC15hz/j+8B0CRoBB
         eYl8/yNWnseL5HRzlAU5NRfWjil/hiD3iPp4WgAXvQHiA5ntCvG0FbcFh9nWr/4V5dxh
         PiBcJ3QWaQPEwWp/9TQ/pqrchQ2ku2Z6dq0ekl7Y0Z4dbicrA+XKx/BdSTN0op8s4EnK
         iTVe+3Zmfuc7OY9k9bwLSmH2o8SEwv9WFLDjKh+fUZp2IiWw40N3G8tB7WXcUzOyZ4Yo
         i96t+vNm7rZENSx8BmGsC5kn75xut/s6epjk/lYzc/iYPzRqptcIBw+pxPuTV3ETEr3W
         zLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712351206; x=1712956006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y0cxei4ORlfPQCmegMyRswRYodv9cfdwuAGjxFKELSY=;
        b=mKoJe7997v9HRJPWaO0pDhkUGiN2k77MA7DuBPxsx2boAVSmhWHyFFLgJImilKMZlJ
         AGv7e2qEQd9Im8ucAMA3KuVWlxk3r+grQLChj/BjzL+uO2VYt/Z/FYuB0WJHeIOFCqc0
         wwuD73K+n/d3v/lTEw2et0A4h+CqKBd5Yieck6uKtT/YRSSszf/QNjXwDI7muJpHnTgX
         ys8dDi+4E1j1SovtQ93ahXyxFgQvtHnt4jeEsk4AOYoAXAtFll/5HqgdIEERv4EacLVJ
         V4DxAJRJvmNq5w7ZvNYfdjRExQy5cG9HKx+E0NN3Y8Tu62o/U9TI84WrYmKmcqviWzrU
         TwgA==
X-Forwarded-Encrypted: i=1; AJvYcCXHoyxh/eo7tLwPT1iiLSuqtS7uru9nt45yYQAwaxDyFLeKo3sxvz1zHwW8KM6Kj8S9JniAqd3i1/gj6/cEZ9w5/cPrYZ5D
X-Gm-Message-State: AOJu0YzlwjAUKLMnviBJT7lf1HtVAysDqnRPFgXs7szNJRwcg2/k79Nm
	Dd7LKTAF7SUMpdpvL8OsREqP0/YQuSN14JreaCbKvcjjWuuylx94w03WA35dTAlp8s30XMbPbEA
	h2DmXEYu1haWdBaNhK/SNRTYoMykuRiNAYEur
X-Google-Smtp-Source: AGHT+IHxkVuWnDiiKHRr67i5gtuiQWncr7OPN3z4D8xxJ+E/9r0elPObhZZ0foP5iG+DGQsVGo+3SY+RB+wr3TxqnXo=
X-Received: by 2002:a05:6402:c9b:b0:56e:3486:25a3 with SMTP id
 cm27-20020a0564020c9b00b0056e348625a3mr4782edb.1.1712351206227; Fri, 05 Apr
 2024 14:06:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405204145.93169-1-kuniyu@amazon.com>
In-Reply-To: <20240405204145.93169-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 5 Apr 2024 23:06:32 +0200
Message-ID: <CANn89iK=9PVZ9y0Oh6sWiQn0OdohGBX0_vf=OdT3_0ULaFcgrA@mail.gmail.com>
Subject: Re: [PATCH v1 net] af_unix: Clear stale u->oob_skb.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rao shoaib <rao.shoaib@oracle.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+7f7f201cc2668a8fd169@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 10:42=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> syzkaller started to report deadlock of unix_gc_lock after commit
> 4090fa373f0e ("af_unix: Replace garbage collection algorithm."), but
> it just uncovers the bug that has been there since commit 314001f0bf92
> ("af_unix: Add OOB support").
>
> The repro basically does the following.
>
>   from socket import *
>   from array import array
>
>   c1, c2 =3D socketpair(AF_UNIX, SOCK_STREAM)
>   c1.sendmsg([b'a'], [(SOL_SOCKET, SCM_RIGHTS, array("i", [c2.fileno()]))=
], MSG_OOB)
>   c2.recv(1)  # blocked as no normal data in recv queue
>
>   c2.close()  # done async and unblock recv()
>   c1.close()  # done async and trigger GC
>
> A socket sends its file descriptor to itself as OOB data and tries to
> receive normal data, but finally recv() fails due to async close().
>
> The problem here is wrong handling of OOB skb in manage_oob().  When
> recvmsg() is called without MSG_OOB, manage_oob() is called to check
> if the peeked skb is OOB skb.  In such a case, manage_oob() pops it
> out of the receive queue but does not clear unix_sock(sk)->oob_skb.
> This is wrong in terms of uAPI.
>
> Let's say we send "hello" with MSG_OOB, and "world" without MSG_OOB.
> The 'o' is handled as OOB data.  When recv() is called twice without
> MSG_OOB, the OOB data should be lost.
>
>   >>> from socket import *
>   >>> c1, c2 =3D socketpair(AF_UNIX, SOCK_STREAM, 0)
>   >>> c1.send(b'hello', MSG_OOB)  # 'o' is OOB data
>   5
>   >>> c1.send(b'world')
>   5
>   >>> c2.recv(5)  # OOB data is not received
>   b'hell'
>   >>> c2.recv(5)  # OOB date is skippeed
>   b'world'
>   >>> c2.recv(5, MSG_OOB)  # This should return an error
>   b'o'
>
> In the same situation, TCP actually returns -EINVAL for the last
> recv().
>
> Also, if we do not clear unix_sk(sk)->oob_skb, unix_poll() always set
> EPOLLPRI even though the data has passed through by previous recv().
>
> To avoid these issues, we must clear unix_sk(sk)->oob_skb when dequeuing
> it from recv queue.
>
> The reason why the old GC did not trigger the deadlock is because the
> old GC relied on the receive queue to detect the loop.
>
> When it is triggered, the socket with OOB data is marked as GC candidate
> because file refcount =3D=3D inflight count (1).  However, after traversi=
ng
> all inflight sockets, the socket still has a positive inflight count (1),
> thus the socket is excluded from candidates.  Then, the old GC lose the
> chance to garbage-collect the socket.
>
> With the old GC, the repro continues to create true garbage that will
> never be freed nor detected by kmemleak as it's linked to the global
> inflight list.  That's why we couldn't even notice the issue.
>
> Fixes: 314001f0bf92 ("af_unix: Add OOB support")
> Reported-by: syzbot+7f7f201cc2668a8fd169@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D7f7f201cc2668a8fd169
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/unix/af_unix.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 5b41e2321209..8f105cf535be 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -2665,7 +2665,9 @@ static struct sk_buff *manage_oob(struct sk_buff *s=
kb, struct sock *sk,
>                                 }
>                         } else if (!(flags & MSG_PEEK)) {
>                                 skb_unlink(skb, &sk->sk_receive_queue);
> -                               consume_skb(skb);
> +                               WRITE_ONCE(u->oob_skb, NULL);
> +                               kfree_skb(skb);

I dunno, this duplicate kfree_skb() is quite unusual and would deserve
a comment.

I would perhaps use

   if (!WARN_ON_ONCE(skb_unref(skb))
      kfree_skb(skb);

> +                               kfree_skb(skb);
>                                 skb =3D skb_peek(&sk->sk_receive_queue);
>                         }
>                 }
> --
> 2.30.2
>

