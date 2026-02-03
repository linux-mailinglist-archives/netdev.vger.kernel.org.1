Return-Path: <netdev+bounces-256269-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eF8FN+XmgWl0LwMAu9opvQ
	(envelope-from <netdev+bounces-256269-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 13:15:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6581BD8DF6
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 13:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C6BE30F8539
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 12:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A0033D6C1;
	Tue,  3 Feb 2026 12:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bj/FffSu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8793382F0
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 12:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770120595; cv=none; b=uwhOJnCVz908T8YCpw/zbTfEdV5RCfJyNWnOEdMAToW9qw4ysLiN246ld1827Wd8ZlO+yzhaQ83pkZxYf8yMW4NOXQo1Yycc+9gJ3i5D+PKuWd3ncbCctNqtW9Cxawwtd6X5t1i+KmvgpnmkKxHKkiYQMOjZNWa+nxn8MUNGC3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770120595; c=relaxed/simple;
	bh=t/NHiCAOtrU5RmZFrRrViJJq2+qojcYukf+Sl2Pbl9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmInm2l+FfWBVZRaqArpO8Vt6jSnze2CFoL8mH++8xldyRs0OQvYRD4FWdgjh/jmxTNE1Tz1hutbGn+FTb3ZoSQgXBL/aM2bnPkcVlmxtBd5vi1AGfurVFrjQKSwaeyaXWF7JMLDYwtABTH5cmhffOCAV1SHW12kqFVqtmTtlWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bj/FffSu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770120592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7wvdwy6kOKBUUQ9Sy1sqxRYmKnrlPjeRAeZlizy/ctQ=;
	b=Bj/FffSuXWDZp3bXz4FJLmaR7ClIWlNGnqgKJ2fUMqyG5M7eSrk2eB6PAutlc8JFHMqR6N
	1epxa3DBSXzeTowkBy6h1j5P/f8PXxboMM9BaMwWOMdsaZbgGVHzfcs0zF6EZA+RQv9sN9
	CWk1pQTWnYzdoYNhBEqkGOOkl2ac7jA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-OQJNgJT6N_yh8JUDu0wqQg-1; Tue,
 03 Feb 2026 07:09:49 -0500
X-MC-Unique: OQJNgJT6N_yh8JUDu0wqQg-1
X-Mimecast-MFC-AGG-ID: OQJNgJT6N_yh8JUDu0wqQg_1770120587
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F9E5195605A;
	Tue,  3 Feb 2026 12:09:47 +0000 (UTC)
Received: from thinkpad (unknown [10.44.34.184])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9F1B2180094B;
	Tue,  3 Feb 2026 12:09:43 +0000 (UTC)
Date: Tue, 3 Feb 2026 13:09:40 +0100
From: Felix Maurer <fmaurer@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	jkarrenpalo@gmail.com, tglx@linutronix.de, mingo@kernel.org,
	allison.henderson@oracle.com, petrm@nvidia.com, antonio@openvpn.net
Subject: Re: [PATCH net-next v2 5/9] selftests: hsr: Add tests for more link
 faults with PRP
Message-ID: <aYHlhKiSh8YrXjT1@thinkpad>
References: <cover.1769093335.git.fmaurer@redhat.com>
 <774d7a2327d1c05b78ee30ac21297794bfcb0245.1769093335.git.fmaurer@redhat.com>
 <20260129133217.xNoDm9nn@linutronix.de>
 <aYCK5Dczg_0tbuEA@thinkpad>
 <20260202164550.1TDNCEe_@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202164550.1TDNCEe_@linutronix.de>
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
	TAGGED_FROM(0.00)[bounces-256269-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linutronix.de,oracle.com,nvidia.com,openvpn.net];
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
X-Rspamd-Queue-Id: 6581BD8DF6
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 05:45:50PM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-02-02 12:30:44 [+0100], Felix Maurer wrote:
> > On Thu, Jan 29, 2026 at 02:32:17PM +0100, Sebastian Andrzej Siewior wrote:
> > > On 2026-01-22 15:57:00 [+0100], Felix Maurer wrote:
> > > > Add tests where one link has different rates of packet loss or reorders
> > > > packets. PRP should still be able to recover from these link faults and
> > > > show no packet loss.  However, it is acceptable to receive some level of
> > > > duplicate packets. This matches the current specification (IEC
> > > > 62439-3:2021) of the duplicate discard algorithm that requires it to be
> > > > "designed such that it never rejects a legitimate frame, while occasional
> > > > acceptance of a duplicate can be tolerated." The rate of acceptable
> > > > duplicates in this test is intentionally high (10%) to make the test
> > > > stable, the values I observed in the worst test cases (20% loss) are around
> > > > 5% duplicates.
> > >
> > > Do you know why we have the duplicates? It is because of the high
> > > sending rate at which point the blocks are dropped and we can't
> > > recognise the duplicate?
> >
> > I could not give a definitive answer on this last week, I had to dig a
> > bit and think through this. The reason for the duplicates is not a high
> > sending rate leading to dropped blocks. Rather, it's the low sending
> > rate leading to expiring blocks: in the test, the ping interval is set
> > to 10ms. As the blocks expire based on the timestamp of the first
> > received sequence number, the 400ms entry expiry gets hit every ca. 40
> > frames, at which we basically clear all received sequence number in the
> > block by creating a new block. This happens on both nodes (for ping
> > requests and replies) ca. 10 times during the test, leading to about 20
> > duplicate packets, which is the ca. 5% duplicates I observed in multiple
> > runs of this test.
> >
> > This means the duplicate rate is highly dependent on the traffic pattern
> > and the test manages to hit exactly this situation. I'll add the
> > explanation to the message in v3. If similar traffic patterns are hit in
> > the real world too often, we could test different block sizes. I just
> > did this and the results are as expected:
> > - 64 bit blocks: the duplicate rate is about the same because the block
> >   still expires once.
> > - 32 bit blocks: the duplicate rate drops to around 4% because,
> >   including the netem delay in the test, this is roughly the edge
> >   between expiring a block and already hitting a new one. But if we keep
> >   the bitmap as it is, we waste 50% of memory.
> > - 16 bit blocks: duplicate rate is zero because we use new blocks way
> >   before the expiry time. But this wastes about 75% memory for each
> >   block and the overhead of the timestamp in each block gets quite
> >   significant.
> >
> > I'd suggest to keep the 128 bit blocks to have a chance to detect
> > duplicates at higher data rates for some delay difference (up to about
> > 5.5ms with 1Gbit/s). 64 bit blocks would halve the maximum delay
> > difference, but probably still strike a good balance between memory
> > overhead and duplicate rate. Do you prefer one over the other?
>
> We had false positives with the old algorithm so having now some is not
> the end of the world. 128bit blocks are fine I guess. The question is
> how far do we want to tune it and everything comes with a price.
>
> If I update bitmap every time there is a valid packet:
>
> diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
> index 08f91f10a9347..bb9b13940c35b 100644
> --- a/net/hsr/hsr_framereg.c
> +++ b/net/hsr/hsr_framereg.c
> @@ -572,6 +572,7 @@ static int hsr_check_duplicate(struct hsr_frame_info *frame,
>  	if (test_and_set_bit(seq_bit, block->seq_nrs[port_type]))
>  		goto out_seen;
>
> +	block->time = jiffies;
>  out_new:
>  	spin_unlock_bh(&node->seq_out_lock);
>  	return 0;
>
> then I the test
> | TEST: test_cut_link - HSRv1                                         [ OK ]
> | INFO: Wait for node table entries to be merged.
> | INFO: Running ping node1-NUb1aJ -> 100.64.0.2
> | INFO: 400 packets transmitted, 400 received, +22 duplicates, 0% packet loss, time 6113ms
>
> turns into
>
> | TEST: test_cut_link - HSRv1                                         [ OK ]
> | INFO: Wait for node table entries to be merged.
> | INFO: Running ping node1-6i4xNe -> 100.64.0.2
> | INFO: 400 packets transmitted, 400 received, 0% packet loss, time 6067ms
>
> which could be considered as an improvement.

Thank you for testing this! That's indeed an improvement.

> On the other hand the live
> time of the block gets pushed past the HSR_ENTRY_FORGET_TIME so
> the first entry survives longer theoretically 127 * (400-1) = ~50 seconds.
> In the reboot case the box should be quiet for 500ms at which point the
> entry gets removed anyway so the longer "hold time" shouldn't matter.
>
> It sounds like a good idea but I don't want to rush anything ;)

I agree, the reboot case is safe because of the 500ms quiet period. But
I kinda fear a situation where a node sends a lot of packets (making
it's sequence number wrap within the 400ms), but only a small fraction
of that to us, so that we don't clear blocks because of a full buffer.
That could make a block live pretty long, when we hit it multiple times,
which could in turn lead to valid, new frames being dropped. I'd say
it's a somewhat artificial scenario, but not impossible in reality
(especially considering that I'd expect a good chunk of the traffic in
HSR and PRP networks being periodic, which may lead to reliably hitting
the same blocks over and over).

Thanks,
   Felix


