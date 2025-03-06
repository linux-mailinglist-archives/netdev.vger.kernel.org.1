Return-Path: <netdev+bounces-172426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94339A5491A
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 12:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDC9D3AE6B3
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 11:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA451209F46;
	Thu,  6 Mar 2025 11:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gqifp0rK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFEB209F22;
	Thu,  6 Mar 2025 11:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741259951; cv=none; b=mirFWkagfVNlgrEn6CblBz3UghwR7Gqbqvgv+dtatsYoqAx1OhXHrcvkuAYvIOqLmwkmCV3pCHwoZ2WbJdL70XKhlDj1lBiLhLCBDpxTHfm/gwMDqAfqQNr3SxaWvkD+74+3Ow+l/PGkCgmNDV90KMmd/g954fZ37NKAdYkTsHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741259951; c=relaxed/simple;
	bh=Ok1N6vLAt3wQ2ON0rtwHmYpKF2IJZbcxuUIBDEcSWAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tNCGadl3aSKi1RkIjrYXTSWVxDZzzoGdjHVZQ9OANS65G3pkzA3ueQr91rrCyFrTJEWcdFwfzsTLmDkCeTwojrAmSD5KIWAh95HpzeLCb0OCluz/Xcb11t/6Of8TElEA0ihWi+Xfq4yH/rVbJUQqILFAQB1DrgEFkj9O+GyHows=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gqifp0rK; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3d439dc0548so1449855ab.3;
        Thu, 06 Mar 2025 03:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741259949; x=1741864749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdFglds/j6znPC2cjLp2w6Zp59saQXRTSKQDQqGGWHI=;
        b=Gqifp0rKajo44UecdNnuKH0x5WUxF4/6ARhrlPlNHJTzJb6vPhHDFd/MsjF2wZbFAy
         wIJsjB+aYNwTk7GynBt4NfvkqPP56FcBhHSf9rnr07wHXqPItANSAdZ7BlOgBZ9owVHJ
         ibdGq7xc1Yk8Yg2tDzeSYK2QmIWpM0cBusyhv3zRjr8TnFmwDhbwN0RdXWOX5+TJzZvX
         LA2YauQCLZo8e36xdDZ/4K0ESDM0yl07sfE6BqBZJagk2ozML3+ywb0BqrYTCJXpAEqa
         M5gtN+e3Q98f5MTF+APGZayhQRqYxmlTy6/gfB1doyZwZ91r6fnGpt/54UFv7uwKPFb7
         zkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741259949; x=1741864749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdFglds/j6znPC2cjLp2w6Zp59saQXRTSKQDQqGGWHI=;
        b=oj/OTmV+fOrIgH2pdakhCLKbV70SNngDniQJTSkdS/K0nVnh8RoszADtddws0Iz6cs
         Q935FrXKdFO/oqvIa7EWgPdbV2x3k/PQ+fspuqNVDzDKrp1fNCga3cwNgf/3TGLABSbU
         +2yaSU46jxQm0fElpcO/wru/iKA5vTLcUdORH/YKfhFBosazaWbyP6+bJikLZHhi/jLX
         Ymtc5Dn3dAHfPYYgl9Bh34bWxmvd0jEm0tNAngYP5jcssG8AfUYTI5xN/MNzIgls31Vo
         3gIVECBTOkPyrdkL9fK2p+lb6MLZdZkeRggv6hTkAIFFtMWyBNwDCe/+UqIc0G5uzJYe
         OOog==
X-Forwarded-Encrypted: i=1; AJvYcCUy9B1J8T8oVrCuZD/hYUXSYFBgtYrx2hi5elWwQ2YGmKRIPKDH6rqDmvglf27MGEnzhrFVrJyx@vger.kernel.org, AJvYcCXWjcT+bQWxicAr0KhVrVMGY82XK26VafL5kESSvX5q1OI+UerFWQ//vu4GmHHBnveSjJT8bOjR3F2Ieuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBXl0Yeacgrb/eu/CYuWUCnPYSO7/TUGHBa40zFeF0pulYcwQm
	may6nHJaTZ+FSrg3IIyC4skxhrmZ2XEwENLhKCKvTHJoCEe+ti8MYOMf4PEi/Ljqo2qVbfnM65Y
	OnNO3+M5FIUtgeBBRF6Pqo7CrzfM=
X-Gm-Gg: ASbGncuyEfEC5oVLc78GJ1Z3bWbeWFHRGAMzwqGUS8+6Y4+5fswB8zD/2HWgSoMvOME
	prjETtNl+31mcJszh0MB3o5XsOpbOj/mAOO4afw+AaofIPaV+EXs+Dn/tkkicjRw7hWvLL4osPq
	AOC8/sW4i5o8XGuAeqUjZ8ZEC+zA==
X-Google-Smtp-Source: AGHT+IHyoCGfvVYbAaURcPlnL9tHG+meZJOQIierDlmoKJlrLsVKnOJCvjGK85WZ0DWTXsXn4aSUQFwuK0dv+9qCAEA=
X-Received: by 2002:a05:6e02:1fe7:b0:3d3:fa69:6763 with SMTP id
 e9e14a558f8ab-3d42b879b0bmr82296045ab.2.1741259948949; Thu, 06 Mar 2025
 03:19:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305-net-next-fix-tcp-win-clamp-v1-1-12afb705d34e@kernel.org>
 <CAL+tcoAqZmeV0-4rjH-EPmhBBaS=ZSwgcXhU8ZsBCr_aXS3Lqw@mail.gmail.com> <CANn89iLqgi5byZd+Si7jTdg7zrLNn13ejWAQjMRurvrQPeg3zg@mail.gmail.com>
In-Reply-To: <CANn89iLqgi5byZd+Si7jTdg7zrLNn13ejWAQjMRurvrQPeg3zg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 6 Mar 2025 19:18:32 +0800
X-Gm-Features: AQ5f1Jq0u63iE68V3P_FpSeHlD2FMnvoOEzXHk11BDHE5gpLosHNeH6eIzHVykg
Message-ID: <CAL+tcoDH0DAWmvYR2RFPtWimq8MW8a1CRdoaTSABpS-OTx_L+w@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: clamp window like before the cleanup
To: Eric Dumazet <edumazet@google.com>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 5:45=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Thu, Mar 6, 2025 at 6:22=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
> >
> > On Wed, Mar 5, 2025 at 10:49=E2=80=AFPM Matthieu Baerts (NGI0)
> > <matttbe@kernel.org> wrote:
> > >
> > > A recent cleanup changed the behaviour of tcp_set_window_clamp(). Thi=
s
> > > looks unintentional, and affects MPTCP selftests, e.g. some tests
> > > re-establishing a connection after a disconnect are now unstable.
> > >
> > > Before the cleanup, this operation was done:
> > >
> > >   new_rcv_ssthresh =3D min(tp->rcv_wnd, new_window_clamp);
> > >   tp->rcv_ssthresh =3D max(new_rcv_ssthresh, tp->rcv_ssthresh);
> > >
> > > The cleanup used the 'clamp' macro which takes 3 arguments -- value,
> > > lowest, and highest -- and returns a value between the lowest and the
> > > highest allowable values. This then assumes ...
> > >
> > >   lowest (rcv_ssthresh) <=3D highest (rcv_wnd)
> > >
> > > ... which doesn't seem to be always the case here according to the MP=
TCP
> > > selftests, even when running them without MPTCP, but only TCP.
> > >
> > > For example, when we have ...
> > >
> > >   rcv_wnd < rcv_ssthresh < new_rcv_ssthresh
> > >
> > > ... before the cleanup, the rcv_ssthresh was not changed, while after
> > > the cleanup, it is lowered down to rcv_wnd (highest).
> > >
> > > During a simple test with TCP, here are the values I observed:
> > >
> > >   new_window_clamp (val)  rcv_ssthresh (lo)  rcv_wnd (hi)
> > >       117760   (out)         65495         <  65536
> > >       128512   (out)         109595        >  80256  =3D> lo > hi
> > >       1184975  (out)         328987        <  329088
> > >
> > >       113664   (out)         65483         <  65536
> > >       117760   (out)         110968        <  110976
> > >       129024   (out)         116527        >  109696 =3D> lo > hi
> > >
> > > Here, we can see that it is not that rare to have rcv_ssthresh (lo)
> > > higher than rcv_wnd (hi), so having a different behaviour when the
> > > clamp() macro is used, even without MPTCP.
> > >
> > > Note: new_window_clamp is always out of range (rcv_ssthresh < rcv_wnd=
)
> > > here, which seems to be generally the case in my tests with small
> > > connections.
> > >
> > > I then suggests reverting this part, not to change the behaviour.
> > >
> > > Fixes: 863a952eb79a ("tcp: tcp_set_window_clamp() cleanup")
> > > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/551
> > > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> >
> > Tested-by: Jason Xing <kerneljasonxing@gmail.com>
> >
> > Thanks for catching this. I should have done more tests :(
> >
> > Now I use netperf with TCP_CRR to test loopback and easily see the
> > case where tp->rcv_ssthresh is larger than tp->rcv_wnd, which means
> > tp->rcv_wnd is not the upper bound as you said.
> >
> > Thanks,
> > Jason
> >
>
> Patch looks fine to me but all our tests are passing with the current ker=
nel,
> and I was not able to trigger the condition.
>
> Can you share what precise test you did ?
>
> Thanks !

I did the test[1] on the virtual machine running the kernel [2]. And
after seeing your reply, I checked out a clean branch and compiled the
kernel with the patch reverted again and rebooted. The case can still
be reliably reproduced in my machine. Here are some outputs from BPF
program[3]:
 sudo bpftrace tcp_cap.bt.2
Attaching 1 probe...
4327813, 4326775, 4310912
netperf
        tcp_set_window_clamp+1
        tcp_data_queue+1744
        tcp_rcv_established+501
        tcp_v4_do_rcv+369
        tcp_v4_rcv+4800
        ip_protocol_deliver_rcu+65

4327813, 4326827, 4310912
netperf
        tcp_set_window_clamp+1
        tcp_data_queue+1744
        tcp_rcv_established+501
        tcp_v4_do_rcv+369
        tcp_v4_rcv+4800
        ip_protocol_deliver_rcu+65

418081, 417052, 417024
swapper/11
        tcp_set_window_clamp+1
        tcp_data_queue+1744
        tcp_rcv_established+501
        tcp_v4_do_rcv+369
        tcp_v4_rcv+4800
        ip_protocol_deliver_rcu+65

I can help if you want to see something else.

Thanks,
Jason

[1]: netperf -H 127.0.0.1 and netperf -H 127.0.0.1 -t TCP_CRR
[2]: based on commit f130a0cc1b4ff1 with reverted patch
commit 196150bf8e912eb27d4f083fc223ad8787709c6f (HEAD -> main)
Author: Jason Xing <kerneljasonxing@gmail.com>
Date:   Thu Mar 6 19:00:47 2025 +0800

    Revert "tcp: tcp_set_window_clamp() cleanup"

    This reverts commit 863a952eb79a6acf2b1f654f4e75ed104ff4cc81.

commit f130a0cc1b4ff1ef28a307428d40436032e2b66e (origin/main, origin/HEAD)
Author: Eric Dumazet <edumazet@google.com>
Date:   Tue Mar 4 12:59:18 2025 +0000

    inet: fix lwtunnel_valid_encap_type() lock imbalance

    After blamed commit rtm_to_fib_config() now calls
    lwtunnel_valid_encap_type{_attr}() without RTNL held,
    triggering an unlock balance in __rtnl_unlock,
    as reported by syzbot [1]
[3]:
kprobe: tcp_set_window_clamp
{
        $sk =3D (struct sock *) arg0;
        $val =3D arg1;
        $tp =3D (struct tcp_sock *) $sk;
        $dport =3D $sk->__sk_common.skc_dport;
        $dport =3D bswap($dport);
        $lport =3D $sk->__sk_common.skc_num;

        if ($tp->rcv_ssthresh > $tp->rcv_wnd) {
                printf("%u, %u, %u\n", $tp->window_clamp,
$tp->rcv_ssthresh, $tp->rcv_wnd);
                printf("%s %s\n", comm, kstack(6));
        }
}

