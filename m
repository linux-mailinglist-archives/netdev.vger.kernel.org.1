Return-Path: <netdev+bounces-167975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E1DA3CFCA
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 04:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AC353B8585
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 03:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B39E1C5F34;
	Thu, 20 Feb 2025 03:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHFTL6kK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCA110FD;
	Thu, 20 Feb 2025 03:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740020695; cv=none; b=GRH8hPzQCT4DX+nXE/LbKmy0dOOKih6Pbac7ixvJHSVoU+ppo3Ge0IteoydstA75QsqR1Fe18CH5KB/WPkQ8q5JyO8xAo0W/hn06psInj5O9eby5Rbyj+5AilgXD3JjuE6nQKUe/I9/ZpSeo0iJbVGPh+CL/tQCAZFol6wrPECQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740020695; c=relaxed/simple;
	bh=jw1Mw1OqKbf7VQkEUWe/UY9yoZhbXfvIChjA4V/L3tg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DZjMfUpXSp+LBgK79RonTqIVbpRkntQzpK4ZKtp2YQcyLOb1FqYqV6/x8YDaguFol6Kh8mepFVdwpRtAaOtjMMj6fuAVr4SiUA+AUtbcjFhCQV76WeAW2dhpT2GkmP8okdWgPiZdEcf69Iiaqu8fFvxrNeAjJk0/ZBeEI9rZGOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHFTL6kK; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3cfcf8b7455so3331205ab.3;
        Wed, 19 Feb 2025 19:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740020692; x=1740625492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2GT+f5OHzpxlsFUj3FyG26JtbYx1D5wOyep0xqEKQg=;
        b=FHFTL6kKl077ymKC8LxggiZU1YE52KLClcLS4rxdnRbtI/RvXKHkhlFLy78EdAt5Il
         PBozCHngj+G+dgY0OfLVsRvG7qwidXc271nXnQxs7VRs3GqThLXKJ9tgCnj4dCXE9CFX
         kTi9Cf5bYmUq61V5gOz2jGI8NbDSTY66YOq3GT1iXBsLt6JM06myzADqYtIcHogr377b
         CnIxz/nCQ1rsWwMN1Tuwf4TNzWQ7lTA8UxrZWTuTEL1UjiRW9P9Nv4GWGLvwDKkUypQy
         e7qA9edU4FsHby1tKShhVJRptnpIYpZOE9JqrUiqkNINdW3zRGfYb/ZBP7d1Qx+mjiHE
         kWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740020692; x=1740625492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o2GT+f5OHzpxlsFUj3FyG26JtbYx1D5wOyep0xqEKQg=;
        b=m8u2E+5JnXPa7cOUTV+R/xhxih4J+Pv1fqClLTtX27feLq+frBPe8b8FNNWw34zJiS
         LTVprhuJOoLAB9VgAyXH73o1rI+3dkhb0pnTr45NEkgC23N0WuEkbMr80ViVljQ/pfLx
         +XOUV+R5d5RAXhfJMvTBdI5ERLRwUXajxJwHHHT27rHoyEJ3UikT84BIFmduq4XBI/kV
         YD/0uMT03wRiKcd40zgkOvU+6TWYTuFcqBm15wWmsBUaxZDKbUmu9FgJcpWgDz7ZChhc
         fTKv0DS98aQvkxEniJ8GIqf1uH1P2Nhra60gvAvLLNSgdlqYPNRQa42T3kIYh07EMeiG
         3Tsw==
X-Forwarded-Encrypted: i=1; AJvYcCU1qhjQBAexBW+sleVYZikIuR0ng6VIgEJwplTHCItv72R8HWHDBo81kC5i0HkDeE5QiBi7wRqH1pWCtSs=@vger.kernel.org, AJvYcCX6+W6hwmdXKAMEwp2LLSYVj8/AQ3aGfFqPcxB3q02WCbWaX4TjSTXScPyRl7OqxPatgU2dSxde@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3rldE1dqhrxBsr5zkWnfrA3IAccLrwW8TPdTPmNgE9HvCQRrf
	1p989jeVTQRLathVbtOWbMsyz8YjTwUnj0nyJLBSh8a9G0BU//6l94nta1tZohVhso5XrMfnsr5
	t8P8KPO+OrNzc0lvUzomcT0spP/I=
X-Gm-Gg: ASbGncsXA9HNatHdLMy80i70QQrk64F3Rj6cpdGu0QjpzwAvlL3S22WV9nXWNzacnc5
	HwkooUPpNczFFPlzRTy5v0til69tv3FQtgWqdz5gj4l9k5bEGck8INM2LIeiWtkLWLVpyiEvs
X-Google-Smtp-Source: AGHT+IGpPobWlMnVj5rcIXRsQ7qlPeAsMgRe32sZ7MqKeZve6yZpGaTMqNij4LrzS+hRyTQRT75kUUvNFXlgoex3fPE=
X-Received: by 2002:a05:6e02:218c:b0:3d0:4e0c:2c96 with SMTP id
 e9e14a558f8ab-3d2b529cb9fmr70199595ab.2.1740020692431; Wed, 19 Feb 2025
 19:04:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218105824.34511-1-wanghai38@huawei.com> <CANn89iKF+LC_isruAAd+nyxgytr4LPeFTe9=ey0j=Xy5URMvkg@mail.gmail.com>
 <f3b279ea-92c3-457f-915a-2f4963746838@huawei.com> <CAL+tcoByx13C1Bk1E33C_TqhpXydNNMe=PF93-5daRQeUC=V7A@mail.gmail.com>
 <5fa8fc14-b67b-4da1-ac8e-339fd3e536c2@huawei.com>
In-Reply-To: <5fa8fc14-b67b-4da1-ac8e-339fd3e536c2@huawei.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 20 Feb 2025 11:04:15 +0800
X-Gm-Features: AWEUYZne20RsNX0ZVg4lJ7w3FGNRJA7ogK2gBUk26SskC564kZRK0brjleN42Uc
Message-ID: <CAL+tcoC3TuZPTwnHTDvXC+JPoJbgW2UywZ2=xv=E=utokb3pCQ@mail.gmail.com>
Subject: Re: [PATCH net] tcp: Fix error ts_recent time during three-way handshake
To: Wang Hai <wanghai38@huawei.com>
Cc: Eric Dumazet <edumazet@google.com>, ncardwell@google.com, kuniyu@amazon.com, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 9:11=E2=80=AFPM Wang Hai <wanghai38@huawei.com> wro=
te:
>
>
>
> On 2025/2/19 11:31, Jason Xing wrote:
> > On Wed, Feb 19, 2025 at 10:16=E2=80=AFAM Wang Hai <wanghai38@huawei.com=
> wrote:
> >>
> >>
> >>
> >> On 2025/2/18 21:35, Eric Dumazet wrote:
> >>> On Tue, Feb 18, 2025 at 12:00=E2=80=AFPM Wang Hai <wanghai38@huawei.c=
om> wrote:
> >>>>
> >>>> If two ack packets from a connection enter tcp_check_req at the same=
 time
> >>>> through different cpu, it may happen that req->ts_recent is updated =
with
> >>>> with a more recent time and the skb with an older time creates a new=
 sock,
> >>>> which will cause the tcp_validate_incoming check to fail.
> >>>>
> >>>> cpu1                                cpu2
> >>>> tcp_check_req
> >>>>                                       tcp_check_req
> >>>> req->ts_recent =3D tmp_opt.rcv_tsval =3D t1
> >>>>                                       req->ts_recent =3D tmp_opt.rcv=
_tsval =3D t2
> >>>>
> >>>> newsk->ts_recent =3D req->ts_recent =3D t2 // t1 < t2
> >>>> tcp_child_process
> >>>> tcp_rcv_state_process
> >>>> tcp_validate_incoming
> >>>> tcp_paws_check
> >>>> if ((s32)(rx_opt->ts_recent - rx_opt->rcv_tsval) <=3D paws_win) // f=
ailed
> >>>>
> >>>> In tcp_check_req, restore ts_recent to this skb's to fix this bug.
> >>>>
> >>>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> >>>> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> >>>> ---
> >>>>    net/ipv4/tcp_minisocks.c | 4 ++++
> >>>>    1 file changed, 4 insertions(+)
> >>>>
> >>>> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> >>>> index b089b08e9617..0208455f9eb8 100644
> >>>> --- a/net/ipv4/tcp_minisocks.c
> >>>> +++ b/net/ipv4/tcp_minisocks.c
> >>>> @@ -878,6 +878,10 @@ struct sock *tcp_check_req(struct sock *sk, str=
uct sk_buff *skb,
> >>>>           sock_rps_save_rxhash(child, skb);
> >>>>           tcp_synack_rtt_meas(child, req);
> >>>>           *req_stolen =3D !own_req;
> >>>> +       if (own_req && tcp_sk(child)->rx_opt.tstamp_ok &&
> >>>> +           unlikely(tcp_sk(child)->rx_opt.ts_recent !=3D tmp_opt.rc=
v_tsval))
> >>>> +               tcp_sk(child)->rx_opt.ts_recent =3D tmp_opt.rcv_tsva=
l;
> >>>> +
> >>>>           return inet_csk_complete_hashdance(sk, child, req, own_req=
);
> >>>
> >>> Have you seen the comment at line 818 ?
> >>>
> >>> /* TODO: We probably should defer ts_recent change once
> >>>    * we take ownership of @req.
> >>>    */
> >>>
> >>> Plan was clear and explained. Why implement something else (and buggy=
) ?
> >>>
> >> Hi Eric,
> >>
> >> Currently we have a real problem, so we want to solve it. This bug
> >> causes the upper layers to be unable to be notified to call accept aft=
er
> >> the successful three-way handshake.
> >>
> >> Skb from cpu1 that fails at tcp_paws_check (which it could have
> >> succeeded) will not be able to enter the TCP_ESTABLISHED state, and
> >> therefore parent->sk_data_ready(parent) will not be triggered, and skb
> >> from cpu2 can complete the three-way handshake, but there is also no w=
ay
> >> to call parent->sk_data_ready(parent) to notify the upper layer, which
> >> will result
> >> in the upper layer not being able to sense and call accept to obtain t=
he
> >> nsk.
> >>
> >> cpu1                                cpu2
> >> tcp_check_req
> >>                                       tcp_check_req
> >> req->ts_recent =3D tmp_opt.rcv_tsval =3D t1
> >>                                       req->ts_recent=3Dtmp_opt.rcv_tsv=
al=3D t2
> >>
> >> newsk->ts_recent =3D req->ts_recent =3D t2 // t1 < t2
> >> tcp_child_process
> >>    tcp_rcv_state_process
> >>     tcp_validate_incoming
> >>      tcp_paws_check // failed
> >>    parent->sk_data_ready(parent); // will not be called
> >>                                       tcp_v4_do_rcv
> >>                                       tcp_rcv_state_process // Complet=
e the three-way handshake
> >>                                                                       =
                                   // missing parent->sk_data_ready(parent)=
;
> >
> > IIUC, the ack received from cpu1 triggered calling
> > inet_csk_complete_hashdance() so its state transited from
> > TCP_NEW_SYN_RECV to TCP_SYN_RECV, right? If so, the reason why not
> > call sk_data_ready() if the skb entered into tcp_child_process() is
> > that its state failed to transit to TCP_ESTABLISHED?
> >
> Yes, because it didn't switch to TCP_ESTABLISHED
> > Here is another question. How did the skb on the right side enter into
> > tcp_v4_do_rcv() after entering tcp_check_req() if the state of sk
> > which the skb belongs to is TCP_NEW_SYN_RECV? Could you elaborate more
> > on this point?
> Since cpu1 successfully created the child sock, cpu2 will return
> null in tcp_check_req and req_stolen is set to true, so that it will
> subsequently go to 'goto lookup' to re-process the packet, and at
> this point, sk->sk_state is already in TCP_SYN_RECV state, and then
> then tcp_v4_do_rcv is called.

Now I can see what happened there. Perhaps it would be good to update
the commit message
in the next iteration.

Another key information I notice is that the second lookup process
loses the chance to call sk_data_ready() for its parent socket. It's
the one of the main reasons that cause your application to be unable
to get notified. Taking a rough look at tcp_rcv_state_process(), I
think it's not easy to acquire the parent socket there and then call
sk_data_ready() without modifying more codes compared to the current
solution. It's a different solution in theory.

If your new approach (like your previous reply) works, the following
commit[1] will be reverted/overwritten.
commit e0f9759f530bf789e984961dce79f525b151ecf3
Author: Eric Dumazet <edumazet@google.com>
Date:   Tue Feb 13 06:14:12 2018 -0800

    tcp: try to keep packet if SYN_RCV race is lost

    =EB=B0=B0=EC=84=9D=EC=A7=84 reported that in some situations, packets f=
or a given 5-tuple
    end up being processed by different CPUS.

    This involves RPS, and fragmentation.

    =EB=B0=B0=EC=84=9D=EC=A7=84 is seeing packet drops when a SYN_RECV requ=
est socket is
    moved into ESTABLISH state. Other states are protected by socket lock.

    This is caused by a CPU losing the race, and simply not caring enough.

    Since this seems to occur frequently, we can do better and perform
    a second lookup.

    Note that all needed memory barriers are already in the existing code,
    thanks to the spin_lock()/spin_unlock() pair in inet_ehash_insert()
    and reqsk_put(). The second lookup must find the new socket,
    unless it has already been accepted and closed by another cpu.

    Note that the fragmentation could be avoided in the first place by
    use of a correct TCP MSS option in the SYN{ACK} packet, but this
    does not mean we can not be more robust.

Please repost a V2 when you think it's ready, then TCP maintainers
will handle it:)

Thanks,
Jason

