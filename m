Return-Path: <netdev+bounces-292437-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IgbLEJKF2r0/wcAu9opvQ
	(envelope-from <netdev+bounces-292437-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 21:47:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 489765E99E9
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 21:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 013FE30210F9
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 19:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06E33B0AE9;
	Wed, 27 May 2026 19:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NFmxSNmY"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC8530CD82
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 19:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911228; cv=none; b=aYhKNKKAfQ/iyKQ22BoGvGX0aU5/tdzHRvVdVKqR+DZxgGPv2pSI8POCcotjbBJeIOFsJVCne75LEXq5TZBR3yie5XBiA1p1WWUyvNg8uW9hr1fDbbP4D9jEI4I0Wx+OmwNZa53XespOdzX02bplFkXF4yhboSJgkimA6/yizN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911228; c=relaxed/simple;
	bh=nN0W4IgzisQvg4h2urXlOh1tScjeO3jHY/naFP2zIJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2moCu+7eH5NUGbl1NCyZ1hSRcZR68qCXRufYrIoKN7vDixoj3+ulojVkoflbTziWqO3rk67u8GGtS76smLD5ymE7pQXrrXhIBipxc9mm+ODziRBsEmrzUydX4Io2KGlpI63GwZXkHl/3AcTCRSStqXy+SXTa0K4wsj8VBHVBy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NFmxSNmY; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 27 May 2026 12:46:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779911223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fLSQHjT20+LiCHPgqnD2jE1WT55KzpuEKobPVOEpYCE=;
	b=NFmxSNmYeC2eTCyqjySAupnvzmOXB04IjJ6ChNPnF94nMG1v7vLPkZQkVX8mJDCvA8dG7p
	77mIFMei8i5bIxXue9h99bLgGaxy0wFyo9qxvY0pa1Si6BbdvOCrJK0bA7NBqxLDSjcQL3
	q54owQWsydjS9Fjl2LHOmGhS5kVHBGk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Tenzin Ukyab <ukyab@berkeley.edu>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 bpf-next 03/11] bpf: tcp: Support bpf_skb_load_bytes()
 for BPF_SOCK_OPS_RCVQ_CB.
Message-ID: <2026527192229.olv9.martin.lau@linux.dev>
References: <20260523083001.2911931-1-kuniyu@google.com>
 <20260523083001.2911931-4-kuniyu@google.com>
 <202652620632.prOx.martin.lau@linux.dev>
 <CAAVpQUA0UNhR8AWfd0WC-krYJeXb0ebNs-V4u9kgweyNw_XHtg@mail.gmail.com>
 <2026526214538.Vhly.martin.lau@linux.dev>
 <CAL+tcoCSU9KFZsV33LE2R89iUzb5b3Xm+h6QObs5GOuRYR3sMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoCSU9KFZsV33LE2R89iUzb5b3Xm+h6QObs5GOuRYR3sMQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292437-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,berkeley.edu,vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:email,linux.dev:mid,linux.dev:dkim,bpf_sock_ops.data:url]
X-Rspamd-Queue-Id: 489765E99E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 12:01:11PM +0800, Jason Xing wrote:
> On Wed, May 27, 2026 at 6:19 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
> >
> > On Tue, May 26, 2026 at 02:21:56PM -0700, Kuniyuki Iwashima wrote:
> > > On Tue, May 26, 2026 at 1:34 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
> > > >
> > > > On Sat, May 23, 2026 at 08:29:32AM +0000, Kuniyuki Iwashima wrote:
> > > > > When a TCP skb is queued to sk->sk_receive_queue, BPF SOCK_OPS
> > > > > prog can be called with BPF_SOCK_OPS_RCVQ_CB.
> > > > >
> > > > > In this hook, we want to parse the RPC descriptor in the skb
> > > > > and adjust sk->sk_rcvlowat based on the RPC frame size.
> > > > >
> > > > > However, we cannot access payload via bpf_sock_ops.data on
> > > > > modern NICs with TCP header/data split on as the payload is
> > > > > not placed in the linear area.
> > > > >
> > > > > Let's support bpf_skb_load_bytes() for BPF_SOCK_OPS_RCVQ_CB.
> > > > >
> > > > > Three notes:
> > > > >
> > > > >   1) bpf_sock_ops_kern.skb will be NULL when the BPF prog is
> > > > >       invoked from recvmsg().
> > > > >
> > > > >   2) Access to bpf_sock_ops.data will be disabled by passing
> > > > >       0 end_offset to bpf_skops_init_skb().
> > > > >
> > > > >   3) ____bpf_skb_load_bytes() is called directly instead of
> > > > >      __bpf_skb_load_bytes() to allow compilers to inline it
> > > > >      instead of generating a tail-call.
> > > >
> > > > Some observations below.
> > > >
> > > > >
> > > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > > > ---
> > > > > v2: Explain why using ____ version instead of __
> > > > > ---
> > > > >  net/core/filter.c | 34 ++++++++++++++++++++++++++++++++++
> > > > >  1 file changed, 34 insertions(+)
> > > > >
> > > > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > > > index 4a50fe2cd863..fa8a7c7d86eb 100644
> > > > > --- a/net/core/filter.c
> > > > > +++ b/net/core/filter.c
> > > > > @@ -7760,6 +7760,38 @@ static const struct bpf_func_proto bpf_sk_assign_proto = {
> > > > >       .arg3_type      = ARG_ANYTHING,
> > > > >  };
> > > > >
> > > > > +BPF_CALL_4(bpf_sock_ops_skb_load_bytes, struct bpf_sock_ops_kern *, bpf_sock,
> > > > > +        u32, offset, void *, to, u32, len)
> > > > > +{
> > > > > +     int err;
> > > > > +
> > > > > +     if (bpf_sock->op != BPF_SOCK_OPS_RCVQ_CB) {
> > > >
> > > > bpf_dynptr_from_skb() and bpf_dynptr_slice() kfunc could also be considered.
> > > > One less bpf_sock->op check in filter.c to maintain and could also avoid
> > > > a data copy. There is a bpf_cast_to_kern_ctx() to get to a trusted
> > > > skops_kern pointer but this will need changes in verifier.c to get to
> > > > skops_kern->skb (e.g. in type_is_trusted_or_null) and this is the tradeoff.
> > >
> > > Maybe a dumb question, but does it add extra cost (extra dynptr
> > > function call?) if data overlaps two frags, or can dynptr handle it
> > > seamlessly with a single bpf_dynptr_slice() ?
> >
> > Right, there is an extra bpf_dynptr_from_skb(). I don't think we have
> > benchmarked it.
> >
> > If I read it correctly, unlike bpf_xdp_pointer, the skb_header_pointer
> > will still copy even if the data is in one frag. It works well if the data
> > is in the headlen and the worst case is to copy, which is the same as
> > load_bytes.
> >
> > It is a readonly use case. Maybe the bpf prog can directly read the frag.
> > Regardless, it is useful to have a kfunc/helper to read it.
> >
> > >
> > > In our case, the data copy is ~16 bytes, so the cost will not be
> > > a big problem I think.
> > >
> > >
> > > >
> > > > If this new rcvq callback is added to the 'bpf_tcp_ops' proposal [1],
> > > > all this will go away. 'struct sk_buff *skb' can be directly passed to an
> > > > ops of the 'bpf_tcp_ops'. Supporting '*skb' in a struct_ops has already
> > > > been done in the bpf_qdisc.
> > > >
> > > > [1]: https://lore.kernel.org/bpf/20260519215841.2984970-11-martin.lau@linux.dev/
> > >
> > > Oh I missed the series, the struct_ops conversion looks nice !
> > > Since this work isn't urgent, I can wait for your series if mine
> > > churns it.
> > >
> > > Jason's series is adding a new op, and I guess this can be
> > > integrated too ?
> > > https://lore.kernel.org/bpf/20260521135244.40869-5-kerneljasonxing@gmail.com/
> >
> > imo, a new sock_ops cb should be added as an ops in struct_ops. For example,
> > in patch 4 of that series, bpf_skops_rx_timestamping assigns u64 to 'u32
> > args[4]', which is adding tech debt to the current sock_ops interface.
> > For the timestamping case, it could be a separate ops for the
> > 'struct sock' instead of 'struct tcp_sock' because it should
> > at least work for both TCP and UDP.
> 
> Sorry, I don't get it. What is the tech debt in this? And
> bpf_skops_rx_timestamping() only outputs the timestamps, which has
> nothing to do with either 'sock' or 'tcp_sock'.

Did I say the tech debt is in bpf_skops_rx_timestamping?
I said the tech debt of the bpf_sock_ops[_kern] interface.
Besides always memzero the whole &sockops, the way that the bpf prog
needs to get a u64 timestamp from u32 is not thrilling in 2026.
args[4] is also not reliable when the earlier cgroup bpf prog
writes to replylong. We had already hit some of these in our rx net
timestamping discussion a few years ago. I suggest you go back
and revisit.

> 
> Could you show me what to do next? Thanks in advance. It sounds like
> the tx side of bpf timestamping should be adjusted accordingly?

imo, the bpf_tcp_ops can land first. and then add net timestamping
ops (existing tx and the new rx) in bpf_sock_ops.

