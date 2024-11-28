Return-Path: <netdev+bounces-147707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 311189DB4BA
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 10:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA083164733
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 09:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326A915574E;
	Thu, 28 Nov 2024 09:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="wr9TLDYX"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC27E17BA5;
	Thu, 28 Nov 2024 09:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732785936; cv=none; b=dMpnzbqL+ls00vO0lnVk91aylYj7d/BT4ujJSEIBHQv+njpmoFMaEkN7MfyUF5M8CNHW2XUmYlFoj84Lggl71R6JwkALOueLm3BKSsu20ln2l1OizI06ApEO0RJmH56ICMT6zuMqxV+tLZppC0jVw+F9nNwPAKX/Yr70JAtDRMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732785936; c=relaxed/simple;
	bh=xDZbs25Ro1Le6d5NO3nl0DYrtlOsay0BdyZ4UZbXCPE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ghzqw6c6YKBi0+Fctz51Zvz2TDbOD7qlPRgdEONRKYt9FLveAMmnTD/Lc26pqu5wgOAuX/D9URqg2WOojG7/5343KZ175njitEUPSzo/NEfMndJzB1S2L6Nsw5h/vktBg1flzE8sCcxFZ1Jkn3tib/v7K2K6kupZR1ube8enlo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=wr9TLDYX; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id B9F872088A;
	Thu, 28 Nov 2024 10:25:24 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dllkb9X-ccYE; Thu, 28 Nov 2024 10:25:24 +0100 (CET)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 2C0932085A;
	Thu, 28 Nov 2024 10:25:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 2C0932085A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1732785924;
	bh=t/7n88zTDlq2bmfBwLns/chDoKA+TtamzqKlnGAD0gI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=wr9TLDYXU7kciVYcG7oyHnTRU+dqKUnApyv3puKjRvmi1+8FTfYBN/znrYQTiBaGY
	 o1BCc0o+/xrod24w5pQQJvpZDtE5ejuJUCipnXQiDBvcwJoip1NCbzB77AzBxjshIx
	 QdfADBrOa06rplJ/943xddlJCDa4GAD7C7R0kNTuOOfv4j8WMfHk3JQg5/wj0LfKoK
	 YDiO40+TjTL1+7oDALE3IEIFp/qEbmulTWC71RcOp25U7P1rwom+fsrFpY4bqjJ8FA
	 YI4GC4s6lsMqjIeUfu79xOi0hdcAiNNNAc72jb9gKmALbecRcR9RwxM88ygymhVO41
	 xW22YUUuH+PIQ==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 28 Nov 2024 10:25:23 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Nov
 2024 10:25:23 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 9038B3181FC0; Thu, 28 Nov 2024 10:25:23 +0100 (CET)
Date: Thu, 28 Nov 2024 10:25:23 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Ilia Lin <ilia.lin@kernel.org>, <herbert@gondor.apana.org.au>, "David
 Miller" <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xfrm: Add pre-encap fragmentation for packet offload
Message-ID: <Z0g3A87ArEdrOCgj@gauss3.secunet.de>
References: <20241124093531.3783434-1-ilia.lin@kernel.org>
 <20241124120424.GE160612@unreal>
 <CA+5LGR2n-jCyGbLy9X5wQoUT5OXPkAc3nOr9bURO6=9ObEZVnA@mail.gmail.com>
 <20241125194340.GI160612@unreal>
 <CA+5LGR0e677wm5zEx9yYZDtsCUL6etMoRB2yF9o5msqdVOWU8w@mail.gmail.com>
 <20241126083513.GL160612@unreal>
 <Z0XGMxSou3AZrB2f@gauss3.secunet.de>
 <20241126132145.GA1245331@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241126132145.GA1245331@unreal>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Tue, Nov 26, 2024 at 03:21:45PM +0200, Leon Romanovsky wrote:
> On Tue, Nov 26, 2024 at 01:59:31PM +0100, Steffen Klassert wrote:
> > On Tue, Nov 26, 2024 at 10:35:13AM +0200, Leon Romanovsky wrote:
> > > 
> > > Steffen, do we need special case for packet offload here? My preference is
> > > to make sure that we will have as less possible special cases for packet
> > > offload.
> > 
> > Looks like the problem on packet offload is that packets
> > bigger than MTU size are dropped before the PMTU signaling
> > is handled.
> 
> But PMTU should be less or equal to MTU, even before first packet was
> sent. Otherwise already first packet will be fragmented.

Atually I ment PMTU. On packet offload, we just drop packets bigger
than PMTU. We need to make sure that xfrm{4,6}_tunnel_check_size
is called. This will either fragment or do PMTU signaling.

