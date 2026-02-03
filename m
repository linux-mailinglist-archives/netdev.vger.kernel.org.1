Return-Path: <netdev+bounces-256248-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGsNLEjXgWlYKgMAu9opvQ
	(envelope-from <netdev+bounces-256248-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 12:08:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 151EDD8156
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 12:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A05273043BC7
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 11:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2739F32D44F;
	Tue,  3 Feb 2026 11:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mldw8AUx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5063A27F749
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 11:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770116934; cv=none; b=bfXVJQxMNWXcmeV7VnWqeXK2mGc3dNKrE23gDHk8oOY59S4PqdW+pwHT1AATBtgJJIyhfkodNk1pT3dWxdDpxyFaMo4EIwgjs8FJc60grnOG2EjPm2ixk9Sgd4KL5ok5I3KUEJ//30RpcCPwV5IrpKps39XfVY0L4lUMc7VbcuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770116934; c=relaxed/simple;
	bh=a4wqJNm/s0KfkWEZUxsaRpTFx18oeDMeG6ljLW+gANQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHyas0kAnOfqujdO+cuaCIlJ7TPapqyzwRQOdvIlx9arXvmEvkFgih23ZwQhOoHbfxw8/QHalmdAXv+Q7kHkWRY6ypPINMwrLHdp5yiGm3AULS7eroATJ8rGokPD5XBdw2yJ8umdsmSru3Ws6IYvROXOJ2qEzxmlPISE6qnIL+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mldw8AUx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770116931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jYEXi0PEquZskZNv8rHSySINYtei/a+rz6VJUg5OVG8=;
	b=Mldw8AUxaGcAR9GiGYofolXpzfiCuMqh65AXrk/sFXEk+783/j1BimEfo4N0VAxggZ7NU+
	UrAtfhymXwSDvOvvKKqnUSzCf2ZnDzrojv/PKRWWNiL2j2uer3j0pFMZSiOlD5m3/PX/Am
	yHBNeevSm4Rx+tYrbIWDxeb/W1Uu84I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-q-jrge04Oi-OiRXY2afQqQ-1; Tue,
 03 Feb 2026 06:08:48 -0500
X-MC-Unique: q-jrge04Oi-OiRXY2afQqQ-1
X-Mimecast-MFC-AGG-ID: q-jrge04Oi-OiRXY2afQqQ_1770116926
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 326E2180044D;
	Tue,  3 Feb 2026 11:08:46 +0000 (UTC)
Received: from thinkpad (unknown [10.44.34.184])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 458B51800285;
	Tue,  3 Feb 2026 11:08:42 +0000 (UTC)
Date: Tue, 3 Feb 2026 12:08:39 +0100
From: Felix Maurer <fmaurer@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	jkarrenpalo@gmail.com, tglx@linutronix.de, mingo@kernel.org,
	allison.henderson@oracle.com, petrm@nvidia.com, antonio@openvpn.net,
	Yoann Congal <yoann.congal@smile.fr>
Subject: Re: [PATCH net-next v2 6/9] hsr: Implement more robust duplicate
 discard for HSR
Message-ID: <aYHXN1RvUoX6TGXM@thinkpad>
References: <cover.1769093335.git.fmaurer@redhat.com>
 <07b90a435ed7d3450c1949e3a21910916d8538de.1769093335.git.fmaurer@redhat.com>
 <20260129144348.CIs44m-d@linutronix.de>
 <aXuIAFJ_m6gMUFFO@thinkpad>
 <20260202171123.LkzpiAMv@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260202171123.LkzpiAMv@linutronix.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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
	TAGGED_FROM(0.00)[bounces-256248-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 151EDD8156
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 06:11:23PM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-01-29 17:17:04 [+0100], Felix Maurer wrote:
> > About the interlink: that's the interface where you attach devices that
> > know nothing about HSR, i.e., when we are a RedBox. I consider it very
> > similar to the master port, it's our responsibility to de-duplicate what
> > we send out there.
>
> Right. It should contain the same "seen" values as the master port.
>
> > I was thinking about exactly this while working on the patch as well and
> > I came to each conclusion (A,B are needed vs. are not needed) at least
> > once. In the end, I think we will need it. It's right that a well
> > behaving node in the ring should not forward "frames for which the node
> > is the unique destination" (5.3.2.1). But there could be frames that
> > have no unique destination in the ring at all: multicast frames or
> > frames addressed to a non-existing MAC address. We should not forward
> > such frames either to prevent them from looping forever.
>
> But multicast and non-existing destination frames do one round in the
> circle, reach the sender which will remove them from the ring and not
> forward.
>
> > Now, such frames should probably only reach back to us, if we sent them
> > (either from our stack or from the interlink port). We could track
> > sequence numbers sent to master and interlink (for de-duplication) and
> > sent by master and interlink (for loop prevention) for more clarity, but
> > then we're back at four bitmaps again.
>
> I think we could avoid tracking A/ B. The packets that we receive from
> A/ B and forward to the master after de-duplication should be the same
> as those that are forwarded to the interlink port.

I consider this an argument for removing the separate tracking of master
and interlink (and thereby saving another 1k), by changing the
forwarding code to not iterate over all ports independently.

I'll reply to the A/B tracking topic in the other mail :)


> > > I know you preserve what is already here but what is this even used for?
> > > | ip -d link show dev hsr0
> > >
> > > does not show these numbers. It shows the sequence number of the hsr0
> > > interface which I understand.
> > > But then it is also possible to show the last received sequence number
> > > of any node on either of the two interfaces?
> >
> > This is only exposed through the HSR_C_GET_NODE_STATUS netlink command
> > for the "HSR" (sic!) netlink family. I'm not aware of a userspace tool
> > that actually shows this data. It's unclear if it is of any real use.
>
> hehe. Great.
>
> > I assume that the two sequence numbers are reported because they would
> > in theory allow to detect a broken ring: if one of the numbers stops
> > increasing or the numbers generally diverge, some link in the ring is
> > broken. If we have traffic from multiple nodes, we could even detect
> > where the ring is broken. That's likely also the reason for the weird
> > cross-assinment of B->1, A->2. What we send out on B has to have arrived
> > on port A resp. 1 before.
> >
> > We can discuss removing this stuff in the future, but I'd prefer not to
> > touch userspace at this time.
>
> Sure. I was just looking who is using this and this netlink interface
> was the only user. It looks like debug code.

For which we would have the debugfs... The netlink interface is already
on my list to take a look at. I'll take that debug aspect into account.
I might start a different thread with the discussion topics that came up
with this patchset.

> > > > +}
> > > > +
> > > >  int hsr_get_node_data(struct hsr_priv *hsr,
> > > >  		      const unsigned char *addr,
> > > >  		      unsigned char addr_b[ETH_ALEN],
> > > …
> > > > --- a/net/hsr/hsr_framereg.h
> > > > +++ b/net/hsr/hsr_framereg.h
> > > > @@ -82,15 +82,18 @@ int prp_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame);
> > > >  #define hsr_seq_block_index(sequence_nr) ((sequence_nr) >> HSR_SEQ_BLOCK_SHIFT)
> > > >  #define hsr_seq_block_bit(sequence_nr) ((sequence_nr) & HSR_SEQ_BLOCK_MASK)
> > > >
> > > > +#define DECLARE_BITMAP_FLEX_ARRAY(name, bits) \
> > > > +	unsigned long name[][BITS_TO_LONGS(bits)]
> > > > +
> > > >  struct hsr_seq_block {
> > > >  	unsigned long		time;
> > > >  	u16			block_idx;
> > > > -	DECLARE_BITMAP(seq_nrs, HSR_SEQ_BLOCK_SIZE);
> > > > +	DECLARE_BITMAP_FLEX_ARRAY(seq_nrs, HSR_SEQ_BLOCK_SIZE);
> > >
> > > is there a story behind DECLARE_BITMAP_FLEX_ARRAY()? We have just this
> > > one user.
> >
> > I've added it this way to make it obvious that almost all of it is the
> > same as DECLARE_BITMAP(). But probably it's better to get rid of the
> > macro, add the definition directly to the struct, and maybe add a
> > comment that it's supposed to be similar to what DECLARE_BITMAP()
> > produces. What do you think?
>
> I would get rid of it. There the "official" DECLARE_BITMAP(). If this
> doesn't work just open code it avoiding the macro.

Alright, I did that in the v3 [1] I sent yesterday. Sorry for not
waiting with that until the end of every discussion. I understood your
reply to 0/9 as a "go" for sending a new version addressing the small
issues (without touching the A/B tracking).

Thanks,
   Felix


[1]: https://lore.kernel.org/netdev/cover.1770041682.git.fmaurer@redhat.com/


