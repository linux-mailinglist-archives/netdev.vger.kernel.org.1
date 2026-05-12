Return-Path: <netdev+bounces-287263-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDqKAHlyA2q55wEAu9opvQ
	(envelope-from <netdev+bounces-287263-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 20:33:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C53527C18
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 20:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60930311D9A2
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 18:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0E0342501;
	Tue, 12 May 2026 18:15:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A973347BD7
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 18:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609711; cv=none; b=ANp7isC0SeuLttaz+T9q0NkJgk8Pqepck2z7KunbQ9xkM1x/y3Nj0Q1BvOnKpubFBY0/xzZlED5ws5ASIJ61t0KeHBrxIrLSJKG+qzJtxuthqD9UupvVzXJFF89YGoYCTcdiHKSRULVT1DaEhKvPQLONXQ4FQztL3OXa8y3E2r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609711; c=relaxed/simple;
	bh=n0M1zWhAHwdov0qZD9ENe2g/uOz7BS14QwSf0KHETDg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WDPC6sn4aHsTjIVOPMsuvyeZlD5mrAHdLcwrzWqeW9HDpGVrY6JpCV8intKRgoK8MgtqP4UZAcp7fYH8wnbf22LmnzGSuGxzEr07E1Bf5BXgpmS/6l8/U3/grAQpEU6jdoHKT/9aflWCTtuwYZ62MIv4I87ukMmo0Vg+Vcr9/CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Authentication-Results: mail.toke.dk; dkim=none
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko
 <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 2/2] net/sched: fq_codel: local packets no
 longer count against memory limit
In-Reply-To: <CANn89i+0mw1MRXaWiDfMr1j4dYgot54roxFs8gTMCQYRQVUz9g@mail.gmail.com>
References: <20260512094859.3673997-1-edumazet@google.com>
 <20260512094859.3673997-3-edumazet@google.com> <87o6ikygiz.fsf@toke.dk>
 <CANn89i+0mw1MRXaWiDfMr1j4dYgot54roxFs8gTMCQYRQVUz9g@mail.gmail.com>
Date: Tue, 12 May 2026 20:15:06 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87fr3wxzo5.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 66C53527C18
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[toke.dk : SPF not aligned (relaxed), No valid DKIM,reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-287263-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[toke@toke.dk,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,toke.dk:email,toke.dk:mid]
X-Rspamd-Action: no action

Eric Dumazet <edumazet@google.com> writes:

> On Tue, May 12, 2026 at 5:11=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@toke.dk> wrote:
>>
>> Eric Dumazet <edumazet@google.com> writes:
>>
>> > Commit 95b58430abe7 ("fq_codel: add memory limitation per queue")
>> > claimed that the 32Mb default was "reasonable even for heavy duty usag=
es."
>> >
>> > In practice, this is not the case.
>>
>> Well, the assumption lasted a decade, so that's pretty good? :)
>>
>> > Packets that are associated with local sockets sk_wmem_alloc
>> > do not really need additional memory control.
>> >
>> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>> > ---
>> >  net/sched/sch_fq_codel.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
>> > index 1b1de693d4c64a1f5f4e9e788371829dea91740e..71107dc52be799a14f370f=
2ad74d2eadd93992c1 100644
>> > --- a/net/sched/sch_fq_codel.c
>> > +++ b/net/sched/sch_fq_codel.c
>> > @@ -212,7 +212,7 @@ static int fq_codel_enqueue(struct sk_buff *skb, s=
truct Qdisc *sch,
>> >               q->new_flow_count++;
>> >               WRITE_ONCE(flow->deficit, q->quantum);
>> >       }
>> > -     get_codel_cb(skb)->mem_usage =3D skb->truesize;
>> > +     get_codel_cb(skb)->mem_usage =3D is_skb_wmem(skb) ? 0 : skb->tru=
esize;
>> >       q->memory_usage +=3D get_codel_cb(skb)->mem_usage;
>>
>> Only one concern here: q->memory_usage is exposed to userspace in the
>> stats, so this will look like the packets queued are zero-length to
>> anyone watching, which may end up confusing folks? Also, there will be
>> no way to see how many bytes are actually in the qdisc.
>
> Standard qdisc stats show the amount of bytes and packets.
>
> None of the other qdiscs seem to care (except cake which copy/pasted fq_c=
odel)

Right, the cake stats was why I asked. Pretty sure there are people who
watch these; but now that you mention it, I may have confused the
standard backlog_bytes stat field with this one...

>> Should we keep a separate counter so we can still accurately report the
>> memory usage to userspace?
>
> Only purpose of mem usage counter was to have an idea of how close of
> the 32Mb limit we were, this is still reported for forwarded packets
> (router workload)
>
> All these counters take precious resources, I would rather not add anothe=
r one.

Right, fair (and see above). In that case:

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>


