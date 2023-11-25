Return-Path: <netdev+bounces-51078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 711607F9045
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 00:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 288C52811C9
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 23:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693DA30FBB;
	Sat, 25 Nov 2023 23:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="ODVvf1AZ"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AB0129
	for <netdev@vger.kernel.org>; Sat, 25 Nov 2023 15:15:21 -0800 (PST)
X-KPN-MessageId: 8062ef19-8be8-11ee-8345-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 8062ef19-8be8-11ee-8345-005056ab378f;
	Sun, 26 Nov 2023 00:15:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=udsW/65yFmP6Vs6CPk6rZHIq6fC4Oe+MROcNbB+RkYg=;
	b=ODVvf1AZL34TPJKAQYYiwwuY0dqRPx8PKXJnchbMAgH1Wvn44JAAKRHzFavt6XSc0rqGiBBwvZwZ7
	 BYw/1NwdDOsCKJX5F9e4JxKBoc9OvidkgXhOxdReTUqRoGzYZn3HZ8KXpnetdkJHHWtJjyIDOE1k5Y
	 6XVlR/vjzf5+3tvw=
X-KPN-MID: 33|gatELFvrQwESVml4wf7eX1JAycrpzJdsv/dWsb1L4kkFx1WmYhQGqDiOo2pkHPG
 Wh631ID0Vz0VpReTI84ITPz1a7x2UJ6iIiV7TGmSs6CA=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|e/9opgAs/4NrFFqAZCbT04HP85lEA81ivzPsYPahoGxu4Xg5pcG2XPKkS3fhK7C
 JY/nCFMxHw7XB3a6Sn7GAMA==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 7f5d84bb-8be8-11ee-b971-005056abf0db;
	Sun, 26 Nov 2023 00:15:19 +0100 (CET)
Date: Sun, 26 Nov 2023 00:15:18 +0100
From: Antony Antony <antony@phenome.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Antony Antony <antony.antony@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, devel@linux-ipsec.org,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: Re: [devel-ipsec] [PATCH v2 ipsec-next 2/2] xfrm: fix source address
 in icmp error generation from IPsec gateway
Message-ID: <ZWKABgdw2lImWXrZ@Antony2201.local>
References: <e9b8e0f951662162cc761ee5473be7a3f54183a7.1639872656.git.antony.antony@secunet.com>
 <300c36a0644b63228cee8d0a74be0e1e81d0fe98.1698394516.git.antony.antony@secunet.com>
 <ZVcwoX4clOp3NimG@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZVcwoX4clOp3NimG@gauss3.secunet.de>

On Fri, Nov 17, 2023 at 10:21:37AM +0100, Steffen Klassert via Devel wrote:
> On Fri, Oct 27, 2023 at 10:16:52AM +0200, Antony Antony wrote:
> > 
> > diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> > index e63a3bf99617..bec234637122 100644
> > --- a/net/ipv4/icmp.c
> > +++ b/net/ipv4/icmp.c
> > @@ -555,7 +555,6 @@ static struct rtable *icmp_route_lookup(struct net *net,
> >  					    XFRM_LOOKUP_ICMP);
> >  	if (!IS_ERR(rt2)) {
> >  		dst_release(&rt->dst);
> > -		memcpy(fl4, &fl4_dec, sizeof(*fl4));
> 
> This is not really IPsec code. The change needs either an
> Ack of one of the netdev Maintainers, or it has to go

I understand your concern. I chose to submit the change to ipsec-next as it 
is directly related to the outcome of a successful xfrm_lookup().

> through the nedev tree. Also, please consider this as
> a fix.

It is a fix:) I considered including a 'Fixes:' tag initially but ultimately 
decided against it.  My hesitation stemmed from the concern that if this fix 
were backported, it could inadvertently trigger regressions in someone’s 
test suite. This might lead to requests for a revert through the ipsec tree, 
which I am keen to avoid.

However, I do concur that this submission qualifies as a fix. Is there a way
to include the 'Fixes:' tag while also advising against backporting it to 
reduce the risk of potential regressions?

I will add the 'Fixes:' tag to the new version. When it comes to backport I 
will recomend not to backport this fix. Please keep an eye out for those 
messages. This could get backported to all curently maintained releases!

The key reason for pairing this update with my other patch ("xfrm: introduce 
forwarding of ICMP Error messages") is to proactively address any potential 
claims of a regression. Without this new patch, it's  conceivable that the 
changes could be misinterpreted as causing a regression, especially 
considering that the commit this patch addresses is 12 years old! By 
submitting them together, it should help clarify that these changes are, in 
fact, rectifying long-standing issues rather than introducing new ones.

I believe applying two patches together will provide a clearer context for 
both the changes and help streamline their acceptance and integration.

thanks,
-antony

