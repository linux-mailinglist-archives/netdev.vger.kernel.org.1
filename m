Return-Path: <netdev+bounces-116048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61164948D7D
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 13:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D75811F21577
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 11:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B954A1C2314;
	Tue,  6 Aug 2024 11:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="GscaZI0F"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4F01BD50F
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 11:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722942843; cv=none; b=kW1+DgDZ/rx9og128KCmu0i9BQUUwEFSf1gZ7RweD8MZl9yQa9ep3W72V0pNB24WiYMm8HPQtqXLgtrxa7ruPvth9Y7cQRids5QuhSZGEbgSrbF58qYKtS9L5qxOHubVyDyLgaa4XrduyBGxsEvanllS9Z5rGBeZVPdZhp26DJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722942843; c=relaxed/simple;
	bh=3sFzuyYhkkm7YP/WYIlDdu19pMQ+Y8Vll5+3vCD04ms=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=psmfOIY7jD9NVfmrRCO6SmI30fptMHSOYojqYrI4xqL5iBt+49OBTDrDsfipBXx7XS4mfh76ZWqIVLfkZC3SrV5cj+psDL869z/bn1aiWlqlLlAvXkKLcwM7UU3TDUaTuMwImChv8aYBcdUHz1wlReduTzOCv3bjEUBGXN5NU9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=GscaZI0F; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 8DD44201E2;
	Tue,  6 Aug 2024 13:07:57 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jk0Er3Y_Smov; Tue,  6 Aug 2024 13:07:56 +0200 (CEST)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id C3B0F201CC;
	Tue,  6 Aug 2024 13:07:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com C3B0F201CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1722942476;
	bh=RQo2zx5HAEMi2B32wFwq6qjxOmKHs2qBTAVpFOIPRec=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=GscaZI0FxsOeN/K7+fcb3j6H+6ZHaEkmi3rLH0TO/7pU0XpEvMMqgidUL2tw5BJ6g
	 yUYMjZM3FZ8fCfLn7K8iNdFBgAPgbNV7AXIHaop8Er4qM1RHD8yKhO/vPzO8YSfgDF
	 14mI7Br9hucZAGTAWczgA1TQWjDO78DuGD0bTNE3LD0h+Q1G6iZaCu09RnEPFufMHq
	 ZO6o7cSqu2oIcRNbL4/axiFEDcnBRg0ZfL+KliUz1PVbbiUiPmO3Qi6iz1T5X8cn8j
	 7mUarI/cjK/iR4oke/vxsTvD+4ehW+WDi86W5F+1CFxAX1Q8qJOVZHUEwYwtk+NEnN
	 g0WPZUiQUEffw==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 6 Aug 2024 13:07:56 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Aug
 2024 13:07:56 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id E0B3831813FE; Tue,  6 Aug 2024 13:07:55 +0200 (CEST)
Date: Tue, 6 Aug 2024 13:07:55 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Christian Hopps <chopps@chopps.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, <devel@linux-ipsec.org>,
	<netdev@vger.kernel.org>, Christian Hopps <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v8 10/16] xfrm: iptfs: add fragmenting of
 larger than MTU user packets
Message-ID: <ZrIEC3HWJpKfIz6Y@gauss3.secunet.de>
References: <20240804203346.3654426-1-chopps@chopps.org>
 <20240804203346.3654426-11-chopps@chopps.org>
 <Zq__9Z4ckXNdR-Ec@hog>
 <m2a5hr7iek.fsf@ja-home.int.chopps.org>
 <ZrHjByjZnnDgjvfo@hog>
 <m2le1aouzf.fsf@ja-home.int.chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <m2le1aouzf.fsf@ja-home.int.chopps.org>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Tue, Aug 06, 2024 at 04:54:53AM -0400, Christian Hopps wrote:
> 
> Sabrina Dubroca <sd@queasysnail.net> writes:
> 
> > 2024-08-04, 22:33:05 -0400, Christian Hopps wrote:
> > > > > +/* 1) skb->head should be cache aligned.
> > > > > + * 2) when resv is for L2 headers (i.e., ethernet) we want the cacheline to
> > > > > + * start -16 from data.
> > > > > + * 3) when resv is for L3+L2 headers IOW skb->data points at the IPTFS payload
> > > > > + * we want data to be cache line aligned so all the pushed headers will be in
> > > > > + * another cacheline.
> > > > > + */
> > > > > +#define XFRM_IPTFS_MIN_L3HEADROOM 128
> > > > > +#define XFRM_IPTFS_MIN_L2HEADROOM (64 + 16)
> > > >
> > > > How did you pick those values?
> > > 
> > > That's what the comment is talking to. When reserving space for L2 headers we
> > > pick 64 + 16 (a 2^(<=6) cacheline + 16 bytes so the the cacheline should start
> > > -16 from where skb->data will point at.
> > 
> > Hard-coding the x86 cacheline size is not a good idea. And what's the
> > 16B for? You don't know that it's enough for the actual L2 headers.
> 
> I am not hard coding the x86 cacheline. I am picking 64 as the largest cacheline that this is optimized for, it also works for smaller cachelines.

Maybe use L1_CACHE_BYTES instead of 64? This will give you
the actual size of the cacheline.

> > > > > +
> > > > > +	skb_reserve(skb, resv);
> > > > > +
> > > > > +	/* We do not want any of the tpl->headers copied over, so we do
> > > > > +	 * not use `skb_copy_header()`.
> > > > > +	 */
> > > >
> > > > This is a bit of a bad sign for the implementation. It also worries
> > > > me, as this may not be updated when changes are made to
> > > > __copy_skb_header().
> > > > (c/p'd from v1 review since this was still not answered)
> > > 
> > > I don't agree that this is a bad design at all, I'm curious what you think a good design to be.
> > 
> > Strange skb manipulations hiding in a protocol module is not good
> > design.
> 
> It's a fragmentation and aggregation protocol, it's needs work with skbs by design. It's literally the function of the protocol to manipulate packet content.
> 
> I would appreciate it if you could provide technical reasons to justify referring to things as "bad" or "strange" -- it's not helpful otherwise.
> 
> > c/p bits of core code into a module (where they will never get fixed
> > up when the core code gets updated) is always a bad idea.
> 
> I need some values from the SKB, so I copy them -- it's that simple.
> 
> > > I did specifically state why we are not re-using
> > > skb_copy_header(). The functionality is different. We are not trying
> > > to make a copy of an skb we are using an skb as a template for new
> > > skbs.
> > 
> > I saw that. That doesn't mean it's a good thing to do.
> 
> Please suggest an alternative.

Maybe create a helper like this:

void ___copy_skb_header(struct sk_buff *new, const struct sk_buff *old)
{
        new->tstamp             = old->tstamp;
        /* We do not copy old->sk */
        new->dev                = old->dev;
        memcpy(new->cb, old->cb, sizeof(old->cb)); 
        skb_dst_copy(new, old);  
        __skb_ext_copy(new, old);
        __nf_copy(new, old, false);
}

and change __copy_skb_header() to use this too. That way it gets
updated whenever something changes here.

It also might make sense to split out the generic infrastructure changes
into a separate pachset wih netdev maintainers Cced on. That would make
the changes more visible.

