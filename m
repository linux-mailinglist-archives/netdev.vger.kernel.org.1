Return-Path: <netdev+bounces-261501-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMvHJjyFoGknkgQAu9opvQ
	(envelope-from <netdev+bounces-261501-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 18:39:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00ECF1AC99F
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 18:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F74133013C3
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 17:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149F9426692;
	Thu, 26 Feb 2026 17:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="LSI6TqCT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j2L9eAxr"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103683D7D7F;
	Thu, 26 Feb 2026 16:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772125201; cv=none; b=TrfkovIgAL0FuTFmPbT2NNUMD0Z05VllwaoluN0FN4quPK+OLUZ6eZwqh1OI3UZC6IH74n7IuWJGFjVuJ1q8LWCB7dRS0tB5W4DmrxDc2F4wTnDP6InKNGuVNuqxYBYvlDO3lV+t19h75WkJvHF8n+xpph753GVfaj8PIYjBEHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772125201; c=relaxed/simple;
	bh=fnh5iSifVccC2P+7Bw9Ravyrahm0sqQFHCjFTlbqT1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6gdCEJwjqcdWeK1eOTDdnopiZyG0JwLalFBMaQljmIqqCnDIbbKvsmKlcGK2JCHZ776wO1LIQjLcY6cwqNhX4LGcBiIjD8T+UBjhXNO9Brf1v45Y/A0Lrl11hiI2rIoHhAXtdI/ejh/cFeHV94zn2TKUODXteuNmJ3d5AedDwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=LSI6TqCT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j2L9eAxr; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 197BD140019C;
	Thu, 26 Feb 2026 11:59:56 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 26 Feb 2026 11:59:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1772125195; x=
	1772211595; bh=rMpdeGppPamOfXcrHEpeM2JvhdgBbq/Wcs0zQ8hwPjg=; b=L
	SI6TqCTNh56+j7MsNGyoGyawIIG+05JEh6GU0T1QKUBgAOS9qAfqzi8bjQ6RPOBC
	E5E7pGXLLyNJv1wTazVwnfYLF+5bWrcam5xypVgZyxSLLo95LP6pA155BmnD7br8
	dIcZ3CqTUP7UH0iJJpFE58dqXPY78HK8ymheLtqQcf598i9Opo76aR4vIxzbdyer
	Niez65EhzVZXlF9KNya6ztCUFwh1MUBs6QfLaJEOEZlTjnwesoHkaJowAcwoF/OB
	jnrSGXf7WuYtRDXRDKmxebx/G/yyJpH7OXDwqpXT6QmUPM9rnKZPKWK1O99sfc/e
	ccK+4zA5rAAefHkAoj8iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772125195; x=1772211595; bh=rMpdeGppPamOfXcrHEpeM2JvhdgBbq/Wcs0
	zQ8hwPjg=; b=j2L9eAxr7OtIwWGTypc/mioZ2HJAZxQRgSIcxTUjD3Vf1myc0ak
	GKppsGXbvz/ILqscqe6d6NKvC1HaZ5LTwMC44PxLlCmQ+6oijk1tJ2R+qMBFP83A
	zFDojXzwgPhT1nOjMnpbAAd4E+cFOhzYEZZUBXWjwLvhzapiz/GnmcdtUM6s1fZx
	PuztRQ3PT302E8jqEp8fDmFoUQt5ew1LjIRKCNDm6bT3VruyvqugMkuKxN+tpeTS
	5UI01kNGpo2Frg3k6iQr+GKq82n8Y0+Z4FI3SbU5sWVQEDhBSOGTYZXIuoihUzMl
	a6SCw53tOLWN4/TdehXICRK6X4ho20n6HMg==
X-ME-Sender: <xms:Cnygae93VQh55DwIR8DKmI5Fq5oEQ2jVP9DeFQRETXLoDSfqrOJjQw>
    <xme:CnygabFKWWmvBZxF6aa_-1LAMbIorMIwJzjwfuGFbnHSVbm_EZiFgw0cDMMsSdvHB
    fCOx9-N9XgM_DovuvAbXCHaCTjzIhxZb1WlHHqN9zebSFkYONGvSA>
X-ME-Received: <xmr:CnygaYdkB7BEEsH0rDvLqSMzUPmmP5a236QzoJmInDlEKk_3LXeMCYSra4Az>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeeiheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedugedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnthhonhihsehphhgvnhhomhgvrdhorh
    hgpdhrtghpthhtoheprghnthhonhihrdgrnhhtohhnhiesshgvtghunhgvthdrtghomhdp
    rhgtphhtthhopehsthgvfhhfvghnrdhklhgrshhsvghrthesshgvtghunhgvthdrtghomh
    dprhgtphhtthhopehhvghrsggvrhhtsehgohhnughorhdrrghprghnrgdrohhrghdrrghu
    pdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgr
    iigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:CnygaUksIN37UpJQeUAzFBgwrB7RfjRTG0XqlAA9u9RRYFUPcMauow>
    <xmx:CnygafoQj9yp5pA2UNzwCHeCfUyUXNABf6P_d97BUenXgVEi0L9GBw>
    <xmx:CnygaZH6CQBo9gPg94As4B3h7jRXfHFvwykWcFy3N7MhC-NzW-Z1hQ>
    <xmx:CnygadT6NEsZ7O7SKLIkk9_EDULTTCJAKk99G1ub7DhkxFly89jPuQ>
    <xmx:C3ygaY6hnlc6CNOUzDf_MYCSrtHhwXhuxXin6sU4V7s1uwLOcAAky_u1>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 11:59:53 -0500 (EST)
Date: Thu, 26 Feb 2026 17:59:52 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antony Antony <antony@phenome.org>
Cc: Antony Antony <antony.antony@secunet.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chiachang Wang <chiachangwang@google.com>,
	Yan Yan <evitayan@google.com>, devel@linux-ipsec.org,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [devel-ipsec] Re: [PATCH ipsec-next v5 7/8] xfrm: add error
 messages to state migration
Message-ID: <aaB8CL1uZ8_PzyLA@krikkit>
References: <cover.1769509130.git.antony.antony@secunet.com>
 <dd1d5b341323d6e0f93057c214adf4fc51c3cbd1.1769509131.git.antony.antony@secunet.com>
 <aXygrzQrsQxGdDG5@krikkit>
 <aaBqGgkGWfjPdJRv@Antony2201.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aaBqGgkGWfjPdJRv@Antony2201.local>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261501-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,queasysnail.net:dkim,messagingengine.com:dkim,secunet.com:email]
X-Rspamd-Queue-Id: 00ECF1AC99F
X-Rspamd-Action: no action

2026-02-26, 16:43:22 +0100, Antony Antony wrote:
> On Fri, Jan 30, 2026 at 01:14:39PM +0100, Sabrina Dubroca via Devel wrote:
> > 2026-01-27, 11:43:42 +0100, Antony Antony wrote:
> > > Add descriptive(extack) error messages for all error paths
> > > in state migration. This improves diagnostics by
> > > providing clear feedback when migration fails.
> > > 
> > > Signed-off-by: Antony Antony <antony.antony@secunet.com>
> > > ---
> > > v4->v5: - added this patch
> > > ---
> > >  net/xfrm/xfrm_state.c | 13 ++++++++++---
> > >  1 file changed, 10 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> > > index 88a362e46972..2e03871ae872 100644
> > > --- a/net/xfrm/xfrm_state.c
> > > +++ b/net/xfrm/xfrm_state.c
> > > @@ -2129,15 +2129,21 @@ struct xfrm_state *xfrm_state_migrate_create(struct xfrm_state *x,
> > >  	struct xfrm_state *xc;
> > > 
> > >  	xc = xfrm_state_clone_and_setup(x, encap, m);
> > > -	if (!xc)
> > > +	if (!xc) {
> > > +		NL_SET_ERR_MSG(extack, "Failed to clone and setup state");
> > 
> > When xfrm_state_clone_and_setup fails it's because some allocation
> > failed and the user won't be able to do much about this, right? I
> > don't feel extack in those situations is super helpful.
> 
> I felt it was usefaul to know, and to log this happened. May not a great 
> idea.

I don't have a super strong opinion. IIRC that was the approach I
picked when I added extack (no extack for kernel events that the user
can't do anything about and don't result from an invalid netlink
message), but maybe that kind of stuff deserves an extack too.

Also, I thought that something that ends up returning ENOMEM to
userspace is explicit enough, without adding a string "failed to
allocate memory for $object" in extack. But I don't work on *swan, so
maybe it's more useful than I think.

(Steffen has the final word, and you're closer to him than I am :))


> > >  		return NULL;
> > > +	}
> > > 
> > > -	if (xfrm_init_state(xc) < 0)
> > > +	if (xfrm_init_state(xc) < 0) {
> > > +		NL_SET_ERR_MSG(extack, "Failed to initialize migrated state");
> > 
> > xfrm_init_state itself doesn't handle extack, but it's just a wrapper
> > around functions that do. Maybe better to make xfrm_init_state
> > propagate extack?
> 
> That is a great idea. May be in a future patch set. For now, I will drop 
> this patch from this series. To move forward quickly.

Ok. Or keep the patch with just the fixup right below this, I'm not
NACKing it.

> > >  		goto error;
> > > +	}
> > > 
> > >  	/* configure the hardware if offload is requested */
> > > -	if (xuo && xfrm_dev_state_add(net, xc, xuo, extack))
> > > +	if (xuo && xfrm_dev_state_add(net, xc, xuo, extack)) {
> > > +		NL_SET_ERR_MSG(extack, "Failed to initialize state offload");
> > 
> > We already set an extack in xfrm_dev_state_add, this chunk should be
> > dropped to avoid overwriting the more specific info we got.
> > 
> > >  		goto error;
> > > +	}
> > > 
> > >  	return xc;
> > >  error:
> > > @@ -2161,6 +2167,7 @@ int xfrm_state_migrate_install(const struct xfrm_state *x,
> > >  		xfrm_state_insert(xc);
> > >  	} else {
> > >  		if (xfrm_state_add(xc) < 0) {
> > > +			NL_SET_ERR_MSG(extack, "Failed to add migrated state");
> > 
> > Not a strong objection, but this case would be the EEXIST situation
> > from xfrm_state_add, and there's not much the user can do about this?
> 
> Fair point, but logging it still has value too, userspace can track these
> over time and adapt. Let's revisit when we add extack to xfrm_init_state.

Ok.

> > >  			if (xuo)
> > >  				xfrm_dev_state_delete(xc);
> > >  			xc->km.state = XFRM_STATE_DEAD;
> > 

-- 
Sabrina

