Return-Path: <netdev+bounces-219811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2CDB4319F
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 07:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E27C162F56
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 05:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E60A15DBC1;
	Thu,  4 Sep 2025 05:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NABTh3pu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEEE8F40
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 05:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756963932; cv=none; b=gbupCPtsubipnC5VPvqe+KfvMkxjw8RwTPUpLcQgeti8ZY0QuKvfzLDvoM62ZHqpqyNt/ulWTlGQoE8KNsxzCBefQqvhi8aeoggeYV/cIhWj8IzfJEe1U+xDtdW6kVgTwPSpo7PKSeVIG6DZQQk4Z1+uHAa28CH5bpRpqx9DdVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756963932; c=relaxed/simple;
	bh=49/jRq1XZRA3ZxYt1Pn7lgZEInrsbuOcCY8AQ02By3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SzpH2RtVlOBthE6ehgzGASdBKmmXu7XfjRcW4CpgU7ZP/SDIhp5UEPJ3M4PvvP9qFh5fXoc9UhZ3w9gJZ6HpQWOuJ8ZL6aZuRA/PCiVmiEM9iv5ajFcLHYDyERo38zShAPMszJECwfgSZnu0C8GTSSVIZGbmd1D2IPqXazKS33g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NABTh3pu; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-77250e45d36so593991b3a.0
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 22:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756963930; x=1757568730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zm8HG6q2XhOiSXadWpjaeys2T1j23xgSwizMsyr/dq0=;
        b=NABTh3pujT7vX7w/i67sdVVHT20/hdNNBnKDxwfItZH3fwmc4vWFfbVLLxQ0/LCMeM
         DaebcicrjFSyOZW0+8te0GTcLoPuRQnR/V+DSXvG4nxV+++nTTCbpP9QhNU/lB/St2+3
         yLVlWxD7iOtAm+EeiMTVnX87qjkAv660Dil3TfWG2rtsc29GCk2DBFsXPAogG5JOhIie
         az3SPHFj75Irp6RS4KgE/2TK8990cCbajC3RPtijmWvcVi0fo+4aQcdR0cc7bUEwvtYB
         mgqyL1qVbqUkRDMvISGJyMEchhQeyhTCqlHIHkAhmjjI28eN2tyY2lxKTgqEC9SMIvhW
         J86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756963930; x=1757568730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zm8HG6q2XhOiSXadWpjaeys2T1j23xgSwizMsyr/dq0=;
        b=IpozpYVXI40l/LmrT5R0p0/HiHZizVgnOHTMcKJms2eUJWLoK7Y4bIyykoa7x5L8ys
         MDEcL/xmwe1W89KQdixts9bbd6Dplz81HsvBstCEohXIaxlrC2D5zmcNcp1ve5nR1nvW
         K3s10Wgh7E/E2FocI3/O5UWcpKuG0O3QrXJ7rT2/N3luEddl/NLlPDAINhsiZQv7XPI7
         ws4/eUQgDuoiZpOz/2ZF2MYOzIjDAiSCLPjhZTdiGWnmZodFlbbx78rQ4oK3GM1n2W64
         hIW9G2sDsZYEZ5Zh+bbjz8eJIspZKfqUH8ICVY0MVWwOaRZyZWzQ9VXRAeHfKvgaun0d
         8Xvw==
X-Forwarded-Encrypted: i=1; AJvYcCXVVYBMyv+O50xFyi2xurI0B/3F13TBiy02G1hO4zB90IpzDC70di+KxyVhi0y45ACmHMbkuY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNZ2CdJhsKFLvE8yfsj79HLWsz96NbigaexmqGLTs7m8adc24j
	Nzd5aHtsFFS6pwm96BBEm/yWYcf6sbv9hJGpCLmFNPew02raq6KRdcosER3wFXQQvp0CnD3JO7R
	wm4I857nZ1k4jlAD+yPT9RlxayOyWnNO73vbeKRg1xb9wdjXJfxHerZ7lcik=
X-Gm-Gg: ASbGncur6Rrm7RiQztzQ4I2kFV7gQNV5k4afKCCH5bpQn6RNf7/emjcE2Cmk+omvI13
	/Epa9OMISpxJ/S7bIpRoMhhyZMSqtpbZRVBvNwE/+DMFouxtZtGcSU4PbKKNALzyMzsCUibqaRX
	V5qA91AIiRNXmu1YjW4s/4wJOYSw/SZ9H1Sq052x+oLSE3G9uxThk7vE1ZxHEWlxIcwLGCepnkb
	CDHVy9+8/zZ17X1TP1WpGHszjeKp6R9SD6A76VYnkeHPlYRvoyeDK6be1N96vXmVIxnpEvCRnhm
	UcU=
X-Google-Smtp-Source: AGHT+IHELrDGBB2fMB4iIigmJ36+ijhNyJeFGieLN1fGA9wbRPj4CODQ3iwhjzpNsmEhG0SvUZsdafPs0CGU4ZRihW0=
X-Received: by 2002:a17:902:e78f:b0:24c:c57d:36a2 with SMTP id
 d9443c01a7336-24cc57d4caamr15122735ad.13.1756963929669; Wed, 03 Sep 2025
 22:32:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903084720.1168904-1-edumazet@google.com> <20250903084720.1168904-2-edumazet@google.com>
 <CAL+tcoCqey97QW=7n_S8V9t-haSe=mu9iE1sAaDmPPJ+1BkysA@mail.gmail.com>
In-Reply-To: <CAL+tcoCqey97QW=7n_S8V9t-haSe=mu9iE1sAaDmPPJ+1BkysA@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 3 Sep 2025 22:31:58 -0700
X-Gm-Features: Ac12FXxrgJTVzJ1XB3u_xrhq4geicd35j1jcF_yGUcc2rZlgYsddwVW7N26OMfg
Message-ID: <CAAVpQUBgCyC+y+2M7=WKJVk=sivgeZtE2kwCxDLFCrgezycjZg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] tcp: fix __tcp_close() to only send RST when required
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 10:04=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Wed, Sep 3, 2025 at 4:47=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > If the receive queue contains payload that was already
> > received, __tcp_close() can send an unexpected RST.
> >
> > Refine the code to take tp->copied_seq into account,
> > as we already do in tcp recvmsg().
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>
> Sorry, Eric. I might be wrong, and I don't think it's a bugfix for now.
>
> IIUC, it's not possible that one skb stays in the receive queue and
> all of the data has been consumed in tcp_recvmsg() unless it's
> MSG_PEEK mode. So my understanding is that the patch tries to cover
> the case where partial data of skb is read by applications and the
> whole skb has not been unlinked from the receive queue yet. Sure, as
> we can learn from tcp_sendsmg(), skb can be partially read.

You can find a clear example in patch 2 that this patch fixes.

Without patch 1, the test fails:

# ./ksft_runner.sh tcp_close_no_rst.pkt
...
tcp_close_no_rst.pkt:32: error handling packet: live packet field
tcp_fin: expected: 1 (0x1) vs actual: 0 (0x0)
script packet:  0.140854 F. 1:1(0) ack 1002
actual packet:  0.140844 R. 1:1(0) ack 1002 win 65535
not ok 1 ipv4


>
> As long as 'TCP_SKB_CB(skb)->end_seq - TCP_SKB_CB(skb)->seq' has data
> len, and the skb still exists in the receive queue, it can directly
> means some part of skb hasn't been read yet. We can call it the unread
> data case then, so the logic before this patch is right.
>
> Two conditions (1. skb still stays in the queue, 2. skb has data) make
> sure that the data unread case can be detected and then sends an RST.
> No need to replace it with copied_seq, I wonder? At least, it's not a
> bug.
>
> Thanks,
> Jason
>
>
>
>
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  net/ipv4/tcp.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 40b774b4f587..39eb03f6d07f 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -3099,8 +3099,8 @@ bool tcp_check_oom(const struct sock *sk, int shi=
ft)
> >
> >  void __tcp_close(struct sock *sk, long timeout)
> >  {
> > +       bool data_was_unread =3D false;
> >         struct sk_buff *skb;
> > -       int data_was_unread =3D 0;
> >         int state;
> >
> >         WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
> > @@ -3119,11 +3119,12 @@ void __tcp_close(struct sock *sk, long timeout)
> >          *  reader process may not have drained the data yet!
> >          */
> >         while ((skb =3D __skb_dequeue(&sk->sk_receive_queue)) !=3D NULL=
) {
> > -               u32 len =3D TCP_SKB_CB(skb)->end_seq - TCP_SKB_CB(skb)-=
>seq;
> > +               u32 end_seq =3D TCP_SKB_CB(skb)->end_seq;
> >
> >                 if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN)
> > -                       len--;
> > -               data_was_unread +=3D len;
> > +                       end_seq--;
> > +               if (after(end_seq, tcp_sk(sk)->copied_seq))
> > +                       data_was_unread =3D true;
> >                 __kfree_skb(skb);
> >         }
> >
> > --
> > 2.51.0.338.gd7d06c2dae-goog
> >
> >

