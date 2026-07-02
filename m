Return-Path: <netdev+bounces-304210-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yhn1BD14RmooWgsAu9opvQ
	(envelope-from <netdev+bounces-304210-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 16:39:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 562916F8F64
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 16:39:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mEQ4xkni;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304210-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304210-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D14423011770
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 14:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0066D4229A0;
	Thu,  2 Jul 2026 14:35:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA3147DFB4;
	Thu,  2 Jul 2026 14:35:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783002943; cv=none; b=MSZdHTBHONPLceqzy/NNHvtnZvXZB0JztpYRQ95s0irCSFCcoI/eKMhK+S/yekLH5jku2KQ/cRYf+BnNLuyTtPEUQrxRjJJAltiE4JpUhHFfKRBX3aQDoha3CyPIYvCfc9MCdQhkacUQaMPevto4L3SCjsYdomdTAVvzEmNDYgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783002943; c=relaxed/simple;
	bh=OChXG95dXklADOHWHO2RUZcCF9PIoKQeA5FlqfWEq6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBAfFKtVONFqdchCnUpt0q1YJxI/jA+180Wvkk44hXor1Z4C7SxWeYOyP74AVpa9aLvvc2+3k9mC62yo/Opg1++jkYvDJ9mcSgyglD+6Xo98tqmUuGw9e73o3xd/c6xG/hB8shZ4TiR4OiHeSNa/zny/xbKCkjvntzIvmIGb75c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEQ4xkni; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9276F1F000E9;
	Thu,  2 Jul 2026 14:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783002941;
	bh=wH9rv6AxNmdVYoJg0T3cBY47n1twfT656Q2yRzOY/xI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mEQ4xknizAwN9m9BBuGqodJtOesHR1ePpcgaFcVl6YLkUgpkmhQNwKJYORN0RL5aF
	 Zap7xy7QCA5EX2jc+RjnYkBghVkLQf0NjvYHMD4tLjcHgYHcH8XBZ+HsZOAjvFrxmh
	 A/TqLdLqF5kjtdjg7m4aGrJMbqzRP9MlAgaskdofaJoNtgjsRuB5ABSs6Xx0x9Jzko
	 DMSkjzLGGfKy4hDC9e7AjonGgU4uifZFcqqvZwprngUIFYE9iWHd4LTH6JGEUGLNIQ
	 h6QrGBZQ/H80taGOJwizJrsrEzSuVqY0v9sjHpJnOe+cO/eIpPsxu73DhapD9oPms5
	 2khvfGU+SZc5w==
Date: Thu, 2 Jul 2026 17:35:34 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Manish Chopra <manishc@marvell.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-net-drivers@amd.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/4] bnx2x: use kzalloc() to allocate mac filtering list
Message-ID: <akZ3NuRLZ4YjFGGv@kernel.org>
References: <20260701-b4-drivers-ethernet-v1-0-58776615db6e@kernel.org>
 <20260701-b4-drivers-ethernet-v1-1-58776615db6e@kernel.org>
 <02237688-9532-4fd0-8494-a7bb524ca4f2@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02237688-9532-4fd0-8494-a7bb524ca4f2@intel.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304210-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[rppt@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:manishc@marvell.com,m:pabeni@redhat.com,m:ecree.xilinx@gmail.com,m:skalluru@marvell.com,m:anthony.l.nguyen@intel.com,m:intel-wired-lan@lists.osuosl.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-net-drivers@amd.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,m:ecreexilinx@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,marvell.com,redhat.com,gmail.com,intel.com,lists.osuosl.org,vger.kernel.org,kvack.org,amd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 562916F8F64

On Thu, Jul 02, 2026 at 03:52:13PM +0200, Przemek Kitszel wrote:
> 
> > @@ -2713,8 +2714,7 @@ static int bnx2x_mcast_enqueue_cmd(struct bnx2x *bp,
> >   				total_elems = BNX2X_MCAST_BINS_NUM;
> >   		}
> >   		while (total_elems > 0) {
> > -			elem_group = (struct bnx2x_mcast_elem_group *)
> > -				     __get_free_page(GFP_ATOMIC | __GFP_ZERO);
> > +			elem_group = kzalloc(PAGE_SIZE, GFP_ATOMIC);
> 
> what is the current rule of thumb for kzalloc vs kvzalloc size under
> GFP_ATOMIC?

kvzalloc() with GFP_ATOMIC is kzalloc():

	/*
	 * vmalloc uses GFP_KERNEL for some internal allocations (e.g page tables)
	 * so the given set of flags has to be compatible.
	 */
	if ((flags & GFP_KERNEL) != GFP_KERNEL)
		return kmalloc_node(size, flags, node);

so it's only physically contiguous allocations.

 
> >   			if (!elem_group) {
> >   				bnx2x_free_groups(&new_cmd->group_head);
> >   				kfree(new_cmd);
> > 
> 

-- 
Sincerely yours,
Mike.

