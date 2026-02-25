Return-Path: <netdev+bounces-261003-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HQHImkQn2neYgQAu9opvQ
	(envelope-from <netdev+bounces-261003-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 16:08:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D788C199356
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 16:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6C45300B9F5
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CDE3939BE;
	Wed, 25 Feb 2026 15:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bk0g61NM"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C9D230BEC;
	Wed, 25 Feb 2026 15:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772031995; cv=none; b=KlyJjO0i8AHrWWTpNP6RpcT88/jrYIfFfsbrXfxBGa2r0mHG7aShoIjQBBuwpvE4mMTVlgk5E5qT70LsdhOa/VMUg5llY4LmpnZ4b0P4YgD3HC6p/+1cukE/1oPvprepm6lN9I2VB0Kazy9hGAdA/fCOZQjh0D2hVJinG0xa7kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772031995; c=relaxed/simple;
	bh=YVhG/CbLxWddfCPCFJoGp0XGnJSap4YFoLkT6WLPxsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjMtqyDTeyfrEpryz0ETB8o2yGoH+UhMNkRc8ZSiZ9L0l0TzdGkZKr/vAfAk/TVqekA9HUjcymMeH2v6aVS/RIfxyE/gW1yxdPf8YYSKJtVB+aUeXfiloDs5Zz0m8n30gOHPBlkZmYw5shNeB/XiTHN9KLHXZAv5xTcR+i4kYVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bk0g61NM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=YyzqB3h3wj0ZFQ3tzFmvcazlJJUUMErmv5XYy62kmHM=; b=bk
	0g61NMiMPoJtnnJ557M9Br6/jHR/Mr6nVb5h7XvsASx8ZkwzGIsUnkVgPe1lvxsDg7tZLxAXNt0Oj
	oUgfj8fiDwEeK60PkbpH5si8iKCdaPO8QU+niL7my5aUksuMn4+FFPCyXe9YCXTp72uc6s7oobzuI
	9DGLr1gnWEpVbjE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vvGT3-008lGk-01; Wed, 25 Feb 2026 16:06:25 +0100
Date: Wed, 25 Feb 2026 16:06:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: dsa: yt921x: Add port police support
Message-ID: <a11993f5-144b-4c3e-863d-2e3104d41bf1@lunn.ch>
References: <20260225090853.2021140-1-mmyangfl@gmail.com>
 <20260225090853.2021140-3-mmyangfl@gmail.com>
 <8be7610c-c606-4c7d-8c8b-b2873bed082e@lunn.ch>
 <CAAXyoMO7YS28fwAkf93qN8Bc45qE2M6N9OzzKW+wSTJ_ujeXnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAXyoMO7YS28fwAkf93qN8Bc45qE2M6N9OzzKW+wSTJ_ujeXnQ@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261003-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim,lunn.ch:email]
X-Rspamd-Queue-Id: D788C199356
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 10:47:18PM +0800, David Yang wrote:
> On Wed, Feb 25, 2026 at 10:17 PM Andrew Lunn <andrew@lunn.ch> wrote:
> ...
> > > +/* v * 2^e */
> > > +#define ldexpi(v, e) ({ \
> > > +     __auto_type _v = (v); \
> > > +     __auto_type _e = (e); \
> > > +     _e >= 0 ? _v << _e : _v >> -_e; \
> > > +})
> > > +
> > > +/* slot (ns) * rate (/s) / 10^9 (ns/s) = 2^C * token * 4^unit */
> > > +#define rate2token(rate, unit, slot_ns, C) \
> > > +     ((u32)(ldexpi((slot_ns) * (rate), \
> > > +                   -(2 * (unit) + (C) + YT921X_TOKEN_RATE_C)) / 1000000000))
> > > +#define token2rate(token, unit, slot_ns, C) \
> > > +     (ldexpi(1000000000 * (u64)(token), \
> > > +             2 * (unit) + (C) + YT921X_TOKEN_RATE_C) / (slot_ns))
> > > +
> > > +/* burst = 2^C * token * 4^unit */
> > > +#define burst2token(burst, unit, C) ((u32)ldexpi((burst), -(2 * (unit) + (C))))
> > > +#define token2burst(token, unit, C) ldexpi((u64)(token), 2 * (unit) + (C))
> >
> > Please avoid macros like this. Write functions. The compiler will
> > inline them if that makes sense. But you gain type checking, etc.
> >
> 
> ldexpi is generic over integer types and we do type conversions in the
> formulas below. So I think it cannot be expressed as a function.

Writing functions will then help makes the types clearer. Why are type
conversions needed? Making them explicit would make the code better.

> > > +static struct yt921x_meter
> > > +yt921x_meter_tfm(struct yt921x_priv *priv, int port, unsigned int slot_ns,
> > > +              u64 rate, u64 burst, unsigned int flags,
> > > +              u32 cir_max, u32 cbs_max, int unit_max)
> > > +{
> > > +     const int C = flags & YT921X_METER_PKT_MODE ? YT921X_TOKEN_PKT_C :
> > > +                   YT921X_TOKEN_BYTE_C;
> > > +     struct device *dev = to_device(priv);
> > > +     struct yt921x_meter meter;
> > > +     bool distorted;
> > > +     u64 burst_est;
> > > +     u64 burst_max;
> > > +     u64 rate_max;
> > > +
> > > +     meter.unit = unit_max;
> > > +     rate_max = token2rate(cir_max, meter.unit, slot_ns, C);
> > > +     burst_max = token2burst(cbs_max, meter.unit, C);
> > > +
> > > +     /* Clamp rate and burst */
> > > +     if (rate > rate_max || burst > burst_max) {
> > > +             dev_warn(dev,
> > > +                      "rate %llu, burst %llu too high, max is %llu, %llu, clamping...\n",
> > > +                      rate, burst, rate_max, burst_max);
> >
> > I'm not sure clamping is the correct thing to do here. -ERANGE would
> > make it clearer that what the user requests is not possible.
> >
> 
> The maxima are way larger than the physical limitations of GbE, so
> they are also acceptable. Still it would be quite unusual for users to
> supply such values.

If they are unusual, then maybe ERANGE makes more sense, the user has
probably misunderstood the API, which can be quite easy with tc :-(

> > > +     } else if (meter.cir > cir_max) {
> > > +             WARN_ON(1);
> > > +             meter.cir = cir_max;
> >
> > What does this WARN_ON() indicate? If this fires, you want somebody
> > who is debugging it to be able to understand it.
> >
> 
> It means logical error during unit selection. Surely internal error
> and the debugger must be familiar with the implementation details, I
> think.

     } else if (WARN_ON(meter.cir > cir_max)) {
             meter.cir = cir_max;

would be more normal.

      Andrew

