Return-Path: <netdev+bounces-255994-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCsQMEX9gGk6DgMAu9opvQ
	(envelope-from <netdev+bounces-255994-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 20:38:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E50DD0924
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 20:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 206963022F42
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 19:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018CF303A37;
	Mon,  2 Feb 2026 19:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b="BamsWXUz"
X-Original-To: netdev@vger.kernel.org
Received: from oak.phenome.org (unknown [193.110.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C643C29ACD7;
	Mon,  2 Feb 2026 19:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.110.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770061122; cv=none; b=mc6VPVVG5XiHyhoy7eIGMQFo5yh+Gpc2hkiGobAPPxF2o9BClT+hSLUeoY/YyMAJ6nTqZOrHBFgr2Ej/RxRIJ0rych/2LssQftmsyexQWz8q24WG+FUENS1GSdT55+0PJcwaRRmQoR9ozYMzJu+R9UPB7pgGd6CBM0E7WOTbWL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770061122; c=relaxed/simple;
	bh=gU/qVpvNYaoUC0WMZ3bkCb7nhNCMo6mo3lYiOgCB6CQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=siCkWZhlN6eJF+D8tbiHSdakJvC1XltGZr5XZ6mjl5p9VTZEvJAAz/I+jWMLprsjKegNW4VR6HAOqKMN1OiYP+pM1EHwfaZQkpFdBWAdfSsw2tKs8SWqDwAkG4LhSsYUc8vvPOyLWSoaX8rzyr/lw9O2YFggSvETBk2d1dGbnBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org; spf=pass smtp.mailfrom=phenome.org; dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b=BamsWXUz; arc=none smtp.client-ip=193.110.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phenome.org
Authentication-Results: oak.phenome.org (amavisd); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=phenome.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=phenome.org; h=
	in-reply-to:content-transfer-encoding:content-disposition
	:content-type:content-type:mime-version:references:message-id
	:subject:subject:from:from:date:date:received; s=oak1; t=
	1770061118; x=1770925119; bh=gU/qVpvNYaoUC0WMZ3bkCb7nhNCMo6mo3lY
	iOgCB6CQ=; b=BamsWXUz36uxH/mAm6ipEtXZ7WXolOsBwJwpVLqydCXLzAml20/
	Ex94p8r+q2/5s3MJxn0eMLvIGRwQfXL3KZW1FfBqpBAIQ1PZzgJa7jiOxTYasmKh
	ewf4sFAg5nao8hWmB8uk7ugwhNNsGC20l+Dnh7rMHe6F4pDjx40yJfklhJVKgc+N
	CBiJPPyCl6zfltjnS3Jt5+9/5aVSPeRkD58/NfcTah2V4X/JztTFJuCLOyiVgnRl
	pJFOPEPuvr9EWFKUAPq7rrzRGlXYS8adKcT8YlwJfae8o8WkfzFULpDeyEKm7EXQ
	O/Dzb3F6q4gENFYjzKeKjZn+9u2rGPtDInw==
X-Virus-Scanned: amavisd at oak.phenome.org
Received: by oak.phenome.org (Postfix);
	Mon, 02 Feb 2026 20:38:37 +0100 (CET)
Date: Mon, 2 Feb 2026 20:38:35 +0100
From: Antony Antony <antony@phenome.org>
To: Nathan Harold <nharold@google.com>
Cc: antony.antony@secunet.com, Sabrina Dubroca <sd@queasysnail.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chiachang Wang <chiachangwang@google.com>,
	Yan Yan <evitayan@google.com>, devel@linux-ipsec.org,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [devel-ipsec] Re: [PATCH ipsec-next v5 3/8] xfrm: allow
 migration from UDP encapsulated to non-encapsulated ESP
Message-ID: <aYD9O5qiA1R2KIJ_@Antony2201.local>
References: <cover.1769509130.git.antony.antony@secunet.com>
 <7c30e7f8543048a384f693684ccba5f71fe8543b.1769509131.git.antony.antony@secunet.com>
 <aXyV028imsUPWSyq@krikkit>
 <aYCfVAeKGqF7MIRq@moon.secunet.de>
 <CADhJOfbkUFaPfxTBrmOnrEh2JvxPKpkxaRrSdJHZGxeoQsQTcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADhJOfbkUFaPfxTBrmOnrEh2JvxPKpkxaRrSdJHZGxeoQsQTcw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[phenome.org,none];
	R_DKIM_ALLOW(-0.20)[phenome.org:s=oak1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255994-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antony@phenome.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[phenome.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Antony2201.local:mid,android.com:url,linux-ipsec.org:email]
X-Rspamd-Queue-Id: 3E50DD0924
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 10:15:24AM -0800, Nathan Harold via Devel wrote:
> Unfortunately, I believe Android relies on this behavior (at least for
> now). We never re-send the encap parameters.
> 
> https://cs.android.com/android/platform/superproject/main/+/main:system/netd/server/XfrmController.cpp;l=1183;drc=61197364367c9e404c7da6900658f1b16c42d0da

Thanks Nathan. It is good to know.

The next question is how do you feel about changing the behavior in
Android? Would you be willing re-send ports every time the SA has it?

This will allow more flexible migration. Migrating from NAT to no NAT an
IPv6 without NAT would be possible.

If that is a bad idea, I would limit this change to the new method only.

regards,
-antony

> 
> -Nathan
> 
> 
> On Mon, Feb 2, 2026 at 4:58 AM Antony Antony via Devel <
> devel@lists.linux-ipsec.org> wrote:
> 
> > On Fri, Jan 30, 2026 at 12:28:19 +0100, Sabrina Dubroca wrote:
> > > 2026-01-27, 11:42:40 +0100, Antony Antony wrote:
> > > > The current code prevents migrating an SA from UDP encapsulation to
> > > > plain ESP. This is needed when moving from a NATed path to a non-NATed
> > > > one, for example when switching from IPv4+NAT to IPv6.
> > > >
> > > > Only copy the existing encapsulation during migration if the encap
> > > > attribute is explicitly provided.
> > >
> > > Are we sure nobody out there relies on this behavior (silently copying
> > > the existing UDP encap without having to explicitly request it in the
> > > MIGRATE request)? If there are, this patch would break their setup by
> > > clearing the encap that they expect to still be present.
> >
> > Libreswan and Android are the main users of migrate method. Libreswan sets
> > the
> > value in every call. I am guessing Android does that too.
> >
> > Yan, would this patch cause regression in Android?
> >
> > Without this fix migrating from v4 nat to v6 and no v4 nat won't  work.
> >
> > Also the ENCAP migrate with UDP port was broken before, 2017,
> > the commit 4ab47d47af20 ("xfrm: extend MIGRATE with UDP encapsulation
> > port") ?
> > So likely it was never used by older code and PF_KEY.
> >
> > For the new methed strongSwan wants to support migrating from UDP encap
> > to no UDP encap.
> >
> > regards
> > -antony
> >
> > PS : Steffen advised not to Fixes tag.
> > --
> > Devel mailing list -- devel@lists.linux-ipsec.org
> > To unsubscribe send an email to devel-leave@lists.linux-ipsec.org
> >

> -- 
> Devel mailing list -- devel@lists.linux-ipsec.org
> To unsubscribe send an email to devel-leave@lists.linux-ipsec.org


