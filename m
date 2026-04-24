Return-Path: <netdev+bounces-281055-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCr/HhPF62liRAAAu9opvQ
	(envelope-from <netdev+bounces-281055-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 21:31:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03382462EEC
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 21:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECB76300617A
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 19:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE93826A0B9;
	Fri, 24 Apr 2026 19:31:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED6827453;
	Fri, 24 Apr 2026 19:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777059071; cv=none; b=dS6nVsrmzQ+noA95SuRelM2PpcBi0p0bxsmAM1U9MD75VXoY0J6QZjdNL6weOA8SwhWDYhpuVZJjGu1eh+I3E9RjOLSHF5FwgJHeB5KsHG02gf2dDPZ0AK+5EEq883wyr5RX1hMo+TKhyRus9a4x+Jlz39d8mbRoY/etiOVFTtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777059071; c=relaxed/simple;
	bh=EYaf/JhqL+ccTdvuXaqxnjG9DW6oirUSaJ9T3K1PNlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PddLKnaeBxcC8aCoSafLFhcX2kN7T25xmMHWU9G39V4lXo9iQqvegIMNr4huUlojhzkS/8NTuy+7s1XCaGnAvW2A+R0WAetuUHnCuDotxVHjTaOM8UmP5u3OavQZlqJ/NBkbPeSrdMIfaFh/vBYENaW2SUovGVXWi+7WmPT+YJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id A479D60425; Fri, 24 Apr 2026 21:31:01 +0200 (CEST)
Date: Fri, 24 Apr 2026 21:31:00 +0200
From: Florian Westphal <fw@strlen.de>
To: Ginger <ginger.jzllee@gmail.com>
Cc: steffen.klassert@secunet.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [bug report] Potential order bug in 'net/xfrm/xfrm_state.c',
 primarily in 'xfrm_state_walk_done()'
Message-ID: <aevE9IXgvj_Gx0gD@strlen.de>
References: <CAGp+u1autEHVxgs1pdqxz0kwExuKE3+XmQOtTC5bv-R7WU8nBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGp+u1autEHVxgs1pdqxz0kwExuKE3+XmQOtTC5bv-R7WU8nBw@mail.gmail.com>
X-Rspamd-Queue-Id: 03382462EEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-281055-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]

Ginger <ginger.jzllee@gmail.com> wrote:
> Potential concurrent triggering executions:
> T0:
> xfrm_state_walk_done
>     --> kfree(walk->filter); [t0]
>     --> list_del(&walk->all); [t3]

list_del() uses same spinlock as iterator.

> T1:
> xfrm_state_walk

2652 int xfrm_state_walk(struct net *net, struct xfrm_state_walk *walk,
2653                     int (*func)(struct xfrm_state *, int, void*),
2654                     void *data)
2655 {
[..]
2663         spin_lock_bh(&net->xfrm.xfrm_state_lock);
2668         list_for_each_entry_from(x, &net->xfrm.state_all, all) {
2669                 if (x->state == XFRM_STATE_DEAD)
2670                         continue;

... and walker has STATE_DEAD, no? So I don't see how UaF is possible.

Even if parallel invocation (pfkey+netlink?) is possible, then we have:

T0: walk_done() -> free filter -> blocks on spinlock for list_del
T1: list_for_each ... -> walker is valid memory, checks x->state -> SKIP
to next entry

(or list_del already finished, but then _walk() is blocked on
spinlock).

