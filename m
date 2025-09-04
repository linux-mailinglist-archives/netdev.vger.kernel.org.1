Return-Path: <netdev+bounces-219823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB995B432BE
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 08:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 859E158254C
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 06:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A4627A915;
	Thu,  4 Sep 2025 06:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4IW7hu0U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF3127A123
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 06:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756968284; cv=none; b=GWVCxg3TBV6TZo5548tUb2TMHpIBFGbsMawPwWMtAalrtTrgY/DzvVPWrPt91isdoZZIQyF/5P7HLdb9XOCpnXiiXtsVQ9yBjJcnVu1AsahHUzISKyDps7W+4DNxXghNc+1md8m0XKwZNTI3tpFK8BUs0iSW4U0fkw6Lg9s5cfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756968284; c=relaxed/simple;
	bh=qwPWCYphvBsRjfRd4nVO8Swt068Dyp8f15V165D82oE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f9nmOuPV7F94FZSEP7pv18hpwF1PXihkfv2oQrvWmahxmQ3KApAgCIo3/z16EBaAJv4SXp33L5ffdO01bw0AItodkMv/ygiX80+Cle7WMbQge5p17AuND6IWxNFkJd3IR1UKDleB8Jr83sX88/9EFYrUYUTG+hd9S4vo20q8yQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4IW7hu0U; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-724974fc5f8so6768147b3.3
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 23:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756968282; x=1757573082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WX1ukhUIOhf+nUGbl0XYtU405flpdMh6tFcNmGe40K4=;
        b=4IW7hu0U5t5RW5PYW6xeKjmbEIr7QBAi0/AMxPU9/mz44bzmndzJ7O7o5PUbuLGQqD
         YNeHtA8TiaKadi+ylJIhyuBoDiuZ+v2QH5zpo89mrbv0QeG3XDnbJpnoMr9D8vKDLc85
         QEh0BuslkgeKJj1qZqvmfBupIMFL9sa0L8GjLdHD0K9kzsIsCCC/5FvFPGc0Z0LKbPB1
         MnAWp/KVp1M+oojhmvFG4bll+BpKaF4W6XGDOUfdPMxEvX0Z3RSWacVptNZCQt9AD0rP
         BM4JRm+A0TKm1Zi9gFdT8+pdIAdNfU5o228Hey+QSjdCWKVrlJ6hJIc7kZl5ejPL3TTM
         gbWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756968282; x=1757573082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WX1ukhUIOhf+nUGbl0XYtU405flpdMh6tFcNmGe40K4=;
        b=Zh1xSwbyQg48O3ZnRcFCl1E2hJqtkl11gh8a8PT9W+VONLEBHhnQIzPxizxLz5PUhM
         OueV4fwBVut7+1ArkSLVjnVF1WUoDb1WZSZ1L8Ho+WTfNp1pue++eBPzmQVlgwf2FpvF
         9HpFJ4ciE0Rov84kkwJwjGnNROzd43Xz7yKG3ymi6295vxbfk1LUKKzaFA+/f+DG9a4g
         P9NfAogQRpN8tyZ6W+vFZSGRowdsgVAQ5FqFn3P536X6PGhSqlUZIeOsV7lNePC/f71r
         j27T86rMb8mMZyRrwoRHDuh0SCwOxD687IDrIyN51YZG3wXbipPRXrJcYavN6pCwdhkU
         CfiQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+oWfcdHohq3/i/z5VnQ2dXfueq7vi12ixOZPYC8KmSWhwoGX2S4pc4X19Ul9Z70cYFQCEotU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJEl6A4jltQPqVqxCdg/EntP4Ijr1KfRAAp4xwV6snZ15deCgi
	vhZFu0Jvi/bIdI9fDustr+zc6EgPc5okwVQBX40vsiTrjf9sF7z+YHuC+y9O7pKkqu9tk0LlcS6
	r/bxpquwNwyajDVXIb5VcDNEAmoi86t6ik783fj3A
X-Gm-Gg: ASbGncsSzzA5YaTNMFsEavxs7gQr3tMwVP6EO8wH9613xKuAA/YIs1uOqM4J+jYhlU5
	8iDQs1OU9s4vvt32VnG762SSH42wISmj9SKbUyMlnxZfFwvumHQJ4w0IH1cVYNZTLaNNbzeOaz2
	FLrlHASFkefafB61UPA1AChZQIc37Sn6+EwjXff0Kmn4+HQCNmbWRTZeq4B5BNJ/5vPOEc0zU9j
	vxu+hJj3Ikk
X-Google-Smtp-Source: AGHT+IFay9En/AJuBZGWYJZnE/srzmZ6ynmWMYb540EhtF+YKJtlr+ol8UAM9XPyiNpIy4nQLALg9eKpaqus+mvXiJM=
X-Received: by 2002:a05:690c:8e10:b0:722:8611:7966 with SMTP id
 00721157ae682-7228611850amr137031847b3.32.1756968281449; Wed, 03 Sep 2025
 23:44:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903084720.1168904-1-edumazet@google.com> <20250903084720.1168904-2-edumazet@google.com>
 <CAL+tcoCqey97QW=7n_S8V9t-haSe=mu9iE1sAaDmPPJ+1BkysA@mail.gmail.com>
 <CAAVpQUBgCyC+y+2M7=WKJVk=sivgeZtE2kwCxDLFCrgezycjZg@mail.gmail.com> <CAL+tcoBJxe6GkosVCS5Vzwk_z8W1WmxqLFELzXNwCRSYkQUyHw@mail.gmail.com>
In-Reply-To: <CAL+tcoBJxe6GkosVCS5Vzwk_z8W1WmxqLFELzXNwCRSYkQUyHw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 3 Sep 2025 23:44:28 -0700
X-Gm-Features: Ac12FXxABTrrmM2SmbpzNFT6zb6Yo_5O9h0P9VnAFURLObJgKDEra8raCIRX-vk
Message-ID: <CANn89iLO1JOw8LKoxAYm5M_tXDFyiSVhEovOPsSf9H08gPwj_Q@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] tcp: fix __tcp_close() to only send RST when required
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 11:19=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Thu, Sep 4, 2025 at 1:32=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
> >
> > On Wed, Sep 3, 2025 at 10:04=E2=80=AFPM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > On Wed, Sep 3, 2025 at 4:47=E2=80=AFPM Eric Dumazet <edumazet@google.=
com> wrote:
> > > >
> > > > If the receive queue contains payload that was already
> > > > received, __tcp_close() can send an unexpected RST.
> > > >
> > > > Refine the code to take tp->copied_seq into account,
> > > > as we already do in tcp recvmsg().
> > > >
> > > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > >
> > > Sorry, Eric. I might be wrong, and I don't think it's a bugfix for no=
w.
> > >
> > > IIUC, it's not possible that one skb stays in the receive queue and
> > > all of the data has been consumed in tcp_recvmsg() unless it's
> > > MSG_PEEK mode. So my understanding is that the patch tries to cover
> > > the case where partial data of skb is read by applications and the
> > > whole skb has not been unlinked from the receive queue yet. Sure, as
> > > we can learn from tcp_sendsmg(), skb can be partially read.
> >
> > You can find a clear example in patch 2 that this patch fixes.
>
> Oh, great, a very interesting corner case: resending data with FIN....

Linux TCP stack under memory pressure can do that BTW, no need for
another implementation :)

tcp_send_fin()


> I just wasn't able to read the second patch in time...
>
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
>
> Thanks,
> Jason
>
> >
> > Without patch 1, the test fails:
> >
> > # ./ksft_runner.sh tcp_close_no_rst.pkt
> > ...
> > tcp_close_no_rst.pkt:32: error handling packet: live packet field
> > tcp_fin: expected: 1 (0x1) vs actual: 0 (0x0)
> > script packet:  0.140854 F. 1:1(0) ack 1002
> > actual packet:  0.140844 R. 1:1(0) ack 1002 win 65535
> > not ok 1 ipv4
> >
> >
> > >
> > > As long as 'TCP_SKB_CB(skb)->end_seq - TCP_SKB_CB(skb)->seq' has data
> > > len, and the skb still exists in the receive queue, it can directly
> > > means some part of skb hasn't been read yet. We can call it the unrea=
d
> > > data case then, so the logic before this patch is right.
> > >
> > > Two conditions (1. skb still stays in the queue, 2. skb has data) mak=
e
> > > sure that the data unread case can be detected and then sends an RST.
> > > No need to replace it with copied_seq, I wonder? At least, it's not a
> > > bug.
> > >
> > > Thanks,
> > > Jason
> > >
> > >
> > >
> > >
> > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > > ---
> > > >  net/ipv4/tcp.c | 9 +++++----
> > > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > > index 40b774b4f587..39eb03f6d07f 100644
> > > > --- a/net/ipv4/tcp.c
> > > > +++ b/net/ipv4/tcp.c
> > > > @@ -3099,8 +3099,8 @@ bool tcp_check_oom(const struct sock *sk, int=
 shift)
> > > >
> > > >  void __tcp_close(struct sock *sk, long timeout)
> > > >  {
> > > > +       bool data_was_unread =3D false;
> > > >         struct sk_buff *skb;
> > > > -       int data_was_unread =3D 0;
> > > >         int state;
> > > >
> > > >         WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
> > > > @@ -3119,11 +3119,12 @@ void __tcp_close(struct sock *sk, long time=
out)
> > > >          *  reader process may not have drained the data yet!
> > > >          */
> > > >         while ((skb =3D __skb_dequeue(&sk->sk_receive_queue)) !=3D =
NULL) {
> > > > -               u32 len =3D TCP_SKB_CB(skb)->end_seq - TCP_SKB_CB(s=
kb)->seq;
> > > > +               u32 end_seq =3D TCP_SKB_CB(skb)->end_seq;
> > > >
> > > >                 if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN)
> > > > -                       len--;
> > > > -               data_was_unread +=3D len;
> > > > +                       end_seq--;
> > > > +               if (after(end_seq, tcp_sk(sk)->copied_seq))
> > > > +                       data_was_unread =3D true;
> > > >                 __kfree_skb(skb);
> > > >         }
> > > >
> > > > --
> > > > 2.51.0.338.gd7d06c2dae-goog
> > > >
> > > >

