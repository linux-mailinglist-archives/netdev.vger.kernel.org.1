Return-Path: <netdev+bounces-116052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7870948DBC
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 13:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8B201C221E4
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 11:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226C21C3F36;
	Tue,  6 Aug 2024 11:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="QNrgN4nQ"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A541C3F2C
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 11:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722943960; cv=none; b=Fm5PhdHoXSKWhS+jLwfzbII1HN3/68rKqvUqYlA/gV9WToDnuWza/7mEnWgOoOtJtXVc6X7HCnZxmoNyjR01xH8WwHL2H0s0JUUUhMiOrT5gxKs/jXTg6Ib71aSaNDS4YiwEkUanapI9cTVDnw9tlQxQ8ogz3ZdGtwjp4oJOURo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722943960; c=relaxed/simple;
	bh=Q241oUaMGFlSJQ9vHQUogcqqVHQq5Smd38ZvTH+jYf0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrhEOsedbxssDEX7+BQ+6lOxbOOuc4HehrfABLxGoFNmoj0xQml5p3C3vI/KMTcZ1T+18MItamg8PmvzfN9rQF7qwCHg44otjz1L5FW5d8rHWyyU3/mrzTHBK/vf7Q9DLqRjKvQdX2VsijClPE4YWoYnr8Fg1NcgOBy6HB1OC4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=QNrgN4nQ; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 6F5FF20539;
	Tue,  6 Aug 2024 13:32:35 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H0tWupvw3IEF; Tue,  6 Aug 2024 13:32:34 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id D289F201A0;
	Tue,  6 Aug 2024 13:32:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com D289F201A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1722943954;
	bh=hbBqENPToFTZTB/vSmNx9Rm3WbF7XygdemLWbYkeES4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=QNrgN4nQbl19d0jwr2Of9FU+3udzdXa4+PTzElXA1EDUry1UXWJuhnt9XzM2PFqz1
	 7jkIYIsdcOl2V/Uw86R8H66SgBzcGElLycGZXFskEqoq1JWjhes+Vn80JzFNR1rLtY
	 IPT5vixoyklDlL2Fk4B9j2j5hcAgWRvRjIcB6h4QA/uW069zQhImgtP0wZx39XiWvL
	 8hBjwwCnkJh2NfhkbAu6+jiHw5Rgz71j7idoqzkwcsLYTgZYPHpTb7jrnzMvtZJeTU
	 CLAd18jVuaZVm2alXasxlnDN7oEEBL+7v2gu+MCWwFdwbRA2WXns1vO1gu1nmfg+E3
	 jjuookFq+YF1A==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 6 Aug 2024 13:32:34 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Aug
 2024 13:32:34 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id EC3C53182977; Tue,  6 Aug 2024 13:32:33 +0200 (CEST)
Date: Tue, 6 Aug 2024 13:32:33 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Sabrina Dubroca <sd@queasysnail.net>
CC: Christian Hopps <chopps@chopps.org>, <devel@linux-ipsec.org>,
	<netdev@vger.kernel.org>, Christian Hopps <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v8 10/16] xfrm: iptfs: add fragmenting of
 larger than MTU user packets
Message-ID: <ZrIJ0d6x3pTslQKn@gauss3.secunet.de>
References: <20240804203346.3654426-1-chopps@chopps.org>
 <20240804203346.3654426-11-chopps@chopps.org>
 <Zq__9Z4ckXNdR-Ec@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zq__9Z4ckXNdR-Ec@hog>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Mon, Aug 05, 2024 at 12:25:57AM +0200, Sabrina Dubroca wrote:
> 
> > +/**
> > + * skb_copy_bits_seq - copy bits from a skb_seq_state to kernel buffer
> > + * @st: source skb_seq_state
> > + * @offset: offset in source
> > + * @to: destination buffer
> > + * @len: number of bytes to copy
> > + *
> > + * Copy @len bytes from @offset bytes into the source @st to the destination
> > + * buffer @to. `offset` should increase (or be unchanged) with each subsequent
> > + * call to this function. If offset needs to decrease from the previous use `st`
> > + * should be reset first.
> > + *
> > + * Return: 0 on success or a negative error code on failure
> > + */
> > +static int skb_copy_bits_seq(struct skb_seq_state *st, int offset, void *to,
> > +			     int len)
> 
> Probably belongs in net/core/skbuff.c, although I'm really not
> convinced copying data around is the right way to implement the type
> of packet splitting IPTFS does (which sounds a bit like a kind of
> GSO).

I tried to come up with a 'GSO like' variant of this when I did the
initial review last year at the IPsec workshop. But it turned out
that things will get even more complicated as they are now.
We did some performance tests and it was quite compareable to
tunnel mode, so for a first implementation I'd be ok with the
copy variant.


> And there are helpers in net/core/skbuff.c (such as
> pskb_carve/pskb_extract) that seem to do similar things to what you
> need here, without as much data copying.

In case we have helpers that will fit here, we should use them of
course.


