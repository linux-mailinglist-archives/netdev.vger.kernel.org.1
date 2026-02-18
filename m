Return-Path: <netdev+bounces-259352-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iN3QMvYSlmkDZwIAu9opvQ
	(envelope-from <netdev+bounces-259352-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 20:28:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8241590DD
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 20:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6F17301FF96
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 19:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41031347BA3;
	Wed, 18 Feb 2026 19:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eh1pKMPM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D04344DAE
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 19:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771442932; cv=none; b=VB1fXvIZbx1gPWPvckKy9SpHptA1fyUmzsX8K+MuduUOLKu2elJCcHJjm/3cULgtQ47g5SAsqa/eCdW4oUxXFBwNVm7tKZFm1GvOKPIrRrP9jN8u4lerRI+SUs0varjEIT/2fZLRfczKo6aTqDhvBbhvZ0H+HCKbJ8VYo30lNeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771442932; c=relaxed/simple;
	bh=PO+xH1FUrwVZ2IXPeZh+whPAwJAR6FZJBHPt7QKcVzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9yXZTTfugdxcqZlbJeY85SNf2AjqoVZgCWJZFHQm5Z/0p4o5eZ9M+UelXKaCeNv9EZ+lhJj7xIC8Vu8/qUlX/H8qCF6eJoaK0boNMxuGvq/FKMcU88ImB8GVQECt3WCkAoxC3hCnS4kvFPri19KF2JjuZqkO+ZOC4F0CKWHyJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Eh1pKMPM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771442929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3CK4qaB4zqAyy2rhZi6J+IfjYcvDMgbjjFDmPPOFYBs=;
	b=Eh1pKMPMVfFlylMoZarXPHey9pWysV3wxNP+UjqxKEezc/7cyzBhSS48zjlbYSrFEzWEXq
	q5pOd6NapD6SzzA68pUfjsqrrdSMpbY9845DMXm7jcMqVnJ4zy0C+Gj8oImAQyOxrYvz6v
	/QvBl/53JTQOND1t7Pt5aHnOi4iFwCk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-pgEgTDdxN6CJlLq3OzoHRg-1; Wed,
 18 Feb 2026 14:28:46 -0500
X-MC-Unique: pgEgTDdxN6CJlLq3OzoHRg-1
X-Mimecast-MFC-AGG-ID: pgEgTDdxN6CJlLq3OzoHRg_1771442924
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 27FF718005AD;
	Wed, 18 Feb 2026 19:28:44 +0000 (UTC)
Received: from thinkpad (unknown [10.44.32.24])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A236C1800349;
	Wed, 18 Feb 2026 19:28:40 +0000 (UTC)
Date: Wed, 18 Feb 2026 20:28:36 +0100
From: Felix Maurer <fmaurer@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH RFC net-next 0/2] hsr: Add additional info to send/
 receive skbs
Message-ID: <aZYSvY8nUKhpLZhv@thinkpad>
References: <20260204-hsr_ptp-v1-0-b421c69a77da@linutronix.de>
 <aZNBfh81p1zBvbi2@thinkpad>
 <20260217161053.XMFBwFXg@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217161053.XMFBwFXg@linutronix.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259352-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2F8241590DD
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 05:10:53PM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-02-16 17:10:38 [+0100], Felix Maurer wrote:
> > I agree with Willem that the changes are pretty invasive in core parts
> > of the stack for a pretty narrow use case. It got me thinking what would
> > already be supported at the moment without any changes in the kernel or
> > pretty small changes. For that, I see three parts:
> >
> > 1. Userspace needs to get the full HSR+PTP frames including the headers
> >    and including the rx port information.
> >      a) Userspace should have a way to _only_ receive HSR+PTP frames
> >         instead of all traffic on one of the ports.
> > 2. We should not forward HSR+PTP frames in HSR interface to prevent
> >    creating inaccurate timing information.
> > 3. Userspace needs a way to send packets a) over just port A or B of an
> >    HSR interface, that b) already include an HSR header and should
> >    therefore go mostly unmodified.
> >
> > Is that about a correct summary?
>
> Yes. Point 3b needs to be extended by
>   " + or does not contain a HSR/PRP header and requires one by the
>   system."

Ah, I missed that! Thanks for pointing it out, that seems to be the
tricky part to me. Just be sure, you refer to the Pdelay_{Req,Resp}
messages? Or are there any other messages?

> > If I understand your patch 2 correctly, you will be maintaining two
> > sockets in userspace (one bound to each of the ports A and B through the
> > HSR interface using PACKET_HSR_BIND_PORT). Binding through the HSR
> > interface to port A/B has the very special meaning of making a socket
> > only receive a very small subset of the packets, that is PTP traffic at
> > the moment. This seems like a somewhat hidden property of the bound
> > sockets and should at least be very explicit.
>
> Technically four sockets (two for A and two for B) but in general yes.
> What you mean by hidden property/ very explicit? Document
> PACKET_HSR_BIND_PORT in packet(7) or something else?

Yes, at least that. Maybe also make it more clear in the name that this
kind of binding means that you will not receive all packets from this
port but just some (atm, PTP).

[...]
> > The other thing that came to my mind: this sounds like XDP with AF_XDP
> > could be a solution that could be used already today; not so much
> > because of their speed but because you can program what goes to the
> > stack and what ends up in userspace. It fulfills 1) + a) directly, 2)
> > implicitly by not letting these frames enter the stack, and 3) directly.
> > But I also see that handling AF_XDP sockets in userspace is quite some
> > work to do if all you really need is to separate out some traffic.
>
> Not forwarding PTP traffic needs to happen unconditionally and not to
> wait until the system is up and has the software running.

I agree that we should just do that in the kernel, no matter what else
we do to support PTP.

> However if we
> ignore this detail and can receive on interface A and send on interface
> B over XDP and get timestamps right then we have the same as the packet
> interface on the two eth devices. What is missing is sending with HSR/
> PRP header.

You wrote in another reply, and I agree with it, that sending with the
system HSR header and sequence number must go through the hsr device.
Frames that already have a header, such as Sync an FollowUp that are
forwarded, could just directly go through the slave interfaces.

I think the cases should be handled independently: to send a frame with
a full header (i.e., the forward case), we already have the AF_PACKET
socket on the slave interfaces as an option. For sending a frame just in
one direction in the HSR ring through the hsr interface, we have to come
up with something, but IMHO just for that.

I like the idea of putting the port hint in the ancillary data of the
message, but I'm not sure where to put in the skb then / how to pass it
to the hsr interface. Willem's suggestions are worth exploring I think.

Thanks,
   Felix


