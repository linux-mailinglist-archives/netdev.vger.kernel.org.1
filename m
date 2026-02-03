Return-Path: <netdev+bounces-256264-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODSYCuXggWmDLQMAu9opvQ
	(envelope-from <netdev+bounces-256264-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 12:49:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CD3D89DA
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 12:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84920300ECB6
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 11:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C473314A4;
	Tue,  3 Feb 2026 11:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jHpWikjZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5DD318EF9
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 11:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770119394; cv=none; b=ciieZIcXtbp0mYx6tG47N6zmKFDDUzVsGTBB+3tN9WhOBHHTj7M7jBSYtNNUK94SiYcwfhFlqGlzFWRPYgTSwTdoBsnMYS+lMQkB2DW9tcQfDGoO/Bx7sqfZ9wbQkJsrgbv5xFTt7Ltu9Abcap+psjn+wq7Cj+/lNtejBEYqjuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770119394; c=relaxed/simple;
	bh=743zvJnYtsHkanyojszAsz33oDGfK8dwthyxg5KIOcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYdWRlK27ogTQ5UPZ8eCjax/9dEruJtre4v0Xx8PTDs9QjSVSAQQYKFj/oK7OoREkvFJIBSIcq5ZWREPWNnpuYlU2PIHcHvhQ1kN712dDl/cUcZ2r3WBMJMA7a6Zagh4xAWir20hBzu49c2w1zArePgQa2D6jC3ktpg3fFifyyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jHpWikjZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770119391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+TY5QcgoJWx8Xp9dn1RmI/pAgpx+W2PZvwQelh7nfcA=;
	b=jHpWikjZDh6j45AnzJ+pcw5r4vldh6W26LzamqnhZSbVYRRQOj4Ly6OjDilkqWKYpbHI1m
	mJwD1oJ2V3lvSZGFkzpIhwG4QZVJuO6O6wdWSDysgq+SL0R2Z+2pJwuH8j10ZgyKS62jpV
	2OexEo2llJcJX6dbbiC8S1BTLyVRMrs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-c8OV0a4GM-2NfdXtd1UHJw-1; Tue,
 03 Feb 2026 06:49:48 -0500
X-MC-Unique: c8OV0a4GM-2NfdXtd1UHJw-1
X-Mimecast-MFC-AGG-ID: c8OV0a4GM-2NfdXtd1UHJw_1770119386
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F63218005B0;
	Tue,  3 Feb 2026 11:49:46 +0000 (UTC)
Received: from thinkpad (unknown [10.44.34.184])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7DCF91955F1B;
	Tue,  3 Feb 2026 11:49:42 +0000 (UTC)
Date: Tue, 3 Feb 2026 12:49:39 +0100
From: Felix Maurer <fmaurer@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	jkarrenpalo@gmail.com, tglx@linutronix.de, mingo@kernel.org,
	allison.henderson@oracle.com, petrm@nvidia.com, antonio@openvpn.net,
	Yoann Congal <yoann.congal@smile.fr>
Subject: Re: [PATCH net-next v2 6/9] hsr: Implement more robust duplicate
 discard for HSR
Message-ID: <aYHg08WMQyQKmgZO@thinkpad>
References: <cover.1769093335.git.fmaurer@redhat.com>
 <07b90a435ed7d3450c1949e3a21910916d8538de.1769093335.git.fmaurer@redhat.com>
 <20260129144348.CIs44m-d@linutronix.de>
 <aXuIAFJ_m6gMUFFO@thinkpad>
 <aXugXpSajp6jzG1o@thinkpad>
 <aXyJTzwJ3x34B-xR@thinkpad>
 <20260202175311.m2Qu8pEp@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202175311.m2Qu8pEp@linutronix.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256264-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D1CD3D89DA
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 06:53:11PM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-01-30 11:34:55 [+0100], Felix Maurer wrote:
> > I took another look at this. I think the IEC 62439-3:2021 is not super
> > clear on this (it often refers to "duplicate frames" without being exact
> > about in which domain they are duplicates). But the section on HSR Modes
> > (5.3.2.1) is quite telling when all modes are read in combination.
> >
> > First, there is the mode H, which is the default and mandatory to
> > implement. In this mode, a node should forward all frames "except for
> > frames sent by the node itself, duplicate frames and frames for which
> > the node is the unique destination". Note that "duplicate frame" is not
> > further specified here. As we don't implement different modes, we should
> > follow mode H in our implementation.
> >
> > In contrast, there is also mode X (sometimes referred to as "traffic
> > reduction").  It is supposed to work like mode H, but without sending
> > "counter-duplicates", i.e., frames that are "a duplicate of a frame that
> > it received [...] from the opposite direction."
> >
> > To me, this means two things for mode H, i.e., what we should be doing:
> > - For a frame with one sequence number coming from one node, we should
> >   be forwarding the frame once in each direction.
> > - There could be duplicates of these frames in either direction that we
> >   should not forward. This is also hinted at in other parts of the
> >   standard, that there could be multiple duplicates, especially when HSR
> >   rings are coupled.
> >
> > Therefore, I think it is correct to do the duplicate tracking once for
> > each port, especially separately for port A and port B.
>
> I will not argue with you here.
> But. :)
> If you track duplicates for A and B and see a duplicate on port A then
> this indicates that the sender of this packet did not remove it from the
> ring once it received it back. This looks like a failure.

I agree, it looks like a failure. I tried to find the reason why the
standard is so explicitly asking for discarding duplicates within the
ring, as that implies that sometimes such duplicates happen in normal
operation. In most cases, IMHO, there should not be any duplicates in
the same direction in the ring, if the nodes behave correctly.

I think the duplicates can occur on RedBoxes if they are used to couple
the HSR ring and another redundant network (either with a PRP network
through HSR-PRP mode or with an HSR network through HSR-HSR mode, which
we both don't implement at the moment). In both cases, two RedBoxes are
used to maintain redundancy and both independently inject a frame they
receive into the HSR ring (see Figure 12 and 16 in the IEC
62439-3:2021). But it's also the RedBoxes that would remove the
duplicates, so we would be aware that we should discard duplicates on
port A and B.

However, I'm not sure if these are the only cases where duplicates are
to be expected in the ring and I don't want to prematurely make the
decision to just forward everything within the ring.

> If you track duplicates for A and B in a single "bitmap" then this would
> mode X.

I think I didn't understand this clearly and I mixed this up in some of
my replies, so just to make sure; there are two ideas:
1) Track port A and B together, i.e., don't forward the
   counter-duplicate, i.e., Mode X (which is optional to implement).
2) Don't track duplicates for port A or B at all. We consider duplicates
   in the ring as a failure of another node.

We don't consider 1), i.e., Mode X, at the moment. We are only
discussing idea 2), right?

> I nag here a bit because you allocate 16 + (128 / 8) * 4 * 64 = 4112
> bytes for this bitmap per node. That is a bit over 4kib. Then adding and
> removing sequences got a bit more expensive. Anyway. There is table
> F.19+ specifying HSR tests and don't find "forwarding duplicate over
> port A". So lets keep it.

I totally understand that. It's quite some memory for each node and I'm
very much in for reducing that. But I'd suggest that, for now, we follow
what we had before and what the standard explicitly asks, which is to
track (and discard) duplicates on port A and B as well. I'm not sure if
we should diverge from the standard in one of the few points where it is
explicit. If I understand your last sentence correctly, you're okay with
that as well?

Thanks,
   Felix


