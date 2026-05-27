Return-Path: <netdev+bounces-292440-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPpULjJMF2r7AAgAu9opvQ
	(envelope-from <netdev+bounces-292440-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 21:55:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B36E25E9C72
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 21:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 07ED33059749
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 19:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC443B19DB;
	Wed, 27 May 2026 19:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tHo2OWCW"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01863B0AF8
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 19:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911578; cv=none; b=jrmShKfeJhDTq0I9vIZKwCND8PQXhrWuOR3w3z6MHXuLKrXUh3PKOT1SnQHRsfTELR606b+oopH605gj7kcBtV0H817A3DEsP5Li/rGRud2NGKO2UypLAlkabP7SQb7M37IeD1oy+hrCaUZ2wjcozOA3u3gUjdQxB+NeiLk/qu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911578; c=relaxed/simple;
	bh=ESpWEv8U7i/rwZrk159PCTa8esnF553wJdOucCIE2xI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bi1e8gAqpmzTSvxWLqfezjBdMmpZA2MHwHR9NVYenJT1DozLHPSyb5vfx3h2+ad6jtRysHyXBUW+BlAXE88dK1ndONyx94UCYjryrtRwk++9pfo5Akg1EYLe2h+ELAbIWNG1LoR82jGop0cN2vaZRJ6nBcQh/zfIZN0QgFn4nVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tHo2OWCW; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 27 May 2026 12:52:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779911574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LrC/E5OOEeBssNuQEBba+PXsRMzs7+0VDFGOMKZnl4c=;
	b=tHo2OWCWF9KY921Ly0Tx/o/TqLfAdgZ8WGqi8CJxjSDuHfRRK2GmbhH1Udzewbv7EHX1k5
	/9ehA64Ire+BJpPmSaf5RrS4uJRcus261bYuTxvZcWS8D0RVLlVvs2FQrQcq2hk0MS0mpX
	/x//OtHMdsV2exINFT61dby6S7MqONQ=
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
Message-ID: <202652719515.aUpT.martin.lau@linux.dev>
References: <20260523083001.2911931-1-kuniyu@google.com>
 <20260523083001.2911931-4-kuniyu@google.com>
 <202652620632.prOx.martin.lau@linux.dev>
 <CAAVpQUA0UNhR8AWfd0WC-krYJeXb0ebNs-V4u9kgweyNw_XHtg@mail.gmail.com>
 <2026526214538.Vhly.martin.lau@linux.dev>
 <CAL+tcoCSU9KFZsV33LE2R89iUzb5b3Xm+h6QObs5GOuRYR3sMQ@mail.gmail.com>
 <2026527192229.olv9.martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026527192229.olv9.martin.lau@linux.dev>
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
	TAGGED_FROM(0.00)[bounces-292440-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B36E25E9C72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 12:46:25PM -0700, Martin KaFai Lau wrote:
> > > > > If this new rcvq callback is added to the 'bpf_tcp_ops' proposal [1],
> > > > > all this will go away. 'struct sk_buff *skb' can be directly passed to an
> > > > > ops of the 'bpf_tcp_ops'. Supporting '*skb' in a struct_ops has already
> > > > > been done in the bpf_qdisc.
> > > > >
> > > > > [1]: https://lore.kernel.org/bpf/20260519215841.2984970-11-martin.lau@linux.dev/
> > > >
> > > > Oh I missed the series, the struct_ops conversion looks nice !
> > > > Since this work isn't urgent, I can wait for your series if mine
> > > > churns it.
> > > >
> > > > Jason's series is adding a new op, and I guess this can be
> > > > integrated too ?
> > > > https://lore.kernel.org/bpf/20260521135244.40869-5-kerneljasonxing@gmail.com/
> > >
> > > imo, a new sock_ops cb should be added as an ops in struct_ops. For example,
> > > in patch 4 of that series, bpf_skops_rx_timestamping assigns u64 to 'u32
> > > args[4]', which is adding tech debt to the current sock_ops interface.
> > > For the timestamping case, it could be a separate ops for the
> > > 'struct sock' instead of 'struct tcp_sock' because it should
> > > at least work for both TCP and UDP.
> > 
> > Sorry, I don't get it. What is the tech debt in this? And
> > bpf_skops_rx_timestamping() only outputs the timestamps, which has
> > nothing to do with either 'sock' or 'tcp_sock'.
> 
> Did I say the tech debt is in bpf_skops_rx_timestamping?
> I said the tech debt of the bpf_sock_ops[_kern] interface.
> Besides always memzero the whole &sockops, the way that the bpf prog
> needs to get a u64 timestamp from u32 is not thrilling in 2026.
> args[4] is also not reliable when the earlier cgroup bpf prog
> writes to replylong. We had already hit some of these in our rx net
> timestamping discussion a few years ago. I suggest you go back
> and revisit.
> 
> > 
> > Could you show me what to do next? Thanks in advance. It sounds like
> > the tx side of bpf timestamping should be adjusted accordingly?
> 
> imo, the bpf_tcp_ops can land first. and then add net timestamping
> ops (existing tx and the new rx) in bpf_sock_ops.
To be clear, for bpf_sock_ops, I meant a struct_ops named bpf_sock_ops (or
another better name).

