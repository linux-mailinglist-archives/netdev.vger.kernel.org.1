Return-Path: <netdev+bounces-85268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A9C899F6C
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 16:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E22091C22994
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 14:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE7016F0DB;
	Fri,  5 Apr 2024 14:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="akqkauRm"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AD116EC0F
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 14:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712326783; cv=none; b=XYw58aMVd2hSWB8FDN9CvSfQCE877f/+VmE6efNunkh14UsJZKSWiKZBTOC/pnGbQCmU8c9LfT2wVoauQ1sCDq6XmFVSTdV2oAeGWmJWqi6vFEeK9L4bI3FcttCGnnBquMRlt/v7EcCdgliBXpVSa7iUffPReKhc362j0J7a23s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712326783; c=relaxed/simple;
	bh=/xIk3cwN6PGsSnUpZA3DbOdv0SHBsHzxMMqbyAHVlE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDcZGwP5e+HqEbe4zYIHfVHuP5cr7ymue16YRAbx/QGDxRbktQGelZRvNzSLN8HjwvKm7Zdqmdz5YrfNWbnsauN4YJzQo+mTjhsqoO1YH8TcvRMAZC/tgEWIxGdnTtegAVwrPOM3ns+z9cJdXo8uDagHRiixEXJvSPJyk6L2S8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org; spf=none smtp.mailfrom=phenome.org; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=akqkauRm; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=phenome.org
X-KPN-MessageId: 825c0a37-f357-11ee-89f5-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 825c0a37-f357-11ee-89f5-005056abbe64;
	Fri, 05 Apr 2024 16:19:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=LLPt6Bj7SSFVULXp6KkCHNKGt9KWEnW6tUXXNFdsEpQ=;
	b=akqkauRmckSTvfWA3tgCsdzQwKMeKozuA2cxjkS/iSLXj34STogHH/X4fAILabzwa6OmIp0moUgd/
	 DuwJmY8YyqCjyJ3YdgKwO7JepPBcJPSi7uTsKX13jPV/51D9ydDAtSIjlZEwXqwhbivFbSFxhU8SPU
	 w5MZ0PVmzTxY482E=
X-KPN-MID: 33|Y+YZ6F2pRQuulVBF4sHfX71q+8e9l/wWAFnw70oBcX84qijP72y9uFHQVu4STIE
 kPLgaLYurZljXMx8RLir66Iz6nu8PvdtN08HNLrxlREs=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|Uhw8df5SH4laxz+RtUtLkd/9FaapITRI/dUdvki/9khlvD5ygQ2EFe7a91RjGij
 CxAYf8e4HLqcaOTugIvPqcA==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 873fce8e-f357-11ee-9f09-005056ab7584;
	Fri, 05 Apr 2024 16:19:36 +0200 (CEST)
Date: Fri, 5 Apr 2024 16:19:34 +0200
From: Antony Antony <antony@phenome.org>
To: Feng Wang <wangfe@google.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, herbert@gondor.apana.org.au,
	davem@davemloft.net
Subject: Re: [PATCH] [PATCH ipsec] xfrm: Store ipsec interface index
Message-ID: <ZhAIdoNsmwXSK59t@Antony2201.local>
References: <CADsK2K_65Wytnr5y+5Biw=ebtb-+hO=K7hxhSNJd6X+q9nAieg@mail.gmail.com>
 <ZfpnCIv+8eYd7CpO@gauss3.secunet.de>
 <CADsK2K-WFG2+2NQ08xBq89ty-G-xcoV517Eq5D7kNePcT4z0MQ@mail.gmail.com>
 <20240321093248.GC14887@unreal>
 <CADsK2K8=B=Yv4i6rzNdbuc-C6yc-pw6RSuRvKbsL2qYjsO9seg@mail.gmail.com>
 <20240401142707.GD73174@unreal>
 <CADsK2K-VLdiuxeP82bmuGvmU6z848mLpk+JBYdhXppOq0B76VA@mail.gmail.com>
 <20240402075104.GD11187@unreal>
 <CADsK2K8WvGmUdno5X=_ebNF1mzP9=kd1=ve31Tb5hSk+q4VTkg@mail.gmail.com>
 <20240403064507.GR11187@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403064507.GR11187@unreal>
X-Mutt-Fcc: ~/sent

Hi Feng,

On Wed, Apr 03, 2024 at 09:45:07AM +0300, Leon Romanovsky wrote:
> On Tue, Apr 02, 2024 at 02:10:16PM -0700, Feng Wang wrote:
> > The xfrm interface ID is the index of the ipsec device, for example,
> > ipsec11, ipsec12.  One ipsec application(VPN) might create an ipsec11
> > interface and send the data through this interface.

Where to find xfrm interface if_id depends on the direction the packet is 
traversing, direction "out": (clear text in ESP out), or "in": (ESP in clear 
text out) use if_id diffrently.

Which case are you looking at? It sounds like out.

> > Another application(Wifi calling) might create an ipsec12 interface and
> > send its data through ipsec12.  Both packets are routed through the kernel
> > to the one device driver(wifi).  When the device driver receives the
> > packet, it needs to find the correct application parameters to encrypt the

this looks like an out case. After a successful dst lookup, xfrm_lookup(),

look at skb_dst(skb)->xfrm->if_id ?

> > packet.  So if the skb_iif is marked by the kernel with ipsec11 or
> > ipsec12,  device driver can use this information to find the corresponding
> > parameter.  I hope I explain my user case clearly.  If there is any
> > misunderstanding, please let me know.  I try my best to make it clear.

skb_dst(skb)->xfrm->if_id should match  what is in the xfrm policy I think,
p->if_id.

Note I assumed the packet is locally generated. If it is a forwarded packet 
there could be another policy lookup before.
 
> Like I said before, please send the code which uses this feature. Right
> now, packet offload doesn't need this feature.

+1
-antony

