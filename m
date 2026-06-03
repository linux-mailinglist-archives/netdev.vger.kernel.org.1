Return-Path: <netdev+bounces-294716-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dX7rKmYNIGqFvAAAu9opvQ
	(envelope-from <netdev+bounces-294716-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 13:17:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1276E636F44
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 13:17:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MszdDAJk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294716-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294716-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 332E73396A1B
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 11:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7174E45BD4E;
	Wed,  3 Jun 2026 11:07:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A6A4534A8;
	Wed,  3 Jun 2026 11:07:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484845; cv=none; b=nVA7/v/HTXvGFSY7k0zqIlonAC5yxsagtTLgjlL2itsP35u30uumiOvsGdtR4zlUki1P6meE0mZKNaZPwnYRPNkFWkixnBArBCZ0M1Cr9PSi413/EDMJwwiUaZ6czWIADhiuVbSZdkRanixfpPXKTQK1SFy/OEvRI8uOf6eXk1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484845; c=relaxed/simple;
	bh=QR21B1XieO1Gv/zvOXQd1clr0hyDmZzfZmqsZDRnmmM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fqxAw65/p8rtNbdNxeWyvFyaEpPlcuK+0aqWeSJfz5o580fAmnfdiY/oii71Y+2iYV+3xHQet801x2NhdBZK3YWiZD5ZjbTXQ8TH5Sg/Qkz5zU30hHkGOfbaYdN53vvP8SDVr3QL2B12ZWBtx1ATU7QwyIPClyWRbrUS5y8mVyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MszdDAJk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BC61F0089A;
	Wed,  3 Jun 2026 11:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780484843;
	bh=Ui/yXK7lZaXIcLfzck+vL1NDPgq7d4i58XIiuImd1TA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=MszdDAJkXZzyP3gNU6o+YgfTsHh54ExDatarqbsslYE5R2BJ/N7mm3N2gmnU81/tB
	 Nv0+UcW5D6xL7cyCBofxdG9jfubI2JsjobJR0JIAfxlZN8ekQFixsC2YdEfO1ZbZ0s
	 phCDPk2Ia65orjO0jKOAx2/ejmNiZh5HebjH8bBZoJxUFQqNsRIiOIsUcjzWgN1e9r
	 ZrtiJb2Q5fRN68eZcpAaMF5lPYTazuzngxvLfuzZ+leaqlc0RyqZs8b0wAsNXl2HxJ
	 VKXpYYSBGlyfHmPJk1Vr8O5+va18hNrX3O2XcmkdP+fm82BNSRXISIwbMflz7J68qQ
	 clQY5L1kDM8Fg==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id D12827BAE4D; Wed, 03 Jun 2026 13:07:20 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, willemb@google.com,
 kuniyu@google.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, Simon
 Sundberg <Simon.Sundberg@kau.se>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next 5/6] bpf: enable bpf timestamping rx in TCP layer
In-Reply-To: <87lddfn2m1.fsf@toke.dk>
References: <20260518082344.96647-1-kerneljasonxing@gmail.com>
 <20260518082344.96647-6-kerneljasonxing@gmail.com>
 <f9606d4b-7ff7-479f-8e73-2e8cc77095fa@kernel.org>
 <CAL+tcoDRSpVsiCym+DYsGLBGrdEuim7AZqyBTHYzd-OSBki5-Q@mail.gmail.com>
 <2942dd24-3b6f-4e88-acb2-67d35ea8938b@kernel.org>
 <CAL+tcoCO7Op69K6w9fNX5BohHoafU3C1r62=J1djTMdc30nhFQ@mail.gmail.com>
 <CAL+tcoA_VBcXu_2zVXFvsWF7+U=-TZf7bCz0KzNpN=p=82tB=w@mail.gmail.com>
 <87lddfn2m1.fsf@toke.dk>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 03 Jun 2026 13:07:20 +0200
Message-ID: <871pendgrb.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.10 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.56)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-294716-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kerneljasonxing@gmail.com,m:hawk@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:willemb@google.com,m:kuniyu@google.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:Simon.Sundberg@kau.se,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:kernelxing@tencent.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[toke@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,gmail.com,fomichev.me,kau.se,vger.kernel.org,tencent.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,doi.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,toke.dk:mid,toke.dk:email,lpc.events:url,arxiv.org:url,diva-portal.org:url,tencent.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1276E636F44

Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk> writes:

> Jason Xing <kerneljasonxing@gmail.com> writes:
>
>> On Tue, May 19, 2026 at 7:16=E2=80=AFAM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
>>>
>>> On Tue, May 19, 2026 at 12:40=E2=80=AFAM Jesper Dangaard Brouer <hawk@k=
ernel.org> wrote:
>>> >
>>> >
>>> >
>>> > On 18/05/2026 15.53, Jason Xing wrote:
>>> > > On Mon, May 18, 2026 at 9:01=E2=80=AFPM Jesper Dangaard Brouer <haw=
k@kernel.org> wrote:
>>> > >>
>>> > >>
>>> > >>
>>> > >> On 18/05/2026 10.23, Jason Xing wrote:
>>> > >>> From: Jason Xing <kernelxing@tencent.com>
>>> > >>>
>>> > >>> Add two if statements to accurately isolate bpf timestamping and =
so
>>> > >>> timestamping. They can work respectively.
>>> > >>>
>>> > >>> As to so_timestamping, only add a loose condition via report flags
>>> > >>> to avoid duplicate strict checks that is done in tcp_recv_timesta=
mp()
>>> > >>> and performance impact. If the loose condition is hit,
>>> > >>> tcp_recv_timestamp() is able to handle the exact case and doesn't
>>> > >>> hamper the existing timestamping feature.
>>> > >>>
>>> > >>> Make it work in TCP protocol.
>>> > >>>
>>> > >>> Signed-off-by: Jason Xing <kernelxing@tencent.com>
>>> > >>> ---
>>> > >>>    net/ipv4/tcp.c | 14 ++++++++++++--
>>> > >>>    1 file changed, 12 insertions(+), 2 deletions(-)
>>> > >>>
>>> > >>> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
>>> > >>> index 21ece4c71612..64c69bb3578a 100644
>>> > >>> --- a/net/ipv4/tcp.c
>>> > >>> +++ b/net/ipv4/tcp.c
>>> > >>> @@ -2949,8 +2949,18 @@ int tcp_recvmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len, int flags)
>>> > >>>        release_sock(sk);
>>> > >>>
>>> > >>>        if ((cmsg_flags | msg->msg_get_inq) && ret >=3D 0) {
>>> > >>> -             if (cmsg_flags & TCP_CMSG_TS)
>>> > >>> -                     tcp_recv_timestamp(msg, sk, &tss);
>>> > >>> +             if (cmsg_flags & TCP_CMSG_TS) {
>>> > >>> +                     u32 tsflags =3D READ_ONCE(sk->sk_tsflags);
>>> > >>> +
>>> > >>> +                     if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
>>> > >>> +                         SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_RX_TI=
MESTAMPING))
>>> > >>> +                             bpf_skops_rx_timestamping(sk, &tss,
>>> > >>> +                                                       BPF_SOCK_=
OPS_TSTAMP_RCV_CB);
>>> > >>
>>> > >> Does this mean I can enable timestamp reading per cgroup?
>>> > >
>>> > > Yes, I think so, but I didn't try. One of the natures of sockopt
>>> > > feature is supporting cgroup attach.
>>> > > cgroup_bpf_prog_attach()/cgroup_bpf_link_attach() is probably
>>> > > something that you're looking for.
>>> > >
>>> >
>>> > Sound good
>>> >
>>> > > IIUC, you can attach the prog onto the cgroup where all the sockets
>>> > > are set using the bpf timestamping function. So the current impl is
>>> > > cleaner and has better isolation (to filter out those unmatched
>>> > > flows).
>>> > >
>>> > >>
>>> > >> In Simon's netstacklat[1] tool we are forced process all RX timest=
amp
>>> > >> (hooking fentry/tcp_recv_timestamp), and then we have a BPF filter=
[2] on
>>> > >> the cgroup IDs that we are interested in (which is a significant
>>> > >> overhead, as this is deployed at Cloudflare production scale).
>>> > >
>>> > > I can feel the pain when filtering in this kind of relatively hot
>>> > > path, which is what I'm trying to avoid internally. What I've done =
in
>>> > > production (to cover those old kernels) is to just let the kernel
>>> > > print the information, that's it, and there is an agent continuously
>>> > > gathering the data, doing the match and computing latency. But it's
>>> > > overall complicated.
>>> > >
>>> >
>>> > I hope you don't mean your internal/old approach was using printk and
>>> > then analyzing this data.
>>>
>>> Of course not :)
>>>
>>> The internal approach is to cover the old kernels but doesn't mean the
>>> approach is old :P
>>>
>>> Instead, the internal kernel module is super efficient and I'm trying
>>> to ship bpf with such an ability. The fact is we've already deployed
>>> in production: 7x24 running, zero sampling.
>>>
>>> Please see page 24 where there is a brief introduction on how to deal
>>> with the log part:
>>> https://lpc.events/event/19/contributions/2055/#preview:3846
>>> I believe this is the promising direction (ring buffer + lightweight
>>> kernel + heavy agent) we're taking.
>>>
>>> The headache part is that I need to provide an agent written in BPF to
>>> do the heavy process.
>>>
>>> >
>>> > > Many thanks here, I'm always interested in hearing more useful and
>>> > > real requirements and fancy ideas on how to monitor the latency :) =
Now
>>> >
>>> > Simon Sundberg <Simon.Sundberg@kau.se> have many more fancy ideas on =
how
>>> > to monitor the latency.
>>> > The netstacklat tool is part of Simon's PhD thesis:
>>> > - https://doi.org/10.59217/qklv6836
>>> >
>>> > And we even gotten a paper accepted on netstacklat:
>>> > -
>>> > https://kau.diva-portal.org/smash/record.jsf?pid=3Ddiva2%3A2034009&ds=
wid=3D3032
>>>
>>> Sorry, I cannot access this link. Could you give me the title of this p=
aper?
>>
>> Waiting at the Front Door - Continuous Monitoring of Latency in the
>> Host Network Stack
>>
>> Oh, I guess it hasn't been officially published right? This is the
>> reason why I have no way to know the content.
>
> No, it's not published yet; I'll send you a copy off-list :)

In case anyone else is interested, the paper is now on Arxiv:
https://arxiv.org/abs/2606.02057

-Toke

