Return-Path: <netdev+bounces-276161-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ExnE5B01WmB6gcAu9opvQ
	(envelope-from <netdev+bounces-276161-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 23:18:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC393B4F16
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 23:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 594003017797
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 21:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDB837C11E;
	Tue,  7 Apr 2026 21:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anmw335a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2074D37BE73
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 21:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775596665; cv=none; b=SJpfH3V7x2uujFlnLr0z3dKRxdkJXTqsJ2yXxh4CchvyeAUDLa6HahjGYggD2JzJoGHBhzmylPsVcvKUD676qNJ5xHDOmSN4cUsC5C/Kjw/MY8rLjsgcMuAhH7i86hApdjcB1+UBV8rZny3FzQyBZqh4y2PBCIkMTRSm4VvpJK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775596665; c=relaxed/simple;
	bh=1sh2NGYQU03vEzmL1TUWOQsRQHZWpIKmamfl5BAH09U=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=uo+iE9MvTk4zCvlEMs4PzMXKJ5MoOR6v5zPa3MpfXX7ayWZ78gIj0Q1KiLcso3WDvKEBfgX4dF1YB5+2PHXEpL6fL1d9VOF028/jFFLQhkh6ysM/7SandI9A+PD3QKH4zTSoqVhp7fzxa8ye2MJjKWdGxnKMlyJtEP76So2XnA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anmw335a; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-794719afcd4so55156257b3.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 14:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775596663; x=1776201463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKu3oCaf2WwdcProg7tdSrWrUg7SBS7cgEVQLN3Mfqs=;
        b=anmw335adC7RDuTAUUq8OWIPiSs/ntp/wdyKn/WcZuT5Gh56z+NWgXzGhCbYliXgP1
         tPXnsgvI2YnNvKMKlQUbnR/srZ3PmtIPXL/RW20AiZuaTj23iQAYnMTv5yZQKrE7uQWO
         hi5WwNoD5NdBqXcHU/X9qoOMm8FpQj7lirYxdTtt7d3hkXIjBUS+rqj/YK7Firs2h2fw
         dQYFBS3AB39F5+RmHtMGUxnRkDRRcA3h+2dtQYL87oin4qTYPxv9HULJ71BYo4+dy4pA
         02vazJ9nbSYA21NliVeReYVf2sVjVy/1LlQG+l5olnLit0PrNVjIK0yebBDPIC8dUbxA
         CDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775596663; x=1776201463;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rKu3oCaf2WwdcProg7tdSrWrUg7SBS7cgEVQLN3Mfqs=;
        b=NxN32t2nQd4q2s/FeL1xaHuzpSRpHXD9yIzXQV2TCb5IdjJcg3/52zWlT/ZS0QDRp4
         JnyGGWQBAEdLvDgC+ldM1OnokUP9ketx4kivj1xat3PcLiBUZzYTUOoKyMuaxl7hY1Un
         2JWW2tQlDgcxWXsEjDOHea2MWVUsxXJWSmcdHmVRkiu6ykrwfhUbcmsxGRbwIRUUT2Or
         XaOXd79EQzJnIWJqj/3rmQlKvflnULPkwWw0clGp+6wK/C+gA2kbbRfEf7vobs1wSF7G
         UWt5kwKuxSVmz/aQly2MYnPw+DuGX7WVglgNv36ffSVjs++IIFyJzjqcEszYxQ2BtJ1a
         PSYA==
X-Forwarded-Encrypted: i=1; AJvYcCUFbQpNIMRzJb2y9147HJqxaDV0ZznQYQbGMdz8N2bNu81ygb5n901hywko1wSPDt1OTLvw7Yg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf14c3SzWRXMixJydMu+6V0eqohChQgTmxd+q31zudUSFfH7X2
	af8VDanIcCno+7kvtkd6ls5sSiHM0R0BMwXI8VkCvhhUbu/GIkYGVXuz
X-Gm-Gg: AeBDiev6AOy05jusISxcFlcAHMSD+Bqxd0xKlPl+zQJBrge/3wjpvWGxAX3AqvVYwai
	EALyw62GmI3i8XiAbspBLCOrDJFQ3z5h9aESsLuFf6RDH+3A8zP9JCIze3X8jmkW9QFtE92B7Tk
	gdGy1Pvt77zBPKsGcszEPWnk9X3vJV5KhYnnn3RUG/pFA3FXA26/1/DqD2CRF3rAjyCXW/IHhcN
	HnrOLe2UGZXemxOs36Ie2ks+orMicAG3GDkLp5l2+g0sdGhvOUX7ke2maNIwCNvd8skSLicvAT7
	YNnWkLLflfLTk0loYOk/w+RTF7n1QVR1dKmlvzlMOn4zusZXFDOa+QMdFjiq5R6+Nq+bVglPFQX
	QBftJg80xqNnWKF5cHK1OOduXtVVY7dYK5JXwclZdQ/iuZ0puj+EjXGrDCpuFl4SZQSe3AOv/aN
	HbAefaIU51EeKOcGDrmjAJO9XwEHmq3QuJljQ9qE6yRkGhm+wKrQIy1BDHVvFnexVrQwvUgkSj1
	T1tXGut2p39s6g=
X-Received: by 2002:a05:690c:9:b0:79f:3b8c:a808 with SMTP id 00721157ae682-7a4d536f72amr194223127b3.30.1775596662904;
        Tue, 07 Apr 2026 14:17:42 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36e8329dbsm75916667b3.15.2026.04.07.14.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 14:17:42 -0700 (PDT)
Date: Tue, 07 Apr 2026 17:17:41 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 willemb@google.com, 
 martin.lau@kernel.org, 
 netdev@vger.kernel.org, 
 bpf@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>, 
 Yushan Zhou <katrinzhou@tencent.com>
Message-ID: <willemdebruijn.kernel.1b49845d3acc7@gmail.com>
In-Reply-To: <CAL+tcoCctfs=d9zz5ei1S999S94HmUDSToriZ8NJiLT8MmpQTA@mail.gmail.com>
References: <20260404150452.83904-1-kerneljasonxing@gmail.com>
 <20260404150452.83904-4-kerneljasonxing@gmail.com>
 <willemdebruijn.kernel.2ff565d2f9e7f@gmail.com>
 <CAL+tcoB94=ptFB-acU3nAK_MqW74DV0MQUVvvV3nbQ7Zc6zSZw@mail.gmail.com>
 <willemdebruijn.kernel.27ec47b22b23c@gmail.com>
 <CAL+tcoAvVBN7juJEBt5-FYQ4eGTe7dYrFbR3CMOwguw=_X=btA@mail.gmail.com>
 <CAL+tcoCctfs=d9zz5ei1S999S94HmUDSToriZ8NJiLT8MmpQTA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/4] bpf-timestamp: keep track of the skb when
 wait_for_space occurs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276161-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tencent.com:email]
X-Rspamd-Queue-Id: ADC393B4F16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jason Xing wrote:
> On Tue, Apr 7, 2026 at 11:33=E2=80=AFAM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> >
> > On Mon, Apr 6, 2026 at 10:37=E2=80=AFPM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jason Xing wrote:
> > > > On Mon, Apr 6, 2026 at 10:28=E2=80=AFAM Willem de Bruijn
> > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > >
> > > > > Jason Xing wrote:
> > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > >
> > > > > > The patch is the 1/2 part of push-level granularity feature.
> > > > > >
> > > > > > Tag the skb in tcp_sendmsg_locked() when wait_for_space occur=
s even
> > > > > > though it might not carry the last byte of the sendmsg.
> > > > > >
> > > > > > Prior to the patch, BPF timestamping cannot cover this case:
> > > > > > The following steps reproduce this:
> > > > > > 1) skb A is the current last skb before entering wait_for_spa=
ce process
> > > > > > 2) tcp_push() pushes A without any tag
> > > > > > 3) A is transmitted from TCP to driver without putting any sk=
b carrying
> > > > > >    timestamps in the error queue, like SCHED, DRV/HARDWARE.
> > > > > > 4) sk_stream_wait_memory() sleeps for a while and then return=
s with an
> > > > > >    error code. Note that the socket lock is released.
> > > > > > 5) skb A finally gets acked and removed from the rtx queue.
> > > > > > 6) continue with the rest of tcp_sendmsg_locked(): it will ju=
mp to(goto)
> > > > > >    'do_error' label and then 'out' label.
> > > > > > 7) at this moment, skb A turns out to be the last one in this=
 send
> > > > > >    syscall, and miss the following tcp_bpf_tx_timestamp() opp=
ortunity
> > > > > >    before the final tcp_push()
> > > > > > 8) BPF script fails to see any timestamps this time
> > > > > >
> > > > > > Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
> > > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > > ---
> > > > > >  net/ipv4/tcp.c | 4 +++-
> > > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > > > > index c603b90057f6..7d030a11d004 100644
> > > > > > --- a/net/ipv4/tcp.c
> > > > > > +++ b/net/ipv4/tcp.c
> > > > > > @@ -1400,9 +1400,11 @@ int tcp_sendmsg_locked(struct sock *sk=
, struct msghdr *msg, size_t size)
> > > > > >  wait_for_space:
> > > > > >               set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
> > > > > >               tcp_remove_empty_skb(sk);
> > > > > > -             if (copied)
> > > > > > +             if (copied) {
> > > > > > +                     tcp_bpf_tx_timestamp(sk);
> > > > > >                       tcp_push(sk, flags & ~MSG_MORE, mss_now=
,
> > > > > >                                TCP_NAGLE_PUSH, size_goal);
> > > > >
> > > > > Now the number of skbs that will be tracked will be unpredictab=
le,
> > > > > varying based on memory pressure.
> > > >
> > > > Right, I put some effort into writing a selftests to check how ma=
ny
> > > > push functions get called at one time and failed to do so.
> > > >
> > > > >
> > > > > That sounds hard to use to me. Especially if these extra pushes=

> > > > > cannot be identified as such.
> > > > >
> > > > > Perhaps if all skbs from the same sendmsg call can be identifie=
d,
> > > > > that would help explain pattern in data resulting from these
> > > > > uncommon extra data points.
> > > >
> > > > You meant move tcp_bpf_tx_timestamp before tcp_skb_entail()? That=
 is
> > > > close to packet basis without considering fragmentation of skb :)=

> > >
> > > No, I meant somehow in the notification having a way to identify al=
l
> > > the skbs belonging to the same sendmsg call, to allow filtering on
> > > that. But I also don't immediately see how to do that (without addi=
ng
> > > yet another counter say).
> >
> > If we don't build the relationship between skb and sendmsg (just like=

> > the SENDMSG sock option), we will have no clue on how to calculate. I=
f
> > we only take care of the skb from the view of the syscall layer, it's=

> > fine by moving tcp_bpf_tx_timestamp() before tcp_skb_entail(). But in=

> > terms of per skb even generated beneath TCP due to gso/tso, there is
> > only one way to correlate: adding an additional member in the skb
> > structure to store its sendmsg time. This discussion is only suitable=

> > for use cases like net_timestamping.
> >
> > Well, my key point is that, I have to admit, the above (including
> > existing bpf script net_timestamping) is a less effective way which
> > definitely harms the performance because of the extremely frequent
> > look-up process. It's not suitable for 7x24 observability in
> > production. What we've done internally is make the kernel layer as
> > lightweight/easy as possible and let the timestamping feature throw
> > each record into a ring buffer that the application can read, sort an=
d
> > calculate. This arch survives the performance. But that's simply what=

> > the design of the kernel module is, given the fast deployment in
> > production. I suppose in the future we could build a userspace tool
> > like blktrace to monitor efficiently instead of the selftest sample.
> > Honestly I don't like look-up action.
> >
> > Since we're modifying the kernel, how about adding a new member to
> > record sendmsg time which bpf script is able to read. The whole
> > scenario looks like this:
> > 1) in tcp_sendmsg_locked(), record the sendmsg time for each skb
> > 2) in either tso_fragment() or tcp_gso_tstamp(), each new skb will ge=
t
> > a copy of its original skb
> > 3) in each stage, bpf script reads the skb's sendmsg time and the
> > current time, and then effortlessly do the math.
> >
> > At this point, what I had in mind is we have two options:
> > 1) only handle the skb from the view of the send syscall layer, which=

> > is, for sure, very simple but not thorough.
> > 2) stick to a pure authentic packet basis, then adding a new member
> > seems inevitable. so the question would be where to add? The space of=

> > the skb structure is very precious :(
> =

> Finding a suitable place to put this timestamp is really hard. IIRC,
> we can't expand the size of struct skb_shared_info so easily since
> it's a global effect.
> =

> I'm wondering if we can turn the per-packet mode into a non-compatible
> feature by reusing 'u32 tskey' to store a microsecond timestamp of
> sendmsg.

Agreed that an extra field is hard. We should avoid that.

If the purpose is to group skbs by sendmsg call (e.g., to filter out
all but the last one), it is probably also unnecessary.

From a process PoV, since the process knows the sendmsg len and each
skb has a tskey in byte offset, it can correlate the skb with a given
sendmsg buffer.

The BPF program is under control of a third-party admin. So that does
not follow directly. But it can be passed additional metadata.

I thought about passing the offset of the skb from the start of the
sendmsg buffer to identify all consecutive skbs for a sendmsg call,
as each new buffer will start with an skb with offset 0 ..

.. but that won't work as there is no guarantee that a sendmsg call
will not append to an existing outstanding skb.

Anyway, the general idea is to pass to the BPF program through
bpf_skops_tx_timestamping some relevant signal , without having to
expand either skb or sk itself.

I hear you on that measuring every skb is too frequent. But is calling
the BPF program and letting it decide whether to measure too? BPF
program invocation itself should be cheap.

If per-push is preferable, with a filter ability like the above, it
seems more useful to me already.



