Return-Path: <netdev+bounces-280012-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEacHdsQ52nL3QEAu9opvQ
	(envelope-from <netdev+bounces-280012-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 07:53:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDC143695F
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 07:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66B14303A8CF
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 05:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208E233343C;
	Tue, 21 Apr 2026 05:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rp75F8HO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35D23321BF;
	Tue, 21 Apr 2026 05:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776750649; cv=none; b=tUDbxZZksqr92yZDcvzjYdkLJyYsv0UFNTSIJHu6G15kNZc6WO9ff0szpPWDm9hxKE+cFvfRcOhqioKqgVfYh8lMb3G/VjFxZUGzLSPvOfljlv8m5NoAnpf1OgA1nLIdFL7iGyw1VKX046xZTnw+tjdaFz0GPcqxJXtfT0HZPds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776750649; c=relaxed/simple;
	bh=JDTPcirY2vcsqwOGrHbuLkFCW5wOK3VLZ3Eg6V/p0rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spksU8jvfPNPET7PZbGRYPyLYsMN+LMgF+sLqr85nsDb/q6xNQoCmIfQPXxO9BoBoL95G24nL7YVeQcRE+UZ7tJmBihVZjQJAWuTDvVVrGQFaxnVkeFYFEu5qkrV4CaEnOUt+NtobTPQQR1q9IDN88oPOD7gZCwmdPEWMJo7GMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rp75F8HO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 387E7C2BCB0;
	Tue, 21 Apr 2026 05:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776750648;
	bh=JDTPcirY2vcsqwOGrHbuLkFCW5wOK3VLZ3Eg6V/p0rw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rp75F8HOPQdPClYPjZbGPYf2jB/W8YaW7RVoi3jpObCqHZOvC8ocf6PnJWBrz9IaD
	 n21KDQR0YJoBt5Wa4BdJxfMSHom+w5gkqlTIds3ZJ4QlDpO/oW3Adn0aPHyjiIomIV
	 E5S1aYNfBzJvlGFKKbYmMmRozlsEB/I/me8qaxLg=
Date: Tue, 21 Apr 2026 07:50:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, stable@kernel.org
Subject: Re: [PATCH net] ipv6: rpl: expand skb head when recompressed SRH
 grows, not only on last segment
Message-ID: <2026042140-drench-pursuable-37fa@gregkh>
References: <2026042024-cabbie-gills-9371@gregkh>
 <20260421045510.1546375-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421045510.1546375-1-kuniyu@google.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280012-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: CDDC143695F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 04:52:52AM +0000, Kuniyuki Iwashima wrote:
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Date: Mon, 20 Apr 2026 21:32:25 +0200
> > ipv6_rpl_srh_rcv() processes a Routing Protocol for LLNs Source Routing
> > Header by decompressing it, swapping the next segment address into
> > ipv6_hdr->daddr, recompressing, and pushing the new header back. The
> > recompressed header can be larger than the original when the
> > address-elision opportunities are worse after the swap.
> > 
> > The function pulls (hdr->hdrlen + 1) << 3 bytes (the old header) and
> > pushes (chdr->hdrlen + 1) << 3 + sizeof(ipv6hdr) bytes (the new header
> > plus the IPv6 header).  pskb_expand_head() is called to guarantee
> > headroom only when segments_left == 0.
> > 
> > A crafted SRH that loops back to the local host (each segment is a local
> > address, so ip6_route_input() delivers it back to ipv6_rpl_srh_rcv())
> > with chdr growing on each pass exhausts headroom over several
> > iterations.
> 
> How could this occur.. ?  Did AI generate a repro or just
> flagged the possibility ?

It generated a reproducer which caused a crash which made me have to
create this patch.  I'll dig it out of the huge pile of mess that was
sent to me and get it into a form that I can reply here to.

thanks,

greg k-h

