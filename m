Return-Path: <netdev+bounces-167603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF60DA3B00A
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 04:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 894FB1751C6
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 03:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF741547FF;
	Wed, 19 Feb 2025 03:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayTxPLa/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57ED136A;
	Wed, 19 Feb 2025 03:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739935919; cv=none; b=dZ3ZC+O4HZcvtLccigecqlPc80+48uTrNNuEZkLWB6cGrS+ZNA89atj44GRaqe/TIrMDbtugrmaGZsenkYRxcwzIFFvj5/3ffjydwlJmlmoMxkHAlrq39LOcfhexuQVYxp3CYMCUifm0QMMTbxd3HJ/qy8/CXkmuJYh9mN6Rb2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739935919; c=relaxed/simple;
	bh=okHOJqxKpAgGDK5EYqVExz7WeDz4/LDo6DEtsGqv/hw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dlm3ueJrl4sIdqTmPgz/mk28uVXLYhD+7cJ0u4rwYHg4kul/lWHybih0W8yM1NJtnikqhgUtHpP2laOXeyLTRozxwIuQ4NT98vtxjbT8/QgFZqHZKehqCRLVgo2dQXXzo3rNHxDcbANcac8DYhS/S44p6vTE9CNETEsSP7vKODs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayTxPLa/; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-85517db52a2so125348339f.3;
        Tue, 18 Feb 2025 19:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739935916; x=1740540716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+OUaaJXwOMrUhgWSUKQkkYMtzqTZvR6HK4jSYX4dyc=;
        b=ayTxPLa/I7bh+Z8Bv4oOxhUsLk3x9+nSTPajJL5w+HTU2vH63U+EThKVczcw5nmf7K
         fs2X1fDWTYuj3wMF4n1bUCcspwEwIqg6i9XFO3Wv124qati6XFL2ChKueiOfGk7tABdu
         LcEqV/E9dL/U7nHf4/pT8k/XP8mTeVlbKTJks7C7mQl1DvbW650zwL2N8jl8iDI3Bi7T
         x83Ny9HcArxK6A3DBod9o6k9oq/jPJMMf16cYapCVvasXo6kD/uMODwZ7kcSVT/fJcI/
         jzRXixSBoZfVzpl5M8JOyDLdchNbiXKyzjYnW1z7YyFFbabIkZFc3+eHy68W5p3gAySq
         BqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739935916; x=1740540716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+OUaaJXwOMrUhgWSUKQkkYMtzqTZvR6HK4jSYX4dyc=;
        b=cjDGUx5aSe72otUeXtwD9wW8+Lnrj9ipvPaqEsGlyJun9pbGYNnrdTMEtNM6x35f+D
         WGQqmP/vRWQ9wEXMznanzA2Ex9MzycjJQqozlZ08pgg4Wh1Jdy+xwmnoanG8oQZJihIj
         /wSAW6TTSIzubh+G8fevlfNK9UD44mevf6Akz9GH2BW2AXtNrK7aKloapf1QRkVuT5oN
         wArz45kKqIcgD4k+j4NMXxmQqlUJmV8yzZIeZOk4+IXFtJVhc9PRZtpjFhp255G84Xez
         CXT3mbFlQiJzul27P+5MpaLSOlyu5YuGP2V0ReMZeJgW3hLsatzldN+TFAeE8nb0vbBt
         6H4A==
X-Forwarded-Encrypted: i=1; AJvYcCUvod2OdYLUsTJ1hBnqwdBxfNxrpJQnZmpPDDckM7FobAJ+fNw7n49nQJBm/356XG6cvFhpX26q@vger.kernel.org, AJvYcCVu1dh+e5PTu1lRCaB7ym/yb/3hRv9TEMg4CwX1NeGFzH1eaP/NdDZgs0GxABS553uTxyY0G8hq3us+36Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsrTCI0RKEwXRDY1ThiDlnBakRkSsG3t0JV4BW9N2zIieT20M8
	ehl79f80iMMgcI82qHOoriTV7DA1/IiWSpPK7d2RJjJ8u+XS3sr87ibcRs4hq4n5C4HBnPjcjN5
	xqG9ixThZ2onRt0gFwc4fSqW1yJA=
X-Gm-Gg: ASbGnctTTqXS3HMR2ZWkglGHHVNIMlp+56Ntd68AXPlnBnMtEn6s5lH8ygsfGNTP3Ge
	Su0bfl7mVEhziavuoZr2WBNkV4Htn5s9sY9GW4teMtBNwCjAlNgR++ZywfKF7KOw3Dr2cPOGU
X-Google-Smtp-Source: AGHT+IGFIM48LDWdSa0fM5fv6vkMF0cAOM3ChwQmFZppyg/pXLCL/7tj9VQDGyJHhFNYXTkM8ptCDG5YY7aMJdcAcEA=
X-Received: by 2002:a05:6e02:3182:b0:3d0:1ee6:731b with SMTP id
 e9e14a558f8ab-3d28092be7cmr151318145ab.15.1739935916079; Tue, 18 Feb 2025
 19:31:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218105824.34511-1-wanghai38@huawei.com> <CANn89iKF+LC_isruAAd+nyxgytr4LPeFTe9=ey0j=Xy5URMvkg@mail.gmail.com>
 <f3b279ea-92c3-457f-915a-2f4963746838@huawei.com>
In-Reply-To: <f3b279ea-92c3-457f-915a-2f4963746838@huawei.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 19 Feb 2025 11:31:19 +0800
X-Gm-Features: AWEUYZmOxzFEIzfrWT_r5uxgZ41XeOzvhnB8B6r_lhXCBrI3iq_vYTcDYDlZm9w
Message-ID: <CAL+tcoByx13C1Bk1E33C_TqhpXydNNMe=PF93-5daRQeUC=V7A@mail.gmail.com>
Subject: Re: [PATCH net] tcp: Fix error ts_recent time during three-way handshake
To: Wang Hai <wanghai38@huawei.com>
Cc: Eric Dumazet <edumazet@google.com>, ncardwell@google.com, kuniyu@amazon.com, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 10:16=E2=80=AFAM Wang Hai <wanghai38@huawei.com> wr=
ote:
>
>
>
> On 2025/2/18 21:35, Eric Dumazet wrote:
> > On Tue, Feb 18, 2025 at 12:00=E2=80=AFPM Wang Hai <wanghai38@huawei.com=
> wrote:
> >>
> >> If two ack packets from a connection enter tcp_check_req at the same t=
ime
> >> through different cpu, it may happen that req->ts_recent is updated wi=
th
> >> with a more recent time and the skb with an older time creates a new s=
ock,
> >> which will cause the tcp_validate_incoming check to fail.
> >>
> >> cpu1                                cpu2
> >> tcp_check_req
> >>                                      tcp_check_req
> >> req->ts_recent =3D tmp_opt.rcv_tsval =3D t1
> >>                                      req->ts_recent =3D tmp_opt.rcv_ts=
val =3D t2
> >>
> >> newsk->ts_recent =3D req->ts_recent =3D t2 // t1 < t2
> >> tcp_child_process
> >> tcp_rcv_state_process
> >> tcp_validate_incoming
> >> tcp_paws_check
> >> if ((s32)(rx_opt->ts_recent - rx_opt->rcv_tsval) <=3D paws_win) // fai=
led
> >>
> >> In tcp_check_req, restore ts_recent to this skb's to fix this bug.
> >>
> >> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> >> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> >> ---
> >>   net/ipv4/tcp_minisocks.c | 4 ++++
> >>   1 file changed, 4 insertions(+)
> >>
> >> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> >> index b089b08e9617..0208455f9eb8 100644
> >> --- a/net/ipv4/tcp_minisocks.c
> >> +++ b/net/ipv4/tcp_minisocks.c
> >> @@ -878,6 +878,10 @@ struct sock *tcp_check_req(struct sock *sk, struc=
t sk_buff *skb,
> >>          sock_rps_save_rxhash(child, skb);
> >>          tcp_synack_rtt_meas(child, req);
> >>          *req_stolen =3D !own_req;
> >> +       if (own_req && tcp_sk(child)->rx_opt.tstamp_ok &&
> >> +           unlikely(tcp_sk(child)->rx_opt.ts_recent !=3D tmp_opt.rcv_=
tsval))
> >> +               tcp_sk(child)->rx_opt.ts_recent =3D tmp_opt.rcv_tsval;
> >> +
> >>          return inet_csk_complete_hashdance(sk, child, req, own_req);
> >
> > Have you seen the comment at line 818 ?
> >
> > /* TODO: We probably should defer ts_recent change once
> >   * we take ownership of @req.
> >   */
> >
> > Plan was clear and explained. Why implement something else (and buggy) =
?
> >
> Hi Eric,
>
> Currently we have a real problem, so we want to solve it. This bug
> causes the upper layers to be unable to be notified to call accept after
> the successful three-way handshake.
>
> Skb from cpu1 that fails at tcp_paws_check (which it could have
> succeeded) will not be able to enter the TCP_ESTABLISHED state, and
> therefore parent->sk_data_ready(parent) will not be triggered, and skb
> from cpu2 can complete the three-way handshake, but there is also no way
> to call parent->sk_data_ready(parent) to notify the upper layer, which
> will result
> in the upper layer not being able to sense and call accept to obtain the
> nsk.
>
> cpu1                                cpu2
> tcp_check_req
>                                      tcp_check_req
> req->ts_recent =3D tmp_opt.rcv_tsval =3D t1
>                                      req->ts_recent=3Dtmp_opt.rcv_tsval=
=3D t2
>
> newsk->ts_recent =3D req->ts_recent =3D t2 // t1 < t2
> tcp_child_process
>   tcp_rcv_state_process
>    tcp_validate_incoming
>     tcp_paws_check // failed
>   parent->sk_data_ready(parent); // will not be called
>                                      tcp_v4_do_rcv
>                                      tcp_rcv_state_process // Complete th=
e three-way handshake
>                                                                          =
                               // missing parent->sk_data_ready(parent);

IIUC, the ack received from cpu1 triggered calling
inet_csk_complete_hashdance() so its state transited from
TCP_NEW_SYN_RECV to TCP_SYN_RECV, right? If so, the reason why not
call sk_data_ready() if the skb entered into tcp_child_process() is
that its state failed to transit to TCP_ESTABLISHED?

Here is another question. How did the skb on the right side enter into
tcp_v4_do_rcv() after entering tcp_check_req() if the state of sk
which the skb belongs to is TCP_NEW_SYN_RECV? Could you elaborate more
on this point?

Thanks,
Jason

