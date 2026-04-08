Return-Path: <netdev+bounces-276695-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNDpKeGs1mmZHAgAu9opvQ
	(envelope-from <netdev+bounces-276695-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 21:30:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3163C31A4
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 21:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 853193066BEE
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 19:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32A73DA7CA;
	Wed,  8 Apr 2026 19:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j/N/2nXJ"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382383446CA
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 19:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775676148; cv=none; b=LtN5qGLQKG8szFGmb3jeEHs4LYw3VatwcIY0scZLKWo9jTowynnf8DdA0ydVPM6mqE/WVtV9nRL8BKleQm0uhCrmGwvelrciKzagYjCgnEth8ApxsIgqrCv/P0L/XMQs5Fw51eKONaPGcqTL2Pzz67aQ9OcjtjXm9aCe2rWeJm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775676148; c=relaxed/simple;
	bh=xeU+CpDbjuqTRy7NHM9S1q/5feA7r1UJohNuP6FPUFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQ2JX5MOT7PZXeOS6Zak4+ky0+WsPmkIsa4lc9JMDSp8Wr7xX2PeyyhLUTlN+xXlx7A4kqG0PTK+PhNsr7FDhqgNe7k1/xKPqJ45B0Inh8kyWfAE5waARe1xHCt2ErHIWWuIgiT+iwSyZhl3l90rnBF/Z45zMwSew2CNI26DLH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j/N/2nXJ; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 8 Apr 2026 12:22:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775676135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r06+65cH0yTHLeV6B/4VEG9UgecJFocJ5Fv7CVecJZ8=;
	b=j/N/2nXJ6G/XzxA/pZ7oHUMlkEaXecPiuV/MvK4oy24x+6smZSOqY/2JVzR45w8g6cpV/C
	7WWB3gIXOZd4TOUeNgt724+fOogHzDpb2nVnNOZNEG4/+hblxfXW+bRP51bVkM+DgmhLlh
	u7EH+taxjWUhaz0Ec7A0i5B1NssR0fw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>, 
	Kuniyuki Iwashima <kuniyu@google.com>
Cc: Eric Dumazet <edumazet@google.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v6 1/2] bpf: tcp: Reject non-TCP skb in
 bpf_sk_assign_tcp_reqsk()
Message-ID: <202648182730.i4ki.martin.lau@linux.dev>
References: <20260403015851.148209-1-jiayuan.chen@linux.dev>
 <20260403015851.148209-2-jiayuan.chen@linux.dev>
 <20264619471.he8Q.martin.lau@linux.dev>
 <4820d99b-f2c4-4b24-b90f-87e6444284c4@linux.dev>
 <CAAVpQUDz_rUFF1A8XDyE13fLTsgdP5k0XWGtdB1V3r=Z_mJW+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpQUDz_rUFF1A8XDyE13fLTsgdP5k0XWGtdB1V3r=Z_mJW+g@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-276695-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,davemloft.net,redhat.com];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2E3163C31A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 09:25:06PM -0700, Kuniyuki Iwashima wrote:
> > > sashiko has flagged a similar issue with larger scope.
> > > Please take a look. Thanks.
> > >
> > > https://sashiko.dev/#/patchset/20260403015851.148209-1-jiayuan.chen%40linux.dev
> >
> >
> > Thanks a lot Martin, sashiko actually dug into a deeper issue here.
> >
> > Eric and Kuniyuki,
> >
> > I think the AI review has a point. Since BPF can modify skb fields, the
> > following sequence still bypasses the protocol check in
> > bpf_sk_assign_tcp_reqsk():
> >
> >     // for a UDP skb
> >     iph->protocol = TCP
> >     bpf_sk_assign_tcp_reqsk()
> >     iph->protocol = UDP
> >
> > On top of that, bpf_sk_assign() already has the same problem — it doesn't
> > validate L4 protocol at all.
> 
> Sigh... honestly it does not make sense to me to add changes
> in the common fast path to protect someone with bpf capability
> shooting oneself in the foot.
> 
> On top of L4 validation in bpf_sk_assign() and bpf_sk_assign_tcp_reqsk(),
> can't we mark such an skb immutable after the helpers and catch
> subsequent writes to skb->data on the verifier ?

Clearing the skb->sk in a helper like bpf_skb_store_bytes or
rejecting direct writes to skb->data could break existing
bpf program.

I suspect adding a simple iph->protocol/ip6h->nexthdr check to
the helper (e.g. bpf_sk_assign) could also break some
tunneling use cases (e.g. ipip) also.

> 
> 
> >
> > So I think we should add a check matching skb against sk in
> > skb_steal_sock() instead of adding check in bpf helper.

Maybe limit the check to the '*prefetched' case in skb_steal_sock().

FWIW, in the early days of bpf_sk_assign, a tc bpf program could only
get hold of a tcp_sock. Later, bpf_map_lookup_elem(&sock_map) was
allowed in tc, and then udp/unix sock support was also added to sock_map.

There have been discussions on tc bpf programs being able to do
bpf_map_lookup_elem(&sock_map) to get a unix_sock. AFAIK, this
looked-up unix_sock can be used in bpf_sk_assign. It probably
makes sense for bpf_sk_assign to reject all non-tcp/non-udp sk.

