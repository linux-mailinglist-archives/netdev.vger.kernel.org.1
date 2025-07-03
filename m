Return-Path: <netdev+bounces-203703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D3DAF6CB0
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 10:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEEFC520081
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 08:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B10295523;
	Thu,  3 Jul 2025 08:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="O0FKw8iP"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1F417996
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 08:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751530854; cv=none; b=VPRfyjF4tt9Rcgcygn1P8qYViJ26e72jjIv1GmrOxS6JUQoDaEnv48p2r+K9YYDowUpOeiEg1amR+vyP/Gnf0gJJ9jkTxi+teytysh6VuLgqa16MCrWxHvpyLqpKWPGD/CiCvn4b3idReAI69Rq0YsGdJLu9FS6Eu5gXpme5quE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751530854; c=relaxed/simple;
	bh=RLt95fvyyR87skUCeRvjy0rRfux6c09jm0y3enjeulo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDGukWApImGr7CHgwPtnjaJbo6L/i7hEGKULzi0CCaI3bXFZ0gw6mIHOnC+R7jvC4cdk9IE/E8iQH/2Movm5C1yAvfcP/21wPWi7O9XXna4vVUQx7+cjFj7vNQHDnfI3YfKHcn6PPxNGqfeGlgYXeq+3aSTGf8oU9Ese2i/iIsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=O0FKw8iP; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 5684F2080B;
	Thu,  3 Jul 2025 10:20:43 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dTFIN4oJ_hPW; Thu,  3 Jul 2025 10:20:42 +0200 (CEST)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id C8B942050A;
	Thu,  3 Jul 2025 10:20:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com C8B942050A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1751530842;
	bh=bkbzv0Rc5b+1ll+KOqo6xAAOTdYcCxbInylwf6Lrz18=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=O0FKw8iPkp4jGqPt56dhgeVjjAc8gRuefJW3bTCEl8ck2DqNX6lv4EN1x5vfprE1E
	 zCSrL7wxSFT6bw2PHkGzK+0asbNrR72y15VU2/5+3UpsDZeeY9JR4pcMSfzRf1ifOo
	 rwNnL4WhyWq8VVy3pIVlHyztx19KPx/jWAdVG2Pt/Vx5zkOV3UxN9fPeISPe/pI0ET
	 QaK6y6dIQwZJYoLTGH/u6fAMMCatnUyLNtUabtep1JegiyEWxE8nBYQ85twurmd2NZ
	 25exdWheu3zuPmjlMnix0WDMzKzXew3exv+cRUb+51HK7BZ0caWuuPVAjXiXEm5TCv
	 VDUUF6LCxJ0sw==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 3 Jul 2025 10:20:42 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Jul
 2025 10:20:42 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id E8E4D3183036; Thu,  3 Jul 2025 10:20:41 +0200 (CEST)
Date: Thu, 3 Jul 2025 10:20:41 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Tobias Brunner <tobias@strongswan.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, <netdev@vger.kernel.org>, <devel@linux-ipsec.org>
Subject: Re: [PATCH ipsec] xfrm: Set transport header to fix UDP GRO handling
Message-ID: <aGY9WTUYVEYH0Sc6@gauss3.secunet.de>
References: <d14acb9a-bc2b-4459-a8e7-a9017d9d75fc@strongswan.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d14acb9a-bc2b-4459-a8e7-a9017d9d75fc@strongswan.org>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Tue, Jun 24, 2025 at 02:47:20PM +0200, Tobias Brunner wrote:
> The referenced commit replaced a call to __xfrm4|6_udp_encap_rcv() with
> a custom check for non-ESP markers.  But what the called function also
> did was setting the transport header to the ESP header.  The function
> that follows, esp4|6_gro_receive(), relies on that being set when it calls
> xfrm_parse_spi().  We have to set the full offset as the skb's head was
> not moved yet so adding just the UDP header length won't work.
> 
> Fixes: e3fd05777685 ("xfrm: Fix UDP GRO handling for some corner cases")
> Signed-off-by: Tobias Brunner <tobias@strongswan.org>

Applied, thanks Tobias!

