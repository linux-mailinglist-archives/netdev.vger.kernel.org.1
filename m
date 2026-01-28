Return-Path: <netdev+bounces-254411-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMNhHHhXeml55QEAu9opvQ
	(envelope-from <netdev+bounces-254411-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 19:37:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 504E8A7D06
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 19:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B618D300460D
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A485036EABD;
	Wed, 28 Jan 2026 18:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BDux226i"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0141A25A2B4
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 18:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769625461; cv=none; b=J7MSeDhlDEUGXJhtCfRBjKkPRx+/UBUUllPcDccQ1xO4wAxPnJTco+X85+rfHXgx+qV3vyYVrMDH7iL1THNIFAzOzd8YLKQQUKVtFtZNuFxB1CPKSLznsTscSvBz6OSramjg3fBa2I1miyRjfldr0cxgAEINrlO9ipDTMkkZxSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769625461; c=relaxed/simple;
	bh=G77Vg9NCoEOfzWSMqpCfpI3vtHhFc7WHgv7Y4TJrTcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hx9leDb66kaLwB/ITdmL+KwAsPrPe2/7Fset5OFAA5BoNfKdnqFfSE1NMNmZ5bCHYbOYsWNkFXtRxZOI/Z4RaiwZ0ZoayloSkK2AGozFYczY0m/Stqs/MCYk6Og0VBEFE5bB9/ZTOlCDn+udVlzlWFzQIhOm2yC2FHZWY0rC228=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BDux226i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769625459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Rp6W/5BvogCjZr+iOOJYHLX2W86xKh8vpmayGVFhwA=;
	b=BDux226iltuK4aALC2qBWun67Pm8jJDHhV/Xi4pnRzm3b8N7BqkoBSR4vWTrgtjmGAwX/O
	WNk2olOKXFyB7npKeGq18JHeP9sRmES9pnD0j7Yr4GSm1y0GmP8bL+bRKhueTV2VMNHDE8
	Fhy4J76KH7RtpRmj2KIhxy2hivB4yp4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-C2i-XW3JPxeZn9nTHXkHUw-1; Wed,
 28 Jan 2026 13:37:33 -0500
X-MC-Unique: C2i-XW3JPxeZn9nTHXkHUw-1
X-Mimecast-MFC-AGG-ID: C2i-XW3JPxeZn9nTHXkHUw_1769625451
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8693C1936189;
	Wed, 28 Jan 2026 18:37:30 +0000 (UTC)
Received: from thinkpad (unknown [10.44.33.100])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6F83318002A6;
	Wed, 28 Jan 2026 18:37:26 +0000 (UTC)
Date: Wed, 28 Jan 2026 19:37:23 +0100
From: Felix Maurer <fmaurer@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jkarrenpalo@gmail.com,
	tglx@linutronix.de, mingo@kernel.org, allison.henderson@oracle.com,
	petrm@nvidia.com, antonio@openvpn.net, bigeasy@linutronix.de,
	Steffen Lindner <steffen.lindner@de.abb.com>
Subject: Re: [PATCH net-next v2 4/9] hsr: Implement more robust duplicate
 discard for PRP
Message-ID: <aXpXY0YSjA-ctoBa@thinkpad>
References: <cover.1769093335.git.fmaurer@redhat.com>
 <fe1dbc483482e98fbc286290a2a3e88f555894d4.1769093335.git.fmaurer@redhat.com>
 <20260128163824.GB172540@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128163824.GB172540@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254411-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linutronix.de,oracle.com,nvidia.com,openvpn.net,de.abb.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 504E8A7D06
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 04:38:24PM +0000, Simon Horman wrote:
> On Thu, Jan 22, 2026 at 03:56:59PM +0100, Felix Maurer wrote:
>
> ...
>
> > diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
>
> ...
>
> > +/* Get the currently active sequence number block. If there is no block yet, or
> > + * the existing one is expired, a new block is created. The idea is to maintain
> > + * a "sparse bitmap" where a bitmap for the whole sequence number space is
> > + * split into blocks and not all blocks exist all the time. The blocks can
> > + * expire after time (in low traffic situations) or when they are replaced in
> > + * the backing fixed size buffer (in high traffic situations).
> > + */
> > +static struct hsr_seq_block *hsr_get_seq_block(struct hsr_node *node,
> > +					       u16 block_idx)
> > +{
> > +	struct hsr_seq_block *block, *res;
> > +
> > +	block = xa_load(&node->seq_blocks, block_idx);
> > +
> > +	if (block && hsr_seq_block_is_old(block)) {
> > +		hsr_forget_seq_block(node, block);
> > +		block = NULL;
> > +	}
> > +
> > +	if (!block) {
> > +		block = &node->block_buf[node->next_block];
> > +		hsr_forget_seq_block(node, block);
> > +
> > +		memset(block, 0, sizeof(*block));
> > +		block->time = jiffies;
> > +		block->block_idx = block_idx;
> > +
> > +		res = xa_store(&node->seq_blocks, block_idx, block, GFP_ATOMIC);
> > +		if (xa_is_err(res))
>
> Hi Felix,
>
> I ran Claude Code over this with review-prompts [1] and it flags
> that in the error path above, the following is needed so that the
> block can be re-used.
>
> 			block->time = 0;

I agree. It would nonetheless be reused at some point, but not setting
time = 0 may lead to an unexpected block getting removed when it is
reused (or at least an attempt to do so). I'll fix this in v3.

Thanks,
   Felix


> [1] https://github.com/masoncl/review-prompts/
>
> > +			return NULL;
> > +
> > +		node->next_block =
> > +			(node->next_block + 1) & (HSR_MAX_SEQ_BLOCKS - 1);
> > +	}
> > +
> > +	return block;
> > +}
> > +
>
> ...


