Return-Path: <netdev+bounces-290477-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBr9FdIeD2pSGAYAu9opvQ
	(envelope-from <netdev+bounces-290477-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 17:03:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0722C5A7DE8
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 17:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 27D633272FF8
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E0A611E;
	Thu, 21 May 2026 13:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="ewTZg83o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K7LFu0W8"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5C037C103
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 13:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779371849; cv=none; b=lSfY/TDB2gWY6m1Suiki0MKNEfMiEQwwrkUS4/5ajM1oV9EmWQbFiCOzoibiZii/jVx1TZEHN8dL7abuAgqqULF4eIwW9x6KRCDMYO5u2Ufgxn0EZYQDAd54KNm8JiSwadTnLTP0CZhN63LC1jJupIYBCSQ+tVSdfbLkFeQZ0gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779371849; c=relaxed/simple;
	bh=0DoaqcCuigWWctjbGZDv6uM+d0KKf2UHN/ogXkeypXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVij73VLkLDBHV5q/jrxkDSRxZ1HSPjvPxItHuQwfX8FbwwByi8E5dphkohhlWXGf9Ghm8gDkpg/itTIZElTcPE+HRMlQhVseDk3lg/m8cIBQoj+GIymD3ZS4dF9vb6N7a921CbeNSrI8WF7YyRj6ICNWe2Mh/62Z06TwG7hVi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=ewTZg83o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K7LFu0W8; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6C8987A00B2;
	Thu, 21 May 2026 09:57:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 21 May 2026 09:57:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1779371845; x=
	1779458245; bh=FPsjXzj7FkqynHWJfQkwyEPmoEk1/doC6g7UxnPbBj8=; b=e
	wTZg83o6DV+SSoCD0KJ99nmZp0eS4UVKRkiIJjbmjSMTT2k/+mZC8KcoiQDo97yW
	iTMic7unQe6KMUKND0lbWSKv1REEHxHfDIXgjZsMgMoWqggk3210/qH6c3aqyPyC
	+jkmfxic6P05UHAEi7Gwi0X0+Il+z9sSSmMZF5ugMeTOoqwsWO/Rj2EhKJtEhUhD
	wE6w8ZfOdJAuP2KPL/wpsNofhJzHpRtmOpA1i8Ft4VNVbtSvMSsHnR4r+c/Sk2Ry
	pfQBXBdMi8A3Oy3a0K+fNOKsmbpYScDtzj/u0Mdcx4pKjxHgyB6GPIDC9zZhL0Xa
	JYqK9CCVR/sHFcRTWQjZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779371845; x=1779458245; bh=FPsjXzj7FkqynHWJfQkwyEPmoEk1/doC6g7
	UxnPbBj8=; b=K7LFu0W8bq17vu+S0I6rBN5CH1IIeME17/AO0Ct+fK/s1C/jn0A
	5lMTEbudjgGfU5Y8ve6o6+kxg7kklw4IUiwDSMEzHabQBK/bwn0eWipGfCFGVe8Q
	dsgiTqvtpaK9UVhpC/Y1g2Dv4YZTdrLc3yKMne57ve6d3LmTVZEj4merL21tu3kR
	gT2YqdIDWsBhMdcu6lxJpOWhzagaKYZbwfUinbh2PHURaJPMZDjZBJqX80nnlCzG
	evBS2AtLy5EB7IBLbRQnlxPdsKhQqf6fwC8BJu5X3CRJJBVe37Ii/AwzKllL3QtB
	ziruOd+E8b/f6NDbq+8IKOszuLedzDKDRZg==
X-ME-Sender: <xms:RA8PapI7O-iiHM1bI5cc1M8-oOue7iTNPQRNbxdk1_v4vSD3j6Uy3A>
    <xme:RA8Pag_0hlxB9KWSDGYWqCiuQVsG3DaTdZUyeqMXuF-ibTwZnk1aHeI3QtMnOTD4b
    CHzpNlbwkkt0B0ubB0ow9HxidQIigxiJKAlwgzT4uAwYbg23hH1p9M>
X-ME-Received: <xmr:RA8PatGd4Gyf9T_BrHmepVMV04C0_F9fJyAxzpJ7kzN5IZ9G4aGUejK5S1r4S1MIe1zQdP5GOuFRvRpprKDNr7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduvddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhjvghthhifrghnihesvghvvghrphhurh
    gvuggrthgrrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepshgrvggvughmsehnvhhiughirgdrtghomhdprhgtphhtth
    hopehtrghrihhqthesnhhvihguihgrrdgtohhmpdhrtghpthhtohepmhgslhhotghhsehn
    vhhiughirgdrtghomhdprhgtphhtthhopegsohhrihhsphesnhhvihguihgrrdgtohhmpd
    hrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurg
    hvvghmlhhofhhtrdhnvght
X-ME-Proxy: <xmx:RA8Paj41xxZfHOTNG21m-JCwOo_GQoWIHnNi_3yhSIDDaFg-HWHcqA>
    <xmx:RA8Paub1WcyahEciT9K6zeDAUInBr8feMqMQEXSC1_wib9u0NMLFzw>
    <xmx:RA8PapgoQSTSq0i-0rNWCoZYY_mcdGF1DHTq2WGAT8rHx0sYhany7Q>
    <xmx:RA8Paofm7_9F-T2wXQDRM-5_hzbU66-VZfwN_lDKs1Qa3PgtyM5iHA>
    <xmx:RQ8PapdmIh7lwcFwomicKeW3QPYIlI995sgvTK7K-opwh6zzwpthrHfA>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 09:57:24 -0400 (EDT)
Date: Thu, 21 May 2026 15:57:23 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Rishikesh Jethwani <rjethwani@everpuredata.com>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
	mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com,
	kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, leon@kernel.org
Subject: Re: [PATCH v13 5/6] tls: add hardware offload key update support
Message-ID: <ag8PQ2pxvKMHglWV@krikkit>
References: <20260429181016.3164935-1-rjethwani@purestorage.com>
 <20260429181016.3164935-6-rjethwani@purestorage.com>
 <afsmVLSn2tA7UP9W@krikkit>
 <CAKaoeS2=W-WFxAmo2M_FOzS4d65L-1WM+3CJ2x3dy0U0NvMapA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKaoeS2=W-WFxAmo2M_FOzS4d65L-1WM+3CJ2x3dy0U0NvMapA@mail.gmail.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290477-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,gmail.com,kernel.org,davemloft.net,redhat.com,google.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,queasysnail.net:dkim]
X-Rspamd-Queue-Id: 0722C5A7DE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-05-12, 10:55:35 -0700, Rishikesh Jethwani wrote:
> > Not blaming you for NIC behavior, but... the NIC passes up as
> > "decrypted" records that have failed decryption (because it was using
> > the wrong (old) key), or passes as "encrypted" the incorrectly
> > decrypted data (that it has "decrypted" with the old key)?
> >
> > Or this is only the first record(s) after the KeyUpdate message, if
> > they fall within the same packet, the whole packet was "decrypted"
> > with the old key but only the KeyUpdate itself (and maybe some more
> > records before it) decrypted correctly ; but subsequent packets get
> > passed as !decrypted and don't need this reencrypt dance?
> >
> > (this is maybe more of a question for Tariq or the other @nvidia
> > folks)
> >
> >
> > I haven't reviewed the whole patch at this point, because of Paolo's
> > suggestion and this confusion with the RX rekey.
> >
> > The traces show how both NICs behave during the key transition:
> 
>   Broadcom (NIC preserves decrypted flags):
>   - decrypted=1: NIC fully decrypted these with the old key; one reencrypt
> pass (retry=0) re-encrypts those frags back to ciphertext, then SW decrypts
> with the new key.
>   - encrypted=0, decrypted=0: boundary-straddling record; same single
> reencrypt pass.
>   - encrypted=1: NIC never touched these; SW decrypts directly with the new
> key.
> 
>   Mellanox (NIC clears decrypted flags on auth failure):
>   - encrypted=0, decrypted=0: NIC partially processed the record but
> cleared all decrypted flags on auth failure. retry=0 reencrypts with the
> wrong frag interpretation and gets EBADMSG; retry=1 toggles the flags and
> succeeds.
>   - encrypted=1: NIC reported these as untouched; SW decrypts directly.
> 
>   The retry path exists specifically for the Mellanox case: cleared flags
> hide which frags the NIC actually touched, so the first pass may pick the
> wrong interpretation and need to flip it.

Thanks for describing this.

I don't think the core TLS implementation should implement workarounds
for HW/drivers doing strange things. IMO this should instead be
stuffed into a driver CB, which would implement the necessary steps to
perform during a rekey.

The core can provide a helper, but I would move the whole
"reencrypt+maybe retry" logic to a CB.

-- 
Sabrina

