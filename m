Return-Path: <netdev+bounces-152848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 049EF9F601C
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 09:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 021C37A3DA1
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 08:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E081714C8;
	Wed, 18 Dec 2024 08:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="A/AYsREU"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A498F155303
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 08:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734510395; cv=none; b=KHvOayU22FCWiLnPi5VC3h+A+0qd5M+IpU8Zq5ZT4S2wujaifM9Sik8kIkRPnfGTHqVHI39j2QG3LLBEe996CAubZjgOUIg29OlHZXLPGgR6NNFpQ389pKtDhjscveyUCPK/V71a7OrNXS/9MJPQVT8Lpf6sack9Gl7zTJWBc/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734510395; c=relaxed/simple;
	bh=FBvTBV6IMGGvUCetMf0gEeZB7z/iVhwXxjHT3rvG+Pw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=caW4R8eKx/1of58OPe4FMQZUnwv01ldT767rsPUdeTDDHZqZ/wpW7yOdzJxLKgnXE0v81uSs5SQU3qvaAv+sd4puRIT48qRxOEIdDdZV9W0Vl7QIA0mdU61j3hH+B/XGifdI71ZceyA0M8n+ZK1jAfvC1Wu36QT0e5S7JTnCQtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=A/AYsREU; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 7B574206F0;
	Wed, 18 Dec 2024 09:26:25 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AiIaB2yKXecB; Wed, 18 Dec 2024 09:26:25 +0100 (CET)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id F0008206D2;
	Wed, 18 Dec 2024 09:26:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com F0008206D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1734510385;
	bh=ZoNb8XSr7K8f1g/V1TfemyyaxRngaRdLs3bk4axa8v0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=A/AYsREUJ7T5+pII9tE4M1g1pak+h07XOtRYGEa8iyibFvtuPJqgnlzGt3B2SX/s7
	 ODpjTIGHLYtF2+1bFVnhz3A1lelzCQhmjVE1PZsk+H31D20xv2EJPJCTE4zq2sRu42
	 O3w/P5dyUsLlA7m7Gtif5wwutRUCmvAH28v2rxCNUj8RV9R6Xuu6KM1WjF9W5AaEcy
	 UqchR4PDVSffxmyOJgT6OdfU/waLwQ5RFjTAYfql+1meE5/tjDgEIijQjY6x214MN8
	 pvWAL+GS6tuBWZ2ut/UTnenLfYVVWpTLEtniuq97eRffJ9DbQ99m8dKBNA/YKRlu0r
	 T8ifNAx27vzhg==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 18 Dec 2024 09:26:24 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Dec
 2024 09:26:24 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 3A0C3318103D; Wed, 18 Dec 2024 09:26:24 +0100 (CET)
Date: Wed, 18 Dec 2024 09:26:24 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Eric Dumazet <edumazet@google.com>
CC: Shahar Shitrit <shshitrit@nvidia.com>, "brianvv@google.com"
	<brianvv@google.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"eric.dumazet@gmail.com" <eric.dumazet@gmail.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "kuniyu@amazon.com" <kuniyu@amazon.com>,
	"martin.lau@kernel.org" <martin.lau@kernel.org>, "ncardwell@google.com"
	<ncardwell@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>, Ziyad Atiyyeh <ziyadat@nvidia.com>, "Dror
 Tennenbaum" <drort@nvidia.com>
Subject: Re: [PATCH v3 net-next 4/5] ipv6: tcp: give socket pointer to
 control skbs
Message-ID: <Z2KHMLJ4oTUwgBSo@gauss3.secunet.de>
References: <CY5PR12MB63224DE8AEEC1A2410E65466DA3B2@CY5PR12MB6322.namprd12.prod.outlook.com>
 <CANn89iL8ihnVyi+g1aKNu3=BJCQoRv4_s29OvVSXBBQdOM4foQ@mail.gmail.com>
 <CANn89iKAZsG=RepuJmStFTH2QK+N5s9Cu=OnD2GmQAb1JKCfeQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iKAZsG=RepuJmStFTH2QK+N5s9Cu=OnD2GmQAb1JKCfeQ@mail.gmail.com>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Mon, Dec 16, 2024 at 04:21:32PM +0100, Eric Dumazet wrote:
> On Mon, Dec 16, 2024 at 2:29 PM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Mon, Dec 16, 2024 at 2:18 PM Shahar Shitrit <shshitrit@nvidia.com> wrote:
> > >
> > > Hello,
> > >
> > >
> > >
> > > We observe memory leaks reported by kmemleak when using IPSec in transport mode with crypto offload.
> > >
> > > The leaks reproduce for TX offload, RX offload and both.
> > >
> > > The leaks as shown in stack trace can be seen below.
> > >
> > >
> > >
> > > The issue has been bisected to this commit 507a96737d99686ca1714c7ba1f60ac323178189.
> > >
> > >
> >
> > Nothing comes to mind. This might be an old bug in loopback paths.
> 
> Or some XFRM assumption.
> 
> Note that ip6_xmit() first parameter can be different than skb->sk
> 
> Apparently, xfrm does not check this possibility.

Can you provide a bit more context? I don't see the problem.

Thanks!

