Return-Path: <netdev+bounces-75092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBB6868249
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 21:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E589F28AE6F
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 20:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0288F12F388;
	Mon, 26 Feb 2024 20:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPK/GzEx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D302C2AD0F
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 20:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708981069; cv=none; b=S5RscYOs1YM6ywlPvbzC9Ot+Rinp60EeQR49gg8Y3ainXRMREYtdByAsaXuoRUPF5fnhF44Fo2Neni2OVcEMWV4DBbEgSWn9A1KoofYgaTIhlJWPL4dIW8BFtZxTyZRocrcfcTopJZ4ZRI8mls9xrvV09yK9epRqR07I5pDbofI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708981069; c=relaxed/simple;
	bh=qwsXn+5SgZ3Cm1rTV3JaGYzpWLqknrq8CshJ1ew5h6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxSmsCLHpqo6+Ykv/+g9dJ6mAA1obI03kXQRZJUJ4eETyj+8+hHR/i6eTLrvYuZ6MC97iLV/5t1+CcTAKyUqFfKIYE2xfzvpcwcOXqtYU91zcgejxFT5jldlrLm5wn7NA1YvGgKY8c5g5Q6VJKc7YFWvfGOuL+EKo1/MRFzad6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rPK/GzEx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8AEC433C7;
	Mon, 26 Feb 2024 20:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708981069;
	bh=qwsXn+5SgZ3Cm1rTV3JaGYzpWLqknrq8CshJ1ew5h6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rPK/GzExc6X6ByoQcpd8PdgDrEH4PYdFcXM8BW+m9qNzS/oNUycOKgjYJBZWhOEPR
	 SywTPwCZfwXv6lh/YY5J/FiD4HHxx0oH+o++NZvuD612wB6izF+06q2Us4G7EAmqea
	 dh6AfdbaLeLqbG83wYWdCR0l31HYhr3+SRLaJGs3Yo1canYXZimmt6JDZpPETs074J
	 TQPE394AK9nRw5pTFWzt/VdbpTv0eipLqt5VYJnXr+nY1neH9AYy2VRp677qPHU8QO
	 4mmTdd0yIBlWdwr/11TLaznu6VKpPAlcHNCUHLY1CnjJOOfFLaTGA5YyIOSJ9oH9nu
	 LlAPvZu6/iCLA==
Date: Mon, 26 Feb 2024 20:57:46 +0000
From: Simon Horman <horms@kernel.org>
To: Christian Hopps <chopps@labn.net>
Cc: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org,
	Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH ipsec-next v1 8/8] iptfs: impl: add new iptfs xfrm mode
 impl
Message-ID: <20240226205746.GK13129@kernel.org>
References: <20240219085735.1220113-1-chopps@chopps.org>
 <20240219085735.1220113-9-chopps@chopps.org>
 <20240219201349.GO40273@kernel.org>
 <m24je013cj.fsf@ja.int.chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m24je013cj.fsf@ja.int.chopps.org>

On Thu, Feb 22, 2024 at 03:23:36PM -0500, Christian Hopps wrote:
> 
> Simon Horman <horms@kernel.org> writes:
> 
> > On Mon, Feb 19, 2024 at 03:57:35AM -0500, Christian Hopps wrote:
> > > From: Christian Hopps <chopps@labn.net>
> > > 
> > > Add a new xfrm mode implementing AggFrag/IP-TFS from RFC9347.
> > > 
> > > This utilizes the new xfrm_mode_cbs to implement demand-driven IP-TFS
> > > functionality. This functionality can be used to increase bandwidth
> > > utilization through small packet aggregation, as well as help solve PMTU
> > > issues through it's efficient use of fragmentation.
> > > 
> > > Link: https://www.rfc-editor.org/rfc/rfc9347.txt
> > > 
> > > Signed-off-by: Christian Hopps <chopps@labn.net>
> > 
> > ...
> > 
> > > diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
> > 
> > ...
> > 
> > > +/**
> > > + * skb_head_to_frag() - initialize a skb_frag_t based on skb head data
> > > + * @skb: skb with the head data
> > > + * @frag: frag to initialize
> > > + */
> > > +static void skb_head_to_frag(const struct sk_buff *skb, skb_frag_t *frag)
> > > +{
> > > +	struct page *page = virt_to_head_page(skb->data);
> > > +	unsigned char *addr = (unsigned char *)page_address(page);
> > > +
> > > +	BUG_ON(!skb->head_frag);
> > 
> > Is it strictly necessary to crash the Kernel here?
> > Likewise, many other places in this patch.
> 
> In all use cases it represents a programming error (bug) if the condition is met.
> 
> What is the correct use of BUG_ON?

Hi Christian,

I would say that BUG_ON should used in situations where
there is an unrecoverable error to the extent where
the entire system cannot continue to function.

...


