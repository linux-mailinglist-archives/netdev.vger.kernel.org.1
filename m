Return-Path: <netdev+bounces-290591-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHkkH+NOD2orJAYAu9opvQ
	(envelope-from <netdev+bounces-290591-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 20:28:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB4B5AB0CD
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 20:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A4E23079AC9
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 18:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FCE361DB8;
	Thu, 21 May 2026 18:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CrIulQIY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2515A38E13F
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 18:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779387747; cv=none; b=A3avCLOb/asYPnyxkrh3NjJ5mjL2Brk1Axlp/h01OwkKN8l9esdKIcSFrra3RwpLbJGFZeRHHeszbU5p7e11izPWT/hMDtUpFccYpMKP8NAWyp69PTJKXOz7heb4te5jMxkm7eY72H0f7fIIcS9BKEF3MOOVePoxj9PihbCpM3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779387747; c=relaxed/simple;
	bh=k9AurF181x2exwKnRJljaY/5VaLbBAqNYVOsdJvZuS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWG5AqdbFo6kaMs94BPXv91oJYLx7Zsa/U9VbA9Y+Al4qIvgBpsFi6Bw+vcdOAGnIVVawvFKelWmkjAIQdUW7bCPyBhBxDD8dO9OmgRci0904UF31iE1Zwf5wiXttg/Y3Lfj1p63KR1IwoDaOdT8IDFf+LrDiQ6hKTetGT8TAGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CrIulQIY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779387745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OzJ1fElh4gv9IHJI4SOnoimlJUpeNOPWJb0z1lqLfg4=;
	b=CrIulQIYkmBzLPxS/wDoY7oEO5fDZL5PodXkqJ2ooOttyz2R2vNjJZPXF/donOorlBeQ20
	tAjBtaWXpcv/B5MXRePrthQy4ffvXkR85gctHwEaUHWM8xfnq/IFUDpk1QxnAZRtpCUws7
	nm9sVHCEIEXCaO4G5o4u37syHNPFE20=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-PlbFa3BTP1Wy1SDncSoVFg-1; Thu,
 21 May 2026 14:22:21 -0400
X-MC-Unique: PlbFa3BTP1Wy1SDncSoVFg-1
X-Mimecast-MFC-AGG-ID: PlbFa3BTP1Wy1SDncSoVFg_1779387739
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 82A15195608D;
	Thu, 21 May 2026 18:22:19 +0000 (UTC)
Received: from thinkpad (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2D39D1800347;
	Thu, 21 May 2026 18:22:14 +0000 (UTC)
Date: Thu, 21 May 2026 20:22:11 +0200
From: Felix Maurer <fmaurer@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, Jayachandran <j-rameshbabu@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>, Danish Anwar <danishanwar@ti.com>,
	Daolin Qiu <d-qiu@ti.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Neelima Muralidharan <neelima@ti.com>,
	Paolo Abeni <pabeni@redhat.com>, Praneeth Bajjuri <praneeth@ti.com>,
	Pratheesh Gangadhar TK <pratheesh@ti.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next v4] hsr: Allow to send a specific port and with
 HSR header
Message-ID: <ag9NU2iGKLlSd6tz@thinkpad>
References: <20260508-hsr_ptp-v4-1-aa19aa7c6a71@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508-hsr_ptp-v4-1-aa19aa7c6a71@linutronix.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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
	TAGGED_FROM(0.00)[bounces-290591-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,ti.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DAB4B5AB0CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 08, 2026 at 12:17:38PM +0200, Sebastian Andrzej Siewior wrote:
> HSR forwards all packets it received on slave port 1 to slave port 2 and
> one of the two copies to the user (master) interface.
> In terms of PTP this is not good because the latency introduced by
> forwarding makes the timestamp in the PTP packet inaccurate.
> The PTP packets should not be forwarded like regular packets.
>
> In order to work with PTP over HSR the following has been done:
> - PTP packets which are received are dropped within the HSR stack. That
>   means they are not forwarded or injected into the master port. If the
>   user requires them, then they need to be obtained directly from the
>   SLAVE interface.
>
> - Sending packets. If the ethernet type of the packet is ETH_P_1588 then
>   the stack assumes a header of type struct hsr_inline_header. The size
>   of this header is the same as ethhdr. As a safeguard, the header
>   contains a magic field which matches the position of h_source and it
>   needs to match HSR_INLINE_HDR.
>   Once this is verified, the header contains the port on which this
>   packet needs to be sent and if system's HSR header should be added.
>   This information is used with the HSR stack. The packet is then
>   pulled passed the custom header so the remaining stack will see the
>   actual data.
>
> - HSR HW offloading. The stack passes the skb to the requested port. The
>   driver needs to be aware of the mode (HSR/ PRP). In PRP mode, there
>   must be no offloading if the ether type is ETH_P_1588. In HSR mode it
>   needs to add a HSR header for the ETH_P_1588 ether type but none if it
>   is already ETH_P_HSR.

Hi Sebastian,

I unfortunately didn't get to properly reviewing your patch before
leaving for vacation. But in general I like what you're proposing at the
moment. The inline header feels like a bit of magic to me still, but
it's probably necessary to have some amount of magic to make the
different sending options possible. Also seems like it doesn't put too
much burden on user space.

Skimming the patch, one thing came to my mind: maybe there is a simple
way to make user space opt-in to the inline header handling, e.g.,
something like a respect-hsr-inline-header flag at socket level(?) that
only gets checked in the hsr code. Without such flag, the special
parsing wouldn't happen at all, with the flag we still check for the
inline magic value to support sending normal frames and special frames.
But this is mostly an idea, probably not too well thought through yet.

But I have one real ask: can you add a simple selftest for this? No need
to do any kind of real PTP, but just verify that we don't break any case
of the matrix "add header/includes header" x "send normally/send on
single port". Maybe just by tcpdump'ing on the other end of a veth?

Thanks,
   Felix


