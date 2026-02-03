Return-Path: <netdev+bounces-256241-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AF/NMm3NgWl5KAMAu9opvQ
	(envelope-from <netdev+bounces-256241-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 11:26:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49501D7972
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 11:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4CD430209C2
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 10:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10939316185;
	Tue,  3 Feb 2026 10:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jVHMGh3q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B06313526
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 10:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770114255; cv=none; b=h1DvOiLXhHI9tFB+Z+ewM6/stJcvX1ANduaBrf+WZtsUiQVJl/G1m1k5nKIBbOYR+DbX2VeazLEdrwjQcMDJM8tNZMYFeVi4Ed8oMohZwFrjv/fBRDMCFzLQuKQPLQSjdLTg98YbwdFUFr6siXljdT7ejSmeyCWZ5C4SVViuf5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770114255; c=relaxed/simple;
	bh=TbHi8NYXiKv9OlxhwUsDYnYszuVZy4eSfERCwRojuV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AyRE5SYpsIFcBiW5ajOG63oajUGmbFoJGX0RiEXuHh8z4b/GXyRj0e0EwMEHKAhI6YquECWG6nxE5oEXN9dLwIFIx4vs9kSU0ZDrM3FvojJzKfX25vzhk6BONzhx8OBPUL+X6jHsUQWTv7rHW+I3lId6hLBuc0t8BeNwxE2iYeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jVHMGh3q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770114252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wjYBKmBeHIWGT7vX4BsMfaxupTp6wFGyNzDY5eUgb8w=;
	b=jVHMGh3qAMMsCaJUDl4oZbJ81IB4TEdQb9WYaJxYNEGRA9d6qs+WPrA4j0mgHuOVm1jWxp
	q98B/XDS7FJprep3Q0RLGeCrmGWse/ExahKuyTdduK8rpDwBeawKGJM2ahYxU2jKb1CPDh
	VoVdFmRCXeOLSxDzvReXSZi8isL6aM8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-eEpDzR4eO4-_j6_YbV7G9w-1; Tue,
 03 Feb 2026 05:24:06 -0500
X-MC-Unique: eEpDzR4eO4-_j6_YbV7G9w-1
X-Mimecast-MFC-AGG-ID: eEpDzR4eO4-_j6_YbV7G9w_1770114245
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CCC7118003FD;
	Tue,  3 Feb 2026 10:24:04 +0000 (UTC)
Received: from thinkpad (unknown [10.44.34.184])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D4C1C30001A7;
	Tue,  3 Feb 2026 10:24:00 +0000 (UTC)
Date: Tue, 3 Feb 2026 11:23:57 +0100
From: Felix Maurer <fmaurer@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jkarrenpalo@gmail.com, tglx@linutronix.de,
	mingo@kernel.org, allison.henderson@oracle.com, petrm@nvidia.com,
	antonio@openvpn.net, Steffen Lindner <steffen.lindner@de.abb.com>
Subject: Re: [PATCH net-next v2 4/9] hsr: Implement more robust duplicate
 discard for PRP
Message-ID: <aYHMvaGiuQSHBevG@thinkpad>
References: <cover.1769093335.git.fmaurer@redhat.com>
 <fe1dbc483482e98fbc286290a2a3e88f555894d4.1769093335.git.fmaurer@redhat.com>
 <20260128163824.GB172540@kernel.org>
 <aXpXY0YSjA-ctoBa@thinkpad>
 <20260202165702.R9PI3JSM@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202165702.R9PI3JSM@linutronix.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256241-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,davemloft.net,google.com,redhat.com,gmail.com,linutronix.de,oracle.com,nvidia.com,openvpn.net,de.abb.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 49501D7972
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 05:57:02PM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-01-28 19:37:23 [+0100], Felix Maurer wrote:
> > > > +	if (!block) {
> > > > +		block = &node->block_buf[node->next_block];
> > > > +		hsr_forget_seq_block(node, block);
> > > > +
> > > > +		memset(block, 0, sizeof(*block));
> > > > +		block->time = jiffies;
> > > > +		block->block_idx = block_idx;
> > > > +
> > > > +		res = xa_store(&node->seq_blocks, block_idx, block, GFP_ATOMIC);
> > > > +		if (xa_is_err(res))
> > >
> > > Hi Felix,
> > >
> > > I ran Claude Code over this with review-prompts [1] and it flags
> > > that in the error path above, the following is needed so that the
> > > block can be re-used.
> > >
> > > 			block->time = 0;
> >
> > I agree. It would nonetheless be reused at some point, but not setting
> > time = 0 may lead to an unexpected block getting removed when it is
> > reused (or at least an attempt to do so). I'll fix this in v3.
>
> Not sure I follow. If xa_store() fails then the block is not added to
> the "sequence-blocks" and it will be attempted once the next packet is
> received, right?. Otherwise node->next_block is not updated at which
> point this block will be added twice which sounds worse.

Yes, it will be attempted again on the next frame that needs a new
block. But every attempt to recycle the next_block starts with calling
hsr_forget_seq_block(), which tries to xa_erase() the block if time!=0.
Generally, time==0 is the marker that a block is not stored in the
xarray. So for consistency it's correct to set time=0 if the block can't
be added to the xarray, even though I don't think it would cause any
trouble at the moment if the time is not reset.

Thanks,
   Felix


