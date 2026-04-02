Return-Path: <netdev+bounces-274311-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBFLAr3HzWkLhQYAu9opvQ
	(envelope-from <netdev+bounces-274311-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 03:34:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9118138249A
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 03:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 80587303C094
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 01:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B601E885A;
	Thu,  2 Apr 2026 01:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uIDVavCa"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2FC27C162
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 01:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775093690; cv=none; b=SF3pCrgk2JJlENSyu2S1/GMYGf6uBHqFTEvpSxDVKqVy9DfXhD8NuRaEaRz/h/UpownG6U8+SUS0tACH7diEGRF1z3cjqvwVfDmFbMqsQeJIktl4/lbvNHWCI5HJa4Y+1UsnNJd7VVynJS93Jz/DtVy8yo2iouXceHEEO86D5fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775093690; c=relaxed/simple;
	bh=m297v3GiOVxkqkQKNKsn0SSm2BRnx0wYfsw0+elhHng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWLNjnsJ9A/ITNKqOmmyPdB8RoVVL/W/H6XbQfBiy6zcCm64Tq0CksJJU7O2tNQHp3i0qIrpRt2pEJ3DkK3g1EcTKfvr4T8O1O7HYcH5MfC1kIXtfzvtZ9nfkNB6eFUbSVxQ4yDWOyS4O231hxiUL4AYyJacrNxO88pp/HVwB58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uIDVavCa; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 1 Apr 2026 18:34:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775093685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QIoJDHbGUi2T/S0l/YZNFtyf9ayIGPFiBwet0GcLpco=;
	b=uIDVavCa2u2MMjx4gA75IWMWn8CnNonvE3gYY8ZwaNY/D/b8Pru3oHsGl0/dAPjD1gxyqp
	BMbIN6FIaEHgEr4rzTlUMqB5C3vy0QK/ntg/MFZzoyMAk7CdYmK2usVt4LaljM1PHjBTx+
	hgoH7PNIK2wuRPEA/6jvvMUQpjTVlLU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Michal Luczaj <mhal@rbox.co>
Cc: Jiayuan Chen <mrpre@163.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Cong Wang <cong.wang@bytedance.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v3 5/5] bpf, sockmap: Adapt for af_unix-specific lock
Message-ID: <ac2z6IqYyIxSZFPS@devbig1721.ftw5.facebook.com>
References: <20260306-unix-proto-update-null-ptr-deref-v3-0-2f0c7410c523@rbox.co>
 <20260306-unix-proto-update-null-ptr-deref-v3-5-2f0c7410c523@rbox.co>
 <2192e9ef-894f-4826-b296-4f90e973a31b@163.com>
 <b9a956dd-ebb2-47ca-8b49-ccbba6ff9b26@rbox.co>
 <b21fac4e-891b-481c-9734-e95290e49097@linux.dev>
 <fa818820-c0c9-48dc-8ebc-661cb3349935@rbox.co>
 <dd043c69-4d03-46fe-8325-8f97101435cf@linux.dev>
 <27fa6e91-02a5-46cd-8c95-b75fd2c5fa08@rbox.co>
 <ae86a1e5-769c-44d8-ad7e-ad724800e9e4@linux.dev>
 <08c824b0-cfbb-40ca-b976-9fbd41e5e855@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08c824b0-cfbb-40ca-b976-9fbd41e5e855@rbox.co>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274311-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FREEMAIL_CC(0.00)[163.com,gmail.com,cloudflare.com,google.com,redhat.com,davemloft.net,kernel.org,fb.com,iogearbox.net,linux.dev,fomichev.me,bytedance.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:dkim]
X-Rspamd-Queue-Id: 9118138249A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 01 Apr 2026 00:43:58 +0200, Michal Luczaj wrote:
> On 3/31/26 02:20, Martin KaFai Lau wrote:
> > On 3/30/26 4:03 PM, Michal Luczaj wrote:
> >> On 3/26/26 07:26, Martin KaFai Lau wrote:
> >>> On 3/15/26 4:58 PM, Michal Luczaj wrote:
> >>>>> Beside, from looking at the may_update_sockmap(), I don't know if it is
> >>>>> even doable (or useful) to bpf_map_update_elem(unix_sk) in
> >>>>> tc/flow_dissector/xdp. One possible path is the SOCK_FILTER when looking
> >>>>> at unix_dgram_sendmsg() => sk_filter(). It was not the original use case
> >>>>> when the bpf_map_update_elem(sockmap) support was added iirc.
> >>>>
> >>>> What about a situation when unix_sk is stored in a sockmap, then tc prog
> >>>> looks it up and invokes bpf_map_update_elem(unix_sk)? I'm not sure it's
> >>>> useful, but seems doable.
> >>>
> >>> [ Sorry for the late reply ]
> >>>
> >>> It is a bummer that the bpf_map_update_elem(unix_sk) path is possible
> >>> from tc :(
> >>>
> >>> Then unix_state_lock() in its current form cannot be safely acquired in
> >>> sock_map_update_elem(). It is currently a spin_lock() instead of
> >>> spin_lock_bh().
> >>
> >> Is there a specific deadlock you have in your mind?
> > 
> > e.g. unix_stream_connect() is taking unix_state_lock(). Can a tc's 
> > ingress bpf prog call unix_state_lock()?
> 
> Ah, right, that's the problem, thanks for explaining.
> 
> But, as I've asked in the parallel thread, do we really need to take the
> unix_state_lock() in sock_map_update_elem()? Taking it in
> sock_map_update_elem_sys() fixes the null-ptr-deref and does not lead to a
> deadlock. Taking unix_state_lock() in sock_map_update_elem() seems
> unnecessary. Well, at least under the assumption progs can only access
> unix_sk via the sockmap lookup.

right, sock_map_update_elem_sys() should be safe to take
unix_state_lock().

If it is fixed by testing unix_peer(), is the TCPF_ESTABLISHED test
in sock_map_sk_state_allowed() still useful and needed? Also,
please explain in detail in the commit message why testing for NULL
without unix_state_lock() is enough. For example, for the BPF iterator on
sock_map, my understanding is that unix_release_sock() can still happen
while the BPF iterator is iterating over a unix_sock. I guess a future
unix_state_lock() in the iterator's seq_show() should be useful.

It will also be useful to mention what was discovered about TC + lookup
+ update_elem(&sock_map, ...) and why it is not safe to take
unix_state_lock() in that path. Thanks.

> 
> >> ...
> >> And sock_{map,hash}_seq_show() (being a part of bpf iter machinery) needs
> >> to take lock_sock() just as well? Would that require a special-casing
> >> (unix_state_lock()) for af_unix?
> > 
> > I would think so for lock_sock() considering the current bh_lock_sock 
> > without !sock_owned_by_user() usage is incorrect in 
> > sock_map_update_elem(). [ this probably should be a separate issue for 
> > another patch ]
> 
> All right, leaving that for later.
> 
> > Some more side-tracking... from looking at the code, the bpf_iter of 
> > sock_{map,hash} can do bpf_map_lookup_elem(&sock_map, ...). This 
> > bpr_iter program probably will be failed to load because the 
> > bpf_sk_release() is not available.
> 
> I think ability to bpf_map_lookup_elem(sockmap) was added way before bpf
> iter in
> https://lore.kernel.org/bpf/20200429181154.479310-2-jakub@cloudflare.com/
> and iter "allows" it somewhat accidentally. Would you rather have it
> explicitly dropped?

It is fine to leave it as is. It would be a bit nicer to reject map_lookup
on sockmap instead of giving the confusing error that bpf_sk_release
is not available. That is for another day. I was just wondering what else
could go wrong with map_lookup.

