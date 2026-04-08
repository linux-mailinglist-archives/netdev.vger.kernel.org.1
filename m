Return-Path: <netdev+bounces-276353-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBa2AwsR1mmxAwgAu9opvQ
	(envelope-from <netdev+bounces-276353-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 10:25:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 477E43B8FA7
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 10:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D905B3003831
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 08:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63503A1E96;
	Wed,  8 Apr 2026 08:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="jC7gDana";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ngr0rp/b"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5881A3A1E67;
	Wed,  8 Apr 2026 08:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775636710; cv=none; b=FhQCQP6drdBWfiRjlUV2L7zmPUZfvES6vZO8UwLHK060IeLeSmS7T6p9fCsSP5bh8YvNq/5Yrimf6w/2NhImxdgjkIbJf1QMTV2hva+7BAs28oCkpNPnEoBu+X5AtZBxjclokYH8wsPHaf+YPu/mAS9A79w818AaOFQip0PssVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775636710; c=relaxed/simple;
	bh=MYsVuliKoeskedgLGX+ydNaCxpDmYE4muspSAQYsSHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IICZwnvo0wQYuv0B7rkT8MBGh5lnsGMxY9p+84idSjJKVaJMZ8MNPArltOmoAH4mb9xsga5p6TYDD4PdVElW7nQuEFm2/A6eiOGc99nC4+5X8bh/VCqiZ5sxscTFE56uncUU96WCeN8OptEQrcaaFCNSqsxAN3hCoVS04JdyF34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=jC7gDana; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ngr0rp/b; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id E89E71D0003A;
	Wed,  8 Apr 2026 04:25:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 08 Apr 2026 04:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1775636705; x=
	1775723105; bh=bLVRMkiIK8Nf8+Lr2yPv9kdpziO/G9ty43AaymTwsF4=; b=j
	C7gDanaiLbLtQjX/EE7XqSVybZEaeyF8dbFJDPR6mFDlhenqbT4K9wIIeKq4rS1l
	ek8Qlyddc7oX1asNmxEDyRIJ8Lzz+xMK+NQ9ptnA5r97xLqNbIZOUUGToZtSclKi
	bECp7XHcMHP+UX5kWgBEfr/0Zqt+X/cm6PJkR1MFPFeyHA/WjlTPZ7+1JIPpW5Ts
	YyKvMnZBz3t2PoJR1kqejfsOD3OgUA2rpv1yjxDp0nq0TUqvGvptAIXlosw6XhWZ
	j2R56YHtOI+6YZ6oMBrv5VqpDIDdZwGj1CueSvVmnYazzY3ePGsmA8Ry1W1Erl4/
	nw5xwAj+isOJMMNqS1tpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775636705; x=1775723105; bh=bLVRMkiIK8Nf8+Lr2yPv9kdpziO/G9ty43A
	aymTwsF4=; b=ngr0rp/bYoNaDiyJSGMJW0YhlgkjL7nbYY2fVIekBbArY7oSJu6
	eL9QoCosXNXimEZvzZ1OJ9FOJwq7kJR6lCneLgObxg5WOhnbHD5imkPkcSJkumzS
	4C+uPVBnbiPMBW27WoaJ78VncQfVaV+aX4jFfiAWCiyjJOhhPs8sQPIAztG7t2bZ
	ZA3+zkmXClE1sDxv/0KQH/jkrnyP6FcIWWog8JV2un4AS4EMxFfc3ocFi833u12U
	EAduqke32bJVD3p3SvHXAJgPhkds1dMffdZ+4BgY6e7zoDpky3aq0Hk92gQDnHfU
	eQhB5lDV9ymHokkjvHnyXRTsd4W1Y3vRmbw==
X-ME-Sender: <xms:4BDWaUBoS-uOmRfjlRShhpVkll_8OFfnDOdanuNIzPSvDmXiH139aw>
    <xme:4BDWaYEgc7zcFeRE7dwkEJrpvnjoA74IfLoycIELv5QGJfyS0Zf8bybPTpXpOYE4h
    5GyLgSqVdm1Yb8zofLUHdbW4vYVFLZfNGA2Gr7EYvwuXOqvvHA4r9w>
X-ME-Received: <xmr:4BDWaW1Tr8frlQmxrANLMpdEwx4jbuQEMEvDrTMxx43EIW_nf7wKsKhQHpif>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvfedtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeegteehgeehieffgfeuvdeuffef
    gfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepuddvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegtrhgrthhiuhesnhhvihguihgrrdgtohhmpd
    hrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegrnhgu
    rhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvh
    gvmhhlohhfthdrnhgvthdprhgtphhtthhopehlihhnuhigqdhkshgvlhhfthgvshhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughtrghtuhhlvggrsehnvhhiug
    hirgdrtghomhdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopehsughfsehfohhmihgthhgvvhdrmhgvpdhrtghpthhtohepkhhusggrsehkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:4BDWaRNFFSRH7NskaXGn3J5HnsQeZFja3T-IFEp3yDY1gJ853l8dhQ>
    <xmx:4BDWaeaIOmoBPNdmuNYbO8lua_hDawrl2e5WyU_rAT1UY4Y2JUZuaA>
    <xmx:4BDWaXxsXczY_jJ1nsUgzwszbSHb0V3QRJzOO16M6e3naNyaGfvtYQ>
    <xmx:4BDWaVO6fvqlEZyE3c4fabMwJMpG_3giBesmMiODzxnyUb2jxJxTlg>
    <xmx:4RDWaTwuYFI4A2_i2tioIj7PPMUrMLCzuXgwiqJba6eKu-0WldLiTYoz>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 04:25:03 -0400 (EDT)
Date: Wed, 8 Apr 2026 10:25:00 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"sdf@fomichev.me" <sdf@fomichev.me>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"horms@kernel.org" <horms@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net v6 4/4] macsec: Support VLAN-filtering lower devices
Message-ID: <adYQ3OMfEEWFTd7X@krikkit>
References: <20260330130130.989236-1-cratiu@nvidia.com>
 <20260330130130.989236-5-cratiu@nvidia.com>
 <ac6BsG4IhAajip1s@krikkit>
 <e2eefeb7033caa859551834d3448a77b7af3c7d4.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e2eefeb7033caa859551834d3448a77b7af3c7d4.camel@nvidia.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm3,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276353-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[queasysnail.net:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 477E43B8FA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-04-07, 15:07:47 +0000, Cosmin Ratiu wrote:
> On Thu, 2026-04-02 at 16:48 +0200, Sabrina Dubroca wrote:
> > If this happens on a real device, the VLAN filters will be broken.
> > I'm
> > not sure what the right behavior would be:
> > 
> > 1. reject the request to enable offload
> > 2. switch to promiscuous mode
> 
> I implemented and tested option 1. In the unlikely scenario adding VLAN
> filters prevents offloading

How unlikely is it? Resource allocation, talking to HW, device limits,
anything else that could fail?

> , it's better for the driver to be explicit
> and let the user turn on promisc mode themselves. Keeping track of
> whether VLAN filters failed and promisc was used as a fallback adds
> some extra complexity.

If it's indeed (very) unlikely, sure. There's still a bit of a
regression/change of behavior for users compared to before the
IFF_UNICAST_FLT patch, but I think we can wait until someone
complains, and then add the tracking if that happens.

> What would be the point of IFF_UNICAST_FLT then?

The point is that this would just be a fallback.

> Please let me know if you agree with this approach, so I can send v8
> with it.

If you can confirm it's on the "very unlikely" side, yes, this
approach sounds ok. Thanks.

> > OTOH maybe we don't need to care, since __netdev_update_features also
> > (kind of) ignores those errors:
> > 
[...]
> 
> Well, in this case we have the chance to do something nicer (even
> proper error message back to the user via extack) for a small

(That reminds me I have a branch of "macsec: add extack to X" patches
I still need to polish and submit. I don't think I'll get to it before
the merge window opens, I'll rebase on top of your changes.)

> complexity cost. Perhaps the VLAN filter handling could be improved
> separately.

I'm not sure if this would be an "improvement to VLAN filter handling"
or a "(breaking) change of user-visible behavior". Probably
improvement. Or maybe it's "unlikely enough" that nobody has ever
cared.

-- 
Sabrina

