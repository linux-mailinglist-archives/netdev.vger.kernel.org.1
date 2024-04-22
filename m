Return-Path: <netdev+bounces-90209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6914B8AD194
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 18:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05A701F2103F
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 16:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CBE153581;
	Mon, 22 Apr 2024 16:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="gW/V60KB"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EE615357B
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 16:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713802279; cv=none; b=E9n4Og09W+nOsiCIqsTRArO78s0+/kZ/hXAjAOhUNKldc2R4P3cNIY7+qRnmzICvMobh+Bt3WA2zEeQVE0w8gfalZNraxQc/Fg7wBAroRIUs+wuTdyMcMBNI8KsHotD+E4H5EL6xmG4hUwFhCNokgaInkNpz8s4k3xzsgwrW9t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713802279; c=relaxed/simple;
	bh=iuEt06c15ZpSI5gooEbksAT53qbH2lNGBGZmCx+ozVA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2xsjHAlik0UJB4a1VfXFNf0/CLgWcSHZhBFxCYXbozF3F1hbidzy8Fc3U6EpAhfVTe6aC/fZQ07oTwMjjj1+D8KsbdBuNEDhw2T13Vp/G4cOYuf9Duk7dKKtNZ98VxPdircaz5q92160vpR3HEei1ouQ4Uc2aGKVh+m0uEHASE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=gW/V60KB; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 919B3207E4;
	Mon, 22 Apr 2024 18:11:13 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1YAwzjmEClaO; Mon, 22 Apr 2024 18:11:12 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 6B59B205E3;
	Mon, 22 Apr 2024 18:11:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 6B59B205E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1713802272;
	bh=l+Jw/tsRdCVH1z8TPr6fjaovnODPh6TBoMbhMA7b/Ok=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=gW/V60KBbdvgvkYtK1SNoKCFcSdN44S9uV7goYZwPfHu+Vmt54lvBRWd0y2VjcjBz
	 2yEmakzefPWCIxETvrRBu+W4eaQXoXkhJFL2KbnqVE+aNM+kqmHfkTjQVrraz4s0UR
	 tpDKZ5hCcO11vDcQYJ/CmNi7kqCvckNSXl2bQDh9L5RBPoDyt7fcyuGlU3BKZFZUFV
	 mlWsKsz3vEZAAn1QYmpjA3377idACXGNdqb5HtojpLICwJt0c5X+RLMnAQLAN3lU53
	 LMjWWFvQftenj1goB5lpxKlzn8jk3OPK1HcPokTUf1d54NIopPWgChedy7yUN91Ag0
	 QbThWFvHXU4rw==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 5E65F80004A;
	Mon, 22 Apr 2024 18:11:12 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 18:11:12 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 22 Apr
 2024 18:11:11 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 957E13182BCE; Mon, 22 Apr 2024 18:11:11 +0200 (CEST)
Date: Mon, 22 Apr 2024 18:11:11 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Sabrina Dubroca <sd@queasysnail.net>
CC: Paul Davey <paul.davey@alliedtelesis.co.nz>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH net] xfrm: Preserve vlan tags for transport mode software
 GRO
Message-ID: <ZiaMH0e0NL+/P0Fg@gauss3.secunet.de>
References: <20240422025711.145577-1-paul.davey@alliedtelesis.co.nz>
 <ZiY0Of0QuDOCPXHg@gauss3.secunet.de>
 <ZiZc6ApkxivqaILg@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZiZc6ApkxivqaILg@hog>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)

On Mon, Apr 22, 2024 at 02:49:44PM +0200, Sabrina Dubroca wrote:
> 
> Actually it looks like we still have 4B in xfrm_mode_skb_cb:
> 
> struct xfrm_mode_skb_cb {
> 	struct xfrm_tunnel_skb_cb  header;               /*     0    32 */
> 	__be16                     id;                   /*    32     2 */
> 	__be16                     frag_off;             /*    34     2 */
> 	u8                         ihl;                  /*    36     1 */
> 	u8                         tos;                  /*    37     1 */
> 	u8                         ttl;                  /*    38     1 */
> 	u8                         protocol;             /*    39     1 */
> 	u8                         optlen;               /*    40     1 */
> 	u8                         flow_lbl[3];          /*    41     3 */
> 
> 	/* size: 48, cachelines: 1, members: 9 */
> 	/* padding: 4 */
> 	/* last cacheline: 48 bytes */
> };
> 
> flow_lbl ends at 44, so adding orig_mac_len should be fine. I don't
> see any config options that would increase the size of
> xfrm_mode_skb_cb compared to what I already have.

Right, I overlooked the 4 byte padding in the pahole output.

