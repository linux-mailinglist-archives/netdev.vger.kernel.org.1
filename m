Return-Path: <netdev+bounces-254840-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBT6MhSIe2mlFQIAu9opvQ
	(envelope-from <netdev+bounces-254840-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 17:17:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 732D1B2050
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 17:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CB0A33004605
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 16:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56A233D6D4;
	Thu, 29 Jan 2026 16:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SS4JMYJ0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E151933D6F1
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 16:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769703442; cv=none; b=aD2NIxBa7OswXZMGDXb61+OfDcVYixn1jmQHdXH4pXaYRqs2b3SPpAoq55NyqFb4EYwDpi7N59dCYCVStcUtAk9wDoXU5vOT31ScM07MME1MfUNQJ4pT31vV7FIdR8TuJaBCR9xAPVRAbl44hVhyMnPudAfe1kxoMLYldgh/f9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769703442; c=relaxed/simple;
	bh=cqHOU9GrGSzPVakVpvKCnAMfJOIM4PnLQhTrCneb2EM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLDE9q9KX2GfgkCYcQhgd1hY7OGQ916fIndP3wBNZ8HU10Naa3FYT5TYfn9Q+8EydRs4uilB52P9RDxyh1nftwpVAk+EwsJvWARv4R7j+A0VmcQRImFNJ2OMysZVyiS1MCXD9BsdnAFyTNw3q+oR9X7wPNVhsf+dEH5+590Hhq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SS4JMYJ0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769703439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4It8slVtarCu4DVvMInrTQl3b78Xd5NgimOoy6AXI8c=;
	b=SS4JMYJ0A61wH57HxMJcm2sUAPUJGIiVsIsfIfpOebnOH/SNjq1G5mZSmsHQgmR+3lQVi0
	EWhYfVC+iwhL+YbtH6K9+fvQ/8bNfDqI1hJSLOpzZMQ79mU/6OopeVB25phGDADqEYoFva
	M5gWjuq8k1MgFLNxyf6MbZ1EKXrY3mA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-d8FDsvFHMPmefNIqWAOTJA-1; Thu,
 29 Jan 2026 11:17:14 -0500
X-MC-Unique: d8FDsvFHMPmefNIqWAOTJA-1
X-Mimecast-MFC-AGG-ID: d8FDsvFHMPmefNIqWAOTJA_1769703432
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 108471954B21;
	Thu, 29 Jan 2026 16:17:12 +0000 (UTC)
Received: from thinkpad (unknown [10.44.34.121])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 290AE180009E;
	Thu, 29 Jan 2026 16:17:07 +0000 (UTC)
Date: Thu, 29 Jan 2026 17:17:04 +0100
From: Felix Maurer <fmaurer@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	jkarrenpalo@gmail.com, tglx@linutronix.de, mingo@kernel.org,
	allison.henderson@oracle.com, petrm@nvidia.com, antonio@openvpn.net,
	Yoann Congal <yoann.congal@smile.fr>
Subject: Re: [PATCH net-next v2 6/9] hsr: Implement more robust duplicate
 discard for HSR
Message-ID: <aXuIAFJ_m6gMUFFO@thinkpad>
References: <cover.1769093335.git.fmaurer@redhat.com>
 <07b90a435ed7d3450c1949e3a21910916d8538de.1769093335.git.fmaurer@redhat.com>
 <20260129144348.CIs44m-d@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260129144348.CIs44m-d@linutronix.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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
	TAGGED_FROM(0.00)[bounces-254840-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linutronix.de,oracle.com,nvidia.com,openvpn.net,smile.fr];
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
X-Rspamd-Queue-Id: 732D1B2050
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 03:43:48PM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-01-22 15:57:01 [+0100], Felix Maurer wrote:
> …
> > As the problem (we accidentally skip over a sequence number that has not
> > been received but will be received in the future) is similar to PRP, we can
> > apply a similar solution. The duplicate discard algorithm based on the
> > "sparse bitmap" works well for HSR if it is extended to track one bitmap
> > for each port (A, B, master, interlink). To do this, change the sequence
> > number blocks to contain a flexible array member as the last member that
> > can keep chunks for as many bitmaps as we need. This design makes it easy
> > to reuse the same algorithm in a potential PRP RedBox implementation.
>
> I know you just "copy" the logic based on what we have now but…
> Why do we have to track the sequence number for A, B and interlink? The
> 'master' port is what we feed into the stack so this needs to be
> de-duplicated. I am not sure how 'interlink' works so I keep quiet here.
> But A and B? There shouldn't be any duplicates on A and B unless the
> destination node forwards the node. Or do I miss something?
> I'm bringing this up because limiting to one (or two since I am unsure
> about interlink) would save some memory and avoid needless updates. And
> if you have HW-offloading enabled then you shouldn't see any packets
> which are not directed to _this_ node.

About the interlink: that's the interface where you attach devices that
know nothing about HSR, i.e., when we are a RedBox. I consider it very
similar to the master port, it's our responsibility to de-duplicate what
we send out there.

I was thinking about exactly this while working on the patch as well and
I came to each conclusion (A,B are needed vs. are not needed) at least
once. In the end, I think we will need it. It's right that a well
behaving node in the ring should not forward "frames for which the node
is the unique destination" (5.3.2.1). But there could be frames that
have no unique destination in the ring at all: multicast frames or
frames addressed to a non-existing MAC address. We should not forward
such frames either to prevent them from looping forever.

Now, such frames should probably only reach back to us, if we sent them
(either from our stack or from the interlink port). We could track
sequence numbers sent to master and interlink (for de-duplication) and
sent by master and interlink (for loop prevention) for more clarity, but
then we're back at four bitmaps again.

I agree that we can and should optimize the HW-offloaded case. I'd
suggest to do that in a separate patchset, though, partly because I
don't have access to a hardware with HSR offload at the moment.

> …
> > diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
> > index 70b3819e9298..c9bd25e6a7cc 100644
> > --- a/net/hsr/hsr_framereg.c
> > +++ b/net/hsr/hsr_framereg.c
> > @@ -805,6 +774,39 @@ void *hsr_get_next_node(struct hsr_priv *hsr, void *_pos,
> >  	return NULL;
> >  }
> >
> > +/* Fill the last sequence number that has been received from node on if1 by
> > + * finding the last sequence number sent on port B; accordingly get the last
> > + * received sequence number for if2 using sent sequence numbers on port A.
> > + */
> > +static void fill_last_seq_nrs(struct hsr_node *node, u16 *if1_seq, u16 *if2_seq)
> > +{
> > +	struct hsr_seq_block *block;
> > +	unsigned int block_off;
> > +	size_t block_sz;
> > +	u16 seq_bit;
> > +
> > +	spin_lock_bh(&node->seq_out_lock);
> > +
> > +	// Get last inserted block
> > +	block_off = (node->next_block - 1) & (HSR_MAX_SEQ_BLOCKS - 1);
> > +	block_sz = hsr_seq_block_size(node);
> > +	block = node->block_buf + block_off * block_sz;
> > +
> > +	if (!bitmap_empty(block->seq_nrs[HSR_PT_SLAVE_B - 1],
> > +			  HSR_SEQ_BLOCK_SIZE)) {
> > +		seq_bit = find_last_bit(block->seq_nrs[HSR_PT_SLAVE_B - 1],
> > +					HSR_SEQ_BLOCK_SIZE);
> > +		*if1_seq = (block->block_idx << HSR_SEQ_BLOCK_SHIFT) | seq_bit;
> > +	}
> > +	if (!bitmap_empty(block->seq_nrs[HSR_PT_SLAVE_A - 1],
> > +			  HSR_SEQ_BLOCK_SIZE)) {
> > +		seq_bit = find_last_bit(block->seq_nrs[HSR_PT_SLAVE_A - 1],
> > +					HSR_SEQ_BLOCK_SIZE);
> > +		*if2_seq = (block->block_idx << HSR_SEQ_BLOCK_SHIFT) | seq_bit;
> > +	}
> > +	spin_unlock_bh(&node->seq_out_lock);
>
> I know you preserve what is already here but what is this even used for?
> | ip -d link show dev hsr0
>
> does not show these numbers. It shows the sequence number of the hsr0
> interface which I understand.
> But then it is also possible to show the last received sequence number
> of any node on either of the two interfaces?

This is only exposed through the HSR_C_GET_NODE_STATUS netlink command
for the "HSR" (sic!) netlink family. I'm not aware of a userspace tool
that actually shows this data. It's unclear if it is of any real use.

I assume that the two sequence numbers are reported because they would
in theory allow to detect a broken ring: if one of the numbers stops
increasing or the numbers generally diverge, some link in the ring is
broken. If we have traffic from multiple nodes, we could even detect
where the ring is broken. That's likely also the reason for the weird
cross-assinment of B->1, A->2. What we send out on B has to have arrived
on port A resp. 1 before.

We can discuss removing this stuff in the future, but I'd prefer not to
touch userspace at this time.

> > +}
> > +
> >  int hsr_get_node_data(struct hsr_priv *hsr,
> >  		      const unsigned char *addr,
> >  		      unsigned char addr_b[ETH_ALEN],
> …
> > --- a/net/hsr/hsr_framereg.h
> > +++ b/net/hsr/hsr_framereg.h
> > @@ -82,15 +82,18 @@ int prp_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame);
> >  #define hsr_seq_block_index(sequence_nr) ((sequence_nr) >> HSR_SEQ_BLOCK_SHIFT)
> >  #define hsr_seq_block_bit(sequence_nr) ((sequence_nr) & HSR_SEQ_BLOCK_MASK)
> >
> > +#define DECLARE_BITMAP_FLEX_ARRAY(name, bits) \
> > +	unsigned long name[][BITS_TO_LONGS(bits)]
> > +
> >  struct hsr_seq_block {
> >  	unsigned long		time;
> >  	u16			block_idx;
> > -	DECLARE_BITMAP(seq_nrs, HSR_SEQ_BLOCK_SIZE);
> > +	DECLARE_BITMAP_FLEX_ARRAY(seq_nrs, HSR_SEQ_BLOCK_SIZE);
>
> is there a story behind DECLARE_BITMAP_FLEX_ARRAY()? We have just this
> one user.

I've added it this way to make it obvious that almost all of it is the
same as DECLARE_BITMAP(). But probably it's better to get rid of the
macro, add the definition directly to the struct, and maybe add a
comment that it's supposed to be similar to what DECLARE_BITMAP()
produces. What do you think?

Thanks for your comments,
   Felix


> >  };
>
> Sebastian


