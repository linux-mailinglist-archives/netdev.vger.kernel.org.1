Return-Path: <netdev+bounces-256283-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKBqEyTvgWlAMwMAu9opvQ
	(envelope-from <netdev+bounces-256283-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 13:50:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D96D9555
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 13:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74B9330E72EA
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 12:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D5732E690;
	Tue,  3 Feb 2026 12:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CEvxVeql"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9A631A7F2
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 12:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770122582; cv=none; b=OfpNP0X7l5lSFcmu6Q6p+H6J8sFjd8H9kE9nwTLzoABV5WbAnJAxeup4y4KvThbBNXni/gch4QUlbQwWGY3G+BSymyJ4s8R5nxqzaxIlx76p6c6OkG55NFr9b/m9GQ2dtngOPL0LOHUNnADHrf+tGeB2FmRmcUhGI0B/dVZni7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770122582; c=relaxed/simple;
	bh=u+chm2qe2UaDCOdZTAISqPdNE1lhHXCRqAvQjvQx0WM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rd7EOdKIubDs9rvL23dCeIt0PfKihhLc/G5YwQ4FOBazif1UKiszWkluGxyqo/hjpDXXanp1eHcqII7tZPWozbbkf8/FW2UFRY2+AkDUTMqe/GGxM4kWZo7PkU7NcaUa59dNc9Am3Ym9K4UU1i17KiB86+nAbOPNqBD5C5Asc+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CEvxVeql; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770122580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LF3GRiApzlM2RrKH+kiOvRs8f6wdo1Fn0YQ6vnScJiQ=;
	b=CEvxVeqlZeITVeE6vpHS31bB+Pk4DlUGinUoLd8u2dVfAr0fOU7NeGTNtN+HT0HsoeB0gC
	RTXmMFu7OFM0fgrNgsuQ7ePmAMbGkFTcdhtKlNK6Ki8egqwBe+h8jcu9Vwb97b1IcNWCk6
	7cED9UdYscr2ZPfBSbT+a3jZ2SIKZGo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-moibDoRpM9-yTHg7ZbNy_Q-1; Tue,
 03 Feb 2026 07:42:57 -0500
X-MC-Unique: moibDoRpM9-yTHg7ZbNy_Q-1
X-Mimecast-MFC-AGG-ID: moibDoRpM9-yTHg7ZbNy_Q_1770122575
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E2EC1800365;
	Tue,  3 Feb 2026 12:42:55 +0000 (UTC)
Received: from thinkpad (unknown [10.44.34.184])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A6E7180176D;
	Tue,  3 Feb 2026 12:42:51 +0000 (UTC)
Date: Tue, 3 Feb 2026 13:42:48 +0100
From: Felix Maurer <fmaurer@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jkarrenpalo@gmail.com, tglx@linutronix.de,
	mingo@kernel.org, allison.henderson@oracle.com, petrm@nvidia.com,
	antonio@openvpn.net, Steffen Lindner <steffen.lindner@de.abb.com>
Subject: Re: [PATCH net-next v2 4/9] hsr: Implement more robust duplicate
 discard for PRP
Message-ID: <aYHtSP-Pl1mTpkJC@thinkpad>
References: <cover.1769093335.git.fmaurer@redhat.com>
 <fe1dbc483482e98fbc286290a2a3e88f555894d4.1769093335.git.fmaurer@redhat.com>
 <20260128163824.GB172540@kernel.org>
 <aXpXY0YSjA-ctoBa@thinkpad>
 <20260202165702.R9PI3JSM@linutronix.de>
 <aYHMvaGiuQSHBevG@thinkpad>
 <20260203115719.cU_6tnal@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203115719.cU_6tnal@linutronix.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256283-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E1D96D9555
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 12:57:19PM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-02-03 11:23:57 [+0100], Felix Maurer wrote:
> > On Mon, Feb 02, 2026 at 05:57:02PM +0100, Sebastian Andrzej Siewior wrote:
> > > On 2026-01-28 19:37:23 [+0100], Felix Maurer wrote:
> > > > > > +	if (!block) {
> > > > > > +		block = &node->block_buf[node->next_block];
> > > > > > +		hsr_forget_seq_block(node, block);
> > > > > > +
> > > > > > +		memset(block, 0, sizeof(*block));
> > > > > > +		block->time = jiffies;
> > > > > > +		block->block_idx = block_idx;
> > > > > > +
> > > > > > +		res = xa_store(&node->seq_blocks, block_idx, block, GFP_ATOMIC);
> > > > > > +		if (xa_is_err(res))
> > > > >
> > > > > Hi Felix,
> > > > >
> > > > > I ran Claude Code over this with review-prompts [1] and it flags
> > > > > that in the error path above, the following is needed so that the
> > > > > block can be re-used.
> > > > >
> > > > > 			block->time = 0;
> > > >
> > > > I agree. It would nonetheless be reused at some point, but not setting
> > > > time = 0 may lead to an unexpected block getting removed when it is
> > > > reused (or at least an attempt to do so). I'll fix this in v3.
> > >
> > > Not sure I follow. If xa_store() fails then the block is not added to
> > > the "sequence-blocks" and it will be attempted once the next packet is
> > > received, right?. Otherwise node->next_block is not updated at which
> > > point this block will be added twice which sounds worse.
> >
> > Yes, it will be attempted again on the next frame that needs a new
> > block. But every attempt to recycle the next_block starts with calling
> > hsr_forget_seq_block(), which tries to xa_erase() the block if time!=0.
> > Generally, time==0 is the marker that a block is not stored in the
> > xarray. So for consistency it's correct to set time=0 if the block can't
> > be added to the xarray, even though I don't think it would cause any
> > trouble at the moment if the time is not reset.
>
> My point is that the block will not be recycled if it failed to be added
> here. It remains the "next" block to be used and added to the list if it
> fails that xa_store().

Hm, I'm not sure I follow. Do you argue that the code already in the
patch is incorrect or that it would be incorrect with Simon's
suggestion?

Yes, in case the xa_store() fails, the current "next" block remains the
"next" block. But we also definitely erased it from the xarray already.
With the next frame, we attempt to recycle/insert the block again. I
don't think that can lead to the same block being used twice?

I understood Simon's suggestion this way: in the error path, *also*
reset block->time to 0. We'd still return NULL in that case and,
crucially, don't advance the next_block. IMHO, that only makes the data
more consistent (blocks in the buffer that are not in the xarray always
have time=0) and prevents that we try to remove a non-existing entry
from the xarray on the next frame when we try again to recycle the
current "next" block.

Thanks,
   Felix


