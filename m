Return-Path: <netdev+bounces-289378-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHHYOGk1DGoKaAUAu9opvQ
	(envelope-from <netdev+bounces-289378-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:03:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B30C57BD24
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 991463034402
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D41246AF04;
	Tue, 19 May 2026 09:57:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429C43D8103;
	Tue, 19 May 2026 09:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184659; cv=none; b=jkcb4+TJ7HG8Qtr+nmVGCSuu0TNfcWCe5YzmN9rH9KhTz65bAikkI/cvVnwAS+Q29AoH9jPtCYSIndylemcbfQtJIXoiXKuGBI6Unefb+8qqR7OUEWl3AE19iPiGrDmoStfW7r6fPYbqRxnKNjcRVKfYUPdZPdvp5ElU9T5vHMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184659; c=relaxed/simple;
	bh=ao5yktV3VAW0NwfNu4akMcKARIkpwyiF0BaqE2LX4lQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WBDTdSsor/dFLLzC7Ge2EF62u3oCorSEtCjq1fMvL8ezKlBZAjPieNgXew5loOjp1OFt8IyJERhYkjsKTxpXO1h40oyaxv2Y6dsONrGXErupGb+KrJmXbiAy7dHB0S7tBBjWAFVMAcZ9kKyiQVCCg8mamAWth3gqswpzzrUx/uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Authentication-Results: mail.toke.dk; dkim=none
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
In-Reply-To: <CAL+tcoA_VBcXu_2zVXFvsWF7+U=-TZf7bCz0KzNpN=p=82tB=w@mail.gmail.com>
References: <20260518082344.96647-1-kerneljasonxing@gmail.com>
 <20260518082344.96647-6-kerneljasonxing@gmail.com>
 <f9606d4b-7ff7-479f-8e73-2e8cc77095fa@kernel.org>
 <CAL+tcoDRSpVsiCym+DYsGLBGrdEuim7AZqyBTHYzd-OSBki5-Q@mail.gmail.com>
 <2942dd24-3b6f-4e88-acb2-67d35ea8938b@kernel.org>
 <CAL+tcoCO7Op69K6w9fNX5BohHoafU3C1r62=J1djTMdc30nhFQ@mail.gmail.com>
 <CAL+tcoA_VBcXu_2zVXFvsWF7+U=-TZf7bCz0KzNpN=p=82tB=w@mail.gmail.com>
Date: Tue, 19 May 2026 11:57:26 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87lddfn2m1.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [2.60 / 15.00];
	DMARC_POLICY_REJECT(2.00)[toke.dk : SPF not aligned (relaxed), No valid DKIM,reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.56)[subject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289378-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,gmail.com,fomichev.me,kau.se,vger.kernel.org,tencent.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@toke.dk,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lpc.events:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,diva-portal.org:url,doi.org:url,kau.se:email]
X-Rspamd-Queue-Id: 8B30C57BD24
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jason Xing <kerneljasonxing@gmail.com> writes:

> On Tue, May 19, 2026 at 7:16=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
>>
>> On Tue, May 19, 2026 at 12:40=E2=80=AFAM Jesper Dangaard Brouer <hawk@ke=
rnel.org> wrote:
>> >
>> >
>> >
>> > On 18/05/2026 15.53, Jason Xing wrote:
>> > > On Mon, May 18, 2026 at 9:01=E2=80=AFPM Jesper Dangaard Brouer <hawk=
@kernel.org> wrote:
>> > >>
>> > >>
>> > >>
>> > >> On 18/05/2026 10.23, Jason Xing wrote:
>> > >>> From: Jason Xing <kernelxing@tencent.com>
>> > >>>
>> > >>> Add two if statements to accurately isolate bpf timestamping and so
>> > >>> timestamping. They can work respectively.
>> > >>>
>> > >>> As to so_timestamping, only add a loose condition via report flags
>> > >>> to avoid duplicate strict checks that is done in tcp_recv_timestam=
p()
>> > >>> and performance impact. If the loose condition is hit,
>> > >>> tcp_recv_timestamp() is able to handle the exact case and doesn't
>> > >>> hamper the existing timestamping feature.
>> > >>>
>> > >>> Make it work in TCP protocol.
>> > >>>
>> > >>> Signed-off-by: Jason Xing <kernelxing@tencent.com>
>> > >>> ---
>> > >>>    net/ipv4/tcp.c | 14 ++++++++++++--
>> > >>>    1 file changed, 12 insertions(+), 2 deletions(-)
>> > >>>
>> > >>> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
>> > >>> index 21ece4c71612..64c69bb3578a 100644
>> > >>> --- a/net/ipv4/tcp.c
>> > >>> +++ b/net/ipv4/tcp.c
>> > >>> @@ -2949,8 +2949,18 @@ int tcp_recvmsg(struct sock *sk, struct msg=
hdr *msg, size_t len, int flags)
>> > >>>        release_sock(sk);
>> > >>>
>> > >>>        if ((cmsg_flags | msg->msg_get_inq) && ret >=3D 0) {
>> > >>> -             if (cmsg_flags & TCP_CMSG_TS)
>> > >>> -                     tcp_recv_timestamp(msg, sk, &tss);
>> > >>> +             if (cmsg_flags & TCP_CMSG_TS) {
>> > >>> +                     u32 tsflags =3D READ_ONCE(sk->sk_tsflags);
>> > >>> +
>> > >>> +                     if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
>> > >>> +                         SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_RX_TIM=
ESTAMPING))
>> > >>> +                             bpf_skops_rx_timestamping(sk, &tss,
>> > >>> +                                                       BPF_SOCK_O=
PS_TSTAMP_RCV_CB);
>> > >>
>> > >> Does this mean I can enable timestamp reading per cgroup?
>> > >
>> > > Yes, I think so, but I didn't try. One of the natures of sockopt
>> > > feature is supporting cgroup attach.
>> > > cgroup_bpf_prog_attach()/cgroup_bpf_link_attach() is probably
>> > > something that you're looking for.
>> > >
>> >
>> > Sound good
>> >
>> > > IIUC, you can attach the prog onto the cgroup where all the sockets
>> > > are set using the bpf timestamping function. So the current impl is
>> > > cleaner and has better isolation (to filter out those unmatched
>> > > flows).
>> > >
>> > >>
>> > >> In Simon's netstacklat[1] tool we are forced process all RX timesta=
mp
>> > >> (hooking fentry/tcp_recv_timestamp), and then we have a BPF filter[=
2] on
>> > >> the cgroup IDs that we are interested in (which is a significant
>> > >> overhead, as this is deployed at Cloudflare production scale).
>> > >
>> > > I can feel the pain when filtering in this kind of relatively hot
>> > > path, which is what I'm trying to avoid internally. What I've done in
>> > > production (to cover those old kernels) is to just let the kernel
>> > > print the information, that's it, and there is an agent continuously
>> > > gathering the data, doing the match and computing latency. But it's
>> > > overall complicated.
>> > >
>> >
>> > I hope you don't mean your internal/old approach was using printk and
>> > then analyzing this data.
>>
>> Of course not :)
>>
>> The internal approach is to cover the old kernels but doesn't mean the
>> approach is old :P
>>
>> Instead, the internal kernel module is super efficient and I'm trying
>> to ship bpf with such an ability. The fact is we've already deployed
>> in production: 7x24 running, zero sampling.
>>
>> Please see page 24 where there is a brief introduction on how to deal
>> with the log part:
>> https://lpc.events/event/19/contributions/2055/#preview:3846
>> I believe this is the promising direction (ring buffer + lightweight
>> kernel + heavy agent) we're taking.
>>
>> The headache part is that I need to provide an agent written in BPF to
>> do the heavy process.
>>
>> >
>> > > Many thanks here, I'm always interested in hearing more useful and
>> > > real requirements and fancy ideas on how to monitor the latency :) N=
ow
>> >
>> > Simon Sundberg <Simon.Sundberg@kau.se> have many more fancy ideas on h=
ow
>> > to monitor the latency.
>> > The netstacklat tool is part of Simon's PhD thesis:
>> > - https://doi.org/10.59217/qklv6836
>> >
>> > And we even gotten a paper accepted on netstacklat:
>> > -
>> > https://kau.diva-portal.org/smash/record.jsf?pid=3Ddiva2%3A2034009&dsw=
id=3D3032
>>
>> Sorry, I cannot access this link. Could you give me the title of this pa=
per?
>
> Waiting at the Front Door - Continuous Monitoring of Latency in the
> Host Network Stack
>
> Oh, I guess it hasn't been officially published right? This is the
> reason why I have no way to know the content.

No, it's not published yet; I'll send you a copy off-list :)

-Toke

