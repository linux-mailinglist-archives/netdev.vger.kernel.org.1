Return-Path: <netdev+bounces-123369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 540B7964A06
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 17:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AFBA2856F1
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 15:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BB61B2EEE;
	Thu, 29 Aug 2024 15:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThQsRo5Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221021B3759
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 15:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724945292; cv=none; b=kEFd2RRXe/s+KtbHv3+8T3rgqL4dSQhJAMqhCk+FafAPqdkVz8Zkj0lJEAz0cO6TvFTn17p01ongWYVeVsAHZuqAtmQuOXZEq0nmI0NScjGZvNNF7Q/vAMYZPhCu+sSF1abhORHS15fJ+t6atKEf6ryBs/418XtCu61pmp+RV/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724945292; c=relaxed/simple;
	bh=0Pj64d2LLlGVuhLH/caPNAxJbH2rt39ar4xtx/Q5z8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YGUf9769afiT5XEqL5dAeU5Z3KuB4xHBMmRyZGsq4IS63GTSZ90TXIxomr457LeiTSNTKb6bKfjPMzwplfkDvQNjljDn9sUN/yIafsVdXf+qN7qC56KTydS7/4juwyf7c7AiCTa4haUCXWKdcVQ6PVj00jiPyOJnMHnAJqNOzxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThQsRo5Y; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c210e23651so877422a12.3
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 08:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724945289; x=1725550089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDBvoq+7NJi2lNazydrPNMQOT2RH7RzHc4HYm5r/skc=;
        b=ThQsRo5YFRd0Js8URgO2arNfgxTzWzVPDDagU3WtVtOp3WRWHX86XMKlCxaoHazNtN
         J7XEKpQx0u2mXJqmt9YGKTdYxcBW80Pozcg/zEN64nl7uxohu1WtUsbVLZF4nzX/YxzR
         Ly4PxkVGzdVY9S2ZfLmpsu7F/J7BqhD3VcGS9gTDEbKE03DyDW5/Yn8CSNLtN3wkr8aB
         nrHxO17VgyN8LWZXTlJzGHYOyDZa1m9OgZeRUQVmJZ1mdxZ/cbSOBUg0FYlaeN8hzu57
         uKg/22iftLtD9IvnuRWRynLT/7AWAkwqw4bWMRRFIwdx/E0qRYM61g+3ezGPKQiQU1yx
         W4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724945289; x=1725550089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dDBvoq+7NJi2lNazydrPNMQOT2RH7RzHc4HYm5r/skc=;
        b=KfYbiR5HztN8yKdbTCz6/WYbS6zqVMTIE2aiFs3idyb1wdW4IbtUGaJ2QJHIq5lSaX
         B92cKm6g+kVPz61tf1CZVG+H5dXDkUA6A2swQeygFj+T0x0Zowmkeo9LCLBkhjMZdk8t
         cE97+nS+ilfESmpq4ZL3l6ZlzwrehW6A1Jkjh6BvepHfT6zp2dnefgqiLDvWEPQAWz+C
         0Ze4GKSAI+gJuUv/XE1byatSvWcN2o+UgiM6D7AL8mSzCErmyK8o0kjEgtR/b7Iw57de
         KJqO+uEDANuwEblhTVzSyHrEh3SadCl0LY+NjuOQIvIcJdeGz5Z3cCojRE0hW8UAM3Nb
         +1MA==
X-Forwarded-Encrypted: i=1; AJvYcCXIb0+SdyNZIZXjLW4YYy6MsVU9eURcObOLhFBEX+E38wXBlWALEddIj2fsEqPqxsJspbWr9ig=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywizr8VkSxLt8gUdC9dlKI/4zNja+IR8XpvncjL4jcm+F6X3DDr
	fjBb4Gir56tAfkbZjqE0qCoUFxixFHwWtW+7zeeELLZKKHlxjNcc6Vb/8olrAIaCeA0eIa4Nzhu
	xcNoDd9WWfpY7R1ytFcw8EMiuvdk=
X-Google-Smtp-Source: AGHT+IFEx9eb7PrmttoUkW5DUTcq+dzwMidXMs6PpYSWnZWr0a8zC9YiR6cfq+JR0V0ePG1+V5i9TpGlyxSV96MSV0g=
X-Received: by 2002:a05:6402:35d6:b0:5c0:a8b1:ca8a with SMTP id
 4fb4d7f45d1cf-5c21ed42ac9mr2748837a12.11.1724945289051; Thu, 29 Aug 2024
 08:28:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828160145.68805-1-kerneljasonxing@gmail.com> <66d082422d85_3895fa29427@willemb.c.googlers.com.notmuch>
In-Reply-To: <66d082422d85_3895fa29427@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 29 Aug 2024 23:27:31 +0800
Message-ID: <CAL+tcoD6s0rrCAvMeMDE3-QVemPy21Onh4mHC+9PE-DDLkdj-Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/2] timestamp: control SOF_TIMESTAMPING_RX_SOFTWARE
 feature per socket
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 10:14=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Prior to this series, when one socket is set SOF_TIMESTAMPING_RX_SOFTWA=
RE
> > which measn the whole system turns on this button, other sockets that o=
nly
> > have SOF_TIMESTAMPING_SOFTWARE will be affected and then print the rx
> > timestamp information even without SOF_TIMESTAMPING_RX_SOFTWARE flag.
> > In such a case, the rxtimestamp.c selftest surely fails, please see
> > testcase 6.
> >
> > In a normal case, if we only set SOF_TIMESTAMPING_SOFTWARE flag, we
> > can't get the rx timestamp because there is no path leading to turn on
> > netstamp_needed_key button in net_enable_timestamp(). That is to say, i=
f
> > the user only sets SOF_TIMESTAMPING_SOFTWARE, we don't expect we are
> > able to fetch the timestamp from the skb.
>
> I already happened to stumble upon a counterexample.
>
> The below code requests software timestamps, but does not set the
> generate flag. I suspect because they assume a PTP daemon (sfptpd)
> running that has already enabled that.

To be honest, I took a quick search through the whole onload program
and then suspected the use of timestamp looks really weird.

1. I searched the SOF_TIMESTAMPING_RX_SOFTWARE flag and found there is
no other related place that actually uses it.
2. please also see the tx_timestamping.c file[1]. The author similarly
only turns on SOF_TIMESTAMPING_SOFTWARE report flag without turning on
any useful generation flag we are familiar with, like
SOF_TIMESTAMPING_TX_SOFTWARE, SOF_TIMESTAMPING_TX_SCHED,
SOF_TIMESTAMPING_TX_ACK.

[1]: https://github.com/Xilinx-CNS/onload/blob/master/src/tests/onload/hwti=
mestamping/tx_timestamping.c#L247

>
> https://github.com/Xilinx-CNS/onload/blob/master/src/tests/onload/hwtimes=
tamping/rx_timestamping.c
>
> I suspect that there will be more of such examples in practice. In
> which case we should scuttle this. Please do a search online for
> SOF_TIMESTAMPING_SOFTWARE to scan for this pattern.

I feel that only the buggy program or some program particularly takes
advantage of the global netstamp_needed_key...

>
> > More than this, we can find there are some other ways to turn on
> > netstamp_needed_key, which will happenly allow users to get tstamp in
> > the receive path. Please see net_enable_timestamp().
> >
> > How to solve it?
> >
> > setsockopt interface is used to control each socket separately but in
> > this case it is affected by other sockets. For timestamp itself, it's
> > not feasible to convert netstamp_needed_key into a per-socket button
> > because when the receive stack just handling the skb from driver doesn'=
t
> > know which socket the skb belongs to.
> >
> > According to the original design, we should not use both generation fla=
g
> > (SOF_TIMESTAMPING_RX_SOFTWARE) and report flag (SOF_TIMESTAMPING_SOFTWA=
RE)
> > together to test if the application is allowed to receive the timestamp
> > report in the receive path. But it doesn't hold for receive timestampin=
g
> > case. We have to make an exception.
> >
> > So we have to test the generation flag when the applications do recvmsg=
:
> > if we set both of flags, it means we want the timestamp; if not, it mea=
ns
> > we don't expect to see the timestamp even the skb carries.
> >
> > As we can see, this patch makes the SOF_TIMESTAMPING_RX_SOFTWARE under
> > setsockopt control. And it's a per-socket fine-grained now.
> >
> > v2
> > Link: https://lore.kernel.org/all/20240825152440.93054-1-kerneljasonxin=
g@gmail.com/
> > Discussed with Willem
> > 1. update the documentation accordingly
> > 2. add more comments in each patch
> > 3. remove the previous test statements in __sock_recv_timestamp()
> >
> > Jason Xing (2):
> >   tcp: make SOF_TIMESTAMPING_RX_SOFTWARE feature per socket
> >   net: make SOF_TIMESTAMPING_RX_SOFTWARE feature per socket
> >
> >  Documentation/networking/timestamping.rst |  7 +++++++
> >  include/net/sock.h                        |  7 ++++---
> >  net/bluetooth/hci_sock.c                  |  4 ++--
> >  net/core/sock.c                           |  2 +-
> >  net/ipv4/ip_sockglue.c                    |  2 +-
> >  net/ipv4/ping.c                           |  2 +-
> >  net/ipv4/tcp.c                            | 11 +++++++++--
> >  net/ipv6/datagram.c                       |  4 ++--
> >  net/l2tp/l2tp_ip.c                        |  2 +-
> >  net/l2tp/l2tp_ip6.c                       |  2 +-
> >  net/nfc/llcp_sock.c                       |  2 +-
> >  net/rxrpc/recvmsg.c                       |  2 +-
> >  net/socket.c                              | 11 ++++++++---
> >  net/unix/af_unix.c                        |  2 +-
> >  14 files changed, 40 insertions(+), 20 deletions(-)
> >
> > --
> > 2.37.3
> >
>
>

