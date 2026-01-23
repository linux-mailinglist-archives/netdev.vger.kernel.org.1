Return-Path: <netdev+bounces-252595-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iB9vAgHWcmlhpwAAu9opvQ
	(envelope-from <netdev+bounces-252595-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:59:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 735776F6A1
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D36F3012BDC
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 01:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB18335078;
	Fri, 23 Jan 2026 01:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVdF6Faf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4050122173D;
	Fri, 23 Jan 2026 01:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769133562; cv=none; b=jR1q8yJZb7nQW4YrPl2Bd29RZP+gQwAo2GMj3CbujYlUbROtVYw/9mYUr3Oq/e+XvunZHbGVgpSYIbmUicxkSqxXJbTHZBa56u0Aw8vgqrdsru1JSEm8OczUrY93bVTAuNqkUny0GWYKuy/MFguzTRLanCfkF4JaumP0BPnb2oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769133562; c=relaxed/simple;
	bh=tuX+B1m6aVOnTDrES4Dffuzl97D9Q9bjlMnIuuT4C/4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c0qLcQQ07umKKWIhYU4t1vUFFUSjnGaIy/bORK7jZ5Ym5uIoeiZfigKj+3z6CTBUPxewC49RJdX6gwKN7Wy9YOnKZH9EbdtSRX/4Q+GLx5J/5Ds6zgZuzFU1045hJhdIUyL+f3UuA0was6evtoB7jCJkTRFQfIUSxy55zFzxKMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVdF6Faf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F46C116C6;
	Fri, 23 Jan 2026 01:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769133561;
	bh=tuX+B1m6aVOnTDrES4Dffuzl97D9Q9bjlMnIuuT4C/4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oVdF6FafABPah3b7WO2A5H6uQXWkWolqAw/dHpXoWTbc6StKN3Oykd0bl1cd/oSqH
	 YAFTyFRuHDGajKV31nAzmM1z6+PddLbudDBmFkjChU+2KtkhY97kvCTvlbhBmSlMS3
	 8bjSNpUfUEecAH/3X2Ij94pNbid1GddnEpzTvXu+7xG8H+r7RiQlDB/zOhySbNh6nF
	 C1SpB6Rjzzv5nbh82AlIutVbKkBgRvGT0yB1WIzMPB/D811sy0OtBCNTaXvc0LifJU
	 Qbuw99LLUV9cQ2klnTC9GXle/aJ7hKJaT86kxmy5wb8/y2O02wm+ANY9TBnlHO54K4
	 t6OKoFHJe4MTw==
Date: Thu, 22 Jan 2026 17:59:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, Eric Dumazet
 <eric.dumazet@gmail.com>, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@toke.dk>, carges@cloudflare.com, kernel-team@cloudflare.com, Yan Zhai
 <yan@cloudflare.com>
Subject: Re: [PATCH net-next v1] net: sched: sfq: add detailed drop reasons
 for monitoring
Message-ID: <20260122175919.590601b6@kernel.org>
In-Reply-To: <28911dac-6aec-42ce-9101-9071e18e1522@kernel.org>
References: <176847978787.939583.16722243649193888625.stgit@firesoul>
	<1bbbb306-d497-4143-a714-b126ecc41a06@kernel.org>
	<20260120162616.463c8af1@kernel.org>
	<412b91a2-15f3-4a5f-8f1a-249c9d79cb41@kernel.org>
	<20260121172155.6ec96ef8@kernel.org>
	<28911dac-6aec-42ce-9101-9071e18e1522@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,redhat.com,toke.dk,cloudflare.com];
	TAGGED_FROM(0.00)[bounces-252595-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.979];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 735776F6A1
X-Rspamd-Action: no action

On Thu, 22 Jan 2026 16:33:00 +0100 Jesper Dangaard Brouer wrote:
> > The kfree_skb tracepoint does not have netdev,  
> 
> Correct, the kfree_skb tracepoint does not have netdev avail.
> I'm also saying that I don't want the netdev, because that would
> explode/increase the Prometheus metric data.

Perhaps cutting someones reply mid-sentence is not the most effective
way to communicate.

> > so if you're saying you have the ability to see the netdev then
> > presumably there's some BPF in the mix BTF'ing the netdev info out.
> > And if you can read the netdev info, you can as well read
> > netdev->qdisc->ops->id and/or netdev->_tx[0]->qdisc->ops->id
> > 
> > It kinda reads to me like you're trying to encode otherwise-reachable
> > metadata into the drop reason.  
> 
> This feels like a misunderstanding. We don't want to (somehow) decode
> extra metadata like netdev or qdisc.  First of all we don't want to
> spend extra BPF prog cycles doing this (if it's even possible), and
> secondly we want to keep metric simple (see cardinality explosion).
> 
> I'm simply saying let us keep Eric's current approach of having qdisc
> specific drop-reason *when* those relates to qdisc specific tunables.
> And I'm arguing that FQ flow_limit and SFQ depth are two different
> things, and should have their own enums.
>    I have a specific production use-case, where I want configure SFQ to
> have small flow "depth" to penalize elefant flows, so I'm okay with
> SKB_DROP_REASON_SFQ_MAXDEPTH events.  So, I want to be able to tell this
> apart from FQ drops (SKB_DROP_REASON_FQ_FLOW_LIMIT). I hope that this
> makes it clear why I want this to be separate enums(?)

It really sounds to me like _in your setup_ there's some special
meaning associated with some traffic being in SFQ and other
traffic in FQ. And you can get the relevant information with BPF,
you're just saying that you don't want to spend cycles (with no
data to back that up).

I'm not gonna lose sleep over this, if you convince another maintainer
to merge it it's fine. To me having per qdisc drop reasons. When qdiscs
are *pluggable modules* and drop reasons are a core thing makes
no sense. You're encoding arbitrary metadata into the drop reason for
the convenience of your narrow use case.

