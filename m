Return-Path: <netdev+bounces-258920-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIlxCo1Bk2kg2wEAu9opvQ
	(envelope-from <netdev+bounces-258920-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 17:10:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0F4145F6F
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 17:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3124730075E2
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 16:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561103321D4;
	Mon, 16 Feb 2026 16:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qu/Oxczt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E732D0C63
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 16:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771258250; cv=none; b=Ptg4InW+NWhOGLKRbF2V0IlCVAsa4kYR75ek9kuquIWv2ffSklcy73Cb4c6sCd05Y+HOtaNp0M80tunTwYuiCLShsse5/duxnjEbAK+3QdCsKNvHk6lntsA/tFRiQA1e2puKbLPrQxnUVakoJ3IoBTAp7eokzhWnD5r7YwEkOFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771258250; c=relaxed/simple;
	bh=yQZwWBzgmpek5nvzZwa4g1vR3hnGN4VNyyGDgoBWQio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVHNwQvhZJDVWoARxMLm7wVyAvz/OiQ8WGTua4HEPhECPF9cboZmh09NRU10YEG3J4KS2NXpdq+TdIGfaoNf8pl48DoBOazg6qmBuuxxCN5HJgWnSPc173sf5m1oDus6sbTWgHzqUPG+11w6cvJcFzvgjGNOZh1VBfpalb7betY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qu/Oxczt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771258247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OOZHDDURA3G18WP3L2W3M40SuL2AgqxBgzEYOYKHO+w=;
	b=Qu/OxcztXi76L9JOMX2pofkq/8b+9zaYWy8jrhK6xfVQzqbearWmpy6gpGKjZXrx6d9Hwn
	ovFXa60qwkP43jRl38ELYNY1JQD770ETSz51nBcpQtarEjcwDj1rOZyq/NbnrnxDe4BMyH
	eA14z1f91AN7VwUyoaVycQ3JazIiRFM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-U-MPfyc8OgWFRJZrXZlUfw-1; Mon,
 16 Feb 2026 11:10:46 -0500
X-MC-Unique: U-MPfyc8OgWFRJZrXZlUfw-1
X-Mimecast-MFC-AGG-ID: U-MPfyc8OgWFRJZrXZlUfw_1771258244
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 38C7C19560B2;
	Mon, 16 Feb 2026 16:10:44 +0000 (UTC)
Received: from thinkpad (unknown [10.44.34.197])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 55B331955F43;
	Mon, 16 Feb 2026 16:10:41 +0000 (UTC)
Date: Mon, 16 Feb 2026 17:10:38 +0100
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
Message-ID: <aZNBfh81p1zBvbi2@thinkpad>
References: <20260204-hsr_ptp-v1-0-b421c69a77da@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204-hsr_ptp-v1-0-b421c69a77da@linutronix.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258920-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7C0F4145F6F
X-Rspamd-Action: no action

Hi Sebastian,

I had to read quite a bit about PTP and how it's supposed to be handled
in HSR rings. I've got no experience with PTP in the real world, but
here we go.

On Wed, Feb 04, 2026 at 12:24:02PM +0100, Sebastian Andrzej Siewior wrote:
> I am trying to extend linuxptp to support PTP over a HSR network. The
> user space for linuxptp are still under discussion, the thread starts at
> 	https://lists.nwtime.org/sympa/arc/linuxptp-devel/2025-11/msg00013.html
>
> the posted patches are also available at git repository for convenience
> 	https://git.kernel.org/pub/scm/linux/kernel/git/bigeasy/linuxptp-hsr.git hsr_v2
>
> This is the kernel side of the changes. In short PTP over HSR sends its
> packets to multicast address and every node needs to forward the PTP
> packet (SYNC and FOLLOW-UP for instance) within the HSR ring.
> In order to achieve this, the HSR stack must not duplicate and forward
> the PTP packets as it would with other packets. The delay caused by the
> duplication and forwarding adds overhead which in turn makes the timing
> information within the PTP packet inaccurate.
>
> My current approach is to open the hsr0 device from userland and send
> and receive the PTP packets individually on both slave interfaces. I
> added additional hints to the af_packet interface, which is used by
> linuxptp, to be able send a packet on a specific interface (A or B) and
> also to have the information recorded for received packets.
> Additionally, the PTP-timestamps which arrive on the slave interface are
> forwarded to the hsr interface.

I agree with Willem that the changes are pretty invasive in core parts
of the stack for a pretty narrow use case. It got me thinking what would
already be supported at the moment without any changes in the kernel or
pretty small changes. For that, I see three parts:

1. Userspace needs to get the full HSR+PTP frames including the headers
   and including the rx port information.
     a) Userspace should have a way to _only_ receive HSR+PTP frames
        instead of all traffic on one of the ports.
2. We should not forward HSR+PTP frames in HSR interface to prevent
   creating inaccurate timing information.
3. Userspace needs a way to send packets a) over just port A or B of an
   HSR interface, that b) already include an HSR header and should
   therefore go mostly unmodified.

Is that about a correct summary?

If I understand your patch 2 correctly, you will be maintaining two
sockets in userspace (one bound to each of the ports A and B through the
HSR interface using PACKET_HSR_BIND_PORT). Binding through the HSR
interface to port A/B has the very special meaning of making a socket
only receive a very small subset of the packets, that is PTP traffic at
the moment. This seems like a somewhat hidden property of the bound
sockets and should at least be very explicit.

Is there a reason not to create and bind one socket directly to each of
the underlying slave interfaces, with a socket filter attached to only
receive the HSR+PTP packets you want? The rx port information is
inherent to the socket this way. I'm not sure if sending over the
sockets works out of the box, but if something is needed for that, I'd
assume it's less invasive and more generally usable.

We'd still need to address 2. for this to work, but blocking forwarding
for PTP could be done in hsr_forward and friends with a much simpler
patch.

The other thing that came to my mind: this sounds like XDP with AF_XDP
could be a solution that could be used already today; not so much
because of their speed but because you can program what goes to the
stack and what ends up in userspace. It fulfills 1) + a) directly, 2)
implicitly by not letting these frames enter the stack, and 3) directly.
But I also see that handling AF_XDP sockets in userspace is quite some
work to do if all you really need is to separate out some traffic.

Thanks,
   Felix


