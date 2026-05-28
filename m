Return-Path: <netdev+bounces-292485-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Kk9G4aLF2o5IwgAu9opvQ
	(envelope-from <netdev+bounces-292485-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 02:25:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8475EB38B
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 02:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE350301F5C2
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 00:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7997D175A93;
	Thu, 28 May 2026 00:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nlDrQDqG"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D4234389A
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 00:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779927919; cv=none; b=gSUut128RqM88hC3yMa7MNxj/fcs2GXq5Qbj/t2/6LNZszISM5NLHddtnLGrRJdl5pLmkjH54v4dFFCSGQcR7sfZ4DsnmG7lnDj8KKvju6noMG6dFGPm32pWeUH7QopSBz9CrLIsJaaZH7LlqgNjisNMPNd5UkwTcQS958XNs3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779927919; c=relaxed/simple;
	bh=nnJN/WTB7RTL1WY4rmdg9pWu8uW2CTb/zmgvfsALoI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtF7cstkzhC1SvApm0XpUi/k8b0oh7jsGyJW0BfffcHA4MbxzYm8aQwG+a8767hqa38Z6uw4zfZUHPSY9XDFF2rZ1xDtJIFgvW779BZeixm8p3taCqOSBltb/V8SRfubdzygBNW//VqSCRf/Xgz8DkCSS5RO/oOPKcDWyBuuCdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nlDrQDqG; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 27 May 2026 17:24:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779927905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RwJoFpvdeBNTnl2sJg+T3OVD+m+DGzYdPbYTYG/cTL0=;
	b=nlDrQDqGxxkO73JMN35VIJ6iVNi9WdMPb9ZluX8yi+Dr9Q713AvTWLY3U8oHlRSX+GnKir
	Zgth49xaxqp18yZz757icA4UG0kcn1NLTkcXWmCfcP30S4qbwQvooFcWa03TG2Tfe19RsV
	TzJYSALkTqlCWLMmEOdM8/f9VFJzq0Y=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Amery Hung <ameryhung@gmail.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 bpf-next 03/11] bpf: tcp: Support bpf_skb_load_bytes()
 for BPF_SOCK_OPS_RCVQ_CB.
Message-ID: <2026527234056.o8QL.martin.lau@linux.dev>
References: <20260523083001.2911931-1-kuniyu@google.com>
 <20260523083001.2911931-4-kuniyu@google.com>
 <202652620632.prOx.martin.lau@linux.dev>
 <CAAVpQUA0UNhR8AWfd0WC-krYJeXb0ebNs-V4u9kgweyNw_XHtg@mail.gmail.com>
 <2026526214538.Vhly.martin.lau@linux.dev>
 <CAL+tcoCSU9KFZsV33LE2R89iUzb5b3Xm+h6QObs5GOuRYR3sMQ@mail.gmail.com>
 <2026527192229.olv9.martin.lau@linux.dev>
 <CAAVpQUCUV=N0dEi8H51Y0oZytnohkJT1=B6zT3gxEKvb_5bukg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAVpQUCUV=N0dEi8H51Y0oZytnohkJT1=B6zT3gxEKvb_5bukg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292485-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,iogearbox.net,linux.dev,fomichev.me,google.com,berkeley.edu,vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: DF8475EB38B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 02:39:20PM -0700, Kuniyuki Iwashima wrote:
> > > Could you show me what to do next? Thanks in advance. It sounds like
> > > the tx side of bpf timestamping should be adjusted accordingly?
> >
> > imo, the bpf_tcp_ops can land first. and then add net timestamping
> > ops (existing tx and the new rx) in bpf_sock_ops.
> 
> Sounds good to me.  I'll rebase TCP AutoLOWAT feature on top
> of the struct_ops series.

Thanks.

The ops in bpf_tcp_ops do not have a skb arg yet.
A few lines similar to bpf_qdisc_is_valid_access() in bpf_qdisc.c
are needed. I recall it works around btf_ctx_access(). We can
probably clean it up in the future, which should be generic
enough for all struct_ops taking a skb.

I believe the "if (prog->aux->st_ops != &bpf_Qdisc_ops)" check in
bpf_qdisc_kfunc_filter() may get in the way. bpf_dynptr_from_skb
kfunc should not be limited to the bpf_qdisc struct_ops. I think
the net subsystem should allow bpf_dynptr_from_skb as the basic
kfunc for all struct_ops programs as long as skb is a trusted pointer.
You should be able to work around it for now by tweaking bpf_qdisc_kfunc_filter.
The struct_ops program will only have read-only access to the skb
through bpf_dynptr_*() kfuncs.

The struct_ops series will need to address some issues (excluding
the pre-existing ones in cgroup.c) pointed out by Sashiko.
Amery is kind enough to help me figure out how to resolve it
and then respin.

