Return-Path: <netdev+bounces-90530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D088AE666
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 14:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A36191C21DE9
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 12:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9895D8615C;
	Tue, 23 Apr 2024 12:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="dlSzN1Ux"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B00182C60
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 12:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713875859; cv=none; b=GFUc3f++JKdEiK476zODSZ8Vo+D5jlBZeKU2OpxY9GYmi2A1rVxbGZiiAJNL0mt3ociew4926d2+e7bYT6PQ4aPSe2a9fvGhBoZnUC78m/nP13LnRr7Tn2mH9Scfd2mVJ8LmzZrnv3cHSeT4ipTG2sgdyZDkAuqyB9b6tOeq/cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713875859; c=relaxed/simple;
	bh=mWZNiQeGNCm+GlSKMQWNzURnaKu33Kd9EM7SGktlycs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Digfq7SNUjZVl/oiad9ng4X0XFTa+xbS0NzIb+gzSbZJQ9jTMocgqs90nrllotnC9LvZTTK+0VXo956GI9TqnxnwC0zBCxSZf7R94Xf1L0SV04NU8ppC4HPj6b9DR1lgONRPWlsklKC36t+fsNHGgTJG2qbMXrMqVnRde7D0SzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org; spf=none smtp.mailfrom=phenome.org; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=dlSzN1Ux; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=phenome.org
X-KPN-MessageId: 0fd797ec-016e-11ef-89f7-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 0fd797ec-016e-11ef-89f7-005056abbe64;
	Tue, 23 Apr 2024 14:36:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=HiFFx2ibMSp90yKH+o/wFo/VaTU07qd3IRStG7Mffr0=;
	b=dlSzN1UxivKV2EgIaq4xRLK05Pxt7gKa7z2Md/DHShuOGKi9q7GaSQ6qKxI9jCk+xyCVv9duGAahb
	 OaFFkgwVlMi8u1f8Ec2Lk/a7cZi1cGN+oIR5M+Ds3Pu0SY/L66LO0WTFiil8RGXqUF7fHv1Y+Q36xw
	 zJdq2Ul3heHeut+M=
X-KPN-MID: 33|YFVicq5RULF8yjJsyfp2mWxsmmjrjEqbuzHABI0CMcK+l6itGppTWcR7ba+7xv5
 xqBa8QyeFTyhgn0vQ5eeIr+4vzYT/v3PmVGm/jnWMyFs=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|ID+bo6r4q4CrW5yW6fowhbH4X5bfR3SP4cK5oWr5ZhFUnr0GKkEJ1FYVDlW7aU6
 NvngCYXrcxAJtDn1yWWLW4Q==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 19797f02-016e-11ef-a498-005056abf0db;
	Tue, 23 Apr 2024 14:36:27 +0200 (CEST)
Date: Tue, 23 Apr 2024 14:36:25 +0200
From: Antony Antony <antony@phenome.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Antony Antony <antony.antony@secunet.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devel@linux-ipsec.org, Leon Romanovsky <leon@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: Re: [devel-ipsec] [PATCH ipsec-next v11 2/4] xfrm: Add dir
 validation to "out" data path lookup
Message-ID: <ZierSZe5fykqwnFz@Antony2201.local>
References: <cover.1713737786.git.antony.antony@secunet.com>
 <bae7627414f03223034371142fa870a430cb3c5e.1713737786.git.antony.antony@secunet.com>
 <ZiYz5Om5OtivN7cV@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiYz5Om5OtivN7cV@hog>

On Mon, Apr 22, 2024 at 11:54:44AM +0200, Sabrina Dubroca via Devel wrote:
> 2024-04-22, 00:27:48 +0200, Antony Antony wrote:
> > diff --git a/net/xfrm/xfrm_proc.c b/net/xfrm/xfrm_proc.c
> > index 5f9bf8e5c933..98606f1078f7 100644
> > --- a/net/xfrm/xfrm_proc.c
> > +++ b/net/xfrm/xfrm_proc.c
> > @@ -41,6 +41,7 @@ static const struct snmp_mib xfrm_mib_list[] = {
> >  	SNMP_MIB_ITEM("XfrmFwdHdrError", LINUX_MIB_XFRMFWDHDRERROR),
> >  	SNMP_MIB_ITEM("XfrmOutStateInvalid", LINUX_MIB_XFRMOUTSTATEINVALID),
> >  	SNMP_MIB_ITEM("XfrmAcquireError", LINUX_MIB_XFRMACQUIREERROR),
> > +	SNMP_MIB_ITEM("XfrmOutStateDirError", LINUX_MIB_XFRMOUTSTATEDIRERROR),
> 
> This needs a corresponding entry in Documentation/networking/xfrm_proc.rst

fixed. I added both in and out error to it; v12.

-antony

