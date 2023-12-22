Return-Path: <netdev+bounces-59913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A072481CA56
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 13:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 509CE28733C
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 12:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3511863F;
	Fri, 22 Dec 2023 12:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="iZKww6nW"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958CF18624
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 12:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 5CB7D20849;
	Fri, 22 Dec 2023 13:56:37 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WGqC0ea24ljF; Fri, 22 Dec 2023 13:56:36 +0100 (CET)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id CFFAC20185;
	Fri, 22 Dec 2023 13:56:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com CFFAC20185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1703249796;
	bh=iFiRMfw6pdHH+YDC2BepjaEsLP4lWMSCkqckrMH6mHQ=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=iZKww6nWGycKTMKag1fVHYLCvZaMGrkpjGcjeChMWQmv3wi/NbU/rLbeMB5eL7hYr
	 lMDUvM80rqVSPyU1/L5RSkT8Ks8pbt2vBWf6TJLfhqn0XvNubkXI8E2hg0ry4sX6dl
	 xsziSxcQrHKfK8TEeo5njNvEEX73/Gy3hsGpxuSqACswQEUlFBSkzsuvSp48xU9MZf
	 4H5lINCyWCiW9oZtMYzwqj3takz0lJ8BI/ZrzR60A3q4SDeSYXvluWxgNBTJNlBrPu
	 kt87g+URbmO2irk0iRvMz/CyTSWMNNGdi0+LKhSKMJPB8h0H2OybmKoQLEHJ+cLOab
	 FC+3EHtXObCeA==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id CB8D880004A;
	Fri, 22 Dec 2023 13:56:36 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 22 Dec 2023 13:56:36 +0100
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 22 Dec
 2023 13:56:36 +0100
Date: Fri, 22 Dec 2023 13:56:29 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
CC: Antony Antony <antony.antony@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
	<devel@linux-ipsec.org>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH v4 ipsec-next 2/2] xfrm: fix source address in icmp error
 generation from IPsec gateway
Message-ID: <ZYWHfaHKu2dT8LyX@moon.secunet.de>
Reply-To: <antony.antony@secunet.com>
References: <e9b8e0f951662162cc761ee5473be7a3f54183a7.1639872656.git.antony.antony@secunet.com>
 <bbc29793e3865a33937ae70f10016a4bc41b71fa.1703164284.git.antony.antony@secunet.com>
 <ZYU5WXhf1F+BJMAY@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZYU5WXhf1F+BJMAY@gauss3.secunet.de>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Fri, Dec 22, 2023 at 08:23:05 +0100, Steffen Klassert wrote:
> On Thu, Dec 21, 2023 at 02:12:36PM +0100, Antony Antony wrote:
> > ---
> >  net/ipv4/icmp.c | 1 -
> >  1 file changed, 1 deletion(-)
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
> >  		rt = rt2;
> >  	} else if (PTR_ERR(rt2) == -EPERM) {
> >  		if (rt)
> 
> This is generic icmp code, so I want to see an Ack from one of
> the netdev Maintainers before I merge this into the ipsec-next
> tree. Alternatively, you can just split the patchset and route
> this one to net or net-next.

Let me split the series. In case we get an Ack take the v4 series!

thank,
-antony

