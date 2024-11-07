Return-Path: <netdev+bounces-142711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4369C0123
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 10:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 506AB1C20FE2
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 09:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B361922D8;
	Thu,  7 Nov 2024 09:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReRtWKv3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A920318785B
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 09:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730971844; cv=none; b=UiL/U/L7ZyjxtlSnTs2fPCdhlEf/hNTKDSEy27095DZjp2RjMnBhjWL5tcGtvkpNS72hWqTHyO7KBKhjCVzQmp/DovsSMuRgMuzsZFtgJJY1sO8/UGXVuWTvvr9QZaQAl11eg8R3aohiy8LEwpG5sgK54EbUyJz9PxLt4fI2woA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730971844; c=relaxed/simple;
	bh=b2jPctcPSYjkVTZjWBiItB7ezCGeW343cdkavKNuja4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KblMUY0XV8l3wahDU1vCGZLNSNp8uVJYC1WQFFflXKvfQKCuEHKNt9gEaY9twiDd9lQeJErX3orMwXYYBzdblYYsE4GnkyZa1GKfL0tmKPn3B2MRKA0i/Btgt5wlmOaZIfGQVSjrP6Hxdn9IGMtNz1Hs5VvoHNiqVk5RWAqhKZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ReRtWKv3; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a6c1cfcb91so3045435ab.0
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 01:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730971842; x=1731576642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lv5XSPQnrvcOoJF7ZJoyeH21MV+tMP+cswU63+DWigE=;
        b=ReRtWKv3vFmnizf9oMjMa91/pQnjHerZCv5qvPSNdHWBR2hD+g6OG0SblQk/cVqIBv
         UMRB2Aiy4QzCLkTNowAsn+qJWV+RDYEdKy3C145Xy6zHq7c1M/fQHpf4YZhMioumjzfi
         Hurfysu2T14YAhpI/w6QfXw3EafThQ0mqBXIJHEtqzTiJSiSlmUbs9IiL/4EpLzop4Lc
         5yfGQ1rW+7rcbvNyZKGcgizd5L0GUEfQ9+yoZ9a8igSbq4R9s8oAqVgRlqD4H3idsQu8
         t7xklGIUfaPJpBgIxJUI6JjgqryFFZhDHr6CF3RJbTG7pZq54r1GtOsqskI8gO+fIVwf
         yuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730971842; x=1731576642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lv5XSPQnrvcOoJF7ZJoyeH21MV+tMP+cswU63+DWigE=;
        b=tncg4/dXjzZFKRBIYOHPAqUriGmAkGtcDxHi7JaAYl65cEDCKgQnP4jV90bWt1uBpp
         Kk6LgKGI248af2PoFUpCX6Nf6gM7XZV7POf5Vz1nTrEaQo64LwJS5eS5nfJezwGqIRAI
         5G61hP2dRs9IRfKItgRlPWdEP87Yu29x3L+OjPuhJHEvy2FDzQLJ07L0x8gtSNkG8ssN
         zG3lUojQRPo+s9iiOHYl31VmrC4HVhPN7q9KFqpTRw9NFs9xaIGZor4HEToFtmXehwZ3
         icXJq05rQyvL39iIytDfJrGPAP2jWLr0GLdFrmRkRSHpj4hzt1AtCs4LTJjqcL4Plt0l
         rsng==
X-Forwarded-Encrypted: i=1; AJvYcCXPJMBSukxVE/9ejEZRLSqnbbPvzuo6gXtsUbZA1liIMc3YpY80nZiKRL7ohp1mYO7CURgpX4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZXn/ECQy+jgs8QYGIppHPGUxqSDFdbKOM7xouhd+Q6crmAG7x
	alTnemrnbhPqhSS4EQctWRNDhrYbdVmWwoVJeUip1ZDX9aJBojJCoRgF/7ack0dEED1ui7qcvGF
	J1ZHVTjNdG8DaC1Y3U+ylUgS4orE=
X-Google-Smtp-Source: AGHT+IEBhDE3y+zqNtt6IFRtuu+lMnnu+vvIg4ECnm9DUJoeOpl8liLjYPI/idjN+1Q+hBPkpLqjE+4U7PHTdzPJ8+8=
X-Received: by 2002:a05:6e02:1849:b0:3a6:b783:3c06 with SMTP id
 e9e14a558f8ab-3a6ed21aff8mr5559435ab.19.1730971841716; Thu, 07 Nov 2024
 01:30:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105025511.42652-1-kerneljasonxing@gmail.com>
 <92c1d976-7bb6-49ff-9131-edba30623f76@linux.alibaba.com> <CAL+tcoBZaDhBuSKHzGEqgxkzOazX3K-Vo2=mCdOy+iLp4sPAhg@mail.gmail.com>
 <75708260-7eb4-42fe-9d9b-605f8eef488b@linux.alibaba.com> <CAL+tcoBA78svT_vTMOLV-pbwKM1o_SDbjs7AAZLhHOtrd8akBg@mail.gmail.com>
 <CANn89iL5df5_EiDX7JxaFbfmZ9gDo=8ZyLXhbZs+-yp8zVD=GA@mail.gmail.com> <CAL+tcoBCqXiQ33XZv61vCes7_XV83DC0HSPy_w6eCn4pzzJeqA@mail.gmail.com>
In-Reply-To: <CAL+tcoBCqXiQ33XZv61vCes7_XV83DC0HSPy_w6eCn4pzzJeqA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 7 Nov 2024 17:30:05 +0800
Message-ID: <CAL+tcoBPj2aULt5G4qis0D78ke=dt2ws7KBg4Gn+s4FtzjMZfQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: avoid RST in 3-way shakehands due to
 failure in tcp_timewait_state_process
To: Eric Dumazet <edumazet@google.com>
Cc: Philo Lu <lulie@linux.alibaba.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 5:00=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> On Thu, Nov 7, 2024 at 4:37=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > On Thu, Nov 7, 2024 at 9:27=E2=80=AFAM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> > >
> > > On Thu, Nov 7, 2024 at 4:22=E2=80=AFPM Philo Lu <lulie@linux.alibaba.=
com> wrote:
> > > >
> > > >
> > > >
> > > > On 2024/11/7 16:01, Jason Xing wrote:
> > > > > On Thu, Nov 7, 2024 at 3:51=E2=80=AFPM Philo Lu <lulie@linux.alib=
aba.com> wrote:
> > > > >>
> > > > >> Hi Jason,
> > > > >>
> > > > >> On 2024/11/5 10:55, Jason Xing wrote:
> > > > >>> From: Jason Xing <kernelxing@tencent.com>
> > > > >>>
> > > > >>> We found there are rare chances that some RST packets appear du=
ring
> > > > >>> the shakehands because the timewait socket cannot accept the SY=
N and
> > > > >>> doesn't return TCP_TW_SYN in tcp_timewait_state_process().
> > > > >>>
> > > > >>> Here is how things happen in production:
> > > > >>> Time        Client(A)        Server(B)
> > > > >>> 0s          SYN-->
> > > > >>> ...
> > > > >>> 132s                         <-- FIN
> > > > >>> ...
> > > > >>> 169s        FIN-->
> > > > >>> 169s                         <-- ACK
> > > > >>> 169s        SYN-->
> > > > >>> 169s                         <-- ACK
> > > > >>> 169s        RST-->
> > > > >>> As above picture shows, the two flows have a start time differe=
nce
> > > > >>> of 169 seconds. B starts to send FIN so it will finally enter i=
nto
> > > > >>> TIMEWAIT state. Nearly at the same time A launches a new connec=
tion
> > > > >>> that soon is reset by itself due to receiving a ACK.
> > > > >>>
> > > > >>> There are two key checks in tcp_timewait_state_process() when t=
imewait
> > > > >>> socket in B receives the SYN packet:
> > > > >>> 1) after(TCP_SKB_CB(skb)->seq, rcv_nxt)
> > > > >>> 2) (s32)(READ_ONCE(tcptw->tw_ts_recent) - tmp_opt.rcv_tsval) < =
0)
> > > > >>>
> > > > >>> Regarding the first rule, it fails as expected because in the f=
irst
> > > > >>> connection the seq of SYN sent from A is 1892994276, then 169s =
have
> > > > >>> passed, the second SYN has 239034613 (caused by overflow of s32=
).
> > > > >>>
> > > > >>> Then how about the second rule?
> > > > >>> It fails again!
> > > > >>> Let's take a look at how the tsval comes out:
> > > > >>> __tcp_transmit_skb()
> > > > >>>       -> tcp_syn_options()
> > > > >>>           -> opts->tsval =3D tcp_skb_timestamp_ts(tp->tcp_usec_=
ts, skb) + tp->tsoffset;
> > > > >>> The timestamp depends on two things, one is skb->skb_mstamp_ns,=
 the
> > > > >>> other is tp->tsoffset. The latter value is fixed, so we don't n=
eed
> > > > >>> to care about it. If both operations (sending FIN and then star=
ting
> > > > >>> sending SYN) from A happen in 1ms, then the tsval would be the =
same.
> > > > >>> It can be clearly seen in the tcpdump log. Notice that the tsva=
l is
> > > > >>> with millisecond precision.
> > > > >>>
> > > > >>> Based on the above analysis, I decided to make a small change t=
o
> > > > >>> the check in tcp_timewait_state_process() so that the second fl=
ow
> > > > >>> would not fail.
> > > > >>>
> > > > >>
> > > > >> I wonder what a bad result the RST causes. As far as I know, the=
 client
> > > > >> will not close the connect and return. Instead, it re-sends an S=
YN in
> > > > >> TCP_TIMEOUT_MIN(2) jiffies (implemented in
> > > > >> tcp_rcv_synsent_state_process). So the second connection could s=
till be
> > > > >> established successfully, at the cost of a bit more delay. Like:
> > > > >>
> > > > >>    Time        Client(A)        Server(B)
> > > > >>    0s          SYN-->
> > > > >>    ...
> > > > >>    132s                         <-- FIN
> > > > >>    ...
> > > > >>    169s        FIN-->
> > > > >>    169s                         <-- ACK
> > > > >>    169s        SYN-->
> > > > >>    169s                         <-- ACK
> > > > >>    169s        RST-->
> > > > >> ~2jiffies    SYN-->
>
> It doesn't happen. I dare to say the SYN will not be retransmitted
> soon which I can tell from many tcpdump logs I captured.

My mind went blank probably because of getting sick. Sorry. Why the
tcpdump doesn't show the retransmitted SYN packet is our private
kernel missed this following commit:

commit 9603d47bad4642118fa19fd1562569663d9235f6
Author: SeongJae Park <sjpark@amazon.de>
Date:   Sun Feb 2 03:38:26 2020 +0000

    tcp: Reduce SYN resend delay if a suspicous ACK is received

    When closing a connection, the two acks that required to change closing
    socket's status to FIN_WAIT_2 and then TIME_WAIT could be processed in
    reverse order.  This is possible in RSS disabled environments such as a
    connection inside a host.

