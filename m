Return-Path: <netdev+bounces-238366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63878C57DE5
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 15:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFD103BBB82
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 13:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F3821883E;
	Thu, 13 Nov 2025 13:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="LS/L7S7h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jsZRJWn2"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6219C21D3F3
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 13:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763041719; cv=none; b=S/8XsPfgNJWo6Cu2YUa6V+qfSpfLVzqQ0tOCJlooMYXPYKCz6hb1MwBs3ovIs0DIZ+pQHlSj4grY6BgrJ7ABSSuxONbHsv/0LrdPqdXe4bDr3lWf/Hlv6Jq0MVePFV7LvdRaNCj9FDM2QC02ju76sPFrlSPB6SSDxIf1SfB7UWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763041719; c=relaxed/simple;
	bh=gC9xFfMOY9jh1sK28xagC7f/6aBGtYezftueqEsw/xM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVVsT9Tx56AIJOKmdcrPqE4YKvvpUUE6NXz9YZzRV3ftaSLlhe+gNIWi72vsVA06NIv6lBz4aKTHw9onpAbRDs4DkbsJo/t0FVwqrZGNTNV2K5T2Nny02h+xa/ggYY2TyJFRvyz0cbgW2fDEZjZSBbs1p/jK4a3XEplyryVd6OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=LS/L7S7h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jsZRJWn2; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 4B4D1EC01D7;
	Thu, 13 Nov 2025 08:48:35 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 13 Nov 2025 08:48:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1763041715; x=1763128115; bh=l0BSewK8sCblX9qd/K4yWf2C5QtbDG5b
	Fy7pP0mGw88=; b=LS/L7S7hQNFxSPJE3MBYTgvF40UErn5z0BpkotI0O6SwHZe7
	rK+7UnDjxhaskbTamrgN9DMR+2Uwb8NYF19O3iAyJJ0yKNvJInkmVjvxIiYsYz6I
	CwhRsot9wV2ATfdqCt2RM17fE9S7bTFe8tulvjxY6qKXpHV8b1/ztBhpul7A9BA0
	pguol1i38/RrnHEtzMNfn+pXT/2u5QTCViA5AnamxRYKmAuzZ64uk/5BDy6MvuZw
	2j6xENhBxYjeE9y/WgtQUP7zJQowQYUH2KWjB0KXidGMPM0Uq9xBbSt6NsaSrKWB
	g82AitJcGX5dsAgpWFleNUVifJWwrvIHk6jNBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763041715; x=
	1763128115; bh=l0BSewK8sCblX9qd/K4yWf2C5QtbDG5bFy7pP0mGw88=; b=j
	sZRJWn2zrv5xHGJqTmmLmoTV38iV5aSfYLmX9jnwtFRu/YmqPrzvOSwuDz6VfyAk
	Th5+SodRY2YecnEyhISO7ZD9r43OuFOcfUuDtVZCHjrkm6vy6B2bt1Q7j7IWeQ6H
	K3NMZ0H71c5B+C8B2/SLY+YoIjiZjP1BOwTpOAm0H68VpNreRBRvxI+fygDLy/63
	9Zefu0ZeikHYgWuAliAuMiGlQQQ43stPn0fJZ2/zCpFtyRmVAOPFiLy2LM0MwoSF
	0RR1kEK6C5krqaz067VivIgsFOuPs/6ZNOcBxYQi7jcarriT9UdC+ICDIAQ4+SH+
	/0t93xxxM0TzHSU2u+Ibg==
X-ME-Sender: <xms:suEVaRCiKtQghR0o2dUdjmr_XHOpbMr1Q1YDNn6CqnQWtDpn8Fij8Q>
    <xme:suEVaTOi8uH1OTNd7bZV08alXqp8SoISNDuRZYLdfKw0XTohpcBt4OvI1nlo6iYmQ
    VRcqUb9-RsYHD9_CUJIGoiI43fLOMdMv8nEgO50z0409dHtMXXc2kB1>
X-ME-Received: <xmr:suEVaWY80DtfO_SZoLTDvbANkqOW1ilQOk_m7i290tEN9v5EKHF2fBE2ePS4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdejuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefurggsrhhi
    nhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtf
    frrghtthgvrhhnpefgvdegieetffefvdfguddtleegiefhgeeuheetveevgeevjeduleef
    ffeiheelvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrlhhfsehmrghnuggvlhgsihhtrdgtoh
    hmpdhrtghpthhtoheprghnthhonhhiohesohhpvghnvhhpnhdrnhgvthdprhgtphhtthho
    pehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumh
    griigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:suEVaSvL4pMHo-5ZxLU4VSuy3Pjpg2tkY9wzJbGyla2oDs7Owdk3tw>
    <xmx:suEVaYPyMrYQ2aeCXJPxv6PEwEnqQQLjtSzcxxORlQJ-RokkeqFIrw>
    <xmx:suEVaZ4ShxP2DkWj1zbouLzi6NJP76iB0FknFc_ZG97o49QkQPCmJQ>
    <xmx:suEVaeRX7eYiq6iHo4zxrLl6az1E-8zF8aeMHDJGid9Va5KcmFFtew>
    <xmx:s-EVaZLWkEonM2OZkR5w730UEgk3NzZNIAgXFsouGnTMISEq_quF17e0>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Nov 2025 08:48:34 -0500 (EST)
Date: Thu, 13 Nov 2025 14:48:32 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Ralf Lici <ralf@mandelbit.com>
Cc: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 6/8] ovpn: consolidate crypto allocations in one
 chunk
Message-ID: <aRXhsFpwTEfne0vF@krikkit>
References: <20251111214744.12479-1-antonio@openvpn.net>
 <20251111214744.12479-7-antonio@openvpn.net>
 <aRS13OqKdhx4aVRo@krikkit>
 <7315d47ac4cd7510ad9df7760e04c49bddd92383.camel@mandelbit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7315d47ac4cd7510ad9df7760e04c49bddd92383.camel@mandelbit.com>

2025-11-13, 11:35:07 +0100, Ralf Lici wrote:
> On Wed, 2025-11-12 at 17:29 +0100, Sabrina Dubroca wrote:
> > 2025-11-11, 22:47:39 +0100, Antonio Quartulli wrote:
> > > +static unsigned int ovpn_aead_crypto_tmp_size(struct crypto_aead
> > > *tfm,
> > > +					      const unsigned int
> > > nfrags)
> > > +{
> > > +	unsigned int len = crypto_aead_ivsize(tfm);
> > > +
> > > +	if (likely(len)) {
> > 
> > Is that right?
> > 
> > Previously iv was reserved with a constant size (OVPN_NONCE_SIZE), and
> > we're always going to write some data into ->iv via
> > ovpn_pktid_aead_write, but now we're only reserving the crypto
> > algorithm's IV size (which appear to be 12, ie OVPN_NONCE_SIZE, for
> > both chachapoly and gcm(aes), so maybe it doesn't matter).
> 
> Exactly, I checked and both gcm-aes and chachapoly return an IV size
> equal to OVPN_NONCE_SIZE, as you noted. I just thought it wouldn't hurt
> to make the function a bit more generic in case we ever support
> algorithms without an IV in the future, knowing that OVPN_NONCE_SIZE
> matches ivsize for all current cases.

IMO there's not much to gain here, since the rest of the code
(ovpn_aead_encrypt/decrypt) isn't ready for it. It may even be more
confusing since this bit looks generic but the rest isn't, and
figuring out why the packets are not being encrypted/decrypted
correctly could be a bit painful.

> Also, there's a check in ovpn_aead_init to ensure that
> crypto_aead_ivsize returns the expected value, so we're covered if
> anything changes unexpectedly.

Ah, good.

Then I would prefer to just make ovpn_aead_crypto_tmp_size always use
OVPN_NONCE_SIZE, and maybe add a comment in ovpn_aead_init referencing
ovpn_aead_crypto_tmp_size.

Something like:

/* basic AEAD assumption
 * all current algorithms use OVPN_NONCE_SIZE.
 * ovpn_aead_crypto_tmp_size and ovpn_aead_encrypt/decrypt
 * expect this.
 */


Or a

    DEBUG_NET_WARN_ON_ONCE(OVPN_NONCE_SIZE != crypto_aead_ivsize(tfm));

in ovpn_aead_crypto_tmp_size, which would fire if the check in
ovpn_aead_init is ever removed.


> > > @@ -130,11 +225,7 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer,
> > > struct ovpn_crypto_key_slot *ks,
> > >  	/* AEAD Additional data */
> > >  	sg_set_buf(sg, skb->data, OVPN_AAD_SIZE);
> > >  
> > > -	req = aead_request_alloc(ks->encrypt, GFP_ATOMIC);
> > > -	if (unlikely(!req))
> > > -		return -ENOMEM;
> > > -
> > > -	ovpn_skb_cb(skb)->req = req;
> > > +	ovpn_skb_cb(skb)->crypto_tmp = tmp;
> > 
> > That should be done immediately after the allocation, so that any
> > failure before this (skb_to_sgvec_nomark, ovpn_pktid_xmit_next) will
> > not leak this blob? ovpn_aead_encrypt returns directly and lets
> > ovpn_encrypt_post handle the error and free the memory, but only after
> >  ->crypto_tmp has been set.
> > 
> > (same thing on the decrypt path)
> 
> Right, will fix both paths.

Thanks.

-- 
Sabrina

