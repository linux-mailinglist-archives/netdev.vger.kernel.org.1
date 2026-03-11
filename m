Return-Path: <netdev+bounces-266564-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKKII0o4sWmesgIAu9opvQ
	(envelope-from <netdev+bounces-266564-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 10:39:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD08260D15
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 10:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3DD843003BEF
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07ACD3E3C72;
	Wed, 11 Mar 2026 09:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="PAfjEfoK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qQ0bxV19"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAD93E1229
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 09:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773221196; cv=none; b=h3l6RpkMLufBZ7EkBY5go9904z+dqWf5cc0m8sxmyICAozI6maoLjfdCrt4LeQTjP+YccKteuELpzjsjewKjs4OMiO/mEKiy47gTNnhy5+Ujy+hPW+AhPFygff0WAwbZETDJyi13GGNkZzxCJS34p2kcE/E2ajfgTO+t7IDwpjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773221196; c=relaxed/simple;
	bh=1tM0oRQHBCuuNG/TzmqoQ/gfD7hAYFwVEU8BpjGj9v0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1Af2DKZ5zKDokbRvB//gV2hjuvD/5picaSgIWBx0ocjAz6A4iV0b3E8AJpDPCi00as2wO/FUfqCKg2i9bC0cq0tFV/3++qbDeRwSkPha3BvJuMfmpYIHX1EhlujSIACRF1WiDFYCw/Sem89/wjMs2nNs1eA1LUmyDp9zZuxWLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=PAfjEfoK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qQ0bxV19; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id E96941D001BA;
	Wed, 11 Mar 2026 05:26:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 11 Mar 2026 05:26:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1773221190; x=1773307590; bh=bo9mQEVg1/lOkgOwxi+CBamO5vf7YEEP
	0yFfAL+KxJc=; b=PAfjEfoKO+bB5l98pXNaRFGyMnT9a+ac/2TnFiGTjOKJgfTU
	oMnPdcs35A1WsF1EO2QwiNUKy4++1+LUfxX8vsIJCncf+D/xvskOcIhjB9vGtjet
	iV6DmKunBVgGGGSH/qUSXJ+blpTw6M09Qvmm+qrOPGkYckthP56ZO/OByNwPg6tR
	yempsTBJA6dB1dkjG+HpII35GFyHCwd5E4ufpzYFjgaQRSRgFMA/mHRq/KXSrLVy
	scfo43D2XZrJPsuBXohCs96VwuPFvGCcyHgNueGCldHBv8yPigyM3gh8//QsjpYI
	/nWT2i2njOyHkFnJ26p54WLYMvdaGbwznW8HMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773221190; x=
	1773307590; bh=bo9mQEVg1/lOkgOwxi+CBamO5vf7YEEP0yFfAL+KxJc=; b=q
	Q0bxV19+UKoZQeEFFsD+Kd8UUNG8JjvczUIGoeMTzrM5ZUbTwQbD6mVQ1NM/SgiC
	1T5Zgp7rrFCMZJqz2gcMCar/cAxVC4QSJ7NaHg/Y79J3LN70+kI3OZc/6ue4eB8X
	0CB2iYqridCMmdT5yBsk+hI4JbQ/EXZfGnCLorxXFK11c6lSN6u7+VF/H7sC8Q91
	XeI149r87hXmRBECW72VwRvD2jKxkgAjXcS+f1ETLhS89mty2A3/97CK2ViJ3Uw6
	ae9vq0CBrD7UOMuFNb66Y4HkJiaOZ/Rx/pnHaCzxlNBAin47tFvr7hjslspk5D4+
	zUGRNcnG1Ufp+jaHWB0PQ==
X-ME-Sender: <xms:RTWxabWOVINZTXAAr7SWHNVqrbeEdk97eoeK6Mtd2iBcIrT1o8xnZg>
    <xme:RTWxaZnYFUGoqEhxvh1-QATAIHfvHoFt6TumFiiDSXkS5xAin9nAzlqdIEFSdXlCY
    _Ho11zZtTK2bK-oFS3uis0S21PuRSBfna3ROWXTLmO5_NJ2F0r2HbKi>
X-ME-Received: <xmr:RTWxaSMYs0VofiKQv6sfbgp8f5kFmjQ2Afu5ZIRgz1mHeqnvqj88P1XdRt9e>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeefheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefurggsrhhi
    nhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtf
    frrghtthgvrhhnpefgvdegieetffefvdfguddtleegiefhgeeuheetveevgeevjeduleef
    ffeiheelvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepuddtpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopegvhigrlhdrsghirhhgvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepihhmvhegsggvlhesghhmrghilhdrtghomhdprhgtphht
    thhopehsthgvfhhfvghnrdhklhgrshhsvghrthesshgvtghunhgvthdrtghomhdprhgtph
    htthhopehhvghrsggvrhhtsehgohhnughorhdrrghprghnrgdrohhrghdrrghupdhrtghp
    thhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumh
    griigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoh
    ephhhorhhmsheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:RTWxaZLJpvExqg0-7NnMzrvaRo5vyD55lrNbNlkkayB1dnP2wQNUfQ>
    <xmx:RTWxaU3BL7U1YFkwXAqpZ3W4v2Lr9qylwCbYJaCXRSjbgOtshOw6_g>
    <xmx:RTWxadUBdWgHwEsr4U4tHM6L_ovwK0RMZ_6ENbMAjrTP07tFy9UtCw>
    <xmx:RTWxaWNpIff-23NLk9uIVbX-VMB2ztFOVPB_KWb6-3UrLaCt-BJWTg>
    <xmx:RjWxaYBaLYsUsbH3vcK7g_SpZOJOuxOCcMdPZNRQ72AT2J8ynq8QnBl6>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 05:26:29 -0400 (EDT)
Date: Wed, 11 Mar 2026 10:26:27 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Eyal Birger <eyal.birger@gmail.com>
Cc: Hyunwoo Kim <imv4bel@gmail.com>, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] xfrm: Fix work re-schedule after cancel in
 xfrm_nat_keepalive_net_fini()
Message-ID: <abE1Q7BMvZ1l14jF@krikkit>
References: <abBf_R81PYmafhWv@v4bel>
 <abCh2CgVS3Uw7W-_@krikkit>
 <CAHsH6GtYpoowPJe5VWMcm=CCdUernc1q-Sk6HznXxMy7LDAmrQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHsH6GtYpoowPJe5VWMcm=CCdUernc1q-Sk6HznXxMy7LDAmrQ@mail.gmail.com>
X-Rspamd-Queue-Id: 8DD08260D15
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[sin.lore.kernel.org:server fail,messagingengine.com:server fail,queasysnail.net:server fail];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266564-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,secunet.com,gondor.apana.org.au,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,queasysnail.net:dkim,queasysnail.net:email,messagingengine.com:dkim]
X-Rspamd-Action: no action

2026-03-10, 17:14:19 -0700, Eyal Birger wrote:
> Hi,
> 
> On Tue, Mar 10, 2026 at 3:57 PM Sabrina Dubroca <sd@queasysnail.net> wrote:
> >
> > Please also CC the author, and maybe additional contributors, of the
> > patch that introduced the problem you're fixing.
> >
> > 2026-03-11, 03:16:29 +0900, Hyunwoo Kim wrote:
> > > After cancel_delayed_work_sync() is called from
> > > xfrm_nat_keepalive_net_fini(), xfrm_state_fini() flushes remaining
> > > states via __xfrm_state_delete(), which calls
> > > xfrm_nat_keepalive_state_updated() to re-schedule nat_keepalive_work.
> >
> > Eyal, I'm wondering why __xfrm_state_delete() calls
> > xfrm_nat_keepalive_state_updated(). At this point the state has been
> > removed from the walk list so nat_keepalive_work() won't do
> > anything. Am I missing something?
> 
> I don't remember for sure, but I think the idea was to have the work
> run "now" so that when deleting the last nat-keepalive state it
> won't run in the future, and in general to refresh the interval and
> not wait for the next iteration.
> 
> Eyal.

Ok. I thought about this, but I'm not seeing the benefit of doing
that. Assuming we're deleting just this one state, the next run will
process all the remaining states in the same way, whether it happens
right now or at the previously scheduled time:

 - if the next run was needed by the peer we're deleting, not much
   changes except that we're recomputing the delay earlier than
   otherwise (right now instead of when deleted_state's interval runs
   out)

 - if some other state was the first to need a keepalive, we do a run
   for nothing

So I think we could drop the xfrm_nat_keepalive_state_updated call
from __xfrm_state_delete.


@Hyunwoo here again I'm not opposed to s/cancel/disable/, it makes
sense to use disable_ in a "destruct" operation where we don't plan to
need the work again. But AFAICT this schedule_delayed_work isn't
really useful.

-- 
Sabrina

