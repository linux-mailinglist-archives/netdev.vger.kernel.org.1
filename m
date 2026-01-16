Return-Path: <netdev+bounces-250503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 56662D300E6
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 12:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D2343015D1A
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 11:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38E0366DC7;
	Fri, 16 Jan 2026 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b="CSngBGWX"
X-Original-To: netdev@vger.kernel.org
Received: from oak.phenome.org (unknown [193.110.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FCF366540
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 11:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.110.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768561349; cv=none; b=EaCF2eIR8jIbdleAd/gVSaT//mUGBIplGgHWXFpIwTT4cGrJTwIFbECyVVw5hgTn9zd3HvfQCg8ofpmIpwgiUSRn9lM/33UGx4X7GB2JpRt6AP1XAz2xyRRescDmYbh8OVRhoxXNnmjHWakgOPdVMbQkuqlWx85IvR4zaVgDrXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768561349; c=relaxed/simple;
	bh=VSlCp7iUGmTUW3L4RvL1ZGxYsue9P4F1nIStK/5KbpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHhRC4oZYQdKBaV1DfceQdnS92GJkd0DOQYKWnCda3DMqI8PZEXc81DUOYhZPRCFKIsYRPrc+2t5tdiUAGvgC5iDe5rE2o0MDDDtuxkXSq6AcBA2E5jQko9l3iB1D/LZclBu8QX5QSdRo8OqPH6Ho0HLGU5tpMqOrar2QyxPn4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org; spf=pass smtp.mailfrom=phenome.org; dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b=CSngBGWX; arc=none smtp.client-ip=193.110.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phenome.org
Authentication-Results: oak.phenome.org (amavisd); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=phenome.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=phenome.org; h=
	in-reply-to:content-transfer-encoding:content-disposition
	:content-type:content-type:mime-version:references:message-id
	:subject:subject:from:from:date:date:received; s=oak1; t=
	1768561335; x=1769425336; bh=VSlCp7iUGmTUW3L4RvL1ZGxYsue9P4F1nIS
	tK/5KbpM=; b=CSngBGWXuDW30AGMDLuNUshfvMuCkJmjhA8T3/ccEQTX7pAOD1m
	pJi/N2aGjEUg8JY82138zO3frq0pIN6cj43rcK8R6xcC8XD5+8+j2BkedX0Surug
	nWkfoM4Nhd9plQogMn0Y2bbYdq4VcJnaOJnv045USqEPriO2PG+MDqkgKtDpNVMX
	jKhOIcZ7lNhdErPtNrxZa2foXj3BjignUdoKqqmBD1tppK/GwtCmujB+8uoEzELm
	hen5D5sSPJAc8tqt5irJq3bDmCbMWudooJdlTAaVwcQdV3egjh8/K6zuCA8bcIIk
	dZiCdJHGDf/r59RLU4g1gpD0RMaBX+YbahA==
X-Virus-Scanned: amavisd at oak.phenome.org
Received: by oak.phenome.org (Postfix);
	Fri, 16 Jan 2026 12:02:14 +0100 (CET)
Date: Fri, 16 Jan 2026 12:02:12 +0100
From: Antony Antony <antony@phenome.org>
To: Simon Horman <horms@kernel.org>
Cc: Antony Antony <antony@phenome.org>,
	Antony Antony <antony.antony@secunet.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devel@linux-ipsec.org
Subject: Re: [devel-ipsec] Re: [PATCH ipsec-next 4/6] xfrm: add
 XFRM_MSG_MIGRATE_STATE for single SA migration
Message-ID: <aWoatI4v84lJAC48@Antony2201.local>
References: <cover.1767964254.git.antony@moon.secunet.de>
 <3558d8c20a0a973fd873ca6f50aef47a9caffcdc.1767964254.git.antony@moon.secunet.de>
 <aWZdTOXTn_YBKKhv@horms.kernel.org>
 <aWe_sIibKYzdWL9C@Antony2201.local>
 <aWjvUllZ7Clf3pm5@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aWjvUllZ7Clf3pm5@horms.kernel.org>

On Thu, Jan 15, 2026 at 01:44:50PM +0000, Simon Horman via Devel wrote:
> On Wed, Jan 14, 2026 at 05:09:20PM +0100, Antony Antony wrote:
> 
> Hi Antony,
> 
> > Hi Simon,
> > 
> > On Tue, Jan 13, 2026 at 02:57:16PM +0000, Simon Horman via Devel wrote:
> > > On Fri, Jan 09, 2026 at 02:38:05PM +0100, Antony Antony wrote:
> 
> ...
> 
> > > > +static int xfrm_send_migrate_state(const struct xfrm_user_migrate_state *um,
> > > > +				   const struct xfrm_encap_tmpl *encap,
> > > > +				   const struct xfrm_user_offload *xuo)
> > > > +{
> > > > +	int err;
> > > > +	struct sk_buff *skb;
> > > > +	struct net *net = &init_net;
> > > > +
> > > > +	skb = nlmsg_new(xfrm_migrate_state_msgsize(!!encap, !!xuo), GFP_ATOMIC);
> > > > +	if (!skb)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	err = build_migrate_state(skb, um, encap, xuo);
> > > > +	if (err < 0) {
> > > > +		WARN_ON(1);

kfree_skb(skb); replace the above line; explained bellow

> > > > +		return err;
> > > 
> > > skb seems to be leaked here.
> > > 
> > > Also flagged by Review Prompts.
> > 
> > I don't see a skb leak. It also looks similar to the functions above.
> 
> xfrm_get_ae() is the previous caller of nlmsg_new() in this file.
> It calls BUG_ON() on error, so leaking is not an issue there.
> 
> The caller before that is xfrm_get_default() which calls kfree_skb() in
> it's error path. Maybe I'm missing something obvious, but I was thinking
> that approach is appropriate here too.

You’re right. There is a leak in the error path.

The new helper I added is similar to build_migrate(), but that code uses
BUG_ON() on the error path. That feels too extreme here (even though there
are other instances of it in the same file).

I’ll follow the pattern in xfrm_get_default(): handle the error by freeing
the skb (kfree_skb()) and returning an error. And no WARN_ON().

I’ll send v3 shortly.

thanks,
-antony

