Return-Path: <netdev+bounces-168161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C80CEA3DD44
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 15:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C6C3B4933
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 14:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D2D1D5ADC;
	Thu, 20 Feb 2025 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rz+CJnnL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C32E846C;
	Thu, 20 Feb 2025 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740062759; cv=none; b=ZO8o26+TBgKGYiDppH6ZYu9EMuJUnn2IzWvR3xIYSuMJeUkPp7QpeM2Q93tZFFbfr3kO3aGybfL5VYYhLL/42sA4VjZwzFDDuTkeh7CFinRfnIqa7Q61VY8sB7NuuLMjz7lAuUXCvd0pBFKDJqYyimX+IfULQL0j52oqkjyezs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740062759; c=relaxed/simple;
	bh=j9scqRi6I8GcTBTGe4QdTetBP1XPewqGTTQJlgJfLXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KVWKOKXNavdGi1jrUWWye3px14+Ureqq3VhnhcdE/lt9aCZRwxmk2LhGYSxLs91VJQb21j3IOLOZd0R7u17lLZ+fXyZ6T1rUO+INQFZXywHVDG2ihaD7dS+CqhLNEalPa8dDAq5Oo1ufDCMu7E4xNFzsYT6TTExqaQAo02QT8ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rz+CJnnL; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3ce85545983so3092545ab.0;
        Thu, 20 Feb 2025 06:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740062756; x=1740667556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYP/9GAIimdjM+IGjvhwDYzgsVj4ddnh1ixjOBOXlsA=;
        b=Rz+CJnnLqSAsUr98cIpnhwjmfzGTyJdtwmp++K1OufDFpkkMecXP1pypZAFzsd6QiM
         4QgGYNJs2tE+5TLL5+ym/lF5PJojEvZ6BihjWlBPjQ7df7oI/MSeXyjk7YySfDhW9Eod
         yDTGz8ErBIUCgg6EY9OrSZSkffTZYt1ejrDDdCvcHoR7oRq39lo8sDYupspophG9xzAz
         JjxEPaRbKx2R9+57lJQrp1hUeJC61057dswpIHkXpJa6zJRQpCjngCgmA1++HCsWZifY
         x5y7VhRGbek+XwjGtZf58y8KIyqe7hdshSSDifg0rRkCHKN/kN9/Gk963JMAEJFU8Lzq
         50PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740062756; x=1740667556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYP/9GAIimdjM+IGjvhwDYzgsVj4ddnh1ixjOBOXlsA=;
        b=KJhAaP3Pg2qOB2yfDR3HslHpqPF+NRAuBD7gSC5+p+GnILs9bxbEvH8Pxta1wyrBrr
         YY+T4y4xAcoOl0KvCUttM1si7uxVLzOVTaP/+pAcufMWxebi9t3BbQ+lYgLvGMZE8mtX
         QcQBJOFFCbh4Vwalg2pT3TRIGBMkS8avhskLK37/frs+qxLdi2CRynP0FRkqSEE0bagy
         6TjG2dhpk3jLD/+7HHQ6e61b3RyUcIwbNB07xwE5M20aPuHiGuitFhDJ42h1Nidtpmz1
         7RjHvxnNuz5lJFQ5mmZ9i1UERj7NTK7WKbVx9kksyj1LXxLXrDm1DE1Tt7RAHazHi0s2
         Kqrw==
X-Forwarded-Encrypted: i=1; AJvYcCWTku5Zn3crCI9fxL/gAX2CeZgL9csE8OB2UaYM3PyVrUX/wUlC0bKf+9g7Ed53i1YLQxF8IZ1sLK2lrUY=@vger.kernel.org, AJvYcCXNp7RlgUBBzS4DUCLA1IFZeq1InYbiuCjKGGajU8benUtHPFRQrtFI+BagxJB7Smqa2B5aivx+@vger.kernel.org
X-Gm-Message-State: AOJu0YyrtcCdzImeIfvDJuHSd/f8cvdfehTwZmXKPcDwlAVEiegmFDQw
	XQ/SYkz1mrEj6kN56CGC1L1xXQ502XmZkCQnNP8/nq9lhDuZ3KIYkcoclw10OS+AR6r/ycaOc9U
	NEC1pBjCnJUauPHBo8TzY81XlKfM=
X-Gm-Gg: ASbGncvqlnDyUNMlM5ZytMltw+mWNMPCTAskVSiCuX7v0mRp2UZyC/WOMqBypAaWHjm
	djkUGI9wg9UUU+gJg5xXWDn227awB+WF/njAUDebWr139SF5VbN0m1EpAYjBXPElx+Tl2ZONC
X-Google-Smtp-Source: AGHT+IHCrUbNJ7Gl5zO6NnigdyoY5MsD70MBQAQ1jyOmKYlCyPFEIHK4PrRa6gvf3tVxldfsfK+3LsIR1WifepQYmpc=
X-Received: by 2002:a05:6e02:1565:b0:3cd:e9a0:3c3d with SMTP id
 e9e14a558f8ab-3d2c00b2fc5mr36834665ab.2.1740062756044; Thu, 20 Feb 2025
 06:45:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218105824.34511-1-wanghai38@huawei.com> <CANn89iKF+LC_isruAAd+nyxgytr4LPeFTe9=ey0j=Xy5URMvkg@mail.gmail.com>
 <f3b279ea-92c3-457f-915a-2f4963746838@huawei.com> <CAL+tcoByx13C1Bk1E33C_TqhpXydNNMe=PF93-5daRQeUC=V7A@mail.gmail.com>
 <5fa8fc14-b67b-4da1-ac8e-339fd3e536c2@huawei.com> <CAL+tcoC3TuZPTwnHTDvXC+JPoJbgW2UywZ2=xv=E=utokb3pCQ@mail.gmail.com>
 <c52f3ef0-0ae0-4913-a3f0-19d55147874d@huawei.com>
In-Reply-To: <c52f3ef0-0ae0-4913-a3f0-19d55147874d@huawei.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 20 Feb 2025 22:45:19 +0800
X-Gm-Features: AWEUYZninMjSy3o1mu9gegixrATRpeg8K4AZ1bhtDzdz7LwjfNOUt6CoK5syttU
Message-ID: <CAL+tcoACG4P9e7-7iZwvJc6njidcO1QUMr3oifjaj7+iS6dMBA@mail.gmail.com>
Subject: Re: [PATCH net] tcp: Fix error ts_recent time during three-way handshake
To: Wang Hai <wanghai38@huawei.com>
Cc: Eric Dumazet <edumazet@google.com>, ncardwell@google.com, kuniyu@amazon.com, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 10:03=E2=80=AFPM Wang Hai <wanghai38@huawei.com> wr=
ote:
>
>
>
> On 2025/2/20 11:04, Jason Xing wrote:
> > On Wed, Feb 19, 2025 at 9:11=E2=80=AFPM Wang Hai <wanghai38@huawei.com>=
 wrote:
> >>
> >>
> >>
> >> On 2025/2/19 11:31, Jason Xing wrote:
> >>> On Wed, Feb 19, 2025 at 10:16=E2=80=AFAM Wang Hai <wanghai38@huawei.c=
om> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 2025/2/18 21:35, Eric Dumazet wrote:
> >>>>> On Tue, Feb 18, 2025 at 12:00=E2=80=AFPM Wang Hai <wanghai38@huawei=
.com> wrote:
> >>>>>>
> >>>>>> If two ack packets from a connection enter tcp_check_req at the sa=
me time
> >>>>>> through different cpu, it may happen that req->ts_recent is update=
d with
> >>>>>> with a more recent time and the skb with an older time creates a n=
ew sock,
> >>>>>> which will cause the tcp_validate_incoming check to fail.
> >>>>>>
> >>>>>> cpu1                                cpu2
> >>>>>> tcp_check_req
> >>>>>>                                        tcp_check_req
> >>>>>> req->ts_recent =3D tmp_opt.rcv_tsval =3D t1
> >>>>>>                                        req->ts_recent =3D tmp_opt.=
rcv_tsval =3D t2
> >>>>>>
> >>>>>> newsk->ts_recent =3D req->ts_recent =3D t2 // t1 < t2
> >>>>>> tcp_child_process
> >>>>>> tcp_rcv_state_process
> >>>>>> tcp_validate_incoming
> >>>>>> tcp_paws_check
> >>>>>> if ((s32)(rx_opt->ts_recent - rx_opt->rcv_tsval) <=3D paws_win) //=
 failed
> >>>>>>
> >>>>>> In tcp_check_req, restore ts_recent to this skb's to fix this bug.
> >>>>>>
> >>>>>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> >>>>>> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> >>>>>> ---
> >>>>>>     net/ipv4/tcp_minisocks.c | 4 ++++
> >>>>>>     1 file changed, 4 insertions(+)
> >>>>>>
> >>>>>> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> >>>>>> index b089b08e9617..0208455f9eb8 100644
> >>>>>> --- a/net/ipv4/tcp_minisocks.c
> >>>>>> +++ b/net/ipv4/tcp_minisocks.c
> >>>>>> @@ -878,6 +878,10 @@ struct sock *tcp_check_req(struct sock *sk, s=
truct sk_buff *skb,
> >>>>>>            sock_rps_save_rxhash(child, skb);
> >>>>>>            tcp_synack_rtt_meas(child, req);
> >>>>>>            *req_stolen =3D !own_req;
> >>>>>> +       if (own_req && tcp_sk(child)->rx_opt.tstamp_ok &&
> >>>>>> +           unlikely(tcp_sk(child)->rx_opt.ts_recent !=3D tmp_opt.=
rcv_tsval))
> >>>>>> +               tcp_sk(child)->rx_opt.ts_recent =3D tmp_opt.rcv_ts=
val;
> >>>>>> +
> >>>>>>            return inet_csk_complete_hashdance(sk, child, req, own_=
req);
> >>>>>
> >>>>> Have you seen the comment at line 818 ?
> >>>>>
> >>>>> /* TODO: We probably should defer ts_recent change once
> >>>>>     * we take ownership of @req.
> >>>>>     */
> >>>>>
> >>>>> Plan was clear and explained. Why implement something else (and bug=
gy) ?
> >>>>>
> >>>> Hi Eric,
> >>>>
> >>>> Currently we have a real problem, so we want to solve it. This bug
> >>>> causes the upper layers to be unable to be notified to call accept a=
fter
> >>>> the successful three-way handshake.
> >>>>
> >>>> Skb from cpu1 that fails at tcp_paws_check (which it could have
> >>>> succeeded) will not be able to enter the TCP_ESTABLISHED state, and
> >>>> therefore parent->sk_data_ready(parent) will not be triggered, and s=
kb
> >>>> from cpu2 can complete the three-way handshake, but there is also no=
 way
> >>>> to call parent->sk_data_ready(parent) to notify the upper layer, whi=
ch
> >>>> will result
> >>>> in the upper layer not being able to sense and call accept to obtain=
 the
> >>>> nsk.
> >>>>
> >>>> cpu1                                cpu2
> >>>> tcp_check_req
> >>>>                                        tcp_check_req
> >>>> req->ts_recent =3D tmp_opt.rcv_tsval =3D t1
> >>>>                                        req->ts_recent=3Dtmp_opt.rcv_=
tsval=3D t2
> >>>>
> >>>> newsk->ts_recent =3D req->ts_recent =3D t2 // t1 < t2
> >>>> tcp_child_process
> >>>>     tcp_rcv_state_process
> >>>>      tcp_validate_incoming
> >>>>       tcp_paws_check // failed
> >>>>     parent->sk_data_ready(parent); // will not be called
> >>>>                                        tcp_v4_do_rcv
> >>>>                                        tcp_rcv_state_process // Comp=
lete the three-way handshake
> >>>>                                                                     =
                                      // missing parent->sk_data_ready(pare=
nt);
> >>>
> >>> IIUC, the ack received from cpu1 triggered calling
> >>> inet_csk_complete_hashdance() so its state transited from
> >>> TCP_NEW_SYN_RECV to TCP_SYN_RECV, right? If so, the reason why not
> >>> call sk_data_ready() if the skb entered into tcp_child_process() is
> >>> that its state failed to transit to TCP_ESTABLISHED?
> >>>
> >> Yes, because it didn't switch to TCP_ESTABLISHED
> >>> Here is another question. How did the skb on the right side enter int=
o
> >>> tcp_v4_do_rcv() after entering tcp_check_req() if the state of sk
> >>> which the skb belongs to is TCP_NEW_SYN_RECV? Could you elaborate mor=
e
> >>> on this point?
> >> Since cpu1 successfully created the child sock, cpu2 will return
> >> null in tcp_check_req and req_stolen is set to true, so that it will
> >> subsequently go to 'goto lookup' to re-process the packet, and at
> >> this point, sk->sk_state is already in TCP_SYN_RECV state, and then
> >> then tcp_v4_do_rcv is called.
> >
> > Now I can see what happened there. Perhaps it would be good to update
> > the commit message
> > in the next iteration.
> Hi Jason,
>
> Thanks for the suggestion, I'll test it out and improve the commit
> message to send v2.
> >
> > Another key information I notice is that the second lookup process
> > loses the chance to call sk_data_ready() for its parent socket. It's
> > the one of the main reasons that cause your application to be unable
> > to get notified. Taking a rough look at tcp_rcv_state_process(), I
> > think it's not easy to acquire the parent socket there and then call
> > sk_data_ready() without modifying more codes compared to the current
> > solution. It's a different solution in theory.
> Yes, I have considered this fix before, but the complexity of the fix
> would be higher.

Agreed.

> >
> > If your new approach (like your previous reply) works, the following
> > commit[1] will be reverted/overwritten.
> I'm sorry, I may not have understood what you meant. Applying my fix,
> commit[1] is still necessary because it doesn't solve the bug that
> commit[1] fixes. can you explain in detail, why commit[1] will be
> reverted/overwritten.

Right, what I was trying to say is that the commit[1] explains how it
happened which is quite similar to your case from the commit message
while your approach can avoid the failure of calling sk_data_ready()
on the basis of commit[1]. IIUC, you postpone updating the recent time
of the skb received from cpu1 which could let this pass
tcp_paws_check() and have the chance to call sk_data_ready(). Then the
issue you reported will be solved. After your patch, we will not
resort to a second lookup. I'm just murmuring alone.

Sorry for my previous inaccurate/wrong words. The above is what I
meant. So let it go. Please go ahead and post your patch :)

Thanks,
Jason

>
> Thanks,
> Wang
>

