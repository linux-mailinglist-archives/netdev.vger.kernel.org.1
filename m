Return-Path: <netdev+bounces-80726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD86880A5E
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 05:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E89CB1C2103A
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 04:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCE8846D;
	Wed, 20 Mar 2024 04:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="okk1hCbs"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C2879C2
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 04:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710909204; cv=none; b=DFbojoMCxjFHnRMS/+mRps1xKReNkvD8CmPkXULuir0ADOodMnm5xdgpWgkGaN76VnWscERAhww9w6DeEodNHLu+s47Vvu4lYnXvLCWqYmnfaQQnq1vVpFhsZznDO8uQofEEyh8N5pTlItYrUK/ijO4qlrdPaBiRvkvO2SVn9JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710909204; c=relaxed/simple;
	bh=+R6gMPqirv2uzFN88bnlpZK2RK8kuDMgDFLXSBRKhiQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0MK93AWkyP73fcP55n9utxeAoQ445Yxd4GLHPLiDtmY4oGP+Cz4QmBJMAZ/oTSuF699q5ajY/2GX2HOFuyO6HhDPjDNXV8FpksD3WALWFy5xTcHc5vdPZT0wr7JQYqnEfbV6cG5EpMp2xC48kd8sPw05I2PkzmcVMzNc8PlB9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=okk1hCbs; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 81B17207D1;
	Wed, 20 Mar 2024 05:33:18 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lX9INqCMPbuW; Wed, 20 Mar 2024 05:33:13 +0100 (CET)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id AA064207C6;
	Wed, 20 Mar 2024 05:33:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com AA064207C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1710909193;
	bh=dJy0HDIkV0FP6kndGZRvV/BwhBdkBnztl/U9ROavgc0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=okk1hCbs88M9cNrHej+mLN0i8rzzlMJS0Ye31ftklPnXDLV3Rp/M6AAZR2fjAh+zT
	 Riipoa1icCILxELLP2etN1qEyoC9wNLnTEqWqVYV3xdUCIJQDc0ao3FlpNwBVP2tN5
	 0+E6ShngC4w3Wxg83BGKL5zSYnZXp0/Qmj9US4Z7jqRrqyQNTs1P+iHDc0vMWIHG9K
	 OO6wctrH50hfHOIm1Q1IVtKYOFQNmpMazlnZAcnZXPW2qjGme1Z2tIwE1mWwDhgT9B
	 y2K+e8kH1xcRWBkSKlzy+UJidqBb7dKvdQD6zlXZbhtPEsV1535jLbNytldusUwBBW
	 T1Sr05VvFwi9w==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout1.secunet.com (Postfix) with ESMTP id 8A64480004A;
	Wed, 20 Mar 2024 05:33:13 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 05:33:13 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 05:33:12 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 6ED6131824F9; Wed, 20 Mar 2024 05:33:12 +0100 (CET)
Date: Wed, 20 Mar 2024 05:33:12 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Feng Wang <wangfe@google.com>
CC: Leon Romanovsky <leon@kernel.org>, <netdev@vger.kernel.org>,
	<herbert@gondor.apana.org.au>, <davem@davemloft.net>
Subject: Re: [PATCH] [PATCH ipsec] xfrm: Store ipsec interface index
Message-ID: <ZfpnCIv+8eYd7CpO@gauss3.secunet.de>
References: <20240318231328.2086239-1-wangfe@google.com>
 <20240319084235.GA12080@unreal>
 <CADsK2K_65Wytnr5y+5Biw=ebtb-+hO=K7hxhSNJd6X+q9nAieg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADsK2K_65Wytnr5y+5Biw=ebtb-+hO=K7hxhSNJd6X+q9nAieg@mail.gmail.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Tue, Mar 19, 2024 at 10:15:13AM -0700, Feng Wang wrote:
> Hi Leon,
> 
> There is no "packet offload driver" in the current kernel tree.  The packet
> offload driver mostly is vendor specific, it implements hardware packet
> offload.

There are 'packet offload drivers' in the kernel, that's why we
support this kind of offload. We don't add code for proprietary
drivers.

> On Tue, Mar 19, 2024 at 1:42 AM Leon Romanovsky <leon@kernel.org> wrote:
> 
> > On Mon, Mar 18, 2024 at 04:13:28PM -0700, Feng Wang wrote:
> > > From: wangfe <wangfe@google.com>
> > >
> > > When there are multiple ipsec sessions, packet offload driver
> > > can use the index to distinguish the packets from the different
> > > sessions even though xfrm_selector are same.
> >
> > Do we have such "packet offload driver" in the kernel tree?
> >
> > Thanks
> >
> > > Thus each packet is handled corresponding to its session parameter.
> > >
> > > Signed-off-by: wangfe <wangfe@google.com>
> > > ---
> > >  net/xfrm/xfrm_interface_core.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/net/xfrm/xfrm_interface_core.c
> > b/net/xfrm/xfrm_interface_core.c
> > > index 21d50d75c260..996571af53e5 100644
> > > --- a/net/xfrm/xfrm_interface_core.c
> > > +++ b/net/xfrm/xfrm_interface_core.c
> > > @@ -506,7 +506,9 @@ xfrmi_xmit2(struct sk_buff *skb, struct net_device
> > *dev, struct flowi *fl)
> > >       xfrmi_scrub_packet(skb, !net_eq(xi->net, dev_net(dev)));
> > >       skb_dst_set(skb, dst);
> > >       skb->dev = tdev;
> > > -
> > > +#ifdef CONFIG_XFRM_OFFLOAD
> > > +     skb->skb_iif = if_id;
> > > +#endif

This looks wrong. The network interface ID is not the same as the xfrm
interface ID.

