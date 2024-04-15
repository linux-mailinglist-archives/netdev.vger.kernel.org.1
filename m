Return-Path: <netdev+bounces-88103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3898A5BD2
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 21:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DA031C20B26
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 19:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5EC156C58;
	Mon, 15 Apr 2024 19:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="qaY35akG"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF4F1586C2
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 19:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713210892; cv=none; b=kyWkbwGTQcfa+OgLbehP1WFDQJnxA0lz4Gy0cYzJGf5k23atYK22Sn90k3AMPYSk0/pYYZsN1G4mmVcJC+2qunuVjaX31ZMeDudyxj1vc+bDus4BTrHrt/ucV+Z0FNiCVKa1lJInxN0LSEPaJgg5HP6WU635X0XtmQEamjLPkC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713210892; c=relaxed/simple;
	bh=AkfQe/ctvafTiuVlNgYmU2GoTUR4w2LoHl5LFH9wVVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=saCTTNPD4DWoqB4OJjJdosHLkzvBz9RTe5yINdfcTAHhMcb/IErdZ5OYrKpbpcIFsyuVQp6IrrCsVzCELWHTAY0DJCX6kmF/QbrFti71lhJl7J0X0J1kxK4djxzbrfKb0RkPT+u+ghmhFN3xASBGSmTisoWAe4Luk4lXXJL5UAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org; spf=none smtp.mailfrom=phenome.org; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=qaY35akG; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=phenome.org
X-KPN-MessageId: f83b9b35-fb61-11ee-8fdf-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id f83b9b35-fb61-11ee-8fdf-005056aba152;
	Mon, 15 Apr 2024 21:54:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=xbilvjDWwhCWQH2KN2dpfNj+vnXwqd5l2NkjqBNLEdY=;
	b=qaY35akGKoJEGgMgiATwpB0EhG309dYa+94otipRu46WsbFAy6gycXu/bBUavu6pz+ZGNVk744Nhk
	 tk8S+DdCB6CqLOOMNrQgJRevm0e1IdQMwFis9SC/emguZ4d2N9czy0jTio3iDXSG4GXCBk2tuNy4ED
	 hyPvG4qg7dtLYkyE=
X-KPN-MID: 33|GbqQFGjYh8qH4pO3dQpCI6KO5alkQGNxjB/VERGM7uEbYuSkXuQGbLJWAhtC1Hv
 hTM9wP+IfMVQkoCtE5UxEKgE6/xO18oWc36d0bUoyjno=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|RPz7QiUVg+Ya/1rqHE9R6q8VJqZ3g5sraVxLZYUQJ+YQ3bRMO4Y/m/ElhMLyIHo
 1J09vZnURLcbdI6fX9bLkDQ==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id fd6401fb-fb61-11ee-9f0c-005056ab7584;
	Mon, 15 Apr 2024 21:54:38 +0200 (CEST)
Date: Mon, 15 Apr 2024 21:54:37 +0200
From: Antony Antony <antony@phenome.org>
To: nicolas.dichtel@6wind.com
Cc: antony.antony@secunet.com,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devel@linux-ipsec.org, Leon Romanovsky <leon@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: Re: [PATCH ipsec-next v10 3/3] xfrm: Add dir validation to "in" data
 path lookup
Message-ID: <Zh2F_U5E9f3TSK35@Antony2201.local>
References: <0e0d997e634261fcdf16cf9f07c97d97af7370b6.1712828282.git.antony.antony@secunet.com>
 <d5e2ad71471e2895b19cb60c9a989228cd9a5d96.1712828282.git.antony.antony@secunet.com>
 <424a52f9-df2f-4205-ab9d-cd943b8a7398@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <424a52f9-df2f-4205-ab9d-cd943b8a7398@6wind.com>

On Fri, Apr 12, 2024 at 03:54:51PM +0200, Nicolas Dichtel via Devel wrote:
> Le 11/04/2024 à 11:42, Antony Antony a écrit :
> > grep -vw 0 /proc/net/xfrm_stat
> > XfrmInDirError          	3
> > 
> > Signed-off-by: Antony Antony <antony.antony@secunet.com>
> > ---
> >  include/uapi/linux/snmp.h |  1 +
> >  net/ipv6/xfrm6_input.c    |  7 +++++++
> >  net/xfrm/xfrm_input.c     | 11 +++++++++++
> >  net/xfrm/xfrm_proc.c      |  1 +
> >  4 files changed, 20 insertions(+)
> > 
> > diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
> > index 00e179c382c0..da5714e9a311 100644
> > --- a/include/uapi/linux/snmp.h
> > +++ b/include/uapi/linux/snmp.h
> > @@ -338,6 +338,7 @@ enum
> >  	LINUX_MIB_XFRMOUTSTATEINVALID,		/* XfrmOutStateInvalid */
> >  	LINUX_MIB_XFRMACQUIREERROR,		/* XfrmAcquireError */
> >  	LINUX_MIB_XFRMOUTDIRERROR,		/* XfrmOutDirError */
> > +	LINUX_MIB_XFRMINDIRERROR,		/* XfrmInDirError */
> Same here:
> LINUX_MIB_XFRMINSTATEDIRERROR / XfrmInStateDirError

yes thanks.

