Return-Path: <netdev+bounces-293191-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMbTIYnXGWqjzQgAu9opvQ
	(envelope-from <netdev+bounces-293191-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 20:14:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 02785607220
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 20:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E07A4301A7F6
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 18:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33033955EF;
	Fri, 29 May 2026 18:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxMr+V4x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B965637FF41
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 18:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780078469; cv=none; b=QRUww9aY9ZGB3K0jYWnqQ7M4YNigP7qwdZJdkfOS++St4H2PwR+Rda1BdBAblZwHQfEW1OEIgXXgZAxDm/DQJtU8FuxkJakLreWY5jEYGlQabaV+0RZeGFTjwhnJQ5jX68eBRCP6UNKWFT6m4bnCtjZI+BMIgp+pf78Ofnvlj3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780078469; c=relaxed/simple;
	bh=djud74fEkjZ1cuVtWqVEB3mg5zr3iJlNGnii4o1fz08=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AcNWs1ZTGCQ3zJtKjs80lOQ2mGBu3E/0bM5dNdV4nEcDVvHLHNs6YIzfJM/rCs70BMiOZsa3AhV/oAYklDfFNdOB70S25S8nOS7DB2+LQ2ZAKq6olUx//t3hrnui3kDfia8wvWZsW5GQghE9b5uJzJhlVyE6af3kg6SS8BSJbiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxMr+V4x; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7461F00893;
	Fri, 29 May 2026 18:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780078468;
	bh=rbS0n6KZIxHYMFHP35Mv2lJdUf0WP5ElCIgkJP1fFYI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hxMr+V4xcqHz5T7Ojr/D75LQl3PdH9IG/clIXWgpReWmo68LaaLu+6MdHFAEhuBfY
	 6vgTpE/Mkh0D6Jix4ipgvBFv3eyuVaHhQSQWZ13aixhS3Uy8cTes7WITLT31qLsUt6
	 4idHS91Y6T+qqcQ6ODoCc0tkbjnQszP8epH2MW9pFV9/aWe6nBLpxpA7/858Ea3V8J
	 Gxy42ugyplZ3SSsIsky0jchJkEVRbuXUko6AJm+ra+pNgfuRuF/yQzPxyzYvBWqWDO
	 uZHBC3M0gX+Qql32h7SY+jOq+dy3aVYI7RZWWDfSrzYgmz0FlJL6Q/zo5XPtE2YS46
	 tpBIXpoWgAwDA==
Date: Fri, 29 May 2026 11:14:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
 Herbert Xu <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>,
 Alessandro Schino <7991aleschino@gmail.com>
Subject: Re: [PATCH 5/9] esp: fix page frag reference leak on skb_to_sgvec
 failure
Message-ID: <20260529111427.249957c2@kernel.org>
In-Reply-To: <ahkphzYYBeoCcbRI@secunet.com>
References: <20260527084148.3489759-1-steffen.klassert@secunet.com>
	<20260527084148.3489759-6-steffen.klassert@secunet.com>
	<0902bdb9-2746-45fd-ba4d-8e5b96617b8b@redhat.com>
	<ahkphzYYBeoCcbRI@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,gondor.apana.org.au,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-293191-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 02785607220
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 29 May 2026 07:52:07 +0200 Steffen Klassert wrote:
> > > -static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
> > > +static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb, bool already_unref)
> > >  {
> > >  	struct crypto_aead *aead = x->data;
> > >  	int extralen = 0;
> > > @@ -113,7 +113,7 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
> > >  	/* Unref skb_frag_pages in the src scatterlist if necessary.
> > >  	 * Skip the first sg which comes from skb->data.
> > >  	 */
> > > -	if (req->src != req->dst)
> > > +	if (already_unref || req->src != req->dst)
> > >  		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
> > >  			skb_page_unref(page_to_netmem(sg_page(sg)),
> > >  				       skb->pp_recycle);  
> > 
> > Sashiko points the above is still unsafe:  
> 
> For the original patch submission, sashiko reported 'failed
> to apply' because it was targeted to the ipsec tree. Now
> with the full pull request it applied and it found issues,
> but now it is too late for me to fix this.
> 
> Would it be possible to integrate subtrees of net and net-next
> into the netdev CI? This would avoid such problems in future.

Sashiko is run by Google, tho. IDK why it fails to apply the patches
sometimes, happens for us too :(

