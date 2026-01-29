Return-Path: <netdev+bounces-254835-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDfoHnR9e2kQFAIAu9opvQ
	(envelope-from <netdev+bounces-254835-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 16:32:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D212FB179D
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 16:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D21BB3017C37
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 15:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414F8279DCD;
	Thu, 29 Jan 2026 15:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HlYgVoHa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B241126F2BD
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 15:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769700656; cv=none; b=sMCevNj2O9Yf4elGh6n72I6yDAuUxoSQ6ut6voQ+VPqf52xUsBWxiW5ziz00+MxhsXG71n71q3QYQozLSfsZi6VwPvLMoLgHbHx4oI1yODwCVPA1tTUGoHbe2FLsQCPpl29dZZ205mSNUMj/jLAj4PUQsj1gSnBHwi5Hd2icVu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769700656; c=relaxed/simple;
	bh=apc65uLcuXfsP+/cbJQmxinXOEjJaefSjUQOV7/0VQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WsRujeCkR9DRaJ2PbbBDEgr5v73ZATPv90OL2fyBkR393SsckukJ004aEC19TCUjT2fhwgnI6FeBp9NGKm5mHhVzmb+T/fOAiMUfhXZU59Wc+JSNaEV0nSTxTwQqviiZYhIMRZ/pn5UrqepG6xC9sWL4toRIp8w3mmkTDVzjs9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HlYgVoHa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769700653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ttgpfPTVqpXctCpgd8C7YpFbEsl5uP0oBMz3JbpSPM=;
	b=HlYgVoHaQBJOMKlU6iTSJ4n8k/kU9AtT+Hiiak07pUcKrR9ZluOs9HBLLn/cbtHJlqkg+q
	rkEl4H8jcEDP9gvg7sVrUv4/8i1MghRdXIUmgWzQGsKDeRkC9XbWiUviaKk32RIHzXSCyU
	IYB2S2BEWTWVK6cYXFwNhhLo4FVdCaM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-RCnn6hUONY6YnVyg-HuIyQ-1; Thu,
 29 Jan 2026 10:30:46 -0500
X-MC-Unique: RCnn6hUONY6YnVyg-HuIyQ-1
X-Mimecast-MFC-AGG-ID: RCnn6hUONY6YnVyg-HuIyQ_1769700640
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19F48195606D;
	Thu, 29 Jan 2026 15:30:40 +0000 (UTC)
Received: from thinkpad (unknown [10.44.34.121])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 12A1E3000218;
	Thu, 29 Jan 2026 15:30:35 +0000 (UTC)
Date: Thu, 29 Jan 2026 16:30:32 +0100
From: Felix Maurer <fmaurer@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	jkarrenpalo@gmail.com, tglx@linutronix.de, mingo@kernel.org,
	allison.henderson@oracle.com, petrm@nvidia.com, antonio@openvpn.net,
	Steffen Lindner <steffen.lindner@de.abb.com>
Subject: Re: [PATCH net-next v2 4/9] hsr: Implement more robust duplicate
 discard for PRP
Message-ID: <aXt9GIlea_AUvHX9@thinkpad>
References: <cover.1769093335.git.fmaurer@redhat.com>
 <fe1dbc483482e98fbc286290a2a3e88f555894d4.1769093335.git.fmaurer@redhat.com>
 <20260129132940.XvIWrwoG@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260129132940.XvIWrwoG@linutronix.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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
	TAGGED_FROM(0.00)[bounces-254835-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D212FB179D
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 02:29:40PM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-01-22 15:56:59 [+0100], Felix Maurer wrote:
> > The PRP duplicate discard algorithm does not work reliably with certain
> …
> > The idea of the new algorithm is to store the seen sequence numbers in a
> > bitmap. To keep the size of the bitmap in control, we store it as a "sparse
> > bitmap" where the bitmap is split into blocks and not all blocks exist at
> > the same time. The sparse bitmap is implemented using an xarray that keeps
> > the references to the individual blocks and a backing ring buffer that
> …
>
> My idea was to keep track of say the last 64 sequence numbers but I had
> no idea how to efficiently implement it with all the "forget" parts and
> so on. What you did here is quite nice.

Thank you!

> > @@ -280,6 +301,59 @@ struct hsr_node *hsr_get_node(struct hsr_port *port, struct list_head *node_db,
> …
> > +/* Get the currently active sequence number block. If there is no block yet, or
> > + * the existing one is expired, a new block is created. The idea is to maintain
> > + * a "sparse bitmap" where a bitmap for the whole sequence number space is
> > + * split into blocks and not all blocks exist all the time. The blocks can
> > + * expire after time (in low traffic situations) or when they are replaced in
> > + * the backing fixed size buffer (in high traffic situations).
>                                     HSR_MAX_SEQ_BLOCKS,
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
>
> So we assign ->time here while the block is created and it expires after
> HSR_ENTRY_FORGET_TIME (400ms). *Maybe* it should be updated in
> hsr_check_duplicate() if we set a bit. The difference would be that the
> last sequence in the block would get it whole life time while now the
> lifetime starts with the first entry in the block. The downside
> of course would be that the first entry gets more than the initialy
> expected lifetime.
> Not sure if this matters in reality, just wanted to mention.

I considered that as well. But given that the standard states that
"since the 16-bit SeqNr wraps around after 65 536 frames [...], entries
older than a specified time EntryForgetTime are purged" (IEC
62439-3:2021, 4.1.10.3) and later more explicitly that EntryForgetTime
is the "maximum time an entry may reside in the duplicate table" (4.4),
I decided that we rather go the safe way here and use the lifetime of
the first entry.

One can definitely construct a scenario where using the lifetime of the
last entry is problematic: let's say we have a block with a single
entry. If the sequence number wraps around and we reach the same block
again after, let's say, 350ms but hit a different bit in the block, the
new lifetime would apply to both entries, which would almost double the
lifetime of the initial entry.

The large span of 128 entries per timestamp could be mitigated by
changing the size (and maybe number) of blocks. The 64 blocks with 128
entries each is a kind of arbitrary pick, but make a good tradeoff in my
opinion. I'm making that tradeoff between memory usage, timestamp
inaccuracy, and link delay we can deal with (with 64 * 128 = 2^13
entries out of the 2^16 sequence number space, i.e, 1/8th of the space,
that's 5-6ms on a 1Gbit/s network where sequence number could repeat
every 44ms according to the standard).

> > +		block->block_idx = block_idx;
> > +
> > +		res = xa_store(&node->seq_blocks, block_idx, block, GFP_ATOMIC);
> > +		if (xa_is_err(res))
> > +			return NULL;
> > +
> > +		node->next_block =
> > +			(node->next_block + 1) & (HSR_MAX_SEQ_BLOCKS - 1);
> > +	}
> > +
> > +	return block;
> > +}
> > +
> >  /* Use the Supervision frame's info about an eventual macaddress_B for merging
> >   * nodes that has previously had their macaddress_B registered as a separate
> >   * node.
> > @@ -545,47 +631,26 @@ int prp_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame)
> …
> > +
> > +	seq_bit = hsr_seq_block_bit(sequence_nr);
> > +	if (test_and_set_bit(seq_bit, block->seq_nrs))
>
> the access happens under ::seq_out_lock so you don't need to be atomic
> here. You could safe a cycle and use __test_and_set_bit() instead.

Good point, I tried to get rid of the lock at some point, but then
decided that it would be material for another patchset. I'll change it
to __test_and_set_bit().

Thanks,
   Felix


> > +		goto out_seen;
> >
> >  	node->time_out[port->type] = jiffies;
> >  	node->seq_out[port->type] = sequence_nr;
> > +out_new:
> >  	spin_unlock_bh(&node->seq_out_lock);
> >  	return 0;
> > +
> > +out_seen:
> > +	spin_unlock_bh(&node->seq_out_lock);
> > +	return 1;
> >  }
> >
> >  #if IS_MODULE(CONFIG_PRP_DUP_DISCARD_KUNIT_TEST)
>
> Sebastian


