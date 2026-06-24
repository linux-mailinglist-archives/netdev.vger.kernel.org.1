Return-Path: <netdev+bounces-301623-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NSqhK5PEO2pUcggAu9opvQ
	(envelope-from <netdev+bounces-301623-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 13:50:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DB16BDD5E
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 13:50:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=ehpe0eWz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301623-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301623-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=secunet.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 05ACF300B29A
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 11:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E57C2BEC23;
	Wed, 24 Jun 2026 11:50:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00708194C98
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 11:50:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782301803; cv=none; b=NQ2bsOFH7XVkEeKwlibJsC2cUvuwKk6ou2lEQ0LFjCuTl0yiXsRo49z5rOk8gnmjCcdP1HCRCdh1iUI6kJFFwo6EHa8b3Oa2Qz4oVYzZDaqaV4vZgrsPNVlInYDfwdlIzXGEe8pJhKYKosFXNUBRTohRswaI3ACAb5A+B0Nc8u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782301803; c=relaxed/simple;
	bh=kcMsLWjwESVlkS7eJg9kdfJwAj1KJu+Gv0hON/ykfqw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+7VI3xpkV6JM8x3Wtc7DVrBOXksLfJIEQtB/cebz5TqnT/a6Emhynntg1RBNoq9z1c2Y5E5e4eLm3UzGiEK19hQcrRZ/fE1sXdqYuselJhwJ8as8ljZ8JTjGfWGFnOdsyIg4TsUSaCcr/WR1Y69s1FqAh8E7hyVFHAo51YTGvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=ehpe0eWz; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 5DBE920719;
	Wed, 24 Jun 2026 13:49:53 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d1y61Cwxl4zB; Wed, 24 Jun 2026 13:49:51 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 43C9F20612;
	Wed, 24 Jun 2026 13:49:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 43C9F20612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1782301791;
	bh=V9N9+Sj/8/K5UuRDhgiFqOCl2hjjt7bL6CXb77ilMTY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=ehpe0eWzCDvOBfBikUHRpIlUf7yQ83Yar39PxdYUBZVUQtrEczW7SuRAaXME12Wi8
	 Mn3AaiTj/fnWTvstwaIRGEbQlfDh52P+gSqO6fRKxBsocH+RWAXJ/BT0spnmKJREUJ
	 R442zFtEarXVy4qrMghiksaFe7UKIVdQgiBdWa8O1YEXrLSa0qLYGcDylg+vSCZOyt
	 ZYG0qNgC4710J7qstmsjKOCfAkkskteEGfOadPHS9n40MvH8V/x5qUy6dmAC5NwZvf
	 lYZe1jXTbMco0pzHmO4cu4DVvEKRql4d5R6LTInY6UPFgaIFLvnI/kiyoJVvDueKHN
	 Af1UOL0tY5Wmg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 24 Jun
 2026 13:49:50 +0200
Received: (nullmailer pid 2712676 invoked by uid 1000);
	Wed, 24 Jun 2026 11:49:50 -0000
Date: Wed, 24 Jun 2026 13:49:50 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Qianyu Luo <qianyuluo3@gmail.com>
CC: Eyal Birger <eyal.birger@gmail.com>, Ren Wei <n05ec@lzu.edu.cn>,
	<netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <yuantan098@gmail.com>, <bird@lzu.edu.cn>
Subject: Re: [PATCH 1/1] xfrm: nat_keepalive: avoid double free on send error
Message-ID: <ajvEXryefFCo5B6Q@secunet.com>
References: <cover.1781788385.git.qianyuluo3@gmail.com>
 <46eb334399ce0e25e0897b42f21020541d159300.1781788385.git.qianyuluo3@gmail.com>
 <CAHsH6Gvsf-JEQyetucAVT6mjaJDi=gMT1pDWFDagb1fhjmveGg@mail.gmail.com>
 <CAPOno=q0NxA_LOJ3QaM9Jgk1oM4ZQiW9igipGfxV7+yGvjr+0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPOno=q0NxA_LOJ3QaM9Jgk1oM4ZQiW9igipGfxV7+yGvjr+0g@mail.gmail.com>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301623-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:qianyuluo3@gmail.com,m:eyal.birger@gmail.com,m:n05ec@lzu.edu.cn,m:netdev@vger.kernel.org,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:yuantan098@gmail.com,m:bird@lzu.edu.cn,m:eyalbirger@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,lzu.edu.cn,vger.kernel.org,gondor.apana.org.au,davemloft.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,lzu.edu.cn:email];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[secunet.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 01DB16BDD5E

On Fri, Jun 19, 2026 at 05:06:40PM +0800, Qianyu Luo wrote:
> On Fri, Jun 19, 2026 at 1:21 AM Eyal Birger <eyal.birger@gmail.com> wrote:
> >
> > On Thu, Jun 18, 2026 at 9:36 AM Ren Wei <n05ec@lzu.edu.cn> wrote:
> > >
> > > From: Qianyu Luo <qianyuluo3@gmail.com>
> > >
> > >         skb_dst_set(skb, &rt->dst);
> > >
> > > @@ -100,6 +102,7 @@ static int nat_keepalive_send_ipv6(struct sk_buff *skb,
> > >         sock_net_set(sk, net);
> > >         dst = ip6_dst_lookup_flow(net, sk, &fl6, NULL);
> > >         if (IS_ERR(dst)) {
> > > +               kfree_skb(skb);
> > >                 local_unlock_nested_bh(&nat_keepalive_sk_ipv6.bh_lock);
> >
> > Any reason to do the kfree under lock?
> >
> 
> Thank you for your reply! I did this without particular reason.
> Just to keep the pre-handoff cleanup in the same error path.
> kfree_skb() does not need the bh lock there, so I can move it after the
> unlock in v2 if you need!

Then move it after the unlock to make it clear it is not needed.

