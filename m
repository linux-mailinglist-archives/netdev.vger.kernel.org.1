Return-Path: <netdev+bounces-271967-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPLmEa4HxWnn5gQAu9opvQ
	(envelope-from <netdev+bounces-271967-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:17:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B479E333237
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26ABB316A01F
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 10:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADCD3DD536;
	Thu, 26 Mar 2026 10:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p8HxopNj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C5E3DCDA3
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 10:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774519604; cv=none; b=K9F+EQMaJvgO6ZPSaFr9Gz7N7a9brXe1ex1N/5h/wpYtbFuLYdBbz0LpH4chYLpcl1gr1OBt/mdfZXDpVgxuhcD5wiBaxSmU/0lFsT4JtzaRYxkbyYW1rMBHA8SvqvOqPZ1YVKG1Udd9/wwIyvIzkJnHlLFv178kM/qOOW75s+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774519604; c=relaxed/simple;
	bh=3Z4uyOsHiPvuqdElKeIpFiSC+iUoqTQh5Ehvvr1kPGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fje+Ja4j8hGcHzgw+hkx+xm86Zd/gfbD7HO4oHfjfPHLwCUF0H7ppzbhYSsOBoPiN1A2p1v+x2SAgTx2qNqMwjM8mMq9XnuApEbwqVpUCHiR2iYtHh+X/5nxqeYa3gi6mkhh5oOJM5QL0E8NHx51d9k0BndI13Ct1KnNm6HbE/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p8HxopNj; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48371104ffdso1253235e9.1
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 03:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774519600; x=1775124400; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=87Oy/L9EX9ic6ZQJ6JYJG2LSZTexkj3Tj2pljbEQdeA=;
        b=p8HxopNjRcijTotkBOUfUt7XyX1lssF+d9c647dADI4TYGg9l0Vm3Wpih8miK36ccd
         qPW7lxTmqn5Koh2mlm9I9i8Ph4Q8iledvmOJni6HPYgO6NWBHbzcAufPRQIExzYfuKoD
         oeqL45XzjMqedZrAprby9YjG/oNXhYzqHws8awF2rbYU6Tl3O6VB/tQR1X9BJMHFnnv+
         /TdcaXPHEWzYpKH0EGMqXC2QRS6VcybdHfzAHLSd5FSsXU4OzZDc+1x/VqkSBNVIwm0b
         n8uknaFh9RdOfYB3Uq6cJJHDHCpZbbOXqF0slCpftAPN596FKkNRaep1m9FAoqXE5bA/
         Moxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774519600; x=1775124400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=87Oy/L9EX9ic6ZQJ6JYJG2LSZTexkj3Tj2pljbEQdeA=;
        b=YTa8ApyMR3YCMSQNTLki7/V6WIQU5IWeT1GzBE4fsrs1nswoENV95tu0omy8+vSdNY
         ycqsXjQHZd92/NvIO3sBC7G/DMdC/55cVqXr4jlf0TnhWCvYwMyF9nTO6eKGZg0DDfQd
         IpTmbpMCSqbjCcWmjO66e8bxswtyPCFnm0rCn6oUTbYJjFUVTJpSTLdVCu109eoQewYI
         T3pfA8C4PggX/CQhrg1cKwHW1zLVfNJfvrMTJPzEP8R/pILZBM83/2XAW8f/tpcAeXHm
         qfnayPvCKSPkUBYZu13mdDJOkawLtUDrg9OucSUTjj5OxhVgxwn3H+rdR7L0o94Ek77Q
         orng==
X-Forwarded-Encrypted: i=1; AJvYcCVGlPPpfaXylkFLKC2dyAQVW8bT/d4J83FINHbR5B9uPCROkrl97UVM5JkSXAcX9Ai0WK3o+hI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIZ3bRdgEXGADn7QcXK0cIXW/+QQ7gFfd32PbsLqmPuC7L+Ma5
	qnnph38XiWmEr0nkkA9B5S/iG9lDJUF/KSP2F4At1AL1PBjehexOcKtj
X-Gm-Gg: ATEYQzy5SnREliGL5ZJz+xS7R4lchGKYj6WCERgHXyibDTBcJ1QYeY7ZoEIZdJSDqaF
	5DxIFSpWSrt72S6HeSHA6saZdJxYY1GkhfFgoag8dTEZISZ4WNBcJsTLhNI3G47mVF/31Zs0G6M
	+HOn/njp+BlUlB1IXf/odlPFqATlKJ0L/l/gf5gZ7iHi1MBVM6JxPDTaaT0lh73QOWYeLL9IQO4
	70nwh1M6FWN/8JIKZVpkGR8NICazY3K8uxL3GfRmEH6rxMzJr/Zoz9FnpPdM8nTfwUybreJ8et2
	VZEt+NaHwTeKGVE8BngTn0OW9sc6bh/MzQSjO+7mIfTptEjn9dRO05VxyjS6vMNhBwD01Q15bZg
	3/BZIj7ZfWBTb73Aj8Gm2pMhOUqo7LXEbc0sXMsggdF94xhgXVXYJIvVNwtFDu4+03Xy/8o4zGl
	N6YPGt1VjfHnRlx/0=
X-Received: by 2002:a05:600c:b86:b0:485:385f:674d with SMTP id 5b1f17b1804b1-48716071cf9mr59463375e9.8.1774519599902;
        Thu, 26 Mar 2026 03:06:39 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d50a:b400:cf79:b8bb:14ce:d80f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919e68a6sm7989318f8f.33.2026.03.26.03.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 03:06:39 -0700 (PDT)
Date: Thu, 26 Mar 2026 12:06:37 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	Tristram Ha <Tristram.Ha@microchip.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org
Subject: Re: [PATCH net v4 0/4] net: dsa: ks8995: Post-move fixes
Message-ID: <20260326100637.7xyd42yoop2faabf@skbuf>
References: <20260326-ks8995-fixups-v4-0-989abba8f077@kernel.org>
 <20260326100243.rxxmbiscjrbe3643@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326100243.rxxmbiscjrbe3643@skbuf>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271967-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B479E333237
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 12:02:43PM +0200, Vladimir Oltean wrote:
> On Thu, Mar 26, 2026 at 10:57:31AM +0100, Linus Walleij wrote:
> > This fixes some glearing issues in the Micrel KS8995 driver
> > pointed out by Vladimir.
> > 
> > This patch series implements some required functionality
> > and strips the driver down to just KS8995 deeming the other
> > "micrel" variants to be actually handled by the Microchip
> > KSZ driver.
> > 
> > If the KS8995 should actually *also* be managed by the Microchip
> > driver and this driver deleted remains to be seen. It is clearly
> > the origin chip for that hardware: it is very close to the
> > "KSZ8 family" but there are differences.
> > 
> > It definitely has a different custom tag format for proper DSA
> > tagging, but I have implemented that: I now have to figure out
> > whether to do that on top of this driver or the KSZ driver before
> > continuing.
> > 
> > In the meantime, this patch series makes the situation better.
> > 
> > Signed-off-by: Linus Walleij <linusw@kernel.org>
> > ---
> > Changes in v4:
> > - Drop the final "port isolation" (should be better named "port separation")
> >   patch, due to lack of time to revise the patch. Let's keep this one
> >   for later.
> > - Hope we can merge this first round of fixups so the driver is in some
> >   reasonable state.
> > - Link to v3: https://lore.kernel.org/r/20260219-ks8995-fixups-v3-0-a7fc63fe1916@kernel.org
> > 
> > Changes in v3:
> > - Re-tag the series for net since they are fixes.
> > - Implement mutual exclusion between .remove() and .shutdown()
> >   as found by the AI reviewer.
> > - Fix a typo in the patch dropping the KSZ chips support, 8955->8995,
> >   found by the AI reviewer.
> > - Add fallback compatibles for the deleted chips to the KSZ
> >   SPI driver.
> > - Implement port isolation.
> > - Link to v2: https://lore.kernel.org/r/20260119-ks8995-fixups-v2-0-98bd034a0d12@kernel.org
> > 
> > Changes in v2:
> > - Do port_bitmask in another way and fix a bug where BIT(port_bitmask)
> >   was used instead of just port_bitmask.
> > - Link to v1: https://lore.kernel.org/r/20260118-ks8995-fixups-v1-0-10a493f0339d@kernel.org
> > 
> > ---
> > Linus Walleij (4):
> >       net: dsa: ks8995: Add shutdown callback
> >       net: dsa: microchip: Add fallback Micrel compatibles
> >       net: dsa: ks8955: Delete KSZ8864 and KSZ8795 support
> >       net: dsa: ks8995: Add stub bridge join/leave
> > 
> >  drivers/net/dsa/ks8995.c            | 198 ++++++++++++------------------------
> >  drivers/net/dsa/microchip/ksz_spi.c |  15 +++
> >  2 files changed, 81 insertions(+), 132 deletions(-)
> > ---
> > base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
> > change-id: 20260118-ks8995-fixups-84f25ac3f407
> > 
> > Best regards,
> > -- 
> > Linus Walleij <linusw@kernel.org>
> > 
> 
> Bastien, would you mind also taking a look at this?

And also Tristram Ha. I didn't realize he is not a KSZ maintainer.
It's been a year since Woojung last sent a reply to the mailing lists.

