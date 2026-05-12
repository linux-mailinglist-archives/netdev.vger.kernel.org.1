Return-Path: <netdev+bounces-287039-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OrKGib3AmqvzAEAu9opvQ
	(envelope-from <netdev+bounces-287039-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:47:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 643D251E03E
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 587773014A3A
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED96A3AE70D;
	Tue, 12 May 2026 09:45:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5A64BC016
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 09:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778579136; cv=none; b=m/7Qo5M6h2BBTQJCrC6OjcFL+P+7r6T6Ob1fIKtWY8aE0HFcvCGAE76CUu5G8tktemedQ/eZuvGhOTMoR+MbOSsNJYdKxXkHkZBqGaboUsS/LIOq5TwKwI2DtppegBUjzn1xL94KkpFiTX/D3lRUN2yrigwBp77Dy9x+IXUehCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778579136; c=relaxed/simple;
	bh=kB3FgQ1v4x2nNTOvP/co8m4IKeLd7kxFg6GkVhqpuFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyOYC6q++iEa5OTlEZJFdfzgBTtUInznrs3eVR/VW5DdfHx0YZmghCVSDbqkEMCJt6WyFWSuMnOukdPYUOfUF2gClmemulfKwEB1SFpsLVSJrjgcMw52y9WHTtX5dAGkVuBnb7Gz5xWsgopefD4QseXEHXB6xZdPs+mGuGaozd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 3E3B66092A; Tue, 12 May 2026 11:45:33 +0200 (CEST)
Date: Tue, 12 May 2026 11:45:30 +0200
From: Florian Westphal <fw@strlen.de>
To: Yuan Tan <yuantan098@gmail.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>, Ren Wei <n05ec@lzu.edu.cn>,
	bridge@lists.linux.dev, netdev@vger.kernel.org, idosch@nvidia.com,
	davem@davemloft.net, yifanwucs@gmail.com, tomapufckgml@gmail.com,
	bird@lzu.edu.cn, tonanli66@gmail.com
Subject: Re: [PATCH net 1/1] net: bridge: guard local finish against missing
 port
Message-ID: <agL2up-rblE9Y6yP@strlen.de>
References: <cover.1778504155.git.tonanli66@gmail.com>
 <ad183a40c4d906f39e03590b371fdcfdffb863c6.1778504155.git.tonanli66@gmail.com>
 <1bfd86a2-e7f8-42ef-8486-4d7fa91b2199@blackwall.org>
 <CAPuPA7JzZC1veoLtdmsGdqZ4xuy7Znu=z=+7FsyX0_iUQxcZAQ@mail.gmail.com>
 <c2bbd2ab-e4f9-4142-a3d4-531f3d5ce6d7@blackwall.org>
 <CAPuPA7+jMHLjpY-RWK6-EQqs-NjrGUmanuPVVTDZJv1yeRk1oA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPuPA7+jMHLjpY-RWK6-EQqs-NjrGUmanuPVVTDZJv1yeRk1oA@mail.gmail.com>
X-Rspamd-Queue-Id: 643D251E03E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287039-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[blackwall.org,lzu.edu.cn,lists.linux.dev,vger.kernel.org,nvidia.com,davemloft.net,gmail.com];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.849];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,strlen.de:mid,ozlabs.org:url]
X-Rspamd-Action: no action

Yuan Tan <yuantan098@gmail.com> wrote:
> > >>> The bridge local receive path may be deferred by netfilter and resumed
> > >>> later. By the time br_handle_local_finish() runs, skb->dev may still be
> > >>> valid while its bridge port association has already been removed.
> > >>>
> > >>> br_handle_local_finish() unconditionally looks up the bridge port from
> > >>> skb->dev and dereferences it for source learning. If the port is no
> > >>> longer attached to the bridge, the lookup returns NULL and the deferred
> > >>> local receive path can no longer rely on the port state being present.
> > You should update the Fixes: tag but also wait 24h before re-posting another
> > patch version.
> 
> Ok we will send the v2 with fix tag f350a0a87374 after 24h

Would you mind exploring an alternative fix for this?

As nfnetlink_queue'd skbs leave rcu read locked section, great
care has to be taken on reinject.

Either bridge could call nf_queue_nf_hook_drop() on bridge
port removal, or nfqnl_reinject() could revalidate that skb->dev
is part of a bridge and munge verdict to NF_DROP in case
the assocication was removed while packet was out.

static bool nfqnl_bridge_port_removed(const struct nf_queue_entry *e)
{
	return e->state.pf == NFPROTO_BRIDGE &&
		!br_port_get_rcu(e->skb->dev) == NULL;
}

static void nfqnl_reinject(struct nf_queue_entry *entry, unsigned int verdict)
{
        const struct nf_ct_hook *ct_hook;

        if (verdict == NF_ACCEPT ||
            verdict == NF_REPEAT ||
            verdict == NF_STOP) {
                unsigned int ct_verdict = verdict;

		....

		if (nfqnl_bridge_port_removed(entry))
			verdict = NF_DROP;

Its more work, but it places the extra checks to where
they are really needed.

Also see related bug fix:  At this time, entire bridge device can go
away while packet is out.

https://patchwork.ozlabs.org/project/netfilter-devel/patch/ca7ee343bbcb44905e1f5b853df2f3a5b7d40548.1778493188.git.royenheart@gmail.com/

