Return-Path: <netdev+bounces-267657-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDI7Op62tGm4sAAAu9opvQ
	(envelope-from <netdev+bounces-267657-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 02:15:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E57D28B326
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 02:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1E9731A9205
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 01:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BA82DCBEC;
	Sat, 14 Mar 2026 01:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="OZeUODa/";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="EWTg8vRf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875A62E11D2
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 01:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773450589; cv=none; b=Tah3ueDTUtObMW6HaRmnBpIVoq8CLnuf2+RkxZs1b278md2cLDZ0yjMO0Ue9tk1Jmv0sL4MyNcHcy2vK0rG4pie5l1u7kBYqcUz40sdSmF/RPzkRwnW6hZ290DGGSc+53b/5OV3FgegsIKIW9RkcixYY0ZDnvC+zRNlQ8ybsL0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773450589; c=relaxed/simple;
	bh=QNFUDaCsrOLeka2kBpol1pLbhT3GpOqMWFxBJkqesvE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RCIv6eZ/0eqZOPLv+0TL3pi3i68CDLJ//n85XvO9VopLpgnX7qOZlZAx4vASiZq59X9egGnKTQKSXK2545diAT5NKjzvf1B5XciV3y5l409/DBPxhTqmWzxDDqTh7yVfon5aoHSFltLICl5QdHPhV2LWOJy3+CpZY/uCwSFsN/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=OZeUODa/; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=EWTg8vRf; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 62E198b4022517;
	Sat, 14 Mar 2026 02:09:13 +0100
Received: from lubuntu-18.04 (unknown [160.80.103.126])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 931EB12045B;
	Sat, 14 Mar 2026 02:09:04 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1773450544; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=355Vr8wgyQcWOEFBUm/IrvEz2FsjymlSTqRmbfmeUao=;
	b=OZeUODa/05Dq2RLqE2cOB7nnEOQhRG/XBQRvBNFHOM5hp6oFIai0UR/yQy6elOBHJQubo+
	lpa0YOTb2OW1hLAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1773450544; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=355Vr8wgyQcWOEFBUm/IrvEz2FsjymlSTqRmbfmeUao=;
	b=EWTg8vRfGRXmnWhTzpyIKgGwOnYJKmhPv7G0fHxqaMYfHmftdpasYqOfvsb8HJtkbo7kzo
	0fPJQDt2xL2TWExUUj85isZGCWGSGWvMF5rFaRXNmFfLZVZKOTp2VHyz2DW4BB8A/FymCR
	tT3lg5OBVDKHObvGMWm1ZbihqAutKfmzHhFDOheNoxMMizqIpbSF/imTBVBuPJNiRmOrkw
	xACEV6k0hWR4buLslajnfvEidf+ydC49cQnyTlN8TW1i024pIIw6xhAYW8y6WZGD7EHNun
	7Qgj3xyQcEN4iP5S8/KMulaplTj41GueV04tDHkN0+3ajU+nhLZZHrx3KbtFuw==
Date: Sat, 14 Mar 2026 02:09:04 +0100
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Justin Iurman <justin.iurman@6wind.com>,
        Nicolas Dichtel
 <nicolas.dichtel@6wind.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, justin.iurman@gmail.com, stefano.salsano@uniroma2.it,
        paolo.lungaroni@uniroma2.it, ahabdels@cisco.com,
        Andrea Mayer
 <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net-next v2] seg6: add per-route tunnel source address
Message-Id: <20260314020904.3ec2344109a66ee70b2ec1ac@uniroma2.it>
In-Reply-To: <CAOY2BqwgYYibttTCc15a2SD=4RHMj43F47Ev20_u-a-siPzuOg@mail.gmail.com>
References: <20260311152845.278354-1-justin.iurman@6wind.com>
	<20260313030220.af70f3b5f2c5d2cb7b4a840e@uniroma2.it>
	<CAOY2Bqz8_8iT2Auw=sWob0-XUQg-sPmdAFvzRLg+KszrU6LMqA@mail.gmail.com>
	<43e16e45-5fb1-4413-bbd1-4752bbcdec7d@6wind.com>
	<CAOY2Bqx6jjBc5FCoRg+64v2L17bBsaAE8sy7P4JCwVXc+1n7_Q@mail.gmail.com>
	<3d9d384f-d001-4293-b7d5-7a88596ffc1d@6wind.com>
	<CAOY2BqwgYYibttTCc15a2SD=4RHMj43F47Ev20_u-a-siPzuOg@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[uniroma2.it,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[uniroma2.it:s=ed201904,uniroma2.it:s=rsa201904];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,google.com,redhat.com,gmail.com,uniroma2.it,cisco.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267657-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[uniroma2.it:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.mayer@uniroma2.it,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,uniroma2.it:dkim,uniroma2.it:email,uniroma2.it:mid,6wind.com:email,bootlin.com:url,srv6_hencap_red_l3vpn_test.sh:url,srv6_hl2encap_red_l2vpn_test.sh:url]
X-Rspamd-Queue-Id: 4E57D28B326
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Justin, Nicolas,

First of all, thanks both for the discussion on the link-local addresses.

On Fri, 13 Mar 2026 14:06:26 +0000
Justin Iurman <justin.iurman@6wind.com> wrote:

> On Fri, Mar 13, 2026 at 10:59 AM Nicolas Dichtel
> <nicolas.dichtel@6wind.com> wrote:
> >
> > Le 13/03/2026 à 11:20, Justin Iurman a écrit :
> > > On Fri, Mar 13, 2026 at 9:47 AM Nicolas Dichtel
> > > <nicolas.dichtel@6wind.com> wrote:
> > >>
> > >> Le 13/03/2026 à 09:44, Justin Iurman a écrit :
> > >>> On Fri, Mar 13, 2026 at 2:02 AM Andrea Mayer <andrea.mayer@uniroma2.it> wrote:
> > >>>>
> > >>>> On Wed, 11 Mar 2026 16:28:45 +0100
> > >>>> Justin Iurman <justin.iurman@6wind.com> wrote:
> > >>
> > >
> > > [snip]
> > >
> > >>>> Whether to also reject link-local is debatable: ip6_forward() does
> > >>>> drop it, but is there a legitimate use case where a link-local tunnel
> > >>>> source would actually be needed?!
> > >>>> I'd argue we should reject link-local addresses as well.
> > >>>> For instance, using them as a tunnel source violates scope boundaries and
> > >>>> breaks ICMPv6 error reporting.
> > >>>
> > >>> IMHO, I also think we could reasonably forbid LLs.
> > >>
> > >> Why rejecting LL? It's legal to use LL as a source address of a tunnel (and
> > >> forwarding packets in this tunnel). Is this forbidden with srv6?
> > >
> > > Well, this is indeed legal (at least nothing prevents it), but they're
> > > not routable. So question is does it make sense at all? We're talking
> > > about two nodes on the same layer-2 link as the only valid use-case
> > > here. I'm not sure it makes sense, especially in the context of SRv6.
> > Yes, you're probably right. I'm usually uncomfortable with a configuration being
> > forbidden without any real problem/reason.
> 
> After consideration, it looks like ip6_forward() does filter LL source
> addresses (see [1]), so such packets are never forwarded and there is
> no violation of scope boundaries. I agree it makes little sense to
> allow LL source addresses in the context of SRv6, but Nicolas has a
> point too (i.e., it's not harmful, let's not restrict things
> unnecessarily). I guess both ways are fine, maybe others can shim in
> and share their opinions. For v3, I'll just keep it as is, we can
> still make a change later.
> 
>  [1] https://elixir.bootlin.com/linux/v6.19.7/source/net/ipv6/ip6_output.c#L643

Justin, the ip6_forward() check is exactly the drop behavior I was referring
to. My initial concern was architectural, since a router wouldn't forward a
packet with a LL source anyway.

Nicolas, you make a fair point: nothing explicitly forbids using it.
I initially raised the question just to be on the safe side from the very
beginning and figure out the best path forward.
While it is a niche scenario, there can indeed exist valid use cases
(e.g., a host doing SRv6 encap with a LL source, sending it to a
directly connected SRv6 router that simply applies a decap behavior).

Since it doesn't harm the kernel, I agree we shouldn't artificially
forbid it. Allowing LLs in v3 is fine by me. Let's also see if anyone
else on the list has further thoughts on this.



Justin, regarding the other questions from your previous email about
selftests:
 
On Fri, 13 Mar 2026 08:44:04 +0000
Justin Iurman <justin.iurman@6wind.com> wrote:

> On Fri, Mar 13, 2026 at 2:02 AM Andrea Mayer <andrea.mayer@uniroma2.it> wrote:
> >
> > On Wed, 11 Mar 2026 16:28:45 +0100
> > Justin Iurman <justin.iurman@6wind.com> wrote:
> >
> > > Add SEG6_IPTUNNEL_SRC in the uapi for users to configure a specific
> > > tunnel source address. Make seg6_iptunnel handle the new attribute
> > > correctly. It has priority over the configured per-netns tunnel
> > > source address, if any.
> > >
> > > Signed-off-by: Justin Iurman <justin.iurman@6wind.com>
> > > ---
> [snip]
> 
> I agree. The reason why I did not is simply that, IIRC, none of the
> srv6 selftests actually check the source address ("ip sr tunsrc set
> xxx" is not even used, and dynamic resolution is the default
> behavior). Note that the source address is specifically checked in
> ioam6 selftest though (packet capture + parsing), but srv6 selftests
> are not designed the same way. What I suggest is to not overcomplicate
> things and simply modify srv6_hencap_red_l3vpn_test.sh and
> srv6_hl2encap_red_l2vpn_test.sh to include a test that does encap with
> "tunsrc" (and we could also add the same with "ip sr tunsrc set xxx").
> It wouldn't check for a specific source address though, would just
> make sure connectivity doesn't break like for other tests. Also, the
> other question is should we duplicate all tests for those cases: with
> "ip sr tunsrc set xxx", and with "tunsrc". WDYT?

To answer your questions:

1) Just checking for connectivity might not be sufficient here. If an
   issue causes the kernel to fall back to the default interface IP, a
   simple ping would still succeed, giving us a false positive. To verify
   the actual outer source address without overcomplicating things, we
   could maybe use policy routing (ip -6 rule) or a simple ip6tables/nftables
   rule on the receiving netns to drop the probe (ping) packet if its source
   address doesn't match the expected tunsrc.
   This is just a suggestion, of course; if you want, we can sync offline
   on this to figure out the best way to handle the selftest.

2) I don't think we need to duplicate the tests right now. We can
   consider extending the per-route tunsrc selftest to also cover the
   per-netns tunsrc later, when we start working on that specific
   per-netns fix.

>
> [snip]
>
> I agree. We could synchronize offline to squash the same fix for ioam6_iptunnel.

Yes, for sure!

Thanks,
Andrea

